Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAD074FB8BB
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 11:57:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344916AbiDKJ7M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 05:59:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344888AbiDKJ64 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 05:58:56 -0400
Received: from smtp2.axis.com (smtp2.axis.com [195.60.68.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C871641622;
        Mon, 11 Apr 2022 02:56:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1649671002;
  x=1681207002;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FsUXYvruHmfAYwT/pxCNMHOLQLwKXMVdaCSrwdxakXs=;
  b=oh26PSRXcSC3AyPFe3uSmTU2Qhtx8vNysQFJ/EV29GmWqDBNQ1hw6Qtm
   qol3VsFHkUYtS3NZlXoYazGdklNpWb1DOIRKlPy3k6gSO16WwR/n1ZIQc
   wVEYffW4MEAgxFmfpXAEUFJZaKFP+3shzCYzd2nXPbBc5oGYztEaUtdhv
   JI0WXtbHVQfEJh2oyeViR33vpk3H0uwKBF4HFZCu8TYiuVqE0wEGgXO/6
   MjwJn6s7hsa0A1lnzpgIJIG6hkS50Y10M/vF5fc89h6aIzxngDZXCU8iE
   Aj5aT+nqjbR96CxzJbtNJMIX2bj4gFG6bdwv3fXesBUuNbSG0yVqsBbCc
   A==;
From:   Camel Guo <camel.guo@axis.com>
To:     <inux@roeck-us.net>, <jdelvare@suse.com>, <robh+dt@kernel.org>,
        <krzk+dt@kernel.org>
CC:     <kernel@axis.com>, Camel Guo <camel.guo@axis.com>,
        <linux-hwmon@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/2] hwmon: (tmp401) Add support of three advanced features
Date:   Mon, 11 Apr 2022 11:56:34 +0200
Message-ID: <20220411095634.1782732-3-camel.guo@axis.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220411095634.1782732-1-camel.guo@axis.com>
References: <20220411095634.1782732-1-camel.guo@axis.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tmp401 driver supports TMP401, TMP411 and TMP43X temperature sensors.
According to their datasheet:
- all of them support extended temperature range feature;
- TMP411 and TPM43X support n-factor correction feature;
- TMP43X support beta compensation feature.

In order to support setting them during bootup, this commit reads
ti,extended-range-enable, ti,n-factor and ti,beta-compensation and set
the corresponding registers during probing.

Signed-off-by: Camel Guo <camel.guo@axis.com>
---
 drivers/hwmon/tmp401.c | 43 +++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 42 insertions(+), 1 deletion(-)

diff --git a/drivers/hwmon/tmp401.c b/drivers/hwmon/tmp401.c
index b86d9df7105d..75cdf5d2907e 100644
--- a/drivers/hwmon/tmp401.c
+++ b/drivers/hwmon/tmp401.c
@@ -41,6 +41,8 @@ enum chips { tmp401, tmp411, tmp431, tmp432, tmp435 };
 #define TMP401_STATUS				0x02
 #define TMP401_CONFIG				0x03
 #define TMP401_CONVERSION_RATE			0x04
+#define TMP4XX_N_FACTOR_REG			0x18
+#define TMP43X_BETA_RANGE			0x25
 #define TMP401_TEMP_CRIT_HYST			0x21
 #define TMP401_MANUFACTURER_ID_REG		0xFE
 #define TMP401_DEVICE_ID_REG			0xFF
@@ -543,6 +545,7 @@ static int tmp401_init_client(struct tmp401_data *data)
 	struct regmap *regmap = data->regmap;
 	u32 config, config_orig;
 	int ret;
+	u32 val = 0;
 
 	/* Set conversion rate to 2 Hz */
 	ret = regmap_write(regmap, TMP401_CONVERSION_RATE, 5);
@@ -557,10 +560,48 @@ static int tmp401_init_client(struct tmp401_data *data)
 	config_orig = config;
 	config &= ~TMP401_CONFIG_SHUTDOWN;
 
+	if (of_property_read_bool(data->client->dev.of_node, "ti,extended-range-enable")) {
+		/* Enable measurement over extended temperature range */
+		config |= TMP401_CONFIG_RANGE;
+	}
+
 	data->extended_range = !!(config & TMP401_CONFIG_RANGE);
 
-	if (config != config_orig)
+	if (config != config_orig) {
 		ret = regmap_write(regmap, TMP401_CONFIG, config);
+		if (ret < 0)
+			return ret;
+	}
+
+	ret = of_property_read_u32(data->client->dev.of_node, "ti,n-factor", &val);
+	if (!ret) {
+		if (data->kind == tmp401) {
+			dev_err(&data->client->dev, "ti,tmp401 does not support n-factor correction\n");
+			return -EINVAL;
+		}
+		if (val > 255) {
+			dev_err(&data->client->dev, "n-factor is invalid (%u)\n", val);
+			return -EINVAL;
+		}
+		ret = regmap_write(regmap, TMP4XX_N_FACTOR_REG, val);
+		if (ret < 0)
+			return ret;
+	}
+
+	ret = of_property_read_u32(data->client->dev.of_node, "ti,beta-compensation", &val);
+	if (!ret) {
+		if (data->kind == tmp401 || data->kind == tmp411) {
+			dev_err(&data->client->dev, "ti,tmp401 or ti,tmp411 does not support beta compensation\n");
+			return -EINVAL;
+		}
+		if (val > 15) {
+			dev_err(&data->client->dev, "beta-compensation is invalid (%u)\n", val);
+			return -EINVAL;
+		}
+		ret = regmap_write(regmap, TMP43X_BETA_RANGE, val);
+		if (ret < 0)
+			return ret;
+	}
 
 	return ret;
 }
-- 
2.30.2

