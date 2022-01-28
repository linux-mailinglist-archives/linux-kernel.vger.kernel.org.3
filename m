Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB58949F89D
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 12:45:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348204AbiA1Lpx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 06:45:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348196AbiA1Lpw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 06:45:52 -0500
Received: from mail-wm1-x349.google.com (mail-wm1-x349.google.com [IPv6:2a00:1450:4864:20::349])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 433C1C061714
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 03:45:52 -0800 (PST)
Received: by mail-wm1-x349.google.com with SMTP id bg16-20020a05600c3c9000b0034bea12c043so5760453wmb.7
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 03:45:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=mcBQonq9lXEu3o2avKFSmCAtNtSrD58c9xOTmXyxJbc=;
        b=dDfyhR5AB5IaYgYz2a3FGiI3JkG/6DalYBQNMRvN5op752cNmJaQSQhf3Zp9TA8dYf
         8ENznJKNqNtkw5JTeQ9pd6lTvBtloL+2SdqqVvjF/L+2WaJIAoDbRvCGyzfFaLjTg+Fa
         wl60c7D4H+fhnOCz5FESU9Q5dYy58toSvpTELD8bS2HsIg00u16fE5ugJRDLj00aTQY9
         NxYAp24NP3ja9fv2pMNRI09ibcBZSaC7Ihd14wmLgKnhFiMz30PQfwbfs+kFTAZ8/9f1
         pH/dPx4kF2UDNZJmqkS/P3MMD2cYKYgl54O5nbRYNzkT7q987/QBfoMHcP1/YlF9V3Y0
         PyVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=mcBQonq9lXEu3o2avKFSmCAtNtSrD58c9xOTmXyxJbc=;
        b=J0Vtgs35y7lpI+kNwHrdOAAIwL1lkuO676RUBzrdxIrzSjBLbcTDydh3Rb6pGeLny6
         xsfR63tZkn9KRh4wVtB20AvlZ6XFllXRD+GsoUdu9OKybLROh02d6sen3a9MCL+hR1QL
         lSZ3z6Df+KobZEbIlpx2TYCgQP5q93buodPHpNptHHDj6LYrdSq9YRM/H7rbeCFhwpKo
         2TOEmdq/e6TT8IuZJ9t/QL/Sf8zAt9VdMqjnYXX24xlTTxBHIrtSx9o435UkkgGIS31v
         M/ZOpeTJHBVGEjrTcQK5JByEcELSgJpY2+cma4SVGmvQvZ3Y5fJmrDuv1WA4sB7niqWz
         qNuw==
X-Gm-Message-State: AOAM532/E0evWt3LYgZ592S9JF1WDIJbk+NoPw+4HM1oTF5pqYu17ByF
        Oun9HEIeNMW0wnHURzFqWgSZVN0nKw==
X-Google-Smtp-Source: ABdhPJyBdSh2F7YYmJQ8OWV4SC2aAaFbjqZBKGMpUccusqIhFERKP9cbCKgvNVPUONTLxKkc7pT49fLIrQ==
X-Received: from elver.muc.corp.google.com ([2a00:79e0:15:13:f088:5245:7f91:d730])
 (user=elver job=sendgmr) by 2002:a1c:f413:: with SMTP id z19mr15683197wma.144.1643370350900;
 Fri, 28 Jan 2022 03:45:50 -0800 (PST)
Date:   Fri, 28 Jan 2022 12:44:45 +0100
Message-Id: <20220128114446.740575-1-elver@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.35.0.rc0.227.g00780c9af4-goog
Subject: [PATCH 1/2] stack: Introduce CONFIG_RANDOMIZE_KSTACK_OFFSET
From:   Marco Elver <elver@google.com>
To:     elver@google.com, Thomas Gleixner <tglx@linutronix.de>,
        Kees Cook <keescook@chromium.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Elena Reshetova <elena.reshetova@intel.com>,
        Alexander Potapenko <glider@google.com>, llvm@lists.linux.dev,
        kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The randomize_kstack_offset feature is unconditionally compiled in when
the architecture supports it.

To add constraints on compiler versions, we require a dedicated Kconfig
variable. Therefore, introduce RANDOMIZE_KSTACK_OFFSET.

Furthermore, this option is now also configurable by EXPERT kernels:
while the feature is supposed to have zero performance overhead when
disabled, due to its use of static branches, there are few cases where
giving a distribution the option to disable the feature entirely makes
sense. For example, in very resource constrained environments, which
would never enable the feature to begin with, in which case the
additional kernel code size increase would be redundant.

Signed-off-by: Marco Elver <elver@google.com>
---
 arch/Kconfig                     | 23 ++++++++++++++++++-----
 include/linux/randomize_kstack.h |  5 +++++
 init/main.c                      |  2 +-
 3 files changed, 24 insertions(+), 6 deletions(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index 678a80713b21..2cde48d9b77c 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -1159,16 +1159,29 @@ config HAVE_ARCH_RANDOMIZE_KSTACK_OFFSET
 	  to the compiler, so it will attempt to add canary checks regardless
 	  of the static branch state.
 
-config RANDOMIZE_KSTACK_OFFSET_DEFAULT
-	bool "Randomize kernel stack offset on syscall entry"
+config RANDOMIZE_KSTACK_OFFSET
+	bool "Support for randomizing kernel stack offset on syscall entry" if EXPERT
+	default y
 	depends on HAVE_ARCH_RANDOMIZE_KSTACK_OFFSET
 	help
 	  The kernel stack offset can be randomized (after pt_regs) by
 	  roughly 5 bits of entropy, frustrating memory corruption
 	  attacks that depend on stack address determinism or
-	  cross-syscall address exposures. This feature is controlled
-	  by kernel boot param "randomize_kstack_offset=on/off", and this
-	  config chooses the default boot state.
+	  cross-syscall address exposures.
+
+	  The feature is controlled via the "randomize_kstack_offset=on/off"
+	  kernel boot param, and if turned off has zero overhead due to its use
+	  of static branches (see JUMP_LABEL).
+
+	  If unsure, say Y.
+
+config RANDOMIZE_KSTACK_OFFSET_DEFAULT
+	bool "Default state of kernel stack offset randomization"
+	depends on RANDOMIZE_KSTACK_OFFSET
+	help
+	  Kernel stack offset randomization is controlled by kernel boot param
+	  "randomize_kstack_offset=on/off", and this config chooses the default
+	  boot state.
 
 config ARCH_OPTIONAL_KERNEL_RWX
 	def_bool n
diff --git a/include/linux/randomize_kstack.h b/include/linux/randomize_kstack.h
index bebc911161b6..91f1b990a3c3 100644
--- a/include/linux/randomize_kstack.h
+++ b/include/linux/randomize_kstack.h
@@ -2,6 +2,7 @@
 #ifndef _LINUX_RANDOMIZE_KSTACK_H
 #define _LINUX_RANDOMIZE_KSTACK_H
 
+#ifdef CONFIG_RANDOMIZE_KSTACK_OFFSET
 #include <linux/kernel.h>
 #include <linux/jump_label.h>
 #include <linux/percpu-defs.h>
@@ -50,5 +51,9 @@ void *__builtin_alloca(size_t size);
 		raw_cpu_write(kstack_offset, offset);			\
 	}								\
 } while (0)
+#else /* CONFIG_RANDOMIZE_KSTACK_OFFSET */
+#define add_random_kstack_offset()		do { } while (0)
+#define choose_random_kstack_offset(rand)	do { } while (0)
+#endif /* CONFIG_RANDOMIZE_KSTACK_OFFSET */
 
 #endif
diff --git a/init/main.c b/init/main.c
index 65fa2e41a9c0..560f45c27ffe 100644
--- a/init/main.c
+++ b/init/main.c
@@ -853,7 +853,7 @@ static void __init mm_init(void)
 	pti_init();
 }
 
-#ifdef CONFIG_HAVE_ARCH_RANDOMIZE_KSTACK_OFFSET
+#ifdef CONFIG_RANDOMIZE_KSTACK_OFFSET
 DEFINE_STATIC_KEY_MAYBE_RO(CONFIG_RANDOMIZE_KSTACK_OFFSET_DEFAULT,
 			   randomize_kstack_offset);
 DEFINE_PER_CPU(u32, kstack_offset);
-- 
2.35.0.rc0.227.g00780c9af4-goog

