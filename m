Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C42D4F7BAE
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 11:32:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243806AbiDGJd6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 05:33:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230193AbiDGJd4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 05:33:56 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E78B615FDC;
        Thu,  7 Apr 2022 02:31:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1649323917; x=1680859917;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=1w69Q6nTSQ3x3tu7JISRRajme3osv7e1/VnGFgbm3vQ=;
  b=nun0H+uOUWX1G9mIG1mbTotdc5iOgg0CnJOhdKjj4Sc2IUD3kDa64qga
   ZZuf5EFJQ+IwdXA48mHIizowAfo/dbeg9ltzSwTBtLEa2sXRA+r5WCx9L
   FzdAnDOKsTAlGuAZlZwk9iO/Rf3vC1qPSg2bDD2LeqTQlF+JqDfxmDDxP
   8=;
Received: from unknown (HELO ironmsg01-sd.qualcomm.com) ([10.53.140.141])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 07 Apr 2022 02:31:56 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg01-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2022 02:31:46 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Thu, 7 Apr 2022 02:31:45 -0700
Received: from c-sanm-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Thu, 7 Apr 2022 02:31:40 -0700
From:   Sandeep Maheswaram <quic_c_sanm@quicinc.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Doug Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Mathias Nyman <mathias.nyman@intel.com>
CC:     <linux-arm-msm@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_pkondeti@quicinc.com>,
        <quic_ppratap@quicinc.com>, <quic_kriskura@quicinc.com>,
        <quic_vpulyala@quicinc.com>,
        Sandeep Maheswaram <quic_c_sanm@quicinc.com>
Subject: [PATCH v3 0/2] Skip phy initialization for DWC3 USB Controllers 
Date:   Thu, 7 Apr 2022 15:01:26 +0530
Message-ID: <1649323888-12420-1-git-send-email-quic_c_sanm@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Runtime suspend of phy drivers was failing from DWC3 driver as
runtime usage value is 2 because the phy is initialized from
DWC3 core and HCD core.
Some controllers like DWC3 and CDNS3 manage phy in their core drivers.
This property can be set to avoid phy initialization in HCD core.

v3:
Coming back to this series based on discussion at below thread
https://patchwork.kernel.org/project/linux-arm-msm/patch/1648103831-12347-4-git-send-email-quic_c_sanm@quicinc.com/
Dropped the dt bindings PATCH 1/3 in v2
https://patchwork.kernel.org/project/linux-arm-msm/cover/1636353710-25582-1-git-send-email-quic_c_sanm@quicinc.com/ 

v2:
Updated the commit descriptions.
Changed subject prefix from dwc to dwc3.
Increased props array size.

Sandeep Maheswaram (2):
  usb: host: xhci-plat: Add device property to set XHCI_SKIP_PHY_INIT
    quirk
  usb: dwc3: host: Set the property usb-skip-phy-init

 drivers/usb/dwc3/host.c      | 4 +++-
 drivers/usb/host/xhci-plat.c | 3 +++
 2 files changed, 6 insertions(+), 1 deletion(-)

-- 
2.7.4

