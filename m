Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BD38576665
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 19:54:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229817AbiGORyF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 13:54:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbiGORxq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 13:53:46 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 371332678
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 10:53:41 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id h14-20020a1ccc0e000000b0039eff745c53so3476468wmb.5
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 10:53:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=conchuod.ie; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TI7+rhWBkGbatNs0vcGExprAw/dMIZ8+GzDCKOj9Sjs=;
        b=RgCkQ22+lKhSv5UsZqETHaBjszzbB5eZRyH3n6fwC/Jj2lw75DYoUeo+aViZw/SvZg
         h9OJO8RN4xqEBgYi9eveVVYu/bzADw3b2JbKd5r/FKXz2GQI60hPuiyH7NZNu13t739x
         Kv2KQDxz0jNyNCrT3uEGpQ+gFSO8d0SgakZhK7ifXNOAQ/rk7nOt5KFatwJThxiUWWJO
         E14uh7FSnos+EN/l8GNBYtX23RweEVhtkrqp2aGbwVFqi4d+cfQEogYGUCKKc0QBVQPm
         tNsRg+8vigIs2MirGKEXFTSKr4KRfNC6C+a1+r92yl3tibDAelNN/WoU4kwmJ37yZ37/
         y68w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TI7+rhWBkGbatNs0vcGExprAw/dMIZ8+GzDCKOj9Sjs=;
        b=YDkuqgAxjouSoCGa21PaDbK2dEcPbYL4dpd/TnQK3PH4185B93eZRQrJPqE7VqkfLl
         OeVAajcjTvo+QFtTSmkI0CFSShQ41FDC3OUhS2d8elVM+yunFiv/pny98QIS9qgMOs1O
         IXrBUkLLjQcwicTfar8sspXd1h3HcJeyCaIb20OdFe8Gq7RMouH1ggAKdrXtu4fSHrFy
         G6dCEf4xVvXuLFIg2vsWQ/ZpTe1UpqPbNuPKPJjPRykirT3N58dHDtgG68vcyAVIw9yf
         j6raI2NqwQqPZpp+6Ho5pJNcb47fcsi7TGZ8WmVeLmR+kRpGplSDsb0DXfg+SIRPf4F3
         7g7A==
X-Gm-Message-State: AJIora8UpRUs5DaSQCz+jGtiISp+/Nm59p9ftVQbTUVITkrnsVX+VDCh
        eiwf3TksEsEoYUBBY6GRMX52pQ==
X-Google-Smtp-Source: AGRyM1v16C+sTtH7uzq4xXTnOT9ZFNxBc0KIM/kiFyQv3Pr4mNsCyT2217B/fiLmVgaLmHeEMPlI2A==
X-Received: by 2002:a05:600c:3491:b0:3a0:4d4a:2e2d with SMTP id a17-20020a05600c349100b003a04d4a2e2dmr22285077wmq.4.1657907619894;
        Fri, 15 Jul 2022 10:53:39 -0700 (PDT)
Received: from henark71.. ([51.37.234.167])
        by smtp.gmail.com with ESMTPSA id n9-20020a5d4c49000000b002167efdd549sm4364131wrt.38.2022.07.15.10.53.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jul 2022 10:53:39 -0700 (PDT)
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
Subject: [PATCH v4 1/2] arm64: topology: move store_cpu_topology() to shared code
Date:   Fri, 15 Jul 2022 18:51:55 +0100
Message-Id: <20220715175155.3567243-2-mail@conchuod.ie>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220715175155.3567243-1-mail@conchuod.ie>
References: <20220715175155.3567243-1-mail@conchuod.ie>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
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
index 0424b59b695e..0e2c6b30dd69 100644
--- a/drivers/base/arch_topology.c
+++ b/drivers/base/arch_topology.c
@@ -841,4 +841,23 @@ void __init init_cpu_topology(void)
 		return;
 	}
 }
+
+void store_cpu_topology(unsigned int cpuid)
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
 #endif
-- 
2.37.1

