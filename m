Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EF9E472B2C
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 12:20:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235043AbhLMLUy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 06:20:54 -0500
Received: from gloria.sntech.de ([185.11.138.130]:37646 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231296AbhLMLUx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 06:20:53 -0500
Received: from p5b127e39.dip0.t-ipconnect.de ([91.18.126.57] helo=phil.fritz.box)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1mwjNs-0001Dm-Q5; Mon, 13 Dec 2021 12:20:44 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu
Cc:     atishp@atishpatra.org, anup@brainfault.org, jszhang@kernel.org,
        christoph.muellner@vrull.eu, philipp.tomsich@vrull.eu,
        mick@ics.forth.gr, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, Heiko Stuebner <heiko@sntech.de>
Subject: [PATCH 1/2] riscv: prevent null-pointer dereference with sbi_remote_fence_i
Date:   Mon, 13 Dec 2021 12:20:33 +0100
Message-Id: <20211213112034.2896536-1-heiko@sntech.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The callback used inside sbi_remote_fence_i is set at sbi probe time
to the needed variant. Before that it is a NULL pointer.

The selection between using sbi_remote_fence_i or ipi_remote_fence_i
right now is solely done on the presence of the RISCV_SBI config option.

On a multiplatform kernel, SBI will probably always be built in, but
in the future not all machines using that kernel may have SBI
on them, so in some cases this setup can lead to NULL pointer dereferences.

Also if in future one of the flush_icache_all / flush_icache_mm functions
gets called earlier in the boot process - before sbi_init - this would
trigger the issue.

To prevent this, add a default __sbi_rfence_none returning an error code
and adapt the callers to check for an error from the remote fence
to then fall back to the other method.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/riscv/kernel/sbi.c    | 10 +++++++++-
 arch/riscv/mm/cacheflush.c | 25 +++++++++++++++++--------
 2 files changed, 26 insertions(+), 9 deletions(-)

diff --git a/arch/riscv/kernel/sbi.c b/arch/riscv/kernel/sbi.c
index 7402a417f38e..69d0a96b97d0 100644
--- a/arch/riscv/kernel/sbi.c
+++ b/arch/riscv/kernel/sbi.c
@@ -14,11 +14,19 @@
 unsigned long sbi_spec_version __ro_after_init = SBI_SPEC_VERSION_DEFAULT;
 EXPORT_SYMBOL(sbi_spec_version);
 
+static int __sbi_rfence_none(int fid, const unsigned long *hart_mask,
+			     unsigned long start, unsigned long size,
+			     unsigned long arg4, unsigned long arg5)
+{
+	return -EOPNOTSUPP;
+}
+
 static void (*__sbi_set_timer)(uint64_t stime) __ro_after_init;
 static int (*__sbi_send_ipi)(const unsigned long *hart_mask) __ro_after_init;
 static int (*__sbi_rfence)(int fid, const unsigned long *hart_mask,
 			   unsigned long start, unsigned long size,
-			   unsigned long arg4, unsigned long arg5) __ro_after_init;
+			   unsigned long arg4, unsigned long arg5)
+			   __ro_after_init = __sbi_rfence_none;
 
 struct sbiret sbi_ecall(int ext, int fid, unsigned long arg0,
 			unsigned long arg1, unsigned long arg2,
diff --git a/arch/riscv/mm/cacheflush.c b/arch/riscv/mm/cacheflush.c
index 89f81067e09e..128e23c094ea 100644
--- a/arch/riscv/mm/cacheflush.c
+++ b/arch/riscv/mm/cacheflush.c
@@ -16,11 +16,15 @@ static void ipi_remote_fence_i(void *info)
 
 void flush_icache_all(void)
 {
+	int ret = -EINVAL;
+
 	local_flush_icache_all();
 
 	if (IS_ENABLED(CONFIG_RISCV_SBI))
-		sbi_remote_fence_i(NULL);
-	else
+		ret = sbi_remote_fence_i(NULL);
+
+	/* fall back to ipi_remote_fence_i if sbi failed or not available */
+	if (ret)
 		on_each_cpu(ipi_remote_fence_i, NULL, 1);
 }
 EXPORT_SYMBOL(flush_icache_all);
@@ -66,13 +70,18 @@ void flush_icache_mm(struct mm_struct *mm, bool local)
 		 * with flush_icache_deferred().
 		 */
 		smp_mb();
-	} else if (IS_ENABLED(CONFIG_RISCV_SBI)) {
-		cpumask_t hartid_mask;
-
-		riscv_cpuid_to_hartid_mask(&others, &hartid_mask);
-		sbi_remote_fence_i(cpumask_bits(&hartid_mask));
 	} else {
-		on_each_cpu_mask(&others, ipi_remote_fence_i, NULL, 1);
+		int ret = -EINVAL;
+
+		if (IS_ENABLED(CONFIG_RISCV_SBI)) {
+			cpumask_t hartid_mask;
+
+			riscv_cpuid_to_hartid_mask(&others, &hartid_mask);
+			ret = sbi_remote_fence_i(cpumask_bits(&hartid_mask));
+		}
+
+		if (ret)
+			on_each_cpu_mask(&others, ipi_remote_fence_i, NULL, 1);
 	}
 
 	preempt_enable();
-- 
2.30.2

