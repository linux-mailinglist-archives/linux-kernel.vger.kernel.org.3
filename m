Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84FC14EAB22
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 12:18:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235098AbiC2KUJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 06:20:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235093AbiC2KTy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 06:19:54 -0400
Received: from gnuweeb.org (gnuweeb.org [51.81.211.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 795722405BD
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 03:18:05 -0700 (PDT)
Received: from integral2.. (unknown [182.2.70.161])
        by gnuweeb.org (Postfix) with ESMTPSA id 151CE7E734;
        Tue, 29 Mar 2022 10:18:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gnuweeb.org;
        s=default; t=1648549085;
        bh=DJZFv4JotEMo5L83nTqipusJFM8ZYgW9v7ot8diz0vk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VQtJiwB00c4DkarcuHtgJpo5lMxauXI6ZY2BAAz027atQbihyJahtmO5ASq05SpoE
         ER3x8AqZZW9Y9A3fvGB15CFuVCrQV4XyqQnmfHXEJ1FURvektiK4j2H45gOiTdEBYG
         IimqHvHsTCdJqTS+3pShi5ZkhSbvAXYehNuUwpjVu0FLR7MxmD5DSd8O3Z/3u+VsEB
         A9/hbEPCnBmGEWuWkStjGKZ4GmjbArtmA/2E4Fux7IB+7JP9kR/txZuXAktrIcbSlu
         B36r1OxolWe0Sb7enkTZcTd44Ys++bsNJC/MVcDpSZnhaHFHOseDbsbNhWaqE4FzNM
         RT15qfrBhKR1Q==
From:   Ammar Faizi <ammarfaizi2@gnuweeb.org>
To:     Willy Tarreau <w@1wt.eu>
Cc:     Ammar Faizi <ammarfaizi2@gnuweeb.org>,
        Alviro Iskandar Setiawan <alviro.iskandar@gnuweeb.org>,
        Nugraha <richiisei@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>
Subject: [PATCH v2 5/9] tools/nolibc/sys: Implement `mmap()` and `munmap()`
Date:   Tue, 29 Mar 2022 17:17:33 +0700
Message-Id: <20220329101737.58985-6-ammarfaizi2@gnuweeb.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220329101737.58985-1-ammarfaizi2@gnuweeb.org>
References: <20220329101737.58985-1-ammarfaizi2@gnuweeb.org>
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
===
@@ Changelog:

   Link v1: https://lore.gnuweeb.org/gwml/20220324073039.140946-8-ammarfaizi2@gnuweeb.org
   v1 -> v2:
    * No changes *

   Link RFC v2: https://lore.kernel.org/lkml/20220322102115.186179-5-ammarfaizi2@gnuweeb.org
   RFC v2 -> v1:
    * No changes *

   Link RFC v1: https://lore.kernel.org/lkml/20220320093750.159991-5-ammarfaizi2@gnuweeb.org
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

