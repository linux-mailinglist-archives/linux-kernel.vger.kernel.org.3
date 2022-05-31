Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DD88538CAF
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 10:21:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243899AbiEaIU5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 04:20:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244819AbiEaIUp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 04:20:45 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EC1D9399D;
        Tue, 31 May 2022 01:20:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1653985241; x=1685521241;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=r79Lv8Tpc0oVus0BBEyrwDuYWHc751ghgdapTd8vfFo=;
  b=Y3IF1itpay+NwY86t9fSdDgCwxqk6Zn/nGpzjPy55hXeZQkECJx8luZf
   98ucKKtMPlsepTeNDJrUoVv6gov9xE2NjuVXNfQCky3i4/VcTkctdZmUY
   VPJFMHwPj5glheG70EbwjEvr3jqs2BS57bsMVFSSps2mkxi2F4mGF8BRA
   E=;
Received: from ironmsg09-lv.qualcomm.com ([10.47.202.153])
  by alexa-out.qualcomm.com with ESMTP; 31 May 2022 01:20:41 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg09-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2022 01:20:40 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 31 May 2022 01:20:39 -0700
Received: from hu-harshq-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 31 May 2022 01:20:35 -0700
From:   Harsh Agarwal <quic_harshq@quicinc.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Felipe Balbi <balbi@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
CC:     <linux-usb@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_pkondeti@quicinc.com>,
        <quic_ppratap@quicinc.com>, <quic_jackp@quicinc.com>,
        Harsh Agarwal <quic_harshq@quicinc.com>
Subject: [PATCH 2/3] usb: phy: Add devm_of_usb_get_phy_by_phandle
Date:   Tue, 31 May 2022 13:50:16 +0530
Message-ID: <1653985217-20953-3-git-send-email-quic_harshq@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1653985217-20953-1-git-send-email-quic_harshq@quicinc.com>
References: <1653985217-20953-1-git-send-email-quic_harshq@quicinc.com>
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

Adding support for devm_of_usb_get_phy_by_phandle which allows
us to get PHY phandles of a device declared inside lookup_node.

Signed-off-by: Harsh Agarwal <quic_harshq@quicinc.com>
---
 drivers/usb/phy/phy.c   | 34 ++++++++++++++++++++++++++++++++++
 include/linux/usb/phy.h |  8 ++++++++
 2 files changed, 42 insertions(+)

diff --git a/drivers/usb/phy/phy.c b/drivers/usb/phy/phy.c
index 1b24492..0843757 100644
--- a/drivers/usb/phy/phy.c
+++ b/drivers/usb/phy/phy.c
@@ -615,6 +615,40 @@ struct usb_phy *devm_usb_get_phy_by_phandle(struct device *dev,
 EXPORT_SYMBOL_GPL(devm_usb_get_phy_by_phandle);
 
 /**
+ * devm_of_usb_get_phy_by_phandle - find the USB PHY by phandle in lookup_node
+ * @dev: device that requests this phy
+ * @phandle: name of the property holding the phy phandle value
+ * @index: the index of the phy
+ * @lookup_node: The node to search for PHY phandles.
+ *
+ * Returns the phy driver associated with the given phandle value,
+ * after getting a refcount to it, -ENODEV if there is no such phy or
+ * -EPROBE_DEFER if there is a phandle to the phy, but the device is
+ * not yet loaded. While at that, it also associates the device with
+ * the phy using devres. On driver detach, release function is invoked
+ * on the devres data, then, devres data is freed.
+ *
+ * For use by USB host and peripheral drivers.
+ */
+struct usb_phy *devm_of_usb_get_phy_by_phandle(struct device *dev,
+	const char *phandle, u8 index, struct device_node *lookup_node)
+{
+	struct device_node *node;
+	struct usb_phy	*phy;
+
+	node = of_parse_phandle(lookup_node, phandle, index);
+	if (!node) {
+		dev_dbg(dev, "failed to get %s phandle in %pOF node\n", phandle,
+			dev->of_node);
+		return ERR_PTR(-ENODEV);
+	}
+	phy = devm_usb_get_phy_by_node(dev, node, NULL);
+	of_node_put(node);
+	return phy;
+}
+EXPORT_SYMBOL_GPL(devm_of_usb_get_phy_by_phandle);
+
+/**
  * devm_usb_put_phy - release the USB PHY
  * @dev: device that wants to release this phy
  * @phy: the phy returned by devm_usb_get_phy()
diff --git a/include/linux/usb/phy.h b/include/linux/usb/phy.h
index e4de6bc..2581c72 100644
--- a/include/linux/usb/phy.h
+++ b/include/linux/usb/phy.h
@@ -220,6 +220,8 @@ extern struct usb_phy *devm_usb_get_phy(struct device *dev,
 	enum usb_phy_type type);
 extern struct usb_phy *devm_usb_get_phy_by_phandle(struct device *dev,
 	const char *phandle, u8 index);
+extern struct usb_phy *devm_of_usb_get_phy_by_phandle(struct device *dev,
+	const char *phandle, u8 index, struct device_node *lookup_node);
 extern struct usb_phy *devm_usb_get_phy_by_node(struct device *dev,
 	struct device_node *node, struct notifier_block *nb);
 extern void usb_put_phy(struct usb_phy *);
@@ -249,6 +251,12 @@ static inline struct usb_phy *devm_usb_get_phy_by_phandle(struct device *dev,
 	return ERR_PTR(-ENXIO);
 }
 
+extern inline struct usb_phy *devm_of_usb_get_phy_by_phandle(struct device *dev,
+	const char *phandle, u8 index, struct device_node *lookup_node)
+{
+	return ERR_PTR(-ENXIO);
+}
+
 static inline struct usb_phy *devm_usb_get_phy_by_node(struct device *dev,
 	struct device_node *node, struct notifier_block *nb)
 {
-- 
2.7.4

