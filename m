Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD227552411
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 20:37:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245681AbiFTSgx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 14:36:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245637AbiFTSgr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 14:36:47 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 089E31F61D
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 11:36:46 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id p5so5148859pjt.2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 11:36:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=anholt-net.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dYnEPoGZqfZYJAuPegqx++UzPWjcPYHxQtwczgOEqOY=;
        b=j27uV95QDHmh28z29YzfPn3mYVjgQeD4AjLpoagSqW19OAWVkRFOHjYUOCslMxwhqS
         8lw/4ul9kFOZw8r+4NfjnLyke4Ov1rf8JPUzzFfx2oPJU1GcZHlLopjosMj5XGo3nvUu
         ep4bc9OllPhyOPJ/95NZh5DTjYq3MXOjlURHmycUaCYajuixGmRxiCia5GFA3yo3JMuk
         3WFrf8GZ2yGDYglM9CNwrlf0gkpbcAVQ/hlVXD7L0hBLUFBsrDcrbDz+wnEK/0ixHu8L
         h2pPMd3Jhe4fy/M+xWzMzstO7ugktrNpSJCtX9eZUIdySavMl3jHcZy7PJt+Mgcqu5ec
         Efgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dYnEPoGZqfZYJAuPegqx++UzPWjcPYHxQtwczgOEqOY=;
        b=rtqZeBOKtG171BZFCg70ZMPfLHqP0id+XAKLdA/A6FBRxZTuqW7XTrkV4wA//JXJDp
         7ufs3sftixFNk3XtCgySHEVMTRCjlKOFEMA8k8ArB32ADP/MlDnosSGGip5YW2kWx1e0
         cg9iZMPCdxHjCYjWyYnnsqQs9fU1r9PuqmirgJQyyluQEMFEaPIJ36um1BNY3sQjWjkk
         HuvDknlo8AnejDGM46mO+U+8m9i5O9yLM+D76Jq/+AM8spru3ti2pUOPo44T6sGg7EnK
         41pI3rAmJemUx9jokcDEjGWWeh+Q1g5u6GQrIuhk890rG3taxlBr59xfclJazTVtm55t
         5MCA==
X-Gm-Message-State: AJIora8s8/M01XzRwjhfjwax7ojD7YEbLiJG8Z+MNUIzIq6dsd2i25Pd
        S5wMjmM52xMWqhZ14Lml5Cxypg==
X-Google-Smtp-Source: AGRyM1uz/6Ko3AqqWsTQqB/KJYqsG9FJzSMzyl3BFf9B5wef0b4KsUd6G43yzj9L9DvutkGyCDta0A==
X-Received: by 2002:a17:90b:3b8a:b0:1e2:ee1e:6340 with SMTP id pc10-20020a17090b3b8a00b001e2ee1e6340mr28501640pjb.38.1655750205525;
        Mon, 20 Jun 2022 11:36:45 -0700 (PDT)
Received: from wildbow.anholt.net ([97.115.187.17])
        by smtp.gmail.com with ESMTPSA id ds12-20020a17090b08cc00b001e0c1044ceasm8500041pjb.43.2022.06.20.11.36.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jun 2022 11:36:44 -0700 (PDT)
From:   Emma Anholt <emma@anholt.net>
To:     dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org, Rob Clark <robdclark@gmail.com>,
        Jordan Crouse <jordan@cosmicpenguin.net>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>
Cc:     linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org,
        Emma Anholt <emma@anholt.net>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: [PATCH v2 1/2] iommu: arm-smmu-impl: Add 8250 display compatible to the client list.
Date:   Mon, 20 Jun 2022 11:36:32 -0700
Message-Id: <20220620183633.1131760-2-emma@anholt.net>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220620183633.1131760-1-emma@anholt.net>
References: <20220620183633.1131760-1-emma@anholt.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Required for turning on per-process page tables for the GPU.

Signed-off-by: Emma Anholt <emma@anholt.net>
Reviewed-by: Konrad Dybcio <konrad.dybcio@somainline.org>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
index d8e1ef83c01b..bb9220937068 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
@@ -233,6 +233,7 @@ static const struct of_device_id qcom_smmu_client_of_match[] __maybe_unused = {
 	{ .compatible = "qcom,sc7280-mdss" },
 	{ .compatible = "qcom,sc7280-mss-pil" },
 	{ .compatible = "qcom,sc8180x-mdss" },
+	{ .compatible = "qcom,sm8250-mdss" },
 	{ .compatible = "qcom,sdm845-mdss" },
 	{ .compatible = "qcom,sdm845-mss-pil" },
 	{ }
-- 
2.36.1

