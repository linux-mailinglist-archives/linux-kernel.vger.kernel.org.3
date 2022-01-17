Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A91794901A8
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 06:45:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234293AbiAQFoi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 00:44:38 -0500
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:55078 "EHLO
        alexa-out-sd-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234389AbiAQFoe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 00:44:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1642398274; x=1673934274;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=oWYE4/1jS4KcCIbk7ywm73OcI0RO6xPaxqB+PmdcKrY=;
  b=nWg1kEAXkLyh3lGTeb30+hTAVXmGE01DRZ7qbb6WTWL6H4R5UDf4CwT3
   1UmBMoJITUoKGcB1LxSEqCqa2HoOV+4vsDwUrVLpAvUeOWRUqiblZR6E+
   asKN57IlTJ4adsGTiFFmrs6kNDoYHIs8B44VOIyaRFe3J1N7qbR9qN9ro
   g=;
Received: from unknown (HELO ironmsg01-sd.qualcomm.com) ([10.53.140.141])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 16 Jan 2022 21:44:34 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg01-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2022 21:44:33 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Sun, 16 Jan 2022 21:44:33 -0800
Received: from c-sanm-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Sun, 16 Jan 2022 21:44:28 -0800
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
Subject: [PATCH v10 2/6] usb: dwc3: core: Host wake up support from system suspend
Date:   Mon, 17 Jan 2022 11:14:04 +0530
Message-ID: <1642398248-21753-3-git-send-email-quic_c_sanm@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1642398248-21753-1-git-send-email-quic_c_sanm@quicinc.com>
References: <1642398248-21753-1-git-send-email-quic_c_sanm@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Avoiding phy powerdown when wakeup capable devices are connected
by checking wakeup property of xhci plat device.
Phy should be on to wake up the device from suspend using wakeup capable
devices such as keyboard and mouse.

Signed-off-by: Sandeep Maheswaram <quic_c_sanm@quicinc.com>
Tested-by: Brian Norris <briannorris@chromium.org>
---
Remove redundant else part in dwc3_resume_common. This will not be
required if GDSC is always on during suspend/resume.


 drivers/usb/dwc3/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index f4c0995..e7a5e3f 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -1789,7 +1789,7 @@ static int dwc3_suspend_common(struct dwc3 *dwc, pm_message_t msg)
 		dwc3_core_exit(dwc);
 		break;
 	case DWC3_GCTL_PRTCAP_HOST:
-		if (!PMSG_IS_AUTO(msg)) {
+		if (!PMSG_IS_AUTO(msg) && !device_may_wakeup(&dwc->xhci->dev)) {
 			dwc3_core_exit(dwc);
 			break;
 		}
@@ -1850,7 +1850,7 @@ static int dwc3_resume_common(struct dwc3 *dwc, pm_message_t msg)
 		spin_unlock_irqrestore(&dwc->lock, flags);
 		break;
 	case DWC3_GCTL_PRTCAP_HOST:
-		if (!PMSG_IS_AUTO(msg)) {
+		if (!PMSG_IS_AUTO(msg) && !device_may_wakeup(&dwc->xhci->dev)) {
 			ret = dwc3_core_init_for_resume(dwc);
 			if (ret)
 				return ret;
-- 
2.7.4

