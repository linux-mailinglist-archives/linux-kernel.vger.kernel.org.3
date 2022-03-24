Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B93654E5C33
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 01:10:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242908AbiCXAKg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 20:10:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346693AbiCXAKc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 20:10:32 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F37031A38C
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 17:09:00 -0700 (PDT)
Received: from ip5b412258.dynamic.kabel-deutschland.de ([91.65.34.88] helo=phil.lan)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1nXB0r-00055s-SM; Thu, 24 Mar 2022 01:07:37 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     palmer@dabbelt.com, paul.walmsley@sifive.com, aou@eecs.berkeley.edu
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        wefu@redhat.com, liush@allwinnertech.com, guoren@kernel.org,
        atishp@atishpatra.org, anup@brainfault.org, drew@beagleboard.org,
        hch@lst.de, arnd@arndb.de, wens@csie.org, maxime@cerno.tech,
        gfavor@ventanamicro.com, andrea.mondelli@huawei.com,
        behrensj@mit.edu, xinhaoqu@huawei.com, mick@ics.forth.gr,
        allen.baum@esperantotech.com, jscheid@ventanamicro.com,
        rtrauben@gmail.com, samuel@sholland.org, cmuellner@linux.com,
        philipp.tomsich@vrull.eu, Heiko Stuebner <heiko@sntech.de>
Subject: [PATCH v8 10/14] riscv: add cpufeature handling via alternatives
Date:   Thu, 24 Mar 2022 01:07:06 +0100
Message-Id: <20220324000710.575331-11-heiko@sntech.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220324000710.575331-1-heiko@sntech.de>
References: <20220324000710.575331-1-heiko@sntech.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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
 arch/riscv/kernel/cpufeature.c       | 57 +++++++++++++++++++++++++++-
 4 files changed, 63 insertions(+), 1 deletion(-)

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
index 223770b3945c..e6c9de9f9ba6 100644
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
index a43c08af5f4b..c0ffc26c3ef3 100644
--- a/arch/riscv/kernel/cpufeature.c
+++ b/arch/riscv/kernel/cpufeature.c
@@ -8,9 +8,14 @@
 
 #include <linux/bitmap.h>
 #include <linux/ctype.h>
+#include <linux/module.h>
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
 
@@ -235,3 +240,53 @@ void __init riscv_fill_hwcap(void)
 		static_branch_enable(&cpu_hwcap_fpu);
 #endif
 }
+
+struct cpufeature_info {
+	char name[ERRATA_STRING_LENGTH_MAX];
+	bool (*check_func)(unsigned int stage);
+};
+
+static const struct cpufeature_info __initdata_or_module cpufeature_list[CPUFEATURE_NUMBER] = {
+};
+
+static u32 __init_or_module cpufeature_probe(unsigned int stage)
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
+void __init_or_module riscv_cpufeature_patch_func(struct alt_entry *begin,
+						  struct alt_entry *end,
+						  unsigned int stage)
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
2.35.1

