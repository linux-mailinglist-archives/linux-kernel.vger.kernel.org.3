Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E904C4A73FC
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 15:57:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345192AbiBBOxh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 09:53:37 -0500
Received: from mga18.intel.com ([134.134.136.126]:53177 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230328AbiBBOxg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 09:53:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643813616; x=1675349616;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6fKvC1dWE359KnX2Y/1W6BSF0JiY2aYfeii4GZWU9zg=;
  b=ECxa6Ha0vCwlqKxuOj85NDdFSFq3SDmkP50k1L5i13EDbLd69AbegZQL
   j8T/U5fSEvVm+xvJu22jsUXfs6EalFf1f2MvsqGHHMJKvhJKM3YHqU7CS
   zvOfOdLT5fR6XUG8xIKaXxepP7vp7QLykyMOTVR/kbtWTkW1yyd47cvLT
   BmcNwEXMO27/MNHIzjPG7WjPGXDuogiXykamIR9azq42Rp+Qj3XrOYz7v
   rrhZ8sUrzZqzNH/WHlafFEmSYBBU6j4i2BT+rWmbdor4By5LDJvJJc8Ia
   5yorHsz+VF3g8mrzPmAqZeYx7c1+gRqmRZ1HZRIwaKz0nLnBI9PixJcS6
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10245"; a="231498647"
X-IronPort-AV: E=Sophos;i="5.88,337,1635231600"; 
   d="scan'208";a="231498647"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2022 06:53:36 -0800
X-IronPort-AV: E=Sophos;i="5.88,337,1635231600"; 
   d="scan'208";a="599579999"
Received: from mwnuczyn-mobl.ger.corp.intel.com (HELO localhost) ([10.249.137.160])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2022 06:53:27 -0800
From:   Iwona Winiarska <iwona.winiarska@intel.com>
To:     linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devicetree@vger.kernel.org, linux-aspeed@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-hwmon@vger.kernel.org,
        linux-doc@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Borislav Petkov <bp@alien8.de>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Zev Weiss <zweiss@equinix.com>,
        David Muller <d.mueller@elsoft.ch>,
        Dave Hansen <dave.hansen@intel.com>,
        Billy Tsai <billy_tsai@aspeedtech.com>,
        Iwona Winiarska <iwona.winiarska@intel.com>
Subject: [PATCH v7 08/13] peci: Add support for PECI device drivers
Date:   Wed,  2 Feb 2022 15:48:33 +0100
Message-Id: <20220202144838.163875-9-iwona.winiarska@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220202144838.163875-1-iwona.winiarska@intel.com>
References: <20220202144838.163875-1-iwona.winiarska@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for PECI device drivers, which unlike PECI controller
drivers are actually able to provide functionalities to userspace.

Also, extend peci_request API to allow querying more details about PECI
device (e.g. model/family), that's going to be used to find a compatible
peci_driver.

Signed-off-by: Iwona Winiarska <iwona.winiarska@intel.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 drivers/peci/core.c     |  44 +++++++++
 drivers/peci/device.c   | 130 ++++++++++++++++++++++++
 drivers/peci/internal.h |  74 ++++++++++++++
 drivers/peci/request.c  | 214 ++++++++++++++++++++++++++++++++++++++++
 include/linux/peci.h    |  19 ++++
 5 files changed, 481 insertions(+)

diff --git a/drivers/peci/core.c b/drivers/peci/core.c
index e993615cf521..9c8cf07e51c7 100644
--- a/drivers/peci/core.c
+++ b/drivers/peci/core.c
@@ -160,8 +160,52 @@ struct peci_controller *devm_peci_controller_add(struct device *dev,
 }
 EXPORT_SYMBOL_NS_GPL(devm_peci_controller_add, PECI);
 
+static const struct peci_device_id *
+peci_bus_match_device_id(const struct peci_device_id *id, struct peci_device *device)
+{
+	while (id->family != 0) {
+		if (id->family == device->info.family &&
+		    id->model == device->info.model)
+			return id;
+		id++;
+	}
+
+	return NULL;
+}
+
+static int peci_bus_device_match(struct device *dev, struct device_driver *drv)
+{
+	struct peci_device *device = to_peci_device(dev);
+	struct peci_driver *peci_drv = to_peci_driver(drv);
+
+	if (dev->type != &peci_device_type)
+		return 0;
+
+	return !!peci_bus_match_device_id(peci_drv->id_table, device);
+}
+
+static int peci_bus_device_probe(struct device *dev)
+{
+	struct peci_device *device = to_peci_device(dev);
+	struct peci_driver *driver = to_peci_driver(dev->driver);
+
+	return driver->probe(device, peci_bus_match_device_id(driver->id_table, device));
+}
+
+static void peci_bus_device_remove(struct device *dev)
+{
+	struct peci_device *device = to_peci_device(dev);
+	struct peci_driver *driver = to_peci_driver(dev->driver);
+
+	if (driver->remove)
+		driver->remove(device);
+}
+
 struct bus_type peci_bus_type = {
 	.name		= "peci",
+	.match		= peci_bus_device_match,
+	.probe		= peci_bus_device_probe,
+	.remove		= peci_bus_device_remove,
 	.bus_groups	= peci_bus_groups,
 };
 
diff --git a/drivers/peci/device.c b/drivers/peci/device.c
index d10ed1cfcd48..184b5e650b0b 100644
--- a/drivers/peci/device.c
+++ b/drivers/peci/device.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-only
 // Copyright (c) 2018-2021 Intel Corporation
 
+#include <linux/bitfield.h>
 #include <linux/peci.h>
 #include <linux/slab.h>
 
@@ -13,6 +14,104 @@
  */
 static DEFINE_MUTEX(peci_device_del_lock);
 
+#define REVISION_NUM_MASK GENMASK(15, 8)
+static int peci_get_revision(struct peci_device *device, u8 *revision)
+{
+	struct peci_request *req;
+	u64 dib;
+
+	req = peci_xfer_get_dib(device);
+	if (IS_ERR(req))
+		return PTR_ERR(req);
+
+	/*
+	 * PECI device may be in a state where it is unable to return a proper
+	 * DIB, in which case it returns 0 as DIB value.
+	 * Let's treat this as an error to avoid carrying on with the detection
+	 * using invalid revision.
+	 */
+	dib = peci_request_dib_read(req);
+	if (dib == 0) {
+		peci_request_free(req);
+		return -EIO;
+	}
+
+	*revision = FIELD_GET(REVISION_NUM_MASK, dib);
+
+	peci_request_free(req);
+
+	return 0;
+}
+
+static int peci_get_cpu_id(struct peci_device *device, u32 *cpu_id)
+{
+	struct peci_request *req;
+	int ret;
+
+	req = peci_xfer_pkg_cfg_readl(device, PECI_PCS_PKG_ID, PECI_PKG_ID_CPU_ID);
+	if (IS_ERR(req))
+		return PTR_ERR(req);
+
+	ret = peci_request_status(req);
+	if (ret)
+		goto out_req_free;
+
+	*cpu_id = peci_request_data_readl(req);
+out_req_free:
+	peci_request_free(req);
+
+	return ret;
+}
+
+static unsigned int peci_x86_cpu_family(unsigned int sig)
+{
+	unsigned int x86;
+
+	x86 = (sig >> 8) & 0xf;
+
+	if (x86 == 0xf)
+		x86 += (sig >> 20) & 0xff;
+
+	return x86;
+}
+
+static unsigned int peci_x86_cpu_model(unsigned int sig)
+{
+	unsigned int fam, model;
+
+	fam = peci_x86_cpu_family(sig);
+
+	model = (sig >> 4) & 0xf;
+
+	if (fam >= 0x6)
+		model += ((sig >> 16) & 0xf) << 4;
+
+	return model;
+}
+
+static int peci_device_info_init(struct peci_device *device)
+{
+	u8 revision;
+	u32 cpu_id;
+	int ret;
+
+	ret = peci_get_cpu_id(device, &cpu_id);
+	if (ret)
+		return ret;
+
+	device->info.family = peci_x86_cpu_family(cpu_id);
+	device->info.model = peci_x86_cpu_model(cpu_id);
+
+	ret = peci_get_revision(device, &revision);
+	if (ret)
+		return ret;
+	device->info.peci_revision = revision;
+
+	device->info.socket_id = device->addr - PECI_BASE_ADDR;
+
+	return 0;
+}
+
 static int peci_detect(struct peci_controller *controller, u8 addr)
 {
 	/*
@@ -82,6 +181,10 @@ int peci_device_create(struct peci_controller *controller, u8 addr)
 	device->dev.bus = &peci_bus_type;
 	device->dev.type = &peci_device_type;
 
+	ret = peci_device_info_init(device);
+	if (ret)
+		goto err_put;
+
 	ret = dev_set_name(&device->dev, "%d-%02x", controller->id, device->addr);
 	if (ret)
 		goto err_put;
@@ -108,6 +211,33 @@ void peci_device_destroy(struct peci_device *device)
 	mutex_unlock(&peci_device_del_lock);
 }
 
+int __peci_driver_register(struct peci_driver *driver, struct module *owner,
+			   const char *mod_name)
+{
+	driver->driver.bus = &peci_bus_type;
+	driver->driver.owner = owner;
+	driver->driver.mod_name = mod_name;
+
+	if (!driver->probe) {
+		pr_err("peci: trying to register driver without probe callback\n");
+		return -EINVAL;
+	}
+
+	if (!driver->id_table) {
+		pr_err("peci: trying to register driver without device id table\n");
+		return -EINVAL;
+	}
+
+	return driver_register(&driver->driver);
+}
+EXPORT_SYMBOL_NS_GPL(__peci_driver_register, PECI);
+
+void peci_driver_unregister(struct peci_driver *driver)
+{
+	driver_unregister(&driver->driver);
+}
+EXPORT_SYMBOL_NS_GPL(peci_driver_unregister, PECI);
+
 static void peci_device_release(struct device *dev)
 {
 	struct peci_device *device = to_peci_device(dev);
diff --git a/drivers/peci/internal.h b/drivers/peci/internal.h
index 978e12c8e1d3..52c02e12874f 100644
--- a/drivers/peci/internal.h
+++ b/drivers/peci/internal.h
@@ -19,6 +19,35 @@ struct peci_request;
 struct peci_request *peci_request_alloc(struct peci_device *device, u8 tx_len, u8 rx_len);
 void peci_request_free(struct peci_request *req);
 
+int peci_request_status(struct peci_request *req);
+
+u64 peci_request_dib_read(struct peci_request *req);
+
+u8 peci_request_data_readb(struct peci_request *req);
+u16 peci_request_data_readw(struct peci_request *req);
+u32 peci_request_data_readl(struct peci_request *req);
+u64 peci_request_data_readq(struct peci_request *req);
+
+struct peci_request *peci_xfer_get_dib(struct peci_device *device);
+struct peci_request *peci_xfer_get_temp(struct peci_device *device);
+
+struct peci_request *peci_xfer_pkg_cfg_readb(struct peci_device *device, u8 index, u16 param);
+struct peci_request *peci_xfer_pkg_cfg_readw(struct peci_device *device, u8 index, u16 param);
+struct peci_request *peci_xfer_pkg_cfg_readl(struct peci_device *device, u8 index, u16 param);
+struct peci_request *peci_xfer_pkg_cfg_readq(struct peci_device *device, u8 index, u16 param);
+
+/**
+ * struct peci_device_id - PECI device data to match
+ * @data: pointer to driver private data specific to device
+ * @family: device family
+ * @model: device model
+ */
+struct peci_device_id {
+	const void *data;
+	u16 family;
+	u8 model;
+};
+
 extern struct device_type peci_device_type;
 extern const struct attribute_group *peci_device_groups[];
 
@@ -28,6 +57,51 @@ void peci_device_destroy(struct peci_device *device);
 extern struct bus_type peci_bus_type;
 extern const struct attribute_group *peci_bus_groups[];
 
+/**
+ * struct peci_driver - PECI driver
+ * @driver: inherit device driver
+ * @probe: probe callback
+ * @remove: remove callback
+ * @id_table: PECI device match table to decide which device to bind
+ */
+struct peci_driver {
+	struct device_driver driver;
+	int (*probe)(struct peci_device *device, const struct peci_device_id *id);
+	void (*remove)(struct peci_device *device);
+	const struct peci_device_id *id_table;
+};
+
+static inline struct peci_driver *to_peci_driver(struct device_driver *d)
+{
+	return container_of(d, struct peci_driver, driver);
+}
+
+int __peci_driver_register(struct peci_driver *driver, struct module *owner,
+			   const char *mod_name);
+/**
+ * peci_driver_register() - register PECI driver
+ * @driver: the driver to be registered
+ *
+ * PECI drivers that don't need to do anything special in module init should
+ * use the convenience "module_peci_driver" macro instead
+ *
+ * Return: zero on success, else a negative error code.
+ */
+#define peci_driver_register(driver) \
+	__peci_driver_register(driver, THIS_MODULE, KBUILD_MODNAME)
+void peci_driver_unregister(struct peci_driver *driver);
+
+/**
+ * module_peci_driver() - helper macro for registering a modular PECI driver
+ * @__peci_driver: peci_driver struct
+ *
+ * Helper macro for PECI drivers which do not do anything special in module
+ * init/exit. This eliminates a lot of boilerplate. Each module may only
+ * use this macro once, and calling it replaces module_init() and module_exit()
+ */
+#define module_peci_driver(__peci_driver) \
+	module_driver(__peci_driver, peci_driver_register, peci_driver_unregister)
+
 extern struct device_type peci_controller_type;
 
 int peci_controller_scan_devices(struct peci_controller *controller);
diff --git a/drivers/peci/request.c b/drivers/peci/request.c
index 7dee51c50dd2..a49eb351cda3 100644
--- a/drivers/peci/request.c
+++ b/drivers/peci/request.c
@@ -1,13 +1,140 @@
 // SPDX-License-Identifier: GPL-2.0-only
 // Copyright (c) 2021 Intel Corporation
 
+#include <linux/bug.h>
 #include <linux/export.h>
 #include <linux/peci.h>
 #include <linux/slab.h>
 #include <linux/types.h>
 
+#include <asm/unaligned.h>
+
 #include "internal.h"
 
+#define PECI_GET_DIB_CMD		0xf7
+#define  PECI_GET_DIB_WR_LEN		1
+#define  PECI_GET_DIB_RD_LEN		8
+
+#define PECI_RDPKGCFG_CMD		0xa1
+#define  PECI_RDPKGCFG_WR_LEN		5
+#define  PECI_RDPKGCFG_RD_LEN_BASE	1
+#define PECI_WRPKGCFG_CMD		0xa5
+#define  PECI_WRPKGCFG_WR_LEN_BASE	6
+#define  PECI_WRPKGCFG_RD_LEN		1
+
+/* Device Specific Completion Code (CC) Definition */
+#define PECI_CC_SUCCESS				0x40
+#define PECI_CC_NEED_RETRY			0x80
+#define PECI_CC_OUT_OF_RESOURCE			0x81
+#define PECI_CC_UNAVAIL_RESOURCE		0x82
+#define PECI_CC_INVALID_REQ			0x90
+#define PECI_CC_MCA_ERROR			0x91
+#define PECI_CC_CATASTROPHIC_MCA_ERROR		0x93
+#define PECI_CC_FATAL_MCA_ERROR			0x94
+#define PECI_CC_PARITY_ERR_GPSB_OR_PMSB		0x98
+#define PECI_CC_PARITY_ERR_GPSB_OR_PMSB_IERR	0x9B
+#define PECI_CC_PARITY_ERR_GPSB_OR_PMSB_MCA	0x9C
+
+#define PECI_RETRY_BIT			BIT(0)
+
+#define PECI_RETRY_TIMEOUT		msecs_to_jiffies(700)
+#define PECI_RETRY_INTERVAL_MIN		msecs_to_jiffies(1)
+#define PECI_RETRY_INTERVAL_MAX		msecs_to_jiffies(128)
+
+static u8 peci_request_data_cc(struct peci_request *req)
+{
+	return req->rx.buf[0];
+}
+
+/**
+ * peci_request_status() - return -errno based on PECI completion code
+ * @req: the PECI request that contains response data with completion code
+ *
+ * It can't be used for Ping(), GetDIB() and GetTemp() - for those commands we
+ * don't expect completion code in the response.
+ *
+ * Return: -errno
+ */
+int peci_request_status(struct peci_request *req)
+{
+	u8 cc = peci_request_data_cc(req);
+
+	if (cc != PECI_CC_SUCCESS)
+		dev_dbg(&req->device->dev, "ret: %#02x\n", cc);
+
+	switch (cc) {
+	case PECI_CC_SUCCESS:
+		return 0;
+	case PECI_CC_NEED_RETRY:
+	case PECI_CC_OUT_OF_RESOURCE:
+	case PECI_CC_UNAVAIL_RESOURCE:
+		return -EAGAIN;
+	case PECI_CC_INVALID_REQ:
+		return -EINVAL;
+	case PECI_CC_MCA_ERROR:
+	case PECI_CC_CATASTROPHIC_MCA_ERROR:
+	case PECI_CC_FATAL_MCA_ERROR:
+	case PECI_CC_PARITY_ERR_GPSB_OR_PMSB:
+	case PECI_CC_PARITY_ERR_GPSB_OR_PMSB_IERR:
+	case PECI_CC_PARITY_ERR_GPSB_OR_PMSB_MCA:
+		return -EIO;
+	}
+
+	WARN_ONCE(1, "Unknown PECI completion code: %#02x\n", cc);
+
+	return -EIO;
+}
+EXPORT_SYMBOL_NS_GPL(peci_request_status, PECI);
+
+static int peci_request_xfer(struct peci_request *req)
+{
+	struct peci_device *device = req->device;
+	struct peci_controller *controller = to_peci_controller(device->dev.parent);
+	int ret;
+
+	mutex_lock(&controller->bus_lock);
+	ret = controller->ops->xfer(controller, device->addr, req);
+	mutex_unlock(&controller->bus_lock);
+
+	return ret;
+}
+
+static int peci_request_xfer_retry(struct peci_request *req)
+{
+	long wait_interval = PECI_RETRY_INTERVAL_MIN;
+	struct peci_device *device = req->device;
+	struct peci_controller *controller = to_peci_controller(device->dev.parent);
+	unsigned long start = jiffies;
+	int ret;
+
+	/* Don't try to use it for ping */
+	if (WARN_ON(req->tx.len == 0))
+		return 0;
+
+	do {
+		ret = peci_request_xfer(req);
+		if (ret) {
+			dev_dbg(&controller->dev, "xfer error: %d\n", ret);
+			return ret;
+		}
+
+		if (peci_request_status(req) != -EAGAIN)
+			return 0;
+
+		/* Set the retry bit to indicate a retry attempt */
+		req->tx.buf[1] |= PECI_RETRY_BIT;
+
+		if (schedule_timeout_interruptible(wait_interval))
+			return -ERESTARTSYS;
+
+		wait_interval = min_t(long, wait_interval * 2, PECI_RETRY_INTERVAL_MAX);
+	} while (time_before(jiffies, start + PECI_RETRY_TIMEOUT));
+
+	dev_dbg(&controller->dev, "request timed out\n");
+
+	return -ETIMEDOUT;
+}
+
 /**
  * peci_request_alloc() - allocate &struct peci_requests
  * @device: PECI device to which request is going to be sent
@@ -53,3 +180,90 @@ void peci_request_free(struct peci_request *req)
 	kfree(req);
 }
 EXPORT_SYMBOL_NS_GPL(peci_request_free, PECI);
+
+struct peci_request *peci_xfer_get_dib(struct peci_device *device)
+{
+	struct peci_request *req;
+	int ret;
+
+	req = peci_request_alloc(device, PECI_GET_DIB_WR_LEN, PECI_GET_DIB_RD_LEN);
+	if (!req)
+		return ERR_PTR(-ENOMEM);
+
+	req->tx.buf[0] = PECI_GET_DIB_CMD;
+
+	ret = peci_request_xfer(req);
+	if (ret) {
+		peci_request_free(req);
+		return ERR_PTR(ret);
+	}
+
+	return req;
+}
+EXPORT_SYMBOL_NS_GPL(peci_xfer_get_dib, PECI);
+
+static struct peci_request *
+__pkg_cfg_read(struct peci_device *device, u8 index, u16 param, u8 len)
+{
+	struct peci_request *req;
+	int ret;
+
+	req = peci_request_alloc(device, PECI_RDPKGCFG_WR_LEN, PECI_RDPKGCFG_RD_LEN_BASE + len);
+	if (!req)
+		return ERR_PTR(-ENOMEM);
+
+	req->tx.buf[0] = PECI_RDPKGCFG_CMD;
+	req->tx.buf[1] = 0;
+	req->tx.buf[2] = index;
+	put_unaligned_le16(param, &req->tx.buf[3]);
+
+	ret = peci_request_xfer_retry(req);
+	if (ret) {
+		peci_request_free(req);
+		return ERR_PTR(ret);
+	}
+
+	return req;
+}
+
+u8 peci_request_data_readb(struct peci_request *req)
+{
+	return req->rx.buf[1];
+}
+EXPORT_SYMBOL_NS_GPL(peci_request_data_readb, PECI);
+
+u16 peci_request_data_readw(struct peci_request *req)
+{
+	return get_unaligned_le16(&req->rx.buf[1]);
+}
+EXPORT_SYMBOL_NS_GPL(peci_request_data_readw, PECI);
+
+u32 peci_request_data_readl(struct peci_request *req)
+{
+	return get_unaligned_le32(&req->rx.buf[1]);
+}
+EXPORT_SYMBOL_NS_GPL(peci_request_data_readl, PECI);
+
+u64 peci_request_data_readq(struct peci_request *req)
+{
+	return get_unaligned_le64(&req->rx.buf[1]);
+}
+EXPORT_SYMBOL_NS_GPL(peci_request_data_readq, PECI);
+
+u64 peci_request_dib_read(struct peci_request *req)
+{
+	return get_unaligned_le64(&req->rx.buf[0]);
+}
+EXPORT_SYMBOL_NS_GPL(peci_request_dib_read, PECI);
+
+#define __read_pkg_config(x, type) \
+struct peci_request *peci_xfer_pkg_cfg_##x(struct peci_device *device, u8 index, u16 param) \
+{ \
+	return __pkg_cfg_read(device, index, param, sizeof(type)); \
+} \
+EXPORT_SYMBOL_NS_GPL(peci_xfer_pkg_cfg_##x, PECI)
+
+__read_pkg_config(readb, u8);
+__read_pkg_config(readw, u16);
+__read_pkg_config(readl, u32);
+__read_pkg_config(readq, u64);
diff --git a/include/linux/peci.h b/include/linux/peci.h
index 7e35673f3786..4eda423ba10c 100644
--- a/include/linux/peci.h
+++ b/include/linux/peci.h
@@ -14,6 +14,14 @@
  */
 #define PECI_REQUEST_MAX_BUF_SIZE 32
 
+#define PECI_PCS_PKG_ID			0  /* Package Identifier Read */
+#define  PECI_PKG_ID_CPU_ID		0x0000  /* CPUID Info */
+#define  PECI_PKG_ID_PLATFORM_ID	0x0001  /* Platform ID */
+#define  PECI_PKG_ID_DEVICE_ID		0x0002  /* Uncore Device ID */
+#define  PECI_PKG_ID_MAX_THREAD_ID	0x0003  /* Max Thread ID */
+#define  PECI_PKG_ID_MICROCODE_REV	0x0004  /* CPU Microcode Update Revision */
+#define  PECI_PKG_ID_MCA_ERROR_LOG	0x0005  /* Machine Check Status */
+
 struct peci_controller;
 struct peci_request;
 
@@ -59,6 +67,11 @@ static inline struct peci_controller *to_peci_controller(void *d)
  * struct peci_device - PECI device
  * @dev: device object to register PECI device to the device model
  * @controller: manages the bus segment hosting this PECI device
+ * @info: PECI device characteristics
+ * @info.family: device family
+ * @info.model: device model
+ * @info.peci_revision: PECI revision supported by the PECI device
+ * @info.socket_id: the socket ID represented by the PECI device
  * @addr: address used on the PECI bus connected to the parent controller
  * @deleted: indicates that PECI device was already deleted
  *
@@ -68,6 +81,12 @@ static inline struct peci_controller *to_peci_controller(void *d)
  */
 struct peci_device {
 	struct device dev;
+	struct {
+		u16 family;
+		u8 model;
+		u8 peci_revision;
+		u8 socket_id;
+	} info;
 	u8 addr;
 	bool deleted;
 };
-- 
2.34.1

