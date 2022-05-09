Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0701151F37E
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 06:28:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232135AbiEIEZv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 00:25:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234349AbiEIER2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 00:17:28 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34FD088F66;
        Sun,  8 May 2022 21:13:36 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id j10-20020a17090a94ca00b001dd2131159aso762638pjw.0;
        Sun, 08 May 2022 21:13:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yvzilvcidt0cy/+jVulM8s/ugqFP0eQunNYQSTfNZQQ=;
        b=VZlRW/We3EYhQtPGSwiA+/E8SQ9csMkZggbJQP8bDq93RAzZfEkKLiToa0CrYo2R6b
         Bw9GHO8xdQXPauGeSSZShZ6AcW0osz6zXk11mNUkJ7Zr22PeMHXZRYXR1A0AUoKsFmIG
         WRcIwZLmoMapXgqfsjRadkRfgdZ994AOY3pKiQ/LhphFBkKpGHvzrqGyFFNzacgFcgv9
         uv40xCxir9ojG5hLanVpmtkP3lz5d+JtaVNDHwrsuyWt1ZCckRsmgry7staku/ADL/Bd
         515bJtdiGHxIpP1ShGIxCTpusBl39fvK2BUfdMfgXmJOsqCL5A1sEiJGAp9grbq7gYln
         faZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yvzilvcidt0cy/+jVulM8s/ugqFP0eQunNYQSTfNZQQ=;
        b=FmzlQAfzplFU6tEFtYamjR9pXEChRGC/yKJRkpZprGAJygwRPKe58iG13nFPRtD3/B
         ASTwy7SQv2HSCTEewVuhpGt/89E6oRdn+f9HPp362+0YVd332TDAH8NHGye/BQDCYYFJ
         eNIEa0xb59t/CDdf2nIzj5a68OCz0oaJiCJywV0u+jnygAHgUht2g1sYFdnIhY2Zf2jQ
         pNaaP0HQiZRB3ckrsUz7LbebgcQMsW43uMkNJLruLxXKYQNol4dR6Cl8XaXcl73xYAro
         IPPqoY/5DigP05TlXArx4d4F9XrUa1Thah/laOlcAXkjCGrDAHf/XjS8DilR5xv71OVT
         KZbw==
X-Gm-Message-State: AOAM5324V8Wl7PLeBcYjfdiHbUjTqBwrZPXi681uEvIbGPNyTHvDTHEr
        5eMST2xlL3OXdGNuVFmZ4hVRWSloQg==
X-Google-Smtp-Source: ABdhPJznFnzsSty9FB+peqx2+50gFD+ELmjTouVakza/raAO/f8MAY9hh3Kmuhr15ajevdFC9iJDXA==
X-Received: by 2002:a17:902:d487:b0:15e:a0a4:69e3 with SMTP id c7-20020a170902d48700b0015ea0a469e3mr14746513plg.155.1652069613718;
        Sun, 08 May 2022 21:13:33 -0700 (PDT)
Received: from piliu.users.ipa.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id m19-20020a17090a7f9300b001cd60246575sm11478545pjl.17.2022.05.08.21.13.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 May 2022 21:13:33 -0700 (PDT)
From:   Pingfan Liu <kernelfans@gmail.com>
To:     linux-ia64@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Pingfan Liu <kernelfans@gmail.com>,
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
Subject: [PATCHv3 2/2] arm/arm64/ia64: kexec: fix the primary cpu passed to smp_shutdown_nonboot_cpus()
Date:   Mon,  9 May 2022 12:13:05 +0800
Message-Id: <20220509041305.15056-3-kernelfans@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220509041305.15056-1-kernelfans@gmail.com>
References: <20220509041305.15056-1-kernelfans@gmail.com>
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

kernel_kexec()->migrate_to_reboot_cpu() has already pinned the reboot
thread on a valid online cpu, either reboot_cpu or the first online cpu.

So machine_shutdown() should pass smp_processor_id() of the pinned
thread as the primary cpu to smp_shutdown_nonboot_cpus().

Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
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
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Peter Collingbourne <pcc@google.com>
Cc: Marc Zyngier <maz@kernel.org>
To: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
---
 arch/arm/kernel/reboot.c    | 2 +-
 arch/arm64/kernel/process.c | 2 +-
 arch/ia64/kernel/process.c  | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/kernel/reboot.c b/arch/arm/kernel/reboot.c
index 3044fcb8d073..898405682e08 100644
--- a/arch/arm/kernel/reboot.c
+++ b/arch/arm/kernel/reboot.c
@@ -91,7 +91,7 @@ void soft_restart(unsigned long addr)
  */
 void machine_shutdown(void)
 {
-	smp_shutdown_nonboot_cpus(reboot_cpu);
+	smp_shutdown_nonboot_cpus(smp_processor_id());
 }
 
 /*
diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
index 7fa97df55e3a..e5c130582cc6 100644
--- a/arch/arm64/kernel/process.c
+++ b/arch/arm64/kernel/process.c
@@ -86,7 +86,7 @@ void arch_cpu_idle_dead(void)
  */
 void machine_shutdown(void)
 {
-	smp_shutdown_nonboot_cpus(reboot_cpu);
+	smp_shutdown_nonboot_cpus(smp_processor_id());
 }
 
 /*
diff --git a/arch/ia64/kernel/process.c b/arch/ia64/kernel/process.c
index d7a256bd9d6b..ae732e35e7da 100644
--- a/arch/ia64/kernel/process.c
+++ b/arch/ia64/kernel/process.c
@@ -575,7 +575,7 @@ cpu_halt (void)
 
 void machine_shutdown(void)
 {
-	smp_shutdown_nonboot_cpus(reboot_cpu);
+	smp_shutdown_nonboot_cpus(smp_processor_id());
 
 #ifdef CONFIG_KEXEC
 	kexec_disable_iosapic();
-- 
2.31.1

