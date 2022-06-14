Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E78B354B503
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 17:46:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356959AbiFNPnO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 11:43:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345961AbiFNPnA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 11:43:00 -0400
Received: from smtpout1.mo528.mail-out.ovh.net (smtpout1.mo528.mail-out.ovh.net [46.105.34.251])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0942039813;
        Tue, 14 Jun 2022 08:42:58 -0700 (PDT)
Received: from pro2.mail.ovh.net (unknown [10.108.16.169])
        by mo528.mail-out.ovh.net (Postfix) with ESMTPS id 4DA7E10C19235;
        Tue, 14 Jun 2022 17:42:57 +0200 (CEST)
Received: from localhost.localdomain (88.161.25.233) by DAG1EX2.emp2.local
 (172.16.2.2) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.9; Tue, 14 Jun
 2022 17:42:56 +0200
From:   Jean-Jacques Hiblot <jjhiblot@traphandler.com>
To:     <pavel@ucw.cz>, <krzk+dt@kernel.org>, <andy.shevchenko@gmail.com>
CC:     <robh+dt@kernel.org>, <linux-leds@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Jean-Jacques Hiblot <jjhiblot@traphandler.com>
Subject: [PATCH v5 3/3] leds: tlc5925: Add support for non blocking operations
Date:   Tue, 14 Jun 2022 17:42:45 +0200
Message-ID: <20220614154245.354167-4-jjhiblot@traphandler.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220614154245.354167-1-jjhiblot@traphandler.com>
References: <20220614154245.354167-1-jjhiblot@traphandler.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [88.161.25.233]
X-ClientProxiedBy: DAG1EX2.emp2.local (172.16.2.2) To DAG1EX2.emp2.local
 (172.16.2.2)
X-Ovh-Tracer-Id: 12430216448895826395
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvfedrudduledgledtucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucenucfjughrpefhvfevufffkffojghfggfgtghisehtkeertdertddtnecuhfhrohhmpeflvggrnhdqlfgrtghquhgvshcujfhisghlohhtuceojhhjhhhisghlohhtsehtrhgrphhhrghnughlvghrrdgtohhmqeenucggtffrrghtthgvrhhnpeduteevleevvefggfdvueffffejhfehheeuiedtgedtjeeghfehueduudegfeefueenucfkpheptddrtddrtddrtddpkeekrdduiedurddvhedrvdeffeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphhouhhtpdhhvghlohepphhrohdvrdhmrghilhdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepjhhjhhhisghlohhtsehtrhgrphhhrghnughlvghrrdgtohhmpdhnsggprhgtphhtthhopedupdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdfovfetjfhoshhtpehmohehvdek
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
 drivers/leds/leds-tlc5925.c | 38 +++++++++++++++++++++++++++++++++++--
 1 file changed, 36 insertions(+), 2 deletions(-)

diff --git a/drivers/leds/leds-tlc5925.c b/drivers/leds/leds-tlc5925.c
index 2fb91d9767aa..786497c84ca4 100644
--- a/drivers/leds/leds-tlc5925.c
+++ b/drivers/leds/leds-tlc5925.c
@@ -16,6 +16,7 @@
 #include <linux/module.h>
 #include <linux/property.h>
 #include <linux/types.h>
+#include <linux/workqueue.h>
 #include <linux/spi/spi.h>
 #include <linux/gpio/consumer.h>
 
@@ -27,10 +28,25 @@ struct single_led_priv {
 struct tlc5925_leds_priv {
 	int max_num_leds;
 	unsigned long *state;
+	struct spi_device *spi;
+	struct work_struct xmit_work;
 	struct single_led_priv leds[];
 };
 
-static int tlc5925_brightness_set_blocking(struct led_classdev *cdev,
+static int xmit(struct tlc5925_leds_priv *priv)
+{
+	return spi_write(priv->spi, priv->state, BITS_TO_BYTES(priv->max_num_leds));
+}
+
+static void xmit_work(struct work_struct *ws)
+{
+	struct tlc5925_leds_priv *priv =
+		container_of(ws, struct tlc5925_leds_priv, xmit_work);
+
+	xmit(priv);
+};
+
+static void tlc5925_brightness_set(struct led_classdev *cdev,
 					    enum led_brightness brightness)
 {
 	struct spi_device *spi = to_spi_device(cdev->dev->parent);
@@ -41,9 +57,23 @@ static int tlc5925_brightness_set_blocking(struct led_classdev *cdev,
 
 	assign_bit(index, priv->state, !!brightness);
 
-	return spi_write(spi, priv->state, BITS_TO_BYTES(priv->max_num_leds));
+	schedule_work(&priv->xmit_work);
 }
 
+static int tlc5925_brightness_set_blocking(struct led_classdev *cdev,
+					    enum led_brightness brightness)
+{
+	struct spi_device *spi = to_spi_device(cdev->dev->parent);
+	struct tlc5925_leds_priv *priv = spi_get_drvdata(spi);
+	struct single_led_priv *led =
+		container_of(cdev, struct single_led_priv, cdev);
+	int index = led->idx;
+
+	assign_bit(index, priv->state, !!brightness);
+
+	cancel_work_sync(&priv->xmit_work);
+	return xmit(priv);
+}
 static int tlc5925_probe(struct spi_device *spi)
 {
 	struct device *dev = &spi->dev;
@@ -83,6 +113,9 @@ static int tlc5925_probe(struct spi_device *spi)
 	if (!priv->state)
 		return -ENOMEM;
 
+	priv->spi = spi;
+	INIT_WORK(&priv->xmit_work, xmit_work);
+
 	priv->max_num_leds = max_num_leds;
 
 	device_for_each_child_node(dev, child) {
@@ -103,6 +136,7 @@ static int tlc5925_probe(struct spi_device *spi)
 		cdev = &(priv->leds[count].cdev);
 		cdev->brightness = LED_OFF;
 		cdev->max_brightness = 1;
+		cdev->brightness_set = tlc5925_brightness_set;
 		cdev->brightness_set_blocking = tlc5925_brightness_set_blocking;
 
 		ret = devm_led_classdev_register_ext(dev, cdev, &init_data);
-- 
2.25.1

