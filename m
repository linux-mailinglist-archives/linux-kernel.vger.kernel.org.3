Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B60E5A889F
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 23:56:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232549AbiHaV4B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 17:56:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232387AbiHaVy5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 17:54:57 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98D2255BD;
        Wed, 31 Aug 2022 14:54:54 -0700 (PDT)
Received: from jupiter.universe (dyndsl-091-096-057-024.ewe-ip-backbone.de [91.96.57.24])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 4755E6601E36;
        Wed, 31 Aug 2022 22:54:47 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1661982887;
        bh=R4fBrM9rqeqbOvgCgAUdSKO4cpSM8keuJE8guAqZn9c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=goIa8C14+4amkitdwx4vWfZ0nrDE1rHpvJC5r2NrdJVS5l5RnGTdJIAk+BDPlsrGh
         ZzmzaTbz+68AXlkISA4rE6aG1TIg/UETtNk//50oWFWCfO64zpL2gBizvAEb9dlk2a
         UMDlDtfvh2+6jYiz15PomsqL54zp3qMgNx1xfWgr2QN7m68jVEQiJlZClIw8XunGnk
         0PzOY7RfUweXqjlR2E1wiQhYYkerQL6bW9gWOXPvYZsu6VAziaeLHhBvI3jZHVjdmn
         lIkv5qhyGTOyDBxpAkYObbGzKai/IqpoX2Gqep5hrSAI466qP1a70/3ysRtbg7aoY8
         opCjGfZUkfISA==
Received: by jupiter.universe (Postfix, from userid 1000)
        id 3B00748078D; Wed, 31 Aug 2022 23:54:43 +0200 (CEST)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lee Jones <lee@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        kernel@collabora.com
Subject: [PATCH 06/13] mfd: rk808: replace 'struct i2c_client' with 'struct device'
Date:   Wed, 31 Aug 2022 23:54:30 +0200
Message-Id: <20220831215437.117880-7-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220831215437.117880-1-sebastian.reichel@collabora.com>
References: <20220831215437.117880-1-sebastian.reichel@collabora.com>
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

Put 'struct device' pointer into the MFD platform_data instead
of the 'struct i2c_client' pointer. This simplifies the code
and prepares the MFD for SPI support.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 drivers/mfd/rk808.c       | 6 +++---
 include/linux/mfd/rk808.h | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/mfd/rk808.c b/drivers/mfd/rk808.c
index e793de9146f7..7baa0e484ac0 100644
--- a/drivers/mfd/rk808.c
+++ b/drivers/mfd/rk808.c
@@ -556,7 +556,7 @@ static int rk808_power_off(struct sys_off_data *data)
 	}
 	ret = regmap_update_bits(rk808->regmap, reg, bit, bit);
 	if (ret)
-		dev_err(&rk808->i2c->dev, "Failed to shutdown device!\n");
+		dev_err(rk808->dev, "Failed to shutdown device!\n");
 
 	return NOTIFY_DONE;
 }
@@ -579,7 +579,7 @@ static int rk808_restart(struct sys_off_data *data)
 	}
 	ret = regmap_update_bits(rk808->regmap, reg, bit, bit);
 	if (ret)
-		dev_err(&rk808->i2c->dev, "Failed to restart device!\n");
+		dev_err(rk808->dev, "Failed to restart device!\n");
 
 	return NOTIFY_DONE;
 }
@@ -702,7 +702,7 @@ static int rk808_probe(struct i2c_client *client,
 		return -EINVAL;
 	}
 
-	rk808->i2c = client;
+	rk808->dev = &client->dev;
 	i2c_set_clientdata(client, rk808);
 
 	rk808->regmap = devm_regmap_init_i2c(client, rk808->regmap_cfg);
diff --git a/include/linux/mfd/rk808.h b/include/linux/mfd/rk808.h
index 58602032e642..9937b068fa82 100644
--- a/include/linux/mfd/rk808.h
+++ b/include/linux/mfd/rk808.h
@@ -696,7 +696,7 @@ enum {
 };
 
 struct rk808 {
-	struct i2c_client		*i2c;
+	struct device			*dev;
 	struct regmap_irq_chip_data	*irq_data;
 	struct regmap			*regmap;
 	long				variant;
-- 
2.35.1

