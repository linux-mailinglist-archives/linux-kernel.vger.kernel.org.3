Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EB3E5086F7
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 13:26:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378086AbiDTL30 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 07:29:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357405AbiDTL3R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 07:29:17 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA89362E5;
        Wed, 20 Apr 2022 04:26:31 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: aferraris)
        with ESMTPSA id EB2CD1F4375F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1650453990;
        bh=xnwSIcU9NhkZbooNPSsKPj3qxRSEyE8mP14pNaznZBI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=E1plTEtJN9kJX2jnaqG9mZqBIKfGYgL4u5Vvw7jN0ftB55Rm7tEhfpWRhkOw0jLcQ
         TDbWuhoqNOnV4t+rnmgv+yIjvpzFCNtqyo7b2D+Ser0/FJWrssPVAkUhTVTWyIT0yq
         hGkcIs7LZ0MNck7dC2PvV3lFVeAQBvA87MnLUTq8bJEpATUgci4o6xW18P7FbYLTlZ
         CQqq1H5DvC39+L8poWpZlvf8z45RfruVBoqWjqJPc3+BS8S95OBmX+TEelNpnhqBNr
         0bwfMIj0ThAKBmxgtWM75FRzTOeazKT/7DT2MIhYE2AfYa6Eaqlcj0dAHTPNuGdmRC
         gTvG2H/6kGLUQ==
From:   Arnaud Ferraris <arnaud.ferraris@collabora.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com
Subject: [PATCH v2 2/2] iio: stk3310: Export near level property for proximity sensor
Date:   Wed, 20 Apr 2022 13:25:40 +0200
Message-Id: <20220420112540.91907-3-arnaud.ferraris@collabora.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220420112540.91907-1-arnaud.ferraris@collabora.com>
References: <20220420112540.91907-1-arnaud.ferraris@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This makes the value from which an object should be considered "near"
available to userspace. This hardware-dependent value should be set
in the device-tree.

Signed-off-by: Arnaud Ferraris <arnaud.ferraris@collabora.com>
---
Changes in v2:
  - drop zero-assignment as the variable won't be set if DT property is
    missing

 drivers/iio/light/stk3310.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/iio/light/stk3310.c b/drivers/iio/light/stk3310.c
index 1d02dfbc29d1..b578b46276cc 100644
--- a/drivers/iio/light/stk3310.c
+++ b/drivers/iio/light/stk3310.c
@@ -106,6 +106,7 @@ struct stk3310_data {
 	struct mutex lock;
 	bool als_enabled;
 	bool ps_enabled;
+	uint32_t ps_near_level;
 	u64 timestamp;
 	struct regmap *regmap;
 	struct regmap_field *reg_state;
@@ -135,6 +136,25 @@ static const struct iio_event_spec stk3310_events[] = {
 	},
 };
 
+static ssize_t stk3310_read_near_level(struct iio_dev *indio_dev,
+				       uintptr_t priv,
+				       const struct iio_chan_spec *chan,
+				       char *buf)
+{
+	struct stk3310_data *data = iio_priv(indio_dev);
+
+	return sprintf(buf, "%u\n", data->ps_near_level);
+}
+
+static const struct iio_chan_spec_ext_info stk3310_ext_info[] = {
+	{
+		.name = "nearlevel",
+		.shared = IIO_SEPARATE,
+		.read = stk3310_read_near_level,
+	},
+	{ /* sentinel */ }
+};
+
 static const struct iio_chan_spec stk3310_channels[] = {
 	{
 		.type = IIO_LIGHT,
@@ -151,6 +171,7 @@ static const struct iio_chan_spec stk3310_channels[] = {
 			BIT(IIO_CHAN_INFO_INT_TIME),
 		.event_spec = stk3310_events,
 		.num_event_specs = ARRAY_SIZE(stk3310_events),
+		.ext_info = stk3310_ext_info,
 	}
 };
 
@@ -581,6 +602,10 @@ static int stk3310_probe(struct i2c_client *client,
 	data = iio_priv(indio_dev);
 	data->client = client;
 	i2c_set_clientdata(client, indio_dev);
+
+	device_property_read_u32(&client->dev, "proximity-near-level",
+				 &data->ps_near_level);
+
 	mutex_init(&data->lock);
 
 	ret = stk3310_regmap_init(data);
-- 
2.35.1
