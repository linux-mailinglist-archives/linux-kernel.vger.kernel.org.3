Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B1D056AE18
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 00:05:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236602AbiGGWFQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 18:05:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236730AbiGGWFG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 18:05:06 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D3312CC8A
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jul 2022 15:05:03 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id q9so28128975wrd.8
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jul 2022 15:05:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=conchuod.ie; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hjZHB/xWJ3nWli7ZfNwXsxb5s5FyrkVe3kCR2sto3MY=;
        b=YAksl8QG4Ad+/zsLgP3rFBKEVMf4C2+ycllCQpHkGjWiGmXMrv44Fa5DhcIcWd6OL0
         nSTFK6m5aqU3OdaAoJJlvx90zXqFH5x1SntHlfXOfmFM2szSOaT/cE4rNrCxUdQ0k/sb
         /MXyrA28CE+ypPlAWUYiPH/jh+0UZxSU6DqiijerAqCzqowZEABCeK7WJpCw83jCWrPN
         HOA9Wt1xlePu2vJNvPB59XhOaCfAaoCWjXki4pgl5sLkfmlFKReDiNi3ADDzQ/feC8+5
         CEFG1S2hd5Dk7O/gc4h/Ij2d+6Dp0wuaAqLn9hrf7s2FMU0JpxwUaKqg4II8nREXih3L
         4U8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hjZHB/xWJ3nWli7ZfNwXsxb5s5FyrkVe3kCR2sto3MY=;
        b=phKUZyr6zY4+r6HZCKfzuoL0Oyi/jT7Ju4Gc06xIaDflyswZ1zmOyZgvJNWAQ0i37Z
         G/S3rnQbdR7OND9rpeGcziEALkILwnscrs5Wgkr3/sS6GBNheO5Zs2iI5x9UcrAUDyWZ
         D37bdGIv4VE/FfOch2LHp4SlzM8ApA6czOrc21DCWAf4dewvp4jWhprAFT6z+knYBk2U
         sS1nEd+6nqmXnFAdLhBtcV5uphdZ9A4qZCX7AoNPrDx/hhHRMlQ7bCqQs6+vNXfuu2fP
         tWn+xmjNoV7CaAZ1fmu/iJnrQ2HIKsL4rSgUPnB/HOPOOQcya42nJ7w+APoIolfrgD1Q
         JKAw==
X-Gm-Message-State: AJIora+bCdxBPd95DncRTKMIGzKdv651et5kbs+1B50lpJR3Y6RgqIri
        bBXcbIobXRiw/Uky616oh3S0sg==
X-Google-Smtp-Source: AGRyM1ucM2HayA4Nu/4tlRlCtdGGmAk0G8SNuvQDYgL/iSBK+mKdFbxIG/Vfscu+gH+wgAlYNt1K1g==
X-Received: by 2002:adf:d206:0:b0:21d:6434:a158 with SMTP id j6-20020adfd206000000b0021d6434a158mr66682wrh.37.1657231501756;
        Thu, 07 Jul 2022 15:05:01 -0700 (PDT)
Received: from henark71.. ([51.37.234.167])
        by smtp.gmail.com with ESMTPSA id bn24-20020a056000061800b0020fe35aec4bsm38625743wrb.70.2022.07.07.15.04.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jul 2022 15:05:01 -0700 (PDT)
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
Subject: [RFC 3/4] riscv: arch-topology: move riscv to the generic store_cpu_topology()
Date:   Thu,  7 Jul 2022 23:04:36 +0100
Message-Id: <20220707220436.4105443-4-mail@conchuod.ie>
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

The default implementation of store_cpu_topology() is exactly that
used by RISC-V so revert the portions of aaaabbbbccccdddd ("riscv:
arch-topology: fix default topology reporting") which add the arch
specific version.

Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 arch/riscv/include/asm/topology.h | 13 -------------
 arch/riscv/kernel/Makefile        |  1 -
 arch/riscv/kernel/smpboot.c       |  1 -
 arch/riscv/kernel/topology.c      | 32 -------------------------------
 4 files changed, 47 deletions(-)
 delete mode 100644 arch/riscv/include/asm/topology.h
 delete mode 100644 arch/riscv/kernel/topology.c

diff --git a/arch/riscv/include/asm/topology.h b/arch/riscv/include/asm/topology.h
deleted file mode 100644
index 36bc6ecda898..000000000000
--- a/arch/riscv/include/asm/topology.h
+++ /dev/null
@@ -1,13 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-only */
-/*
- * Copyright (c) 2022 Microchip Technology Inc. and its subsidiaries
- */
-
-#ifndef _ASM_RISCV_TOPOLOGY_H
-#define _ASM_RISCV_TOPOLOGY_H
-
-#include <asm-generic/topology.h>
-
-void store_cpu_topology(unsigned int cpuid);
-
-#endif /* _ASM_RISCV_TOPOLOGY_H */
diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
index 9518882ba6f9..c71d6591d539 100644
--- a/arch/riscv/kernel/Makefile
+++ b/arch/riscv/kernel/Makefile
@@ -50,7 +50,6 @@ obj-y	+= riscv_ksyms.o
 obj-y	+= stacktrace.o
 obj-y	+= cacheinfo.o
 obj-y	+= patch.o
-obj-y	+= topology.o
 obj-y	+= probes/
 obj-$(CONFIG_MMU) += vdso.o vdso/
 
diff --git a/arch/riscv/kernel/smpboot.c b/arch/riscv/kernel/smpboot.c
index a8239b4b61f3..a1c861f84fe2 100644
--- a/arch/riscv/kernel/smpboot.c
+++ b/arch/riscv/kernel/smpboot.c
@@ -32,7 +32,6 @@
 #include <asm/sections.h>
 #include <asm/sbi.h>
 #include <asm/smp.h>
-#include <asm/topology.h>
 
 #include "head.h"
 
diff --git a/arch/riscv/kernel/topology.c b/arch/riscv/kernel/topology.c
deleted file mode 100644
index db72862bd5b5..000000000000
--- a/arch/riscv/kernel/topology.c
+++ /dev/null
@@ -1,32 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- * Copyright (c) 2022 Microchip Technology Inc. and its subsidiaries
- *
- * Based on the arm64 version, which was in turn based on arm32, which was
- * ultimately based on sh's.
- * The arm64 version was listed as:
- * Copyright (C) 2011,2013,2014 Linaro Limited.
- */
-
-#include <linux/arch_topology.h>
-#include <linux/topology.h>
-#include <asm/topology.h>
-
-void store_cpu_topology(unsigned int cpuid)
-{
-	struct cpu_topology *cpuid_topo = &cpu_topology[cpuid];
-
-	if (cpuid_topo->package_id != -1)
-		goto topology_populated;
-
-	cpuid_topo->thread_id = -1;
-	cpuid_topo->core_id = cpuid;
-	cpuid_topo->package_id = cpu_to_node(cpuid);
-
-	pr_debug("CPU%u: package %d core %d thread %d\n",
-		 cpuid, cpuid_topo->package_id, cpuid_topo->core_id,
-		 cpuid_topo->thread_id);
-
-topology_populated:
-	update_siblings_masks(cpuid);
-}
-- 
2.37.0

