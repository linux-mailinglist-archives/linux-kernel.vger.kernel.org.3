Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9433D519C07
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 11:37:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347543AbiEDJk4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 05:40:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347562AbiEDJkb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 05:40:31 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id ADC752657A
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 02:36:51 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 85953153B;
        Wed,  4 May 2022 02:36:51 -0700 (PDT)
Received: from e120937-lin.home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EB6C13FA50;
        Wed,  4 May 2022 02:36:49 -0700 (PDT)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, james.quinlan@broadcom.com,
        Jonathan.Cameron@Huawei.com, f.fainelli@gmail.com,
        vincent.guittot@linaro.org, daniel.lezcano@linaro.org,
        tarek.el-sherbiny@arm.com, adrian.slatineanu@arm.com,
        souvik.chakravarty@arm.com,
        Cristian Marussi <cristian.marussi@arm.com>
Subject: [PATCH 6/7] firmware: arm_scmi: Add scmi_driver optional setup/teardown callbacks
Date:   Wed,  4 May 2022 10:36:08 +0100
Message-Id: <20220504093609.3077646-7-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220504093609.3077646-1-cristian.marussi@arm.com>
References: <20220504093609.3077646-1-cristian.marussi@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add optional .setup and .teardown methods to the scmi_driver descriptor:
such callbacks, if provided, will be called by the SCIM core at driver
registration time, so that, an SCMI driver, registered as usual with the
module_scmi_driver() helper macro, can provide custom callbacks to be
run once for all at module load/unload time to perform specific setup
or teardown operations before/after .probe and .remove steps.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
 drivers/firmware/arm_scmi/bus.c | 15 +++++++++++++--
 include/linux/scmi_protocol.h   |  2 ++
 2 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/arm_scmi/bus.c b/drivers/firmware/arm_scmi/bus.c
index f6fe723ab869..e95085a66bc4 100644
--- a/drivers/firmware/arm_scmi/bus.c
+++ b/drivers/firmware/arm_scmi/bus.c
@@ -132,12 +132,21 @@ int scmi_driver_register(struct scmi_driver *driver, struct module *owner,
 {
 	int retval;
 
-	if (!driver->probe)
+	if (!driver->probe || !driver->id_table)
 		return -EINVAL;
 
+	if (driver->setup) {
+		retval = driver->setup();
+		if (retval)
+			return retval;
+	}
+
 	retval = scmi_protocol_device_request(driver->id_table);
-	if (retval)
+	if (retval) {
+		if (driver->teardown)
+			driver->teardown();
 		return retval;
+	}
 
 	driver->driver.bus = &scmi_bus_type;
 	driver->driver.name = driver->name;
@@ -156,6 +165,8 @@ void scmi_driver_unregister(struct scmi_driver *driver)
 {
 	driver_unregister(&driver->driver);
 	scmi_protocol_device_unrequest(driver->id_table);
+	if (driver->teardown)
+		driver->teardown();
 }
 EXPORT_SYMBOL_GPL(scmi_driver_unregister);
 
diff --git a/include/linux/scmi_protocol.h b/include/linux/scmi_protocol.h
index 6f24715ca2fd..22728893959e 100644
--- a/include/linux/scmi_protocol.h
+++ b/include/linux/scmi_protocol.h
@@ -799,6 +799,8 @@ struct scmi_device_id {
 
 struct scmi_driver {
 	const char *name;
+	int (*setup)(void);
+	void (*teardown)(void);
 	int (*probe)(struct scmi_device *sdev);
 	void (*remove)(struct scmi_device *sdev);
 	const struct scmi_device_id *id_table;
-- 
2.32.0

