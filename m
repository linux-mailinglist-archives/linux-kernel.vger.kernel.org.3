Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9EEC573726
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 15:18:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236275AbiGMNSC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 09:18:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229968AbiGMNR7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 09:17:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF508C53;
        Wed, 13 Jul 2022 06:17:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4AECB61C3A;
        Wed, 13 Jul 2022 13:17:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93B78C36AE2;
        Wed, 13 Jul 2022 13:17:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657718277;
        bh=nRLINNBJCDhGmMGFzIpD64NSda4uc+7Z5ulu67uURFM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lPs2ZZ9zlkPigTxao1+C0Q7yCwqxv6bTj4xx7OD0pHxChls3CAhqpo4rhlCzUjo8I
         NW4fq86qpr+hZumufZlkHlxWIHILzEbnuIle/rRRoV8CAdGUj1R/xBOge9tfoOtc8I
         Ng2Mv51o/Lj3VlG1vr8ZAMIkHVZgjyRIh8I2v1KPyW3QZ5M8Qw3VTOBg+++05LbGGw
         0etcV7ganfD+8aCuXK2zw0w+euwHQvyi3gGT1hJWlVCfSkTp+wzLZZh7D4ppZGfv6+
         shIr8xEgasIgz4qd4T/2R+8JxYXneQZBVxQaR+6SF+sfSij2/LYZUmSz1qkxHJju1K
         fxz7neoaea+Vw==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1oBcFd-0007gK-8m; Wed, 13 Jul 2022 15:18:01 +0200
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Felipe Balbi <balbi@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH 3/7] usb: dwc3: qcom: fix missing optional irq warnings
Date:   Wed, 13 Jul 2022 15:13:36 +0200
Message-Id: <20220713131340.29401-4-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220713131340.29401-1-johan+linaro@kernel.org>
References: <20220713131340.29401-1-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Not all platforms have all of the four currently supported wakeup
interrupts so use the optional irq helpers when looking up interrupts to
avoid printing error messages when an optional interrupt is not found:

	dwc3-qcom a6f8800.usb: error -ENXIO: IRQ hs_phy_irq not found

Fixes: a4333c3a6ba9 ("usb: dwc3: Add Qualcomm DWC3 glue driver")
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/usb/dwc3/dwc3-qcom.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/dwc3/dwc3-qcom.c b/drivers/usb/dwc3/dwc3-qcom.c
index 77036551987a..c5e482f53e9d 100644
--- a/drivers/usb/dwc3/dwc3-qcom.c
+++ b/drivers/usb/dwc3/dwc3-qcom.c
@@ -490,9 +490,9 @@ static int dwc3_qcom_get_irq(struct platform_device *pdev,
 	int ret;
 
 	if (np)
-		ret = platform_get_irq_byname(pdev_irq, name);
+		ret = platform_get_irq_byname_optional(pdev_irq, name);
 	else
-		ret = platform_get_irq(pdev_irq, num);
+		ret = platform_get_irq_optional(pdev_irq, num);
 
 	return ret;
 }
-- 
2.35.1

