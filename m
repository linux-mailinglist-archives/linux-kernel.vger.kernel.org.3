Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09C0A538CAA
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 10:21:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244802AbiEaIUf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 04:20:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244790AbiEaIUb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 04:20:31 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63DBC9399D;
        Tue, 31 May 2022 01:20:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1653985230; x=1685521230;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=71XG4ZmwJ09OcgbOEPiZ9EnPHO86FepcH2+AFt4DG3A=;
  b=xj0laKrzcJ5t6csilCoHHz9k3xGxS9Pm8kbg1bjj2WF4wkZXp5c6K9ds
   Jt5rYH0lEbVsCHVsKqCWd4JEhCNZqyc/NeDpRVU+P7JWHEekqyhy7txnZ
   pv+WW5QRQ45q1h2xvBMcBLkgq/PWmkcSI14WjKCJNtH7mx0foJTkPW7/D
   A=;
Received: from unknown (HELO ironmsg02-sd.qualcomm.com) ([10.53.140.142])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 31 May 2022 01:20:30 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg02-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2022 01:20:29 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 31 May 2022 01:20:28 -0700
Received: from hu-harshq-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 31 May 2022 01:20:24 -0700
From:   Harsh Agarwal <quic_harshq@quicinc.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Felipe Balbi <balbi@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
CC:     <linux-usb@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_pkondeti@quicinc.com>,
        <quic_ppratap@quicinc.com>, <quic_jackp@quicinc.com>,
        Harsh Agarwal <quic_harshq@quicinc.com>
Subject: [PATCH 0/3] Add support for multiport controller 
Date:   Tue, 31 May 2022 13:50:14 +0530
Message-ID: <1653985217-20953-1-git-send-email-quic_harshq@quicinc.com>
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
implementation has been tested with Generic PHYs as well.

For any multiport controller we would define a new node "multiport" inside
dwc3 and then add subsequent "mport" nodes inside it for individual ports
that it supports. Now each individual "mport" node defines their own PHYs.

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

Harsh Agarwal (3):
  dt-bindings: usb: dwc3: Add support for multiport related properties
  usb: phy: Add devm_of_usb_get_phy_by_phandle
  usb: dwc3: Refactor PHY logic to support Multiport Controller

 .../devicetree/bindings/usb/snps,dwc3.yaml         |  55 +++
 drivers/usb/dwc3/core.c                            | 400 +++++++++++++++------
 drivers/usb/dwc3/core.h                            |  12 +-
 drivers/usb/dwc3/drd.c                             |  16 +-
 drivers/usb/dwc3/gadget.c                          |   4 +-
 drivers/usb/phy/phy.c                              |  34 ++
 include/linux/usb/phy.h                            |   8 +
 7 files changed, 402 insertions(+), 127 deletions(-)

-- 
2.7.4

