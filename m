Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8E0D47A9A9
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 13:25:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232679AbhLTMZr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 07:25:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232648AbhLTMZh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 07:25:37 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1E1BC061763
        for <linux-kernel@vger.kernel.org>; Mon, 20 Dec 2021 04:25:28 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id x15so37639131edv.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Dec 2021 04:25:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Hl+ryow41wi2SaGEsd9ekcLiVIZ1XeLL/2x+u6A5DI4=;
        b=ySXDbKpAQDvqd1KrQTCpKrrUdahL3ZhLdFVTEKN/Q2EKUyM05WYjpqrSUoJGpxmpjV
         6IwEyq4mqK7OUfprSz7xlHYLVDBOanZrlb7dP0BqgCk1+mGUzrcChGv+KXCwGkV+5dm6
         y3Rn78yADkPHO4MgtvQASZx53Ae6lGFDrEj+397ljnhlhvhsqeWZLv6/0xJ9aryUGN/q
         RF/UR+BRbaCfazfb/NRQU8sJn2kzA5v6k1IAax8NCP6tIHxvkUHU1E1Sic8OKBBhf19H
         nJu0cHsL9WM9sw6PCLhkR4i4cERgq1x4csGvShaKXZk+anad3qJcz/tz28LwHujjC08z
         S6FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Hl+ryow41wi2SaGEsd9ekcLiVIZ1XeLL/2x+u6A5DI4=;
        b=1xy3NdSH5RxniXzy5Jq45zHV39Scj9MAsvLknkZw45H2u+7Sak180VDgofT9kyM5Q6
         FyuAGK0XUxh/hhlmc3TJUw6mrm9WJPTuyvA9OIwFVYTcT0Ukv2r1AEvY/GbXbTop2e2h
         HA2iTiqQUUXgTZp/dmdwYCqkZuXwPoyAlYUJ2WY/3bENqgRN/Bw8qkxcy/hOSPmU2IHq
         CnBK9Wg+2VYY8XvOBJwlFbMlCVEpsoL7z7AiUh4/VCEDwc9WbEEPrbXun7V3bUVx3xyS
         +8kzQq34fzLe79XPFfhjxjqneT2oB17frW4ioBAnpamzez/cST8NxYJ0eqv6k/4iq9hC
         LdJQ==
X-Gm-Message-State: AOAM533/pvPclGUR9AcW89G5iWyT/q5PnEZaML5AMhwQn/+5N7NJQiqh
        WLqaFUXMzVNyZBcM2hdzJtpK9w==
X-Google-Smtp-Source: ABdhPJz8Er9dgu/RM1Q8UYWfCgZhMuHYfuPV3UUY5O/KX+SXO9evYAOe/OrFlAxOKtfwPpm4d1c4Zg==
X-Received: by 2002:a17:906:6996:: with SMTP id i22mr13335152ejr.293.1640003127203;
        Mon, 20 Dec 2021 04:25:27 -0800 (PST)
Received: from localhost (c-9b28e555.07-21-73746f28.bbcust.telenor.se. [85.229.40.155])
        by smtp.gmail.com with ESMTPSA id y5sm3044716edm.39.2021.12.20.04.25.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Dec 2021 04:25:26 -0800 (PST)
From:   Anders Roxell <anders.roxell@linaro.org>
To:     stable@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, woojung.huh@microchip.com,
        UNGLinuxDriver@microchip.com, davem@davemloft.net,
        netdev@vger.kernel.org, linux-usb@vger.kernel.org,
        clang-built-linux@googlegroups.com, ulli.kroll@googlemail.com,
        linux@armlinux.org.uk, linux-arm-kernel@lists.infradead.org,
        amitkarwar@gmail.com, nishants@marvell.com, gbhat@marvell.com,
        huxinming820@gmail.com, kvalo@codeaurora.org,
        linux-wireless@vger.kernel.org, rostedt@goodmis.org,
        mingo@redhat.com, dmitry.torokhov@gmail.com,
        ndesaulniers@google.com, nathan@kernel.org,
        linux-input@vger.kernel.org, Stefan Agner <stefan@agner.ch>,
        Arnd Bergmann <arnd@arndb.de>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH 4.14 4/6] ARM: 8800/1: use choice for kernel unwinders
Date:   Mon, 20 Dec 2021 13:25:04 +0100
Message-Id: <20211220122506.3631672-5-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211220122506.3631672-1-anders.roxell@linaro.org>
References: <20211220122506.3631672-1-anders.roxell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stefan Agner <stefan@agner.ch>

commit f9b58e8c7d031b0daa5c9a9ee27f5a4028ba53ac upstream.

While in theory multiple unwinders could be compiled in, it does
not make sense in practise. Use a choice to make the unwinder
selection mutually exclusive and mandatory.

Already before this commit it has not been possible to deselect
FRAME_POINTER. Remove the obsolete comment.

Furthermore, to produce a meaningful backtrace with FRAME_POINTER
enabled the kernel needs a specific function prologue:
    mov    ip, sp
    stmfd    sp!, {fp, ip, lr, pc}
    sub    fp, ip, #4

To get to the required prologue gcc uses apcs and no-sched-prolog.
This compiler options are not available on clang, and clang is not
able to generate the required prologue. Make the FRAME_POINTER
config symbol depending on !clang.

Suggested-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Stefan Agner <stefan@agner.ch>
Reviewed-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 arch/arm/Kconfig.debug | 44 +++++++++++++++++++++++++++---------------
 lib/Kconfig.debug      |  6 +++---
 2 files changed, 31 insertions(+), 19 deletions(-)

diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
index b14f154919a5..d6cf18a0cb0a 100644
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@ -16,30 +16,42 @@ config ARM_PTDUMP
 	  kernel.
 	  If in doubt, say "N"
 
-# RMK wants arm kernels compiled with frame pointers or stack unwinding.
-# If you know what you are doing and are willing to live without stack
-# traces, you can get a slightly smaller kernel by setting this option to
-# n, but then RMK will have to kill you ;).
-config FRAME_POINTER
-	bool
-	depends on !THUMB2_KERNEL
-	default y if !ARM_UNWIND || FUNCTION_GRAPH_TRACER
+choice
+	prompt "Choose kernel unwinder"
+	default UNWINDER_ARM if AEABI && !FUNCTION_GRAPH_TRACER
+	default UNWINDER_FRAME_POINTER if !AEABI || FUNCTION_GRAPH_TRACER
+	help
+	  This determines which method will be used for unwinding kernel stack
+	  traces for panics, oopses, bugs, warnings, perf, /proc/<pid>/stack,
+	  livepatch, lockdep, and more.
+
+config UNWINDER_FRAME_POINTER
+	bool "Frame pointer unwinder"
+	depends on !THUMB2_KERNEL && !CC_IS_CLANG
+	select ARCH_WANT_FRAME_POINTERS
+	select FRAME_POINTER
 	help
-	  If you say N here, the resulting kernel will be slightly smaller and
-	  faster. However, if neither FRAME_POINTER nor ARM_UNWIND are enabled,
-	  when a problem occurs with the kernel, the information that is
-	  reported is severely limited.
+	  This option enables the frame pointer unwinder for unwinding
+	  kernel stack traces.
 
-config ARM_UNWIND
-	bool "Enable stack unwinding support (EXPERIMENTAL)"
+config UNWINDER_ARM
+	bool "ARM EABI stack unwinder"
 	depends on AEABI
-	default y
+	select ARM_UNWIND
 	help
 	  This option enables stack unwinding support in the kernel
 	  using the information automatically generated by the
 	  compiler. The resulting kernel image is slightly bigger but
 	  the performance is not affected. Currently, this feature
-	  only works with EABI compilers. If unsure say Y.
+	  only works with EABI compilers.
+
+endchoice
+
+config ARM_UNWIND
+	bool
+
+config FRAME_POINTER
+	bool
 
 config OLD_MCOUNT
 	bool
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 428eaf16a1d2..f63a4faf244e 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1131,7 +1131,7 @@ config LOCKDEP
 	bool
 	depends on DEBUG_KERNEL && TRACE_IRQFLAGS_SUPPORT && STACKTRACE_SUPPORT && LOCKDEP_SUPPORT
 	select STACKTRACE
-	select FRAME_POINTER if !MIPS && !PPC && !ARM_UNWIND && !S390 && !MICROBLAZE && !ARC && !SCORE && !X86
+	select FRAME_POINTER if !MIPS && !PPC && !ARM && !S390 && !MICROBLAZE && !ARC && !SCORE && !X86
 	select KALLSYMS
 	select KALLSYMS_ALL
 
@@ -1566,7 +1566,7 @@ config FAULT_INJECTION_STACKTRACE_FILTER
 	depends on FAULT_INJECTION_DEBUG_FS && STACKTRACE_SUPPORT
 	depends on !X86_64
 	select STACKTRACE
-	select FRAME_POINTER if !MIPS && !PPC && !S390 && !MICROBLAZE && !ARM_UNWIND && !ARC && !SCORE && !X86
+	select FRAME_POINTER if !MIPS && !PPC && !S390 && !MICROBLAZE && !ARM && !ARC && !SCORE && !X86
 	help
 	  Provide stacktrace filter for fault-injection capabilities
 
@@ -1575,7 +1575,7 @@ config LATENCYTOP
 	depends on DEBUG_KERNEL
 	depends on STACKTRACE_SUPPORT
 	depends on PROC_FS
-	select FRAME_POINTER if !MIPS && !PPC && !S390 && !MICROBLAZE && !ARM_UNWIND && !ARC && !X86
+	select FRAME_POINTER if !MIPS && !PPC && !S390 && !MICROBLAZE && !ARM && !ARC && !X86
 	select KALLSYMS
 	select KALLSYMS_ALL
 	select STACKTRACE
-- 
2.34.1

