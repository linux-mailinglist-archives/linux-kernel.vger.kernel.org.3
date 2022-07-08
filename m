Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E421956C244
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 01:12:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240255AbiGHUee (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 16:34:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240258AbiGHUeN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 16:34:13 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 067E89FE39
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jul 2022 13:33:57 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id n10so6662320wrc.4
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jul 2022 13:33:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=conchuod.ie; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3esZkwVy613d0mnGZgND5AwNK9S9FQGfuQwBw22Whgs=;
        b=LkdUJp8NQYuFnVjXuy40IWe/u/nUF1iLbAgQ8kwt1DzSjr8TjfY8OK6w5l4+RjAXpk
         iGEmip0XDsX5gphRrNhPKMRPlkxlJqghGpZhzZudw+mX4vXVSW5nv+HF7n2HqosjpiNM
         YonBlNbVJGWEEjJWl6z8/W4YIUcSFU7ulSKNbE74naVf2Y99F3CuefQwEjYmdXe9v9b0
         fYmg1JHhBwoNkaQ/eVpAo2iok0Zha85+oVM3BYxDZ5uGjFwyUdRev9zn8IzWlbt8z6Ob
         Wtcv+QL+5yfEOCJSycnUNxWqTVOR4k8tyJi4/8LzdW7E9wG4na7ntkHzNCS6Ybym50G0
         kWEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3esZkwVy613d0mnGZgND5AwNK9S9FQGfuQwBw22Whgs=;
        b=Fdi9GcEjo4gVk5ti1ysR0kRPWZIQ+aGxbVvw9SJSA9mEXrprlZf7F6BLqI9Q8obLYC
         sU/4t15I59ACPPJfxWAFzeBq1YjCztJ1DG2Khw4LgPUJj9JAHVPud3Y06L0qGMGTD6tD
         ngbuqiCTzBOuD/vuR2MYvxaDr8ukigWAVemn+6imHEBDLLu24ea++tmfceFxzxuZkRCG
         4v+DH2QM4RmERKVXo+xpcqeiqGTSyvUvzVPYj/bK++pM6c8Ev5TWHrmnk7H0zkpi+b22
         y2Tv6XB2gtmTkJil/tESDOckndvqWvfUJpTDs6gUfrMYobvI4/c4SQxYkE4K9SPgOWO6
         UybQ==
X-Gm-Message-State: AJIora8KwawsdcVG/gOSBYUDsGqfJ/wyYi1S2p68UTlh3/dcYaECGSCF
        XmRkLSGgxVKJmZ562wwRLzRORQ==
X-Google-Smtp-Source: AGRyM1so5vGVqM4+gNIz7n/aN1RHiJ4Q1lPp5fkyRoMDo9JFFCW9Qz/vji4dAeXxwm+HNa/iGx/gUA==
X-Received: by 2002:a05:6000:18d:b0:21b:901e:9b27 with SMTP id p13-20020a056000018d00b0021b901e9b27mr5062706wrx.389.1657312435597;
        Fri, 08 Jul 2022 13:33:55 -0700 (PDT)
Received: from henark71.. ([51.37.234.167])
        by smtp.gmail.com with ESMTPSA id a3-20020a1cf003000000b0039c8a22554bsm3165034wmb.27.2022.07.08.13.33.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jul 2022 13:33:54 -0700 (PDT)
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
Subject: [PATCH v2 1/2] arm64: topology: move store_cpu_topology() to shared code
Date:   Fri,  8 Jul 2022 21:33:42 +0100
Message-Id: <20220708203342.256459-2-mail@conchuod.ie>
X-Mailer: git-send-email 2.37.0
In-Reply-To: <20220708203342.256459-1-mail@conchuod.ie>
References: <20220708203342.256459-1-mail@conchuod.ie>
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

arm64's method of defining a default cpu topology requires only minimal
changes to apply to RISC-V also. The current arm64 implementation exits
early in a uniprocessor configuration by reading MPIDR & claiming that
uniprocessor can rely on the default values.

This is appears to be a hangover from prior to '3102bc0e6ac7 ("arm64:
topology: Stop using MPIDR for topology information")', because the
current code just assigns default values for multiprocessor systems.

With the MPIDR references removed, store_cpu_topolgy() can be moved to
the common arch_topology code.

CC: stable@vger.kernel.org
Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 arch/arm64/kernel/topology.c | 40 ------------------------------------
 drivers/base/arch_topology.c | 19 +++++++++++++++++
 2 files changed, 19 insertions(+), 40 deletions(-)

diff --git a/arch/arm64/kernel/topology.c b/arch/arm64/kernel/topology.c
index 869ffc4d4484..7889a00f5487 100644
--- a/arch/arm64/kernel/topology.c
+++ b/arch/arm64/kernel/topology.c
@@ -22,46 +22,6 @@
 #include <asm/cputype.h>
 #include <asm/topology.h>
 
-void store_cpu_topology(unsigned int cpuid)
-{
-	struct cpu_topology *cpuid_topo = &cpu_topology[cpuid];
-	u64 mpidr;
-
-	if (cpuid_topo->package_id != -1)
-		goto topology_populated;
-
-	mpidr = read_cpuid_mpidr();
-
-	/* Uniprocessor systems can rely on default topology values */
-	if (mpidr & MPIDR_UP_BITMASK)
-		return;
-
-	/*
-	 * This would be the place to create cpu topology based on MPIDR.
-	 *
-	 * However, it cannot be trusted to depict the actual topology; some
-	 * pieces of the architecture enforce an artificial cap on Aff0 values
-	 * (e.g. GICv3's ICC_SGI1R_EL1 limits it to 15), leading to an
-	 * artificial cycling of Aff1, Aff2 and Aff3 values. IOW, these end up
-	 * having absolutely no relationship to the actual underlying system
-	 * topology, and cannot be reasonably used as core / package ID.
-	 *
-	 * If the MT bit is set, Aff0 *could* be used to define a thread ID, but
-	 * we still wouldn't be able to obtain a sane core ID. This means we
-	 * need to entirely ignore MPIDR for any topology deduction.
-	 */
-	cpuid_topo->thread_id  = -1;
-	cpuid_topo->core_id    = cpuid;
-	cpuid_topo->package_id = cpu_to_node(cpuid);
-
-	pr_debug("CPU%u: cluster %d core %d thread %d mpidr %#016llx\n",
-		 cpuid, cpuid_topo->package_id, cpuid_topo->core_id,
-		 cpuid_topo->thread_id, mpidr);
-
-topology_populated:
-	update_siblings_masks(cpuid);
-}
-
 #ifdef CONFIG_ACPI
 static bool __init acpi_cpu_is_threaded(int cpu)
 {
diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
index 441e14ac33a4..07e84c6ac5c2 100644
--- a/drivers/base/arch_topology.c
+++ b/drivers/base/arch_topology.c
@@ -765,6 +765,25 @@ void update_siblings_masks(unsigned int cpuid)
 	}
 }
 
+void __weak store_cpu_topology(unsigned int cpuid)
+{
+	struct cpu_topology *cpuid_topo = &cpu_topology[cpuid];
+
+	if (cpuid_topo->package_id != -1)
+		goto topology_populated;
+
+	cpuid_topo->thread_id = -1;
+	cpuid_topo->core_id = cpuid;
+	cpuid_topo->package_id = cpu_to_node(cpuid);
+
+	pr_debug("CPU%u: package %d core %d thread %d\n",
+		 cpuid, cpuid_topo->package_id, cpuid_topo->core_id,
+		 cpuid_topo->thread_id);
+
+topology_populated:
+	update_siblings_masks(cpuid);
+}
+
 static void clear_cpu_topology(int cpu)
 {
 	struct cpu_topology *cpu_topo = &cpu_topology[cpu];
-- 
2.37.0

