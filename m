Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A98D84A9513
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 09:26:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354879AbiBDI0Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 03:26:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346406AbiBDI0P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 03:26:15 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2492C06173D
        for <linux-kernel@vger.kernel.org>; Fri,  4 Feb 2022 00:26:14 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1nFtv2-0002VU-QD; Fri, 04 Feb 2022 09:26:12 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1nFtv1-00ERdr-Rc; Fri, 04 Feb 2022 09:26:11 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1nFtv0-006WuM-2I; Fri, 04 Feb 2022 09:26:10 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     William Breathitt Gray <vilhelm.gray@gmail.com>
Cc:     linux-iio@vger.kernel.org,
        Robin van der Gracht <robin@protonic.nl>,
        linux-kernel@vger.kernel.org,
        Oleksij Rempel <o.rempel@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        David Jander <david@protonic.nl>,
        Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH] counter: Stop using dev_get_drvdata() to get the counter device
Date:   Fri,  4 Feb 2022 09:25:56 +0100
Message-Id: <20220204082556.370348-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <YfzPcyusGwAOkys6@shinobu>
References: <YfzPcyusGwAOkys6@shinobu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=3546; h=from:subject; bh=4f+E5ZeOEMBTZf7GXLGZNa7l3bll59EU1yKNGxjRWTI=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBh/OMO8ITc0QJeW1oC4iIbd+gd0f1AK9QKA7S5rqNZ Jg4lmaqJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCYfzjDgAKCRDB/BR4rcrsCTFrCA COj+lZ6P26rIwhR41ND6rPp7DUoFAzHTXdnpMUhriZKF95/BF11qR4bAmEI889CrqwwzJZQ5QaCrGb Z+3dcOfSDyLunnPXFV3Ps2euznDA7IokVUDdIbgnvsZ9Y72Xj0EXVqoMRXOVMEZNb+Jo/jdzwGlE/u javAx4c9G0BSGF4vxTfbAAhNwaBUbJX180Kp5wTj+JuTEXZs0SircTCciG+9zYO7LaznLZWXZzNyt/ APnUOt97+qx9rWoS6j/JhzYTSYlF84a8oAFaM/4jWCTE7o1w+R/6xCnv9fGSfSoN377l4DShq+E8xh FphTIlEXTR/wpqqy2BrgVhhyI8GRWZ
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

dev_get_drvdata() returns NULL since commit b56346ddbd82 ("counter: Use
container_of instead of drvdata to track counter_device") which wrongly
claimed there were no users of drvdata. Convert to container_of() to
fix a null pointer dereference.

Reported-by: Oleksij Rempel <o.rempel@pengutronix.de>
Fixes: b56346ddbd82 ("counter: Use container_of instead of drvdata to track counter_device")
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/counter/counter-sysfs.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/counter/counter-sysfs.c b/drivers/counter/counter-sysfs.c
index 7cc4d1d523ea..04eac41dad33 100644
--- a/drivers/counter/counter-sysfs.c
+++ b/drivers/counter/counter-sysfs.c
@@ -19,6 +19,11 @@
 
 #include "counter-sysfs.h"
 
+static inline struct counter_device *counter_from_dev(struct device *dev)
+{
+	return container_of(dev, struct counter_device, dev);
+}
+
 /**
  * struct counter_attribute - Counter sysfs attribute
  * @dev_attr:	device attribute for sysfs
@@ -90,7 +95,7 @@ static ssize_t counter_comp_u8_show(struct device *dev,
 				    struct device_attribute *attr, char *buf)
 {
 	const struct counter_attribute *const a = to_counter_attribute(attr);
-	struct counter_device *const counter = dev_get_drvdata(dev);
+	struct counter_device *const counter = counter_from_dev(dev);
 	int err;
 	u8 data = 0;
 
@@ -122,7 +127,7 @@ static ssize_t counter_comp_u8_store(struct device *dev,
 				     const char *buf, size_t len)
 {
 	const struct counter_attribute *const a = to_counter_attribute(attr);
-	struct counter_device *const counter = dev_get_drvdata(dev);
+	struct counter_device *const counter = counter_from_dev(dev);
 	int err;
 	bool bool_data = 0;
 	u8 data = 0;
@@ -158,7 +163,7 @@ static ssize_t counter_comp_u32_show(struct device *dev,
 				     struct device_attribute *attr, char *buf)
 {
 	const struct counter_attribute *const a = to_counter_attribute(attr);
-	struct counter_device *const counter = dev_get_drvdata(dev);
+	struct counter_device *const counter = counter_from_dev(dev);
 	const struct counter_available *const avail = a->comp.priv;
 	int err;
 	u32 data = 0;
@@ -221,7 +226,7 @@ static ssize_t counter_comp_u32_store(struct device *dev,
 				      const char *buf, size_t len)
 {
 	const struct counter_attribute *const a = to_counter_attribute(attr);
-	struct counter_device *const counter = dev_get_drvdata(dev);
+	struct counter_device *const counter = counter_from_dev(dev);
 	struct counter_count *const count = a->parent;
 	struct counter_synapse *const synapse = a->comp.priv;
 	const struct counter_available *const avail = a->comp.priv;
@@ -281,7 +286,7 @@ static ssize_t counter_comp_u64_show(struct device *dev,
 				     struct device_attribute *attr, char *buf)
 {
 	const struct counter_attribute *const a = to_counter_attribute(attr);
-	struct counter_device *const counter = dev_get_drvdata(dev);
+	struct counter_device *const counter = counter_from_dev(dev);
 	int err;
 	u64 data = 0;
 
@@ -309,7 +314,7 @@ static ssize_t counter_comp_u64_store(struct device *dev,
 				      const char *buf, size_t len)
 {
 	const struct counter_attribute *const a = to_counter_attribute(attr);
-	struct counter_device *const counter = dev_get_drvdata(dev);
+	struct counter_device *const counter = counter_from_dev(dev);
 	int err;
 	u64 data = 0;
 

base-commit: e783362eb54cd99b2cac8b3a9aeac942e6f6ac07
-- 
2.34.1

