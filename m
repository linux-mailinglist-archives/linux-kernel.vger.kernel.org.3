Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D65256CA55
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 17:25:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229567AbiGIPYx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Jul 2022 11:24:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbiGIPYp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jul 2022 11:24:45 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C26C713E88
        for <linux-kernel@vger.kernel.org>; Sat,  9 Jul 2022 08:24:43 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id v14so1859152wra.5
        for <linux-kernel@vger.kernel.org>; Sat, 09 Jul 2022 08:24:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=conchuod.ie; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=e7OziW02Y/9peL0FmHLT2XkVqPVR8DGTtiJWYX8th9g=;
        b=ECZOuvVPNJv4pwuzvrO842PwGYJwOVKmO+ePMzvMb2kiTRVtLSAGqq0e8HvKfnAoev
         XwWbnXBDPV7oUrxaHTMMCTA7ZrD3zrxzMKO3H43E3lHT8OiWHNMJahLSJ2aQpJKNnkxz
         DR7dBbK/xncoYRSghBvFnBFDf7pd1eFaR+Dq+r2peG656ErDx+tqLFcZHxyjrV1TVvOR
         JMe0VByofu+6AGcXSNmPaB3ZHm0n+/koQ98BaXg9Pnm3gpnt3Tx4PbplmbCw4rd8Pl7S
         rsgZrPPV825g3ar4sbMq9eDFKlj/mFEMjRm4PxtZD0jeW5r33d32r2r9X6r9YGTEg5nM
         lU/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=e7OziW02Y/9peL0FmHLT2XkVqPVR8DGTtiJWYX8th9g=;
        b=P4kaFxzFJZ7GEUKc7gG8/nWg+POKTRHpoFczZgEai+Di3LRtvkrL76BLih8s7IPExU
         uXfGVanQ41icEtUaTsXhl4m/ctkTcMlM4w2c7WsJhchBXUzwpkWTYz/ObAa+x3BdFt7Y
         01nTYejdt3Ok406Gf9wctLlVgLsUmdP0PgbFt1ng4OrDSgPonbhN1u85ltVHXolKiqYJ
         S4roStI7Bo0vNjjSiRQFcOwraVt91OqqVRx3qCPNN4mE0GfJ2r1aivucq6LxMrWAcl14
         ZkAD1/DrpBEElCze2IMqU4UjNMLwHyNUWr6LoLcXDxKYRF+R/me2jO4D2ffCaDHpblE0
         cLlg==
X-Gm-Message-State: AJIora9yeNlHGHszVKL5x7jfX9vhR9UxOkMOSf3oLEkLjUGoui4i8Z2N
        TN42XSWAKnS5cYOEl9yOd30ajQ==
X-Google-Smtp-Source: AGRyM1sTW2QGHBhqujHGrijOa1mBvsISG5gFuOmbHCFky2pxJAj8MH78/S0Xmj+pnEx/aUFb6oMnnQ==
X-Received: by 2002:a5d:6a01:0:b0:21a:338c:4862 with SMTP id m1-20020a5d6a01000000b0021a338c4862mr8262063wru.631.1657380282203;
        Sat, 09 Jul 2022 08:24:42 -0700 (PDT)
Received: from henark71.. ([51.37.234.167])
        by smtp.gmail.com with ESMTPSA id y12-20020a5d620c000000b0021d63fe0f03sm1626730wru.12.2022.07.09.08.24.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Jul 2022 08:24:41 -0700 (PDT)
From:   Conor Dooley <mail@conchuod.ie>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>
Cc:     Daire McNamara <daire.mcnamara@microchip.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Niklas Cassel <niklas.cassel@wdc.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Zong Li <zong.li@sifive.com>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Jonas Hahnfeld <hahnjo@hahnjo.de>, Guo Ren <guoren@kernel.org>,
        Anup Patel <anup@brainfault.org>,
        Atish Patra <atishp@atishpatra.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Philipp Tomsich <philipp.tomsich@vrull.eu>,
        Rob Herring <robh@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Brice Goglin <Brice.Goglin@inria.fr>
Subject: [PATCH v3 2/2] riscv: topology: fix default topology reporting
Date:   Sat,  9 Jul 2022 16:23:55 +0100
Message-Id: <20220709152354.2856586-3-mail@conchuod.ie>
X-Mailer: git-send-email 2.37.0
In-Reply-To: <20220709152354.2856586-1-mail@conchuod.ie>
References: <20220709152354.2856586-1-mail@conchuod.ie>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Conor Dooley <conor.dooley@microchip.com>

RISC-V has no sane defaults to fall back on where there is no cpu-map
in the devicetree.
Without sane defaults, the package, core and thread IDs are all set to
-1. This causes user-visible inaccuracies for tools like hwloc/lstopo
which rely on the sysfs cpu topology files to detect a system's
topology.

On a PolarFire SoC, which should have 4 harts with a thread each,
lstopo currently reports:

Machine (793MB total)
  Package L#0
    NUMANode L#0 (P#0 793MB)
    Core L#0
      L1d L#0 (32KB) + L1i L#0 (32KB) + PU L#0 (P#0)
      L1d L#1 (32KB) + L1i L#1 (32KB) + PU L#1 (P#1)
      L1d L#2 (32KB) + L1i L#2 (32KB) + PU L#2 (P#2)
      L1d L#3 (32KB) + L1i L#3 (32KB) + PU L#3 (P#3)

Adding calls to store_cpu_topology() in {boot,smp} hart bringup code
results in the correct topolgy being reported:

Machine (793MB total)
  Package L#0
    NUMANode L#0 (P#0 793MB)
    L1d L#0 (32KB) + L1i L#0 (32KB) + Core L#0 + PU L#0 (P#0)
    L1d L#1 (32KB) + L1i L#1 (32KB) + Core L#1 + PU L#1 (P#1)
    L1d L#2 (32KB) + L1i L#2 (32KB) + Core L#2 + PU L#2 (P#2)
    L1d L#3 (32KB) + L1i L#3 (32KB) + Core L#3 + PU L#3 (P#3)

CC: stable@vger.kernel.org
Fixes: 03f11f03dbfe ("RISC-V: Parse cpu topology during boot.")
Reported-by: Brice Goglin <Brice.Goglin@inria.fr>
Link: https://github.com/open-mpi/hwloc/issues/536
Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
---
 arch/riscv/Kconfig          | 2 +-
 arch/riscv/kernel/smpboot.c | 4 +++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 2af0701b7518..4b6c2fdbb57c 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -52,7 +52,7 @@ config RISCV
 	select COMMON_CLK
 	select CPU_PM if CPU_IDLE
 	select EDAC_SUPPORT
-	select GENERIC_ARCH_TOPOLOGY if SMP
+	select GENERIC_ARCH_TOPOLOGY
 	select GENERIC_ATOMIC64 if !64BIT
 	select GENERIC_CLOCKEVENTS_BROADCAST if SMP
 	select GENERIC_EARLY_IOREMAP
diff --git a/arch/riscv/kernel/smpboot.c b/arch/riscv/kernel/smpboot.c
index f1e4948a4b52..a1c861f84fe2 100644
--- a/arch/riscv/kernel/smpboot.c
+++ b/arch/riscv/kernel/smpboot.c
@@ -40,6 +40,8 @@ static DECLARE_COMPLETION(cpu_running);
 void __init smp_prepare_boot_cpu(void)
 {
 	init_cpu_topology();
+
+	store_cpu_topology(smp_processor_id());
 }
 
 void __init smp_prepare_cpus(unsigned int max_cpus)
@@ -161,9 +163,9 @@ asmlinkage __visible void smp_callin(void)
 	mmgrab(mm);
 	current->active_mm = mm;
 
+	store_cpu_topology(curr_cpuid);
 	notify_cpu_starting(curr_cpuid);
 	numa_add_cpu(curr_cpuid);
-	update_siblings_masks(curr_cpuid);
 	set_cpu_online(curr_cpuid, 1);
 
 	/*
-- 
2.37.0

