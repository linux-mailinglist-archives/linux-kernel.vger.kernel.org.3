Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F2B147BE54
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 11:46:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234235AbhLUKqK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 05:46:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234053AbhLUKqH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 05:46:07 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EB9BC061574
        for <linux-kernel@vger.kernel.org>; Tue, 21 Dec 2021 02:46:07 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mzcei-0005B5-O7; Tue, 21 Dec 2021 11:46:04 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1mzceh-005nfs-H5; Tue, 21 Dec 2021 11:46:02 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mzceg-0004BS-JV; Tue, 21 Dec 2021 11:46:02 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     William Breathitt Gray <vilhelm.gray@gmail.com>,
        Syed Nayyar Waris <syednwaris@gmail.com>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/8] counter: 104-quad-8: Use container_of instead of struct counter_device::priv
Date:   Tue, 21 Dec 2021 11:45:39 +0100
Message-Id: <20211221104546.214066-2-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211221104546.214066-1-u.kleine-koenig@pengutronix.de>
References: <20211221104546.214066-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Patch-Hashes: v=1; h=sha256; i=CnBH63zzo+tqIzwX0lexnwgBN96xH+nVjDGI1acY4RE=; m=WBq4e46WGgS0dLi5xghMITgc9qKFAxSgpTl9JAlgCl4=; p=LfndeIs0fXVbHBSKaxGOiyMpLhehIJekYg4LQfX76U4=; g=d7209755a97347fa53efe3344d0d29e29e1dbe0d
X-Patch-Sig: m=pgp; i=u.kleine-koenig@pengutronix.de; s=0x0D2511F322BFAB1C1580266BE2DCDD9132669BD6; b=iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmHBsC8ACgkQwfwUeK3K7AkaRAf+OSR 4Unldn3jMWyf4io2BQ6yR/IlA0Gxf740sFVQKVw0NHMDBqtuxK2o3mU+57SK9JlSjqyquIYMlvdMB NZRSMWHgs6JBNjOMcEx1274bZLbjsRlj5fNixFOuVNBpy5prhWTlvxunMVraSFUl0eWUxLiMVkvmr 1JAr98qzo1UJLi2Ux1c2S5OE6xuU2+lna+xFqWorqi2+qTYKWsS7defGZ56e0k49almcjhdBMLYZM iKlqxljkvHnlw1/wXjKsgQ5tVAyN6doKDbexr9Vlfwy+sVnCXrzd5f9+1XAXZrukucVD6oqCb+HxY iNvUbrhUBmhtrQIS52tOnlr6FWZqpYw==
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using counter->priv is a memory read and so more expensive than
container_of which is only an addition.

So container_of is expected to be a tad faster, it's type-safe, and
produces smaller code (ARCH=arm allmodconfig):

	add/remove: 0/0 grow/shrink: 5/17 up/down: 76/-172 (-96)
	Function                                     old     new   delta
	quad8_function_write                         612     648     +36
	quad8_count_mode_write                       296     312     +16
	quad8_count_enable_write                     232     248     +16
	quad8_events_configure                       384     388      +4
	quad8_count_preset_enable_write              264     268      +4
	quad8_signal_fck_prescaler_read              108     104      -4
	quad8_count_enable_read                      100      96      -4
	quad8_synchronous_mode_set                   304     296      -8
	quad8_signal_cable_fault_read                240     232      -8
	quad8_signal_cable_fault_enable_write        244     236      -8
	quad8_index_polarity_set                     200     192      -8
	quad8_function_read                          292     284      -8
	quad8_count_read                             304     296      -8
	quad8_count_preset_write                     160     152      -8
	quad8_count_ceiling_read                     216     208      -8
	quad8_signal_read                            212     200     -12
	quad8_signal_cable_fault_enable_read         108      96     -12
	quad8_probe                                 1116    1104     -12
	quad8_error_noise_get                        156     144     -12
	quad8_direction_read                         156     144     -12
	quad8_action_read                            836     824     -12
	quad8_watch_validate                         528     500     -28
	Total: Before=11802, After=11706, chg -0.81%

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/counter/104-quad-8.c | 64 +++++++++++++++++++-----------------
 1 file changed, 34 insertions(+), 30 deletions(-)

diff --git a/drivers/counter/104-quad-8.c b/drivers/counter/104-quad-8.c
index 1cbd60aaed69..a9e75c70ad30 100644
--- a/drivers/counter/104-quad-8.c
+++ b/drivers/counter/104-quad-8.c
@@ -109,11 +109,16 @@ struct quad8 {
 #define QUAD8_CMR_QUADRATURE_X2 0x10
 #define QUAD8_CMR_QUADRATURE_X4 0x18
 
+static struct quad8 *quad8_from_counter(struct counter_device *counter)
+{
+	return container_of(counter, struct quad8, counter);
+}
+
 static int quad8_signal_read(struct counter_device *counter,
 			     struct counter_signal *signal,
 			     enum counter_signal_level *level)
 {
-	const struct quad8 *const priv = counter->priv;
+	const struct quad8 *const priv = quad8_from_counter(counter);
 	unsigned int state;
 
 	/* Only Index signal levels can be read */
@@ -131,7 +136,7 @@ static int quad8_signal_read(struct counter_device *counter,
 static int quad8_count_read(struct counter_device *counter,
 			    struct counter_count *count, u64 *val)
 {
-	struct quad8 *const priv = counter->priv;
+	struct quad8 *const priv = quad8_from_counter(counter);
 	const int base_offset = priv->base + 2 * count->id;
 	unsigned int flags;
 	unsigned int borrow;
@@ -163,7 +168,7 @@ static int quad8_count_read(struct counter_device *counter,
 static int quad8_count_write(struct counter_device *counter,
 			     struct counter_count *count, u64 val)
 {
-	struct quad8 *const priv = counter->priv;
+	struct quad8 *const priv = quad8_from_counter(counter);
 	const int base_offset = priv->base + 2 * count->id;
 	unsigned long irqflags;
 	int i;
@@ -213,7 +218,7 @@ static int quad8_function_read(struct counter_device *counter,
 			       struct counter_count *count,
 			       enum counter_function *function)
 {
-	struct quad8 *const priv = counter->priv;
+	struct quad8 *const priv = quad8_from_counter(counter);
 	const int id = count->id;
 	unsigned long irqflags;
 
@@ -243,7 +248,7 @@ static int quad8_function_write(struct counter_device *counter,
 				struct counter_count *count,
 				enum counter_function function)
 {
-	struct quad8 *const priv = counter->priv;
+	struct quad8 *const priv = quad8_from_counter(counter);
 	const int id = count->id;
 	unsigned int *const quadrature_mode = priv->quadrature_mode + id;
 	unsigned int *const scale = priv->quadrature_scale + id;
@@ -305,7 +310,7 @@ static int quad8_direction_read(struct counter_device *counter,
 				struct counter_count *count,
 				enum counter_count_direction *direction)
 {
-	const struct quad8 *const priv = counter->priv;
+	const struct quad8 *const priv = quad8_from_counter(counter);
 	unsigned int ud_flag;
 	const unsigned int flag_addr = priv->base + 2 * count->id + 1;
 
@@ -335,7 +340,7 @@ static int quad8_action_read(struct counter_device *counter,
 			     struct counter_synapse *synapse,
 			     enum counter_synapse_action *action)
 {
-	struct quad8 *const priv = counter->priv;
+	struct quad8 *const priv = quad8_from_counter(counter);
 	int err;
 	enum counter_function function;
 	const size_t signal_a_id = count->synapses[0].signal->id;
@@ -399,7 +404,7 @@ enum {
 
 static int quad8_events_configure(struct counter_device *counter)
 {
-	struct quad8 *const priv = counter->priv;
+	struct quad8 *const priv = quad8_from_counter(counter);
 	unsigned long irq_enabled = 0;
 	unsigned long irqflags;
 	size_t channel;
@@ -442,7 +447,7 @@ static int quad8_events_configure(struct counter_device *counter)
 static int quad8_watch_validate(struct counter_device *counter,
 				const struct counter_watch *watch)
 {
-	struct quad8 *const priv = counter->priv;
+	struct quad8 *const priv = quad8_from_counter(counter);
 
 	if (watch->channel > QUAD8_NUM_COUNTERS - 1)
 		return -EINVAL;
@@ -497,7 +502,7 @@ static int quad8_index_polarity_get(struct counter_device *counter,
 				    struct counter_signal *signal,
 				    u32 *index_polarity)
 {
-	const struct quad8 *const priv = counter->priv;
+	const struct quad8 *const priv = quad8_from_counter(counter);
 	const size_t channel_id = signal->id - 16;
 
 	*index_polarity = priv->index_polarity[channel_id];
@@ -509,7 +514,7 @@ static int quad8_index_polarity_set(struct counter_device *counter,
 				    struct counter_signal *signal,
 				    u32 index_polarity)
 {
-	struct quad8 *const priv = counter->priv;
+	struct quad8 *const priv = quad8_from_counter(counter);
 	const size_t channel_id = signal->id - 16;
 	const int base_offset = priv->base + 2 * channel_id + 1;
 	unsigned long irqflags;
@@ -538,7 +543,7 @@ static int quad8_synchronous_mode_get(struct counter_device *counter,
 				      struct counter_signal *signal,
 				      u32 *synchronous_mode)
 {
-	const struct quad8 *const priv = counter->priv;
+	const struct quad8 *const priv = quad8_from_counter(counter);
 	const size_t channel_id = signal->id - 16;
 
 	*synchronous_mode = priv->synchronous_mode[channel_id];
@@ -550,7 +555,7 @@ static int quad8_synchronous_mode_set(struct counter_device *counter,
 				      struct counter_signal *signal,
 				      u32 synchronous_mode)
 {
-	struct quad8 *const priv = counter->priv;
+	struct quad8 *const priv = quad8_from_counter(counter);
 	const size_t channel_id = signal->id - 16;
 	const int base_offset = priv->base + 2 * channel_id + 1;
 	unsigned long irqflags;
@@ -589,7 +594,7 @@ static int quad8_count_mode_read(struct counter_device *counter,
 				 struct counter_count *count,
 				 enum counter_count_mode *cnt_mode)
 {
-	const struct quad8 *const priv = counter->priv;
+	const struct quad8 *const priv = quad8_from_counter(counter);
 
 	/* Map 104-QUAD-8 count mode to Generic Counter count mode */
 	switch (priv->count_mode[count->id]) {
@@ -614,7 +619,7 @@ static int quad8_count_mode_write(struct counter_device *counter,
 				  struct counter_count *count,
 				  enum counter_count_mode cnt_mode)
 {
-	struct quad8 *const priv = counter->priv;
+	struct quad8 *const priv = quad8_from_counter(counter);
 	unsigned int count_mode;
 	unsigned int mode_cfg;
 	const int base_offset = priv->base + 2 * count->id + 1;
@@ -661,7 +666,7 @@ static int quad8_count_mode_write(struct counter_device *counter,
 static int quad8_count_enable_read(struct counter_device *counter,
 				   struct counter_count *count, u8 *enable)
 {
-	const struct quad8 *const priv = counter->priv;
+	const struct quad8 *const priv = quad8_from_counter(counter);
 
 	*enable = priv->ab_enable[count->id];
 
@@ -671,7 +676,7 @@ static int quad8_count_enable_read(struct counter_device *counter,
 static int quad8_count_enable_write(struct counter_device *counter,
 				    struct counter_count *count, u8 enable)
 {
-	struct quad8 *const priv = counter->priv;
+	struct quad8 *const priv = quad8_from_counter(counter);
 	const int base_offset = priv->base + 2 * count->id;
 	unsigned long irqflags;
 	unsigned int ior_cfg;
@@ -699,7 +704,7 @@ static const char *const quad8_noise_error_states[] = {
 static int quad8_error_noise_get(struct counter_device *counter,
 				 struct counter_count *count, u32 *noise_error)
 {
-	const struct quad8 *const priv = counter->priv;
+	const struct quad8 *const priv = quad8_from_counter(counter);
 	const int base_offset = priv->base + 2 * count->id + 1;
 
 	*noise_error = !!(inb(base_offset) & QUAD8_FLAG_E);
@@ -710,7 +715,7 @@ static int quad8_error_noise_get(struct counter_device *counter,
 static int quad8_count_preset_read(struct counter_device *counter,
 				   struct counter_count *count, u64 *preset)
 {
-	const struct quad8 *const priv = counter->priv;
+	const struct quad8 *const priv = quad8_from_counter(counter);
 
 	*preset = priv->preset[count->id];
 
@@ -736,7 +741,7 @@ static void quad8_preset_register_set(struct quad8 *const priv, const int id,
 static int quad8_count_preset_write(struct counter_device *counter,
 				    struct counter_count *count, u64 preset)
 {
-	struct quad8 *const priv = counter->priv;
+	struct quad8 *const priv = quad8_from_counter(counter);
 	unsigned long irqflags;
 
 	/* Only 24-bit values are supported */
@@ -755,7 +760,7 @@ static int quad8_count_preset_write(struct counter_device *counter,
 static int quad8_count_ceiling_read(struct counter_device *counter,
 				    struct counter_count *count, u64 *ceiling)
 {
-	struct quad8 *const priv = counter->priv;
+	struct quad8 *const priv = quad8_from_counter(counter);
 	unsigned long irqflags;
 
 	spin_lock_irqsave(&priv->lock, irqflags);
@@ -780,7 +785,7 @@ static int quad8_count_ceiling_read(struct counter_device *counter,
 static int quad8_count_ceiling_write(struct counter_device *counter,
 				     struct counter_count *count, u64 ceiling)
 {
-	struct quad8 *const priv = counter->priv;
+	struct quad8 *const priv = quad8_from_counter(counter);
 	unsigned long irqflags;
 
 	/* Only 24-bit values are supported */
@@ -807,7 +812,7 @@ static int quad8_count_preset_enable_read(struct counter_device *counter,
 					  struct counter_count *count,
 					  u8 *preset_enable)
 {
-	const struct quad8 *const priv = counter->priv;
+	const struct quad8 *const priv = quad8_from_counter(counter);
 
 	*preset_enable = !priv->preset_enable[count->id];
 
@@ -818,7 +823,7 @@ static int quad8_count_preset_enable_write(struct counter_device *counter,
 					   struct counter_count *count,
 					   u8 preset_enable)
 {
-	struct quad8 *const priv = counter->priv;
+	struct quad8 *const priv = quad8_from_counter(counter);
 	const int base_offset = priv->base + 2 * count->id + 1;
 	unsigned long irqflags;
 	unsigned int ior_cfg;
@@ -845,7 +850,7 @@ static int quad8_signal_cable_fault_read(struct counter_device *counter,
 					 struct counter_signal *signal,
 					 u8 *cable_fault)
 {
-	struct quad8 *const priv = counter->priv;
+	struct quad8 *const priv = quad8_from_counter(counter);
 	const size_t channel_id = signal->id / 2;
 	unsigned long irqflags;
 	bool disabled;
@@ -875,7 +880,7 @@ static int quad8_signal_cable_fault_enable_read(struct counter_device *counter,
 						struct counter_signal *signal,
 						u8 *enable)
 {
-	const struct quad8 *const priv = counter->priv;
+	const struct quad8 *const priv = quad8_from_counter(counter);
 	const size_t channel_id = signal->id / 2;
 
 	*enable = !!(priv->cable_fault_enable & BIT(channel_id));
@@ -887,7 +892,7 @@ static int quad8_signal_cable_fault_enable_write(struct counter_device *counter,
 						 struct counter_signal *signal,
 						 u8 enable)
 {
-	struct quad8 *const priv = counter->priv;
+	struct quad8 *const priv = quad8_from_counter(counter);
 	const size_t channel_id = signal->id / 2;
 	unsigned long irqflags;
 	unsigned int cable_fault_enable;
@@ -913,7 +918,7 @@ static int quad8_signal_fck_prescaler_read(struct counter_device *counter,
 					   struct counter_signal *signal,
 					   u8 *prescaler)
 {
-	const struct quad8 *const priv = counter->priv;
+	const struct quad8 *const priv = quad8_from_counter(counter);
 
 	*prescaler = priv->fck_prescaler[signal->id / 2];
 
@@ -924,7 +929,7 @@ static int quad8_signal_fck_prescaler_write(struct counter_device *counter,
 					    struct counter_signal *signal,
 					    u8 prescaler)
 {
-	struct quad8 *const priv = counter->priv;
+	struct quad8 *const priv = quad8_from_counter(counter);
 	const size_t channel_id = signal->id / 2;
 	const int base_offset = priv->base + 2 * channel_id;
 	unsigned long irqflags;
@@ -1150,7 +1155,6 @@ static int quad8_probe(struct device *dev, unsigned int id)
 	priv->counter.num_counts = ARRAY_SIZE(quad8_counts);
 	priv->counter.signals = quad8_signals;
 	priv->counter.num_signals = ARRAY_SIZE(quad8_signals);
-	priv->counter.priv = priv;
 	priv->base = base[id];
 
 	spin_lock_init(&priv->lock);
-- 
2.33.0

