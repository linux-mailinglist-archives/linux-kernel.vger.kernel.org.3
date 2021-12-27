Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C916B47FB7D
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Dec 2021 10:46:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233206AbhL0Jpx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Dec 2021 04:45:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233208AbhL0Jps (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Dec 2021 04:45:48 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A793C061799
        for <linux-kernel@vger.kernel.org>; Mon, 27 Dec 2021 01:45:44 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1n1mZV-0006YV-1F; Mon, 27 Dec 2021 10:45:37 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1n1mZT-006u91-Hs; Mon, 27 Dec 2021 10:45:34 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1n1mZS-0005Uh-3w; Mon, 27 Dec 2021 10:45:34 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     William Breathitt Gray <vilhelm.gray@gmail.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>, kernel@pengutronix.de,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-iio@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        "Felipe Balbi (Intel)" <balbi@kernel.org>,
        Raymond Tan <raymond.tan@intel.com>
Subject: [PATCH v2 08/23] counter: intel-qep: Convert to counter_priv() wrapper
Date:   Mon, 27 Dec 2021 10:45:11 +0100
Message-Id: <20211227094526.698714-9-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211227094526.698714-1-u.kleine-koenig@pengutronix.de>
References: <20211227094526.698714-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Patch-Hashes: v=1; h=sha256; i=g9BfXIkcjNw5YS2h7I7k7foNDE7mpF/qCH/1d9F0FUc=; m=O/hbHSowifJBTpUmrGb87d4c+26dGvtHSBxVMu37a1o=; p=Ax69rXrNAqJUpt+mx9VJqrku88dhLzmNBLAaw6ZG0OY=; g=990ae56b2628066bb62ad34907d77560123f896f
X-Patch-Sig: m=pgp; i=u.kleine-koenig@pengutronix.de; s=0x0D2511F322BFAB1C1580266BE2DCDD9132669BD6; b=iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmHJiokACgkQwfwUeK3K7AnEoAf/T5N 92vfZEE1HMTJqGRIyk0gNvdQkKutMiulbms1DLopqHbUODrdm8r4e9WeviYY4WDCzjvTLsycfgl7l 9PHfKe1DagNdR9WgRBcfETe9bgcdJ2iL6D8vwUVAM+8cVDP/hISbi7hnoidNA8Gvhs6Bgxcn2Enct VFa4pGIz/u7Flu/Rn80Z8nSo5c7w29rxDBwSAhY77qR/K8MNQXHG9LWKa68y8YvkVc2s9YjsFLQyN PQfHKC85jIqBei0hIVtEtqS0W2lrHJX9NT4nqEkQ2aFAyi0zxmzCxZSO8gwk2lZpKORbWxVVd45OY Lp++wf+MyaO8l41x4F8DCpPeg6I8GsQ==
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a straight forward conversion to the new counter_priv() wrapper.

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
2.33.0

