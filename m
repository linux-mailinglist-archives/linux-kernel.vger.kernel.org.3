Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D6374C23D6
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 07:05:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230463AbiBXGFE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 01:05:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbiBXGFD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 01:05:03 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2844B265BCB
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 22:04:34 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id x18so971296pfh.5
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 22:04:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AeWswyL5DjAtKzmLU3KtKz6+xm0djQXebWPR/IOT7mM=;
        b=l/96d7QvjWlPaDARyevWXvubyELpVm1VBS6h7E8mQ97gIOqov98YRpKZRl7EQ0r+VL
         PAU26GemRYp6LGiXJGXykIuFxf3ohYWr2LiIjQZHm710UBIN6SSZHt4Fsr+i1G2RgVVk
         W4PdLGqY4tTiQh3COjYK7WqE2WsQaOezyhypk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AeWswyL5DjAtKzmLU3KtKz6+xm0djQXebWPR/IOT7mM=;
        b=T9596DdHx/xAgcGE2b4GfHbZ5SMvosWB2W+CqufqtKlJZKNBtr0dHtPRJRXHhtW0nd
         KtseIZ3DmdHcxJgNWKQsjc1yKRWRHRgndICUyjVN0v56ajguTlVTDKIQYwBggRXKwpGl
         HhbOtn/3oVYcUnMw8ihsBEacxeimosJS6EPYQi7+2OcXf4Jp8mtQSBrF2oHishrdJnMP
         Y2Vzo7RSg8NTRtAB/qybm7ahm8lKYjN3p30/IElk9nJe1X/r6Q5CXD58dxzC7mOeBfqH
         Njlt7UeH0V8QsBcA38eJh/ejsybCRkQSwXmJVAA9vD7Xy3Mc7tDrFOEPKn19MEAsrAJ1
         2+1A==
X-Gm-Message-State: AOAM531TODSDJHrpfpZJr6Xt68qcQOkxgrUq9ktMz/CtqVz+lyDeeI7R
        n9fcU8pgLdSr4yg8Bp1eIhzlyA==
X-Google-Smtp-Source: ABdhPJyaopj0Ld/RUiuPbCy5QKCLmbYjJO2F/2/UQD4ycjOFQMtz+N8ndlKBqC637rlzJyg8z0hBow==
X-Received: by 2002:aa7:85c2:0:b0:4cb:b95a:887f with SMTP id z2-20020aa785c2000000b004cbb95a887fmr1124835pfn.74.1645682673702;
        Wed, 23 Feb 2022 22:04:33 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id g4sm1598017pfv.63.2022.02.23.22.04.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Feb 2022 22:04:33 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     Kees Cook <keescook@chromium.org>, Marc Zyngier <maz@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Mark Rutland <mark.rutland@arm.com>,
        Yanteng Si <siyanteng01@gmail.com>, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH] mips: Implement "current_stack_pointer"
Date:   Wed, 23 Feb 2022 22:04:32 -0800
Message-Id: <20220224060432.1855897-1-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2542; h=from:subject; bh=Su5r+nRQFJ8y2LkvuL5JXmfe3uoEYG0my6Wnp6xBte4=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBiFx/vka0VZftr6+M0yhcLNUC4ZSc/qos9uFCkLPS6 P6Ej8kmJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYhcf7wAKCRCJcvTf3G3AJgrqD/ kBt998zUUqaRfLVJJn0ajzdaI5Ec4tSYHONMEjtcqtSNnMD8tDMiQNrhF5MKye9FDtVlopQ5vuj4PV k8foIXlR2HMRpXvrZE3XsddWWBTZwr1V4KXNPuxesaCOMairWZCZlnUSMulLv8rd2vjmfPc8oYeZad E3W6EAy5XSlpcLTwrfJ0rSS2XgWrirfmgJXx3bEGOKh5qxoq1NVxGERG3VvOaQ8YOR7l6zS7n21Odz 0QBMWYJkXQUdSegVnHCcb2nmD3csPHAqh7YIpCyOHho9wz12oXMsQQV8RYHiH0HrK+EnyP8XDC5UPw /g3XYYPcRuHtvrkRFBeXBTSnVjp4WUKZaMUVJ4L1UaAPzfolYXIXhMC/oRXZOz17GzAGBYw+NIdFZz DMiKEQIs87Yi/HawbRoPOkfxo2zVNi8gsYPh3jotVQJnNrDm3MlGhvnwb0pIE7yFHCQY8pRA+AnSK5 KuH8WgPkmnn/oVRd5R4V7mmcYXKezF4bL9ovuu9CfHSySAblPxiE42t5Xux0qCxG75HrVwE2xzoUDz 7vfN6dg1r82HiwEhP/rO5GtVQ3q9VaPcr7li/YF0XLb0iO5L3ROmetJuHqHgtp+LTdm/Gz9yslxBfV NNOsP+74u0/wPDpsykGhLOJyhK0T4lH0IKKHd+CXZnz/7raBwEBIynOwwu6g==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To follow the existing per-arch conventions replace open-coded uses
of asm "sp" as "current_stack_pointer". This will let it be used in
non-arch places (like HARDENED_USERCOPY).

Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: Marc Zyngier <maz@kernel.org>
Cc: Guenter Roeck <linux@roeck-us.net>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Yanteng Si <siyanteng01@gmail.com>
Cc: linux-mips@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 arch/mips/Kconfig                   | 1 +
 arch/mips/include/asm/thread_info.h | 2 ++
 arch/mips/kernel/irq.c              | 3 +--
 arch/mips/lib/uncached.c            | 4 +---
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 058446f01487..6781f87e2218 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -4,6 +4,7 @@ config MIPS
 	default y
 	select ARCH_32BIT_OFF_T if !64BIT
 	select ARCH_BINFMT_ELF_STATE if MIPS_FP_SUPPORT
+	select ARCH_HAS_CURRENT_STACK_POINTER
 	select ARCH_HAS_DEBUG_VIRTUAL if !64BIT
 	select ARCH_HAS_FORTIFY_SOURCE
 	select ARCH_HAS_KCOV
diff --git a/arch/mips/include/asm/thread_info.h b/arch/mips/include/asm/thread_info.h
index 0b17aaa9e012..4463348d2372 100644
--- a/arch/mips/include/asm/thread_info.h
+++ b/arch/mips/include/asm/thread_info.h
@@ -69,6 +69,8 @@ static inline struct thread_info *current_thread_info(void)
 	return __current_thread_info;
 }
 
+register unsigned long current_stack_pointer __asm__("sp");
+
 #endif /* !__ASSEMBLY__ */
 
 /* thread information allocation */
diff --git a/arch/mips/kernel/irq.c b/arch/mips/kernel/irq.c
index 5e11582fe308..fc313c49a417 100644
--- a/arch/mips/kernel/irq.c
+++ b/arch/mips/kernel/irq.c
@@ -75,9 +75,8 @@ void __init init_IRQ(void)
 #ifdef CONFIG_DEBUG_STACKOVERFLOW
 static inline void check_stack_overflow(void)
 {
-	unsigned long sp;
+	unsigned long sp = current_stack_pointer;
 
-	__asm__ __volatile__("move %0, $sp" : "=r" (sp));
 	sp &= THREAD_MASK;
 
 	/*
diff --git a/arch/mips/lib/uncached.c b/arch/mips/lib/uncached.c
index f80a67c092b6..f8d4ca046c3e 100644
--- a/arch/mips/lib/uncached.c
+++ b/arch/mips/lib/uncached.c
@@ -40,9 +40,7 @@ unsigned long run_uncached(void *func)
 	register long ret __asm__("$2");
 	long lfunc = (long)func, ufunc;
 	long usp;
-	long sp;
-
-	__asm__("move %0, $sp" : "=r" (sp));
+	long sp = current_stack_pointer;
 
 	if (sp >= (long)CKSEG0 && sp < (long)CKSEG2)
 		usp = CKSEG1ADDR(sp);
-- 
2.30.2

