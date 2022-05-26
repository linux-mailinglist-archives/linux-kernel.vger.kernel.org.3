Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18C82534D1A
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 12:14:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237919AbiEZKOV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 06:14:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236103AbiEZKOI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 06:14:08 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D035113F54;
        Thu, 26 May 2022 03:14:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1653560047; x=1685096047;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=p1t4R8MjMOVp8DsmVzp6Synql5mdHrF2FZ9/ECrFKy0=;
  b=KmJgtXagNE3rL11YAARWtRDT0mly4eHLtgIHmLftY0Eo3xI3iGMGuufu
   eo3YfYZ1a3i1qKrkpXu7ESApfJqvnS0NZ5XoUvo7ZHNNfBon/9liUSXx3
   aPjK9C/fr87k4uVU2GPRW1fYnFGinaO+wV7QG8OeC35a9E7mNOADdCuYN
   g=;
Received: from ironmsg07-lv.qualcomm.com ([10.47.202.151])
  by alexa-out.qualcomm.com with ESMTP; 26 May 2022 03:14:06 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg07-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2022 03:14:06 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Thu, 26 May 2022 03:14:05 -0700
Received: from hu-harshq-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Thu, 26 May 2022 03:14:01 -0700
From:   Harsh Agarwal <quic_harshq@quicinc.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Felipe Balbi <balbi@kernel.org>
CC:     <devicetree@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_pkondeti@quicinc.com>,
        <quic_ppratap@quicinc.com>, Harsh Agarwal <quic_harshq@quicinc.com>
Subject: [RFC v2 0/2] Add support for multiport controller 
Date:   Thu, 26 May 2022 15:43:47 +0530
Message-ID: <1653560029-6937-1-git-send-email-quic_harshq@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently the DWC3 driver supports only single port controller which 
requires at most two PHYs ie HS and SS PHYs. There are SoCs that has
DWC3 controller with multiple ports that can operate in host mode. Some of
the port supports both SS+HS and other port supports only HS mode.

This change refactors the PHY logic to support multiport controller. The 
patches have gone through basic sanity only.

For any multiport controller we would define a new node "multiport" inside
dwc3 and then add subsequent "mport" nodes inside it for individual ports
that it supports. Now each individual "mport" defines the PHYs that it 
supports.

Looking for comments/feedback on the device tree bindings. Once the 
bindings are locked, we can further factor the code.

e.g.
Consider a Dual port controller where each port supports HS+SS 

multiport {
	mp_1: mport@1 {
		usb-phy = <usb2_phy0>, <usb3_phy0>;
        /* Can define Generic PHYs also */  
	};	
	mp_2: mport@2 {
		usb-phy = <usb2_phy1>, <usb3_phy1>;
	};	

Changes in v2:
Added support for Generic PHYs by making use of devm_of_phy_get. It works
for both normal controller and multiport controller.
Cleaned up dwc3_core_get_phy and created new API dwc3_core_get_phy_by_node
which works for both normal and multiport node case.
Addded new APIs to count PHYs defined in the multiport controller.
Changed Generic PHY to double pointer to work for multiport controller.
Added support for GUSB2PHYCFG and GUSB3PIPECTL registers
for multiport controller.


Harsh Agarwal (2):
  dt-bindings: usb: dwc3: Add support for multiport related properties
  usb: dwc3: Refactor PHY logic to support Multiport Controller

 .../devicetree/bindings/usb/snps,dwc3.yaml         |  55 +++
 drivers/usb/dwc3/core.c                            | 420 +++++++++++++++------
 drivers/usb/dwc3/core.h                            |  12 +-
 drivers/usb/dwc3/drd.c                             |  16 +-
 drivers/usb/dwc3/gadget.c                          |   4 +-
 5 files changed, 381 insertions(+), 126 deletions(-)

-- 
2.7.4

