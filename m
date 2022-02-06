Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13E0F4AAD65
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Feb 2022 02:46:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243635AbiBFBh0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Feb 2022 20:37:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236788AbiBFBhZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Feb 2022 20:37:25 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0639C043186
        for <linux-kernel@vger.kernel.org>; Sat,  5 Feb 2022 17:37:23 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id g15-20020a17090a67cf00b001b7d5b6bedaso9825784pjm.4
        for <linux-kernel@vger.kernel.org>; Sat, 05 Feb 2022 17:37:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6mFSwGBPOZsE7a1cgWRID5EHNWk+ZhfB1q2JvQgUDwI=;
        b=ciZWL8D5CFhtiST14Sqo4qF/rwTY2ztJMTrb6IlD9FaI9uggUxZQrmx04VV4IQwCOe
         1TLK4ZVuF19B8U88LMpYJSi1W5BAPk6Y5loDK0C3bgaS+sHZzmpZlkWqCgTC0bmCAyte
         OtKKvPhHiGcduVDlvAo9ltfjMuMmY1wvpyAPf4rhkLa3LXeeDMdSaeXGbQ0LyJJJJmqk
         5kW8GiBQpZXUovo3szFA86i2dxdHGwKOauMM912siyI7oDM6xdIHNlkyf/P3VIrtxarR
         BNcjWGrLkQOw6ebKMrReiE+0QfFkRTaHb1qlK2xpJrYweZ72Grj2KsqTxcSAM8OBMnTL
         q6FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6mFSwGBPOZsE7a1cgWRID5EHNWk+ZhfB1q2JvQgUDwI=;
        b=AIwjHjS8gQ0e0Q7Ix7HDHrSf+6rIN4dmxmSvtvTwQqfBELBIzzXKPq8eL1XPlC6trN
         Ead5M/YiF0wIJXgu3SSoqLDuRfK/fPyIE+c+H9X8uk7pNeBbv922jlzRsL35ZMtuyLua
         fqQRdHLztKhNcOJVaR/3V0SzBLcdHoh5TOC3JXjS9yHWvVUl1HVu70EmWH2gS2g5AJD9
         yPdyakzWeqDmO8tW6Tm4TxE3+2WdAJxF1ibHxpB7GBbXlhQVlWvGV642ODN+SBc1c3Az
         E3MfRZi5gU4TDYNbHA6xOOIydhzKfhaABxtCTSLdy6tumfNoT/IarnUKvtHD8qJaI1ZI
         pUQg==
X-Gm-Message-State: AOAM531BtO3MO4AzPZIdNClAwmFsyG4Wp0wgMwBAZXlW6hMMTp9hXe+I
        sV0Rj1PWGEhrvBNHapoLf5awgkIpZ9rNPXZU
X-Google-Smtp-Source: ABdhPJwp+qgBaFHo0lFLIMWjdiii5+2Fj8XyAM4FkWeotmkVKR5vhv6g1S27wCu/Z4owZIAw2kNHvw==
X-Received: by 2002:a17:90b:1c0f:: with SMTP id oc15mr10941960pjb.17.1644111442857;
        Sat, 05 Feb 2022 17:37:22 -0800 (PST)
Received: from localhost ([2409:10:24a0:4700:e8ad:216a:2a9d:6d0c])
        by smtp.gmail.com with ESMTPSA id rj1sm6145982pjb.49.2022.02.05.17.37.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Feb 2022 17:37:22 -0800 (PST)
From:   Stafford Horne <shorne@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Stafford Horne <shorne@gmail.com>,
        Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Randy Dunlap <rdunlap@infradead.org>,
        openrisc@lists.librecores.org
Subject: [PATCH] openrisc: remove CONFIG_SET_FS
Date:   Sun,  6 Feb 2022 10:36:47 +0900
Message-Id: <20220206013648.3491865-1-shorne@gmail.com>
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

Remove the address space override API set_fs() used for User Mode Linux.
User address space is now limited to TASK_SIZE.

To support this we implement and wire in __get_kernel_nofault and
__set_kernel_nofault.

The function user_addr_max is removed as there is a default definition
provided when CONFIG_SET_FS is not used.

Signed-off-by: Stafford Horne <shorne@gmail.com>
---
 arch/openrisc/Kconfig                   |  1 -
 arch/openrisc/include/asm/thread_info.h |  7 ----
 arch/openrisc/include/asm/uaccess.h     | 48 +++++++++++--------------
 3 files changed, 20 insertions(+), 36 deletions(-)

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
index 120f5005461b..cc9c5d8fd183 100644
--- a/arch/openrisc/include/asm/uaccess.h
+++ b/arch/openrisc/include/asm/uaccess.h
@@ -23,36 +23,12 @@
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
  * address space
  */
 static inline int __range_ok(unsigned long addr, unsigned long size)
 {
-	const mm_segment_t fs = get_fs();
-
-	return size <= fs && addr <= (fs - size);
+	return size <= TASK_SIZE && addr <= (TASK_SIZE - size);
 }
 
 #define access_ok(addr, size)						\
@@ -241,6 +217,25 @@ do {									\
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
@@ -268,9 +263,6 @@ clear_user(void __user *addr, unsigned long size)
 	return size;
 }
 
-#define user_addr_max() \
-	(uaccess_kernel() ? ~0UL : TASK_SIZE)
-
 extern long strncpy_from_user(char *dest, const char __user *src, long count);
 
 extern __must_check long strnlen_user(const char __user *str, long n);
-- 
2.31.1

