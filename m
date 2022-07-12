Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63F665716D2
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 12:10:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232908AbiGLKKh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 06:10:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232934AbiGLKKE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 06:10:04 -0400
Received: from msg-2.mailo.com (msg-2.mailo.com [213.182.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 300CCACEC5;
        Tue, 12 Jul 2022 03:09:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailoo.org; s=mailo;
        t=1657620568; bh=QPaiosXXiLfprW1QKMGlsrlutLt4X1y8Mi0U75yNNnE=;
        h=X-EA-Auth:From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:
         References:MIME-Version:Content-Transfer-Encoding;
        b=eMwOnH7sKrAPwzB3OUVeCEE64KV6GywamRnDop5h1Me44Zo4hdrphGyH0CCMZmpNq
         Rws5dxNSJ57ZA/dWF0VfEdMA8QYgDiYjK6brQyJyttBDRwmMZhcAqPwu1vSP77PPd+
         QbttrTsMBDHutuUia0wVpcmUuSDVFqzNNkP9XOIE=
Received: by b-3.in.mailobj.net [192.168.90.13] with ESMTP
        via [213.182.55.207]
        Tue, 12 Jul 2022 12:09:28 +0200 (CEST)
X-EA-Auth: MQRRJPI1nAyjNRO1tYIhT+FBIakUUHQ7XpPZ+79dlMpyxjhL+K00u1Q0MeZqunGVhsrHPXIE6X3AgUYZRbjNvY4Kj8sGkJgwJzDtb4twffE=
From:   Vincent Knecht <vincent.knecht@mailoo.org>
To:     Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Vincent Knecht <vincent.knecht@mailoo.org>,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        hns@goldelico.com,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v5 10/12] leds: is31fl319x: Fix devm vs. non-devm ordering
Date:   Tue, 12 Jul 2022 12:08:36 +0200
Message-Id: <20220712100841.1538395-11-vincent.knecht@mailoo.org>
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

When non-devm resources are allocated they mustn't be followed by
devm allocations, otherwise it will break the tear down ordering
and might lead to crashes or other bugs during ->remove() stage.
Fix this by wrapping mutex_destroy() call with
devm_add_action_or_reset().

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Vincent Knecht <vincent.knecht@mailoo.org>
---
 drivers/leds/leds-is31fl319x.c | 32 +++++++++-----------------------
 1 file changed, 9 insertions(+), 23 deletions(-)

diff --git a/drivers/leds/leds-is31fl319x.c b/drivers/leds/leds-is31fl319x.c
index d9cf70505c43..233ed67830a3 100644
--- a/drivers/leds/leds-is31fl319x.c
+++ b/drivers/leds/leds-is31fl319x.c
@@ -511,10 +511,13 @@ static int is31fl319x_probe(struct i2c_client *client,
 		return -ENOMEM;
 
 	mutex_init(&is31->lock);
+	err = devm_add_action(dev, (void (*)(void *))mutex_destroy, &is31->lock);
+	if (err)
+		return err;
 
 	err = is31fl319x_parse_fw(&client->dev, is31);
 	if (err)
-		goto free_mutex;
+		return err;
 
 	if (is31->shutdown_gpio) {
 		gpiod_direction_output(is31->shutdown_gpio, 0);
@@ -524,19 +527,15 @@ static int is31fl319x_probe(struct i2c_client *client,
 
 	is31->client = client;
 	is31->regmap = devm_regmap_init_i2c(client, is31->cdef->is31fl319x_regmap_config);
-	if (IS_ERR(is31->regmap)) {
-		err = dev_err_probe(dev, PTR_ERR(is31->regmap), "failed to allocate register map\n");
-		goto free_mutex;
-	}
+	if (IS_ERR(is31->regmap))
+		return dev_err_probe(dev, PTR_ERR(is31->regmap), "failed to allocate register map\n");
 
 	i2c_set_clientdata(client, is31);
 
 	/* check for write-reply from chip (we can't read any registers) */
 	err = regmap_write(is31->regmap, is31->cdef->reset_reg, 0x00);
-	if (err < 0) {
-		err = dev_err_probe(dev, err, "no response from chip write\n");
-		goto free_mutex;
-	}
+	if (err < 0)
+		return dev_err_probe(dev, err, "no response from chip write\n");
 
 	/*
 	 * Kernel conventions require per-LED led-max-microamp property.
@@ -568,22 +567,10 @@ static int is31fl319x_probe(struct i2c_client *client,
 
 		err = devm_led_classdev_register(&client->dev, &led->cdev);
 		if (err < 0)
-			goto free_mutex;
+			return err;
 	}
 
 	return 0;
-
-free_mutex:
-	mutex_destroy(&is31->lock);
-	return err;
-}
-
-static int is31fl319x_remove(struct i2c_client *client)
-{
-	struct is31fl319x_chip *is31 = i2c_get_clientdata(client);
-
-	mutex_destroy(&is31->lock);
-	return 0;
 }
 
 /*
@@ -611,7 +598,6 @@ static struct i2c_driver is31fl319x_driver = {
 		.of_match_table = of_is31fl319x_match,
 	},
 	.probe    = is31fl319x_probe,
-	.remove   = is31fl319x_remove,
 	.id_table = is31fl319x_id,
 };
 
-- 
2.35.3



