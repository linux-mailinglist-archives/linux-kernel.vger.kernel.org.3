Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBBEB5305DE
	for <lists+linux-kernel@lfdr.de>; Sun, 22 May 2022 22:38:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350247AbiEVUhW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 May 2022 16:37:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235342AbiEVUhU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 May 2022 16:37:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE0EA3915C
        for <linux-kernel@vger.kernel.org>; Sun, 22 May 2022 13:37:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DA95660C01
        for <linux-kernel@vger.kernel.org>; Sun, 22 May 2022 20:37:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA0C3C385AA;
        Sun, 22 May 2022 20:37:16 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="fyD4i8TG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1653251833;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=oAwnwKx2LdMyS/spACWLYLZUrVpx6uUo1Je+4tvNAPo=;
        b=fyD4i8TGNPefGDOfWfzK1FPTwgMOSgr+x8ldEARyhFRtLYt0t79ZiwosC2FgIS16gcWWbA
        H74+R7JekkotF/pDU+7oVfwhRySmRX3JxSnL7PKYVBwnoZM9r6aEMY+lxECZTJmcsUdahK
        T9MPhOf0Ivg3HhIKWwY+J9vTmouSc8A=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 1b63c27c (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Sun, 22 May 2022 20:37:13 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     linux-kernel@vger.kernel.org
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>
Subject: [PATCH] random: check for signals after page of pool writes
Date:   Sun, 22 May 2022 22:37:02 +0200
Message-Id: <20220522203702.14386-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

get_random_bytes_user() checks for signals after producing a PAGE_SIZE
worth of output, just like /dev/zero does. write_pool() is doing
basically the same work (actually, slightly more expensive), and so
should stop to check for signals in the same way. Let's also name it
write_pool_user() to match get_random_bytes_user(), so this won't be
misused in the future.

Before this patch, massive writes to /dev/urandom would tie up the
process for an extremely long time and make it unterminatable. After, it
can be successfully interrupted. The following test program can be used
to see this works as intended:

  #include <unistd.h>
  #include <fcntl.h>
  #include <signal.h>
  #include <stdio.h>

  static unsigned char x[~0U];

  static void handle(int) { }

  int main(int argc, char *argv[])
  {
    pid_t pid = getpid(), child;
    int fd;
    signal(SIGUSR1, handle);
    if (!(child = fork())) {
      for (;;)
        kill(pid, SIGUSR1);
    }
    fd = open("/dev/urandom", O_WRONLY);
    pause();
    printf("interrupted after writing %zd bytes\n", write(fd, x, sizeof(x)));
    close(fd);
    kill(child, SIGTERM);
    return 0;
  }

Result before: "interrupted after writing 2147479552 bytes"
Result after: "interrupted after writing 4096 bytes"

Cc: Dominik Brodowski <linux@dominikbrodowski.net>
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 drivers/char/random.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index dc2f2c24c6ec..b691b9d59503 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -1274,7 +1274,7 @@ static __poll_t random_poll(struct file *file, poll_table *wait)
 	return crng_ready() ? EPOLLIN | EPOLLRDNORM : EPOLLOUT | EPOLLWRNORM;
 }
 
-static ssize_t write_pool(struct iov_iter *iter)
+static ssize_t write_pool_user(struct iov_iter *iter)
 {
 	u8 block[BLAKE2S_BLOCK_SIZE];
 	ssize_t ret = 0;
@@ -1289,7 +1289,13 @@ static ssize_t write_pool(struct iov_iter *iter)
 		mix_pool_bytes(block, copied);
 		if (!iov_iter_count(iter) || copied != sizeof(block))
 			break;
-		cond_resched();
+
+		BUILD_BUG_ON(PAGE_SIZE % sizeof(block) != 0);
+		if (ret % PAGE_SIZE == 0) {
+			if (signal_pending(current))
+				break;
+			cond_resched();
+		}
 	}
 
 	memzero_explicit(block, sizeof(block));
@@ -1298,7 +1304,7 @@ static ssize_t write_pool(struct iov_iter *iter)
 
 static ssize_t random_write_iter(struct kiocb *kiocb, struct iov_iter *iter)
 {
-	return write_pool(iter);
+	return write_pool_user(iter);
 }
 
 static ssize_t urandom_read_iter(struct kiocb *kiocb, struct iov_iter *iter)
@@ -1372,7 +1378,7 @@ static long random_ioctl(struct file *f, unsigned int cmd, unsigned long arg)
 		ret = import_single_range(WRITE, p, len, &iov, &iter);
 		if (unlikely(ret))
 			return ret;
-		ret = write_pool(&iter);
+		ret = write_pool_user(&iter);
 		if (unlikely(ret < 0))
 			return ret;
 		/* Since we're crediting, enforce that it was all written into the pool. */
-- 
2.35.1

