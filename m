Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7054450AA24
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 22:38:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1392517AbiDUUlL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 16:41:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1392470AbiDUUkw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 16:40:52 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A03284DF77;
        Thu, 21 Apr 2022 13:37:59 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 23LKblZC090011;
        Thu, 21 Apr 2022 15:37:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1650573467;
        bh=ktVjKFfmp76XHoh+/NFYL5nAOCW3wIUrCAuJVOklyFU=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=kDy6QbLvbw16yc3ulRnLHoLhpKNsDz+BA6ck8+iW4l2CH0vjoxvQ0SXvk6CziC58Y
         PDCTrOwwHKBhw7ZtF+/1NfHTIiVIEY3GakG09n0EX/eAaO9Et3RWKMFUQtIUuMevqr
         iDEWDtmE5iABSYJw0mf41YAq6gl22tZ8tKYJ5vm4=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 23LKblAQ084678
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 21 Apr 2022 15:37:47 -0500
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Thu, 21
 Apr 2022 15:37:46 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Thu, 21 Apr 2022 15:37:46 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 23LKbkq2122044;
        Thu, 21 Apr 2022 15:37:46 -0500
From:   Dave Gerlach <d-gerlach@ti.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Tero Kristo <kristo@kernel.org>, Nishanth Menon <nm@ti.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Dave Gerlach <d-gerlach@ti.com>
Subject: [PATCH 5/6] firmware: ti_sci: Use dt provided fw name and address to load at suspend time
Date:   Thu, 21 Apr 2022 15:36:58 -0500
Message-ID: <20220421203659.27853-6-d-gerlach@ti.com>
X-Mailer: git-send-email 2.35.0
In-Reply-To: <20220421203659.27853-1-d-gerlach@ti.com>
References: <20220421203659.27853-1-d-gerlach@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use request_firmware_direct to load the fs stub LPM firmware to a
provided lpm memory region. The filename for the firmware is provided in
the device tree as "ti,lpm-firmware-name"

Also, add support for "lazy loading" of this firmware during the suspend
callback for the driver so that it is loaded at first suspend. It is
possible in the future for this firmware to require reload, so add a
check to indicate that the firmware is currently loaded so it is only
loaded once at this time.

Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
---
 drivers/firmware/ti_sci.c | 69 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 68 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/ti_sci.c b/drivers/firmware/ti_sci.c
index 1c2000b40e8f..772643cb940c 100644
--- a/drivers/firmware/ti_sci.c
+++ b/drivers/firmware/ti_sci.c
@@ -11,6 +11,7 @@
 #include <linux/bitmap.h>
 #include <linux/debugfs.h>
 #include <linux/export.h>
+#include <linux/firmware.h>
 #include <linux/io.h>
 #include <linux/iopoll.h>
 #include <linux/kernel.h>
@@ -90,6 +91,8 @@ struct ti_sci_desc {
  * @debug_region: Memory region where the debug message are available
  * @debug_region_size: Debug region size
  * @debug_buffer: Buffer allocated to copy debug messages.
+ * @lpm_region: Memory region where the FS Stub LPM Firmware will be stored
+ * @lpm_region_size: LPM region size
  * @handle:	Instance of TI SCI handle to send to clients.
  * @cl:		Mailbox Client
  * @chan_tx:	Transmit mailbox channel
@@ -101,6 +104,8 @@ struct ti_sci_desc {
  * @mem_ctx_hi: High word of address used for low power context memory
  * @users:	Number of users of this instance
  * @is_suspending: Flag set to indicate in suspend path.
+ * @lpm_firmware_loaded: Flag to indicate if LPM firmware has been loaded
+ * @lpm_firmware_name: Name of firmware binary to load from fw search path
  */
 struct ti_sci_info {
 	struct device *dev;
@@ -110,6 +115,8 @@ struct ti_sci_info {
 	void __iomem *debug_region;
 	char *debug_buffer;
 	size_t debug_region_size;
+	void __iomem *lpm_region;
+	size_t lpm_region_size;
 	struct ti_sci_handle handle;
 	struct mbox_client cl;
 	struct mbox_chan *chan_tx;
@@ -122,6 +129,8 @@ struct ti_sci_info {
 	/* protected by ti_sci_list_mutex */
 	int users;
 	bool is_suspending;
+	bool lpm_firmware_loaded;
+	const char *lpm_firmware_name;
 };
 
 #define cl_to_ti_sci_info(c)	container_of(c, struct ti_sci_info, cl)
@@ -3350,6 +3359,30 @@ static int tisci_reboot_handler(struct notifier_block *nb, unsigned long mode,
 	return NOTIFY_BAD;
 }
 
+static int ti_sci_load_lpm_firmware(struct device *dev, struct ti_sci_info *info)
+{
+	const struct firmware *firmware;
+	int ret = 0;
+
+	/* If no firmware name is set, do not attempt to load. */
+	if (!info->lpm_firmware_name)
+		return 0;
+
+	if (request_firmware_direct(&firmware, info->lpm_firmware_name, dev)) {
+		dev_warn(dev, "Cannot load %s\n", info->lpm_firmware_name);
+		return -ENODEV;
+	}
+
+	if (firmware->size > info->lpm_region_size)
+		return -ENOMEM;
+
+	memcpy_toio(info->lpm_region, firmware->data, firmware->size);
+
+	release_firmware(firmware);
+
+	return ret;
+}
+
 static void ti_sci_set_is_suspending(struct ti_sci_info *info, bool is_suspending)
 {
 	info->is_suspending = is_suspending;
@@ -3358,6 +3391,8 @@ static void ti_sci_set_is_suspending(struct ti_sci_info *info, bool is_suspendin
 static int ti_sci_suspend(struct device *dev)
 {
 	struct ti_sci_info *info = dev_get_drvdata(dev);
+	int ret = 0;
+
 	/*
 	 * We must switch operation to polled mode now as drivers and the genpd
 	 * layer may make late TI SCI calls to change clock and device states
@@ -3365,7 +3400,19 @@ static int ti_sci_suspend(struct device *dev)
 	 */
 	ti_sci_set_is_suspending(info, true);
 
-	return 0;
+	if (!info->lpm_firmware_loaded) {
+		ret = ti_sci_load_lpm_firmware(dev, info);
+		if (ret) {
+			dev_err(dev,
+				"Failed to load low power mode firmware, suspend is non functional (%d)\n",
+				ret);
+			ret = -ENODEV;
+		} else {
+			info->lpm_firmware_loaded = true;
+		}
+	}
+
+	return ret;
 }
 
 static int ti_sci_resume(struct device *dev)
@@ -3384,6 +3431,7 @@ static int ti_sci_init_suspend(struct platform_device *pdev, struct ti_sci_info
 	struct device *dev = &pdev->dev;
 	struct device_node *rmem_np;
 	struct reserved_mem *rmem;
+	struct resource *res;
 
 	rmem_np = of_parse_phandle(dev->of_node, "ti,ctx-memory-region", 0);
 	if (!rmem_np) {
@@ -3399,6 +3447,25 @@ static int ti_sci_init_suspend(struct platform_device *pdev, struct ti_sci_info
 	info->mem_ctx_lo = (rmem->base & 0xFFFFFFFF);
 	info->mem_ctx_hi = (rmem->base >> 32);
 
+	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "lpm");
+	if (!res) {
+		dev_warn(dev,
+			 "lpm region is required for suspend but not provided.\n");
+		return -EINVAL;
+	}
+
+	info->lpm_region = devm_ioremap_resource(dev, res);
+	if (IS_ERR(info->lpm_region))
+		return PTR_ERR(info->lpm_region);
+	info->lpm_region_size = resource_size(res);
+
+	if (of_property_read_string(dev->of_node, "ti,lpm-firmware-name",
+				    &info->lpm_firmware_name)) {
+		dev_warn(dev,
+			 "ti,lpm-firmware-name is required for suspend but not provided.\n");
+		return -EINVAL;
+	}
+
 	return 0;
 }
 
-- 
2.35.0

