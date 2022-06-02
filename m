Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDB5953B1B7
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 04:50:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233298AbiFBCVP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 22:21:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233288AbiFBCVO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 22:21:14 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF32C26A90C
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 19:21:11 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id 7so2730878pga.12
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jun 2022 19:21:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GG12pRWYpCMhzTmvdu+AwDhBRPq3Mk8LSZ48yQuCcmg=;
        b=LbojSCdMywwboJsHvQBCV5gloK38NF3e45HPu/lbWImG7XctvRZbulCzhPCX0vDVfF
         7D5qg+qbh4OopNyx2h474m7+zYbil/P93rcOf4x5/U4K8/IQdtEV+U3vicJCJuY0hV8v
         SIzsmtEKrEtbUgmwdzaTytHMHhVSZHfj/n9uM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GG12pRWYpCMhzTmvdu+AwDhBRPq3Mk8LSZ48yQuCcmg=;
        b=h+Xeej5Z8KxgGFmnT5G0MuSu24HwC6ZirUuk2IVCuhrMYA34E5/i4KdROBRABzKnfB
         JJsz/9NjeGDZsqZ8mfYpT84Mws1RTaNgbiFTkco8ilyYZWGW7CwYDoHafCrXA7CQQ3H5
         V0tEa3gM/v/SWlepqx1f8AQC7ukFwWLkUSh8Bmye+1n4dUdMWYharE3PldOQOLvwEiEd
         +smwE9C6jJu7cl1BkfuPfOw15wOpVAQM2eLOqs3S5TwT550ZQ4VdDm/HKDOiDXb2S3uk
         /Rxv7XqpiR8UemTR4v5g1JM1XNbbx9u8G+iUEvNsQJYFMe4XDvte4iJ7nPIwZbtaWpKB
         XA1w==
X-Gm-Message-State: AOAM531RMXIpR1qjuBWhgXiJ1hk12mpwFjJefVoTGGT3WA5/UM0aW3sS
        9+i6p7yvsQYadq75VwJn4Bmqa9P+0BIOQA==
X-Google-Smtp-Source: ABdhPJzQAc7yvw8IedDY62s8gx/hzC1m4lhhsL8fO37xa12t5NllgzfENMY9KSnYKyYm/DhztZJw6Q==
X-Received: by 2002:a05:6a00:10cc:b0:505:ada6:e03e with SMTP id d12-20020a056a0010cc00b00505ada6e03emr2569824pfu.45.1654136471309;
        Wed, 01 Jun 2022 19:21:11 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:201:6885:8b62:3875:9d55])
        by smtp.gmail.com with ESMTPSA id d9-20020a170902cec900b0016378bfeb90sm2181299plg.227.2022.06.01.19.21.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jun 2022 19:21:10 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        "Jason A . Donenfeld" <Jason@zx2c4.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>
Subject: [PATCH] arm64: Initialize jump labels before setup_machine_fdt()
Date:   Wed,  1 Jun 2022 19:21:09 -0700
Message-Id: <20220602022109.780348-1-swboyd@chromium.org>
X-Mailer: git-send-email 2.36.1.255.ge46751e96f-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A static key warning splat appears during early boot on arm64 systems
that credit randomness from devicetrees that contain an "rng-seed"
property. This is because setup_machine_fdt() is called before
jump_label_init() during setup_arch(). Let's swap the order of these two
calls so that jump labels are initialized before the devicetree is
unflattened and the rng seed is credited.

 static_key_enable_cpuslocked(): static key '0xffffffe51c6fcfc0' used before call to jump_label_init()
 WARNING: CPU: 0 PID: 0 at kernel/jump_label.c:166 static_key_enable_cpuslocked+0xb0/0xb8
 Modules linked in:
 CPU: 0 PID: 0 Comm: swapper Not tainted 5.18.0+ #224 44b43e377bfc84bc99bb5ab885ff694984ee09ff
 pstate: 600001c9 (nZCv dAIF -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
 pc : static_key_enable_cpuslocked+0xb0/0xb8
 lr : static_key_enable_cpuslocked+0xb0/0xb8
 sp : ffffffe51c393cf0
 x29: ffffffe51c393cf0 x28: 000000008185054c x27: 00000000f1042f10
 x26: 0000000000000000 x25: 00000000f10302b2 x24: 0000002513200000
 x23: 0000002513200000 x22: ffffffe51c1c9000 x21: fffffffdfdc00000
 x20: ffffffe51c2f0831 x19: ffffffe51c6fcfc0 x18: 00000000ffff1020
 x17: 00000000e1e2ac90 x16: 00000000000000e0 x15: ffffffe51b710708
 x14: 0000000000000066 x13: 0000000000000018 x12: 0000000000000000
 x11: 0000000000000000 x10: 00000000ffffffff x9 : 0000000000000000
 x8 : 0000000000000000 x7 : 61632065726f6665 x6 : 6220646573752027
 x5 : ffffffe51c641d25 x4 : ffffffe51c13142c x3 : ffff0a00ffffff05
 x2 : 40000000ffffe003 x1 : 00000000000001c0 x0 : 0000000000000065
 Call trace:
  static_key_enable_cpuslocked+0xb0/0xb8
  static_key_enable+0x2c/0x40
  crng_set_ready+0x24/0x30
  execute_in_process_context+0x80/0x90
  _credit_init_bits+0x100/0x154
  add_bootloader_randomness+0x64/0x78
  early_init_dt_scan_chosen+0x140/0x184
  early_init_dt_scan_nodes+0x28/0x4c
  early_init_dt_scan+0x40/0x44
  setup_machine_fdt+0x7c/0x120
  setup_arch+0x74/0x1d8
  start_kernel+0x84/0x44c
  __primary_switched+0xc0/0xc8
 ---[ end trace 0000000000000000 ]---
 random: crng init done
 Machine model: Google Lazor (rev1 - 2) with LTE

Cc: Hsin-Yi Wang <hsinyi@chromium.org>
Cc: Douglas Anderson <dianders@chromium.org>
Cc: Ard Biesheuvel <ardb@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Jason A. Donenfeld <Jason@zx2c4.com>
Cc: Dominik Brodowski <linux@dominikbrodowski.net>
Fixes: f5bda35fba61 ("random: use static branch for crng_ready()")
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 arch/arm64/kernel/setup.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
index fea3223704b6..cf3a759f10d4 100644
--- a/arch/arm64/kernel/setup.c
+++ b/arch/arm64/kernel/setup.c
@@ -303,13 +303,14 @@ void __init __no_sanitize_address setup_arch(char **cmdline_p)
 	early_fixmap_init();
 	early_ioremap_init();
 
-	setup_machine_fdt(__fdt_pointer);
-
 	/*
 	 * Initialise the static keys early as they may be enabled by the
-	 * cpufeature code and early parameters.
+	 * cpufeature code, early parameters, and DT setup.
 	 */
 	jump_label_init();
+
+	setup_machine_fdt(__fdt_pointer);
+
 	parse_early_param();
 
 	/*
-- 
https://chromeos.dev

