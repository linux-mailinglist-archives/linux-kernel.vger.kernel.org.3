Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6163D59F8D1
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 13:50:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236973AbiHXLtx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 07:49:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235888AbiHXLtt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 07:49:49 -0400
Received: from mail.sberdevices.ru (mail.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F20F038BF;
        Wed, 24 Aug 2022 04:49:46 -0700 (PDT)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mail.sberdevices.ru (Postfix) with ESMTP id 281835FD0D;
        Wed, 24 Aug 2022 14:49:45 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1661341785;
        bh=Gc1Ehx0muehVG5YGju2xkrdTmR1ENRgiKV3WzwoEykI=;
        h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
        b=J/Y4E53t3As/HZ+Zwly3fui6Tv7C2xxii6luazqq9hmhfTJM4uzT89jRPeQ7x2bi2
         06QKV2d3ANNd29LS/zCb0N0w248We8z+ZZwuin/MWaWBA8cameFkrfQn+iVW/PlUrh
         LMMV44GQkGnNktvFZHSC1QD9VNBkzYb17kqbPs8Ionwbgpvk2G+KRvW+0PrVDvFc6r
         +pCSAkZw7mRHBW7BT1miqWfMMICxcJkxmdW8eydb105IIOBqzmeayuWBCb4ueNEmXc
         S8B1RdH9YdVkyw1gUQOxXl+13j8GulnO9TKEqzAystvt184EpKTphmS8jUKkwo0j8m
         eBxbRdaDX98XQ==
Received: from S-MS-EXCH01.sberdevices.ru (S-MS-EXCH01.sberdevices.ru [172.16.1.4])
        by mail.sberdevices.ru (Postfix) with ESMTP;
        Wed, 24 Aug 2022 14:49:44 +0300 (MSK)
From:   Martin Kurbanov <mmkurbanov@sberdevices.ru>
To:     Pavel Machek <pavel@ucw.cz>,
        Raphael Teysseyre <rteysseyre@gmail.com>,
        Baolin Wang <baolin.wang@linaro.org>
CC:     <linux-leds@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel@sberdevices.ru>,
        Martin Kurbanov <mmkurbanov@sberdevices.ru>
Subject: [PATCH v1] leds: trigger: pattern: notify userpace if pattern finished
Date:   Wed, 24 Aug 2022 14:49:27 +0300
Message-ID: <20220824114927.79231-1-mmkurbanov@sberdevices.ru>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.16.1.6]
X-ClientProxiedBy: S-MS-EXCH02.sberdevices.ru (172.16.1.5) To
 S-MS-EXCH01.sberdevices.ru (172.16.1.4)
X-KSMG-Rule-ID: 4
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiPhishing: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2022/08/24 08:05:00 #20147978
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the current moment, userspace caller can schedule led pattern with
appropriate parameters, but it doesn't have ability to listen any events
indicated pattern finished. This patch implements such an event using
sysfs node and sysfs_notify_dirent() call.

Signed-off-by: Martin Kurbanov <mmkurbanov@sberdevices.ru>
---
 drivers/leds/trigger/ledtrig-pattern.c | 64 +++++++++++++++++++++++++-
 1 file changed, 63 insertions(+), 1 deletion(-)

diff --git a/drivers/leds/trigger/ledtrig-pattern.c b/drivers/leds/trigger/ledtrig-pattern.c
index 43a265dc4696..54c4b957052f 100644
--- a/drivers/leds/trigger/ledtrig-pattern.c
+++ b/drivers/leds/trigger/ledtrig-pattern.c
@@ -33,7 +33,9 @@ struct pattern_trig_data {
 	int delta_t;
 	bool is_indefinite;
 	bool is_hw_pattern;
+	bool running;
 	struct timer_list timer;
+	struct kernfs_node *pattern_ended;
 };

 static void pattern_trig_update_patterns(struct pattern_trig_data *data)
@@ -76,8 +78,14 @@ static void pattern_trig_timer_function(struct timer_list *t)
 	struct pattern_trig_data *data = from_timer(data, t, timer);

 	for (;;) {
-		if (!data->is_indefinite && !data->repeat)
+		if (!data->is_indefinite && !data->repeat) {
+			data->running = false;
+
+			if (data->pattern_ended)
+				sysfs_notify_dirent(data->pattern_ended);
+
 			break;
+		}

 		if (data->curr->brightness == data->next->brightness) {
 			/* Step change of brightness */
@@ -137,6 +145,7 @@ static int pattern_trig_start_pattern(struct led_classdev *led_cdev)
 	data->curr = data->patterns;
 	data->next = data->patterns + 1;
 	data->timer.expires = jiffies;
+	data->running = true;
 	add_timer(&data->timer);

 	return 0;
@@ -176,6 +185,7 @@ static ssize_t repeat_store(struct device *dev, struct device_attribute *attr,
 	mutex_lock(&data->lock);

 	del_timer_sync(&data->timer);
+	data->running = false;

 	if (data->is_hw_pattern)
 		led_cdev->pattern_clear(led_cdev);
@@ -268,6 +278,7 @@ static ssize_t pattern_trig_store_patterns(struct led_classdev *led_cdev,
 	mutex_lock(&data->lock);

 	del_timer_sync(&data->timer);
+	data->running = false;

 	if (data->is_hw_pattern)
 		led_cdev->pattern_clear(led_cdev);
@@ -330,6 +341,17 @@ static ssize_t hw_pattern_store(struct device *dev,

 static DEVICE_ATTR_RW(hw_pattern);

+static ssize_t pattern_ended_show(struct device *dev,
+				  struct device_attribute *attr, char *buf)
+{
+	struct led_classdev *led_cdev = dev_get_drvdata(dev);
+	struct pattern_trig_data *data = led_get_trigger_data(led_cdev);
+
+	return scnprintf(buf, PAGE_SIZE, "%d\n", !data->running);
+}
+
+static DEVICE_ATTR_RO(pattern_ended);
+
 static umode_t pattern_trig_attrs_mode(struct kobject *kobj,
 				       struct attribute *attr, int index)
 {
@@ -385,9 +407,41 @@ static void pattern_init(struct led_classdev *led_cdev)
 	kfree(pattern);
 }

+static int pattern_trig_add_pattern_ended(struct led_classdev *led_cdev)
+{
+	struct pattern_trig_data *data = led_get_trigger_data(led_cdev);
+	struct device *dev = led_cdev->dev;
+	int ret;
+
+	ret = device_create_file(dev, &dev_attr_pattern_ended);
+	if (ret) {
+		dev_err(dev,
+			"Error creating pattern_ended (%pe)\n", ERR_PTR(ret));
+		return ret;
+	}
+
+	data->pattern_ended = sysfs_get_dirent(dev->kobj.sd, "pattern_ended");
+	if (!data->pattern_ended) {
+		dev_err(dev, "Error getting pattern_ended kernelfs\n");
+		device_remove_file(dev, &dev_attr_pattern_ended);
+		return -ENXIO;
+	}
+
+	return 0;
+}
+
+static void pattern_trig_remove_pattern_ended(struct led_classdev *led_cdev)
+{
+	struct pattern_trig_data *data = led_get_trigger_data(led_cdev);
+
+	sysfs_put(data->pattern_ended);
+	device_remove_file(led_cdev->dev, &dev_attr_pattern_ended);
+}
+
 static int pattern_trig_activate(struct led_classdev *led_cdev)
 {
 	struct pattern_trig_data *data;
+	int err;

 	data = kzalloc(sizeof(*data), GFP_KERNEL);
 	if (!data)
@@ -406,6 +460,13 @@ static int pattern_trig_activate(struct led_classdev *led_cdev)
 	data->led_cdev = led_cdev;
 	led_set_trigger_data(led_cdev, data);
 	timer_setup(&data->timer, pattern_trig_timer_function, 0);
+
+	err = pattern_trig_add_pattern_ended(led_cdev);
+	if (err)
+		dev_warn(led_cdev->dev,
+			 "pattern ended notifications disabled (%pe)\n",
+			 ERR_PTR(err));
+
 	led_cdev->activated = true;

 	if (led_cdev->flags & LED_INIT_DEFAULT_TRIGGER) {
@@ -431,6 +492,7 @@ static void pattern_trig_deactivate(struct led_classdev *led_cdev)
 		led_cdev->pattern_clear(led_cdev);

 	del_timer_sync(&data->timer);
+	pattern_trig_remove_pattern_ended(led_cdev);

 	led_set_brightness(led_cdev, LED_OFF);
 	kfree(data);
--
2.37.2

