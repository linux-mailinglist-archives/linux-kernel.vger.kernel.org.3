Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B3FC4E7D3A
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Mar 2022 01:22:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233367AbiCYVWT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 17:22:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233356AbiCYVWS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 17:22:18 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E9C44F9DB
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 14:20:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id E7C67CE2B3E
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 21:20:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8162FC004DD;
        Fri, 25 Mar 2022 21:20:38 +0000 (UTC)
Date:   Fri, 25 Mar 2022 17:20:36 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Amit Shah <amit@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        virtualization@lists.linux-foundation.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH] virtio: Workaround fix for hard hang on guest using fifos
Message-ID: <20220325172036.3f8f619e@gandalf.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="MP_/s7pUkZvV7bLyuAjMDL37/bn"
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--MP_/s7pUkZvV7bLyuAjMDL37/bn
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

This is more of a workaround patch and probably not the proper fix. But
I'm doing some work that is using fifos for guests and this is causing a
hang that is quite annoying.

I currently have this patch applied to continue my work.

I was working on analyzing data transfers between host and guests via
virtio sockets (FIFOs on host, dev on guest), vsockets and TCP packets.

I wrote a program to test each by passing a 1GB file and timing it. I'm
using the splice system call to help move things along. In doing so, I
found that my pipe between splice calls originally used "page_size" for
data transfer, and that is not as efficient as finding out what the pipe
size is. So I changed the code to use pipe_size and while debugging it, the
guest locked up hard.

I'm attaching the "agent-fifo" that runs on the guest, and the
"client-fifo" that runs on the host (the names may be backwards, but
makes sense when you add how I test vsockets and network packets).

Here's what I did:

<host> # ./client-fifo /var/lib/virt/Guest/trace-pipe-cpu0.out /test/bigfile

Where the trace-pipe-cpu0.out is the receiving side from the guest's virtio
pipe. The /test/bigfile is created when data starts coming in from the
guest pipe.

<guest> # dd if=/dev/urandom of=bigfile bs=1024 count=1048576
<guest> # ./agent-fifo /dev/virtio-ports/trace-pipe-cpu0 bigfile

With the updates to change the size being passed in the splice from
page_size to pipe_size, this never finished (it would copy around a meg or
so). And stopped. When I killed the agent-fifo task on the guest, the guest
hung hard.

Debugging this, I found that the guest is stuck in the loop in
drivers/char/virt_console.c: __send_control_msg():

	if (virtqueue_add_outbuf(vq, sg, 1, &portdev->cpkt, GFP_ATOMIC) == 0) {
		virtqueue_kick(vq);
		while (!virtqueue_get_buf(vq, &len)
			&& !virtqueue_is_broken(vq))
			cpu_relax();
	}

It never exits that loop. My workaround (this patch) is to put in a
timeout, and exit out if it spins there for more than 5 seconds. This
makes the problem go away.

Below is my changes, but this is a band-aid, it is not the cure.

Workaround-fix-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
index e3c430539a17..65f259f3f8cb 100644
--- a/drivers/char/virtio_console.c
+++ b/drivers/char/virtio_console.c
@@ -551,6 +551,7 @@ static ssize_t __send_control_msg(struct ports_device *portdev, u32 port_id,
 	struct scatterlist sg[1];
 	struct virtqueue *vq;
 	unsigned int len;
+	u64 end;
 
 	if (!use_multiport(portdev))
 		return 0;
@@ -567,9 +568,15 @@ static ssize_t __send_control_msg(struct ports_device *portdev, u32 port_id,
 
 	if (virtqueue_add_outbuf(vq, sg, 1, &portdev->cpkt, GFP_ATOMIC) == 0) {
 		virtqueue_kick(vq);
+		end = jiffies + 5 * HZ;
 		while (!virtqueue_get_buf(vq, &len)
-			&& !virtqueue_is_broken(vq))
+			&& !virtqueue_is_broken(vq)) {
+			if (unlikely(end < jiffies)) {
+				dev_warn(&portdev->vdev->dev, "send_control_msg timed out!\n");
+				break;
+			}
 			cpu_relax();
+		}
 	}
 
 	spin_unlock(&portdev->c_ovq_lock);

--MP_/s7pUkZvV7bLyuAjMDL37/bn
Content-Type: text/x-c++src
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename=agent-fifo.c

#include <stdio.h>
#include <stdlib.h>
#include <stdarg.h>
#include <string.h>
#include <unistd.h>
#include <errno.h>
#include <sys/ioctl.h>
#include <sys/types.h>
#include <sys/time.h>
#include <sys/stat.h>
#define _GNU_SOURCE
#include <fcntl.h>

#ifndef F_GETPIPE_SZ
# define F_GETPIPE_SZ	1032 /* The Linux number for the option */
#endif

const char *this_name = "agent-fifo";

static void usage(void)
{
	printf("usage: %s dev bigfile\n"
	       "\n",this_name);
	exit(-1);
}

static void __vdie(const char *fmt, va_list ap, int err)
{
	int ret = errno;
	const char *p = this_name;

	if (err && errno)
		perror(p);
	else
		ret = -1;

	fprintf(stderr, "  ");
	vfprintf(stderr, fmt, ap);

	fprintf(stderr, "\n");
	exit(ret);
}

void die(const char *fmt, ...)
{
	va_list ap;

	va_start(ap, fmt);
	__vdie(fmt, ap, 0);
	va_end(ap);
}

void pdie(const char *fmt, ...)
{
	va_list ap;

	va_start(ap, fmt);
	__vdie(fmt, ap, 1);
	va_end(ap);
}

static unsigned long long time()
{
	struct timeval tv;

	gettimeofday(&tv, NULL);
	return tv.tv_sec * 1000000 + tv.tv_usec;
}

static void print_time(unsigned long long time)
{
	unsigned long long seconds;
	unsigned long long usecs;

	seconds = time / 1000000;
	usecs = time - (seconds * 1000000);

	printf("time: %llu.%06llu\n", seconds, usecs);
}

int main(int argc, char *argv[])
{
	unsigned long long start;
	unsigned long long end;
	struct stat st;
	off_t size;
	char *file;
	char *port;
	int page_size;
	int pipe_size;
	int brass[2];
	int ret;
	int cfd;
	int fd;

	if (argc < 3)
		usage();

	port = argv[1];
	file = argv[2];

	fd = open(file, O_RDONLY);
	if (fd < 0)
		pdie("Opening %s", file);

	if (pipe(brass) < 0)
		pdie("pipe");

	if (fstat(fd, &st) < 0)
		pdie("stat %s", file);

	size = st.st_size;
	if (size < 1)
		die("%s must have size found by stat");

	page_size = getpagesize();
	if (page_size <= 0)
		pdie("getting page size");

	ret = fcntl(brass[0], F_GETPIPE_SZ, &pipe_size);
	if (ret < 0 || !pipe_size)
		pipe_size = page_size;
	
	start = time();
	cfd = open(port, O_WRONLY);
	if (cfd < 0)
		pdie("Writing to %s", argv[2]);
	
	start = time();

	do {
		if (size < page_size) {
			char buf[page_size];
			ret = read(fd, buf, size);
			if (ret < 0)
				pdie("reading %s", file);
			size -= ret;
			write(cfd, buf, ret);
			continue;
		}

		if (size < pipe_size)
			pipe_size = size & ~(page_size - 1);

		ret = splice(fd, NULL, brass[1], NULL, pipe_size, 1 /* SPLICE_F_MOVE */);
		if (ret < 0)
			pdie("splice read of %s", file);

		size -= ret;

		ret = splice(brass[0], NULL, cfd, NULL, pipe_size, 3 /* and NON_BLOCK */);
		if (ret < 0)
			pdie("splice write");

	} while (size);

	end = time();

	print_time(end - start);

	exit(0);
}

--MP_/s7pUkZvV7bLyuAjMDL37/bn
Content-Type: text/x-c++src
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename=client-fifo.c

#include <stdio.h>
#include <stdlib.h>
#include <stdarg.h>
#include <string.h>
#include <errno.h>
#include <unistd.h>
#include <fcntl.h>
#include <sys/types.h>
#include <sys/time.h>
#ifndef F_GETPIPE_SZ
# define F_GETPIPE_SZ	1032 /* The Linux number for the option */
#endif

const char *this_name = "client-fifo";

static void usage(void)
{
	const char *p = this_name;

	printf("usage: %s fifo-file output-file\n"
	       "\n",p);
	exit(-1);
}

static void __vdie(const char *fmt, va_list ap, int err)
{
	int ret = errno;
	const char *p = this_name;

	if (err && errno)
		perror(p);
	else
		ret = -1;

	fprintf(stderr, "  ");
	vfprintf(stderr, fmt, ap);

	fprintf(stderr, "\n");
	exit(ret);
}

void die(const char *fmt, ...)
{
	va_list ap;

	va_start(ap, fmt);
	__vdie(fmt, ap, 0);
	va_end(ap);
}

void pdie(const char *fmt, ...)
{
	va_list ap;

	va_start(ap, fmt);
	__vdie(fmt, ap, 1);
	va_end(ap);
}

static unsigned long long time()
{
	struct timeval tv;

	gettimeofday(&tv, NULL);
	return tv.tv_sec * 1000000 + tv.tv_usec;
}

static void print_time(unsigned long long time)
{
	unsigned long long seconds;
	unsigned long long usecs;

	seconds = time / 1000000;
	usecs = time - (seconds * 1000000);

	printf("time: %llu.%06llu\n", seconds, usecs);
}

int main(int argc, char *argv[])
{
	unsigned long long start;
	unsigned long long end;
	char *file;
	char *port;
	int page_size;
	int pipe_size;
	int brass[2];
	int ret;
	int cfd;
	int fd;

	if (argc < 3)
		usage();

	port = argv[1];
	file = argv[2];

	fd = open(file, O_WRONLY | O_CREAT);
	if (fd < 0)
		pdie("Opening %s", file);

	if (pipe(brass) < 0)
		pdie("pipe");

	page_size = getpagesize();
	if (page_size <= 0)
		pdie("getting page size");

	ret = fcntl(brass[0], F_GETPIPE_SZ, &pipe_size);
	if (ret < 0 || !pipe_size)
		pipe_size = page_size;

	start = time();
	cfd = open(port, O_RDONLY);
	if (cfd < 0)
		pdie("Reading to %s", argv[2]);
	
	start = time();

	do {
		ret = splice(cfd, NULL, brass[1], NULL, pipe_size, 1 /* SPLICE_F_MOVE */);
		if (ret < 0 && errno != EAGAIN)
			pdie("splice read of %s", file);

		ret = splice(brass[0], NULL, fd, NULL, pipe_size, 3 /* and NON_BLOCK */);
		if (ret < 0 && errno != EAGAIN)
			pdie("splice write");

		if (ret < 0) {
			char buf[pipe_size];
			ret = read(cfd, buf, pipe_size);
			ret = write(fd, buf, ret);
		}

	} while (ret > 0);

	end = time();

	print_time(end - start);

	exit(0);
}

--MP_/s7pUkZvV7bLyuAjMDL37/bn--
