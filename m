Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03B3B54CD6F
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 17:50:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244359AbiFOPtu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 11:49:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238563AbiFOPtl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 11:49:41 -0400
Received: from smtpout1.mo528.mail-out.ovh.net (smtpout1.mo528.mail-out.ovh.net [46.105.34.251])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CD2815FD1;
        Wed, 15 Jun 2022 08:49:39 -0700 (PDT)
Received: from pro2.mail.ovh.net (unknown [10.109.143.129])
        by mo528.mail-out.ovh.net (Postfix) with ESMTPS id A278310CA541F;
        Wed, 15 Jun 2022 17:49:37 +0200 (CEST)
Received: from localhost.localdomain (88.161.25.233) by DAG1EX2.emp2.local
 (172.16.2.2) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.9; Wed, 15 Jun
 2022 17:49:37 +0200
From:   Jean-Jacques Hiblot <jjhiblot@traphandler.com>
To:     <pavel@ucw.cz>, <robh+dt@kernel.org>,
        <sven.schwermer@disruptive-technologies.com>,
        <krzysztof.kozlowski+dt@linaro.org>
CC:     <johan+linaro@kernel.org>, <marijn.suijten@somainline.org>,
        <bjorn.andersson@linaro.org>, <andy.shevchenko@gmail.com>,
        <linux-leds@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Jean-Jacques Hiblot <jjhiblot@traphandler.com>
Subject: [PATCH 2/4] led: class: Add devm_fwnode_led_get() to get a LED from a firmware node
Date:   Wed, 15 Jun 2022 17:49:16 +0200
Message-ID: <20220615154918.521687-3-jjhiblot@traphandler.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220615154918.521687-1-jjhiblot@traphandler.com>
References: <20220615154918.521687-1-jjhiblot@traphandler.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [88.161.25.233]
X-ClientProxiedBy: CAS1.emp2.local (172.16.1.1) To DAG1EX2.emp2.local
 (172.16.2.2)
X-Ovh-Tracer-Id: 18415500354912008667
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvfedruddvuddgleduucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucenucfjughrpefhvfevufffkffojghfggfgtghisehtkeertdertddtnecuhfhrohhmpeflvggrnhdqlfgrtghquhgvshcujfhisghlohhtuceojhhjhhhisghlohhtsehtrhgrphhhrghnughlvghrrdgtohhmqeenucggtffrrghtthgvrhhnpeduteevleevvefggfdvueffffejhfehheeuiedtgedtjeeghfehueduudegfeefueenucfkpheptddrtddrtddrtddpkeekrdduiedurddvhedrvdeffeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphhouhhtpdhhvghlohepphhrohdvrdhmrghilhdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepjhhjhhhisghlohhtsehtrhgrphhhrghnughlvghrrdgtohhmpdhnsggprhgtphhtthhopedupdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdfovfetjfhoshhtpehmohehvdek
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Same functionality as devm_of_led_get(), but it takes a firmware node
as a parameter.
This mimic devm_fwnode_pwm_get() found in the PWM core.

The ACPI implementation is missing and the function returns -EOPNOTSUPP
when the firmware node is actually an ACPI node.

Signed-off-by: Jean-Jacques Hiblot <jjhiblot@traphandler.com>
---
 drivers/leds/led-class.c | 34 ++++++++++++++++++++++++++++++++++
 include/linux/leds.h     |  4 ++++
 2 files changed, 38 insertions(+)

diff --git a/drivers/leds/led-class.c b/drivers/leds/led-class.c
index 72fd6ee7af88..7faa953a3870 100644
--- a/drivers/leds/led-class.c
+++ b/drivers/leds/led-class.c
@@ -297,6 +297,40 @@ struct led_classdev *__must_check devm_of_led_get(struct device *dev,
 }
 EXPORT_SYMBOL_GPL(devm_of_led_get);
 
+/**
+ * devm_fwnode_led_get() - request a resource managed LED from firmware node
+ * @dev: device for LED consumer
+ * @fwnode: firmware node to get the LED from
+ * @index:	index of the LED to obtain in the consumer
+ *
+ * Returns the LED device parsed from the firmware node. See of_led_get().
+ *
+ * Returns: A pointer to the requested LED device or an ERR_PTR()-encoded
+ * error code on failure.
+ */
+struct led_classdev *__must_check devm_fwnode_led_get(struct device *dev,
+				       struct fwnode_handle *fwnode,
+				       int index)
+{
+	struct led_classdev *led = ERR_PTR(-ENODEV);
+	int ret;
+
+	if (is_of_node(fwnode))
+		led = of_led_get(to_of_node(fwnode), index);
+	else if (is_acpi_node(fwnode))
+		/* ACPI support is not yet implemented */
+		led = ERR_PTR(-EOPNOTSUPP);
+	if (IS_ERR(led))
+		return led;
+
+	ret = devm_add_action_or_reset(dev, devm_led_release, led);
+	if (ret)
+		return ERR_PTR(ret);
+
+	return led;
+}
+EXPORT_SYMBOL_GPL(devm_fwnode_led_get);
+
 static int led_classdev_next_name(const char *init_name, char *name,
 				  size_t len)
 {
diff --git a/include/linux/leds.h b/include/linux/leds.h
index ba4861ec73d3..ace0130bfcd2 100644
--- a/include/linux/leds.h
+++ b/include/linux/leds.h
@@ -216,6 +216,10 @@ extern void led_put(struct led_classdev *led_cdev);
 struct led_classdev *__must_check devm_of_led_get(struct device *dev,
 						  int index);
 
+struct led_classdev *__must_check devm_fwnode_led_get(struct device *dev,
+				       struct fwnode_handle *fwnode,
+				       int index);
+
 /**
  * led_blink_set - set blinking with software fallback
  * @led_cdev: the LED to start blinking
-- 
2.25.1

