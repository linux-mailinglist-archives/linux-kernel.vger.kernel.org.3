Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C1BF570F6F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 03:25:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231828AbiGLBZ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 21:25:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231585AbiGLBZ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 21:25:26 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 365828AEC1;
        Mon, 11 Jul 2022 18:25:25 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id o5-20020a17090a3d4500b001ef76490983so6503830pjf.2;
        Mon, 11 Jul 2022 18:25:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=tJk6zBlY9QhoHDBqE6sf/Ar1VT3b2UIqq/vwqwhB/To=;
        b=SdrCVU8V7n1mEnZPqiBABStsw6yqQpQVouPs7LbNp0b2rcLAsVIGMaNMDLdojJ3W8E
         Uz5kHYF87Ipu9A/qN0aFy099JBAtGWbQNK4vShKsEUuRz35yDaIfdwKYUhyPrWXV3CI/
         Q7wrdnRHslrlZkHOGFoAJJJiZ3Jtxej0qemOk4tbliYt1UwNkqhtXc/uaLGumK7b5Lq5
         EkeGC0jNRvS+VKIOoD5CSCELfhowN7GK0fsapsmIeuxgVHaVRAZ/snVBF6EezSW+TFI/
         nD+kJ09rEKfgzdxemzJ96Gz3SYXlHH+zAiDEo7Zf3/PCLV/cemSGhGa0F/4VGp0lwJGI
         Lqeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=tJk6zBlY9QhoHDBqE6sf/Ar1VT3b2UIqq/vwqwhB/To=;
        b=7GWkaIDhxw+/x18N3HdoCqBWq/RliQ4LDJg54x7fXz+nreLh3LxGAWBcjcSuIOCGPA
         ZfODkbkCy0boliBFnFUzcQjvfhj593ffXuj2fkLP3+2r5gN9UW/6M4OKoMzve4GnlJIZ
         7W9b1It+K2j8oZNZsi88yyh80KYNQS8MzZtpQ0WNoJl0IJfmGLjonKalSbsEcBerbgop
         FrEFSHQeCTKyoNGHGIrxQzEOX63eSWHxQc3ZOOf+IHArpry65TavoI66/6UFBqU589Ln
         f5lDliJwecbtAv6RLPP8PQoZ5FXV8HpXJ/CgUjJ0cKpQejFUQiwMDz8t2brPU1jlsotT
         fC4Q==
X-Gm-Message-State: AJIora+erUyUFiKenu+oU4yBvtRJb4paSKOJCOakq+uDgBSwS+nCbJSs
        r7IR7pjZD4pS2nGbWHzfVZimUZPP8TA=
X-Google-Smtp-Source: AGRyM1tVDFhTOh3SLdWErzTBq0Y0cdXLDepnSiDU+IuE3v/TMGPW7U3/ihBoOO5UGN0rk+sv+32csQ==
X-Received: by 2002:a17:90b:4c42:b0:1ef:c8a6:fe91 with SMTP id np2-20020a17090b4c4200b001efc8a6fe91mr1304325pjb.202.1657589123951;
        Mon, 11 Jul 2022 18:25:23 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:a31e:fcfb:1279:f5f8])
        by smtp.gmail.com with ESMTPSA id y7-20020a17090abd0700b001ec71be4145sm5408763pjr.2.2022.07.11.18.25.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jul 2022 18:25:22 -0700 (PDT)
Date:   Mon, 11 Jul 2022 18:25:18 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     linux-input@vger.kernel.org, acz@semihalf.com
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Peter Hutterer <peter.hutterer@who-t.net>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] Input: properly queue synthetic events
Message-ID: <YszNfq4b6MkeoCJC@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We should not be passing synthetic events (such as autorepeat events)
out of order with the events coming from the hardware device, but rather
add them to pending events and flush them all at once.

This also fixes an issue with timestamps for key release events carrying
stale data from the previous autorepeat event.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/input.c | 125 +++++++++++++++++++++---------------------
 1 file changed, 63 insertions(+), 62 deletions(-)

diff --git a/drivers/input/input.c b/drivers/input/input.c
index 1365c9dfb5f2..2c24e92fd64a 100644
--- a/drivers/input/input.c
+++ b/drivers/input/input.c
@@ -174,44 +174,6 @@ static void input_pass_values(struct input_dev *dev,
 	}
 }
 
-static void input_pass_event(struct input_dev *dev,
-			     unsigned int type, unsigned int code, int value)
-{
-	struct input_value vals[] = { { type, code, value } };
-
-	input_pass_values(dev, vals, ARRAY_SIZE(vals));
-}
-
-/*
- * Generate software autorepeat event. Note that we take
- * dev->event_lock here to avoid racing with input_event
- * which may cause keys get "stuck".
- */
-static void input_repeat_key(struct timer_list *t)
-{
-	struct input_dev *dev = from_timer(dev, t, timer);
-	unsigned long flags;
-
-	spin_lock_irqsave(&dev->event_lock, flags);
-
-	if (test_bit(dev->repeat_key, dev->key) &&
-	    is_event_supported(dev->repeat_key, dev->keybit, KEY_MAX)) {
-		struct input_value vals[] =  {
-			{ EV_KEY, dev->repeat_key, 2 },
-			input_value_sync
-		};
-
-		input_set_timestamp(dev, ktime_get());
-		input_pass_values(dev, vals, ARRAY_SIZE(vals));
-
-		if (dev->rep[REP_PERIOD])
-			mod_timer(&dev->timer, jiffies +
-					msecs_to_jiffies(dev->rep[REP_PERIOD]));
-	}
-
-	spin_unlock_irqrestore(&dev->event_lock, flags);
-}
-
 #define INPUT_IGNORE_EVENT	0
 #define INPUT_PASS_TO_HANDLERS	1
 #define INPUT_PASS_TO_DEVICE	2
@@ -275,6 +237,10 @@ static int input_get_disposition(struct input_dev *dev,
 	int disposition = INPUT_IGNORE_EVENT;
 	int value = *pval;
 
+	/* filter-out events from inhibited devices */
+	if (dev->inhibited)
+		return INPUT_IGNORE_EVENT;
+
 	switch (type) {
 
 	case EV_SYN:
@@ -375,19 +341,9 @@ static int input_get_disposition(struct input_dev *dev,
 	return disposition;
 }
 
-static void input_handle_event(struct input_dev *dev,
-			       unsigned int type, unsigned int code, int value)
+static void input_event_dispose(struct input_dev *dev, int disposition,
+			        unsigned int type, unsigned int code, int value)
 {
-	int disposition;
-
-	/* filter-out events from inhibited devices */
-	if (dev->inhibited)
-		return;
-
-	disposition = input_get_disposition(dev, type, code, &value);
-	if (disposition != INPUT_IGNORE_EVENT && type != EV_SYN)
-		add_input_randomness(type, code, value);
-
 	if ((disposition & INPUT_PASS_TO_DEVICE) && dev->event)
 		dev->event(dev, type, code, value);
 
@@ -426,7 +382,22 @@ static void input_handle_event(struct input_dev *dev,
 		input_pass_values(dev, dev->vals, dev->num_vals);
 		dev->num_vals = 0;
 	}
+}
+
+static void input_handle_event(struct input_dev *dev,
+			       unsigned int type, unsigned int code, int value)
+{
+	int disposition;
+
+	lockdep_assert_held(&dev->event_lock);
+
+	disposition = input_get_disposition(dev, type, code, &value);
+	if (disposition != INPUT_IGNORE_EVENT) {
+		if (type != EV_SYN)
+			add_input_randomness(type, code, value);
 
+		input_event_dispose(dev, disposition, type, code, value);
+	}
 }
 
 /**
@@ -613,7 +584,7 @@ static void __input_release_device(struct input_handle *handle)
 					    lockdep_is_held(&dev->mutex));
 	if (grabber == handle) {
 		rcu_assign_pointer(dev->grab, NULL);
-		/* Make sure input_pass_event() notices that grab is gone */
+		/* Make sure input_pass_values() notices that grab is gone */
 		synchronize_rcu();
 
 		list_for_each_entry(handle, &dev->h_list, d_node)
@@ -736,7 +707,7 @@ void input_close_device(struct input_handle *handle)
 
 	if (!--handle->open) {
 		/*
-		 * synchronize_rcu() makes sure that input_pass_event()
+		 * synchronize_rcu() makes sure that input_pass_values()
 		 * completed and that no more input events are delivered
 		 * through this handle
 		 */
@@ -758,14 +729,12 @@ static void input_dev_release_keys(struct input_dev *dev)
 
 	if (is_event_supported(EV_KEY, dev->evbit, EV_MAX)) {
 		for_each_set_bit(code, dev->key, KEY_CNT) {
-			input_pass_event(dev, EV_KEY, code, 0);
+			input_handle_event(dev, EV_KEY, code, 0);
 			need_sync = true;
 		}
 
 		if (need_sync)
-			input_pass_event(dev, EV_SYN, SYN_REPORT, 1);
-
-		memset(dev->key, 0, sizeof(dev->key));
+			input_handle_event(dev, EV_SYN, SYN_REPORT, 1);
 	}
 }
 
@@ -1004,12 +973,16 @@ int input_set_keycode(struct input_dev *dev,
 	} else if (test_bit(EV_KEY, dev->evbit) &&
 		   !is_event_supported(old_keycode, dev->keybit, KEY_MAX) &&
 		   __test_and_clear_bit(old_keycode, dev->key)) {
-		struct input_value vals[] =  {
-			{ EV_KEY, old_keycode, 0 },
-			input_value_sync
-		};
-
-		input_pass_values(dev, vals, ARRAY_SIZE(vals));
+		/*
+		 * We have to use input_event_dispose() here directly instead
+		 * of input_handle_event() because the key we want to release
+		 * here is considered no longer supported by the device and
+		 * input_handle_event() will ignore it.
+		 */
+		input_event_dispose(dev, INPUT_PASS_TO_HANDLERS,
+				    EV_KEY, old_keycode, 0);
+		input_event_dispose(dev, INPUT_PASS_TO_HANDLERS | INPUT_FLUSH,
+				    EV_SYN, SYN_REPORT, 1);
 	}
 
  out:
@@ -2259,6 +2232,34 @@ static void devm_input_device_unregister(struct device *dev, void *res)
 	__input_unregister_device(input);
 }
 
+/*
+ * Generate software autorepeat event. Note that we take
+ * dev->event_lock here to avoid racing with input_event
+ * which may cause keys get "stuck".
+ */
+static void input_repeat_key(struct timer_list *t)
+{
+	struct input_dev *dev = from_timer(dev, t, timer);
+	unsigned long flags;
+
+	spin_lock_irqsave(&dev->event_lock, flags);
+
+	if (!dev->inhibited &&
+	    test_bit(dev->repeat_key, dev->key) &&
+	    is_event_supported(dev->repeat_key, dev->keybit, KEY_MAX)) {
+
+		input_set_timestamp(dev, ktime_get());
+		input_handle_event(dev, EV_KEY, dev->repeat_key, 2);
+		input_handle_event(dev, EV_SYN, SYN_REPORT, 1);
+
+		if (dev->rep[REP_PERIOD])
+			mod_timer(&dev->timer, jiffies +
+					msecs_to_jiffies(dev->rep[REP_PERIOD]));
+	}
+
+	spin_unlock_irqrestore(&dev->event_lock, flags);
+}
+
 /**
  * input_enable_softrepeat - enable software autorepeat
  * @dev: input device
-- 
2.37.0.144.g8ac04bfd2-goog


-- 
Dmitry
