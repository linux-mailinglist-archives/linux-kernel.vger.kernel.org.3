Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 375295A923E
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 10:41:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233431AbiIAIl3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 04:41:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232804AbiIAIlT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 04:41:19 -0400
Received: from mail-m11878.qiye.163.com (mail-m11878.qiye.163.com [115.236.118.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36DC9110882
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 01:41:18 -0700 (PDT)
Received: from rockchip.. (unknown [58.22.7.114])
        by mail-m11878.qiye.163.com (Hmail) with ESMTPA id 0ECB87407D8;
        Thu,  1 Sep 2022 16:34:48 +0800 (CST)
From:   William Wu <william.wu@rock-chips.com>
To:     balbi@kernel.org, gregkh@linuxfoundation.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        william.wu@rock-chips.com, fabioaiuto83@gmail.com,
        sven@svenpeter.dev, frank.wang@rock-chips.com,
        jianwei.zheng@rock-chips.com
Subject: [PATCH] usb: dwc3: core: leave default DMA if the controller does not support 64-bit DMA
Date:   Thu,  1 Sep 2022 16:34:46 +0800
Message-Id: <20220901083446.3799754-1-william.wu@rock-chips.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
        tZV1koWUFJSktLSjdXWS1ZQUlXWQ8JGhUIEh9ZQVkZGEJJVhlCHUJJTEMYS0hLQ1UTARMWGhIXJB
        QOD1lXWRgSC1lBWU5DVUlJVUxVSkpPWVdZFhoPEhUdFFlBWU9LSFVKSktITkhVSktLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Nhw6HDo4Gj01AUwyTjIMMkxO
        MDAKCyxVSlVKTU1JS0lKSUNDTE9PVTMWGhIXVQwSFxcSGhZVDA47CRQYEFYYExILCFUYFBZFWVdZ
        EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFJTE9INwY+
X-HM-Tid: 0a82f83041912eb4kusn0ecb87407d8
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On some DWC3 controllers (e.g. Rockchip SoCs), the DWC3 core
doesn't support 64-bit DMA address width. In this case, this
driver should use the default 32-bit mask. Otherwise, the DWC3
controller will break if it runs on above 4GB physical memory
environment.

This patch reads the DWC_USB3_AWIDTH bits of GHWPARAMS0 which
used for the DMA address width, and only configure 64-bit DMA
mask if the DWC_USB3_AWIDTH is 64.

Fixes: 45d39448b4d0 ("usb: dwc3: support 64 bit DMA in platform driver")
Signed-off-by: William Wu <william.wu@rock-chips.com>
---
 drivers/usb/dwc3/core.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index c5c238ab3083..2fcbd05b2af1 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -1751,12 +1751,6 @@ static int dwc3_probe(struct platform_device *pdev)
 
 	dwc3_get_properties(dwc);
 
-	if (!dwc->sysdev_is_parent) {
-		ret = dma_set_mask_and_coherent(dwc->sysdev, DMA_BIT_MASK(64));
-		if (ret)
-			return ret;
-	}
-
 	dwc->reset = devm_reset_control_array_get_optional_shared(dev);
 	if (IS_ERR(dwc->reset))
 		return PTR_ERR(dwc->reset);
@@ -1823,6 +1817,13 @@ static int dwc3_probe(struct platform_device *pdev)
 	dwc3_cache_hwparams(dwc);
 	device_init_wakeup(&pdev->dev, of_property_read_bool(dev->of_node, "wakeup-source"));
 
+	if (!dwc->sysdev_is_parent &&
+	    DWC3_GHWPARAMS0_AWIDTH(dwc->hwparams.hwparams0) == 64) {
+		ret = dma_set_mask_and_coherent(dwc->sysdev, DMA_BIT_MASK(64));
+		if (ret)
+			goto disable_clks;
+	}
+
 	spin_lock_init(&dwc->lock);
 	mutex_init(&dwc->mutex);
 
-- 
2.34.1

