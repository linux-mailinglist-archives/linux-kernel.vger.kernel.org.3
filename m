Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 703A85955EA
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 11:08:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233079AbiHPJIQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 05:08:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233403AbiHPJHf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 05:07:35 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3DF38BCC3D
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 00:25:12 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1FCBA1D34;
        Tue, 16 Aug 2022 00:25:12 -0700 (PDT)
Received: from e120937-lin.home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 83A1B3F70D;
        Tue, 16 Aug 2022 00:25:09 -0700 (PDT)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, james.quinlan@broadcom.com,
        Jonathan.Cameron@Huawei.com, f.fainelli@gmail.com,
        etienne.carriere@linaro.org, vincent.guittot@linaro.org,
        souvik.chakravarty@arm.com, wleavitt@marvell.com,
        peter.hilber@opensynergy.com, nicola.mazzucato@arm.com,
        tarek.el-sherbiny@arm.com, cristian.marussi@arm.com
Subject: [RFC PATCH 2/6] firmware: arm_scmi: Add bus helpers to enter raw mode
Date:   Tue, 16 Aug 2022 08:24:46 +0100
Message-Id: <20220816072450.3120959-3-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220816072450.3120959-1-cristian.marussi@arm.com>
References: <20220816072450.3120959-1-cristian.marussi@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a couple of helpers to be able to trigger the un-registration and the
re-registration of the whole stack of SCMI drivers from/to the SCMI bus.

Once this mode is enabled any new SCMI driver registration is inhibited
and delayed till the this new mode is disabled.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
 drivers/firmware/arm_scmi/bus.c    | 69 +++++++++++++++++++++++++++++-
 drivers/firmware/arm_scmi/common.h |  2 +
 include/linux/scmi_protocol.h      |  1 +
 3 files changed, 71 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/arm_scmi/bus.c b/drivers/firmware/arm_scmi/bus.c
index d4e23101448a..c4b3371dcb1b 100644
--- a/drivers/firmware/arm_scmi/bus.c
+++ b/drivers/firmware/arm_scmi/bus.c
@@ -19,6 +19,10 @@ static DEFINE_IDA(scmi_bus_id);
 static DEFINE_IDR(scmi_protocols);
 static DEFINE_SPINLOCK(protocol_lock);
 
+static bool scmi_raw_mode_enabled;
+static LIST_HEAD(scmi_registered_drivers);
+static DEFINE_MUTEX(scmi_raw_mode_mtx);
+
 static const struct scmi_device_id *
 scmi_dev_match_id(struct scmi_device *scmi_dev, struct scmi_driver *scmi_drv)
 {
@@ -144,6 +148,18 @@ int scmi_driver_register(struct scmi_driver *driver, struct module *owner,
 	driver->driver.owner = owner;
 	driver->driver.mod_name = mod_name;
 
+	mutex_lock(&scmi_raw_mode_mtx);
+	list_add_tail(&driver->node, &scmi_registered_drivers);
+	/*
+	 * If RAW mode is enabled here, the driver will be registered fully
+	 * only later, when RAW will be (if ever) disabled.
+	 */
+	if (scmi_raw_mode_enabled) {
+		mutex_unlock(&scmi_raw_mode_mtx);
+		return 0;
+	}
+	mutex_unlock(&scmi_raw_mode_mtx);
+
 	retval = driver_register(&driver->driver);
 	if (!retval)
 		pr_debug("registered new scmi driver %s\n", driver->name);
@@ -154,7 +170,18 @@ EXPORT_SYMBOL_GPL(scmi_driver_register);
 
 void scmi_driver_unregister(struct scmi_driver *driver)
 {
-	driver_unregister(&driver->driver);
+	mutex_lock(&scmi_raw_mode_mtx);
+	list_del_init(&driver->node);
+	/*
+	 * No need to unregister a driver when RAW mode is enabled, it would
+	 * have been already unregistered when RAW was enabled.
+	 */
+	if (!scmi_raw_mode_enabled) {
+		mutex_unlock(&scmi_raw_mode_mtx);
+		driver_unregister(&driver->driver);
+		mutex_lock(&scmi_raw_mode_mtx);
+	}
+	mutex_unlock(&scmi_raw_mode_mtx);
 	scmi_protocol_device_unrequest(driver->id_table);
 }
 EXPORT_SYMBOL_GPL(scmi_driver_unregister);
@@ -276,6 +303,46 @@ static void scmi_devices_unregister(void)
 	bus_for_each_dev(&scmi_bus_type, NULL, NULL, __scmi_devices_unregister);
 }
 
+void scmi_bus_raw_mode_enable(void)
+{
+	struct scmi_driver *driver;
+
+	/* On enable any known SCMI driver is unregistered */
+	mutex_lock(&scmi_raw_mode_mtx);
+	list_for_each_entry_reverse(driver, &scmi_registered_drivers, node) {
+		mutex_unlock(&scmi_raw_mode_mtx);
+
+		driver_unregister(&driver->driver);
+
+		mutex_lock(&scmi_raw_mode_mtx);
+	}
+	scmi_raw_mode_enabled = true;
+	mutex_unlock(&scmi_raw_mode_mtx);
+}
+
+void scmi_bus_raw_mode_disable(void)
+{
+	int retval;
+	struct scmi_driver *driver;
+
+	/*
+	 * On disable any known SCMI driver is registered again unless it was
+	 * removed already as a module.
+	 */
+	mutex_lock(&scmi_raw_mode_mtx);
+	list_for_each_entry(driver, &scmi_registered_drivers, node) {
+		mutex_unlock(&scmi_raw_mode_mtx);
+
+		retval = driver_register(&driver->driver);
+		if (retval)
+			pr_warn("Failed to rebind driver %s\n", driver->name);
+
+		mutex_lock(&scmi_raw_mode_mtx);
+	}
+	scmi_raw_mode_enabled = false;
+	mutex_unlock(&scmi_raw_mode_mtx);
+}
+
 int __init scmi_bus_init(void)
 {
 	int retval;
diff --git a/drivers/firmware/arm_scmi/common.h b/drivers/firmware/arm_scmi/common.h
index 61aba7447c32..bbaac20544a5 100644
--- a/drivers/firmware/arm_scmi/common.h
+++ b/drivers/firmware/arm_scmi/common.h
@@ -171,6 +171,8 @@ int scmi_protocol_device_request(const struct scmi_device_id *id_table);
 void scmi_protocol_device_unrequest(const struct scmi_device_id *id_table);
 struct scmi_device *scmi_child_dev_find(struct device *parent,
 					int prot_id, const char *name);
+void scmi_bus_raw_mode_enable(void);
+void scmi_bus_raw_mode_disable(void);
 
 /**
  * struct scmi_desc - Description of SoC integration
diff --git a/include/linux/scmi_protocol.h b/include/linux/scmi_protocol.h
index 4f765bc788ff..39e64ec72984 100644
--- a/include/linux/scmi_protocol.h
+++ b/include/linux/scmi_protocol.h
@@ -820,6 +820,7 @@ struct scmi_driver {
 	void (*remove)(struct scmi_device *sdev);
 	const struct scmi_device_id *id_table;
 
+	struct list_head node;
 	struct device_driver driver;
 };
 
-- 
2.32.0

