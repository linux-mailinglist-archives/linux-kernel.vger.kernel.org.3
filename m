Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AA2C5AA2E2
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 00:22:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235284AbiIAWVx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 18:21:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234523AbiIAWU5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 18:20:57 -0400
Received: from mail.3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9A55A2237;
        Thu,  1 Sep 2022 15:19:19 -0700 (PDT)
Received: from mwalle01.kontron.local. (unknown [213.135.10.150])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.3ffe.de (Postfix) with ESMTPSA id D8BD221D8;
        Fri,  2 Sep 2022 00:19:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2022082101;
        t=1662070752;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MB/t+1HQcFJ8w0iMCkQzsjPb6YGMRkeITQOlS7zSzWI=;
        b=Hm9VEphIqRqtwHvY5u5z0jS28RcIVe5sMXYmcskpH2DgDJgUCPjKXQDX8fFEGBY4XkDFNZ
        T6caA6j6r5aBV7fUcoyUX1GW8IuG4YnowxGxmIBAhpY9YW3gmjt92P1Xr8mOr2mB03pOCb
        bOWkxJQZuM16TuUC9A1H5hOMqj0FjdPeDTssjXbAsUJbh/PDHTFzZhhGO8Oz2wPppj8oxD
        pdFhjVCA/yI4FFf0FFgpUAfKFddayicSHEiZ4Bjbg6Rg0yiFwAsye6hXpTwBRJFhmRRNoj
        vmpiPM11lqo/g4SWypmj+mGog8VK541TJqgQgWCGpgAEkv01IO8xsm957YmlxQ==
From:   Michael Walle <michael@walle.cc>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
        Frank Rowand <frowand.list@gmail.com>
Cc:     linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Ahmad Fatoum <a.fatoum@pengutronix.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Michael Walle <michael@walle.cc>
Subject: [PATCH v2 08/20] nvmem: core: introduce NVMEM layouts
Date:   Fri,  2 Sep 2022 00:18:45 +0200
Message-Id: <20220901221857.2600340-9-michael@walle.cc>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220901221857.2600340-1-michael@walle.cc>
References: <20220901221857.2600340-1-michael@walle.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam: Yes
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

NVMEM layouts are used to generate NVMEM cells during runtime. Think of
an EEPROM with a well-defined conent. For now, the content can be
described by a device tree or a board file. But this only works if the
offsets and lengths are static and don't change. One could also argue
that putting the layout of the EEPROM in the device tree is the wrong
place. Instead, the device tree should just have a specific compatible
string.

Right now there are two use cases:
 (1) The NVMEM cell needs special processing. E.g. if it only specifies
     a base MAC address offset and you need to add an offset, or it
     needs to parse a MAC from ASCII format or some proprietary format.
     (Post processing of cells is added in a later commit).
 (2) u-boot environment parsing. The cells don't have a particular
     offset but it needs parsing the content to determine the offsets
     and length.

Signed-off-by: Michael Walle <michael@walle.cc>
---
changes since v1:
 - add documentation in nvmem.rst
 - add nvmem_layout_unregister() + necessary module tracking
 - make it possible to supply a layout via nvmem_register()
 - check add_cells, before calling

 Documentation/driver-api/nvmem.rst | 15 ++++++
 drivers/nvmem/Kconfig              |  4 ++
 drivers/nvmem/Makefile             |  1 +
 drivers/nvmem/core.c               | 85 ++++++++++++++++++++++++++++++
 drivers/nvmem/layouts/Kconfig      |  5 ++
 drivers/nvmem/layouts/Makefile     |  4 ++
 include/linux/nvmem-provider.h     | 51 ++++++++++++++++++
 7 files changed, 165 insertions(+)
 create mode 100644 drivers/nvmem/layouts/Kconfig
 create mode 100644 drivers/nvmem/layouts/Makefile

diff --git a/Documentation/driver-api/nvmem.rst b/Documentation/driver-api/nvmem.rst
index e3366322d46c..de221e91c8e3 100644
--- a/Documentation/driver-api/nvmem.rst
+++ b/Documentation/driver-api/nvmem.rst
@@ -185,3 +185,18 @@ ex::
 =====================
 
 See Documentation/devicetree/bindings/nvmem/nvmem.txt
+
+8. NVMEM layouts
+================
+
+NVMEM layouts are yet another mechanism to create cells. With the device
+tree binding it is possible to specify simple cells by using an offset
+and a length. Sometimes, the cells doesn't have a static offset, but
+the content is still well defined, e.g. tag-length-values. In this case,
+the NVMEM device content has to be first parsed and the cells need to
+be added accordingly. Layouts let you read the content of the NVMEM device
+and let you add cells dynamically.
+
+Another use case for layouts is the post processing of cells. With layouts,
+it is possible to associate a custom post processing hook to a cell. It
+even possible to add this hook to cells not created by the layout itself.
diff --git a/drivers/nvmem/Kconfig b/drivers/nvmem/Kconfig
index 7f2557934834..adacb113cb94 100644
--- a/drivers/nvmem/Kconfig
+++ b/drivers/nvmem/Kconfig
@@ -21,6 +21,10 @@ config NVMEM_SYSFS
 	 This interface is mostly used by userspace applications to
 	 read/write directly into nvmem.
 
+# Layouts
+
+source "drivers/nvmem/layouts/Kconfig"
+
 # Devices
 
 config NVMEM_APPLE_EFUSES
diff --git a/drivers/nvmem/Makefile b/drivers/nvmem/Makefile
index bac799b2fa8d..b8bd1199686e 100644
--- a/drivers/nvmem/Makefile
+++ b/drivers/nvmem/Makefile
@@ -5,6 +5,7 @@
 
 obj-$(CONFIG_NVMEM)		+= nvmem_core.o
 nvmem_core-y			:= core.o
+obj-y				+= layouts/
 
 # Devices
 obj-$(CONFIG_NVMEM_APPLE_EFUSES)	+= nvmem-apple-efuses.o
diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index c640d411ab15..164511537082 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -40,6 +40,7 @@ struct nvmem_device {
 	nvmem_reg_write_t	reg_write;
 	nvmem_cell_post_process_t cell_post_process;
 	struct gpio_desc	*wp_gpio;
+	struct nvmem_layout	*layout;
 	void *priv;
 };
 
@@ -74,6 +75,9 @@ static LIST_HEAD(nvmem_lookup_list);
 
 static BLOCKING_NOTIFIER_HEAD(nvmem_notifier);
 
+static DEFINE_SPINLOCK(nvmem_layout_lock);
+static LIST_HEAD(nvmem_layouts);
+
 static int __nvmem_reg_read(struct nvmem_device *nvmem, unsigned int offset,
 			    void *val, size_t bytes)
 {
@@ -734,6 +738,75 @@ static int nvmem_add_cells_from_of(struct nvmem_device *nvmem)
 	return 0;
 }
 
+int __nvmem_layout_register(struct nvmem_layout *layout, struct module *owner)
+{
+	layout->owner = owner;
+
+	spin_lock(&nvmem_layout_lock);
+	list_add(&layout->node, &nvmem_layouts);
+	spin_unlock(&nvmem_layout_lock);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(__nvmem_layout_register);
+
+void nvmem_layout_unregister(struct nvmem_layout *layout)
+{
+	spin_lock(&nvmem_layout_lock);
+	list_del(&layout->node);
+	spin_unlock(&nvmem_layout_lock);
+}
+EXPORT_SYMBOL_GPL(nvmem_layout_unregister);
+
+static struct nvmem_layout *nvmem_layout_get(struct nvmem_device *nvmem)
+{
+	struct device_node *np = nvmem->dev.of_node;
+	struct nvmem_layout *l, *layout = NULL;
+
+	spin_lock(&nvmem_layout_lock);
+
+	list_for_each_entry(l, &nvmem_layouts, node) {
+		if (!of_match_node(l->of_match_table, np))
+			continue;
+
+		if (try_module_get(l->owner))
+			layout = l;
+
+		break;
+	}
+
+	spin_unlock(&nvmem_layout_lock);
+
+	return layout;
+}
+
+static void nvmem_layout_put(struct nvmem_layout *layout)
+{
+	if (layout)
+		module_put(layout->owner);
+}
+
+static int nvmem_add_cells_from_layout(struct nvmem_device *nvmem)
+{
+	struct nvmem_layout *layout = nvmem->layout;
+
+	if (layout && layout->add_cells)
+		layout->add_cells(&nvmem->dev, nvmem, layout);
+
+	return 0;
+}
+
+const void *nvmem_layout_get_match_data(struct nvmem_device *nvmem,
+					struct nvmem_layout *layout)
+{
+	const struct of_device_id *match;
+
+	match = of_match_node(layout->of_match_table, nvmem->dev.of_node);
+
+	return match ? match->data : NULL;
+}
+EXPORT_SYMBOL_GPL(nvmem_layout_get_match_data);
+
 /**
  * nvmem_register() - Register a nvmem device for given nvmem_config.
  * Also creates a binary entry in /sys/bus/nvmem/devices/dev-name/nvmem
@@ -848,6 +921,12 @@ struct nvmem_device *nvmem_register(const struct nvmem_config *config)
 			goto err_device_del;
 	}
 
+	/*
+	 * If the driver supplied a layout by config->layout, the module
+	 * pointer will be NULL and nvmem_layout_put() will be a noop.
+	 */
+	nvmem->layout = config->layout ?: nvmem_layout_get(nvmem);
+
 	if (config->cells) {
 		rval = nvmem_add_cells(nvmem, config->cells, config->ncells);
 		if (rval)
@@ -862,6 +941,10 @@ struct nvmem_device *nvmem_register(const struct nvmem_config *config)
 	if (rval)
 		goto err_remove_cells;
 
+	rval = nvmem_add_cells_from_layout(nvmem);
+	if (rval)
+		goto err_remove_cells;
+
 	blocking_notifier_call_chain(&nvmem_notifier, NVMEM_ADD, nvmem);
 
 	return nvmem;
@@ -871,6 +954,7 @@ struct nvmem_device *nvmem_register(const struct nvmem_config *config)
 err_teardown_compat:
 	if (config->compat)
 		nvmem_sysfs_remove_compat(nvmem, config);
+	nvmem_layout_put(nvmem->layout);
 err_device_del:
 	device_del(&nvmem->dev);
 err_put_device:
@@ -892,6 +976,7 @@ static void nvmem_device_release(struct kref *kref)
 		device_remove_bin_file(nvmem->base_dev, &nvmem->eeprom);
 
 	nvmem_device_remove_all_cells(nvmem);
+	nvmem_layout_put(nvmem->layout);
 	device_unregister(&nvmem->dev);
 }
 
diff --git a/drivers/nvmem/layouts/Kconfig b/drivers/nvmem/layouts/Kconfig
new file mode 100644
index 000000000000..9ad3911d1605
--- /dev/null
+++ b/drivers/nvmem/layouts/Kconfig
@@ -0,0 +1,5 @@
+# SPDX-License-Identifier: GPL-2.0
+
+menu "Layout Types"
+
+endmenu
diff --git a/drivers/nvmem/layouts/Makefile b/drivers/nvmem/layouts/Makefile
new file mode 100644
index 000000000000..6fdb3c60a4fa
--- /dev/null
+++ b/drivers/nvmem/layouts/Makefile
@@ -0,0 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# Makefile for nvmem layouts.
+#
diff --git a/include/linux/nvmem-provider.h b/include/linux/nvmem-provider.h
index 72accdbe1d96..8a41bb30fc87 100644
--- a/include/linux/nvmem-provider.h
+++ b/include/linux/nvmem-provider.h
@@ -89,6 +89,7 @@ struct nvmem_cell_info {
  * @priv:	User context passed to read/write callbacks.
  * @wp-gpio:	Write protect pin
  * @ignore_wp:  Write Protect pin is managed by the provider.
+ * @layout:	Fixed layout associated with this nvmem device.
  *
  * Note: A default "nvmem<id>" name will be assigned to the device if
  * no name is specified in its configuration. In such case "<id>" is
@@ -111,6 +112,7 @@ struct nvmem_config {
 	bool			read_only;
 	bool			root_only;
 	bool			ignore_wp;
+	struct nvmem_layout	*layout;
 	struct device_node	*of_node;
 	bool			no_of_node;
 	nvmem_reg_read_t	reg_read;
@@ -144,6 +146,33 @@ struct nvmem_cell_table {
 	struct list_head	node;
 };
 
+/**
+ * struct nvmem_layout - NVMEM layout definitions
+ *
+ * @name:		Layout name.
+ * @of_match_table:	Open firmware match table.
+ * @add_cells:		Will be called if a nvmem device is found which
+ *			has this layout. The function will add layout
+ *			specific cells with nvmem_add_one_cell().
+ * @owner:		Pointer to struct module.
+ * @node:		List node.
+ *
+ * A nvmem device can hold a well defined structure which can just be
+ * evaluated during runtime. For example a TLV list, or a list of "name=val"
+ * pairs. A nvmem layout can parse the nvmem device and add appropriate
+ * cells.
+ */
+struct nvmem_layout {
+	const char *name;
+	const struct of_device_id *of_match_table;
+	int (*add_cells)(struct device *dev, struct nvmem_device *nvmem,
+			 struct nvmem_layout *layout);
+
+	/* private */
+	struct module *owner;
+	struct list_head node;
+};
+
 #if IS_ENABLED(CONFIG_NVMEM)
 
 struct nvmem_device *nvmem_register(const struct nvmem_config *cfg);
@@ -158,6 +187,14 @@ void nvmem_del_cell_table(struct nvmem_cell_table *table);
 int nvmem_add_one_cell(struct nvmem_device *nvmem,
 		       const struct nvmem_cell_info *info);
 
+int __nvmem_layout_register(struct nvmem_layout *layout, struct module *owner);
+#define nvmem_layout_register(layout) \
+	__nvmem_layout_register(layout, THIS_MODULE)
+void nvmem_layout_unregister(struct nvmem_layout *layout);
+
+const void *nvmem_layout_get_match_data(struct nvmem_device *nvmem,
+					struct nvmem_layout *layout);
+
 #else
 
 static inline struct nvmem_device *nvmem_register(const struct nvmem_config *c)
@@ -178,5 +215,19 @@ static inline void nvmem_del_cell_table(struct nvmem_cell_table *table) {}
 static inline int nvmem_add_one_cell(struct nvmem_device *nvmem,
 				     const struct nvmem_cell_info *info) {}
 
+static inline int nvmem_layout_register(struct nvmem_layout *layout)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline void nvmem_layout_unregister(struct nvmem_layout *layout) {}
+
+static inline const void *
+nvmem_layout_get_match_data(struct nvmem_device *nvmem,
+			    struct nvmem_layout *layout)
+{
+	return NULL;
+}
+
 #endif /* CONFIG_NVMEM */
 #endif  /* ifndef _LINUX_NVMEM_PROVIDER_H */
-- 
2.30.2

