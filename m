Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD14A4E5EC5
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 07:38:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348173AbiCXGjQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 02:39:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242352AbiCXGjK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 02:39:10 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B3B9972DF;
        Wed, 23 Mar 2022 23:37:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1648103859; x=1679639859;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=DNjBzF1z6qkUkW7RPhySCx1eXWaWBLN7xnMrlQ0ScmQ=;
  b=pbl5LW0MIWU4jggZEH+A5fPnNmbkCAAt8FWGU19wYPUynZDvEjhzJxBg
   JduRMogD9SuG/D/a6n9+6FDoQoZkK7kbNnIq0Scp7ZXBr0aORoUKEhJp6
   WGXvePQ1Y5jjHYiS5nz7EZTN0K4HkBvgzysP7AgB7Sm+2o7oWg8y140p3
   E=;
Received: from unknown (HELO ironmsg05-sd.qualcomm.com) ([10.53.140.145])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 23 Mar 2022 23:37:38 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg05-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2022 23:37:38 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 23 Mar 2022 23:37:38 -0700
Received: from c-sanm-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 23 Mar 2022 23:37:33 -0700
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
Subject: [PATCH v3 2/3] usb: xhci: Remove unwanted header inclusion
Date:   Thu, 24 Mar 2022 12:07:10 +0530
Message-ID: <1648103831-12347-3-git-send-email-quic_c_sanm@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1648103831-12347-1-git-send-email-quic_c_sanm@quicinc.com>
References: <1648103831-12347-1-git-send-email-quic_c_sanm@quicinc.com>
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

The header file linux/usb/hcd.h is already included where we are using
xhci-plat.h so remove the header file and forward declare struct usb_hcd
to avoid multiple inclusions.

Signed-off-by: Sandeep Maheswaram <quic_c_sanm@quicinc.com>
---
This patch is to address below comment.
https://patchwork.kernel.org/project/linux-arm-msm/patch/1644949454-814-2-git-send-email-quic_c_sanm@quicinc.com/#24739885

 include/linux/usb/xhci-plat.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/usb/xhci-plat.h b/include/linux/usb/xhci-plat.h
index 906e907..576e400 100644
--- a/include/linux/usb/xhci-plat.h
+++ b/include/linux/usb/xhci-plat.h
@@ -9,7 +9,8 @@
 #define _XHCI_PLAT_H
 
 #include <linux/types.h>
-#include <linux/usb/hcd.h>
+
+struct usb_hcd;
 
 struct xhci_plat_priv {
 	const char *firmware_name;
-- 
2.7.4

