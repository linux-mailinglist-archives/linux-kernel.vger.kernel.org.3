Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36FB34CA8AF
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 15:58:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243329AbiCBO6k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 09:58:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237870AbiCBO6h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 09:58:37 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A31A344FA;
        Wed,  2 Mar 2022 06:57:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 19E33B81FFC;
        Wed,  2 Mar 2022 14:57:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CD77C340F1;
        Wed,  2 Mar 2022 14:57:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646233070;
        bh=ppfP2G32Iq7vZfJjkXBIQFtPt8UJHuV5l9zUh3VfH+I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qXmloFawc6UYgjfoUI9IkbEVV1zYVb7XxCsqtjBGAfXf/e/qZx7GAeewnvllF1c/U
         qXQNVx5lVSo7fOlN0dMvYSNvL46L0+7IATpgQooJR6a3qOj+jiNx2cIsBYkagI+xjH
         U0ZDfvZXCa4yEbGJUCPy4L9JNQXLM5yl4pb09q0d24yO4Y+WqkWhUda86rGZPSiWkj
         3ztH8FtVULu2yGsjGaBJIEzTzRANL8xKi8iqAW9z5GlNIrmSHnrdv+xDKi7s6Aog9+
         BZaFkUwHxkiD9UZ/9tMnXJS975m7KXxlhAkUarU6U31s3cwG8ZKwy+qqEcFPRsJtmz
         kssd1ZLVbEYYg==
Received: by pali.im (Postfix)
        id 1855C990; Wed,  2 Mar 2022 15:57:50 +0100 (CET)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
        Russell King <rmk+kernel@armlinux.org.uk>
Cc:     linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/4] PCI: Add function for parsing 'slot-power-limit-milliwatt' DT property
Date:   Wed,  2 Mar 2022 15:57:32 +0100
Message-Id: <20220302145733.12606-4-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220302145733.12606-1-pali@kernel.org>
References: <20220302145733.12606-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add function of_pci_get_slot_power_limit(), which parses the
'slot-power-limit-milliwatt' DT property, returning the value in
milliwatts and in format ready for the PCIe Slot Capabilities Register.

Signed-off-by: Pali Rohár <pali@kernel.org>
Signed-off-by: Marek Behún <kabel@kernel.org>
Reviewed-by: Rob Herring <robh@kernel.org>
---
Changes in v2:
* Added support for PCIe 6.0 slot power limit encodings
* Round down slot power limit value
---
 drivers/pci/of.c  | 64 +++++++++++++++++++++++++++++++++++++++++++++++
 drivers/pci/pci.h | 15 +++++++++++
 2 files changed, 79 insertions(+)

diff --git a/drivers/pci/of.c b/drivers/pci/of.c
index cb2e8351c2cc..549a404bd536 100644
--- a/drivers/pci/of.c
+++ b/drivers/pci/of.c
@@ -633,3 +633,67 @@ int of_pci_get_max_link_speed(struct device_node *node)
 	return max_link_speed;
 }
 EXPORT_SYMBOL_GPL(of_pci_get_max_link_speed);
+
+/**
+ * of_pci_get_slot_power_limit - Parses the "slot-power-limit-milliwatt"
+ *				 property.
+ *
+ * @node: device tree node with the slot power limit information
+ * @slot_power_limit_value: pointer where the value should be stored in PCIe
+ *			    Slot Capabilities Register format
+ * @slot_power_limit_scale: pointer where the scale should be stored in PCIe
+ *			    Slot Capabilities Register format
+ *
+ * Returns the slot power limit in milliwatts and if @slot_power_limit_value
+ * and @slot_power_limit_scale pointers are non-NULL, fills in the value and
+ * scale in format used by PCIe Slot Capabilities Register.
+ *
+ * If the property is not found or is invalid, returns 0.
+ */
+u32 of_pci_get_slot_power_limit(struct device_node *node,
+				u8 *slot_power_limit_value,
+				u8 *slot_power_limit_scale)
+{
+	u32 slot_power_limit_mw;
+	u8 value, scale;
+
+	if (of_property_read_u32(node, "slot-power-limit-milliwatt",
+				 &slot_power_limit_mw))
+		slot_power_limit_mw = 0;
+
+	/* Calculate Slot Power Limit Value and Slot Power Limit Scale */
+	if (slot_power_limit_mw == 0) {
+		value = 0x00;
+		scale = 0;
+	} else if (slot_power_limit_mw <= 255) {
+		value = slot_power_limit_mw;
+		scale = 3;
+	} else if (slot_power_limit_mw <= 255*10) {
+		value = slot_power_limit_mw / 10;
+		scale = 2;
+	} else if (slot_power_limit_mw <= 255*100) {
+		value = slot_power_limit_mw / 100;
+		scale = 1;
+	} else if (slot_power_limit_mw <= 239*1000) {
+		value = slot_power_limit_mw / 1000;
+		scale = 0;
+	} else if (slot_power_limit_mw <= 250*1000) {
+		value = 0xF0;
+		scale = 0;
+	} else if (slot_power_limit_mw <= 600*1000) {
+		value = 0xF0 + (slot_power_limit_mw / 1000 - 250) / 25;
+		scale = 0;
+	} else {
+		value = 0xFF;
+		scale = 0;
+	}
+
+	if (slot_power_limit_value)
+		*slot_power_limit_value = value;
+
+	if (slot_power_limit_scale)
+		*slot_power_limit_scale = scale;
+
+	return slot_power_limit_mw;
+}
+EXPORT_SYMBOL_GPL(of_pci_get_slot_power_limit);
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 3d60cabde1a1..e10cdec6c56e 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -627,6 +627,9 @@ struct device_node;
 int of_pci_parse_bus_range(struct device_node *node, struct resource *res);
 int of_get_pci_domain_nr(struct device_node *node);
 int of_pci_get_max_link_speed(struct device_node *node);
+u32 of_pci_get_slot_power_limit(struct device_node *node,
+				u8 *slot_power_limit_value,
+				u8 *slot_power_limit_scale);
 void pci_set_of_node(struct pci_dev *dev);
 void pci_release_of_node(struct pci_dev *dev);
 void pci_set_bus_of_node(struct pci_bus *bus);
@@ -653,6 +656,18 @@ of_pci_get_max_link_speed(struct device_node *node)
 	return -EINVAL;
 }
 
+static inline u32
+of_pci_get_slot_power_limit(struct device_node *node,
+			    u8 *slot_power_limit_value,
+			    u8 *slot_power_limit_scale)
+{
+	if (slot_power_limit_value)
+		*slot_power_limit_value = 0;
+	if (slot_power_limit_scale)
+		*slot_power_limit_scale = 0;
+	return 0;
+}
+
 static inline void pci_set_of_node(struct pci_dev *dev) { }
 static inline void pci_release_of_node(struct pci_dev *dev) { }
 static inline void pci_set_bus_of_node(struct pci_bus *bus) { }
-- 
2.20.1

