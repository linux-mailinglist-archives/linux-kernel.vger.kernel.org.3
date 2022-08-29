Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD5D35A4D7D
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 15:17:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230319AbiH2NRx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 09:17:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230043AbiH2NRJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 09:17:09 -0400
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 267C078232;
        Mon, 29 Aug 2022 06:16:32 -0700 (PDT)
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27TB2Jvq015154;
        Mon, 29 Aug 2022 09:15:01 -0400
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3j7d484399-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 29 Aug 2022 09:15:01 -0400
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 27TDF0Bg019084
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 29 Aug 2022 09:15:00 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Mon, 29 Aug
 2022 09:14:59 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Mon, 29 Aug 2022 09:14:59 -0400
Received: from nsa.ad.analog.com ([10.44.3.68])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 27TDEeiL026449;
        Mon, 29 Aug 2022 09:14:52 -0400
From:   =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>
To:     <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        <devicetree@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        <linux-input@vger.kernel.org>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>
CC:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Hennerich <michael.hennerich@analog.com>
Subject: [PATCH v4 01/10] input: keyboard: adp5588-keys: support gpi key events as 'gpio keys'
Date:   Mon, 29 Aug 2022 15:15:44 +0200
Message-ID: <20220829131553.690063-2-nuno.sa@analog.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220829131553.690063-1-nuno.sa@analog.com>
References: <20220829131553.690063-1-nuno.sa@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: bNqOKQWNAqt83U521aDD-H1uu6KjFOtI
X-Proofpoint-ORIG-GUID: bNqOKQWNAqt83U521aDD-H1uu6KjFOtI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-29_07,2022-08-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 spamscore=0
 impostorscore=0 priorityscore=1501 bulkscore=0 clxscore=1015
 malwarescore=0 lowpriorityscore=0 mlxlogscore=999 mlxscore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208290061
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This change replaces the support for GPIs as key event generators.
Instead of reporting the events directly, we add a gpio based irqchip
so that these events can be consumed by keys defined in the gpio-keys
driver (as it's goal is indeed for keys on GPIOs capable of generating
interrupts). With this, the gpio-adp5588 driver can also be dropped.

The basic idea is that all the pins that are not being used as part of
the keymap matrix can be possibly requested as GPIOs by gpio-keys
(it's also fine to use these pins as plain interrupts though that's not
really the point).

Since the gpiochip now also has irqchip capabilities, we should only
remove it after we free the device interrupt (otherwise we could, in
theory, be handling GPIs interrupts while the gpiochip is concurrently
removed). Thus the call 'adp5588_gpio_add()' is moved and since the
setup phase also needs to come before making the gpios visible, we also
need to move 'adp5588_setup()'.

While at it, always select GPIOLIB so that we don't need to use #ifdef
guards.

Signed-off-by: Nuno Sá <nuno.sa@analog.com>
---
 drivers/input/keyboard/Kconfig        |   2 +
 drivers/input/keyboard/adp5588-keys.c | 274 +++++++++++++-------------
 include/linux/platform_data/adp5588.h |   2 -
 3 files changed, 144 insertions(+), 134 deletions(-)

diff --git a/drivers/input/keyboard/Kconfig b/drivers/input/keyboard/Kconfig
index a20ee693b22b..ca5cd5e520a7 100644
--- a/drivers/input/keyboard/Kconfig
+++ b/drivers/input/keyboard/Kconfig
@@ -40,6 +40,8 @@ config KEYBOARD_ADP5520
 config KEYBOARD_ADP5588
 	tristate "ADP5588/87 I2C QWERTY Keypad and IO Expander"
 	depends on I2C
+	select GPIOLIB
+	select GPIOLIB_IRQCHIP
 	help
 	  Say Y here if you want to use a ADP5588/87 attached to your
 	  system I2C bus.
diff --git a/drivers/input/keyboard/adp5588-keys.c b/drivers/input/keyboard/adp5588-keys.c
index e2719737360a..f5f7ddfe68be 100644
--- a/drivers/input/keyboard/adp5588-keys.c
+++ b/drivers/input/keyboard/adp5588-keys.c
@@ -40,21 +40,21 @@
 #define WA_DELAYED_READOUT_REVID(rev)		((rev) < 4)
 #define WA_DELAYED_READOUT_TIME			25
 
+#define ADP5588_INVALID_HWIRQ	(~0UL)
+
 struct adp5588_kpad {
 	struct i2c_client *client;
 	struct input_dev *input;
 	ktime_t irq_time;
 	unsigned long delay;
 	unsigned short keycode[ADP5588_KEYMAPSIZE];
-	const struct adp5588_gpi_map *gpimap;
-	unsigned short gpimapsize;
-#ifdef CONFIG_GPIOLIB
 	unsigned char gpiomap[ADP5588_MAXGPIO];
 	struct gpio_chip gc;
 	struct mutex gpio_lock;	/* Protect cached dir, dat_out */
 	u8 dat_out[3];
 	u8 dir[3];
-#endif
+	u8 int_en[3];
+	u8 irq_mask[3];
 };
 
 static int adp5588_read(struct i2c_client *client, u8 reg)
@@ -72,7 +72,6 @@ static int adp5588_write(struct i2c_client *client, u8 reg, u8 val)
 	return i2c_smbus_write_byte_data(client, reg, val);
 }
 
-#ifdef CONFIG_GPIOLIB
 static int adp5588_gpio_get_value(struct gpio_chip *chip, unsigned off)
 {
 	struct adp5588_kpad *kpad = gpiochip_get_data(chip);
@@ -171,9 +170,6 @@ static int adp5588_build_gpiomap(struct adp5588_kpad *kpad,
 	for (i = 0; i < pdata->cols; i++)
 		pin_used[i + GPI_PIN_COL_BASE - GPI_PIN_BASE] = true;
 
-	for (i = 0; i < kpad->gpimapsize; i++)
-		pin_used[kpad->gpimap[i].pin - GPI_PIN_BASE] = true;
-
 	for (i = 0; i < ADP5588_MAXGPIO; i++)
 		if (!pin_used[i])
 			kpad->gpiomap[n_unused++] = i;
@@ -196,11 +192,79 @@ static void adp5588_gpio_do_teardown(void *_kpad)
 		dev_warn(&kpad->client->dev, "teardown failed %d\n", error);
 }
 
+static void adp5588_irq_bus_lock(struct irq_data *d)
+{
+	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
+	struct adp5588_kpad *kpad = gpiochip_get_data(gc);
+
+	mutex_lock(&kpad->gpio_lock);
+}
+
+static void adp5588_irq_bus_sync_unlock(struct irq_data *d)
+{
+	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
+	struct adp5588_kpad *kpad = gpiochip_get_data(gc);
+	int i;
+
+	for (i = 0; i <= ADP5588_BANK(ADP5588_MAXGPIO); i++) {
+		if (kpad->int_en[i] ^ kpad->irq_mask[i]) {
+			kpad->int_en[i] = kpad->irq_mask[i];
+			adp5588_write(kpad->client, GPI_EM1 + i, kpad->int_en[i]);
+		}
+	}
+
+	mutex_unlock(&kpad->gpio_lock);
+}
+
+static void adp5588_irq_mask(struct irq_data *d)
+{
+	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
+	struct adp5588_kpad *kpad = gpiochip_get_data(gc);
+	irq_hw_number_t hwirq = irqd_to_hwirq(d);
+	unsigned long real_irq = kpad->gpiomap[hwirq];
+
+	kpad->irq_mask[ADP5588_BANK(real_irq)] &= ~ADP5588_BIT(real_irq);
+	gpiochip_disable_irq(gc, hwirq);
+}
+
+static void adp5588_irq_unmask(struct irq_data *d)
+{
+	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
+	struct adp5588_kpad *kpad = gpiochip_get_data(gc);
+	irq_hw_number_t hwirq = irqd_to_hwirq(d);
+	unsigned long real_irq = kpad->gpiomap[hwirq];
+
+	gpiochip_enable_irq(gc, hwirq);
+	kpad->irq_mask[ADP5588_BANK(real_irq)] |= ADP5588_BIT(real_irq);
+}
+
+static int adp5588_irq_set_type(struct irq_data *d, unsigned int type)
+{
+	if (!(type & IRQ_TYPE_EDGE_BOTH))
+		return -EINVAL;
+
+	irq_set_handler_locked(d, handle_edge_irq);
+
+	return 0;
+}
+
+static const struct irq_chip adp5588_irq_chip = {
+	.name = "adp5588",
+	.irq_mask = adp5588_irq_mask,
+	.irq_unmask = adp5588_irq_unmask,
+	.irq_bus_lock = adp5588_irq_bus_lock,
+	.irq_bus_sync_unlock = adp5588_irq_bus_sync_unlock,
+	.irq_set_type = adp5588_irq_set_type,
+	.flags = IRQCHIP_SKIP_SET_WAKE | IRQCHIP_IMMUTABLE,
+	GPIOCHIP_IRQ_RESOURCE_HELPERS,
+};
+
 static int adp5588_gpio_add(struct adp5588_kpad *kpad)
 {
 	struct device *dev = &kpad->client->dev;
 	const struct adp5588_kpad_platform_data *pdata = dev_get_platdata(dev);
 	const struct adp5588_gpio_platform_data *gpio_data = pdata->gpio_data;
+	struct gpio_irq_chip *girq;
 	int i, error;
 
 	if (!gpio_data)
@@ -212,6 +276,7 @@ static int adp5588_gpio_add(struct adp5588_kpad *kpad)
 		return 0;
 	}
 
+	kpad->gc.parent = &kpad->client->dev;
 	kpad->gc.direction_input = adp5588_gpio_direction_input;
 	kpad->gc.direction_output = adp5588_gpio_direction_output;
 	kpad->gc.get = adp5588_gpio_get_value;
@@ -223,6 +288,11 @@ static int adp5588_gpio_add(struct adp5588_kpad *kpad)
 	kpad->gc.owner = THIS_MODULE;
 	kpad->gc.names = gpio_data->names;
 
+	girq = &kpad->gc.irq;
+	gpio_irq_chip_set_chip(girq, &adp5588_irq_chip);
+	girq->handler = handle_bad_irq;
+	girq->threaded = true;
+
 	mutex_init(&kpad->gpio_lock);
 
 	error = devm_gpiochip_add_data(dev, &kpad->gc, kpad);
@@ -255,35 +325,73 @@ static int adp5588_gpio_add(struct adp5588_kpad *kpad)
 	return 0;
 }
 
-#else
-static inline int adp5588_gpio_add(struct adp5588_kpad *kpad)
+static unsigned long adp5588_gpiomap_get_hwirq(struct device *dev,
+					       const u8 *map, unsigned int gpio,
+					       unsigned int ngpios)
 {
-	return 0;
+	unsigned int hwirq;
+
+	for (hwirq = 0; hwirq < ngpios; hwirq++)
+		if (map[hwirq] == gpio)
+			return hwirq;
+
+	/* should never happen */
+	dev_warn_ratelimited(dev, "could not find the hwirq for gpio(%u)\n", gpio);
+
+	return ADP5588_INVALID_HWIRQ;
+}
+
+static void adp5588_gpio_irq_handle(struct adp5588_kpad *kpad, int key_val,
+				    int key_press)
+{
+	unsigned int irq, gpio = key_val - GPI_PIN_BASE, irq_type;
+	struct i2c_client *client = kpad->client;
+	struct irq_data *irqd;
+	unsigned long hwirq;
+
+	hwirq = adp5588_gpiomap_get_hwirq(&client->dev, kpad->gpiomap,
+					  gpio, kpad->gc.ngpio);
+	if (hwirq == ADP5588_INVALID_HWIRQ) {
+		dev_err(&client->dev, "Could not get hwirq for key(%u)\n", key_val);
+		return;
+	}
+
+	irq = irq_find_mapping(kpad->gc.irq.domain, hwirq);
+	if (!irq)
+		return;
+
+	irqd = irq_get_irq_data(irq);
+	if (!irqd) {
+		dev_err(&client->dev, "Could not get irq(%u) data\n", irq);
+		return;
+	}
+
+	irq_type = irqd_get_trigger_type(irqd);
+
+	/*
+	 * Default is active low which means key_press is asserted on
+	 * the falling edge.
+	 */
+	if ((irq_type & IRQ_TYPE_EDGE_RISING && !key_press) ||
+	    (irq_type & IRQ_TYPE_EDGE_FALLING && key_press))
+		handle_nested_irq(irq);
 }
-#endif
 
 static void adp5588_report_events(struct adp5588_kpad *kpad, int ev_cnt)
 {
-	int i, j;
+	int i;
 
 	for (i = 0; i < ev_cnt; i++) {
 		int key = adp5588_read(kpad->client, Key_EVENTA + i);
 		int key_val = key & KEY_EV_MASK;
+		int key_press = key & KEY_EV_PRESSED;
 
-		if (key_val >= GPI_PIN_BASE && key_val <= GPI_PIN_END) {
-			for (j = 0; j < kpad->gpimapsize; j++) {
-				if (key_val == kpad->gpimap[j].pin) {
-					input_report_switch(kpad->input,
-							kpad->gpimap[j].sw_evt,
-							key & KEY_EV_PRESSED);
-					break;
-				}
-			}
-		} else {
+		if (key_val >= GPI_PIN_BASE && key_val <= GPI_PIN_END)
+			/* gpio line used as IRQ source */
+			adp5588_gpio_irq_handle(kpad, key_val, key_press);
+		else
 			input_report_key(kpad->input,
-					 kpad->keycode[key_val - 1],
-					 key & KEY_EV_PRESSED);
-		}
+					 kpad->keycode[key_val - 1], key_press);
 	}
 }
 
@@ -341,7 +449,6 @@ static int adp5588_setup(struct i2c_client *client)
 			dev_get_platdata(&client->dev);
 	const struct adp5588_gpio_platform_data *gpio_data = pdata->gpio_data;
 	int i, ret;
-	unsigned char evt_mode1 = 0, evt_mode2 = 0, evt_mode3 = 0;
 
 	ret = adp5588_write(client, KP_GPIO1, KP_SEL(pdata->rows));
 	ret |= adp5588_write(client, KP_GPIO2, KP_SEL(pdata->cols) & 0xFF);
@@ -356,23 +463,6 @@ static int adp5588_setup(struct i2c_client *client)
 	for (i = 0; i < KEYP_MAX_EVENT; i++)
 		ret |= adp5588_read(client, Key_EVENTA);
 
-	for (i = 0; i < pdata->gpimapsize; i++) {
-		unsigned short pin = pdata->gpimap[i].pin;
-
-		if (pin <= GPI_PIN_ROW_END) {
-			evt_mode1 |= (1 << (pin - GPI_PIN_ROW_BASE));
-		} else {
-			evt_mode2 |= ((1 << (pin - GPI_PIN_COL_BASE)) & 0xFF);
-			evt_mode3 |= ((1 << (pin - GPI_PIN_COL_BASE)) >> 8);
-		}
-	}
-
-	if (pdata->gpimapsize) {
-		ret |= adp5588_write(client, GPI_EM1, evt_mode1);
-		ret |= adp5588_write(client, GPI_EM2, evt_mode2);
-		ret |= adp5588_write(client, GPI_EM3, evt_mode3);
-	}
-
 	if (gpio_data) {
 		for (i = 0; i <= ADP5588_BANK(ADP5588_MAXGPIO); i++) {
 			int pull_mask = gpio_data->pullup_dis_mask;
@@ -399,44 +489,6 @@ static int adp5588_setup(struct i2c_client *client)
 	return 0;
 }
 
-static void adp5588_report_switch_state(struct adp5588_kpad *kpad)
-{
-	int gpi_stat1 = adp5588_read(kpad->client, GPIO_DAT_STAT1);
-	int gpi_stat2 = adp5588_read(kpad->client, GPIO_DAT_STAT2);
-	int gpi_stat3 = adp5588_read(kpad->client, GPIO_DAT_STAT3);
-	int gpi_stat_tmp, pin_loc;
-	int i;
-
-	for (i = 0; i < kpad->gpimapsize; i++) {
-		unsigned short pin = kpad->gpimap[i].pin;
-
-		if (pin <= GPI_PIN_ROW_END) {
-			gpi_stat_tmp = gpi_stat1;
-			pin_loc = pin - GPI_PIN_ROW_BASE;
-		} else if ((pin - GPI_PIN_COL_BASE) < 8) {
-			gpi_stat_tmp = gpi_stat2;
-			pin_loc = pin - GPI_PIN_COL_BASE;
-		} else {
-			gpi_stat_tmp = gpi_stat3;
-			pin_loc = pin - GPI_PIN_COL_BASE - 8;
-		}
-
-		if (gpi_stat_tmp < 0) {
-			dev_err(&kpad->client->dev,
-				"Can't read GPIO_DAT_STAT switch %d default to OFF\n",
-				pin);
-			gpi_stat_tmp = 0;
-		}
-
-		input_report_switch(kpad->input,
-				    kpad->gpimap[i].sw_evt,
-				    !(gpi_stat_tmp & (1 << pin_loc)));
-	}
-
-	input_sync(kpad->input);
-}
-
-
 static int adp5588_probe(struct i2c_client *client,
 			 const struct i2c_device_id *id)
 {
@@ -469,37 +521,6 @@ static int adp5588_probe(struct i2c_client *client,
 		return -EINVAL;
 	}
 
-	if (!pdata->gpimap && pdata->gpimapsize) {
-		dev_err(&client->dev, "invalid gpimap from pdata\n");
-		return -EINVAL;
-	}
-
-	if (pdata->gpimapsize > ADP5588_GPIMAPSIZE_MAX) {
-		dev_err(&client->dev, "invalid gpimapsize\n");
-		return -EINVAL;
-	}
-
-	for (i = 0; i < pdata->gpimapsize; i++) {
-		unsigned short pin = pdata->gpimap[i].pin;
-
-		if (pin < GPI_PIN_BASE || pin > GPI_PIN_END) {
-			dev_err(&client->dev, "invalid gpi pin data\n");
-			return -EINVAL;
-		}
-
-		if (pin <= GPI_PIN_ROW_END) {
-			if (pin - GPI_PIN_ROW_BASE + 1 <= pdata->rows) {
-				dev_err(&client->dev, "invalid gpi row data\n");
-				return -EINVAL;
-			}
-		} else {
-			if (pin - GPI_PIN_COL_BASE + 1 <= pdata->cols) {
-				dev_err(&client->dev, "invalid gpi col data\n");
-				return -EINVAL;
-			}
-		}
-	}
-
 	if (!client->irq) {
 		dev_err(&client->dev, "no IRQ?\n");
 		return -EINVAL;
@@ -541,9 +562,6 @@ static int adp5588_probe(struct i2c_client *client,
 	memcpy(kpad->keycode, pdata->keymap,
 		pdata->keymapsize * input->keycodesize);
 
-	kpad->gpimap = pdata->gpimap;
-	kpad->gpimapsize = pdata->gpimapsize;
-
 	/* setup input device */
 	__set_bit(EV_KEY, input->evbit);
 
@@ -555,11 +573,6 @@ static int adp5588_probe(struct i2c_client *client,
 			__set_bit(kpad->keycode[i], input->keybit);
 	__clear_bit(KEY_RESERVED, input->keybit);
 
-	if (kpad->gpimapsize)
-		__set_bit(EV_SW, input->evbit);
-	for (i = 0; i < kpad->gpimapsize; i++)
-		__set_bit(kpad->gpimap[i].sw_evt, input->swbit);
-
 	error = input_register_device(input);
 	if (error) {
 		dev_err(&client->dev, "unable to register input device: %d\n",
@@ -567,6 +580,14 @@ static int adp5588_probe(struct i2c_client *client,
 		return error;
 	}
 
+	error = adp5588_setup(client);
+	if (error)
+		return error;
+
+	error = adp5588_gpio_add(kpad);
+	if (error)
+		return error;
+
 	error = devm_request_threaded_irq(&client->dev, client->irq,
 					  adp5588_hard_irq, adp5588_thread_irq,
 					  IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
@@ -577,17 +598,6 @@ static int adp5588_probe(struct i2c_client *client,
 		return error;
 	}
 
-	error = adp5588_setup(client);
-	if (error)
-		return error;
-
-	if (kpad->gpimapsize)
-		adp5588_report_switch_state(kpad);
-
-	error = adp5588_gpio_add(kpad);
-	if (error)
-		return error;
-
 	dev_info(&client->dev, "Rev.%d keypad, irq %d\n", revid, client->irq);
 	return 0;
 }
diff --git a/include/linux/platform_data/adp5588.h b/include/linux/platform_data/adp5588.h
index 6d3f7d911a92..82170ec8c266 100644
--- a/include/linux/platform_data/adp5588.h
+++ b/include/linux/platform_data/adp5588.h
@@ -147,8 +147,6 @@ struct adp5588_kpad_platform_data {
 	unsigned en_keylock:1;		/* Enable Key Lock feature */
 	unsigned short unlock_key1;	/* Unlock Key 1 */
 	unsigned short unlock_key2;	/* Unlock Key 2 */
-	const struct adp5588_gpi_map *gpimap;
-	unsigned short gpimapsize;
 	const struct adp5588_gpio_platform_data *gpio_data;
 };
 
-- 
2.37.2

