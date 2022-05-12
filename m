Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0636B524302
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 05:07:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244854AbiELDG5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 23:06:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244811AbiELDGx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 23:06:53 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA6A838DA1;
        Wed, 11 May 2022 20:06:49 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id l11-20020a17090a49cb00b001d923a9ca99so3710714pjm.1;
        Wed, 11 May 2022 20:06:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pWq/+Bte7VjbrLdN2lGHRy6uQDSlfBm3NDeykg391Ho=;
        b=nwEtTjFAW+x+QRTih+1S+0XAkG0pzoOBF2HYPZwaOOc3NvTHQBxVW9lNY0SWO4QAWt
         lVO8D7d8sj+GBLO+SJ0XuCUK3Yc5a1dG15PNl51PuQMVJjpmk3gcNXKQCCvS+Wctqw7Z
         xqwFSaTbEDq62TMY5sEOxYt/+j4UhmjfJcZUAivfC1zzdwpFD+xcQTttiGjDfDv0+hIO
         tHacXhvSJgKE0ZT/uTsxGFoHh1W3mdRCQZ82qw3g3TqhaGyqWKOBApmpMatJXZe51Rke
         /RlwqTzaW8mNFIHXJx+fVRv/MOK5rWGcbW7Q/A1aTU0Kzd7hg+3vS7IBsxBjA3alWGY/
         6vWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pWq/+Bte7VjbrLdN2lGHRy6uQDSlfBm3NDeykg391Ho=;
        b=x33kS411Wackk7UXZ55OqG+PAdEuiJZyMsSWBO9431AbmBxoE69QU2riVgMHbB0hAo
         nAnMEg4pj/9SlKB9c5XJMi6gayyR4VBQ29/oRwSAOFLgGfl8U56wm2pe3W9NRekaqjEO
         Y3Ba6ZWLSY47SL/1b0imFp7x+3UdIu2EN+VezgJt40xYK6S0qAGrbHKSaS7SdiAT2pQs
         2UeHsBPDXCqfMC/O4CHVWR5DNUtt1wCVY1SCZD2TpQwYjk23wrfT/dzNlA8OX4R+evGL
         GepWgwKlrKOeqjFGktkS7/KSlNW+HR7pxDipZ9urdTVTFWg9R8ViXuDh/JUGsk6TYysY
         bP6w==
X-Gm-Message-State: AOAM531aKn8Z1KKLQSPNzhKfzKGMxBccklnMweyGUeHCK2Sy6nARYx6Y
        YxT/8hLW0njPvGUGIYQA27C+a1GVng==
X-Google-Smtp-Source: ABdhPJySV9BUOK77UbovcdzqXyp9x8QSqqEfbjObNWOs5wEeq7X821SAQEeSH0VJB9DBni9EAR7MaA==
X-Received: by 2002:a17:90a:4417:b0:1ca:a861:3fbf with SMTP id s23-20020a17090a441700b001caa8613fbfmr8594395pjg.80.1652324809107;
        Wed, 11 May 2022 20:06:49 -0700 (PDT)
Received: from piliu.users.ipa.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id e13-20020aa7980d000000b0050dc762815bsm2488162pfl.53.2022.05.11.20.06.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 May 2022 20:06:48 -0700 (PDT)
From:   Pingfan Liu <kernelfans@gmail.com>
To:     linux-ia64@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Pingfan Liu <kernelfans@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Jens Axboe <axboe@kernel.dk>,
        Russell King <linux@armlinux.org.uk>,
        Guenter Roeck <linux@roeck-us.net>,
        Arnd Bergmann <arnd@arndb.de>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Lee Jones <lee.jones@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Collingbourne <pcc@google.com>,
        Marc Zyngier <maz@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCHv4 2/2] cpu/hotplug: Remove the input parameter primary_cpu of smp_shutdown_nonboot_cpus()
Date:   Thu, 12 May 2022 11:06:19 +0800
Message-Id: <20220512030619.13426-3-kernelfans@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220512030619.13426-1-kernelfans@gmail.com>
References: <20220512030619.13426-1-kernelfans@gmail.com>
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

For all call sites of smp_shutdown_nonboot_cpus(),

$git grep smp_shutdown_nonboot_cpus -- arch | grep -v \*
arch/arm/kernel/reboot.c:94:    smp_shutdown_nonboot_cpus(reboot_cpu);
arch/arm64/kernel/process.c:89: smp_shutdown_nonboot_cpus(reboot_cpu);
arch/ia64/kernel/process.c:578: smp_shutdown_nonboot_cpus(reboot_cpu);
arch/riscv/kernel/machine_kexec.c:135:  smp_shutdown_nonboot_cpus(smp_processor_id());

As it shows, the input parameter seems a little arbitrary.

Since kernel_kexec()->migrate_to_reboot_cpu() has already pinned the
rebooting thread on the selected CPU and the CPU hotplug keeps disabled
before smp_shutdown_nonboot_cpus(). Let smp_shutdown_nonboot_cpus()
deduce the rebooting CPU by smp_processor_id(), instead of passing the
parameter primary_cpu to it.

As a result, all call sites look consistent.

Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Kees Cook <keescook@chromium.org>
Cc: Jens Axboe <axboe@kernel.dk>
To: linux-ia64@vger.kernel.org
Cc: Russell King <linux@armlinux.org.uk>
Cc: Guenter Roeck <linux@roeck-us.net>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: Lee Jones <lee.jones@linaro.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Peter Collingbourne <pcc@google.com>
Cc: Marc Zyngier <maz@kernel.org>
To: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
---
 arch/arm/kernel/reboot.c          | 2 +-
 arch/arm64/kernel/process.c       | 2 +-
 arch/ia64/kernel/process.c        | 2 +-
 arch/riscv/kernel/machine_kexec.c | 2 +-
 include/linux/cpu.h               | 4 ++--
 kernel/cpu.c                      | 4 ++--
 6 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm/kernel/reboot.c b/arch/arm/kernel/reboot.c
index 3044fcb8d073..98c961f0b377 100644
--- a/arch/arm/kernel/reboot.c
+++ b/arch/arm/kernel/reboot.c
@@ -91,7 +91,7 @@ void soft_restart(unsigned long addr)
  */
 void machine_shutdown(void)
 {
-	smp_shutdown_nonboot_cpus(reboot_cpu);
+	smp_shutdown_nonboot_cpus();
 }
 
 /*
diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
index 7fa97df55e3a..1f6498d44740 100644
--- a/arch/arm64/kernel/process.c
+++ b/arch/arm64/kernel/process.c
@@ -86,7 +86,7 @@ void arch_cpu_idle_dead(void)
  */
 void machine_shutdown(void)
 {
-	smp_shutdown_nonboot_cpus(reboot_cpu);
+	smp_shutdown_nonboot_cpus();
 }
 
 /*
diff --git a/arch/ia64/kernel/process.c b/arch/ia64/kernel/process.c
index d7a256bd9d6b..9af53ff43983 100644
--- a/arch/ia64/kernel/process.c
+++ b/arch/ia64/kernel/process.c
@@ -575,7 +575,7 @@ cpu_halt (void)
 
 void machine_shutdown(void)
 {
-	smp_shutdown_nonboot_cpus(reboot_cpu);
+	smp_shutdown_nonboot_cpus();
 
 #ifdef CONFIG_KEXEC
 	kexec_disable_iosapic();
diff --git a/arch/riscv/kernel/machine_kexec.c b/arch/riscv/kernel/machine_kexec.c
index cbef0fc73afa..a30c545714cc 100644
--- a/arch/riscv/kernel/machine_kexec.c
+++ b/arch/riscv/kernel/machine_kexec.c
@@ -132,7 +132,7 @@ void machine_shutdown(void)
 	local_irq_disable();
 
 #if defined(CONFIG_HOTPLUG_CPU)
-	smp_shutdown_nonboot_cpus(smp_processor_id());
+	smp_shutdown_nonboot_cpus();
 #endif
 }
 
diff --git a/include/linux/cpu.h b/include/linux/cpu.h
index 54dc2f9a2d56..0506ba3ac85e 100644
--- a/include/linux/cpu.h
+++ b/include/linux/cpu.h
@@ -127,7 +127,7 @@ extern void cpu_hotplug_enable(void);
 void clear_tasks_mm_cpumask(int cpu);
 int remove_cpu(unsigned int cpu);
 int cpu_device_down(struct device *dev);
-extern void smp_shutdown_nonboot_cpus(unsigned int primary_cpu);
+extern void smp_shutdown_nonboot_cpus(void);
 
 #else /* CONFIG_HOTPLUG_CPU */
 
@@ -140,7 +140,7 @@ static inline void lockdep_assert_cpus_held(void) { }
 static inline void cpu_hotplug_disable(void) { }
 static inline void cpu_hotplug_enable(void) { }
 static inline int remove_cpu(unsigned int cpu) { return -EPERM; }
-static inline void smp_shutdown_nonboot_cpus(unsigned int primary_cpu) { }
+static inline void smp_shutdown_nonboot_cpus(void) { }
 #endif	/* !CONFIG_HOTPLUG_CPU */
 
 #ifdef CONFIG_PM_SLEEP_SMP
diff --git a/kernel/cpu.c b/kernel/cpu.c
index 4415370f0e91..66b8af6b8a3e 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -1228,7 +1228,7 @@ int remove_cpu(unsigned int cpu)
 }
 EXPORT_SYMBOL_GPL(remove_cpu);
 
-void smp_shutdown_nonboot_cpus(unsigned int primary_cpu)
+void smp_shutdown_nonboot_cpus(void)
 {
 	unsigned int cpu;
 	int error;
@@ -1244,7 +1244,7 @@ void smp_shutdown_nonboot_cpus(unsigned int primary_cpu)
 	__cpu_hotplug_enable();
 
 	for_each_online_cpu(cpu) {
-		if (cpu == primary_cpu)
+		if (cpu == smp_processor_id())
 			continue;
 
 		error = cpu_down_maps_locked(cpu, CPUHP_OFFLINE);
-- 
2.31.1

