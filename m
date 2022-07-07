Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBD7656A597
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 16:38:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235816AbiGGOhn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 10:37:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235486AbiGGOhj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 10:37:39 -0400
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 539A030F60
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jul 2022 07:37:38 -0700 (PDT)
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4LdzXG4PtSz9tGm;
        Thu,  7 Jul 2022 16:37:34 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id N3sFXSvvRn9D; Thu,  7 Jul 2022 16:37:34 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4LdzXC13YMz9tGt;
        Thu,  7 Jul 2022 16:37:31 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 11DEB8B768;
        Thu,  7 Jul 2022 16:37:31 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id L6X1qUgoqLTf; Thu,  7 Jul 2022 16:37:30 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [192.168.233.174])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 981978B7A0;
        Thu,  7 Jul 2022 16:37:30 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.16.1) with ESMTPS id 267EbKK3538798
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Thu, 7 Jul 2022 16:37:20 +0200
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.17.1/Submit) id 267EbJHX538797;
        Thu, 7 Jul 2022 16:37:19 +0200
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to christophe.leroy@csgroup.eu using -f
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Rashmica Gupta <rashmica.g@gmail.com>,
        Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Kajol Jain <kjain@linux.ibm.com>
Subject: [PATCH v5 1/2] powerpc/perf: Use PVR rather than oprofile field to determine CPU version
Date:   Thu,  7 Jul 2022 16:37:17 +0200
Message-Id: <20c0ee7f99dbf0dbf8658df6b39f84753e6db1ef.1657204631.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1657204637; l=9237; i=christophe.leroy@csgroup.eu; s=20211009; h=from:subject:message-id; bh=CpFxw9bHPU0p1MWc8raCrOtG2g/J5ssxWjHRTSEWQS8=; b=kDDdCa0dZLdWrVo4yeBNpMQYZ7U+TKfRzO7wsVRIYUQ3RPgJPV7kBaZmv5dw5K7cWvFNDVmsW/xn nb9eIigiBI+aHGwN8oHNuTq20D98flthPRSMdC3c1NAF/Mju0myy
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rashmica Gupta <rashmica.g@gmail.com>

Currently the perf CPU backend drivers detect what CPU they're on using
cur_cpu_spec->oprofile_cpu_type.

Although that works, it's a bit crufty to be using oprofile related fields,
especially seeing as oprofile is more or less unused these days.

It also means perf is reliant on the fragile logic in setup_cpu_spec()
which detects when we're using a logical PVR and copies back the PMU
related fields from the raw CPU entry. So lets check the PVR directly.

Suggested-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Rashmica Gupta <rashmica.g@gmail.com>
Reviewed-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
[chleroy: Added power10 and fixed checkpatch issues]
Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
Reviewed-and-tested-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Reviewed-and-tested-By: Kajol Jain <kjain@linux.ibm.com> [For 24x7 side changes]
---
v4:
- No change to the series
- Added additional Reviewed-by/Tested-by.
- Rebased
- Resending to get some CI result this time
---
 arch/powerpc/perf/e500-pmu.c    | 9 +++++----
 arch/powerpc/perf/e6500-pmu.c   | 5 +++--
 arch/powerpc/perf/hv-24x7.c     | 6 +++---
 arch/powerpc/perf/mpc7450-pmu.c | 5 +++--
 arch/powerpc/perf/power10-pmu.c | 6 ++----
 arch/powerpc/perf/power5+-pmu.c | 6 +++---
 arch/powerpc/perf/power5-pmu.c  | 5 +++--
 arch/powerpc/perf/power6-pmu.c  | 5 +++--
 arch/powerpc/perf/power7-pmu.c  | 7 ++++---
 arch/powerpc/perf/power8-pmu.c  | 5 +++--
 arch/powerpc/perf/power9-pmu.c  | 4 +---
 arch/powerpc/perf/ppc970-pmu.c  | 7 ++++---
 12 files changed, 37 insertions(+), 33 deletions(-)

diff --git a/arch/powerpc/perf/e500-pmu.c b/arch/powerpc/perf/e500-pmu.c
index a59c33bed32a..e3e1a68eb1d5 100644
--- a/arch/powerpc/perf/e500-pmu.c
+++ b/arch/powerpc/perf/e500-pmu.c
@@ -118,12 +118,13 @@ static struct fsl_emb_pmu e500_pmu = {
 
 static int init_e500_pmu(void)
 {
-	if (!cur_cpu_spec->oprofile_cpu_type)
-		return -ENODEV;
+	unsigned int pvr = mfspr(SPRN_PVR);
 
-	if (!strcmp(cur_cpu_spec->oprofile_cpu_type, "ppc/e500mc"))
+	/* ec500mc */
+	if (PVR_VER(pvr) == PVR_VER_E500MC || PVR_VER(pvr) == PVR_VER_E5500)
 		num_events = 256;
-	else if (strcmp(cur_cpu_spec->oprofile_cpu_type, "ppc/e500"))
+	/* e500 */
+	else if (PVR_VER(pvr) != PVR_VER_E500V1 && PVR_VER(pvr) != PVR_VER_E500V2)
 		return -ENODEV;
 
 	return register_fsl_emb_pmu(&e500_pmu);
diff --git a/arch/powerpc/perf/e6500-pmu.c b/arch/powerpc/perf/e6500-pmu.c
index 44ad65da82ed..bd779a2338f8 100644
--- a/arch/powerpc/perf/e6500-pmu.c
+++ b/arch/powerpc/perf/e6500-pmu.c
@@ -107,8 +107,9 @@ static struct fsl_emb_pmu e6500_pmu = {
 
 static int init_e6500_pmu(void)
 {
-	if (!cur_cpu_spec->oprofile_cpu_type ||
-		strcmp(cur_cpu_spec->oprofile_cpu_type, "ppc/e6500"))
+	unsigned int pvr = mfspr(SPRN_PVR);
+
+	if (PVR_VER(pvr) != PVR_VER_E6500)
 		return -ENODEV;
 
 	return register_fsl_emb_pmu(&e6500_pmu);
diff --git a/arch/powerpc/perf/hv-24x7.c b/arch/powerpc/perf/hv-24x7.c
index cf5406b31e27..33c23225fd54 100644
--- a/arch/powerpc/perf/hv-24x7.c
+++ b/arch/powerpc/perf/hv-24x7.c
@@ -1718,16 +1718,16 @@ static int hv_24x7_init(void)
 {
 	int r;
 	unsigned long hret;
+	unsigned int pvr = mfspr(SPRN_PVR);
 	struct hv_perf_caps caps;
 
 	if (!firmware_has_feature(FW_FEATURE_LPAR)) {
 		pr_debug("not a virtualized system, not enabling\n");
 		return -ENODEV;
-	} else if (!cur_cpu_spec->oprofile_cpu_type)
-		return -ENODEV;
+	}
 
 	/* POWER8 only supports v1, while POWER9 only supports v2. */
-	if (!strcmp(cur_cpu_spec->oprofile_cpu_type, "ppc64/power8"))
+	if (PVR_VER(pvr) == PVR_POWER8)
 		interface_version = 1;
 	else {
 		interface_version = 2;
diff --git a/arch/powerpc/perf/mpc7450-pmu.c b/arch/powerpc/perf/mpc7450-pmu.c
index e39b15b79a83..552d51a925d3 100644
--- a/arch/powerpc/perf/mpc7450-pmu.c
+++ b/arch/powerpc/perf/mpc7450-pmu.c
@@ -417,8 +417,9 @@ struct power_pmu mpc7450_pmu = {
 
 static int __init init_mpc7450_pmu(void)
 {
-	if (!cur_cpu_spec->oprofile_cpu_type ||
-	    strcmp(cur_cpu_spec->oprofile_cpu_type, "ppc/7450"))
+	unsigned int pvr = mfspr(SPRN_PVR);
+
+	if (PVR_VER(pvr) != PVR_7450)
 		return -ENODEV;
 
 	return register_power_pmu(&mpc7450_pmu);
diff --git a/arch/powerpc/perf/power10-pmu.c b/arch/powerpc/perf/power10-pmu.c
index c6d51e7093cf..a6a72b762d55 100644
--- a/arch/powerpc/perf/power10-pmu.c
+++ b/arch/powerpc/perf/power10-pmu.c
@@ -597,12 +597,10 @@ int __init init_power10_pmu(void)
 	unsigned int pvr;
 	int rc;
 
-	/* Comes from cpu_specs[] */
-	if (!cur_cpu_spec->oprofile_cpu_type ||
-	    strcmp(cur_cpu_spec->oprofile_cpu_type, "ppc64/power10"))
+	pvr = mfspr(SPRN_PVR);
+	if (PVR_VER(pvr) != PVR_POWER10)
 		return -ENODEV;
 
-	pvr = mfspr(SPRN_PVR);
 	/* Add the ppmu flag for power10 DD1 */
 	if ((PVR_CFG(pvr) == 1))
 		power10_pmu.flags |= PPMU_P10_DD1;
diff --git a/arch/powerpc/perf/power5+-pmu.c b/arch/powerpc/perf/power5+-pmu.c
index 753b4740ef64..b4708ab73145 100644
--- a/arch/powerpc/perf/power5+-pmu.c
+++ b/arch/powerpc/perf/power5+-pmu.c
@@ -679,9 +679,9 @@ static struct power_pmu power5p_pmu = {
 
 int __init init_power5p_pmu(void)
 {
-	if (!cur_cpu_spec->oprofile_cpu_type ||
-	    (strcmp(cur_cpu_spec->oprofile_cpu_type, "ppc64/power5+")
-	     && strcmp(cur_cpu_spec->oprofile_cpu_type, "ppc64/power5++")))
+	unsigned int pvr = mfspr(SPRN_PVR);
+
+	if (PVR_VER(pvr) != PVR_POWER5p)
 		return -ENODEV;
 
 	return register_power_pmu(&power5p_pmu);
diff --git a/arch/powerpc/perf/power5-pmu.c b/arch/powerpc/perf/power5-pmu.c
index 1f83c4cba0aa..c6aefd0a1cc8 100644
--- a/arch/powerpc/perf/power5-pmu.c
+++ b/arch/powerpc/perf/power5-pmu.c
@@ -620,8 +620,9 @@ static struct power_pmu power5_pmu = {
 
 int __init init_power5_pmu(void)
 {
-	if (!cur_cpu_spec->oprofile_cpu_type ||
-	    strcmp(cur_cpu_spec->oprofile_cpu_type, "ppc64/power5"))
+	unsigned int pvr = mfspr(SPRN_PVR);
+
+	if (PVR_VER(pvr) != PVR_POWER5)
 		return -ENODEV;
 
 	return register_power_pmu(&power5_pmu);
diff --git a/arch/powerpc/perf/power6-pmu.c b/arch/powerpc/perf/power6-pmu.c
index aec746f86804..5729b6e059de 100644
--- a/arch/powerpc/perf/power6-pmu.c
+++ b/arch/powerpc/perf/power6-pmu.c
@@ -541,8 +541,9 @@ static struct power_pmu power6_pmu = {
 
 int __init init_power6_pmu(void)
 {
-	if (!cur_cpu_spec->oprofile_cpu_type ||
-	    strcmp(cur_cpu_spec->oprofile_cpu_type, "ppc64/power6"))
+	unsigned int pvr = mfspr(SPRN_PVR);
+
+	if (PVR_VER(pvr) != PVR_POWER6)
 		return -ENODEV;
 
 	return register_power_pmu(&power6_pmu);
diff --git a/arch/powerpc/perf/power7-pmu.c b/arch/powerpc/perf/power7-pmu.c
index a74211410b8d..c95ccf2e28da 100644
--- a/arch/powerpc/perf/power7-pmu.c
+++ b/arch/powerpc/perf/power7-pmu.c
@@ -447,11 +447,12 @@ static struct power_pmu power7_pmu = {
 
 int __init init_power7_pmu(void)
 {
-	if (!cur_cpu_spec->oprofile_cpu_type ||
-	    strcmp(cur_cpu_spec->oprofile_cpu_type, "ppc64/power7"))
+	unsigned int pvr = mfspr(SPRN_PVR);
+
+	if (PVR_VER(pvr) != PVR_POWER7 && PVR_VER(pvr) != PVR_POWER7p)
 		return -ENODEV;
 
-	if (pvr_version_is(PVR_POWER7p))
+	if (PVR_VER(pvr) == PVR_POWER7p)
 		power7_pmu.flags |= PPMU_SIAR_VALID;
 
 	return register_power_pmu(&power7_pmu);
diff --git a/arch/powerpc/perf/power8-pmu.c b/arch/powerpc/perf/power8-pmu.c
index e37b1e714d2b..9b93c7655cb4 100644
--- a/arch/powerpc/perf/power8-pmu.c
+++ b/arch/powerpc/perf/power8-pmu.c
@@ -381,9 +381,10 @@ static struct power_pmu power8_pmu = {
 int __init init_power8_pmu(void)
 {
 	int rc;
+	unsigned int pvr = mfspr(SPRN_PVR);
 
-	if (!cur_cpu_spec->oprofile_cpu_type ||
-	    strcmp(cur_cpu_spec->oprofile_cpu_type, "ppc64/power8"))
+	if (PVR_VER(pvr) != PVR_POWER8E && PVR_VER(pvr) != PVR_POWER8NVL &&
+	    PVR_VER(pvr) != PVR_POWER8)
 		return -ENODEV;
 
 	rc = register_power_pmu(&power8_pmu);
diff --git a/arch/powerpc/perf/power9-pmu.c b/arch/powerpc/perf/power9-pmu.c
index 3ad40ffb9256..b401c762956f 100644
--- a/arch/powerpc/perf/power9-pmu.c
+++ b/arch/powerpc/perf/power9-pmu.c
@@ -457,9 +457,7 @@ int __init init_power9_pmu(void)
 	int rc = 0;
 	unsigned int pvr = mfspr(SPRN_PVR);
 
-	/* Comes from cpu_specs[] */
-	if (!cur_cpu_spec->oprofile_cpu_type ||
-	    strcmp(cur_cpu_spec->oprofile_cpu_type, "ppc64/power9"))
+	if (PVR_VER(pvr) != PVR_POWER9)
 		return -ENODEV;
 
 	/* Blacklist events */
diff --git a/arch/powerpc/perf/ppc970-pmu.c b/arch/powerpc/perf/ppc970-pmu.c
index 09802482ba72..762676fb839e 100644
--- a/arch/powerpc/perf/ppc970-pmu.c
+++ b/arch/powerpc/perf/ppc970-pmu.c
@@ -491,9 +491,10 @@ static struct power_pmu ppc970_pmu = {
 
 int __init init_ppc970_pmu(void)
 {
-	if (!cur_cpu_spec->oprofile_cpu_type ||
-	    (strcmp(cur_cpu_spec->oprofile_cpu_type, "ppc64/970")
-	     && strcmp(cur_cpu_spec->oprofile_cpu_type, "ppc64/970MP")))
+	unsigned int pvr = mfspr(SPRN_PVR);
+
+	if (PVR_VER(pvr) != PVR_970 && PVR_VER(pvr) != PVR_970MP &&
+	    PVR_VER(pvr) != PVR_970FX && PVR_VER(pvr) != PVR_970GX)
 		return -ENODEV;
 
 	return register_power_pmu(&ppc970_pmu);
-- 
2.36.1

