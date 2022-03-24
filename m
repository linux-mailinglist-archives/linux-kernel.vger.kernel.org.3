Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E44C04E5EC1
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 07:37:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242277AbiCXGjI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 02:39:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238219AbiCXGjG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 02:39:06 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D830972DA;
        Wed, 23 Mar 2022 23:37:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1648103855; x=1679639855;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=ny5meEcqBdnyrsnV2tnyf9u5KHqZJrNUmMU2YLboYkM=;
  b=QLRAxikSUb1XSIQCTGEeplDtDRFsfyC2VmdIUFx2umDkZ3qtro7zr2Qi
   F8WdOXYn/MJVq3x5zRD+DMJqVqKkBG83ULdbfpGGImR171jfgjfirhWQ2
   XCz/a+hMFlI9CuPweh6sXNh6Vun+kXAVmIaj1DWfc2thcRIfcNH15lX77
   E=;
Received: from unknown (HELO ironmsg01-sd.qualcomm.com) ([10.53.140.141])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 23 Mar 2022 23:37:34 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg01-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2022 23:37:27 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 23 Mar 2022 23:37:27 -0700
Received: from c-sanm-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 23 Mar 2022 23:37:22 -0700
From:   Sandeep Maheswaram <quic_c_sanm@quicinc.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Doug Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Peter Chen <peter.chen@kernel.org>,
        Pawel Laszczak <pawell@cadence.com>,
        Roger Quadros <rogerq@kernel.org>,
        Aswath Govindraju <a-govindraju@ti.com>
CC:     <linux-arm-msm@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_pkondeti@quicinc.com>,
        <quic_ppratap@quicinc.com>,
        Sandeep Maheswaram <quic_c_sanm@quicinc.com>
Subject: [PATCH v3 0/3] Refactor xhci quirks and plat private data
Date:   Thu, 24 Mar 2022 12:07:08 +0530
Message-ID: <1648103831-12347-1-git-send-email-quic_c_sanm@quicinc.com>
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

changes in v3:
Updated the commit description for PATCH 2/3 and PATCH 3/3. 

changes in v2:
Added a PATCH 2/3 to remove unwanted header inclusion.
Fixed minor nitpicks in PATCH 3/3.

Pavankumar Kondeti (1):
  usb: xhci: refactor quirks and plat private data

Sandeep Maheswaram (2):
  usb: xhci: Remove unwanted header inclusion
  usb: dwc: host: add xhci_plat_priv quirk XHCI_SKIP_PHY_INIT

 drivers/usb/cdns3/host.c        |  2 +-
 drivers/usb/dwc3/host.c         | 13 ++++++++
 drivers/usb/host/xhci-plat.c    |  3 +-
 drivers/usb/host/xhci-plat.h    | 24 ---------------
 drivers/usb/host/xhci-rcar.c    |  3 +-
 drivers/usb/host/xhci.h         | 60 ++++--------------------------------
 include/linux/usb/xhci-plat.h   | 24 +++++++++++++++
 include/linux/usb/xhci-quirks.h | 67 +++++++++++++++++++++++++++++++++++++++++
 8 files changed, 115 insertions(+), 81 deletions(-)
 delete mode 100644 drivers/usb/host/xhci-plat.h
 create mode 100644 include/linux/usb/xhci-plat.h
 create mode 100644 include/linux/usb/xhci-quirks.h

-- 
2.7.4

