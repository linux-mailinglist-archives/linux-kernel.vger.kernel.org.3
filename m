Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3460259B5E7
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Aug 2022 20:19:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231706AbiHUSTC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Aug 2022 14:19:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231679AbiHUSSz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Aug 2022 14:18:55 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41BCB1C12F;
        Sun, 21 Aug 2022 11:18:54 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id s36-20020a17090a69a700b001faad0a7a34so11908786pjj.4;
        Sun, 21 Aug 2022 11:18:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=3UPV+AIr+VN1gJBjfNvC42kkO2spb7wnrBuGNcr6epA=;
        b=qvSOn95xRk74S7zpkCSkCjyYWsHCcZk6bI8EiNG721G1MkN0hChGYrFZXC4KLeE/I+
         4OJ+apvmmxlT0d86KhV/qCQw/sYVc6hVP6zkxAiettOdUxl9hQPWOx6PoYLRTtl7YQGJ
         DTu874p88RWKZUOTvQaToVZPYns9dhdjHDx/yq9qjAEou5Q/gJTlafvC7DP8ao4Lpyzt
         ApfRLIXQdlDXhLz4kYkymAP1Kjlu0/S7ygei/KXj1+Eab8wBJBNRjWvS0x7gPdleLnEB
         xeJy9jwo7wPZdQjDogYg+2QQR7q1rqP/qYK1VDEodix280gbUvEHWKl6BFrGrZaAxagE
         IuvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=3UPV+AIr+VN1gJBjfNvC42kkO2spb7wnrBuGNcr6epA=;
        b=5mC5sb5HD8LIjNmiqksAV+FBID5YSYqdQN8+LM6qOQ/ApiIycyXb1B/y3vO+oQgGxo
         Lp3Wr14VaXXWsvHQ4QrBWe1guoIIThh5QeGVq3Ii0SkPzc0quoqsGjQ9G6tr4ABXxfXi
         dX+zRD2bpE5MhoOJTruwV2ilYa1ZfKA/vZcYzPd6pz4ak1SzhL4AcesP5/FmmZHXF7ID
         9k009dL7k5L+DCNLrk23yoFIE9L1NUWZiMuI9cVVD7kXR6f9XVvZzBgV91H4XxsxlPx6
         NtfjszSIqMgwOLvQ2VlFYdgScGk9koDISPtuLe/GVZ0B/TTOuMptuYoOJb5nKyyODhHl
         zfZg==
X-Gm-Message-State: ACgBeo3CZGYTayqVzDcWFGx1WiZBX9vAzkg9a0Rv8ZLS+Nh9/dZSduij
        1X4e7ERXGxRKD7NllYJ1q8o=
X-Google-Smtp-Source: AA6agR7dtmESYOitnU5DYhjNSHX3sh73wN0UvrFXYQMVn/nBm2N8GH+sNa7fESl2HF3bNjC49hhRdQ==
X-Received: by 2002:a17:90b:3d7:b0:1fa:e708:ef43 with SMTP id go23-20020a17090b03d700b001fae708ef43mr13620916pjb.239.1661105933694;
        Sun, 21 Aug 2022 11:18:53 -0700 (PDT)
Received: from localhost ([2601:1c0:5200:a6:307:a401:7b76:c6e5])
        by smtp.gmail.com with ESMTPSA id u16-20020a170903125000b001726b585d4bsm6792298plh.202.2022.08.21.11.18.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Aug 2022 11:18:52 -0700 (PDT)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
        Rob Clark <robdclark@chromium.org>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Loic Poulain <loic.poulain@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Sibi Sankar <sibis@codeaurora.org>,
        linux-arm-kernel@lists.infradead.org (moderated list:ARM SMMU DRIVERS),
        iommu@lists.linux-foundation.org (open list:IOMMU DRIVERS),
        iommu@lists.linux.dev (open list:IOMMU DRIVERS),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 2/5] iommu/arm-smmu-qcom: Provide way to access current TTBR0
Date:   Sun, 21 Aug 2022 11:19:03 -0700
Message-Id: <20220821181917.1188021-3-robdclark@gmail.com>
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

The drm driver can skip tlbinv when unmapping from something that isn't
the current pgtables, as there is already a tlbinv on context switch.

Signed-off-by: Rob Clark <robdclark@chromium.org>
---
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 9 +++++++++
 include/linux/adreno-smmu-priv.h           | 2 ++
 2 files changed, 11 insertions(+)

diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
index 7820711c4560..59b460c1c9a5 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
@@ -157,6 +157,14 @@ static int qcom_adreno_smmu_set_ttbr0_cfg(const void *cookie,
 	return 0;
 }
 
+static u64 qcom_adreno_smmu_get_ttbr0(const void *cookie)
+{
+	struct arm_smmu_domain *smmu_domain = (void *)cookie;
+	struct arm_smmu_cfg *cfg = &smmu_domain->cfg;
+
+	return arm_smmu_cb_readq(smmu_domain->smmu, cfg->cbndx, ARM_SMMU_CB_TTBR0);
+}
+
 static int qcom_adreno_smmu_alloc_context_bank(struct arm_smmu_domain *smmu_domain,
 					       struct arm_smmu_device *smmu,
 					       struct device *dev, int start)
@@ -217,6 +225,7 @@ static int qcom_adreno_smmu_init_context(struct arm_smmu_domain *smmu_domain,
 	priv->cookie = smmu_domain;
 	priv->get_ttbr1_cfg = qcom_adreno_smmu_get_ttbr1_cfg;
 	priv->set_ttbr0_cfg = qcom_adreno_smmu_set_ttbr0_cfg;
+	priv->get_ttbr0 = qcom_adreno_smmu_get_ttbr0;
 	priv->get_fault_info = qcom_adreno_smmu_get_fault_info;
 	priv->set_stall = qcom_adreno_smmu_set_stall;
 	priv->resume_translation = qcom_adreno_smmu_resume_translation;
diff --git a/include/linux/adreno-smmu-priv.h b/include/linux/adreno-smmu-priv.h
index ac4c2c0ab724..4ad90541a095 100644
--- a/include/linux/adreno-smmu-priv.h
+++ b/include/linux/adreno-smmu-priv.h
@@ -43,6 +43,7 @@ struct adreno_smmu_fault_info {
  * @set_ttbr0_cfg: Set the TTBR0 config for the GPUs context bank.  A
  *                 NULL config disables TTBR0 translation, otherwise
  *                 TTBR0 translation is enabled with the specified cfg
+ * @get_ttbr0:     Get current TTBR0 value
  * @get_fault_info: Called by the GPU fault handler to get information about
  *                  the fault
  * @set_stall:     Configure whether stall on fault (CFCFG) is enabled.  Call
@@ -64,6 +65,7 @@ struct adreno_smmu_priv {
 	const void *cookie;
 	const struct io_pgtable_cfg *(*get_ttbr1_cfg)(const void *cookie);
 	int (*set_ttbr0_cfg)(const void *cookie, const struct io_pgtable_cfg *cfg);
+	u64 (*get_ttbr0)(const void *cookie);
 	void (*get_fault_info)(const void *cookie, struct adreno_smmu_fault_info *info);
 	void (*set_stall)(const void *cookie, bool enabled);
 	void (*resume_translation)(const void *cookie, bool terminate);
-- 
2.37.2

