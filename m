Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B46A4AB64B
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 09:12:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236155AbiBGHwn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 02:52:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243299AbiBGHvC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 02:51:02 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58DE5C043181
        for <linux-kernel@vger.kernel.org>; Sun,  6 Feb 2022 23:51:01 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id g8so1723359pfq.9
        for <linux-kernel@vger.kernel.org>; Sun, 06 Feb 2022 23:51:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3bIYzWqmKF4OUiLArYTAXIwmNIkF1zAp2Bo8KhvDjuI=;
        b=mfPEoaUoTNW4cZcUnhtyn0r4mMu9F+6a9vIIHAKnZduKijW6Dh8TOxtB4MdRXrf0Zc
         HNOp7UcYZ1sjqM1rJLtFss7HewON8j2NSkYuf8xhCoTyFzEtkhX23nOyDxybW0R6jLcT
         uzS6JntswqmLoMKx5UGFHTDfq7HJV7tK9tbzK+wFknaHJIG/QbuFqeWyetbJ+yEBd0df
         vbvDxEqpko/urGmhVsfxjK5Qf7DWwZr9NxRP/28AmJjpSP0vjBdpQ1ZuoH8F0B32SFBB
         C8o96YE5CQQ+w/vBIb3ZrjIYNCuvaJEKz/AwDdDC1zbzhesQU1lPPpRAhFJSk3oY2jbS
         ZWBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3bIYzWqmKF4OUiLArYTAXIwmNIkF1zAp2Bo8KhvDjuI=;
        b=kl4TwBeaRkrtuNwYtADJqan1+DJZAxbN4d7fNAfVwLOG4BWvF6RS+MfvgRZCjy5Tov
         8vCQQ3Y1AsqxMJd5ovkVjhqqUlSMneEwMH3wVjIkhwv3lu8WQ1HRzovDPWmI9wDZDnDb
         Aq+DnmJIxnfm2jICIpBb2xBOAEp/D0OiDWPVcYS5jlyAjYy9AwD1nftW7ueDjVXQ83VM
         hCfKoTnKtoE0aT3Cu7MSuhv44syerHK6jTFNfQwA1cBlo5Z0TbRbkQbvmp0I8v8LZEO1
         EmSxX8furzxlWA4/K/AplF/9A9XbxsYT/89PijbKCVqJTN7tX7lMvV39tqCT0VrDpqsH
         hSDQ==
X-Gm-Message-State: AOAM532VXhsIJRI7YiPGuYPK2zkXeSauXNBgCc/GOJ7ABfElSU0pXq0+
        SYaK5ogn9fD6HMCd6W7MI945T3rpnhk5lA==
X-Google-Smtp-Source: ABdhPJwTL/+cIZ3C18clOHCWfWcmnq939swO65hH5D76BW4zzZBiUUz9TobGzV4hvCovLT3KuCzZpQ==
X-Received: by 2002:a63:ad44:: with SMTP id y4mr8491023pgo.160.1644220260405;
        Sun, 06 Feb 2022 23:51:00 -0800 (PST)
Received: from localhost ([2409:10:24a0:4700:e8ad:216a:2a9d:6d0c])
        by smtp.gmail.com with ESMTPSA id 8sm20150775pjs.39.2022.02.06.23.50.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Feb 2022 23:50:59 -0800 (PST)
From:   Stafford Horne <shorne@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Christoph Hellwig <hch@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Stafford Horne <shorne@gmail.com>,
        Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Randy Dunlap <rdunlap@infradead.org>,
        openrisc@lists.librecores.org
Subject: [PATCH v2] openrisc: remove CONFIG_SET_FS
Date:   Mon,  7 Feb 2022 16:50:36 +0900
Message-Id: <20220207075038.3811999-1-shorne@gmail.com>
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
since v1:
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

