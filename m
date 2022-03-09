Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E0A24D3CA7
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 23:10:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238531AbiCIWKo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 17:10:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238517AbiCIWKm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 17:10:42 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39D23120E83
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 14:09:42 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id n15so3191184plh.2
        for <linux-kernel@vger.kernel.org>; Wed, 09 Mar 2022 14:09:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3RyBtyEmzMRxJU2W39DDk0KiHFUzATbBj69bYMsF/AI=;
        b=WkLEtrasqaJFnK3en/WD8hXMfAgfujQamCEWJX9HzV/nTKkCcWUfvzGf4i/3AbH287
         oDHlS6tUp4gw0xG2QBj2oRaewO9bOlRn9L/Hf2qnAql/N8ANJYrcEuX7/OUufaktDXFA
         RDr+JnI7h6U3/mxcjifwO00fvAAynV66XhzlU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3RyBtyEmzMRxJU2W39DDk0KiHFUzATbBj69bYMsF/AI=;
        b=M3vfIz/Pyfyo4amK+xfE87WubOo+zZOQ8WE56H/rg951j5QqwRaw/xvZHraxgnrNSD
         W4WxIkaiT/iXECQceKjkF0EfoZJTRm2GYIGMlBGxmk8yHuV2hUT81sisS5V72oc44mkX
         JW1CtTJG4u+ZF3KhHir0xPlBbWwZpamwCMb3+Gc/92H6n+5YMavfx1+6ZmfHd1VBCyJf
         eBrX0nHiscvCXIOSZ8rONIM59TUZVZK73TAGymi7v5Mp2nHvvyT4vcCB3mqk/7/4fRvm
         9Ibfkv0uDKwGDPhXgA1SQfq+tv+DKhL4ii2UHwcIdggxhJUgvaTUS7dVbbmLIYLei6IZ
         cLeA==
X-Gm-Message-State: AOAM531vFWmhSTYimAjklKPWb3bP+GFhPzUwgWyyMaBv/KPpywvzg2Q0
        tSjf42p+oLMoY0gBQ/h2T1TFSQ==
X-Google-Smtp-Source: ABdhPJz3hQaSoCXi126abtuoyPN4EMArKtT5LO3jgMJVcY9w2A08BrDP5R/4IOsiTNMI+VbAS4qyYQ==
X-Received: by 2002:a17:902:b410:b0:14b:e53:7aa0 with SMTP id x16-20020a170902b41000b0014b0e537aa0mr1598015plr.101.1646863781324;
        Wed, 09 Mar 2022 14:09:41 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id x190-20020a6286c7000000b004f6bf60b958sm4042169pfd.125.2022.03.09.14.09.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Mar 2022 14:09:41 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     Kees Cook <keescook@chromium.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Yanteng Si <siyanteng01@gmail.com>, linux-mips@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        linux-hardening@vger.kernel.org
Subject: [PATCH v2] MIPS: Only use current_stack_pointer on GCC
Date:   Wed,  9 Mar 2022 14:09:39 -0800
Message-Id: <20220309220939.392227-1-keescook@chromium.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3195; h=from:subject; bh=euWNXeV+R+VzRid09kc/o6vcd8UPQ3nOG/QsDt8+Tfc=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBiKSWi/PwIFAHuBHJ0yDMKnhcCqFJTvDKI02mxaTDI LPX+/KeJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYiklogAKCRCJcvTf3G3AJk68D/ 9on3pGT+Ega5r5xIV64B136VGD6gUesgZypidb6y9QvcJz1cTt/3ju/OMu/seo7B9ijRIGoi/cG+mD sKkDqoLjcp+9ZRmKJQs5wR8hdilBG5XUTNL5vnE4aCOqqylELWVOO+SxOpcNANJqrrz70nvygrYsl+ qUSyor4Y/o5Rb9pmBWbyvhB/N1G34Tu0gpvfzGPbgCiRB3gwgf7dFAxp8PaGZ8g1Ip4RBlYCgcbpDW m2O6RFldr6bRXDHNmyZHrhO3j88F6Xe0U7CkPrrUWuLHnheNPzYCnU8s5+vsWTAq7qKOWFQ4uUyG3q GiqWGYbtAGWh+sy8xp+Xnk4dcll08/cXu0L1UPBweKDslYcOKIDkLX3zyIZDC3HCppAE3HgfPTosAx 6kxuIQ6fGRnIGXHWvbP+mEq/pGcKp/vu7SiBsyxhprrHWju93QY7y3lBr5m0F4yaJKHlJIbp9oP3Yp sqciEFoqClPSSZYwpJ5DU3rKrww/AW4khio0Iqepmgat3F14XKytYAOaeRfCAcosb/QoYSwSLKSmSG /xoh03cB+LvCpCT6AI+iE0w5VofRvOocq9SJ/JqHJlRMpr4POUZ3DX1yLkf+nN81ifzzovDNonG7Dt 266D0ryN32LTJC+WKYEe+JN34YacDDc4a4ncnclazJQkHM1blzpx4QmyuH+Q==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Unfortunately, Clang did not have support for "sp" as a global register
definition, and was crashing after the addition of current_stack_pointer.
This has been fixed in Clang 15, but earlier Clang versions need to
avoid this code, so add a versioned test and revert back to the
open-coded asm instances. Fixes Clang build error:

fatal error: error in backend: Invalid register name global variable

Fixes: 200ed341b864 ("mips: Implement "current_stack_pointer"")
Reported-by: Nathan Chancellor <nathan@kernel.org>
Reviewed-by: Nathan Chancellor <nathan@kernel.org>
Link: https://lore.kernel.org/lkml/YikTQRql+il3HbrK@dev-arch.thelio-3990X
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: Marc Zyngier <maz@kernel.org>
Cc: Guenter Roeck <linux@roeck-us.net>
Cc: Yanteng Si <siyanteng01@gmail.com>
Cc: linux-mips@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
v1: https://lore.kernel.org/lkml/20220309204537.390428-1-keescook@chromium.org
v2: - adjust Clang version (Nathan)
---
 arch/mips/Kconfig                   | 2 +-
 arch/mips/include/asm/thread_info.h | 2 ++
 arch/mips/kernel/irq.c              | 3 ++-
 arch/mips/lib/uncached.c            | 4 +++-
 4 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 3f58b45fc953..0dae5f1e61cc 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -4,7 +4,7 @@ config MIPS
 	default y
 	select ARCH_32BIT_OFF_T if !64BIT
 	select ARCH_BINFMT_ELF_STATE if MIPS_FP_SUPPORT
-	select ARCH_HAS_CURRENT_STACK_POINTER
+	select ARCH_HAS_CURRENT_STACK_POINTER if !CC_IS_CLANG || CLANG_VERSION >= 140000
 	select ARCH_HAS_DEBUG_VIRTUAL if !64BIT
 	select ARCH_HAS_FORTIFY_SOURCE
 	select ARCH_HAS_KCOV
diff --git a/arch/mips/include/asm/thread_info.h b/arch/mips/include/asm/thread_info.h
index 4463348d2372..ecae7470faa4 100644
--- a/arch/mips/include/asm/thread_info.h
+++ b/arch/mips/include/asm/thread_info.h
@@ -69,7 +69,9 @@ static inline struct thread_info *current_thread_info(void)
 	return __current_thread_info;
 }
 
+#ifdef CONFIG_ARCH_HAS_CURRENT_STACK_POINTER
 register unsigned long current_stack_pointer __asm__("sp");
+#endif
 
 #endif /* !__ASSEMBLY__ */
 
diff --git a/arch/mips/kernel/irq.c b/arch/mips/kernel/irq.c
index fc313c49a417..5e11582fe308 100644
--- a/arch/mips/kernel/irq.c
+++ b/arch/mips/kernel/irq.c
@@ -75,8 +75,9 @@ void __init init_IRQ(void)
 #ifdef CONFIG_DEBUG_STACKOVERFLOW
 static inline void check_stack_overflow(void)
 {
-	unsigned long sp = current_stack_pointer;
+	unsigned long sp;
 
+	__asm__ __volatile__("move %0, $sp" : "=r" (sp));
 	sp &= THREAD_MASK;
 
 	/*
diff --git a/arch/mips/lib/uncached.c b/arch/mips/lib/uncached.c
index f8d4ca046c3e..f80a67c092b6 100644
--- a/arch/mips/lib/uncached.c
+++ b/arch/mips/lib/uncached.c
@@ -40,7 +40,9 @@ unsigned long run_uncached(void *func)
 	register long ret __asm__("$2");
 	long lfunc = (long)func, ufunc;
 	long usp;
-	long sp = current_stack_pointer;
+	long sp;
+
+	__asm__("move %0, $sp" : "=r" (sp));
 
 	if (sp >= (long)CKSEG0 && sp < (long)CKSEG2)
 		usp = CKSEG1ADDR(sp);
-- 
2.32.0

