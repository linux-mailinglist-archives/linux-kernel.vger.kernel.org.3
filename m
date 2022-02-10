Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9D0C4B182B
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 23:29:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344928AbiBJW2z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 17:28:55 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231881AbiBJW2w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 17:28:52 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90F07B0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 14:28:50 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id c8-20020a17090a674800b001b91184b732so7621348pjm.5
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 14:28:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ukO0KyYXgy3rVKggK5LNkPNKJG2JLr7pJGZbja+yPMM=;
        b=JQGD925RtnTgkhEK83SQV2rNJ8pa13YxK29GmUsKVhvyBEbjYls7uqaUewavNRW5Kz
         FOtrsArFWStAxVweZ+5Eo1NeZlJX4Q0M0tUkxNpl6DGqT1Cn3sKxKuxG5dCBTSefih2j
         /dKG0B+2n8x/mA9UIaJldB/2OzSifqBmzqvaF3vFEx6/BU4z/lkSQR8mpmhEDIkixRrt
         cN8No09gd8y9PnTrrL4S+jlkYIeV4rrI6Gf96cJptuV5XTcDTiHfD/h8IRtboeAd/OHO
         Bu8su7vkELdvVMv8spptX0Er6gQVoiA87Sk95jsVUZTvB8r/sSQ2mMfVyQfTs5DnR+wV
         nKdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ukO0KyYXgy3rVKggK5LNkPNKJG2JLr7pJGZbja+yPMM=;
        b=NWoQ1em24e1aa6otv61S8audahbiZyAFHXMKQhXDcqYHfYSkQea9W3sL3lEg4OfjO5
         IV+N3SJpboQhRAF6CqHH/AglaYBzj9QWd1QWh8a36kL6H8Xbi++DL6Gr1+CaPwlzmxzG
         vNdK1zhnNPDw8C7z1ZnKNA7yTeIv5oJnwewcMEbGz7SVqTpJBcxVNM/OuJcfdCF8Hbhg
         kyRVeyRBCfPLLdzX975XfBOTGVZqnTrBjV/bvGIDYTAehx+L2zi72bWUkgWsY3Eva+bQ
         zxVdAy0OnLmXrXW+Ky7tqf/Ir2zTzgIqyywMhz3MaiE0Ft4uDxyCCeBdO10MRI5IQ0a8
         NkaQ==
X-Gm-Message-State: AOAM531B0pSdYVUWVIQe6/BaweP/vrU0jV0eQ0gMtoI2sxQLbX6yj9sd
        BoX9YBgRu/NIl1iwHTEOByX/Lv1XJmbkgs8c
X-Google-Smtp-Source: ABdhPJxiUYwtJ+/fPuz8YKpP/smG82Yhs4PL8miZeszApzzFLGH0wjxU62BHOJfEfOUAfoexV9cutA==
X-Received: by 2002:a17:902:da86:: with SMTP id j6mr9720165plx.95.1644532129630;
        Thu, 10 Feb 2022 14:28:49 -0800 (PST)
Received: from localhost ([2409:10:24a0:4700:e8ad:216a:2a9d:6d0c])
        by smtp.gmail.com with ESMTPSA id u13sm26000153pfg.151.2022.02.10.14.28.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Feb 2022 14:28:49 -0800 (PST)
From:   Stafford Horne <shorne@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     David Laight <David.Laight@aculab.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Stafford Horne <shorne@gmail.com>,
        Christoph Hellwig <hch@lst.de>,
        Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Randy Dunlap <rdunlap@infradead.org>,
        openrisc@lists.librecores.org
Subject: [PATCH v4] openrisc: remove CONFIG_SET_FS
Date:   Fri, 11 Feb 2022 07:28:39 +0900
Message-Id: <20220210222841.3187484-1-shorne@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the address space override API set_fs().  The OpenRISC user
address space is now limited to TASK_SIZE.

To support this we implement and wire in __get_kernel_nofault and
__set_kernel_nofault.

The function user_addr_max is removed as there is a default definition
provided when CONFIG_SET_FS is not used.

Signed-off-by: Stafford Horne <shorne@gmail.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
SInce v3:
 - Change order of __range_ok back and add comment about optimization.

Since v2:
 - Change order of __range_ok condition to be more clear.

Since v1:
 - Fix commit message with misleading comment about User Mode Linux.

 arch/openrisc/Kconfig                   |  1 -
 arch/openrisc/include/asm/thread_info.h |  7 ----
 arch/openrisc/include/asm/uaccess.h     | 51 +++++++++++--------------
 3 files changed, 22 insertions(+), 37 deletions(-)

diff --git a/arch/openrisc/Kconfig b/arch/openrisc/Kconfig
index bf047dca7ec6..ceda77fb8bc8 100644
--- a/arch/openrisc/Kconfig
+++ b/arch/openrisc/Kconfig
@@ -36,7 +36,6 @@ config OPENRISC
 	select ARCH_WANT_FRAME_POINTERS
 	select GENERIC_IRQ_MULTI_HANDLER
 	select MMU_GATHER_NO_RANGE if MMU
-	select SET_FS
 	select TRACE_IRQFLAGS_SUPPORT
 
 config CPU_BIG_ENDIAN
diff --git a/arch/openrisc/include/asm/thread_info.h b/arch/openrisc/include/asm/thread_info.h
index 659834ab87fa..4af3049c34c2 100644
--- a/arch/openrisc/include/asm/thread_info.h
+++ b/arch/openrisc/include/asm/thread_info.h
@@ -40,18 +40,12 @@
  */
 #ifndef __ASSEMBLY__
 
-typedef unsigned long mm_segment_t;
-
 struct thread_info {
 	struct task_struct	*task;		/* main task structure */
 	unsigned long		flags;		/* low level flags */
 	__u32			cpu;		/* current CPU */
 	__s32			preempt_count; /* 0 => preemptable, <0 => BUG */
 
-	mm_segment_t		addr_limit; /* thread address space:
-					       0-0x7FFFFFFF for user-thead
-					       0-0xFFFFFFFF for kernel-thread
-					     */
 	__u8			supervisor_stack[0];
 
 	/* saved context data */
@@ -71,7 +65,6 @@ struct thread_info {
 	.flags		= 0,				\
 	.cpu		= 0,				\
 	.preempt_count	= INIT_PREEMPT_COUNT,		\
-	.addr_limit	= KERNEL_DS,			\
 	.ksp            = 0,                            \
 }
 
diff --git a/arch/openrisc/include/asm/uaccess.h b/arch/openrisc/include/asm/uaccess.h
index 120f5005461b..e6407173e549 100644
--- a/arch/openrisc/include/asm/uaccess.h
+++ b/arch/openrisc/include/asm/uaccess.h
@@ -23,36 +23,13 @@
 #include <asm/page.h>
 #include <asm/extable.h>
 
-/*
- * The fs value determines whether argument validity checking should be
- * performed or not.  If get_fs() == USER_DS, checking is performed, with
- * get_fs() == KERNEL_DS, checking is bypassed.
- *
- * For historical reasons, these macros are grossly misnamed.
- */
-
-/* addr_limit is the maximum accessible address for the task. we misuse
- * the KERNEL_DS and USER_DS values to both assign and compare the
- * addr_limit values through the equally misnamed get/set_fs macros.
- * (see above)
- */
-
-#define KERNEL_DS	(~0UL)
-
-#define USER_DS		(TASK_SIZE)
-#define get_fs()	(current_thread_info()->addr_limit)
-#define set_fs(x)	(current_thread_info()->addr_limit = (x))
-
-#define uaccess_kernel()	(get_fs() == KERNEL_DS)
-
 /* Ensure that the range from addr to addr+size is all within the process'
- * address space
+ * address space.  Note, we compare size vs TASK_SIZE as size is often
+ * constant and this will be optimized to a single compare.
  */
 static inline int __range_ok(unsigned long addr, unsigned long size)
 {
-	const mm_segment_t fs = get_fs();
-
-	return size <= fs && addr <= (fs - size);
+	return size <= TASK_SIZE && addr <= TASK_SIZE - size;
 }
 
 #define access_ok(addr, size)						\
@@ -241,6 +218,25 @@ do {									\
 		(__typeof__((x)-(x)))__gu_tmp);		\
 }
 
+#define __get_kernel_nofault(dst, src, type, label)	\
+{							\
+	type __user *p = (type __force __user *)(src);	\
+	type data;					\
+	if (__get_user(data, p))			\
+		goto label;				\
+	*(type *)dst = data;				\
+}
+
+#define __put_kernel_nofault(dst, src, type, label)	\
+{							\
+	type __user *p = (type __force __user *)(dst);	\
+	type data = *(type *)src;			\
+	if (__put_user(data, p))			\
+		goto label;				\
+}
+
+#define HAVE_GET_KERNEL_NOFAULT
+
 /* more complex routines */
 
 extern unsigned long __must_check
@@ -268,9 +264,6 @@ clear_user(void __user *addr, unsigned long size)
 	return size;
 }
 
-#define user_addr_max() \
-	(uaccess_kernel() ? ~0UL : TASK_SIZE)
-
 extern long strncpy_from_user(char *dest, const char __user *src, long count);
 
 extern __must_check long strnlen_user(const char __user *str, long n);
-- 
2.31.1

