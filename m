Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A690481D83
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 16:04:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241173AbhL3PDx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Dec 2021 10:03:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240853AbhL3PDO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Dec 2021 10:03:14 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA67DC061401
        for <linux-kernel@vger.kernel.org>; Thu, 30 Dec 2021 07:03:13 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1n2wxT-0000cR-NP; Thu, 30 Dec 2021 16:03:11 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1n2wxN-007VKp-4I; Thu, 30 Dec 2021 16:03:04 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1n2wxM-0007hP-07; Thu, 30 Dec 2021 16:03:04 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        Raymond Tan <raymond.tan@intel.com>,
        "Felipe Balbi (Intel)" <balbi@kernel.org>,
        William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: [PATCH v4 08/23] counter: intel-qep: Convert to counter_priv() wrapper
Date:   Thu, 30 Dec 2021 16:02:45 +0100
Message-Id: <20211230150300.72196-9-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211230150300.72196-1-u.kleine-koenig@pengutronix.de>
References: <20211230150300.72196-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=3666; h=from:subject; bh=f0kdB4gB0hEDXdNVJlCf5PD3lpsr7Zp1cZEpYnR6MwQ=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBhzcl5Oo/TqlQZgKuiYW9QyEd+CgW2bVmGhW/h9Fsv xc6+jOiJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCYc3JeQAKCRDB/BR4rcrsCUz8B/ wMv3O9/Jlnm6L8AFTJlarpTSpHM3fUXwNV/76Z1L18CUgZIomeVKjAqAt6NN9INTMA4qqSywinR8Dz N8fyVwNsU65eDCzgtymJGVgflcKQtJBVfJVaSmX96FcxBJUYHL/7mKcz6IIV3ViCQMkFT8wEGFN+zt 1u65BHKxPUHLmKm42qRHDXpMlslGnSgi2cqyEXkD3GlIKRIANOPl2G2JU2g+xRYcg/jjfi4jMWtwiS nKG3BmyTk9bj+sjIQncLR78o9fKEunJ5vbNIaxuCtNfFOTBeQ23PAOvhpSMIPFvwD1ChZALe0TgGZP 5U8Ii2mmoEqjdLQYwRhLBg7wkGpRHt
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a straight forward conversion to the new counter_priv() wrapper.

Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Acked-by: William Breathitt Gray <vilhelm.gray@gmail.com>
Acked-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/counter/intel-qep.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/counter/intel-qep.c b/drivers/counter/intel-qep.c
index 0924d16de6e2..8f84a48508ac 100644
--- a/drivers/counter/intel-qep.c
+++ b/drivers/counter/intel-qep.c
@@ -109,7 +109,7 @@ static void intel_qep_init(struct intel_qep *qep)
 static int intel_qep_count_read(struct counter_device *counter,
 				struct counter_count *count, u64 *val)
 {
-	struct intel_qep *const qep = counter->priv;
+	struct intel_qep *const qep = counter_priv(counter);
 
 	pm_runtime_get_sync(qep->dev);
 	*val = intel_qep_readl(qep, INTEL_QEPCOUNT);
@@ -176,7 +176,7 @@ static struct counter_synapse intel_qep_count_synapses[] = {
 static int intel_qep_ceiling_read(struct counter_device *counter,
 				  struct counter_count *count, u64 *ceiling)
 {
-	struct intel_qep *qep = counter->priv;
+	struct intel_qep *qep = counter_priv(counter);
 
 	pm_runtime_get_sync(qep->dev);
 	*ceiling = intel_qep_readl(qep, INTEL_QEPMAX);
@@ -188,7 +188,7 @@ static int intel_qep_ceiling_read(struct counter_device *counter,
 static int intel_qep_ceiling_write(struct counter_device *counter,
 				   struct counter_count *count, u64 max)
 {
-	struct intel_qep *qep = counter->priv;
+	struct intel_qep *qep = counter_priv(counter);
 	int ret = 0;
 
 	/* Intel QEP ceiling configuration only supports 32-bit values */
@@ -213,7 +213,7 @@ static int intel_qep_ceiling_write(struct counter_device *counter,
 static int intel_qep_enable_read(struct counter_device *counter,
 				 struct counter_count *count, u8 *enable)
 {
-	struct intel_qep *qep = counter->priv;
+	struct intel_qep *qep = counter_priv(counter);
 
 	*enable = qep->enabled;
 
@@ -223,7 +223,7 @@ static int intel_qep_enable_read(struct counter_device *counter,
 static int intel_qep_enable_write(struct counter_device *counter,
 				  struct counter_count *count, u8 val)
 {
-	struct intel_qep *qep = counter->priv;
+	struct intel_qep *qep = counter_priv(counter);
 	u32 reg;
 	bool changed;
 
@@ -256,7 +256,7 @@ static int intel_qep_spike_filter_ns_read(struct counter_device *counter,
 					  struct counter_count *count,
 					  u64 *length)
 {
-	struct intel_qep *qep = counter->priv;
+	struct intel_qep *qep = counter_priv(counter);
 	u32 reg;
 
 	pm_runtime_get_sync(qep->dev);
@@ -277,7 +277,7 @@ static int intel_qep_spike_filter_ns_write(struct counter_device *counter,
 					   struct counter_count *count,
 					   u64 length)
 {
-	struct intel_qep *qep = counter->priv;
+	struct intel_qep *qep = counter_priv(counter);
 	u32 reg;
 	bool enable;
 	int ret = 0;
@@ -326,7 +326,7 @@ static int intel_qep_preset_enable_read(struct counter_device *counter,
 					struct counter_count *count,
 					u8 *preset_enable)
 {
-	struct intel_qep *qep = counter->priv;
+	struct intel_qep *qep = counter_priv(counter);
 	u32 reg;
 
 	pm_runtime_get_sync(qep->dev);
@@ -341,7 +341,7 @@ static int intel_qep_preset_enable_read(struct counter_device *counter,
 static int intel_qep_preset_enable_write(struct counter_device *counter,
 					 struct counter_count *count, u8 val)
 {
-	struct intel_qep *qep = counter->priv;
+	struct intel_qep *qep = counter_priv(counter);
 	u32 reg;
 	int ret = 0;
 
-- 
2.34.1

