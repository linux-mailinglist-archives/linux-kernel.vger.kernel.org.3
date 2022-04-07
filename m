Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53B0D4F723B
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 04:45:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239516AbiDGCre (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 22:47:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238895AbiDGCrY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 22:47:24 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4DF020DB38;
        Wed,  6 Apr 2022 19:45:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1649299525; x=1680835525;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=ffCfV/u5aK2/Nt9IZ+hCLvnY6QW2nh2wJ6EbOYyE8mo=;
  b=f3p+BQuWvPiWC30fKmMI9ul665hIdn0/HTKUzNcS/DomzHeyWCkivtLC
   NqabtVolVGvqVECtkryudPATR/rGjj/11tUJl8aB5qj46ptUbOOLsQ3EQ
   DV/0oaF1mqQ6B9S7W/MTirTfuMEaHvnayznelH4ti2yWfjZL+S4c2ITiI
   s=;
Received: from unknown (HELO ironmsg05-sd.qualcomm.com) ([10.53.140.145])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 06 Apr 2022 19:45:24 -0700
X-QCInternal: smtphost
Received: from nasanex01b.na.qualcomm.com ([10.46.141.250])
  by ironmsg05-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2022 19:45:25 -0700
Received: from cbsp-sh-gv.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 6 Apr 2022 19:45:22 -0700
From:   Tao Wang <quic_wat@quicinc.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        "open list:USB SUBSYSTEM" <linux-usb@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
CC:     <quic_wat@quicinc.com>, <quic_linyyuan@quicinc.com>
Subject: [PATCH] usb: hcd: add a flag for whether using shared_hcd priv
Date:   Thu, 7 Apr 2022 10:45:14 +0800
Message-ID: <1649299514-64014-1-git-send-email-quic_wat@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The shared_hcd->hcd_priv is not used in xhci, so not
need to malloc hcd priv memory for shared_hcd.

This change add a shared_hcd_no_priv flag to indicate
if shared_hcd use priv, and set the flag of xhci to 1.

Signed-off-by: Tao Wang <quic_wat@quicinc.com>
---
 drivers/usb/core/hcd.c       | 6 +++++-
 drivers/usb/host/xhci-plat.c | 1 +
 include/linux/usb/hcd.h      | 1 +
 3 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/core/hcd.c b/drivers/usb/core/hcd.c
index 99908d8..f339c3e 100644
--- a/drivers/usb/core/hcd.c
+++ b/drivers/usb/core/hcd.c
@@ -2419,7 +2419,11 @@ struct usb_hcd *__usb_create_hcd(const struct hc_driver *driver,
 {
 	struct usb_hcd *hcd;
 
-	hcd = kzalloc(sizeof(*hcd) + driver->hcd_priv_size, GFP_KERNEL);
+	if (primary_hcd && driver->shared_hcd_no_priv)
+		hcd = kzalloc(sizeof(*hcd), GFP_KERNEL);
+	else
+		hcd = kzalloc(sizeof(*hcd) + driver->hcd_priv_size, GFP_KERNEL);
+
 	if (!hcd)
 		return NULL;
 	if (primary_hcd == NULL) {
diff --git a/drivers/usb/host/xhci-plat.c b/drivers/usb/host/xhci-plat.c
index 21280a6..223e508 100644
--- a/drivers/usb/host/xhci-plat.c
+++ b/drivers/usb/host/xhci-plat.c
@@ -236,6 +236,7 @@ static int xhci_plat_probe(struct platform_device *pdev)
 		return -ENODEV;
 
 	driver = &xhci_plat_hc_driver;
+	driver->shared_hcd_no_priv = 1;
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0)
diff --git a/include/linux/usb/hcd.h b/include/linux/usb/hcd.h
index 2ffafbd..03ac312 100644
--- a/include/linux/usb/hcd.h
+++ b/include/linux/usb/hcd.h
@@ -256,6 +256,7 @@ struct hc_driver {
 	const char	*description;	/* "ehci-hcd" etc */
 	const char	*product_desc;	/* product/vendor string */
 	size_t		hcd_priv_size;	/* size of private data */
+	bool		shared_hcd_no_priv;	/* 0 use priv, 1 not use priv*/
 
 	/* irq handler */
 	irqreturn_t	(*irq) (struct usb_hcd *hcd);
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

