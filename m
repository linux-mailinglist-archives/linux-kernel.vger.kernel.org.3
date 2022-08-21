Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C30AA59B5EE
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Aug 2022 20:19:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231718AbiHUSTF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Aug 2022 14:19:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231703AbiHUSTC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Aug 2022 14:19:02 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E67F11CFC1;
        Sun, 21 Aug 2022 11:19:00 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id c16-20020a17090aa61000b001fb3286d9f7so294966pjq.1;
        Sun, 21 Aug 2022 11:19:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=Jefmh/chTekLzbM/ussShayTDA1/KVFu/osWTYpBS98=;
        b=WMH6h8qOVU9GDf+A1jGtjFuhN3wUSb5DKdVO9OB/9TqGckhh6xF3p7sXG5Itj9GXBM
         H1SZOXP4iee2g7Bzr5fKuWShQWBF0CnKh/FUcZ2dvlYQBLsD7w2Vxgk4PPx7NyRtSbDE
         aSouWTTJV4PBFUbzsZaLZ8IF5wteoL67D7cWxxtcPZ1VnVuSi3XJApuKSONS6R9AzzkJ
         nE2s0JyuCbMHeatvJ4msfrtw5vznIOu5Cl5jA20qb44qgU6241lQdSRjZR9rZks+QKtB
         w7qyRc2y8Qgp4PGQ7L8OehegQKs6KSUbHfmuZb1GQZmEL/v0ze8zJPY6s/InUrhcHVK3
         SGpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=Jefmh/chTekLzbM/ussShayTDA1/KVFu/osWTYpBS98=;
        b=T8eiYUPd3/3RcA0s1NtR3tuZpkOrFnmeYHLeAuMrincCZgxLM5td1rVwTgApmFeKe+
         5Myxyt/9+I/Z7oKWxwe7kZdkXrXcKKImInThG4kdHEfUd//j9HUlIiIDRqNbpQOE2BfS
         vrkIUEP7NWixfIXz35Jctnb7FVPpFh224j+9pCOQJNoIJv1by9nsZZaXr5d8yXHOaxVO
         x+CzdSKI8P3lyHnn/k6hPyTn5TtdPa1bwcbWlrN0RiN5QA7Z1Lg86TG9LVktPPpjbHVU
         0WR4WbEt+l5SgGd2+e2yeQHkFK8Ko7tocTeJSY1iFoy24Flps1CGF8W2hDtI9p0ew1tu
         nW1Q==
X-Gm-Message-State: ACgBeo1H0cT7WhnY8LcYnmEyi/BNpI5WOmZAIhUyV+pEAohAWqnMr3h3
        CT2qBoxoKNfwpO4BokEzxdI=
X-Google-Smtp-Source: AA6agR59xeDDdukCYLQ+P3WWLp5KGrqni1O1UrEyEWs0/hLes29VrUFXlS2vHJ+xIiXb2XH+D7VjHw==
X-Received: by 2002:a17:902:f70d:b0:16c:50a2:78d1 with SMTP id h13-20020a170902f70d00b0016c50a278d1mr16608447plo.34.1661105940414;
        Sun, 21 Aug 2022 11:19:00 -0700 (PDT)
Received: from localhost ([2601:1c0:5200:a6:307:a401:7b76:c6e5])
        by smtp.gmail.com with ESMTPSA id x24-20020aa79418000000b0052d50e14f1dsm6986695pfo.78.2022.08.21.11.18.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Aug 2022 11:18:59 -0700 (PDT)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
        Rob Clark <robdclark@chromium.org>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Sibi Sankar <sibis@codeaurora.org>,
        Vinod Koul <vkoul@kernel.org>,
        Loic Poulain <loic.poulain@linaro.org>,
        Yang Yingliang <yangyingliang@huawei.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        linux-arm-kernel@lists.infradead.org (moderated list:ARM SMMU DRIVERS),
        iommu@lists.linux-foundation.org (open list:IOMMU DRIVERS),
        iommu@lists.linux.dev (open list:IOMMU DRIVERS),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 3/5] iommu/arm-smmu-qcom: Add private interface to tlbinv by ASID
Date:   Sun, 21 Aug 2022 11:19:04 -0700
Message-Id: <20220821181917.1188021-4-robdclark@gmail.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220821181917.1188021-1-robdclark@gmail.com>
References: <20220821181917.1188021-1-robdclark@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rob Clark <robdclark@chromium.org>

This will let the drm driver use different ASID values for each set of
pgtables to avoid over-invalidation on unmap.

Signed-off-by: Rob Clark <robdclark@chromium.org>
---
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c |  1 +
 drivers/iommu/arm/arm-smmu/arm-smmu.c      | 43 ++++++++++++++++++++--
 drivers/iommu/arm/arm-smmu/arm-smmu.h      |  1 +
 include/linux/adreno-smmu-priv.h           |  2 +
 4 files changed, 43 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
index 59b460c1c9a5..3230348729ab 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
@@ -229,6 +229,7 @@ static int qcom_adreno_smmu_init_context(struct arm_smmu_domain *smmu_domain,
 	priv->get_fault_info = qcom_adreno_smmu_get_fault_info;
 	priv->set_stall = qcom_adreno_smmu_set_stall;
 	priv->resume_translation = qcom_adreno_smmu_resume_translation;
+	priv->tlb_inv_by_id = arm_smmu_tlb_inv_by_id;
 
 	return 0;
 }
diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c b/drivers/iommu/arm/arm-smmu/arm-smmu.c
index 2ed3594f384e..624359bb2092 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
@@ -252,7 +252,7 @@ static void arm_smmu_tlb_sync_context(struct arm_smmu_domain *smmu_domain)
 	spin_unlock_irqrestore(&smmu_domain->cb_lock, flags);
 }
 
-static void arm_smmu_tlb_inv_context_s1(void *cookie)
+static void arm_smmu_tlb_inv_context_s1_asid(void *cookie, u16 asid)
 {
 	struct arm_smmu_domain *smmu_domain = cookie;
 	/*
@@ -261,21 +261,56 @@ static void arm_smmu_tlb_inv_context_s1(void *cookie)
 	 */
 	wmb();
 	arm_smmu_cb_write(smmu_domain->smmu, smmu_domain->cfg.cbndx,
-			  ARM_SMMU_CB_S1_TLBIASID, smmu_domain->cfg.asid);
+			  ARM_SMMU_CB_S1_TLBIASID, asid);
 	arm_smmu_tlb_sync_context(smmu_domain);
 }
 
-static void arm_smmu_tlb_inv_context_s2(void *cookie)
+static void arm_smmu_tlb_inv_context_s1(void *cookie)
+{
+	struct arm_smmu_domain *smmu_domain = cookie;
+
+	arm_smmu_tlb_inv_context_s1_asid(cookie, smmu_domain->cfg.asid);
+}
+
+static void arm_smmu_tlb_inv_context_s2_vmid(void *cookie, u16 vmid)
 {
 	struct arm_smmu_domain *smmu_domain = cookie;
 	struct arm_smmu_device *smmu = smmu_domain->smmu;
 
 	/* See above */
 	wmb();
-	arm_smmu_gr0_write(smmu, ARM_SMMU_GR0_TLBIVMID, smmu_domain->cfg.vmid);
+	arm_smmu_gr0_write(smmu, ARM_SMMU_GR0_TLBIVMID, vmid);
 	arm_smmu_tlb_sync_global(smmu);
 }
 
+static void arm_smmu_tlb_inv_context_s2(void *cookie)
+{
+	struct arm_smmu_domain *smmu_domain = cookie;
+
+	arm_smmu_tlb_inv_context_s2_vmid(cookie, smmu_domain->cfg.vmid);
+}
+
+void arm_smmu_tlb_inv_by_id(const void *cookie, u16 id)
+{
+	struct arm_smmu_domain *smmu_domain = (void *)cookie;
+	struct arm_smmu_device *smmu = smmu_domain->smmu;
+
+	arm_smmu_rpm_get(smmu);
+	switch (smmu_domain->stage) {
+	case ARM_SMMU_DOMAIN_S1:
+		arm_smmu_tlb_inv_context_s1_asid(smmu_domain, id);
+		break;
+	case ARM_SMMU_DOMAIN_S2:
+	case ARM_SMMU_DOMAIN_NESTED:
+		arm_smmu_tlb_inv_context_s2_vmid(smmu_domain, id);
+		break;
+	case ARM_SMMU_DOMAIN_BYPASS:
+		break;
+	}
+
+	arm_smmu_rpm_put(smmu);
+}
+
 static void arm_smmu_tlb_inv_range_s1(unsigned long iova, size_t size,
 				      size_t granule, void *cookie, int reg)
 {
diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.h b/drivers/iommu/arm/arm-smmu/arm-smmu.h
index 2b9b42fb6f30..f6fb52d6f841 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu.h
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu.h
@@ -527,6 +527,7 @@ struct arm_smmu_device *arm_smmu_impl_init(struct arm_smmu_device *smmu);
 struct arm_smmu_device *nvidia_smmu_impl_init(struct arm_smmu_device *smmu);
 struct arm_smmu_device *qcom_smmu_impl_init(struct arm_smmu_device *smmu);
 
+void arm_smmu_tlb_inv_by_id(const void *cookie, u16 id);
 void arm_smmu_write_context_bank(struct arm_smmu_device *smmu, int idx);
 int arm_mmu500_reset(struct arm_smmu_device *smmu);
 
diff --git a/include/linux/adreno-smmu-priv.h b/include/linux/adreno-smmu-priv.h
index 4ad90541a095..c44fc68d4de8 100644
--- a/include/linux/adreno-smmu-priv.h
+++ b/include/linux/adreno-smmu-priv.h
@@ -50,6 +50,7 @@ struct adreno_smmu_fault_info {
  *                 before set_ttbr0_cfg().  If stalling on fault is enabled,
  *                 the GPU driver must call resume_translation()
  * @resume_translation: Resume translation after a fault
+ * @tlb_inv_by_id: Flush TLB by ASID/VMID
  *
  *
  * The GPU driver (drm/msm) and adreno-smmu work together for controlling
@@ -69,6 +70,7 @@ struct adreno_smmu_priv {
 	void (*get_fault_info)(const void *cookie, struct adreno_smmu_fault_info *info);
 	void (*set_stall)(const void *cookie, bool enabled);
 	void (*resume_translation)(const void *cookie, bool terminate);
+	void (*tlb_inv_by_id)(const void *cookie, u16 id);
 };
 
 #endif /* __ADRENO_SMMU_PRIV_H */
-- 
2.37.2

