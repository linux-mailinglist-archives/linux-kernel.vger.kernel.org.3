Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48F474D3B52
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 21:45:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238191AbiCIUqs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 15:46:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238199AbiCIUqp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 15:46:45 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC6086E35E
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 12:45:40 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id c16-20020a17090aa61000b001befad2bfaaso3381729pjq.1
        for <linux-kernel@vger.kernel.org>; Wed, 09 Mar 2022 12:45:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ERN4EHsAehnzKKHh1D2+nTh+Py8x5Rp5HMGDjFluxr8=;
        b=cpibhiHH+V6FoD7AGaa89Pnpr1MqQbNAw3c0vVDSFoQFk3yUy7H4dCYYXfTWAmXrOs
         l8GpE3EWh8KFbr1MAh3LU6KqfHECUwSRcaIveHTwEvCwWTWJkfTWeEBuHrdJRNvVcsLT
         qHHY3jztnSlnXprm7bX5SKwQ2E493nxBs4RT4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ERN4EHsAehnzKKHh1D2+nTh+Py8x5Rp5HMGDjFluxr8=;
        b=avQLOKEcch92GiU2hodn4LxDyEQw5A/B8Cq51oz3bUL1VrhEFIsa3amY3AVMsi8Z2Y
         c47Om1suLywyNBUJTVbLuPnuQCIiQGegURB4tYa/Dq/nbomV6jboJiXbxcV/IQ6rwdOB
         18TIzFh3VObH8Q8pE+gZ/u+FhtulHrUqOrej2CdvIv8ZbVTzxVziB5OQjkbjGmiKonOF
         1cxZ4hJKOE8Fh7ZViVMF09F7drz7WYfJMK1QYa9jvVjZaNe+08xuRvzIfnwTC3GXWi39
         69omsJw4EDumDyK+ISglOYaYOqDupsQqbQptVUjSaEt6K6D6+QR+3Dqs1S7qp+EplkUT
         7/jA==
X-Gm-Message-State: AOAM531xBMH+cofAEVC/ystwudiF1njCYPCYQgG6Jo5aKDdMuVTNqgMy
        1Hcc4czOWtz9n0hno/W9l7QDJg==
X-Google-Smtp-Source: ABdhPJzUHtWrv+KW+UL90YnTzk6+LrU87Z4C7tNuo2i9t4ZS9YtNksuPK+owbWcQ8enR1zl7uRCZYQ==
X-Received: by 2002:a17:90a:7bc5:b0:1be:eef4:b961 with SMTP id d5-20020a17090a7bc500b001beeef4b961mr12201271pjl.29.1646858740334;
        Wed, 09 Mar 2022 12:45:40 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 16-20020a056a00073000b004dfe2217090sm4111014pfm.200.2022.03.09.12.45.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Mar 2022 12:45:40 -0800 (PST)
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
Subject: [PATCH] MIPS: Only use current_stack_pointer on GCC
Date:   Wed,  9 Mar 2022 12:45:37 -0800
Message-Id: <20220309204537.390428-1-keescook@chromium.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2946; h=from:subject; bh=mJJlcMAOHOUY1LaTM6CaPuzsaMVsrZSzurV5C9KyV08=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBiKRHwT/gRY3du4lkTuPbFhzgpqXfYeWapwif0U9xk 4yZK6xKJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYikR8AAKCRCJcvTf3G3AJjnMEA CzTpygscG3HkIXS1hEPEscabCr9RpEuJhqQZXV8xRtoQXwrE2xeA0Uzv/rB4oF/Cd58H1w7442Hjs5 +ElxOHaJB/oGPmAJfKoArhK1r7b8Eb9AseY8z6brFbjRwsIpASiwzatqfrqBelCySWBMyKM30+bnvl Y3cxwrGBKrgJfkSo8hgbg2ysttwY/eOCpuZvoLrFL6DDZ1ku1YLomALhq+ujqRrLFWQsz/6aXI4Eks g1hVpufdlwo10713WyE6x/q8tHLF8DaaFK3ILTSL7qRVqinr2WiIgpbiRAD32ouad9jfNP3pPLDxPI 9a+HfL3fK8/exJ9C9kSNuHxFADYNml/bacRhohBGoDmX/tHJ2RZvwaY2mc+LKs+V8U6eXvCpiMjsxJ KRvGsHdcVONj+RRntX0Mzhj/UgYZ0/QfUo6+qCgqmRSlfvqeeeEJIAzYs96lWz1/L6yTMYdxhUvqTs bqViRba8Mx/muLUPqoazxhUxdlODBf2MmQj5dAe5JA+SNOC6hdlsGTWFqyK+sdJTKKbRzWH2tVjXj0 LZLBjJvNi41ZiLfT0Oae3pEqxHIvtcnztyO8kt0UzAKMaNmsHHmC8RwJBU0jr7ImjONFAZVEjv5yl2 NtUvzJAtB5MsSouKr9u4+MPJEVASs4gCzxhDzJfUdHyp5WbkYQEs2XsawC7Q==
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
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: Marc Zyngier <maz@kernel.org>
Cc: Guenter Roeck <linux@roeck-us.net>
Cc: Yanteng Si <siyanteng01@gmail.com>
Cc: linux-mips@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 arch/mips/Kconfig                   | 2 +-
 arch/mips/include/asm/thread_info.h | 2 ++
 arch/mips/kernel/irq.c              | 3 ++-
 arch/mips/lib/uncached.c            | 4 +++-
 4 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 3f58b45fc953..15769013f46e 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -4,7 +4,7 @@ config MIPS
 	default y
 	select ARCH_32BIT_OFF_T if !64BIT
 	select ARCH_BINFMT_ELF_STATE if MIPS_FP_SUPPORT
-	select ARCH_HAS_CURRENT_STACK_POINTER
+	select ARCH_HAS_CURRENT_STACK_POINTER if !CC_IS_CLANG || CLANG_VERSION >= 150000
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

