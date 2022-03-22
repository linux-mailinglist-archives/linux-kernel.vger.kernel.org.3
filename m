Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEED44E3C59
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 11:22:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232930AbiCVKX3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 06:23:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232984AbiCVKXZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 06:23:25 -0400
Received: from gnuweeb.org (gnuweeb.org [51.81.211.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADECC80221
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 03:21:49 -0700 (PDT)
Received: from integral2.. (unknown [182.2.69.158])
        by gnuweeb.org (Postfix) with ESMTPSA id 09D957E2FC;
        Tue, 22 Mar 2022 10:21:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gnuweeb.org;
        s=default; t=1647944509;
        bh=p66YvFuGrGyt3VddGxZU7iLnQ3idpcgTeeL7pb2/ZMc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=na7uKYyAv5UF8SI1p/DQHmVtDdz56ZlALpZLQPCGfgB6jCOJt+7PZW8WuJI6k5UL4
         Fo9OHOcXEhTUp2Qii1BuH5l96VspuqJxZ3To6waUQqTA+3N5h4hsRiPfUnQfBoug++
         hFxJfMmvDfFeu1Ns9Z7BxVArFbVjHYDF801h1w4cb7Qyrg32x25fkepyaSGsGcAyrL
         r2W4azmW9ED0MELvqF/lAvxUrQjXyh0J2BQqh5sMycdvX4oMMChsDxyoX1uC8l47wT
         NGc7hlQCab+NfhkGctCsb1EmUo0H8dDuKUOxPriHudRhthxA+tc1aTD+9dZxLjK7Wd
         rfeFXxWApMw2g==
From:   Ammar Faizi <ammarfaizi2@gnuweeb.org>
To:     Willy Tarreau <w@1wt.eu>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Alviro Iskandar Setiawan <alviro.iskandar@gnuweeb.org>,
        Nugraha <richiisei@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        Ammar Faizi <ammarfaizi2@gnuweeb.org>
Subject: [RFC PATCH v2 4/8] tools/nolibc/sys: Implement `mmap()` and `munmap()`
Date:   Tue, 22 Mar 2022 17:21:11 +0700
Message-Id: <20220322102115.186179-5-ammarfaizi2@gnuweeb.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220322102115.186179-1-ammarfaizi2@gnuweeb.org>
References: <20220322102115.186179-1-ammarfaizi2@gnuweeb.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implement mmap() and munmap(). Currently, they are only available for
architecures that have my_syscall6 macro. For architectures that don't
have, this function will return -1 with errno set to ENOSYS (Function
not implemented).

This has been tested on x86 and i386.

Notes for i386:
 1) The common mmap() syscall implementation uses __NR_mmap2 instead
    of __NR_mmap.

 2) The offset must be shifted-right by 12-bit.

Signed-off-by: Ammar Faizi <ammarfaizi2@gnuweeb.org>
---

@@ Changelog:

   Link RFC v1: https://lore.kernel.org/lkml/20220320093750.159991-5-ammarfaizi2@gnuweeb.org/
   RFC v1 -> RFC v2:
    * No changes *
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
Ammar Faizi

