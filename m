Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 882EE532727
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 12:14:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234706AbiEXKOF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 06:14:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231207AbiEXKOB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 06:14:01 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CD027CDF7;
        Tue, 24 May 2022 03:14:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1653387240; x=1684923240;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=uejRuTI2yo6lZ2f+XE7ScDBsT/UICPyZNLS9Waf/JRk=;
  b=Vb3SPaf0IBEOjqmkOelnhIhsYggrMl6uzhpguj6J8SmmlxPs0IxX/n8l
   3YvngLJJwl0H1Qvj/qZyROx8MxWPlM9aRCP8B8Fm6eadS94kNgoGLBl4B
   OsczGWmq5Yk5s9sBmveTTBUzAZhUhabwXNujp7nQ8qAdBoywyAARVcP+v
   4=;
Received: from ironmsg09-lv.qualcomm.com ([10.47.202.153])
  by alexa-out.qualcomm.com with ESMTP; 24 May 2022 03:14:00 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg09-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2022 03:13:59 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 24 May 2022 03:13:58 -0700
Received: from hu-kriskura-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 24 May 2022 03:13:52 -0700
From:   Krishna Kurapati <quic_kriskura@quicinc.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Doug Anderson <dianders@chromium.org>,
        "Matthias Kaehlcke" <mka@chromium.org>,
        Mathias Nyman <mathias.nyman@intel.com>
CC:     <devicetree@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <quic_pkondeti@quicinc.com>,
        <quic_ppratap@quicinc.com>, <quic_vpulyala@quicinc.com>,
        Krishna Kurapati <quic_kriskura@quicinc.com>
Subject: [PATCH v17 0/5] USB DWC3 host wake up support from system suspend
Date:   Tue, 24 May 2022 15:43:43 +0530
Message-ID: <1653387228-28110-1-git-send-email-quic_kriskura@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Avoiding phy powerdown in host mode when dwc3 is wakeup capable, so that
it can be wake up by devices. Keep usb30_prim gdsc active to retain
controller status during suspend/resume.

Changes in v17:
Moved the speed check to glue driver.
Powering down phy's solely based on dwc3 wakeup capability.
Configuring the dp/dm interrupts appropriately.

Changes in v16:
Added changes to power down the phy's during suspend only if dwc3
is not wakeup capable.

Changes in v15:
Added patch to enable wakeup for xhci-plat based on children wakeup status.
Used device_wakeup_path instead of device_children_wakeup_capable

Changes in v14:
Added patch for device_children_wakeup_capable.
Used device_children_wakeup_capable instead of usb_wakeup_enabled_descendants.
Fixed minor nit picks in v13 reported by Matthias.

Changes in v13:
Moved the dt bindings patch to start.
Changed dwc3_set_phy_speed_mode to dwc3_check_phy_speed_mode.
Check wakep-source property for dwc3 core node to set the
wakeup capability. Drop the device_init_wakeup call from
runtime suspend and resume.
Added GENPD_FLAG_RPM_ALWAYS_ON and set GENPD_FLAG_ALWAYS_ON if
wakeup is supported.

Changes in v12:
Squashed PATCH 1/5 and 2/5 of v11.
Added dt bindings and device tree entry for wakeup-source property
for dwc3 core node.
Dropped redundant phy_set_mode call.

Changes in v11:
Moving back to v8 version
https://patchwork.kernel.org/project/linux-arm-msm/cover/1624882097-23265-1-git-send-email-sanm@codeaurora.org
as we are getting interrupts during suspend
when enabling both DP hs phy irq and DM hs phy irq.
Moved the set phy mode function to dwc3/core.c from xhci-plat.c
We didn't find any other option other than accessing xhci from dwc.

Changes in v10:
PATCH 1/6: Change device_set_wakeup_capable to device_set_wakeup_enable
PATCH 2/6: Remove redundant else part in dwc3_resume_common
PATCH 4/6: Change the irg flags
PATCH 5/6: Set flag GENPD_FLAG_ALWAYS_ON
PATCH 6/6: Remove disable interrupts function and enable
interrupts in probe.


Changes in v9:
Checking with device_may_makeup property instead of phy_power_off flag.
Changed the IRQ flags and removed hs_phy_mode variable.

Changes in v8:
Moved the dwc3 suspend quirk code in dwc3/host.c to xhci-plat.c
Checking phy_power_off flag instead of usb_wakeup_enabled_descendants 
to keep gdsc active.

Changes in v7:
Change in commit text and message in PATCH 1/5 and PATCH 5/5
as per Matthias suggestion.
Added curly braces for if and else if sections in PATCH 4/5.

Changes in v6:
Addressed comments in host.c and core.c
Separated the patches in dwc3-qcom.c to make it simple.
Dropped wakeup-source change as it is not related to this series.

Changes in v5:
Added phy_power_off flag to check presence of wakeup capable devices.
Dropped patch[v4,4/5] as it is present linux-next.
Addressed comments in host.c and dwc3-qcom.c.

Changes in v4:
Addressed Matthias comments raised in v3.

Changes in v3:
Removed need_phy_for_wakeup flag and by default avoiding phy powerdown.
Addressed Matthias comments and added entry for DEV_SUPERSPEED.
Added suspend_quirk in dwc3 host and moved the dwc3_set_phy_speed_flags.
Added wakeup-source dt entry and reading in dwc-qcom.c glue driver.

Changes in v2:
Dropped the patch in clock to set GENPD_FLAG_ACTIVE_WAKEUP flag and 
setting in usb dwc3 driver.
Separated the core patch and glue driver patch.
Made need_phy_for_wakeup flag part of dwc structure and 
hs_phy_flags as unsgined int.
Adrressed the comment on device_init_wakeup call.
Corrected offset for reading portsc register.
Added pacth to support wakeup in xo shutdown case.

Sandeep Maheswaram (5):
  dt-bindings: usb: dwc3: Add wakeup-source property support
  usb: dwc3: core: Host wake up support from system suspend
  usb: dwc3: qcom: Add helper functions to enable,disable wake irqs
  usb: dwc3: qcom: Configure wakeup interrupts during suspend
  usb: dwc3: qcom: Keep power domain on to retain controller status

 .../devicetree/bindings/usb/snps,dwc3.yaml         |   5 +
 drivers/usb/dwc3/core.c                            |  26 ++--
 drivers/usb/dwc3/dwc3-qcom.c                       | 136 +++++++++++++++------
 3 files changed, 115 insertions(+), 52 deletions(-)

-- 
2.7.4

