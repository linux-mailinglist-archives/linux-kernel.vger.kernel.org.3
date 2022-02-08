Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AEEE4AD1C8
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 07:50:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347817AbiBHGt6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 01:49:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347792AbiBHGt4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 01:49:56 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE621C0401F2
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 22:49:55 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id qe15so5833140pjb.3
        for <linux-kernel@vger.kernel.org>; Mon, 07 Feb 2022 22:49:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TdyfB2bN7Vz/Zf9WYE9/YZ10evosJEsfl99tre4qOuI=;
        b=mxlX/FpCVrfM1WD5C4ZSaXMDzyx29ju1J7DHmsrB+M7apCt21xatHgZZAvMvOD1YLa
         tzZFz05CBrTuwyzm6s5TbjEb4z2aebMIiMOrWsMtWJOxYoYq3KaSnPH28tWXqwlHKdgL
         O7JjyQhw46PU4tkPdec+t32W1RjDocx9kmsWjosIqBwB3BtdQAPz10FhFIn44JSwpx12
         HG1/DbudlA6V3dmac1UEYf1th94+ilMlEpOmcXVnaMV2i2UgvoDUnVJELsrdUsqT7iLY
         MUWguHQFxi7vSJK6hW1AJngZwYTUCosRJTvUGZNwAPTskcqt8ealFd5YRVk+4rbOX1Gz
         lcxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TdyfB2bN7Vz/Zf9WYE9/YZ10evosJEsfl99tre4qOuI=;
        b=n87SXiy5NcLGAfwr97X1H0a7KMxzdiXRO1WmbVvmBGTTVAlO0QTj/L9Yl1rssJql84
         2q5TcZ0QEbDNj7dIp0+wV9D4ewv8+cpSb+DccP/mbh/RwKUIqcObwnddUIoQvCYAMwDX
         6JjMBTrVH0007O4Ycpnm07IiL4uzmwnu6cBJw62GH57mRHgD7BWkd44pLGVcbvyswaR7
         SUgbgo5EfkkvisZEplJQyUXol+cF7nw6kU8h6Pz0MZZUD4r/lmT6WO3vArNp3QVIDB5T
         Lb1jMwkQOA8gkwBSdPMSDAPgeHH7JQP49WhyzweWZKRaUgLOkpG1ar8RnVcNOydGbXRH
         lvMQ==
X-Gm-Message-State: AOAM532b7j0A4hZRSeglgQfAc43OXNAkzITsBmX/Wdzc38YSVfAnlmUf
        BwXMtchZGsLyCGdY/1idzqXdAHB9iz7LHg==
X-Google-Smtp-Source: ABdhPJyTAJzDGH96+WIQQ76PBHD3CatihkrVeK/cLi4tmkbtcusyYeaPhBURI4Zu99aWHq/CfmwgoQ==
X-Received: by 2002:a17:90a:ce08:: with SMTP id f8mr2853699pju.27.1644302994647;
        Mon, 07 Feb 2022 22:49:54 -0800 (PST)
Received: from localhost ([2409:10:24a0:4700:e8ad:216a:2a9d:6d0c])
        by smtp.gmail.com with ESMTPSA id q2sm10271423pgt.47.2022.02.07.22.49.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Feb 2022 22:49:54 -0800 (PST)
From:   Stafford Horne <shorne@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     David Laight <David.Laight@aculab.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Christoph Hellwig <hch@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Stafford Horne <shorne@gmail.com>,
        Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Randy Dunlap <rdunlap@infradead.org>,
        openrisc@lists.librecores.org
Subject: [PATCH v3] openrisc: remove CONFIG_SET_FS
Date:   Tue,  8 Feb 2022 15:49:03 +0900
Message-Id: <20220208064905.199632-1-shorne@gmail.com>
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
---
Since v2
 - Change order of __range_ok condition to be more clear.

Since v1:
 - Fix commit message with misleading comment about User Mode Linux.

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
index 120f5005461b..cbf22b94c02c 100644
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
+	return addr <= TASK_SIZE && size <= TASK_SIZE - addr;
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

