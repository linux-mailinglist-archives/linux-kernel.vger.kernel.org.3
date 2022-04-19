Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 407EB5079E4
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 21:11:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350576AbiDSTOf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 15:14:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350276AbiDSTOc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 15:14:32 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F8293B3D1;
        Tue, 19 Apr 2022 12:11:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1650395509; x=1681931509;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=TzZzWcvYlzY2/2hV72xApePSVXFt8euk0wOcNRW3id0=;
  b=BIRRe+azAFKMzrXdxIgZejug+b6TyI9Q1SLBxzIk6DfcQ9nTQ6x9uInk
   4TJeZn4K0m/3LChvC4kL0MBwBr6IPtiHqnfXcRLO+UUTtQrT0vx50D+7Q
   Mjz9h784SXsdk8R2mhycka4V4yX+80V9uxXg9ZmP8krwqcWRUPNkUqjLR
   o=;
Received: from unknown (HELO ironmsg03-sd.qualcomm.com) ([10.53.140.143])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 19 Apr 2022 12:11:49 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg03-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2022 12:11:48 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 19 Apr 2022 12:11:47 -0700
Received: from c-sanm-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 19 Apr 2022 12:11:41 -0700
From:   Sandeep Maheswaram <quic_c_sanm@quicinc.com>
To:     Rob Herring <robh+dt@kernel.org>, Andy Gross <agross@kernel.org>,
        "Bjorn Andersson" <bjorn.andersson@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Doug Anderson <dianders@chromium.org>,
        "Matthias Kaehlcke" <mka@chromium.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>
CC:     <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_pkondeti@quicinc.com>,
        <quic_ppratap@quicinc.com>, <quic_kriskura@quicinc.com>,
        <quic_vpulyala@quicinc.com>,
        Sandeep Maheswaram <quic_c_sanm@quicinc.com>
Subject: [PATCH v14 2/7] PM / wakeup: Add device_children_wakeup_capable()
Date:   Wed, 20 Apr 2022 00:41:05 +0530
Message-ID: <1650395470-31333-3-git-send-email-quic_c_sanm@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1650395470-31333-1-git-send-email-quic_c_sanm@quicinc.com>
References: <1650395470-31333-1-git-send-email-quic_c_sanm@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
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

From: Matthias Kaehlcke <mka@chromium.org>

Add device_children_wakeup_capable() which checks whether the device itself
or one if its descendants is wakeup capable.

Suggested-by: Felipe Balbi <balbi@kernel.org>
Signed-off-by: Sandeep Maheswaram <quic_c_sanm@quicinc.com>
Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
---
 drivers/base/power/wakeup.c | 18 ++++++++++++++++++
 include/linux/pm_wakeup.h   |  7 +++++++
 2 files changed, 25 insertions(+)

diff --git a/drivers/base/power/wakeup.c b/drivers/base/power/wakeup.c
index a57d469..1900637 100644
--- a/drivers/base/power/wakeup.c
+++ b/drivers/base/power/wakeup.c
@@ -541,6 +541,24 @@ int device_set_wakeup_enable(struct device *dev, bool enable)
 }
 EXPORT_SYMBOL_GPL(device_set_wakeup_enable);
 
+static int __device_children_wakeup_capable(struct device *dev, void *dummy)
+{
+	return device_may_wakeup(dev) ||
+		device_for_each_child(dev, NULL, __device_children_wakeup_capable);
+}
+
+/**
+ * device_children_wakeup_capable - Check whether a device or one of its descendants is
+ *                                  wakeup capable.
+ * @dev: Device to handle.
+ */
+bool device_children_wakeup_capable(struct device *dev)
+{
+	return __device_children_wakeup_capable(dev, NULL);
+}
+EXPORT_SYMBOL_GPL(device_children_wakeup_capable);
+
+
 /**
  * wakeup_source_not_registered - validate the given wakeup source.
  * @ws: Wakeup source to be validated.
diff --git a/include/linux/pm_wakeup.h b/include/linux/pm_wakeup.h
index 196a157..9a3005b 100644
--- a/include/linux/pm_wakeup.h
+++ b/include/linux/pm_wakeup.h
@@ -109,6 +109,7 @@ extern struct wakeup_source *wakeup_sources_walk_next(struct wakeup_source *ws);
 extern int device_wakeup_enable(struct device *dev);
 extern int device_wakeup_disable(struct device *dev);
 extern void device_set_wakeup_capable(struct device *dev, bool capable);
+extern bool device_children_wakeup_capable(struct device *dev);
 extern int device_init_wakeup(struct device *dev, bool val);
 extern int device_set_wakeup_enable(struct device *dev, bool enable);
 extern void __pm_stay_awake(struct wakeup_source *ws);
@@ -186,6 +187,12 @@ static inline bool device_wakeup_path(struct device *dev)
 
 static inline void device_set_wakeup_path(struct device *dev) {}
 
+static inline bool device_children_wakeup_capable(struct device *dev)
+{
+	return false;
+}
+
+
 static inline void __pm_stay_awake(struct wakeup_source *ws) {}
 
 static inline void pm_stay_awake(struct device *dev) {}
-- 
2.7.4

