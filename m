Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C9EB597698
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 21:35:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241575AbiHQTdF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 15:33:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241545AbiHQTcf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 15:32:35 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA9DBA5709
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 12:31:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0C8EDB81F4B
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 19:31:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F712C433D6;
        Wed, 17 Aug 2022 19:31:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660764690;
        bh=h9jJLisusQCTKq1uyl3xtKgwVeHl5sOQ3o5Kt7G3JHw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=prJLdY+J42uJNxFqSFVxhzLN8b2mQBv+PDtw2hJIQ2jxq67UW/dEu7wgUkL2dOsMo
         sMSHoCd5e1ge/LpjF+55NnoNqT+CANvLc42aZ3QrMSE8vJUWUq/Zu6Y/xyoTJ/cXAI
         ympXraJSWCzcnRU/qtWns0le0MbcaHNi4+4gezZoXs1gO3RQWtY/o9pKJhJJoGRFcN
         EG4+oTTQEDnLGQLRJhVvNtW+LjvKkOXMdOd8qMRpCMIqjcipdRy5zciYYPdMEaJxqy
         4OXbXnvQsTYQI/ke4pstH+C7s417rl8pYiJUD5kcSZG0JoEstgskKVWxYNe8Z1RK69
         Xb+ANStIxFaTw==
From:   =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
To:     Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Linux Phy <linux-phy@lists.infradead.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     Gregory Clement <gregory.clement@bootlin.com>,
        Kees Cook <keescook@chromium.org>,
        linux-kernel@vger.kernel.org, pali@kernel.org,
        josef.schlehofer@nic.cz,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH linux-phy 2/4] device property: Add {fwnode/device}_get_tx_p2p_amplitude()
Date:   Wed, 17 Aug 2022 21:31:17 +0200
Message-Id: <20220817193119.4463-3-kabel@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220817193119.4463-1-kabel@kernel.org>
References: <20220817193119.4463-1-kabel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add functions fwnode_get_tx_p2p_amplitude() and
device_get_tx_p2p_amplitude() that parse the 'tx-p2p-microvolt' and
'tx-p2p-microvolt-names' properties and return peak to peak transmit
amplitude in microvolts for given PHY mode.

The functions search for mode name in 'tx-p2p-microvolt-names' property,
and return amplitude at the corresponding index in the 'tx-p2p-microvolt'
property.

If given mode is not matched in 'tx-p2p-microvolt-names' array, the mode
name is generalized (for example "pcie3" -> "pcie" -> "default", or
"usb-ss" -> "usb" -> "default").

If the 'tx-p2p-microvolt-names' is not present, the 'tx-p2p-microvolt'
property is expected to contain only one value, which is considered
default, and will be returned for any mode.

Signed-off-by: Marek Behún <kabel@kernel.org>
---
Andy et al. can I get Ack for this if this is okay?
---
 drivers/base/property.c  | 130 +++++++++++++++++++++++++++++++++++++++
 include/linux/property.h |   5 ++
 2 files changed, 135 insertions(+)

diff --git a/drivers/base/property.c b/drivers/base/property.c
index ed6f449f8e5c..34b763436c30 100644
--- a/drivers/base/property.c
+++ b/drivers/base/property.c
@@ -921,6 +921,136 @@ int device_get_phy_mode(struct device *dev)
 }
 EXPORT_SYMBOL_GPL(device_get_phy_mode);
 
+/**
+ * fwnode_get_tx_p2p_amplitude - Get peak to peak transmit amplitude for given
+ *				 PHY mode
+ * @fwnode:	Pointer to the given node
+ * @mode:	Name of the PHY mode, or "default" / NULL
+ * @amplitude:	Pointer where to store the amplitude
+ *
+ * Gets the peak to peak transmit amplitude in microvolts for a given PHY mode
+ * by parsing the 'tx-p2p-microvolt' and 'tx-p2p-microvolt-names' properties.
+ * If amplitude is not specified for @mode exactly, tries a more generic mode,
+ * and if that isn't specified, tries "default".
+ *
+ * For example if @mode is "pcie3", we first try searching for value
+ * corresponding to "pcie3", then to "pcie", and finally to "default".
+ *
+ * Return: %0 if the amplitude was read (success),
+ *	   %-EINVAL if given arguments are not valid,
+ *	   %-ENODATA if the required properties do not have a value,
+ *	   %-EPROTO if the property is not an array of strings,
+ *	   %-ENXIO if no suitable firmware interface is present,
+ *	   %-ENOMEM if out of memory.
+ */
+int fwnode_get_tx_p2p_amplitude(struct fwnode_handle *fwnode, const char *mode,
+				u32 *amplitude)
+{
+	static const char *names_prop = "tx-p2p-microvolt-names",
+			  *vals_prop = "tx-p2p-microvolt";
+	const char **names;
+	int cnt, idx, ret;
+	u32 *vals;
+
+	cnt = fwnode_property_string_array_count(fwnode, names_prop);
+	if (!cnt || cnt == -EINVAL)
+		/*
+		 * If the names property does not exist or is empty, we expect
+		 * the values property to contain only one, default value.
+		 */
+		return fwnode_property_read_u32(fwnode, vals_prop, amplitude);
+	else if (cnt < 0)
+		return cnt;
+
+	names = kcalloc(cnt, sizeof(*names), GFP_KERNEL);
+	if (!names)
+		return -ENOMEM;
+
+	ret = fwnode_property_read_string_array(fwnode, names_prop, names, cnt);
+	if (ret < 0) {
+		kfree(names);
+		return ret;
+	}
+
+	if (!mode)
+		mode = "default";
+
+	do {
+		static const char *gen_table[] = {
+			"pcie", "usb", "ufs-hs", "dp", "mipi-dphy",
+		};
+		size_t i;
+
+		idx = match_string(names, cnt, mode);
+		if (idx >= 0)
+			break;
+
+		/* If mode was not matched, try more generic mode */
+		for (i = 0; i < ARRAY_SIZE(gen_table); ++i) {
+			if (str_has_proper_prefix(mode, gen_table[i])) {
+				mode = gen_table[i];
+				break;
+			}
+		}
+
+		/* Or "default" */
+		if (i == ARRAY_SIZE(gen_table)) {
+			if (strcmp(mode, "default"))
+				mode = "default";
+			else
+				mode = NULL;
+		}
+	} while (mode);
+
+	kfree(names);
+
+	if (idx < 0)
+		return -ENODATA;
+
+	vals = kcalloc(cnt, sizeof(*vals), GFP_KERNEL);
+	if (!vals)
+		return -ENOMEM;
+
+	ret = fwnode_property_read_u32_array(fwnode, vals_prop, vals, cnt);
+	if (ret)
+		goto out;
+
+	*amplitude = vals[idx];
+out:
+	kfree(vals);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(fwnode_get_tx_p2p_amplitude);
+
+/**
+ * device_get_tx_p2p_amplitude - Get peak to peak transmit amplitude for given
+ *				 PHY mode
+ * @dev:	Pointer to the given device
+ * @mode:	Name of the PHY mode, or "default" / NULL
+ * @amplitude:	Pointer where to store the amplitude
+ *
+ * Gets the peak to peak transmit amplitude in microvolts for a given PHY mode
+ * by parsing the 'tx-p2p-microvolt' and 'tx-p2p-microvolt-names' properties.
+ * If amplitude is not specified for @mode exactly, tries a more generic mode,
+ * and if that isn't specified, tries "default".
+ *
+ * For example if @mode is "pcie3", we first try searching for value
+ * corresponding to "pcie3", then to "pcie", and finally to "default".
+ *
+ * Return: %0 if the amplitude was read (success),
+ *	   %-EINVAL if given arguments are not valid,
+ *	   %-ENODATA if the required properties do not have a value,
+ *	   %-EPROTO if the property is not an array of strings,
+ *	   %-ENXIO if no suitable firmware interface is present,
+ *	   %-ENOMEM if out of memory.
+ */
+int device_get_tx_p2p_amplitude(struct device *dev, const char *mode,
+				u32 *amplitude)
+{
+	return fwnode_get_tx_p2p_amplitude(dev_fwnode(dev), mode, amplitude);
+}
+EXPORT_SYMBOL_GPL(device_get_tx_p2p_amplitude);
+
 /**
  * fwnode_iomap - Maps the memory mapped IO for a given fwnode
  * @fwnode:	Pointer to the firmware node
diff --git a/include/linux/property.h b/include/linux/property.h
index a5b429d623f6..91b12a79e245 100644
--- a/include/linux/property.h
+++ b/include/linux/property.h
@@ -392,6 +392,11 @@ const void *device_get_match_data(struct device *dev);
 int device_get_phy_mode(struct device *dev);
 int fwnode_get_phy_mode(struct fwnode_handle *fwnode);
 
+int fwnode_get_tx_p2p_amplitude(struct fwnode_handle *fwnode, const char *mode,
+				u32 *amplitude);
+int device_get_tx_p2p_amplitude(struct device *dev, const char *mode,
+				u32 *amplitude);
+
 void __iomem *fwnode_iomap(struct fwnode_handle *fwnode, int index);
 
 struct fwnode_handle *fwnode_graph_get_next_endpoint(
-- 
2.35.1

