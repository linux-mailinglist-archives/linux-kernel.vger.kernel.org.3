Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A267C5B026B
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 13:08:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230090AbiIGLH7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 07:07:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229996AbiIGLHw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 07:07:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A8799C8E1;
        Wed,  7 Sep 2022 04:07:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 29E6061886;
        Wed,  7 Sep 2022 11:07:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B03A6C43153;
        Wed,  7 Sep 2022 11:07:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662548868;
        bh=aHaRaYHYV8iVhLhmcB9HfKisaYYGvTTVWhp0+xMi1pE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oaNpCGx/HGZ5y8KsmqUfPaNPZ9lz0H/fvsFxocJsQwyL6BXD6wFwAC6z/2VCKP3UR
         T3UThYbcZsZuxrouVCtOhCIMYt6vO8GPP3bzCvqYwozWjdtQuHUSvJUgwOmJW6RIsu
         3Fh7HxH2l/UT0sDSl9pxQj8YrS/yaPhb/nXjjmDRMmFYyZOB4gHvWuqtt7LvtBg3PA
         Etr8RXcqYQMprMnc5lTw7vX+5/G5xlMkZ9ozYdlQQW4NOVN/sHgKrET/A5taa8bc0d
         X5nn/ijANaEoDSbOfgiZhqluM75b+gAagTGxDCqQMrTIj6r/an6U8Qyug0AsYp9WT6
         irsb7kfk29Jbw==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1oVsuP-0004zI-1M; Wed, 07 Sep 2022 13:07:53 +0200
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH 11/16] phy: qcom-qmp: silence noisy probe
Date:   Wed,  7 Sep 2022 13:07:23 +0200
Message-Id: <20220907110728.19092-12-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220907110728.19092-1-johan+linaro@kernel.org>
References: <20220907110728.19092-1-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drivers should in general not log anything during unless there are
errors.

Drop the pointless registration info message from the QMP drivers.

Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/phy/qualcomm/phy-qcom-qmp-combo.c        | 2 --
 drivers/phy/qualcomm/phy-qcom-qmp-pcie-msm8996.c | 2 --
 drivers/phy/qualcomm/phy-qcom-qmp-pcie.c         | 2 --
 drivers/phy/qualcomm/phy-qcom-qmp-ufs.c          | 2 --
 drivers/phy/qualcomm/phy-qcom-qmp-usb.c          | 2 --
 5 files changed, 10 deletions(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-combo.c b/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
index 838f7e328b55..c03878fdf8a7 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
@@ -2972,8 +2972,6 @@ static int qcom_qmp_phy_combo_probe(struct platform_device *pdev)
 	}
 
 	phy_provider = devm_of_phy_provider_register(dev, of_phy_simple_xlate);
-	if (!IS_ERR(phy_provider))
-		dev_info(dev, "Registered Qcom-QMP phy\n");
 
 	return PTR_ERR_OR_ZERO(phy_provider);
 
diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-pcie-msm8996.c b/drivers/phy/qualcomm/phy-qcom-qmp-pcie-msm8996.c
index 49df846c31e6..45701b498efc 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-pcie-msm8996.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-pcie-msm8996.c
@@ -963,8 +963,6 @@ static int qcom_qmp_phy_pcie_msm8996_probe(struct platform_device *pdev)
 	}
 
 	phy_provider = devm_of_phy_provider_register(dev, of_phy_simple_xlate);
-	if (!IS_ERR(phy_provider))
-		dev_info(dev, "Registered Qcom-QMP phy\n");
 
 	return PTR_ERR_OR_ZERO(phy_provider);
 
diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
index c5d8eedab4ea..e6bffb0e2da3 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
@@ -2448,8 +2448,6 @@ static int qmp_pcie_probe(struct platform_device *pdev)
 	}
 
 	phy_provider = devm_of_phy_provider_register(dev, of_phy_simple_xlate);
-	if (!IS_ERR(phy_provider))
-		dev_info(dev, "Registered Qcom-QMP phy\n");
 
 	return PTR_ERR_OR_ZERO(phy_provider);
 
diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c b/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c
index 62e9007137c9..28b75772cd0f 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c
@@ -1287,8 +1287,6 @@ static int qcom_qmp_phy_ufs_probe(struct platform_device *pdev)
 	}
 
 	phy_provider = devm_of_phy_provider_register(dev, of_phy_simple_xlate);
-	if (!IS_ERR(phy_provider))
-		dev_info(dev, "Registered Qcom-QMP phy\n");
 
 	return PTR_ERR_OR_ZERO(phy_provider);
 
diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-usb.c b/drivers/phy/qualcomm/phy-qcom-qmp-usb.c
index c50ebe8d19bc..08e0799e8832 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-usb.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-usb.c
@@ -2859,8 +2859,6 @@ static int qcom_qmp_phy_usb_probe(struct platform_device *pdev)
 	}
 
 	phy_provider = devm_of_phy_provider_register(dev, of_phy_simple_xlate);
-	if (!IS_ERR(phy_provider))
-		dev_info(dev, "Registered Qcom-QMP phy\n");
 
 	return PTR_ERR_OR_ZERO(phy_provider);
 
-- 
2.35.1

