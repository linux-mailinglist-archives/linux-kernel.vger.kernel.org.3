Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 791EA481D77
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 16:03:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241219AbhL3PD2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Dec 2021 10:03:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240038AbhL3PDK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Dec 2021 10:03:10 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1A9EC061761
        for <linux-kernel@vger.kernel.org>; Thu, 30 Dec 2021 07:03:09 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1n2wxP-0000cO-0W; Thu, 30 Dec 2021 16:03:07 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1n2wxM-007VKk-E5; Thu, 30 Dec 2021 16:03:03 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1n2wxL-0007h1-F2; Thu, 30 Dec 2021 16:03:03 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Syed Nayyar Waris <syednwaris@gmail.com>,
        William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: [PATCH v4 05/23] counter: 104-quad-8: Convert to counter_priv() wrapper
Date:   Thu, 30 Dec 2021 16:02:42 +0100
Message-Id: <20211230150300.72196-6-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211230150300.72196-1-u.kleine-koenig@pengutronix.de>
References: <20211230150300.72196-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=11165; h=from:subject; bh=LHPajDrT7KgO3JB/EI/js3kS9n+Fol7dZ5UteMk8rmY=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBhzclfErUiML5+vqwXxRZ4j5GmqnZzR5t5PFzjBJWX xX+ttaSJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCYc3JXwAKCRDB/BR4rcrsCSKOCA CdSYCv6oCwN9xfd+dzPYuhZLEsdS5Q05BTGGZhrhpa8t+vlAIukcS186pgvdu0i7sP+g6Xem0Wh4lP hV3UX8MEKVkE2VAff7SWXcKGyIQtX0bNb5OzO7oHNxa8BCb5jG0zpW2LSggfgcyIvxfsNNVUcGNpwF waXYzwHqqSrcXVenfUSb+CmFJWehdaj+cQdjEjO5aAiZ1vho0eLERMB20sCKWGiZzvAquWFFBC05Dy 6XCehqyJpUbyYwOAgeADssD2/GVg76htOu8+xVhIIkJL7tbXLqtaBbmavzn+Dqd4a8fp0eTnHbFn51 k2wHopUUzNPLsxRLSZOmMYipb1+MJ0
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
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/counter/104-quad-8.c | 56 ++++++++++++++++++------------------
 1 file changed, 28 insertions(+), 28 deletions(-)

diff --git a/drivers/counter/104-quad-8.c b/drivers/counter/104-quad-8.c
index a97027db0446..41b4d6f4583c 100644
--- a/drivers/counter/104-quad-8.c
+++ b/drivers/counter/104-quad-8.c
@@ -112,7 +112,7 @@ static int quad8_signal_read(struct counter_device *counter,
 			     struct counter_signal *signal,
 			     enum counter_signal_level *level)
 {
-	const struct quad8 *const priv = counter->priv;
+	const struct quad8 *const priv = counter_priv(counter);
 	unsigned int state;
 
 	/* Only Index signal levels can be read */
@@ -130,7 +130,7 @@ static int quad8_signal_read(struct counter_device *counter,
 static int quad8_count_read(struct counter_device *counter,
 			    struct counter_count *count, u64 *val)
 {
-	struct quad8 *const priv = counter->priv;
+	struct quad8 *const priv = counter_priv(counter);
 	const int base_offset = priv->base + 2 * count->id;
 	unsigned int flags;
 	unsigned int borrow;
@@ -162,7 +162,7 @@ static int quad8_count_read(struct counter_device *counter,
 static int quad8_count_write(struct counter_device *counter,
 			     struct counter_count *count, u64 val)
 {
-	struct quad8 *const priv = counter->priv;
+	struct quad8 *const priv = counter_priv(counter);
 	const int base_offset = priv->base + 2 * count->id;
 	unsigned long irqflags;
 	int i;
@@ -212,7 +212,7 @@ static int quad8_function_read(struct counter_device *counter,
 			       struct counter_count *count,
 			       enum counter_function *function)
 {
-	struct quad8 *const priv = counter->priv;
+	struct quad8 *const priv = counter_priv(counter);
 	const int id = count->id;
 	unsigned long irqflags;
 
@@ -242,7 +242,7 @@ static int quad8_function_write(struct counter_device *counter,
 				struct counter_count *count,
 				enum counter_function function)
 {
-	struct quad8 *const priv = counter->priv;
+	struct quad8 *const priv = counter_priv(counter);
 	const int id = count->id;
 	unsigned int *const quadrature_mode = priv->quadrature_mode + id;
 	unsigned int *const scale = priv->quadrature_scale + id;
@@ -304,7 +304,7 @@ static int quad8_direction_read(struct counter_device *counter,
 				struct counter_count *count,
 				enum counter_count_direction *direction)
 {
-	const struct quad8 *const priv = counter->priv;
+	const struct quad8 *const priv = counter_priv(counter);
 	unsigned int ud_flag;
 	const unsigned int flag_addr = priv->base + 2 * count->id + 1;
 
@@ -334,7 +334,7 @@ static int quad8_action_read(struct counter_device *counter,
 			     struct counter_synapse *synapse,
 			     enum counter_synapse_action *action)
 {
-	struct quad8 *const priv = counter->priv;
+	struct quad8 *const priv = counter_priv(counter);
 	int err;
 	enum counter_function function;
 	const size_t signal_a_id = count->synapses[0].signal->id;
@@ -397,7 +397,7 @@ enum {
 
 static int quad8_events_configure(struct counter_device *counter)
 {
-	struct quad8 *const priv = counter->priv;
+	struct quad8 *const priv = counter_priv(counter);
 	unsigned long irq_enabled = 0;
 	unsigned long irqflags;
 	struct counter_event_node *event_node;
@@ -495,7 +495,7 @@ static int quad8_index_polarity_get(struct counter_device *counter,
 				    struct counter_signal *signal,
 				    u32 *index_polarity)
 {
-	const struct quad8 *const priv = counter->priv;
+	const struct quad8 *const priv = counter_priv(counter);
 	const size_t channel_id = signal->id - 16;
 
 	*index_polarity = priv->index_polarity[channel_id];
@@ -507,7 +507,7 @@ static int quad8_index_polarity_set(struct counter_device *counter,
 				    struct counter_signal *signal,
 				    u32 index_polarity)
 {
-	struct quad8 *const priv = counter->priv;
+	struct quad8 *const priv = counter_priv(counter);
 	const size_t channel_id = signal->id - 16;
 	const int base_offset = priv->base + 2 * channel_id + 1;
 	unsigned long irqflags;
@@ -536,7 +536,7 @@ static int quad8_synchronous_mode_get(struct counter_device *counter,
 				      struct counter_signal *signal,
 				      u32 *synchronous_mode)
 {
-	const struct quad8 *const priv = counter->priv;
+	const struct quad8 *const priv = counter_priv(counter);
 	const size_t channel_id = signal->id - 16;
 
 	*synchronous_mode = priv->synchronous_mode[channel_id];
@@ -548,7 +548,7 @@ static int quad8_synchronous_mode_set(struct counter_device *counter,
 				      struct counter_signal *signal,
 				      u32 synchronous_mode)
 {
-	struct quad8 *const priv = counter->priv;
+	struct quad8 *const priv = counter_priv(counter);
 	const size_t channel_id = signal->id - 16;
 	const int base_offset = priv->base + 2 * channel_id + 1;
 	unsigned long irqflags;
@@ -587,7 +587,7 @@ static int quad8_count_mode_read(struct counter_device *counter,
 				 struct counter_count *count,
 				 enum counter_count_mode *cnt_mode)
 {
-	const struct quad8 *const priv = counter->priv;
+	const struct quad8 *const priv = counter_priv(counter);
 
 	/* Map 104-QUAD-8 count mode to Generic Counter count mode */
 	switch (priv->count_mode[count->id]) {
@@ -612,7 +612,7 @@ static int quad8_count_mode_write(struct counter_device *counter,
 				  struct counter_count *count,
 				  enum counter_count_mode cnt_mode)
 {
-	struct quad8 *const priv = counter->priv;
+	struct quad8 *const priv = counter_priv(counter);
 	unsigned int count_mode;
 	unsigned int mode_cfg;
 	const int base_offset = priv->base + 2 * count->id + 1;
@@ -659,7 +659,7 @@ static int quad8_count_mode_write(struct counter_device *counter,
 static int quad8_count_enable_read(struct counter_device *counter,
 				   struct counter_count *count, u8 *enable)
 {
-	const struct quad8 *const priv = counter->priv;
+	const struct quad8 *const priv = counter_priv(counter);
 
 	*enable = priv->ab_enable[count->id];
 
@@ -669,7 +669,7 @@ static int quad8_count_enable_read(struct counter_device *counter,
 static int quad8_count_enable_write(struct counter_device *counter,
 				    struct counter_count *count, u8 enable)
 {
-	struct quad8 *const priv = counter->priv;
+	struct quad8 *const priv = counter_priv(counter);
 	const int base_offset = priv->base + 2 * count->id;
 	unsigned long irqflags;
 	unsigned int ior_cfg;
@@ -697,7 +697,7 @@ static const char *const quad8_noise_error_states[] = {
 static int quad8_error_noise_get(struct counter_device *counter,
 				 struct counter_count *count, u32 *noise_error)
 {
-	const struct quad8 *const priv = counter->priv;
+	const struct quad8 *const priv = counter_priv(counter);
 	const int base_offset = priv->base + 2 * count->id + 1;
 
 	*noise_error = !!(inb(base_offset) & QUAD8_FLAG_E);
@@ -708,7 +708,7 @@ static int quad8_error_noise_get(struct counter_device *counter,
 static int quad8_count_preset_read(struct counter_device *counter,
 				   struct counter_count *count, u64 *preset)
 {
-	const struct quad8 *const priv = counter->priv;
+	const struct quad8 *const priv = counter_priv(counter);
 
 	*preset = priv->preset[count->id];
 
@@ -734,7 +734,7 @@ static void quad8_preset_register_set(struct quad8 *const priv, const int id,
 static int quad8_count_preset_write(struct counter_device *counter,
 				    struct counter_count *count, u64 preset)
 {
-	struct quad8 *const priv = counter->priv;
+	struct quad8 *const priv = counter_priv(counter);
 	unsigned long irqflags;
 
 	/* Only 24-bit values are supported */
@@ -753,7 +753,7 @@ static int quad8_count_preset_write(struct counter_device *counter,
 static int quad8_count_ceiling_read(struct counter_device *counter,
 				    struct counter_count *count, u64 *ceiling)
 {
-	struct quad8 *const priv = counter->priv;
+	struct quad8 *const priv = counter_priv(counter);
 	unsigned long irqflags;
 
 	spin_lock_irqsave(&priv->lock, irqflags);
@@ -778,7 +778,7 @@ static int quad8_count_ceiling_read(struct counter_device *counter,
 static int quad8_count_ceiling_write(struct counter_device *counter,
 				     struct counter_count *count, u64 ceiling)
 {
-	struct quad8 *const priv = counter->priv;
+	struct quad8 *const priv = counter_priv(counter);
 	unsigned long irqflags;
 
 	/* Only 24-bit values are supported */
@@ -805,7 +805,7 @@ static int quad8_count_preset_enable_read(struct counter_device *counter,
 					  struct counter_count *count,
 					  u8 *preset_enable)
 {
-	const struct quad8 *const priv = counter->priv;
+	const struct quad8 *const priv = counter_priv(counter);
 
 	*preset_enable = !priv->preset_enable[count->id];
 
@@ -816,7 +816,7 @@ static int quad8_count_preset_enable_write(struct counter_device *counter,
 					   struct counter_count *count,
 					   u8 preset_enable)
 {
-	struct quad8 *const priv = counter->priv;
+	struct quad8 *const priv = counter_priv(counter);
 	const int base_offset = priv->base + 2 * count->id + 1;
 	unsigned long irqflags;
 	unsigned int ior_cfg;
@@ -843,7 +843,7 @@ static int quad8_signal_cable_fault_read(struct counter_device *counter,
 					 struct counter_signal *signal,
 					 u8 *cable_fault)
 {
-	struct quad8 *const priv = counter->priv;
+	struct quad8 *const priv = counter_priv(counter);
 	const size_t channel_id = signal->id / 2;
 	unsigned long irqflags;
 	bool disabled;
@@ -873,7 +873,7 @@ static int quad8_signal_cable_fault_enable_read(struct counter_device *counter,
 						struct counter_signal *signal,
 						u8 *enable)
 {
-	const struct quad8 *const priv = counter->priv;
+	const struct quad8 *const priv = counter_priv(counter);
 	const size_t channel_id = signal->id / 2;
 
 	*enable = !!(priv->cable_fault_enable & BIT(channel_id));
@@ -885,7 +885,7 @@ static int quad8_signal_cable_fault_enable_write(struct counter_device *counter,
 						 struct counter_signal *signal,
 						 u8 enable)
 {
-	struct quad8 *const priv = counter->priv;
+	struct quad8 *const priv = counter_priv(counter);
 	const size_t channel_id = signal->id / 2;
 	unsigned long irqflags;
 	unsigned int cable_fault_enable;
@@ -911,7 +911,7 @@ static int quad8_signal_fck_prescaler_read(struct counter_device *counter,
 					   struct counter_signal *signal,
 					   u8 *prescaler)
 {
-	const struct quad8 *const priv = counter->priv;
+	const struct quad8 *const priv = counter_priv(counter);
 
 	*prescaler = priv->fck_prescaler[signal->id / 2];
 
@@ -922,7 +922,7 @@ static int quad8_signal_fck_prescaler_write(struct counter_device *counter,
 					    struct counter_signal *signal,
 					    u8 prescaler)
 {
-	struct quad8 *const priv = counter->priv;
+	struct quad8 *const priv = counter_priv(counter);
 	const size_t channel_id = signal->id / 2;
 	const int base_offset = priv->base + 2 * channel_id;
 	unsigned long irqflags;
-- 
2.34.1

