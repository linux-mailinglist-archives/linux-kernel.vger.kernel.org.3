Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D8D5557A9D
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 14:48:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231460AbiFWMsF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 08:48:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230361AbiFWMsC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 08:48:02 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B07C9193F1
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 05:48:00 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A454D1474;
        Thu, 23 Jun 2022 05:48:00 -0700 (PDT)
Received: from e120937-lin.home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9184B3F534;
        Thu, 23 Jun 2022 05:47:59 -0700 (PDT)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, vincent.guittot@linaro.org,
        f.fainelli@gmail.com, Cristian Marussi <cristian.marussi@arm.com>
Subject: [PATCH 2/5] firmware: arm_scmi: Support only one single SystemPower device
Date:   Thu, 23 Jun 2022 13:47:39 +0100
Message-Id: <20220623124742.2492164-3-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220623124742.2492164-1-cristian.marussi@arm.com>
References: <20220623124742.2492164-1-cristian.marussi@arm.com>
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
 drivers/firmware/arm_scmi/bus.c | 31 ++++++++++++++++++++++++++++++-
 1 file changed, 30 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/arm_scmi/bus.c b/drivers/firmware/arm_scmi/bus.c
index a7cbf4d09081..476855d3dccb 100644
--- a/drivers/firmware/arm_scmi/bus.c
+++ b/drivers/firmware/arm_scmi/bus.c
@@ -19,6 +19,11 @@ static DEFINE_IDA(scmi_bus_id);
 static DEFINE_IDR(scmi_protocols);
 static DEFINE_SPINLOCK(protocol_lock);
 
+/* Track globally the creation of SCMI SystemPower related devices */
+static bool scmi_syspower_registered;
+/* Protect access to scmi_syspower_registered */
+static DEFINE_MUTEX(scmi_syspower_mtx);
+
 static const struct scmi_device_id *
 scmi_dev_match_id(struct scmi_device *scmi_dev, struct scmi_driver *scmi_drv)
 {
@@ -207,11 +212,31 @@ scmi_device_create(struct device_node *np, struct device *parent, int protocol,
 	scmi_dev->dev.release = scmi_device_release;
 	dev_set_name(&scmi_dev->dev, "scmi_dev.%d", id);
 
+	mutex_lock(&scmi_syspower_mtx);
+	if (protocol == SCMI_PROTOCOL_SYSTEM && scmi_syspower_registered) {
+		dev_warn(parent,
+			 "SCMI SystemPower protocol device must be unique !\n");
+
+		mutex_unlock(&scmi_syspower_mtx);
+		ida_free(&scmi_bus_id, id);
+		kfree_const(scmi_dev->name);
+		kfree(scmi_dev);
+		return NULL;
+	}
+
 	retval = device_register(&scmi_dev->dev);
-	if (retval)
+	if (retval) {
+		mutex_unlock(&scmi_syspower_mtx);
 		goto put_dev;
+	}
+
+	if (protocol == SCMI_PROTOCOL_SYSTEM)
+		scmi_syspower_registered = true;
+
+	mutex_unlock(&scmi_syspower_mtx);
 
 	return scmi_dev;
+
 put_dev:
 	kfree_const(scmi_dev->name);
 	put_device(&scmi_dev->dev);
@@ -221,6 +246,10 @@ scmi_device_create(struct device_node *np, struct device *parent, int protocol,
 
 void scmi_device_destroy(struct scmi_device *scmi_dev)
 {
+	mutex_lock(&scmi_syspower_mtx);
+	if (scmi_dev->protocol_id == SCMI_PROTOCOL_SYSTEM)
+		scmi_syspower_registered = false;
+	mutex_unlock(&scmi_syspower_mtx);
 	kfree_const(scmi_dev->name);
 	scmi_handle_put(scmi_dev->handle);
 	ida_free(&scmi_bus_id, scmi_dev->id);
-- 
2.32.0

