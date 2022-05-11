Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25425523D6D
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 21:30:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346854AbiEKT3u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 15:29:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbiEKT3r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 15:29:47 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B78D8F136D
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 12:29:44 -0700 (PDT)
Received: from ip5b412258.dynamic.kabel-deutschland.de ([91.65.34.88] helo=phil.lan)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1nos1f-0004fe-Aw; Wed, 11 May 2022 21:29:35 +0200
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
Subject: [PATCH 02/12] riscv: allow different stages with alternatives
Date:   Wed, 11 May 2022 21:29:11 +0200
Message-Id: <20220511192921.2223629-3-heiko@sntech.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220511192921.2223629-1-heiko@sntech.de>
References: <20220511192921.2223629-1-heiko@sntech.de>
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

Future features may need to be applied at a different
time during boot, so allow defining stages for alternatives
and handling them differently depending on the stage.

Also make the alternatives-location more flexible so that
future stages may provide their own location.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
Reviewed-by: Philipp Tomsich <philipp.tomsich@vrull.eu>
---
 arch/riscv/errata/sifive/errata.c    |  3 ++-
 arch/riscv/include/asm/alternative.h |  5 ++++-
 arch/riscv/kernel/alternative.c      | 26 +++++++++++++++++---------
 3 files changed, 23 insertions(+), 11 deletions(-)

diff --git a/arch/riscv/errata/sifive/errata.c b/arch/riscv/errata/sifive/errata.c
index f5e5ae70e829..4fe03ac41fd7 100644
--- a/arch/riscv/errata/sifive/errata.c
+++ b/arch/riscv/errata/sifive/errata.c
@@ -80,7 +80,8 @@ static void __init warn_miss_errata(u32 miss_errata)
 }
 
 void __init sifive_errata_patch_func(struct alt_entry *begin, struct alt_entry *end,
-				     unsigned long archid, unsigned long impid)
+				     unsigned long archid, unsigned long impid,
+				     unsigned int stage)
 {
 	struct alt_entry *alt;
 	u32 cpu_req_errata = sifive_errata_probe(archid, impid);
diff --git a/arch/riscv/include/asm/alternative.h b/arch/riscv/include/asm/alternative.h
index 7b42bcef0ecf..0ff550667e94 100644
--- a/arch/riscv/include/asm/alternative.h
+++ b/arch/riscv/include/asm/alternative.h
@@ -19,6 +19,8 @@
 #include <linux/stddef.h>
 #include <asm/hwcap.h>
 
+#define RISCV_ALTERNATIVES_BOOT		0 /* alternatives applied during regular boot */
+
 void __init apply_boot_alternatives(void);
 
 struct alt_entry {
@@ -35,7 +37,8 @@ struct errata_checkfunc_id {
 };
 
 void sifive_errata_patch_func(struct alt_entry *begin, struct alt_entry *end,
-			      unsigned long archid, unsigned long impid);
+			      unsigned long archid, unsigned long impid,
+			      unsigned int stage);
 
 #else /* CONFIG_RISCV_ALTERNATIVE */
 
diff --git a/arch/riscv/kernel/alternative.c b/arch/riscv/kernel/alternative.c
index e8b4a0fe488c..02db62f55bac 100644
--- a/arch/riscv/kernel/alternative.c
+++ b/arch/riscv/kernel/alternative.c
@@ -22,8 +22,8 @@ static struct cpu_manufacturer_info_t {
 } cpu_mfr_info;
 
 static void (*vendor_patch_func)(struct alt_entry *begin, struct alt_entry *end,
-				 unsigned long archid,
-				 unsigned long impid) __initdata;
+				 unsigned long archid, unsigned long impid,
+				 unsigned int stage) __initdata;
 
 static inline void __init riscv_fill_cpu_mfr_info(void)
 {
@@ -58,6 +58,18 @@ static void __init init_alternative(void)
  * a feature detect on the boot CPU). No need to worry about other CPUs
  * here.
  */
+static void __init _apply_alternatives(struct alt_entry *begin,
+				       struct alt_entry *end,
+				       unsigned int stage)
+{
+	if (!vendor_patch_func)
+		return;
+
+	vendor_patch_func(begin, end,
+			  cpu_mfr_info.arch_id, cpu_mfr_info.imp_id,
+			  stage);
+}
+
 void __init apply_boot_alternatives(void)
 {
 	/* If called on non-boot cpu things could go wrong */
@@ -65,11 +77,7 @@ void __init apply_boot_alternatives(void)
 
 	init_alternative();
 
-	if (!vendor_patch_func)
-		return;
-
-	vendor_patch_func((struct alt_entry *)__alt_start,
-			  (struct alt_entry *)__alt_end,
-			  cpu_mfr_info.arch_id, cpu_mfr_info.imp_id);
+	_apply_alternatives((struct alt_entry *)__alt_start,
+			    (struct alt_entry *)__alt_end,
+			    RISCV_ALTERNATIVES_BOOT);
 }
-
-- 
2.35.1

