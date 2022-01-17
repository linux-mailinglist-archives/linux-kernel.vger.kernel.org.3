Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 898CD4901A5
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 06:44:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233019AbiAQFoZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 00:44:25 -0500
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:2481 "EHLO
        alexa-out-sd-01.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232449AbiAQFoY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 00:44:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1642398264; x=1673934264;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=ORexfekDTETJk/q4623XGnH+VR9R4h8fqEYOUoS0J50=;
  b=b5ESTi783O3A+U5CkPAP9X4C3490ms8tGkSuV6FfmkSNn14+Ar52j/eN
   e7aYTmoCPRzcA+Hob45cAxyIjczegQQIDzsYg+9EupMeslspl7ACvOA4X
   eSYHx1t9dF0DcU82bvBPGu7lcddP/uTMTx+QiyZ4kSZGUhVbNJcCO3X4o
   0=;
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 16 Jan 2022 21:44:24 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg-SD-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2022 21:44:24 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Sun, 16 Jan 2022 21:44:24 -0800
Received: from c-sanm-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Sun, 16 Jan 2022 21:44:19 -0800
From:   Sandeep Maheswaram <quic_c_sanm@quicinc.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Doug Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Mathias Nyman <mathias.nyman@intel.com>
CC:     <linux-arm-msm@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_pkondeti@quicinc.com>,
        <quic_ppratap@quicinc.com>,
        Sandeep Maheswaram <quic_c_sanm@quicinc.com>
Subject: [PATCH v10 0/6] USB DWC3 host wake up support from system suspend
Date:   Mon, 17 Jan 2022 11:14:02 +0530
Message-ID: <1642398248-21753-1-git-send-email-quic_c_sanm@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Avoiding phy powerdown in host mode when wakeup capable devices are 
connected, so that it can be wake up by devices.
Set GENPD_FLAG_ALWAYS_ON flag to keep usb30_prim gdsc active to retain
controller status during suspend/resume.

Changes in v10:
PATCH 1/6: Change device_set_wakeup_capable to device_set_wakeup_enable
PATCH 2/6: Remove redundant else part in dwc3_resume_common
PATCH 4/6: Change the irg flags
PATCH 5/6: Set flag GENPD_FLAG_ALWAYS_ON
PATCH 6/6: Remove remove disable interrupts function and enable
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
  usb: host: xhci: plat: Add suspend quirk for dwc3 controller
  usb: dwc3: core: Host wake up support from system suspend
  usb: dwc3: qcom: Add helper functions to enable,disable wake irqs
  usb: dwc3: qcom: Change the IRQ flag for DP/DM hs phy irq
  usb: dwc3: qcom: Keep power domain on to retain controller status
  usb: dwc3: qcom: Enable the interrupts during probe

 drivers/usb/dwc3/core.c      |  4 +--
 drivers/usb/dwc3/dwc3-qcom.c | 64 +++++++++++++++-----------------------------
 drivers/usb/host/xhci-plat.c | 12 +++++++++
 3 files changed, 36 insertions(+), 44 deletions(-)

-- 
2.7.4

