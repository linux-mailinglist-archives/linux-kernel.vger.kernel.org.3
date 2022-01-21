Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED2A54962EF
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 17:37:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351498AbiAUQhO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 11:37:14 -0500
Received: from gloria.sntech.de ([185.11.138.130]:35248 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1349264AbiAUQhF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 11:37:05 -0500
Received: from p508fcef5.dip0.t-ipconnect.de ([80.143.206.245] helo=phil.fritz.box)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1nAwuM-0008GA-Vw; Fri, 21 Jan 2022 17:37:03 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     palmer@dabbelt.com, paul.walmsley@sifive.com, aou@eecs.berkeley.edu
Cc:     linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org, wefu@redhat.com,
        liush@allwinnertech.com, guoren@kernel.org, atishp@atishpatra.org,
        anup@brainfault.org, drew@beagleboard.org, hch@lst.de,
        arnd@arndb.de, wens@csie.org, maxime@cerno.tech,
        dlustig@nvidia.com, gfavor@ventanamicro.com,
        andrea.mondelli@huawei.com, behrensj@mit.edu, xinhaoqu@huawei.com,
        huffman@cadence.com, mick@ics.forth.gr,
        allen.baum@esperantotech.com, jscheid@ventanamicro.com,
        rtrauben@gmail.com, samuel@sholland.org, cmuellner@linux.com,
        philipp.tomsich@vrull.eu, Heiko Stuebner <heiko@sntech.de>
Subject: [PATCH v5 08/14] riscv: move boot alternatives to a slightly earlier position
Date:   Fri, 21 Jan 2022 17:36:12 +0100
Message-Id: <20220121163618.351934-9-heiko@sntech.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220121163618.351934-1-heiko@sntech.de>
References: <20220121163618.351934-1-heiko@sntech.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the application of boot alternatives to soc_early_init().
This allows to catch more generic cases of code needing patches
than doing it in smp_prepare_boot_cpu() and also makes it actually
work if CONFIG_SMP is disabled for whatever reason.

The position is chosen mainly as it is before the actual soc early
init runs but also already allows accessing the devicetree
via fdt_* functions.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/riscv/kernel/head.S    | 2 ++
 arch/riscv/kernel/smpboot.c | 2 --
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/kernel/head.S b/arch/riscv/kernel/head.S
index db062279d9ed..432fe7b3f897 100644
--- a/arch/riscv/kernel/head.S
+++ b/arch/riscv/kernel/head.S
@@ -10,6 +10,7 @@
 #include <asm/thread_info.h>
 #include <asm/page.h>
 #include <asm/pgtable.h>
+#include <asm/alternative.h>
 #include <asm/csr.h>
 #include <asm/cpu_ops_sbi.h>
 #include <asm/hwcap.h>
@@ -341,6 +342,7 @@ clear_bss_done:
 	call kasan_early_init
 #endif
 	/* Start the kernel */
+	call apply_boot_alternatives
 	call soc_early_init
 	tail start_kernel
 
diff --git a/arch/riscv/kernel/smpboot.c b/arch/riscv/kernel/smpboot.c
index a6d13dca1403..f1e4948a4b52 100644
--- a/arch/riscv/kernel/smpboot.c
+++ b/arch/riscv/kernel/smpboot.c
@@ -32,7 +32,6 @@
 #include <asm/sections.h>
 #include <asm/sbi.h>
 #include <asm/smp.h>
-#include <asm/alternative.h>
 
 #include "head.h"
 
@@ -41,7 +40,6 @@ static DECLARE_COMPLETION(cpu_running);
 void __init smp_prepare_boot_cpu(void)
 {
 	init_cpu_topology();
-	apply_boot_alternatives();
 }
 
 void __init smp_prepare_cpus(unsigned int max_cpus)
-- 
2.30.2

