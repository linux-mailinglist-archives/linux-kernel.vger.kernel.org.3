Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 461D954BE0E
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 01:02:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357554AbiFNXBo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 19:01:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357479AbiFNXBj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 19:01:39 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20610532C5
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 16:01:38 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id gd1so9723072pjb.2
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 16:01:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=anholt-net.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RWlMcK/WiHaE2lupDQgc+icrhgmdMQxgOsPbDDDl0aE=;
        b=rxZaCTVb83tYMLMGAxqk8WP2FjGYRIoCovnvFYKSSOhMElgtlaDdZdSZMKPgSK4Yvo
         rC52cpeIJXo1GGTArDPxTrvH2g0j3p7QIUY5w78AbPKw2KsYXheKA8zc25on4qL9jc7k
         Pux+AQFyh9bQxZS2Av8mD7rxozr+inA00Hb7dAzDh+Di3oqIzFrchKq0vkDUvlbHaxek
         DRfGsep2dsYUDMjpJWrl4htAQKqUQVJIsWTNYxGeAn5KVIyPZqHF/KFc4lT4YMeLJIf5
         ry7iVS607W8w4IYMtJIee9psu43QKUIBJbDZIHwrUeV5l21LlnXFp0dg9U3JNTJh/a2F
         me6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RWlMcK/WiHaE2lupDQgc+icrhgmdMQxgOsPbDDDl0aE=;
        b=1Q/nzUZ4+3o1B6WeSfoChYOwgQnWNLjwltLSeSljj2ok0C3/2XZyrKpoQFsAAIB+uM
         34dGZF0/4F5S6crDp5ifB9jUXsiOe/9gET6DAYD0n8H1+Azhylc6ZrEScKlrmrpUs1sd
         Iw0zTfTv4zx8vdycnx75XhZux73P/m9jXyZQ0kQBIJCTpRLPjPSKAFW2zRNcu4f4UxnF
         iuCT8quU+FGyUAcluMFzmVH3dRqBxaGgcLboU5nYXv27iQaPZjru1/FZxgTom+N936iC
         yo6tehlBq706DkA76OpcQ62JBkhbKJpSJkb/Rr9mVsI9yVUmfdW1PS1CFWT51wh+g+IO
         OI3Q==
X-Gm-Message-State: AJIora96IMSCPMsyyUn4G8BO9TXADgd0iq50vTaoLa6pxn/nw7lBq4wU
        gSZL6SKEnZ84UPj45v5oMKnNF54jViXULwJVuhmepQ==
X-Google-Smtp-Source: AGRyM1sug/F5zUgorGwld6/cvjxSjJ3Ba76jZNwLVen3RaltHSazhsqEJzh8eunYtM28ILlpP5FJ5Q==
X-Received: by 2002:a17:90a:a605:b0:1ea:6b4f:915e with SMTP id c5-20020a17090aa60500b001ea6b4f915emr6825913pjq.60.1655247697545;
        Tue, 14 Jun 2022 16:01:37 -0700 (PDT)
Received: from wildbow.anholt.net (97-115-79-125.ptld.qwest.net. [97.115.79.125])
        by smtp.gmail.com with ESMTPSA id cp15-20020a170902e78f00b00168c5230332sm7787768plb.148.2022.06.14.16.01.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jun 2022 16:01:37 -0700 (PDT)
From:   Emma Anholt <emma@anholt.net>
To:     dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org, Rob Clark <robdclark@gmail.com>,
        Jordan Crouse <jcrouse@codeaurora.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>
Cc:     linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, Emma Anholt <emma@anholt.net>
Subject: [PATCH 1/2] iommu: arm-smmu-impl: Add 8250 display compatible to the client list.
Date:   Tue, 14 Jun 2022 16:01:35 -0700
Message-Id: <20220614230136.3726047-1-emma@anholt.net>
X-Mailer: git-send-email 2.36.1
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

