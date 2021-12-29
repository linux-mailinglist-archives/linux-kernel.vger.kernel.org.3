Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DE804814B2
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Dec 2021 16:45:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240695AbhL2Pp1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Dec 2021 10:45:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240631AbhL2Po6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Dec 2021 10:44:58 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36E46C061401
        for <linux-kernel@vger.kernel.org>; Wed, 29 Dec 2021 07:44:58 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1n2b8H-0006qN-8e; Wed, 29 Dec 2021 16:44:53 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1n2b8E-007KGp-9H; Wed, 29 Dec 2021 16:44:49 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1n2b8D-00012X-0F; Wed, 29 Dec 2021 16:44:49 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     William Breathitt Gray <vilhelm.gray@gmail.com>
Cc:     linux-iio@vger.kernel.org, kernel@pengutronix.de,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        Syed Nayyar Waris <syednwaris@gmail.com>
Subject: [PATCH v3 05/23] counter: 104-quad-8: Convert to counter_priv() wrapper
Date:   Wed, 29 Dec 2021 16:44:23 +0100
Message-Id: <20211229154441.38045-6-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211229154441.38045-1-u.kleine-koenig@pengutronix.de>
References: <20211229154441.38045-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=11509; h=from:subject; bh=m5kelU0DOWdEQwRdk8ZA3Vb77Tq8NFPRDRNC7MUJWPY=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBhzIIfk4uPcWzzd7B0Rai6Il3CSLNfmmKTphKZUS7R UKxFPA+JATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCYcyCHwAKCRDB/BR4rcrsCRP3B/ 4nT8Yp4uoXO5+aYo7xX/tSXkhKw0R0IAK06DFZT7CfrJA/w59OzcRjVD0p9A3aVZWZn/rVaaglxbhh G/GoC+6T2toanvUXCtf4eIiytT6B7TvJzqJKhQ6b7EDhwpFQTRsXajXDEVNnDqlIAerKsUnLsa4uIT z0jEXr5gOlBhvS6UDWYsEplWyzrujqbTeS7L6ZNwtL3Hg3TuUVvSV9cOJJTVVoPSchPE9svLEkCShc p3RL9a8cf8IgOyqQxN6zGHfBFCZS/nmafrC4yZibLsmo6m5g7gUMcv/dub4BMg02Sti5NWPXilK4M7 Y0NmO0JMtoASF8diFytLaKclhzYMCa
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
 drivers/counter/104-quad-8.c | 58 ++++++++++++++++++------------------
 1 file changed, 29 insertions(+), 29 deletions(-)

diff --git a/drivers/counter/104-quad-8.c b/drivers/counter/104-quad-8.c
index 1cbd60aaed69..6e5286cd1d4e 100644
--- a/drivers/counter/104-quad-8.c
+++ b/drivers/counter/104-quad-8.c
@@ -113,7 +113,7 @@ static int quad8_signal_read(struct counter_device *counter,
 			     struct counter_signal *signal,
 			     enum counter_signal_level *level)
 {
-	const struct quad8 *const priv = counter->priv;
+	const struct quad8 *const priv = counter_priv(counter);
 	unsigned int state;
 
 	/* Only Index signal levels can be read */
@@ -131,7 +131,7 @@ static int quad8_signal_read(struct counter_device *counter,
 static int quad8_count_read(struct counter_device *counter,
 			    struct counter_count *count, u64 *val)
 {
-	struct quad8 *const priv = counter->priv;
+	struct quad8 *const priv = counter_priv(counter);
 	const int base_offset = priv->base + 2 * count->id;
 	unsigned int flags;
 	unsigned int borrow;
@@ -163,7 +163,7 @@ static int quad8_count_read(struct counter_device *counter,
 static int quad8_count_write(struct counter_device *counter,
 			     struct counter_count *count, u64 val)
 {
-	struct quad8 *const priv = counter->priv;
+	struct quad8 *const priv = counter_priv(counter);
 	const int base_offset = priv->base + 2 * count->id;
 	unsigned long irqflags;
 	int i;
@@ -213,7 +213,7 @@ static int quad8_function_read(struct counter_device *counter,
 			       struct counter_count *count,
 			       enum counter_function *function)
 {
-	struct quad8 *const priv = counter->priv;
+	struct quad8 *const priv = counter_priv(counter);
 	const int id = count->id;
 	unsigned long irqflags;
 
@@ -243,7 +243,7 @@ static int quad8_function_write(struct counter_device *counter,
 				struct counter_count *count,
 				enum counter_function function)
 {
-	struct quad8 *const priv = counter->priv;
+	struct quad8 *const priv = counter_priv(counter);
 	const int id = count->id;
 	unsigned int *const quadrature_mode = priv->quadrature_mode + id;
 	unsigned int *const scale = priv->quadrature_scale + id;
@@ -305,7 +305,7 @@ static int quad8_direction_read(struct counter_device *counter,
 				struct counter_count *count,
 				enum counter_count_direction *direction)
 {
-	const struct quad8 *const priv = counter->priv;
+	const struct quad8 *const priv = counter_priv(counter);
 	unsigned int ud_flag;
 	const unsigned int flag_addr = priv->base + 2 * count->id + 1;
 
@@ -335,7 +335,7 @@ static int quad8_action_read(struct counter_device *counter,
 			     struct counter_synapse *synapse,
 			     enum counter_synapse_action *action)
 {
-	struct quad8 *const priv = counter->priv;
+	struct quad8 *const priv = counter_priv(counter);
 	int err;
 	enum counter_function function;
 	const size_t signal_a_id = count->synapses[0].signal->id;
@@ -399,7 +399,7 @@ enum {
 
 static int quad8_events_configure(struct counter_device *counter)
 {
-	struct quad8 *const priv = counter->priv;
+	struct quad8 *const priv = counter_priv(counter);
 	unsigned long irq_enabled = 0;
 	unsigned long irqflags;
 	size_t channel;
@@ -442,7 +442,7 @@ static int quad8_events_configure(struct counter_device *counter)
 static int quad8_watch_validate(struct counter_device *counter,
 				const struct counter_watch *watch)
 {
-	struct quad8 *const priv = counter->priv;
+	struct quad8 *const priv = counter_priv(counter);
 
 	if (watch->channel > QUAD8_NUM_COUNTERS - 1)
 		return -EINVAL;
@@ -497,7 +497,7 @@ static int quad8_index_polarity_get(struct counter_device *counter,
 				    struct counter_signal *signal,
 				    u32 *index_polarity)
 {
-	const struct quad8 *const priv = counter->priv;
+	const struct quad8 *const priv = counter_priv(counter);
 	const size_t channel_id = signal->id - 16;
 
 	*index_polarity = priv->index_polarity[channel_id];
@@ -509,7 +509,7 @@ static int quad8_index_polarity_set(struct counter_device *counter,
 				    struct counter_signal *signal,
 				    u32 index_polarity)
 {
-	struct quad8 *const priv = counter->priv;
+	struct quad8 *const priv = counter_priv(counter);
 	const size_t channel_id = signal->id - 16;
 	const int base_offset = priv->base + 2 * channel_id + 1;
 	unsigned long irqflags;
@@ -538,7 +538,7 @@ static int quad8_synchronous_mode_get(struct counter_device *counter,
 				      struct counter_signal *signal,
 				      u32 *synchronous_mode)
 {
-	const struct quad8 *const priv = counter->priv;
+	const struct quad8 *const priv = counter_priv(counter);
 	const size_t channel_id = signal->id - 16;
 
 	*synchronous_mode = priv->synchronous_mode[channel_id];
@@ -550,7 +550,7 @@ static int quad8_synchronous_mode_set(struct counter_device *counter,
 				      struct counter_signal *signal,
 				      u32 synchronous_mode)
 {
-	struct quad8 *const priv = counter->priv;
+	struct quad8 *const priv = counter_priv(counter);
 	const size_t channel_id = signal->id - 16;
 	const int base_offset = priv->base + 2 * channel_id + 1;
 	unsigned long irqflags;
@@ -589,7 +589,7 @@ static int quad8_count_mode_read(struct counter_device *counter,
 				 struct counter_count *count,
 				 enum counter_count_mode *cnt_mode)
 {
-	const struct quad8 *const priv = counter->priv;
+	const struct quad8 *const priv = counter_priv(counter);
 
 	/* Map 104-QUAD-8 count mode to Generic Counter count mode */
 	switch (priv->count_mode[count->id]) {
@@ -614,7 +614,7 @@ static int quad8_count_mode_write(struct counter_device *counter,
 				  struct counter_count *count,
 				  enum counter_count_mode cnt_mode)
 {
-	struct quad8 *const priv = counter->priv;
+	struct quad8 *const priv = counter_priv(counter);
 	unsigned int count_mode;
 	unsigned int mode_cfg;
 	const int base_offset = priv->base + 2 * count->id + 1;
@@ -661,7 +661,7 @@ static int quad8_count_mode_write(struct counter_device *counter,
 static int quad8_count_enable_read(struct counter_device *counter,
 				   struct counter_count *count, u8 *enable)
 {
-	const struct quad8 *const priv = counter->priv;
+	const struct quad8 *const priv = counter_priv(counter);
 
 	*enable = priv->ab_enable[count->id];
 
@@ -671,7 +671,7 @@ static int quad8_count_enable_read(struct counter_device *counter,
 static int quad8_count_enable_write(struct counter_device *counter,
 				    struct counter_count *count, u8 enable)
 {
-	struct quad8 *const priv = counter->priv;
+	struct quad8 *const priv = counter_priv(counter);
 	const int base_offset = priv->base + 2 * count->id;
 	unsigned long irqflags;
 	unsigned int ior_cfg;
@@ -699,7 +699,7 @@ static const char *const quad8_noise_error_states[] = {
 static int quad8_error_noise_get(struct counter_device *counter,
 				 struct counter_count *count, u32 *noise_error)
 {
-	const struct quad8 *const priv = counter->priv;
+	const struct quad8 *const priv = counter_priv(counter);
 	const int base_offset = priv->base + 2 * count->id + 1;
 
 	*noise_error = !!(inb(base_offset) & QUAD8_FLAG_E);
@@ -710,7 +710,7 @@ static int quad8_error_noise_get(struct counter_device *counter,
 static int quad8_count_preset_read(struct counter_device *counter,
 				   struct counter_count *count, u64 *preset)
 {
-	const struct quad8 *const priv = counter->priv;
+	const struct quad8 *const priv = counter_priv(counter);
 
 	*preset = priv->preset[count->id];
 
@@ -736,7 +736,7 @@ static void quad8_preset_register_set(struct quad8 *const priv, const int id,
 static int quad8_count_preset_write(struct counter_device *counter,
 				    struct counter_count *count, u64 preset)
 {
-	struct quad8 *const priv = counter->priv;
+	struct quad8 *const priv = counter_priv(counter);
 	unsigned long irqflags;
 
 	/* Only 24-bit values are supported */
@@ -755,7 +755,7 @@ static int quad8_count_preset_write(struct counter_device *counter,
 static int quad8_count_ceiling_read(struct counter_device *counter,
 				    struct counter_count *count, u64 *ceiling)
 {
-	struct quad8 *const priv = counter->priv;
+	struct quad8 *const priv = counter_priv(counter);
 	unsigned long irqflags;
 
 	spin_lock_irqsave(&priv->lock, irqflags);
@@ -780,7 +780,7 @@ static int quad8_count_ceiling_read(struct counter_device *counter,
 static int quad8_count_ceiling_write(struct counter_device *counter,
 				     struct counter_count *count, u64 ceiling)
 {
-	struct quad8 *const priv = counter->priv;
+	struct quad8 *const priv = counter_priv(counter);
 	unsigned long irqflags;
 
 	/* Only 24-bit values are supported */
@@ -807,7 +807,7 @@ static int quad8_count_preset_enable_read(struct counter_device *counter,
 					  struct counter_count *count,
 					  u8 *preset_enable)
 {
-	const struct quad8 *const priv = counter->priv;
+	const struct quad8 *const priv = counter_priv(counter);
 
 	*preset_enable = !priv->preset_enable[count->id];
 
@@ -818,7 +818,7 @@ static int quad8_count_preset_enable_write(struct counter_device *counter,
 					   struct counter_count *count,
 					   u8 preset_enable)
 {
-	struct quad8 *const priv = counter->priv;
+	struct quad8 *const priv = counter_priv(counter);
 	const int base_offset = priv->base + 2 * count->id + 1;
 	unsigned long irqflags;
 	unsigned int ior_cfg;
@@ -845,7 +845,7 @@ static int quad8_signal_cable_fault_read(struct counter_device *counter,
 					 struct counter_signal *signal,
 					 u8 *cable_fault)
 {
-	struct quad8 *const priv = counter->priv;
+	struct quad8 *const priv = counter_priv(counter);
 	const size_t channel_id = signal->id / 2;
 	unsigned long irqflags;
 	bool disabled;
@@ -875,7 +875,7 @@ static int quad8_signal_cable_fault_enable_read(struct counter_device *counter,
 						struct counter_signal *signal,
 						u8 *enable)
 {
-	const struct quad8 *const priv = counter->priv;
+	const struct quad8 *const priv = counter_priv(counter);
 	const size_t channel_id = signal->id / 2;
 
 	*enable = !!(priv->cable_fault_enable & BIT(channel_id));
@@ -887,7 +887,7 @@ static int quad8_signal_cable_fault_enable_write(struct counter_device *counter,
 						 struct counter_signal *signal,
 						 u8 enable)
 {
-	struct quad8 *const priv = counter->priv;
+	struct quad8 *const priv = counter_priv(counter);
 	const size_t channel_id = signal->id / 2;
 	unsigned long irqflags;
 	unsigned int cable_fault_enable;
@@ -913,7 +913,7 @@ static int quad8_signal_fck_prescaler_read(struct counter_device *counter,
 					   struct counter_signal *signal,
 					   u8 *prescaler)
 {
-	const struct quad8 *const priv = counter->priv;
+	const struct quad8 *const priv = counter_priv(counter);
 
 	*prescaler = priv->fck_prescaler[signal->id / 2];
 
@@ -924,7 +924,7 @@ static int quad8_signal_fck_prescaler_write(struct counter_device *counter,
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

