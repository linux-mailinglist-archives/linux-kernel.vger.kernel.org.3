Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF147581A98
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 21:57:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239673AbiGZT5m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 15:57:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231599AbiGZT5k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 15:57:40 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F125357EB;
        Tue, 26 Jul 2022 12:57:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1658865460; x=1690401460;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=02PBEtksdVy4wod/tdA31s6VszEQhGq509EySjvwyEk=;
  b=dWszRMlxRFdc92qXMflMqbxP0LpOFlV1hR3NUQzDzMHcnTtvLP2WWYrB
   AY7TEb0yNIiUyXv6b3MNX2LOBh9YAJYP1CnLIJqh//VDch3y6D7a5c8f/
   SM5MMQ4Zx32Wdr2JspTrLTgmpZ4vjJrCnLyiudZsl+LtVGnDyXo+fs9WW
   0=;
Received: from ironmsg07-lv.qualcomm.com ([10.47.202.151])
  by alexa-out.qualcomm.com with ESMTP; 26 Jul 2022 12:57:40 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg07-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2022 12:57:39 -0700
Received: from nalasex01b.na.qualcomm.com (10.47.209.197) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 26 Jul 2022 12:57:39 -0700
Received: from hu-wcheng-lv.qualcomm.com (10.49.16.6) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 26 Jul 2022 12:57:38 -0700
From:   Wesley Cheng <quic_wcheng@quicinc.com>
To:     <balbi@kernel.org>, <gregkh@linuxfoundation.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <quic_jackp@quicinc.com>, <quic_mrana@quicinc.com>,
        <Thinh.Nguyen@synopsys.com>, Wesley Cheng <quic_wcheng@quicinc.com>
Subject: [PATCH v2] usb: dwc3: gadget: Avoid duplicate requests to enable Run/Stop
Date:   Tue, 26 Jul 2022 12:57:26 -0700
Message-ID: <20220726195726.15730-1-quic_wcheng@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Relocate the pullups_connected check until after it is ensured that there
are no runtime PM transitions.  If another context triggered the DWC3
core's runtime resume, it may have already enabled the Run/Stop.  Do not
re-run the entire pullup sequence again, as it may issue a core soft
reset while Run/Stop is already set.

This patch depends on
  commit 69e131d1ac4e ("usb: dwc3: gadget: Prevent repeat pullup()")

Fixes: 77adb8bdf422 ("usb: dwc3: gadget: Allow runtime suspend if UDC
unbinded")
Signed-off-by: Wesley Cheng <quic_wcheng@quicinc.com>
---
 drivers/usb/dwc3/gadget.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index aeeec751c53c..67b1039c664c 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -2539,9 +2539,6 @@ static int dwc3_gadget_pullup(struct usb_gadget *g, int is_on)
 
 	is_on = !!is_on;
 
-	if (dwc->pullups_connected == is_on)
-		return 0;
-
 	dwc->softconnect = is_on;
 
 	/*
@@ -2566,6 +2563,9 @@ static int dwc3_gadget_pullup(struct usb_gadget *g, int is_on)
 		return 0;
 	}
 
+	if (dwc->pullups_connected == is_on)
+		return 0;
+
 	if (!is_on) {
 		ret = dwc3_gadget_soft_disconnect(dwc);
 	} else {
