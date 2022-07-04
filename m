Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18A52565213
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 12:23:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234362AbiGDKWM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 06:22:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234136AbiGDKVp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 06:21:45 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2ED53DFD1
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 03:19:50 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 46F50D6E;
        Mon,  4 Jul 2022 03:19:50 -0700 (PDT)
Received: from e120937-lin.home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 13D2C3F792;
        Mon,  4 Jul 2022 03:19:48 -0700 (PDT)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, f.fainelli@gmail.com,
        vincent.guittot@linaro.org,
        Cristian Marussi <cristian.marussi@arm.com>
Subject: [PATCH v2 1/4] firmware: arm_scmi: Support only one single SystemPower device
Date:   Mon,  4 Jul 2022 11:19:30 +0100
Message-Id: <20220704101933.2981635-2-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220704101933.2981635-1-cristian.marussi@arm.com>
References: <20220704101933.2981635-1-cristian.marussi@arm.com>
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

In order to minimize SCMI platform fw-side complexity, only one single SCMI
platform should be in charge of SCMI SystemPower protocol communications
with the OSPM: enforce the existence of one single unique device associated
with SystemPower protocol across any possible number of SCMI platforms, and
warn if a system tries to register different SystemPower devices from
multiple platforms.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
v1 --> v2
- move single device checks from bus to driver
---
 drivers/firmware/arm_scmi/bus.c    |  1 +
 drivers/firmware/arm_scmi/driver.c | 23 +++++++++++++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/drivers/firmware/arm_scmi/bus.c b/drivers/firmware/arm_scmi/bus.c
index f6fe723ab869..8960fb5277db 100644
--- a/drivers/firmware/arm_scmi/bus.c
+++ b/drivers/firmware/arm_scmi/bus.c
@@ -201,6 +201,7 @@ scmi_device_create(struct device_node *np, struct device *parent, int protocol,
 		goto put_dev;
 
 	return scmi_dev;
+
 put_dev:
 	kfree_const(scmi_dev->name);
 	put_device(&scmi_dev->dev);
diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
index 00b7f2aff4ec..48392a8a8dcd 100644
--- a/drivers/firmware/arm_scmi/driver.c
+++ b/drivers/firmware/arm_scmi/driver.c
@@ -61,6 +61,11 @@ static atomic_t transfer_last_id;
 static DEFINE_IDR(scmi_requested_devices);
 static DEFINE_MUTEX(scmi_requested_devices_mtx);
 
+/* Track globally the creation of SCMI SystemPower related devices */
+static bool scmi_syspower_registered;
+/* Protect access to scmi_syspower_registered */
+static DEFINE_MUTEX(scmi_syspower_mtx);
+
 struct scmi_requested_dev {
 	const struct scmi_device_id *id_table;
 	struct list_head node;
@@ -2014,21 +2019,39 @@ scmi_get_protocol_device(struct device_node *np, struct scmi_info *info,
 	if (sdev)
 		return sdev;
 
+	mutex_lock(&scmi_syspower_mtx);
+	if (prot_id == SCMI_PROTOCOL_SYSTEM && scmi_syspower_registered) {
+		dev_warn(info->dev,
+			 "SCMI SystemPower protocol device must be unique !\n");
+		mutex_unlock(&scmi_syspower_mtx);
+
+		return NULL;
+	}
+
 	pr_debug("Creating SCMI device (%s) for protocol %x\n", name, prot_id);
 
 	sdev = scmi_device_create(np, info->dev, prot_id, name);
 	if (!sdev) {
 		dev_err(info->dev, "failed to create %d protocol device\n",
 			prot_id);
+		mutex_unlock(&scmi_syspower_mtx);
+
 		return NULL;
 	}
 
 	if (scmi_txrx_setup(info, &sdev->dev, prot_id)) {
 		dev_err(&sdev->dev, "failed to setup transport\n");
 		scmi_device_destroy(sdev);
+		mutex_unlock(&scmi_syspower_mtx);
+
 		return NULL;
 	}
 
+	if (prot_id == SCMI_PROTOCOL_SYSTEM)
+		scmi_syspower_registered = true;
+
+	mutex_unlock(&scmi_syspower_mtx);
+
 	return sdev;
 }
 
-- 
2.32.0

