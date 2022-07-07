Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E262856AE14
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 00:05:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236791AbiGGWFM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 18:05:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236732AbiGGWFG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 18:05:06 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D9172DAB4
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jul 2022 15:05:04 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id l68so11422485wml.3
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jul 2022 15:05:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=conchuod.ie; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bzkzOE355hqIqljAM5HpDyXsSE0Xgb88DMeaRs7oG5A=;
        b=CFw2+uM+g57y3O9S+BDDURXZpzm9TZdcD9w6aL1Q9BBp/mVgPJmSASYxpP46ODI+6+
         PgecRsuYskGLfb7pWQW18Rujt/ybeSrNqS2YyYXjL3PGfbJRSv6K1lZvtZs0Ew1awjCa
         tVi1UlnKshb0eP3bQ2It6U0uotgqO1ULv83499xyeDvhineaEnJgXRPaQ5XOSDgJfCNW
         EYUOjSmyeNrhenndSIkT/LnOYLFrW9I93HhO6uvHc07xdx91/7VKhz/YRjw17AIp5dCS
         c/EM+eOKzdPqPxP39Ifo1M7TWu6prFO7raXxXu/h7XuyKFrTAY4/OjwkNGwG2Mu9aQ1G
         gADA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bzkzOE355hqIqljAM5HpDyXsSE0Xgb88DMeaRs7oG5A=;
        b=dlQNbDmHdOhRGQddzku6jKB9c/kzJgyNoRYIJ+asodbLj5sfOeHbj96p+ctiew5Wyb
         dqNaP1xOebLW34Hjzd53DEtdfpsSrWYFnhhOCI37/Vdp/uAJ7yWmEDc6RZaayuKnX+PE
         HK2Kd0fzcl2ah4rz693tZk6Uq1lf8oEj1+GIHKFJ4EPifVIPvPuh6ofU0abkrgdDJGpT
         Qc0CsNO8JlxkMji+wmA+OBzAvkXTzByFP82yFnDWQ5SCibqB7kCXSIcS9n4p9BK/+P9J
         lSypCE5qPQ0woQBrdsjgsL1Ug6rDMHpuiCqcXmgenbwjhu43yVR8MnPzvRY18IyfCyvj
         bkYw==
X-Gm-Message-State: AJIora9n2ORL0wYVCIIkvFTPWHP4HvtOOoUbEQAkXxAQOCd5o2JBDUmy
        XrHm+ddpsRPQrlEkuT1bNG6tWw==
X-Google-Smtp-Source: AGRyM1tLaiEFk5UPNSD3yHAf3ofk6myCgCJqlLCWLDoubSbnhyUqfAR/rUMStUtSYmUvTHShFmNKCw==
X-Received: by 2002:a05:600c:601d:b0:3a1:a02e:872a with SMTP id az29-20020a05600c601d00b003a1a02e872amr14268wmb.3.1657231503662;
        Thu, 07 Jul 2022 15:05:03 -0700 (PDT)
Received: from henark71.. ([51.37.234.167])
        by smtp.gmail.com with ESMTPSA id bn24-20020a056000061800b0020fe35aec4bsm38625743wrb.70.2022.07.07.15.05.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jul 2022 15:05:02 -0700 (PDT)
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
        Changbin Du <changbin.du@intel.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Philipp Tomsich <philipp.tomsich@vrull.eu>,
        Rob Herring <robh@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Brice Goglin <Brice.Goglin@inria.fr>
Subject: [RFC 4/4] arm64: arch-topology move arm64 to the generic store_cpu_topology()
Date:   Thu,  7 Jul 2022 23:04:37 +0100
Message-Id: <20220707220436.4105443-5-mail@conchuod.ie>
X-Mailer: git-send-email 2.37.0
In-Reply-To: <20220707220436.4105443-1-mail@conchuod.ie>
References: <20220707220436.4105443-1-mail@conchuod.ie>
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

The default implementation of store_cpu_topology() was derived from the
arm64 implementation, but with the mpidr bits removed. Extract the mpidr
bits from the arch implementation to the callsites & use the generic
version.

Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 arch/arm64/kernel/smp.c      | 16 +++++++++++++--
 arch/arm64/kernel/topology.c | 40 ------------------------------------
 2 files changed, 14 insertions(+), 42 deletions(-)

diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
index 62ed361a4376..9e8acaa4c2f7 100644
--- a/arch/arm64/kernel/smp.c
+++ b/arch/arm64/kernel/smp.c
@@ -234,7 +234,12 @@ asmlinkage notrace void secondary_start_kernel(void)
 	 * Log the CPU info before it is marked online and might get read.
 	 */
 	cpuinfo_store_cpu();
-	store_cpu_topology(cpu);
+
+	/*
+	 * Uniprocessor systems can rely on default topology values
+	 */
+	if (!(mpidr & MPIDR_UP_BITMASK))
+		store_cpu_topology(cpu);
 
 	/*
 	 * Enable GIC and timers.
@@ -719,6 +724,7 @@ void __init smp_init_cpus(void)
 void __init smp_prepare_cpus(unsigned int max_cpus)
 {
 	const struct cpu_operations *ops;
+	u64 mpidr;
 	int err;
 	unsigned int cpu;
 	unsigned int this_cpu;
@@ -726,7 +732,13 @@ void __init smp_prepare_cpus(unsigned int max_cpus)
 	init_cpu_topology();
 
 	this_cpu = smp_processor_id();
-	store_cpu_topology(this_cpu);
+	mpidr = read_cpuid_mpidr();
+
+	/*
+	 * Uniprocessor systems can rely on default topology values
+	 */
+	if (!(mpidr & MPIDR_UP_BITMASK))
+		store_cpu_topology(this_cpu);
 	numa_store_cpu_info(this_cpu);
 	numa_add_cpu(this_cpu);
 
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
-- 
2.37.0

