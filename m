Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40F4352C9BD
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 04:19:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232856AbiESCTX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 22:19:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230457AbiESCTU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 22:19:20 -0400
X-Greylist: delayed 124 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 18 May 2022 19:19:19 PDT
Received: from alexa-out-tai-02.qualcomm.com (alexa-out-tai-02.qualcomm.com [103.229.16.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DAB5C3D1B;
        Wed, 18 May 2022 19:19:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1652926760; x=1684462760;
  h=from:to:cc:subject:date:message-id;
  bh=1K5Kj0q4VA0uHycgXAZpiHxXiJ3BZne5cwNBKL+zDRg=;
  b=j0Rr3aWVOKzf8sfCk8/nd/ZmaZTfVpOgfE0FGQQW/1a45NOd4sWpdN3S
   VvgP/Q8FkMWVTdokTFpZGtHPJ47RpS9W2T0l1GxBbfoGw7j7U5rHScL+M
   52FYo9xnBLpslLGGFZ9pTEzz7DwyhAsxkeoYk48bIZTGPC0eMeNBzf5pj
   s=;
Received: from ironmsg02-tai.qualcomm.com ([10.249.140.7])
  by alexa-out-tai-02.qualcomm.com with ESMTP; 19 May 2022 10:17:13 +0800
X-QCInternal: smtphost
Received: from cbsp-sh-gv.ap.qualcomm.com (HELO cbsp-sh-gv.qualcomm.com) ([10.231.249.68])
  by ironmsg02-tai.qualcomm.com with ESMTP; 19 May 2022 10:17:09 +0800
Received: by cbsp-sh-gv.qualcomm.com (Postfix, from userid 3922021)
        id C3CD44A36; Thu, 19 May 2022 10:17:07 +0800 (CST)
From:   Tao Wang <quic_wat@quicinc.com>
To:     Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org (open list:USB XHCI DRIVER),
        linux-kernel@vger.kernel.org (open list)
Cc:     quic_wat@quicinc.com
Subject: [PATCH] usb: xhci: save hcd_priv memory of shared_hcd
Date:   Thu, 19 May 2022 10:17:01 +0800
Message-Id: <1652926622-85047-1-git-send-email-quic_wat@quicinc.com>
X-Mailer: git-send-email 2.7.4
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The shared_hcd->hcd_priv is not used in xhci, so not
need to malloc hcd priv memory for shared_hcd.

Signed-off-by: Tao Wang <quic_wat@quicinc.com>
---
 drivers/usb/host/xhci-plat.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/usb/host/xhci-plat.c b/drivers/usb/host/xhci-plat.c
index 01dcfd7..a27dd3a 100644
--- a/drivers/usb/host/xhci-plat.c
+++ b/drivers/usb/host/xhci-plat.c
@@ -336,6 +336,11 @@ static int xhci_plat_probe(struct platform_device *pdev)
 	device_set_wakeup_capable(&pdev->dev, true);
 
 	xhci->main_hcd = hcd;
+	/*
+	 * The shared_hcd->hcd_priv is not used in xhci,
+	 * so not need to malloc hcd priv memory for shared_hcd.
+	 */
+	driver->hcd_priv_size = 0;
 	xhci->shared_hcd = __usb_create_hcd(driver, sysdev, &pdev->dev,
 			dev_name(&pdev->dev), hcd);
 	if (!xhci->shared_hcd) {
-- 
2.7.4

