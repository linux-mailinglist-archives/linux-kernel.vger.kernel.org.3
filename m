Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BBD7559B72
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 16:24:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232269AbiFXOXl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 10:23:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232500AbiFXOXh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 10:23:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5393A49252
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 07:23:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D2ED162030
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 14:23:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF03BC3411C;
        Fri, 24 Jun 2022 14:23:34 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="mzkWu2f4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1656080613;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jJfl1GH0XNDioFoW1Ys1u2Ptf2MdQky8PrpHURnqz+U=;
        b=mzkWu2f4Zmtcxccu8J1Gb9aOYrlGdtSlrX3E0bsaT10hai6POM4ef2xO5cKdjSRxpt1XJ7
        qgFKIcZBJBWdLLhZ3Xny6NkJgV1/cNN0PZwb/9SJZ2VnMlv20q0UgmscTtE8fb9EhFSjtq
        Xle17Ca1x6mQEhCOHp2L+48lyBAQU0Q=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 49541e4a (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Fri, 24 Jun 2022 14:23:33 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Fabiano Rosas <farosas@linux.ibm.com>,
        linuxppc-dev@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: [PATCH v2 1/2] powerpc/powernv: rename remaining rng powernv_ functions to pnv_
Date:   Fri, 24 Jun 2022 16:23:21 +0200
Message-Id: <20220624142322.2049826-2-Jason@zx2c4.com>
In-Reply-To: <20220624142322.2049826-1-Jason@zx2c4.com>
References: <20220624142322.2049826-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The preferred nomenclature is pnv_, not powernv_, but rng.c used
powernv_ for some reason, which isn't consistent with the rest. A recent
commit added a few pnv_ functions to rng.c, making the file a bit of a
mishmash. This commit just replaces the rest of them.

Cc: Michael Ellerman <mpe@ellerman.id.au>
Fixes: f3eac426657 ("powerpc/powernv: wire up rng during setup_arch")
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 arch/powerpc/include/asm/archrandom.h | 10 +++----
 arch/powerpc/kvm/book3s_hv_builtin.c  |  4 +--
 arch/powerpc/platforms/powernv/rng.c  | 42 +++++++++++++--------------
 drivers/char/hw_random/powernv-rng.c  |  2 +-
 4 files changed, 29 insertions(+), 29 deletions(-)

diff --git a/arch/powerpc/include/asm/archrandom.h b/arch/powerpc/include/asm/archrandom.h
index 9a53e29680f4..11d4815841ab 100644
--- a/arch/powerpc/include/asm/archrandom.h
+++ b/arch/powerpc/include/asm/archrandom.h
@@ -38,12 +38,12 @@ static inline bool __must_check arch_get_random_seed_int(unsigned int *v)
 #endif /* CONFIG_ARCH_RANDOM */
 
 #ifdef CONFIG_PPC_POWERNV
-int powernv_hwrng_present(void);
-int powernv_get_random_long(unsigned long *v);
-int powernv_get_random_real_mode(unsigned long *v);
+int pnv_hwrng_present(void);
+int pnv_get_random_long(unsigned long *v);
+int pnv_get_random_real_mode(unsigned long *v);
 #else
-static inline int powernv_hwrng_present(void) { return 0; }
-static inline int powernv_get_random_real_mode(unsigned long *v) { return 0; }
+static inline int pnv_hwrng_present(void) { return 0; }
+static inline int pnv_get_random_real_mode(unsigned long *v) { return 0; }
 #endif
 
 #endif /* _ASM_POWERPC_ARCHRANDOM_H */
diff --git a/arch/powerpc/kvm/book3s_hv_builtin.c b/arch/powerpc/kvm/book3s_hv_builtin.c
index 88a8f6473c4e..799d40c2ab4f 100644
--- a/arch/powerpc/kvm/book3s_hv_builtin.c
+++ b/arch/powerpc/kvm/book3s_hv_builtin.c
@@ -176,13 +176,13 @@ EXPORT_SYMBOL_GPL(kvmppc_hcall_impl_hv_realmode);
 
 int kvmppc_hwrng_present(void)
 {
-	return powernv_hwrng_present();
+	return pnv_hwrng_present();
 }
 EXPORT_SYMBOL_GPL(kvmppc_hwrng_present);
 
 long kvmppc_rm_h_random(struct kvm_vcpu *vcpu)
 {
-	if (powernv_get_random_real_mode(&vcpu->arch.regs.gpr[4]))
+	if (pnv_get_random_real_mode(&vcpu->arch.regs.gpr[4]))
 		return H_SUCCESS;
 
 	return H_HARDWARE;
diff --git a/arch/powerpc/platforms/powernv/rng.c b/arch/powerpc/platforms/powernv/rng.c
index 463c78c52cc5..868bb9777425 100644
--- a/arch/powerpc/platforms/powernv/rng.c
+++ b/arch/powerpc/platforms/powernv/rng.c
@@ -21,24 +21,24 @@
 
 #define DARN_ERR 0xFFFFFFFFFFFFFFFFul
 
-struct powernv_rng {
+struct pnv_rng {
 	void __iomem *regs;
 	void __iomem *regs_real;
 	unsigned long mask;
 };
 
-static DEFINE_PER_CPU(struct powernv_rng *, powernv_rng);
+static DEFINE_PER_CPU(struct pnv_rng *, pnv_rng);
 
-int powernv_hwrng_present(void)
+int pnv_hwrng_present(void)
 {
-	struct powernv_rng *rng;
+	struct pnv_rng *rng;
 
-	rng = get_cpu_var(powernv_rng);
+	rng = get_cpu_var(pnv_rng);
 	put_cpu_var(rng);
 	return rng != NULL;
 }
 
-static unsigned long rng_whiten(struct powernv_rng *rng, unsigned long val)
+static unsigned long rng_whiten(struct pnv_rng *rng, unsigned long val)
 {
 	unsigned long parity;
 
@@ -58,18 +58,18 @@ static unsigned long rng_whiten(struct powernv_rng *rng, unsigned long val)
 	return val;
 }
 
-int powernv_get_random_real_mode(unsigned long *v)
+int pnv_get_random_real_mode(unsigned long *v)
 {
-	struct powernv_rng *rng;
+	struct pnv_rng *rng;
 
-	rng = raw_cpu_read(powernv_rng);
+	rng = raw_cpu_read(pnv_rng);
 
 	*v = rng_whiten(rng, __raw_rm_readq(rng->regs_real));
 
 	return 1;
 }
 
-static int powernv_get_random_darn(unsigned long *v)
+static int pnv_get_random_darn(unsigned long *v)
 {
 	unsigned long val;
 
@@ -93,19 +93,19 @@ static int __init initialise_darn(void)
 		return -ENODEV;
 
 	for (i = 0; i < 10; i++) {
-		if (powernv_get_random_darn(&val)) {
-			ppc_md.get_random_seed = powernv_get_random_darn;
+		if (pnv_get_random_darn(&val)) {
+			ppc_md.get_random_seed = pnv_get_random_darn;
 			return 0;
 		}
 	}
 	return -EIO;
 }
 
-int powernv_get_random_long(unsigned long *v)
+int pnv_get_random_long(unsigned long *v)
 {
-	struct powernv_rng *rng;
+	struct pnv_rng *rng;
 
-	rng = get_cpu_var(powernv_rng);
+	rng = get_cpu_var(pnv_rng);
 
 	*v = rng_whiten(rng, in_be64(rng->regs));
 
@@ -113,9 +113,9 @@ int powernv_get_random_long(unsigned long *v)
 
 	return 1;
 }
-EXPORT_SYMBOL_GPL(powernv_get_random_long);
+EXPORT_SYMBOL_GPL(pnv_get_random_long);
 
-static __init void rng_init_per_cpu(struct powernv_rng *rng,
+static __init void rng_init_per_cpu(struct pnv_rng *rng,
 				    struct device_node *dn)
 {
 	int chip_id, cpu;
@@ -125,16 +125,16 @@ static __init void rng_init_per_cpu(struct powernv_rng *rng,
 		pr_warn("No ibm,chip-id found for %pOF.\n", dn);
 
 	for_each_possible_cpu(cpu) {
-		if (per_cpu(powernv_rng, cpu) == NULL ||
+		if (per_cpu(pnv_rng, cpu) == NULL ||
 		    cpu_to_chip_id(cpu) == chip_id) {
-			per_cpu(powernv_rng, cpu) = rng;
+			per_cpu(pnv_rng, cpu) = rng;
 		}
 	}
 }
 
 static __init int rng_create(struct device_node *dn)
 {
-	struct powernv_rng *rng;
+	struct pnv_rng *rng;
 	struct resource res;
 	unsigned long val;
 
@@ -160,7 +160,7 @@ static __init int rng_create(struct device_node *dn)
 
 	rng_init_per_cpu(rng, dn);
 
-	ppc_md.get_random_seed = powernv_get_random_long;
+	ppc_md.get_random_seed = pnv_get_random_long;
 
 	return 0;
 }
diff --git a/drivers/char/hw_random/powernv-rng.c b/drivers/char/hw_random/powernv-rng.c
index 8da1d7917bdc..429e956f34e1 100644
--- a/drivers/char/hw_random/powernv-rng.c
+++ b/drivers/char/hw_random/powernv-rng.c
@@ -23,7 +23,7 @@ static int powernv_rng_read(struct hwrng *rng, void *data, size_t max, bool wait
 	buf = (unsigned long *)data;
 
 	for (i = 0; i < len; i++)
-		powernv_get_random_long(buf++);
+		pnv_get_random_long(buf++);
 
 	return len * sizeof(unsigned long);
 }
-- 
2.35.1

