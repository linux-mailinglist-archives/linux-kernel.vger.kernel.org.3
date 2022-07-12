Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00F475716C7
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 12:10:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232313AbiGLKKG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 06:10:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232885AbiGLKJi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 06:09:38 -0400
Received: from msg-2.mailo.com (msg-2.mailo.com [213.182.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD989AB7EF;
        Tue, 12 Jul 2022 03:09:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailoo.org; s=mailo;
        t=1657620565; bh=ot1QY0W2gqQ8FHzqL+n9MiYv5sQHYxZYX0Y2iqO3/ds=;
        h=X-EA-Auth:From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:
         References:MIME-Version:Content-Transfer-Encoding;
        b=M1WqVbKPG1BCZUunTQVsTCtvajxL+sB1QmEwh2OMpPja0TgmRs2H8xANY0sqVZ6Bk
         DaWQmZTrjd4J8QQIEkM4mQeS9/uAfh4RHThUD1+phSQDKkqJzBQwAMgTDoi3ghJCYa
         Sv0n+Zepadm2vD9PIOGJg0DKiEtLJzc9kS4KTuQg=
Received: by b-3.in.mailobj.net [192.168.90.13] with ESMTP
        via [213.182.55.207]
        Tue, 12 Jul 2022 12:09:25 +0200 (CEST)
X-EA-Auth: aTk9wxyFnYR65KRpSAkuG5a0sOVuECX1n5dNry6wlRbP49nAbXGWd/ji9zl1Y6cPEqJ1KW199GphGo4s0Yq+g1gyeO5xXYWsiJqRLJg0oB4=
From:   Vincent Knecht <vincent.knecht@mailoo.org>
To:     Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Vincent Knecht <vincent.knecht@mailoo.org>,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        hns@goldelico.com,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v5 09/12] leds: is31fl319x: Make use of dev_err_probe()
Date:   Tue, 12 Jul 2022 12:08:35 +0200
Message-Id: <20220712100841.1538395-10-vincent.knecht@mailoo.org>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220712100841.1538395-1-vincent.knecht@mailoo.org>
References: <20220712100841.1538395-1-vincent.knecht@mailoo.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Simplify the error handling in probe function by switching from
dev_err() to dev_err_probe().

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Vincent Knecht <vincent.knecht@mailoo.org>
---
 drivers/leds/leds-is31fl319x.c | 33 +++++++++++++--------------------
 1 file changed, 13 insertions(+), 20 deletions(-)

diff --git a/drivers/leds/leds-is31fl319x.c b/drivers/leds/leds-is31fl319x.c
index b1a0ca340e24..d9cf70505c43 100644
--- a/drivers/leds/leds-is31fl319x.c
+++ b/drivers/leds/leds-is31fl319x.c
@@ -396,11 +396,9 @@ static int is31fl319x_parse_fw(struct device *dev, struct is31fl319x_chip *is31)
 	int ret;
 
 	is31->shutdown_gpio = devm_gpiod_get_optional(dev, "shutdown", GPIOD_OUT_HIGH);
-	if (IS_ERR(is31->shutdown_gpio)) {
-		ret = PTR_ERR(is31->shutdown_gpio);
-		dev_err(dev, "Failed to get shutdown gpio: %d\n", ret);
-		return ret;
-	}
+	if (IS_ERR(is31->shutdown_gpio))
+		return dev_err_probe(dev, PTR_ERR(is31->shutdown_gpio),
+				     "Failed to get shutdown gpio\n");
 
 	is31->cdef = device_get_match_data(dev);
 
@@ -410,11 +408,10 @@ static int is31fl319x_parse_fw(struct device *dev, struct is31fl319x_chip *is31)
 
 	dev_dbg(dev, "probing with %d leds defined in DT\n", count);
 
-	if (!count || count > is31->cdef->num_leds) {
-		dev_err(dev, "Number of leds defined must be between 1 and %u\n",
-			is31->cdef->num_leds);
-		return -ENODEV;
-	}
+	if (!count || count > is31->cdef->num_leds)
+		return dev_err_probe(dev, -ENODEV,
+				     "Number of leds defined must be between 1 and %u\n",
+				     is31->cdef->num_leds);
 
 	fwnode_for_each_available_child_node(fwnode, child) {
 		struct is31fl319x_led *led;
@@ -422,27 +419,25 @@ static int is31fl319x_parse_fw(struct device *dev, struct is31fl319x_chip *is31)
 
 		ret = fwnode_property_read_u32(child, "reg", &reg);
 		if (ret) {
-			dev_err(dev, "Failed to read led 'reg' property\n");
+			ret = dev_err_probe(dev, ret, "Failed to read led 'reg' property\n");
 			goto put_child_node;
 		}
 
 		if (reg < 1 || reg > is31->cdef->num_leds) {
-			dev_err(dev, "invalid led reg %u\n", reg);
-			ret = -EINVAL;
+			ret = dev_err_probe(dev, -EINVAL, "invalid led reg %u\n", reg);
 			goto put_child_node;
 		}
 
 		led = &is31->leds[reg - 1];
 
 		if (led->configured) {
-			dev_err(dev, "led %u is already configured\n", reg);
-			ret = -EINVAL;
+			ret = dev_err_probe(dev, -EINVAL, "led %u is already configured\n", reg);
 			goto put_child_node;
 		}
 
 		ret = is31fl319x_parse_child_fw(dev, child, led, is31);
 		if (ret) {
-			dev_err(dev, "led %u DT parsing failed\n", reg);
+			ret = dev_err_probe(dev, ret, "led %u DT parsing failed\n", reg);
 			goto put_child_node;
 		}
 
@@ -530,8 +525,7 @@ static int is31fl319x_probe(struct i2c_client *client,
 	is31->client = client;
 	is31->regmap = devm_regmap_init_i2c(client, is31->cdef->is31fl319x_regmap_config);
 	if (IS_ERR(is31->regmap)) {
-		dev_err(&client->dev, "failed to allocate register map\n");
-		err = PTR_ERR(is31->regmap);
+		err = dev_err_probe(dev, PTR_ERR(is31->regmap), "failed to allocate register map\n");
 		goto free_mutex;
 	}
 
@@ -540,8 +534,7 @@ static int is31fl319x_probe(struct i2c_client *client,
 	/* check for write-reply from chip (we can't read any registers) */
 	err = regmap_write(is31->regmap, is31->cdef->reset_reg, 0x00);
 	if (err < 0) {
-		dev_err(&client->dev, "no response from chip write: err = %d\n", err);
-		err = -EIO; /* does not answer */
+		err = dev_err_probe(dev, err, "no response from chip write\n");
 		goto free_mutex;
 	}
 
-- 
2.35.3



