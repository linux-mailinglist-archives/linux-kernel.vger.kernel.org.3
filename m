Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 777E259B781
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 04:18:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232334AbiHVCP7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Aug 2022 22:15:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229948AbiHVCPu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Aug 2022 22:15:50 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAB562183E;
        Sun, 21 Aug 2022 19:15:48 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id f17so2876063pfk.11;
        Sun, 21 Aug 2022 19:15:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=1iHPy2MJm6s7J5XdJO/siHoKhzaKKWD/EXtuZwe5/AE=;
        b=mKi9In1cguwoEOIvsqd6r243Uwmb97pem6sMmVbQ/lX7DKmHGQ4Cz8u7NaUAMolab3
         HmdgTa5cqnb+GfgxLAPvRC2VcgnhWhU/izaXxri5eH+EgDoV+6M0er9uK9apm/9k6Wa+
         O6vWMuPgbVirYyTOwBORRtmkCs2pdpI1E3AlnfMY1g6INcFNsiY5OxCc+eK21YnW41W/
         9gNulkHUPIkdHnMs5921OdcrPwHgoXozCfdiUiIdwYospQ2cvraEremg4xnjuFFKYkFu
         gDjp9ye/aSfYYNx/jRfdI/eCYmQuHZst3at0UYKdKX8Agaty19wI93E6qRscBDPMtYU4
         QtCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=1iHPy2MJm6s7J5XdJO/siHoKhzaKKWD/EXtuZwe5/AE=;
        b=gQurD7zt8PVEr+NP3mGn/+6k0tXJ5MoscnXNzSMiKmZmjLvPObX9wj+HlnsJ6trjLk
         OX41ToE2aDZVKgGEs3bys+Hg2aTOPMHl2zzs6mWB7gNN4q6AQwKhvS6RI90tJD9R0SeF
         ow9N0Ca1QaVm8epRdoPzpNIQWxKV8QHX7gTmFeENE/nZVTTLYI0cIp6zG6mCtBGVcEE8
         dPhqmxExnHHPCP4976yoMkVwRqS+KP9/xMjAyqos5Z28PJk+KfND+aJGvNT5PQ5ih2oZ
         yPS+MDVl2R25+2orxw8XNxw3toaDZp6kCH1GJT5zRY49/bRq9T9F6A1Qmr9ReEzJt7iX
         X2tQ==
X-Gm-Message-State: ACgBeo2kJuEgLbiLz49ddHiLK8xN8QT4y5GAbnitr65U0uOWBreuEewo
        mihkLZ80R09OCes07dQVcg==
X-Google-Smtp-Source: AA6agR5RhOvnr+n8C+QckGvAPfLQPD+H4Z9Kyq6FS5FDBt09E1rsRMXpjGgfl8V7Hzvo18Hl1aKTcg==
X-Received: by 2002:a63:ce06:0:b0:41d:dcc3:aa6e with SMTP id y6-20020a63ce06000000b0041ddcc3aa6emr15448270pgf.251.1661134548425;
        Sun, 21 Aug 2022 19:15:48 -0700 (PDT)
Received: from piliu.users.ipa.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id k3-20020aa79723000000b005321340753fsm7312139pfg.103.2022.08.21.19.15.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Aug 2022 19:15:47 -0700 (PDT)
From:   Pingfan Liu <kernelfans@gmail.com>
To:     linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Pingfan Liu <kernelfans@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Peter Zijlstra <peterz@infradead.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Marco Elver <elver@google.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Dan Li <ashimida@linux.alibaba.com>,
        Song Liu <song@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Tony Lindgren <tony@atomide.com>,
        Nick Hawkins <nick.hawkins@hpe.com>,
        John Crispin <john@phrozen.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Price <steven.price@arm.com>
Subject: [RFC 02/10] cpu/hotplug: Compile smp_shutdown_nonboot_cpus() conditioned on CONFIG_SHUTDOWN_NONBOOT_CPUS
Date:   Mon, 22 Aug 2022 10:15:12 +0800
Message-Id: <20220822021520.6996-3-kernelfans@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220822021520.6996-1-kernelfans@gmail.com>
References: <20220822021520.6996-1-kernelfans@gmail.com>
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

Only arm/arm64/ia64/riscv share the smp_shutdown_nonboot_cpus(). So
compiling this code conditioned on the macro
CONFIG_SHUTDOWN_NONBOOT_CPUS. Later this macro will brace the quick
kexec reboot code.

Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
Cc: Russell King <linux@armlinux.org.uk>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Paul Walmsley <paul.walmsley@sifive.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>
Cc: Albert Ou <aou@eecs.berkeley.edu>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Marco Elver <elver@google.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Dan Li <ashimida@linux.alibaba.com>
Cc: Song Liu <song@kernel.org>
Cc: Sami Tolvanen <samitolvanen@google.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Ard Biesheuvel <ardb@kernel.org>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Nick Hawkins <nick.hawkins@hpe.com>
Cc: John Crispin <john@phrozen.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Steven Price <steven.price@arm.com>
To: linux-arm-kernel@lists.infradead.org
To: linux-ia64@vger.kernel.org
To: linux-riscv@lists.infradead.org
To: linux-kernel@vger.kernel.org
---
 arch/Kconfig       | 4 ++++
 arch/arm/Kconfig   | 1 +
 arch/arm64/Kconfig | 1 +
 arch/ia64/Kconfig  | 1 +
 arch/riscv/Kconfig | 1 +
 kernel/cpu.c       | 3 +++
 6 files changed, 11 insertions(+)

diff --git a/arch/Kconfig b/arch/Kconfig
index f330410da63a..be447537d0f6 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -14,6 +14,10 @@ menu "General architecture-dependent options"
 config CRASH_CORE
 	bool
 
+config SHUTDOWN_NONBOOT_CPUS
+	select KEXEC_CORE
+	bool
+
 config KEXEC_CORE
 	select CRASH_CORE
 	bool
diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 87badeae3181..711cfdb4f9f4 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -129,6 +129,7 @@ config ARM
 	select PCI_SYSCALL if PCI
 	select PERF_USE_VMALLOC
 	select RTC_LIB
+	select SHUTDOWN_NONBOOT_CPUS
 	select SYS_SUPPORTS_APM_EMULATION
 	select THREAD_INFO_IN_TASK
 	select HAVE_ARCH_VMAP_STACK if MMU && ARM_HAS_GROUP_RELOCS
diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 571cc234d0b3..8c481a0b1829 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -223,6 +223,7 @@ config ARM64
 	select PCI_SYSCALL if PCI
 	select POWER_RESET
 	select POWER_SUPPLY
+	select SHUTDOWN_NONBOOT_CPUS
 	select SPARSE_IRQ
 	select SWIOTLB
 	select SYSCTL_EXCEPTION_TRACE
diff --git a/arch/ia64/Kconfig b/arch/ia64/Kconfig
index 26ac8ea15a9e..8a3ddea97d1b 100644
--- a/arch/ia64/Kconfig
+++ b/arch/ia64/Kconfig
@@ -52,6 +52,7 @@ config IA64
 	select ARCH_CLOCKSOURCE_DATA
 	select GENERIC_TIME_VSYSCALL
 	select LEGACY_TIMER_TICK
+	select SHUTDOWN_NONBOOT_CPUS
 	select SWIOTLB
 	select SYSCTL_ARCH_UNALIGN_NO_WARN
 	select HAVE_MOD_ARCH_SPECIFIC
diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index ed66c31e4655..02606a48c5ea 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -120,6 +120,7 @@ config RISCV
 	select PCI_MSI if PCI
 	select RISCV_INTC
 	select RISCV_TIMER if RISCV_SBI
+	select SHUTDOWN_NONBOOT_CPUS
 	select SPARSE_IRQ
 	select SYSCTL_EXCEPTION_TRACE
 	select THREAD_INFO_IN_TASK
diff --git a/kernel/cpu.c b/kernel/cpu.c
index 338e1d426c7e..2be6ba811a01 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -1258,6 +1258,8 @@ int remove_cpu(unsigned int cpu)
 }
 EXPORT_SYMBOL_GPL(remove_cpu);
 
+#ifdef CONFIG_SHUTDOWN_NONBOOT_CPUS
+
 void smp_shutdown_nonboot_cpus(unsigned int primary_cpu)
 {
 	unsigned int cpu;
@@ -1299,6 +1301,7 @@ void smp_shutdown_nonboot_cpus(unsigned int primary_cpu)
 
 	cpu_maps_update_done();
 }
+#endif
 
 #else
 #define takedown_cpu		NULL
-- 
2.31.1

