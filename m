Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 741D3482899
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jan 2022 22:59:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232768AbiAAV6a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Jan 2022 16:58:30 -0500
Received: from lithops.sigma-star.at ([195.201.40.130]:48700 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232733AbiAAV6Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Jan 2022 16:58:25 -0500
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id D0019614E2ED;
        Sat,  1 Jan 2022 22:58:23 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 4wakbcodk5Q1; Sat,  1 Jan 2022 22:58:23 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 4B767614E2F1;
        Sat,  1 Jan 2022 22:58:23 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id D0uH1gMZpXN6; Sat,  1 Jan 2022 22:58:23 +0100 (CET)
Received: from blindfold.corp.sigma-star.at (213-47-184-186.cable.dynamic.surfer.at [213.47.184.186])
        by lithops.sigma-star.at (Postfix) with ESMTPSA id F305C614E2CD;
        Sat,  1 Jan 2022 22:58:22 +0100 (CET)
From:   Richard Weinberger <richard@nod.at>
To:     linux-um@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, johannes.berg@intel.com,
        anton.ivanov@cambridgegreys.com,
        Richard Weinberger <richard@nod.at>
Subject: [PATCH 2/4] um: os_set_fd_block: Return old blocking mode
Date:   Sat,  1 Jan 2022 22:58:08 +0100
Message-Id: <20220101215810.13260-3-richard@nod.at>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20220101215810.13260-1-richard@nod.at>
References: <20220101215810.13260-1-richard@nod.at>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This will be needed when we restore the old mode upon exit.
The function now returns < 0 in case of an error, 1 if O_NONBLOCK
was set, 0 otherwise.

Signed-off-by: Richard Weinberger <richard@nod.at>
---
 arch/um/drivers/chan_kern.c     | 8 ++++----
 arch/um/drivers/chan_user.c     | 2 +-
 arch/um/drivers/mconsole_kern.c | 2 +-
 arch/um/drivers/ubd_user.c      | 2 +-
 arch/um/drivers/xterm.c         | 2 +-
 arch/um/os-Linux/file.c         | 5 ++++-
 6 files changed, 12 insertions(+), 9 deletions(-)

diff --git a/arch/um/drivers/chan_kern.c b/arch/um/drivers/chan_kern.c
index 62997055c454..86be115b5890 100644
--- a/arch/um/drivers/chan_kern.c
+++ b/arch/um/drivers/chan_kern.c
@@ -83,7 +83,7 @@ static const struct chan_ops not_configged_ops =3D {
=20
 static int open_one_chan(struct chan *chan)
 {
-	int fd, err;
+	int fd, ret;
=20
 	if (chan->opened)
 		return 0;
@@ -95,10 +95,10 @@ static int open_one_chan(struct chan *chan)
 	if (fd < 0)
 		return fd;
=20
-	err =3D os_set_fd_block(fd, 0);
-	if (err) {
+	ret =3D os_set_fd_block(fd, 0);
+	if (ret < 0) {
 		(*chan->ops->close)(fd, chan->data);
-		return err;
+		return ret;
 	}
=20
 	chan->fd =3D fd;
diff --git a/arch/um/drivers/chan_user.c b/arch/um/drivers/chan_user.c
index 6040817c036f..b449656cd5f8 100644
--- a/arch/um/drivers/chan_user.c
+++ b/arch/um/drivers/chan_user.c
@@ -257,7 +257,7 @@ static int winch_tramp(int fd, struct tty_port *port,=
 int *fd_out,
 	}
=20
 	err =3D os_set_fd_block(*fd_out, 0);
-	if (err) {
+	if (err < 0) {
 		printk(UM_KERN_ERR "winch_tramp: failed to set thread_fd "
 		       "non-blocking.\n");
 		goto out_close;
diff --git a/arch/um/drivers/mconsole_kern.c b/arch/um/drivers/mconsole_k=
ern.c
index 6ead1e240457..8000914f9cd4 100644
--- a/arch/um/drivers/mconsole_kern.c
+++ b/arch/um/drivers/mconsole_kern.c
@@ -732,7 +732,7 @@ static int __init mconsole_init(void)
 		printk(KERN_ERR "Failed to initialize management console\n");
 		return 1;
 	}
-	if (os_set_fd_block(sock, 0))
+	if (os_set_fd_block(sock, 0) < 0)
 		goto out;
=20
 	register_reboot_notifier(&reboot_notifier);
diff --git a/arch/um/drivers/ubd_user.c b/arch/um/drivers/ubd_user.c
index a1afe414ce48..a930a254826b 100644
--- a/arch/um/drivers/ubd_user.c
+++ b/arch/um/drivers/ubd_user.c
@@ -42,7 +42,7 @@ int start_io_thread(unsigned long sp, int *fd_out)
=20
 	err =3D os_set_fd_block(*fd_out, 0);
 	err =3D os_set_fd_block(kernel_fd, 0);
-	if (err) {
+	if (err < 0) {
 		printk("start_io_thread - failed to set nonblocking I/O.\n");
 		goto out_close;
 	}
diff --git a/arch/um/drivers/xterm.c b/arch/um/drivers/xterm.c
index 87ca4a47cd66..01be81c25266 100644
--- a/arch/um/drivers/xterm.c
+++ b/arch/um/drivers/xterm.c
@@ -161,7 +161,7 @@ static int xterm_open(int input, int output, int prim=
ary, void *d,
 	}
=20
 	err =3D os_set_fd_block(new, 0);
-	if (err) {
+	if (err < 0) {
 		printk(UM_KERN_ERR "xterm_open : failed to set xterm "
 		       "descriptor non-blocking, err =3D %d\n", -err);
 		goto out_close2;
diff --git a/arch/um/os-Linux/file.c b/arch/um/os-Linux/file.c
index e4421dbc4c36..af2b3cba2c93 100644
--- a/arch/um/os-Linux/file.c
+++ b/arch/um/os-Linux/file.c
@@ -445,11 +445,14 @@ int os_clear_fd_async(int fd)
 int os_set_fd_block(int fd, int blocking)
 {
 	int flags;
+	int oldmode;
=20
 	flags =3D fcntl(fd, F_GETFL);
 	if (flags < 0)
 		return -errno;
=20
+	oldmode =3D !!(flags & O_NONBLOCK);
+
 	if (blocking)
 		flags &=3D ~O_NONBLOCK;
 	else
@@ -458,7 +461,7 @@ int os_set_fd_block(int fd, int blocking)
 	if (fcntl(fd, F_SETFL, flags) < 0)
 		return -errno;
=20
-	return 0;
+	return oldmode;
 }
=20
 int os_accept_connection(int fd)
--=20
2.26.2

