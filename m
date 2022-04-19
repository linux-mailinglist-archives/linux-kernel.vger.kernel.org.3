Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75F98506143
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 03:03:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243395AbiDSAuK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 20:50:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241438AbiDSApS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 20:45:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F23C205E2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 17:42:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DA8B66144E
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 00:42:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7944C341DB;
        Tue, 19 Apr 2022 00:42:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650328948;
        bh=a9uGinr8oNdfB7zLg4ViVkrgJYz+afmtl6wLSS5P8Ng=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SEwC8qs/2V+7xUd8VaDG1eIzXDVZpaHx7YGz1nrFI/z7Zr1PATWKuoGRQBGrdv2v0
         pv2S9g4J5VGCJQNo/7qNUjKWVf+IGwQGTulFU8eGkOANW5zSrSCbRRjSI81pst/OuN
         8ezR+z64oEp6bF3KcsUQZvA3BydCxxHsdyW3/az4N77B5DLr8++ZK77kTp9/Xr3NwK
         uEfPjXu6NzvqtBl19xp+c88rJma+1E/UzK1vyZvFqZ/MWaYAhjnvU4ZIC4fZ/RdQRO
         sL9qDrSaHV/gQGOXY4bue2RJP1NP6oVXryNlSQ3acuJ1G79+jJzy5cQLUeZXfTNOvC
         Uz2PnBwFU7niA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 705555C3242; Mon, 18 Apr 2022 17:42:27 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     gwml@vger.gnuweeb.org, kernel-team@fb.com, w@lwt.eu,
        Ammar Faizi <ammarfaizi2@gnuweeb.org>,
        Willy Tarreau <w@1wt.eu>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH nolibc 57/61] tools/nolibc/sys: Implement `mmap()` and `munmap()`
Date:   Mon, 18 Apr 2022 17:42:21 -0700
Message-Id: <20220419004225.3952530-57-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20220419004219.GA3952301@paulmck-ThinkPad-P17-Gen-1>
References: <20220419004219.GA3952301@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ammar Faizi <ammarfaizi2@gnuweeb.org>

Implement mmap() and munmap(). Currently, they are only available for
architecures that have my_syscall6 macro. For architectures that don't
have, this function will return -1 with errno set to ENOSYS (Function
not implemented).

This has been tested on x86 and i386.

Notes for i386:
 1) The common mmap() syscall implementation uses __NR_mmap2 instead
    of __NR_mmap.

 2) The offset must be shifted-right by 12-bit.

Acked-by: Willy Tarreau <w@1wt.eu>
Signed-off-by: Ammar Faizi <ammarfaizi2@gnuweeb.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/include/nolibc/sys.h | 62 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 62 insertions(+)

diff --git a/tools/include/nolibc/sys.h b/tools/include/nolibc/sys.h
index 4d4308d5d111..08491070387b 100644
--- a/tools/include/nolibc/sys.h
+++ b/tools/include/nolibc/sys.h
@@ -14,6 +14,7 @@
 #include <asm/unistd.h>
 #include <asm/signal.h>  // for SIGCHLD
 #include <asm/ioctls.h>
+#include <asm/mman.h>
 #include <linux/fs.h>
 #include <linux/loop.h>
 #include <linux/time.h>
@@ -675,6 +676,67 @@ int mknod(const char *path, mode_t mode, dev_t dev)
 	return ret;
 }
 
+#ifndef MAP_SHARED
+#define MAP_SHARED		0x01	/* Share changes */
+#define MAP_PRIVATE		0x02	/* Changes are private */
+#define MAP_SHARED_VALIDATE	0x03	/* share + validate extension flags */
+#endif
+
+#ifndef MAP_FAILED
+#define MAP_FAILED ((void *)-1)
+#endif
+
+static __attribute__((unused))
+void *sys_mmap(void *addr, size_t length, int prot, int flags, int fd,
+	       off_t offset)
+{
+#ifndef my_syscall6
+	/* Function not implemented. */
+	return -ENOSYS;
+#else
+
+	int n;
+
+#if defined(__i386__)
+	n = __NR_mmap2;
+	offset >>= 12;
+#else
+	n = __NR_mmap;
+#endif
+
+	return (void *)my_syscall6(n, addr, length, prot, flags, fd, offset);
+#endif
+}
+
+static __attribute__((unused))
+void *mmap(void *addr, size_t length, int prot, int flags, int fd, off_t offset)
+{
+	void *ret = sys_mmap(addr, length, prot, flags, fd, offset);
+
+	if ((unsigned long)ret >= -4095UL) {
+		SET_ERRNO(-(long)ret);
+		ret = MAP_FAILED;
+	}
+	return ret;
+}
+
+static __attribute__((unused))
+int sys_munmap(void *addr, size_t length)
+{
+	return my_syscall2(__NR_munmap, addr, length);
+}
+
+static __attribute__((unused))
+int munmap(void *addr, size_t length)
+{
+	int ret = sys_munmap(addr, length);
+
+	if (ret < 0) {
+		SET_ERRNO(-ret);
+		ret = -1;
+	}
+	return ret;
+}
 
 /*
  * int mount(const char *source, const char *target,
-- 
2.31.1.189.g2e36527f23

