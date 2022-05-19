Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDB9E52D293
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 14:35:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235955AbiESMfL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 08:35:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbiESMfJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 08:35:09 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00E1FA5A8D;
        Thu, 19 May 2022 05:35:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1652963708; x=1684499708;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=YHAJh3IKGS8Psqr2iNcmsbRkyFCVcMSdEtJ+/KqBN6M=;
  b=X3enqrBRNE2qqFtm9MEpi363kNIz6E0VlYLkSVHxTpTNJbsza+swMN+o
   3k9PnARJYs+IZ2v3aiM4eqZoCndzBsVpUg28PveIStzzQqF2TvS0OuVDI
   LwX0HONnW/bkbcalYKD46mW1DIC1eDzSSpqdckmssE4/R/vBr2MGo02im
   s=;
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 19 May 2022 05:35:07 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg-SD-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2022 05:35:07 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Thu, 19 May 2022 05:35:07 -0700
Received: from hu-harshq-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Thu, 19 May 2022 05:35:03 -0700
From:   Harsh Agarwal <quic_harshq@quicinc.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Felipe Balbi <balbi@kernel.org>
CC:     <linux-usb@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_pkondeti@quicinc.com>,
        <quic_ppratap@quicinc.com>, Harsh Agarwal <quic_harshq@quicinc.com>
Subject: [RFC 0/2] Add support for multiport controller 
Date:   Thu, 19 May 2022 18:04:53 +0530
Message-ID: <1652963695-10109-1-git-send-email-quic_harshq@quicinc.com>
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
		usb-phys = <usb2_phy0>, <usb3_phy0>;
	};	
	mp_2: mport@2 {
		usb-phys = <usb2_phy1>, <usb3_phy1>;
	};	
};

Harsh Agarwal (2):
  dt-bindings: usb: dwc3: Add support for multiport related properties
  usb: dwc3: Refactor PHY logic to support Multiport Controller

 .../devicetree/bindings/usb/snps,dwc3.yaml         |  55 +++++
 drivers/usb/dwc3/core.c                            | 259 ++++++++++++++++-----
 drivers/usb/dwc3/core.h                            |   8 +-
 drivers/usb/dwc3/drd.c                             |   8 +-
 drivers/usb/dwc3/gadget.c                          |   4 +-
 5 files changed, 264 insertions(+), 70 deletions(-)

-- 
2.7.4

