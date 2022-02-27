Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C9C54C5EE0
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Feb 2022 21:56:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231771AbiB0U5Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Feb 2022 15:57:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231447AbiB0U5E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Feb 2022 15:57:04 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1D5932FFE7
        for <linux-kernel@vger.kernel.org>; Sun, 27 Feb 2022 12:56:27 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DEEEF12FC;
        Sun, 27 Feb 2022 12:56:26 -0800 (PST)
Received: from e120937-lin.home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8359E3F66F;
        Sun, 27 Feb 2022 12:56:25 -0800 (PST)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, james.quinlan@broadcom.com,
        Jonathan.Cameron@Huawei.com, f.fainelli@gmail.com,
        vincent.guittot@linaro.org, souvik.chakravarty@arm.com,
        peter.hilber@opensynergy.com, cristian.marussi@arm.com
Subject: [RFC PATCH 03/16] firmware: arm_scmi: Add multiple protocols registration support
Date:   Sun, 27 Feb 2022 20:55:55 +0000
Message-Id: <20220227205608.30812-4-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220227205608.30812-1-cristian.marussi@arm.com>
References: <20220227205608.30812-1-cristian.marussi@arm.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the capability for one SCMI driver to register with the core SCMI stack
to use multiple SCMI protocols: in such a case the SCMI driver probe
function will end up being called once for each registered protocol which
have been also found as implemented on the platform.

This is especially useful in testing scenarios.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
 drivers/firmware/arm_scmi/bus.c    |  4 ++--
 drivers/firmware/arm_scmi/common.h |  4 ++--
 drivers/firmware/arm_scmi/driver.c | 24 ++++++++++++++++++++++--
 3 files changed, 26 insertions(+), 6 deletions(-)

diff --git a/drivers/firmware/arm_scmi/bus.c b/drivers/firmware/arm_scmi/bus.c
index f6fe723ab869..e417e84249f2 100644
--- a/drivers/firmware/arm_scmi/bus.c
+++ b/drivers/firmware/arm_scmi/bus.c
@@ -135,7 +135,7 @@ int scmi_driver_register(struct scmi_driver *driver, struct module *owner,
 	if (!driver->probe)
 		return -EINVAL;
 
-	retval = scmi_protocol_device_request(driver->id_table);
+	retval = scmi_protocol_table_register(driver->id_table);
 	if (retval)
 		return retval;
 
@@ -155,7 +155,7 @@ EXPORT_SYMBOL_GPL(scmi_driver_register);
 void scmi_driver_unregister(struct scmi_driver *driver)
 {
 	driver_unregister(&driver->driver);
-	scmi_protocol_device_unrequest(driver->id_table);
+	scmi_protocol_table_unregister(driver->id_table);
 }
 EXPORT_SYMBOL_GPL(scmi_driver_unregister);
 
diff --git a/drivers/firmware/arm_scmi/common.h b/drivers/firmware/arm_scmi/common.h
index 4fda84bfab42..ffaf74a36b30 100644
--- a/drivers/firmware/arm_scmi/common.h
+++ b/drivers/firmware/arm_scmi/common.h
@@ -388,8 +388,8 @@ struct scmi_transport_ops {
 	bool (*poll_done)(struct scmi_chan_info *cinfo, struct scmi_xfer *xfer);
 };
 
-int scmi_protocol_device_request(const struct scmi_device_id *id_table);
-void scmi_protocol_device_unrequest(const struct scmi_device_id *id_table);
+int scmi_protocol_table_register(const struct scmi_device_id *id_table);
+void scmi_protocol_table_unregister(const struct scmi_device_id *id_table);
 struct scmi_device *scmi_child_dev_find(struct device *parent,
 					int prot_id, const char *name);
 
diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
index 4cb9e0ad7af5..8d356d4da0bd 100644
--- a/drivers/firmware/arm_scmi/driver.c
+++ b/drivers/firmware/arm_scmi/driver.c
@@ -1771,7 +1771,7 @@ static void scmi_create_protocol_devices(struct device_node *np,
  *
  * Return: 0 on Success
  */
-int scmi_protocol_device_request(const struct scmi_device_id *id_table)
+static int scmi_protocol_device_request(const struct scmi_device_id *id_table)
 {
 	int ret = 0;
 	unsigned int id = 0;
@@ -1882,6 +1882,17 @@ int scmi_protocol_device_request(const struct scmi_device_id *id_table)
 	return ret;
 }
 
+int scmi_protocol_table_register(const struct scmi_device_id *id_table)
+{
+	int ret = 0;
+	const struct scmi_device_id *entry;
+
+	for (entry = id_table; entry->name && ret == 0; entry++)
+		ret = scmi_protocol_device_request(entry);
+
+	return ret;
+}
+
 /**
  * scmi_protocol_device_unrequest  - Helper to unrequest a device
  *
@@ -1896,7 +1907,8 @@ int scmi_protocol_device_request(const struct scmi_device_id *id_table)
  * that cannot be safely destroyed till the whole SCMI stack is removed.
  * (unless adding further burden of refcounting.)
  */
-void scmi_protocol_device_unrequest(const struct scmi_device_id *id_table)
+static void
+scmi_protocol_device_unrequest(const struct scmi_device_id *id_table)
 {
 	struct list_head *phead;
 
@@ -1925,6 +1937,14 @@ void scmi_protocol_device_unrequest(const struct scmi_device_id *id_table)
 	mutex_unlock(&scmi_requested_devices_mtx);
 }
 
+void scmi_protocol_table_unregister(const struct scmi_device_id *id_table)
+{
+	const struct scmi_device_id *entry;
+
+	for (entry = id_table; entry->name; entry++)
+		scmi_protocol_device_unrequest(entry);
+}
+
 static int scmi_cleanup_txrx_channels(struct scmi_info *info)
 {
 	int ret;
-- 
2.17.1

