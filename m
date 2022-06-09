Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D05745451E3
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 18:28:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344521AbiFIQ2H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 12:28:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344055AbiFIQ1u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 12:27:50 -0400
Received: from smtpout1.mo528.mail-out.ovh.net (smtpout1.mo528.mail-out.ovh.net [46.105.34.251])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 218F54ECC9;
        Thu,  9 Jun 2022 09:27:48 -0700 (PDT)
Received: from pro2.mail.ovh.net (unknown [10.109.146.31])
        by mo528.mail-out.ovh.net (Postfix) with ESMTPS id C0385109DBBD5;
        Thu,  9 Jun 2022 18:27:46 +0200 (CEST)
Received: from localhost.localdomain (88.161.25.233) by DAG1EX2.emp2.local
 (172.16.2.2) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.9; Thu, 9 Jun 2022
 18:27:46 +0200
From:   Jean-Jacques Hiblot <jjhiblot@traphandler.com>
To:     <pavel@ucw.cz>, <krzk+dt@kernel.org>
CC:     <robh+dt@kernel.org>, <linux-leds@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Jean-Jacques Hiblot <jjhiblot@traphandler.com>
Subject: [PATCH v3 3/3] leds: tlc5925: Add support for non blocking operations
Date:   Thu, 9 Jun 2022 18:27:34 +0200
Message-ID: <20220609162734.1462625-4-jjhiblot@traphandler.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220609162734.1462625-1-jjhiblot@traphandler.com>
References: <20220609162734.1462625-1-jjhiblot@traphandler.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [88.161.25.233]
X-ClientProxiedBy: DAG8EX2.emp2.local (172.16.2.82) To DAG1EX2.emp2.local
 (172.16.2.2)
X-Ovh-Tracer-Id: 2270377166237678043
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvfedruddtledgleeiucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucenucfjughrpefhvfevufffkffojghfggfgtghisehtkeertdertddtnecuhfhrohhmpeflvggrnhdqlfgrtghquhgvshcujfhisghlohhtuceojhhjhhhisghlohhtsehtrhgrphhhrghnughlvghrrdgtohhmqeenucggtffrrghtthgvrhhnpeduteevleevvefggfdvueffffejhfehheeuiedtgedtjeeghfehueduudegfeefueenucfkpheptddrtddrtddrtddpkeekrdduiedurddvhedrvdeffeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphhouhhtpdhhvghlohepphhrohdvrdhmrghilhdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepjhhjhhhisghlohhtsehtrhgrphhhrghnughlvghrrdgtohhmpdhnsggprhgtphhtthhopedupdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdfovfetjfhoshhtpehmohehvdek
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Settings multiple LEDs in a row can be a slow operation because of the
time required to acquire the bus and prepare the transfer.
And, in most cases, it is not required that the operation is synchronous.

Implementing the non-blocking brightness_set() for such cases.
A work queue is used to perform the actual SPI transfer.

The blocking method is still available in case someone needs to perform
this operation synchronously (ie by calling led_set_brightness_sync()).


Signed-off-by: Jean-Jacques Hiblot <jjhiblot@traphandler.com>
---
 drivers/leds/leds-tlc5925.c | 76 +++++++++++++++++++++++++++++++++----
 1 file changed, 68 insertions(+), 8 deletions(-)

diff --git a/drivers/leds/leds-tlc5925.c b/drivers/leds/leds-tlc5925.c
index 2c50ba10bdbf..943514d2c459 100644
--- a/drivers/leds/leds-tlc5925.c
+++ b/drivers/leds/leds-tlc5925.c
@@ -18,6 +18,8 @@
 #include <linux/property.h>
 #include <linux/workqueue.h>
 
+#define BITS_PER_ATOMIC (sizeof(atomic_t) * 8)
+
 struct single_led_priv {
 	int idx;
 	struct led_classdev cdev;
@@ -25,12 +27,35 @@ struct single_led_priv {
 
 struct tlc5925_leds_priv {
 	int max_num_leds;
-	u8 *state;
+	int max_state;
+	atomic_t *state;
+	int *spi_buffer;
 	spinlock_t lock;
+	struct spi_device *spi;
+	struct work_struct xmit_work;
 	struct single_led_priv leds[];
 };
 
-static int tlc5925_brightness_set_blocking(struct led_classdev *cdev,
+static int xmit(struct tlc5925_leds_priv *priv)
+{
+	int i;
+
+	spin_lock(&priv->lock);
+	for (i = 0; i < priv->max_state / (sizeof(atomic_t) * 8) ; i++)
+		priv->spi_buffer[i] = atomic_read(&priv->state[i]);
+	spin_unlock(&priv->lock);
+
+	return spi_write(priv->spi, priv->spi_buffer, priv->max_num_leds / 8);
+}
+
+static void xmit_work(struct work_struct *ws)
+{
+	struct tlc5925_leds_priv *priv =
+		container_of(ws, struct tlc5925_leds_priv, xmit_work);
+	xmit(priv);
+};
+
+static void tlc5925_brightness_set(struct led_classdev *cdev,
 					    enum led_brightness brightness)
 {
 	struct spi_device *spi = to_spi_device(cdev->dev->parent);
@@ -40,16 +65,36 @@ static int tlc5925_brightness_set_blocking(struct led_classdev *cdev,
 						   cdev);
 	int index = led->idx;
 
-	spin_lock(&priv->lock);
 	if (brightness)
-		priv->state[index / 8] |= (1 << (index % 8));
+		atomic_or(1 << (index % BITS_PER_ATOMIC),
+			  &priv->state[index / BITS_PER_ATOMIC]);
 	else
-		priv->state[index / 8] &= ~(1 << (index % 8));
-	spin_unlock(&priv->lock);
+		atomic_and(~(1 << (index % BITS_PER_ATOMIC)),
+			   &priv->state[index / BITS_PER_ATOMIC]);
 
-	return spi_write(spi, priv->state, priv->max_num_leds / 8);
+	schedule_work(&priv->xmit_work);
 }
 
+static int tlc5925_brightness_set_blocking(struct led_classdev *cdev,
+					    enum led_brightness brightness)
+{
+	struct spi_device *spi = to_spi_device(cdev->dev->parent);
+	struct tlc5925_leds_priv *priv = spi_get_drvdata(spi);
+	struct single_led_priv *led = container_of(cdev,
+						   struct single_led_priv,
+						   cdev);
+	int index = led->idx;
+
+	if (brightness)
+		atomic_or(1 << (index % BITS_PER_ATOMIC),
+			  &priv->state[index / BITS_PER_ATOMIC]);
+	else
+		atomic_and(~(1 << (index % BITS_PER_ATOMIC)),
+			   &priv->state[index / BITS_PER_ATOMIC]);
+
+	cancel_work_sync(&priv->xmit_work);
+	return xmit(priv);
+}
 
 static int tlc5925_probe(struct spi_device *spi)
 {
@@ -96,10 +141,24 @@ static int tlc5925_probe(struct spi_device *spi)
 
 	spin_lock_init(&priv->lock);
 
-	priv->state = devm_kzalloc(dev, DIV_ROUND_UP(max_num_leds, 8), GFP_KERNEL);
+	priv->spi = spi;
+	INIT_WORK(&priv->xmit_work, xmit_work);
+
+	// Allocate the buffer used to hold the state of each LED
+	priv->max_state = round_up(max_num_leds, BITS_PER_ATOMIC);
+	priv->state = devm_kzalloc(dev,
+				   priv->max_state / 8,
+				   GFP_KERNEL);
 	if (!priv->state)
 		return -ENOMEM;
 
+	// Allocate a second buffer for the communication on the SPI bus
+	priv->spi_buffer = devm_kzalloc(dev,
+				   priv->max_state / 8,
+				   GFP_KERNEL);
+	if (!priv->spi_buffer)
+		return -ENOMEM;
+
 	priv->max_num_leds = max_num_leds;
 
 	device_for_each_child_node(dev, child) {
@@ -120,6 +179,7 @@ static int tlc5925_probe(struct spi_device *spi)
 		cdev = &(priv->leds[count].cdev);
 		cdev->brightness = LED_OFF;
 		cdev->max_brightness = 1;
+		cdev->brightness_set = tlc5925_brightness_set;
 		cdev->brightness_set_blocking = tlc5925_brightness_set_blocking;
 
 		ret = devm_led_classdev_register_ext(dev, cdev, &init_data);
-- 
2.25.1

