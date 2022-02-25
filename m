Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A7CB4C3CA9
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 04:49:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237212AbiBYDtp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 22:49:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237181AbiBYDtl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 22:49:41 -0500
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09D0019BE4E
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 19:49:08 -0800 (PST)
Received: by mail-oi1-x229.google.com with SMTP id y7so6097203oih.5
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 19:49:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UDK1kz5Fr0UKhxFUazSV4lfvWljmN762R0UmyDLBbzw=;
        b=DiAwxygHlg2cunADRHhaLRH/oj/hg887zxesH6wxMvEbnn2WM1kTGcjd3b76js74Ex
         NFv2iIrjxYfyS6GoFxahnN6CvoXjD8vdR+QAkzRsIWFdREtCZdykdi9UwLaZ6t+UFtxu
         DVQ+C6oZtLJwgY3/gToIATa2kHQ2I3OrhIF+6PBaj8Cr01A6UFq0oBhFvGkTivzrGgpR
         fYuoo7Zico/l+lnF7zjeWhV7Xu7rHTbhAPCFEaIQdIhKE0VbGflbF76+lBQPsfeeQD+4
         e+fYH7ETmElVqP7IlRdOkGQN2b7ymK5JQJ5XfikwHU0jwdW9/a0Z1UHD0n+5zF2hEZiZ
         PiOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UDK1kz5Fr0UKhxFUazSV4lfvWljmN762R0UmyDLBbzw=;
        b=DXrmK+KbTruY0Bt8YC1YTit3oXgfL74MV1+LbL2ZoPcgN2ZE7PMEGxpE3k6t0bJmqi
         O4q+7ygjYx0eJoaUmmD1n2Z/T+aKnPN8vMcy+MN1qFKXb5luu5qqFqi5nolP83FflPD8
         HN2rZaj+Yzkb6Y5Kft5S1Hh55boLJsCIW5lPEcLNPhEe3rnsbx3q73JTBzeOeXveOXs8
         AHCHrZk5hSkcr61DT25Pf62qXm1aUQo9mZlCu8PeYXWkSvld3JtkA6+ONDPADZLOFKXN
         cxACpVfvGhfHHjsq8z+ClMApf79MWvRDHv68LevmNbDvQ4ox+Jqh4PtthKziqvb/ZYGW
         EYkw==
X-Gm-Message-State: AOAM5320RtIh6yUlF0lI5U86gATTzCm5IoEBnHHlAj3Fo+1vG1Bb9DiS
        9ZYeZlF+ojHh60kpxrVk3dZknXFJLM9A9Q==
X-Google-Smtp-Source: ABdhPJxL6kvHspWE/hrl9ic6VRR2xRWso6pVw0L7xjQUzQBX5YVNv21tx0NumUdaPwA1VlEks9B5Hw==
X-Received: by 2002:a05:6808:1281:b0:2d4:6e64:1c6 with SMTP id a1-20020a056808128100b002d46e6401c6mr639967oiw.293.1645760948192;
        Thu, 24 Feb 2022 19:49:08 -0800 (PST)
Received: from ripper.. ([2600:1700:a0:3dc8:205:1bff:fec0:b9b3])
        by smtp.gmail.com with ESMTPSA id a10-20020a056808120a00b002d404a71444sm664088oil.35.2022.02.24.19.49.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 19:49:07 -0800 (PST)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] phy: qcom-qmp: add sc8280xp UFS PHY
Date:   Thu, 24 Feb 2022 19:51:05 -0800
Message-Id: <20220225035105.2294599-2-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20220225035105.2294599-1-bjorn.andersson@linaro.org>
References: <20220225035105.2294599-1-bjorn.andersson@linaro.org>
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

Changes since v1:
- None

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

