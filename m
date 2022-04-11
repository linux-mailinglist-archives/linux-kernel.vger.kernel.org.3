Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57F754FC4D4
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 21:17:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349540AbiDKTTe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 15:19:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235610AbiDKTTb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 15:19:31 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85C0536B7D;
        Mon, 11 Apr 2022 12:17:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1649704636; x=1681240636;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=mbUW3srWuVfsoiZRfQkQ+9JmE1U2RGmsleTsivhYkdw=;
  b=eBzVF6vtwb0hyZmCcwE0y9Pa9uf2keKmbWuouIMy6iS+k9/AbTmm/eye
   moHY1vZc1h55VxDrY8atLMGjq+59jiW65b+X9JTmyPiSOYL54i+KesY9X
   igF9Mxy/9fMZq5ky8EW9S9U7/Lx4PpR1vtfbvoW5kl1Ki2NnewMv0VuHJ
   g=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 11 Apr 2022 12:17:16 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg04-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2022 12:17:15 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 11 Apr 2022 12:17:15 -0700
Received: from c-sanm-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 11 Apr 2022 12:17:09 -0700
From:   Sandeep Maheswaram <quic_c_sanm@quicinc.com>
To:     Rob Herring <robh+dt@kernel.org>, Andy Gross <agross@kernel.org>,
        "Bjorn Andersson" <bjorn.andersson@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Doug Anderson <dianders@chromium.org>,
        "Matthias Kaehlcke" <mka@chromium.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     <devicetree@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_pkondeti@quicinc.com>, <quic_ppratap@quicinc.com>,
        <quic_kriskura@quicinc.com>, <quic_vpulyala@quicinc.com>,
        Sandeep Maheswaram <quic_c_sanm@quicinc.com>
Subject: [PATCH v13 0/6] USB DWC3 host wake up support from system suspend
Date:   Tue, 12 Apr 2022 00:46:48 +0530
Message-ID: <1649704614-31518-1-git-send-email-quic_c_sanm@quicinc.com>
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

Avoiding phy powerdown in host mode when wakeup capable devices are 
connected, so that it can be wake up by devices.
Keep usb30_prim gdsc active to retain controller status
during suspend/resume.

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

Sandeep Maheswaram (6):
  dt-bindings: usb: dwc3: Add wakeup-source property support
  usb: dwc3: core: Host wake up support from system suspend
  usb: dwc3: qcom: Add helper functions to enable,disable wake irqs
  usb: dwc3: qcom: Configure wakeup interrupts during suspend
  usb: dwc3: qcom: Keep power domain on to retain controller status
  arm64: dts: qcom: sc7280: Add wakeup-source property for USB node

 .../devicetree/bindings/usb/snps,dwc3.yaml         |  5 ++
 arch/arm64/boot/dts/qcom/sc7280.dtsi               |  1 +
 drivers/usb/dwc3/core.c                            | 33 +++++----
 drivers/usb/dwc3/core.h                            |  4 ++
 drivers/usb/dwc3/dwc3-qcom.c                       | 79 +++++++++++++---------
 drivers/usb/dwc3/host.c                            | 25 +++++++
 6 files changed, 103 insertions(+), 44 deletions(-)

-- 
2.7.4

