Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B2DE4962F1
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 17:37:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350367AbiAUQhU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 11:37:20 -0500
Received: from gloria.sntech.de ([185.11.138.130]:35258 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1349296AbiAUQhF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 11:37:05 -0500
Received: from p508fcef5.dip0.t-ipconnect.de ([80.143.206.245] helo=phil.fritz.box)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1nAwuF-0008GA-I7; Fri, 21 Jan 2022 17:36:55 +0100
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
Subject: [PATCH v5 01/14] riscv: only use IPIs to handle cache-flushes on remote cpus
Date:   Fri, 21 Jan 2022 17:36:05 +0100
Message-Id: <20220121163618.351934-2-heiko@sntech.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220121163618.351934-1-heiko@sntech.de>
References: <20220121163618.351934-1-heiko@sntech.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Right now, the flush_icache functions always use the SBI remote-fence
when SBI is available, leaving using IPIs as a fallback mechanism.

IPIs on the other hand are more flexible, as the ipi_ops are initially
set to go through SBI but later will be overwritten to go through the
ACLINT/CLINT.

In a discussion we had, Nick was of the opinion that "In general we
should prefer doing IPIs on S-mode through CLINT instead of going
through SBI/M-mode, so IMHO we should only be using
on_each_cpu_mask(ipi_remote_fence_i) on flush_icache_all()/
flush_icache_mm() and remove any explicit calls to sbi_remote_fence_i(),
because this way we continue using SBI for doing remote fences even after
CLINT/ACLINT driver is registered, instead of using direct IPIs through
CLINT/ACLINT."

So follow this suggestion and just do ipi calls to have the proper kernel
parts do them,

This also fixes the null-ptr dereference happening when flush_icache_all()
is called before sbi_init().

Suggested-by: Nick Kossifidis <mick@ics.forth.gr>
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/riscv/mm/cacheflush.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/arch/riscv/mm/cacheflush.c b/arch/riscv/mm/cacheflush.c
index 6cb7d96ad9c7..c35375cd52ec 100644
--- a/arch/riscv/mm/cacheflush.c
+++ b/arch/riscv/mm/cacheflush.c
@@ -17,11 +17,7 @@ static void ipi_remote_fence_i(void *info)
 void flush_icache_all(void)
 {
 	local_flush_icache_all();
-
-	if (IS_ENABLED(CONFIG_RISCV_SBI))
-		sbi_remote_fence_i(NULL);
-	else
-		on_each_cpu(ipi_remote_fence_i, NULL, 1);
+	on_each_cpu(ipi_remote_fence_i, NULL, 1);
 }
 EXPORT_SYMBOL(flush_icache_all);
 
@@ -66,8 +62,6 @@ void flush_icache_mm(struct mm_struct *mm, bool local)
 		 * with flush_icache_deferred().
 		 */
 		smp_mb();
-	} else if (IS_ENABLED(CONFIG_RISCV_SBI)) {
-		sbi_remote_fence_i(&others);
 	} else {
 		on_each_cpu_mask(&others, ipi_remote_fence_i, NULL, 1);
 	}
-- 
2.30.2

