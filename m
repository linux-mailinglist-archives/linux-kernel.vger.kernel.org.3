Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EDE74C0B37
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 05:40:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238071AbiBWEkp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 23:40:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237733AbiBWEkl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 23:40:41 -0500
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABA2558E55
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 20:40:14 -0800 (PST)
Received: by mail-oi1-x22b.google.com with SMTP id s5so16969115oic.10
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 20:40:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XiUxUsXWoDSPBkoDa65L0Qpfkg0qt8UeOBJM//CPRsE=;
        b=aa5BbAbSu6x3X7MiDWb43zozBEWAazuwiR4F8BBZXQmIukJ6AevjJlCHIPuka3PYQM
         ZjfdlnGcr3KRavbRRoi6DwUOlP6DYVN7RJ2bRYbsGuPYxdg4IEgP2bvjdGGzJ8Q0oumu
         I069ctxgJ8QR2a+CMyuuNn70Q1FA4CqxKGpS7GbkF5yQC+oaCouTU+s0zCzrHPn3O9kK
         O2bmo4J3LyWfvBw1m7HrCQOsN8+hDNz1by90EO/FGKCMvuAs2mG1O8vNRS9gE3PvJ/YK
         lFr8khCBl4ST6jesWOm+nipXt9ZTC9XBCjoWzNnB89eE2yoO2jLSwJ1mtC9StHdBmkxh
         WqVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XiUxUsXWoDSPBkoDa65L0Qpfkg0qt8UeOBJM//CPRsE=;
        b=H9NMFI1C23/xlAeYscOwJT0KrmDhzM662SzhdSHxGunVuVl6SYhK0yJlT2lmwPRwMm
         JfTr5UbJN+zCkgkcfrG5x1aZAz9kgjYFMfjE+zyQLsagoudB4rlLPqY4QmU/QGye7fw+
         rY1cP+J4RJ8pPlyot0g2El53U9W31FEWEZRnMR85ypm2W5jsKQg0RFETt6IZCUU9C3pw
         5gOJOF85JIj2VNLHet+8QPaaZp37gZbYPQZ8pyj7Vc/D+w7+MeWVcNSfCeZM9js6vItf
         snKG7uhBy5pkEGaIW8ACzkF7KYt77WN7xt9AjpbGeyMe6faSWdw+dgHtf6sVOjwiZaZf
         VK/g==
X-Gm-Message-State: AOAM530+RlcCXh4IysSxTmPJzARWSryvsjf+ecdxWvyPXYnSLTlEiBhk
        k6JD/OvYA+qAn9wc8lglmt9yOg==
X-Google-Smtp-Source: ABdhPJyP0nyPUXhj10ErDAzhFQarkRTaVsanvEHsiXxxdAeCMKTQZHa0SlawcezkX1m/UMXsKQfx2w==
X-Received: by 2002:a05:6808:178a:b0:2d4:eef:144f with SMTP id bg10-20020a056808178a00b002d40eef144fmr3748077oib.225.1645591214001;
        Tue, 22 Feb 2022 20:40:14 -0800 (PST)
Received: from ripper.. ([2600:1700:a0:3dc8:205:1bff:fec0:b9b3])
        by smtp.gmail.com with ESMTPSA id x22sm6250033ooo.20.2022.02.22.20.40.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Feb 2022 20:40:13 -0800 (PST)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] phy: qcom-qmp: add sc8280xp UFS PHY
Date:   Tue, 22 Feb 2022 20:42:13 -0800
Message-Id: <20220223044213.3776600-2-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20220223044213.3776600-1-bjorn.andersson@linaro.org>
References: <20220223044213.3776600-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reuse the SM8350 UFS PHY initialization sequence to add support for the
same found in the Qualcomm SC8280XP platform.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 drivers/phy/qualcomm/phy-qcom-qmp.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp.c b/drivers/phy/qualcomm/phy-qcom-qmp.c
index 8ea87c69f463..b144ae1f729a 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp.c
@@ -5977,6 +5977,9 @@ static const struct of_device_id qcom_qmp_phy_of_match_table[] = {
 	}, {
 		.compatible = "qcom,sc8180x-qmp-ufs-phy",
 		.data = &sm8150_ufsphy_cfg,
+	}, {
+		.compatible = "qcom,sc8280xp-qmp-ufs-phy",
+		.data = &sm8350_ufsphy_cfg,
 	}, {
 		.compatible = "qcom,sc8180x-qmp-usb3-phy",
 		.data = &sm8150_usb3phy_cfg,
-- 
2.33.1

