Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 616B849630B
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 17:41:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350566AbiAUQlD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 11:41:03 -0500
Received: from gloria.sntech.de ([185.11.138.130]:36354 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1349644AbiAUQlB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 11:41:01 -0500
Received: from p508fcef5.dip0.t-ipconnect.de ([80.143.206.245] helo=phil.fritz.box)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1nAwuP-0008GA-4U; Fri, 21 Jan 2022 17:37:05 +0100
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
Subject: [PATCH v5 10/14] riscv: add cpufeature handling via alternatives
Date:   Fri, 21 Jan 2022 17:36:14 +0100
Message-Id: <20220121163618.351934-11-heiko@sntech.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220121163618.351934-1-heiko@sntech.de>
References: <20220121163618.351934-1-heiko@sntech.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some cpufeatures should be handled via the alternatives mechanism
to not incur penalties on unsupporting variants.

So add a mechanism to handle these similar to cpu erratas.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/riscv/include/asm/alternative.h |  3 ++
 arch/riscv/include/asm/errata_list.h |  2 +
 arch/riscv/kernel/alternative.c      |  2 +
 arch/riscv/kernel/cpufeature.c       | 55 +++++++++++++++++++++++++++-
 4 files changed, 61 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/include/asm/alternative.h b/arch/riscv/include/asm/alternative.h
index f0657b1b3174..cf3b22173834 100644
--- a/arch/riscv/include/asm/alternative.h
+++ b/arch/riscv/include/asm/alternative.h
@@ -39,5 +39,8 @@ struct errata_checkfunc_id {
 void sifive_errata_patch_func(struct alt_entry *begin, struct alt_entry *end,
 			      unsigned long archid, unsigned long impid,
 			      unsigned int stage);
+
+void riscv_cpufeature_patch_func(struct alt_entry *begin, struct alt_entry *end,
+				 unsigned int stage);
 #endif
 #endif
diff --git a/arch/riscv/include/asm/errata_list.h b/arch/riscv/include/asm/errata_list.h
index 5f1046e82d9f..6b95bd9aee82 100644
--- a/arch/riscv/include/asm/errata_list.h
+++ b/arch/riscv/include/asm/errata_list.h
@@ -14,6 +14,8 @@
 #define	ERRATA_SIFIVE_NUMBER 2
 #endif
 
+#define	CPUFEATURE_NUMBER 0
+
 #ifdef __ASSEMBLY__
 
 #define ALT_INSN_FAULT(x)						\
diff --git a/arch/riscv/kernel/alternative.c b/arch/riscv/kernel/alternative.c
index e1849faa2fa1..54913857b682 100644
--- a/arch/riscv/kernel/alternative.c
+++ b/arch/riscv/kernel/alternative.c
@@ -63,6 +63,8 @@ static void __init_or_module _apply_alternatives(struct alt_entry *begin,
 						 struct alt_entry *end,
 						 unsigned int stage)
 {
+	riscv_cpufeature_patch_func(begin, end, stage);
+
 	if (!vendor_patch_func)
 		return;
 
diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
index d959d207a40d..fef804346d75 100644
--- a/arch/riscv/kernel/cpufeature.c
+++ b/arch/riscv/kernel/cpufeature.c
@@ -8,8 +8,12 @@
 
 #include <linux/bitmap.h>
 #include <linux/of.h>
-#include <asm/processor.h>
+#include <asm/alternative.h>
+#include <asm/errata_list.h>
 #include <asm/hwcap.h>
+#include <asm/patch.h>
+#include <asm/pgtable.h>
+#include <asm/processor.h>
 #include <asm/smp.h>
 #include <asm/switch_to.h>
 
@@ -149,3 +153,52 @@ void __init riscv_fill_hwcap(void)
 		static_branch_enable(&cpu_hwcap_fpu);
 #endif
 }
+
+struct cpufeature_info {
+	char name[ERRATA_STRING_LENGTH_MAX];
+	bool (*check_func)(unsigned int stage);
+};
+
+static const struct cpufeature_info cpufeature_list[CPUFEATURE_NUMBER] = {
+};
+
+static u32 __init cpufeature_probe(unsigned int stage)
+{
+	const struct cpufeature_info *info;
+	u32 cpu_req_feature = 0;
+	int idx;
+
+	for (idx = 0; idx < CPUFEATURE_NUMBER; idx++) {
+		info = &cpufeature_list[idx];
+
+		if (info->check_func(stage))
+			cpu_req_feature |= (1U << idx);
+	}
+
+	return cpu_req_feature;
+}
+
+void riscv_cpufeature_patch_func(struct alt_entry *begin, struct alt_entry *end,
+				 unsigned int stage)
+{
+	u32 cpu_req_feature = cpufeature_probe(stage);
+	u32 cpu_apply_feature = 0;
+	struct alt_entry *alt;
+	u32 tmp;
+
+	for (alt = begin; alt < end; alt++) {
+		if (alt->vendor_id != 0)
+			continue;
+		if (alt->errata_id >= CPUFEATURE_NUMBER) {
+			WARN(1, "This feature id:%d is not in kernel cpufeature list",
+				alt->errata_id);
+			continue;
+		}
+
+		tmp = (1U << alt->errata_id);
+		if (cpu_req_feature & tmp) {
+			patch_text_nosync(alt->old_ptr, alt->alt_ptr, alt->alt_len);
+			cpu_apply_feature |= tmp;
+		}
+	}
+}
-- 
2.30.2

