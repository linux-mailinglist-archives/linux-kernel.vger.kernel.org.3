Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E35D47BE59
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 11:46:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235782AbhLUKqQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 05:46:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234110AbhLUKqJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 05:46:09 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4A55C061574
        for <linux-kernel@vger.kernel.org>; Tue, 21 Dec 2021 02:46:08 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mzcei-0005BD-O6; Tue, 21 Dec 2021 11:46:04 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1mzcei-005nfy-5M; Tue, 21 Dec 2021 11:46:03 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mzceh-0004Bv-0I; Tue, 21 Dec 2021 11:46:03 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        William Breathitt Gray <vilhelm.gray@gmail.com>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/8] counter: intel-qeb: Use container_of instead of struct counter_device::priv
Date:   Tue, 21 Dec 2021 11:45:41 +0100
Message-Id: <20211221104546.214066-4-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211221104546.214066-1-u.kleine-koenig@pengutronix.de>
References: <20211221104546.214066-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Patch-Hashes: v=1; h=sha256; i=ThNGokgiWcn75qYGbTuomR6f88obJKYrRrSmNBoFD5I=; m=Hg8zE/asUx2g3czk+o5m3SY3gEaouSs/V53jAvhKGzw=; p=ZyUJpfCbrjrA8N6THSfxjmBhtCsfDdq6XEd4Xr1NFZY=; g=e137413badb1a0c1fd78f5213f3b717e8703a1de
X-Patch-Sig: m=pgp; i=u.kleine-koenig@pengutronix.de; s=0x0D2511F322BFAB1C1580266BE2DCDD9132669BD6; b=iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmHBsDUACgkQwfwUeK3K7AlL7wf/d79 RnEH3XmALXk6BQ5vAaTzhNTWG9S/+v5u9NKZvF9p+zGAg5OCE5es/tbqueYNC5IiV0mbUJRoU3POK 3Hi/PZGnQVT5OnJVg39at/9kzUEaK5VEwI/WV+oUn56wLKROysBrpOd9POQLN/H1+P9Y3qpZW9SU5 TSNdHHTUXiLnTLHnvPUiAaSwE9ABPFuDueHHb33qoV/PPL62D3rJiyrxQbiqHT0WLLVzfcOfvEca7 5NPmgmMKTkCQhgt1j2yLGWd2qIrFf++rVZNzsX3//MqRyNNAf9k0cYQm8OVS0MWQiokP+Pw9aNhjk wN6CIs/TJsP6c5l6xd9V3Yn84Euv55g==
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using counter->priv is a memory read and so more expensive than
container_of which is only an addition. (In this case even a noop
because the offset is 0.)

So container_of is expected to be a tad faster, it's type-safe, and
produces smaller code (ARCH=arm allmodconfig):

	add/remove: 0/0 grow/shrink: 0/10 up/down: 0/-116 (-116)
	Function                                     old     new   delta
	intel_qep_spike_filter_ns_write              552     544      -8
	intel_qep_spike_filter_ns_read               252     240     -12
	intel_qep_probe                              692     680     -12
	intel_qep_preset_enable_write                276     264     -12
	intel_qep_preset_enable_read                 164     152     -12
	intel_qep_enable_write                       500     488     -12
	intel_qep_enable_read                         80      68     -12
	intel_qep_count_read                         140     128     -12
	intel_qep_ceiling_write                      260     248     -12
	intel_qep_ceiling_read                       140     128     -12
	Total: Before=4867, After=4751, chg -2.38%

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/counter/intel-qep.c | 24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/drivers/counter/intel-qep.c b/drivers/counter/intel-qep.c
index 0924d16de6e2..168f8f5357cf 100644
--- a/drivers/counter/intel-qep.c
+++ b/drivers/counter/intel-qep.c
@@ -74,6 +74,11 @@ struct intel_qep {
 	u32 qepmax;
 };
 
+static inline struct intel_qep *intel_qep_from_counter(struct counter_device *counter)
+{
+	return container_of(counter, struct intel_qep, counter);
+}
+
 static inline u32 intel_qep_readl(struct intel_qep *qep, u32 offset)
 {
 	return readl(qep->regs + offset);
@@ -109,7 +114,7 @@ static void intel_qep_init(struct intel_qep *qep)
 static int intel_qep_count_read(struct counter_device *counter,
 				struct counter_count *count, u64 *val)
 {
-	struct intel_qep *const qep = counter->priv;
+	struct intel_qep *const qep = intel_qep_from_counter(counter);
 
 	pm_runtime_get_sync(qep->dev);
 	*val = intel_qep_readl(qep, INTEL_QEPCOUNT);
@@ -176,7 +181,7 @@ static struct counter_synapse intel_qep_count_synapses[] = {
 static int intel_qep_ceiling_read(struct counter_device *counter,
 				  struct counter_count *count, u64 *ceiling)
 {
-	struct intel_qep *qep = counter->priv;
+	struct intel_qep *qep = intel_qep_from_counter(counter);
 
 	pm_runtime_get_sync(qep->dev);
 	*ceiling = intel_qep_readl(qep, INTEL_QEPMAX);
@@ -188,7 +193,7 @@ static int intel_qep_ceiling_read(struct counter_device *counter,
 static int intel_qep_ceiling_write(struct counter_device *counter,
 				   struct counter_count *count, u64 max)
 {
-	struct intel_qep *qep = counter->priv;
+	struct intel_qep *qep = intel_qep_from_counter(counter);
 	int ret = 0;
 
 	/* Intel QEP ceiling configuration only supports 32-bit values */
@@ -213,7 +218,7 @@ static int intel_qep_ceiling_write(struct counter_device *counter,
 static int intel_qep_enable_read(struct counter_device *counter,
 				 struct counter_count *count, u8 *enable)
 {
-	struct intel_qep *qep = counter->priv;
+	struct intel_qep *qep = intel_qep_from_counter(counter);
 
 	*enable = qep->enabled;
 
@@ -223,7 +228,7 @@ static int intel_qep_enable_read(struct counter_device *counter,
 static int intel_qep_enable_write(struct counter_device *counter,
 				  struct counter_count *count, u8 val)
 {
-	struct intel_qep *qep = counter->priv;
+	struct intel_qep *qep = intel_qep_from_counter(counter);
 	u32 reg;
 	bool changed;
 
@@ -256,7 +261,7 @@ static int intel_qep_spike_filter_ns_read(struct counter_device *counter,
 					  struct counter_count *count,
 					  u64 *length)
 {
-	struct intel_qep *qep = counter->priv;
+	struct intel_qep *qep = intel_qep_from_counter(counter);
 	u32 reg;
 
 	pm_runtime_get_sync(qep->dev);
@@ -277,7 +282,7 @@ static int intel_qep_spike_filter_ns_write(struct counter_device *counter,
 					   struct counter_count *count,
 					   u64 length)
 {
-	struct intel_qep *qep = counter->priv;
+	struct intel_qep *qep = intel_qep_from_counter(counter);
 	u32 reg;
 	bool enable;
 	int ret = 0;
@@ -326,7 +331,7 @@ static int intel_qep_preset_enable_read(struct counter_device *counter,
 					struct counter_count *count,
 					u8 *preset_enable)
 {
-	struct intel_qep *qep = counter->priv;
+	struct intel_qep *qep = intel_qep_from_counter(counter);
 	u32 reg;
 
 	pm_runtime_get_sync(qep->dev);
@@ -341,7 +346,7 @@ static int intel_qep_preset_enable_read(struct counter_device *counter,
 static int intel_qep_preset_enable_write(struct counter_device *counter,
 					 struct counter_count *count, u8 val)
 {
-	struct intel_qep *qep = counter->priv;
+	struct intel_qep *qep = intel_qep_from_counter(counter);
 	u32 reg;
 	int ret = 0;
 
@@ -429,7 +434,6 @@ static int intel_qep_probe(struct pci_dev *pci, const struct pci_device_id *id)
 	qep->counter.num_counts = ARRAY_SIZE(intel_qep_counter_count);
 	qep->counter.signals = intel_qep_signals;
 	qep->counter.num_signals = ARRAY_SIZE(intel_qep_signals);
-	qep->counter.priv = qep;
 	qep->enabled = false;
 
 	pm_runtime_put(dev);
-- 
2.33.0

