Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 093F45B0173
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 12:15:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230391AbiIGKPd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 06:15:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230212AbiIGKPH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 06:15:07 -0400
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87BD52CDE7
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 03:15:02 -0700 (PDT)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2876a3M5006643;
        Wed, 7 Sep 2022 05:14:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=feKchwoppPrkELgyg0NGjoUkLqBZXbRFHwDJEun2AkY=;
 b=gjFKs0vphFcvAi4tr4FhImRRKRpFkev9Qp1oiC/Q0rqgYZeCDktNokwIaP9M2PXkCn3y
 uIGbk63aFTcS7ch5G08wK1NI9P4eC5bIgCyJiV85s6xHSbdLxFXMT2RdpC3BKl6D04bk
 pRHq+/Fdib4Mqe4U11CtMZy0E+RT7a7QwZbBQlnGV+6O9vyIdelqR71mfvVsqsuRXHch
 Vlf2g8UHKtPgRtIhZSOlrwAPnMq3A4e/qpwnAomwgEzD+T2mcZqcuCdD6caW1JFISiaj
 udWNqMcBlpEs2jlBt2mDJq/dEdkOfxThcywlE8cwqwqfGTscpJv4/mANGcSS6gRQDiMF ag== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3jc4b2dfns-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 07 Sep 2022 05:14:18 -0500
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.12; Wed, 7 Sep
 2022 05:14:16 -0500
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.12 via Frontend
 Transport; Wed, 7 Sep 2022 05:14:16 -0500
Received: from debianA11184.ad.cirrus.com (unknown [198.61.65.149])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 0664C7C;
        Wed,  7 Sep 2022 10:14:15 +0000 (UTC)
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <vkoul@kernel.org>, <yung-chuan.liao@linux.intel.com>,
        <pierre-louis.bossart@linux.intel.com>, <lgirdwood@gmail.com>,
        <peter.ujfalusi@linux.intel.com>,
        <ranjani.sridharan@linux.intel.com>,
        <kai.vehmanen@linux.intel.com>, <daniel.baluta@nxp.com>,
        <sanyog.r.kale@intel.com>, <broonie@kernel.org>
CC:     <alsa-devel@alsa-project.org>,
        <sound-open-firmware@alsa-project.org>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: [PATCH 7/7] soundwire: bus: Fix premature removal of sdw_slave objects
Date:   Wed, 7 Sep 2022 11:14:02 +0100
Message-ID: <20220907101402.4685-8-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220907101402.4685-1-rf@opensource.cirrus.com>
References: <20220907101402.4685-1-rf@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: _ls588k8dOn_DCOUtnfdFdo7W2FW14bA
X-Proofpoint-ORIG-GUID: _ls588k8dOn_DCOUtnfdFdo7W2FW14bA
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the bus manager is removed sdw_bus_master_delete() should not
be deleting the struct sdw_slave objects until the bus manager has
been stopped. The first step of removing child drivers should only
be calling device_unregister() on the child. The counterpart to
sdw_drv_probe() is sdw_drv_remove(), not sdw_delete_slave().

The sdw_slave objects are created by the bus manager probe() from
ACPI/DT information. They are not created when a child driver probes
so should not be deleted by a child driver remove.

Change-Id: I25cc145df12fdc7c126f8f594a5f76eedce25488
Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
 drivers/soundwire/bus.c   | 30 ++++++++++++++++++++++++++----
 drivers/soundwire/slave.c | 21 +++++++++++++++++----
 2 files changed, 43 insertions(+), 8 deletions(-)

diff --git a/drivers/soundwire/bus.c b/drivers/soundwire/bus.c
index 1327a312be86..5533eb589286 100644
--- a/drivers/soundwire/bus.c
+++ b/drivers/soundwire/bus.c
@@ -146,9 +146,8 @@ int sdw_bus_master_add(struct sdw_bus *bus, struct device *parent,
 }
 EXPORT_SYMBOL(sdw_bus_master_add);
 
-static int sdw_delete_slave(struct device *dev, void *data)
+static int sdw_delete_slave(struct sdw_slave *slave)
 {
-	struct sdw_slave *slave = dev_to_sdw_dev(dev);
 	struct sdw_bus *bus = slave->bus;
 
 	sdw_slave_debugfs_exit(slave);
@@ -163,7 +162,24 @@ static int sdw_delete_slave(struct device *dev, void *data)
 	list_del_init(&slave->node);
 	mutex_unlock(&bus->bus_lock);
 
+	mutex_destroy(&slave->sdw_dev_lock);
+	kfree(slave);
+
+	return 0;
+}
+
+static int sdw_remove_child(struct device *dev, void *data)
+{
+	/*
+	 * Do not remove the struct sdw_slave yet. This is created by
+	 * the bus manager probe() from ACPI information and used by the
+	 * bus manager to hold status of each peripheral. Its lifetime
+	 * is that of the bus manager.
+	 */
+
+	/* This will call sdw_drv_remove() */
 	device_unregister(dev);
+
 	return 0;
 }
 
@@ -171,16 +187,22 @@ static int sdw_delete_slave(struct device *dev, void *data)
  * sdw_bus_master_delete() - delete the bus master instance
  * @bus: bus to be deleted
  *
- * Remove the instance, delete the child devices.
+ * Remove the child devices, remove the master instance.
  */
 void sdw_bus_master_delete(struct sdw_bus *bus)
 {
-	device_for_each_child(bus->dev, NULL, sdw_delete_slave);
+	struct sdw_slave *slave, *tmp;
+
+	device_for_each_child(bus->dev, NULL, sdw_remove_child);
 
 	/* Children have been removed so it is now safe for the bus to stop */
 	if (bus->ops->remove)
 		bus->ops->remove(bus);
 
+	/* Now the bus is stopped it is safe to free things */
+	list_for_each_entry_safe(slave, tmp, &bus->slaves, node)
+		sdw_delete_slave(slave);
+
 	sdw_master_device_del(bus);
 
 	sdw_bus_debugfs_exit(bus);
diff --git a/drivers/soundwire/slave.c b/drivers/soundwire/slave.c
index c1c1a2ac293a..b6161d002b97 100644
--- a/drivers/soundwire/slave.c
+++ b/drivers/soundwire/slave.c
@@ -10,10 +10,23 @@
 
 static void sdw_slave_release(struct device *dev)
 {
-	struct sdw_slave *slave = dev_to_sdw_dev(dev);
-
-	mutex_destroy(&slave->sdw_dev_lock);
-	kfree(slave);
+	/*
+	 * The release() callback should not be empty
+	 * (see Documentation/core-api/kobject.rst) but the ownership
+	 * of struct sdw_slave is muddled. It is used for two separate
+	 * purposes:
+	 * 1) by the bus driver to track its own state information for
+	 *    physical devices on the bus and found in ACPI/DT, whether
+	 *    or not there is a child driver for it;
+	 * 2) to hold the child driver object.
+	 *
+	 * The struct sdw_slave cannot be freed when the child driver
+	 * is released because it is holding info used by the bus
+	 * driver. It is freed when the bus driver is removed.
+	 *
+	 * Until the ownership issue is untangled this cannot free
+	 * the struct sdw_slave object containing the child dev.
+	 */
 }
 
 struct device_type sdw_slave_type = {
-- 
2.30.2

