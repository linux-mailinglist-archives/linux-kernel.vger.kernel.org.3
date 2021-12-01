Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51875464710
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 07:16:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346876AbhLAGT2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 01:19:28 -0500
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:38339 "EHLO
        alexa-out-sd-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1346866AbhLAGT1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 01:19:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1638339367; x=1669875367;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=BR15XsJ/2xFEXlJ/cpJHjd2xlSg5BN8S4jdNhwlMkZ0=;
  b=xwY8BB5VyhyjyE29F/L28U0kS6h2IeRkwDcogPo9Po1fydzjeKG/uJPh
   BW55qpFhJKjUUjXsTAD1nRL6G0dh/nXAMkyNUq7Qag6Krj6/3998J/u1p
   ZonjtSXJ2G/9VW6rUOtyeY0Wn9dVaZPuZHUD0XRzJVyZArFdMAFLdUPNx
   Q=;
Received: from unknown (HELO ironmsg02-sd.qualcomm.com) ([10.53.140.142])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 30 Nov 2021 22:16:06 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg02-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2021 22:16:06 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Tue, 30 Nov 2021 22:16:05 -0800
Received: from c-sanm-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Tue, 30 Nov 2021 22:16:01 -0800
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
Subject: [PATCH v3] Skip phy initialization for DWC3 USB Controllers
Date:   Wed, 1 Dec 2021 11:45:37 +0530
Message-ID: <1638339338-6731-1-git-send-email-quic_c_sanm@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Set XHCI_SKIP_PHY_INIT quirk to avoid phy initialization twice.
Runtime suspend of phy drivers was failing from DWC3 driver as
runtime usage value is 2 because the phy is initialized from
DWC3 core and HCD core.
DWC3 manages phy in their core drivers.
Set this quirk to avoid phy initialization in HCD core.

v3:
Dropped the dt property and binding.
Checking for dwc3 compatible in xhci to set the quirk XHCI_SKIP_PHY_INIT.

v2:
Updated the commit descriptions.
Changed subject prefix from dwc to dwc3.
Increased props array size.

Sandeep Maheswaram (1):
  usb: host: xhci-plat: Set XHCI_SKIP_PHY_INIT quirk for DWC3 controller

 drivers/usb/host/xhci-plat.c | 3 +++
 1 file changed, 3 insertions(+)

-- 
2.7.4

