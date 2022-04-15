Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8065850271B
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 10:50:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351617AbiDOIxJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 04:53:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351544AbiDOIxB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 04:53:01 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F346B82E6;
        Fri, 15 Apr 2022 01:50:34 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: aferraris)
        with ESMTPSA id 684331F47DD6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1650012632;
        bh=qJ1psTuJGHQwoRp08D0s9aPEEp7dXucZN9uyn4vkW2U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=R92ppw2xMQBaPq2XBYdHITM9Qn9ensz/3XCBDC5FwQVVIaigQG+EWX+3OQzWUbiPr
         EWMBYGC/mN4wDMukmdgjK+zhFtsW+alOdcE7SFCzcfP85NIBTMPjMUOrMq73Q/QxRG
         O9S3HbWYF40mogsqYKqBBqjy3oIFUYYB9CUBnutbGzqhdgNum3jCk5HXNm4jnXDvCc
         G1efsrq8uKiQQilQSLSRrxmJQ+SF3Ged2rmqgUYINICFwtKjhKEbwuMJFRkyw0aWLm
         ErRNt6YANY1rQSkw4BhFnqlqFfRKb6UHJ0/TMEV8179Fq0SHcXJQQBG1Z6QF7w58KO
         0+l5RC6nDPXdg==
From:   Arnaud Ferraris <arnaud.ferraris@collabora.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com
Subject: [PATCH 2/2] iio: stk3310: Export near level property for proximity sensor
Date:   Fri, 15 Apr 2022 10:50:18 +0200
Message-Id: <20220415085018.35063-3-arnaud.ferraris@collabora.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220415085018.35063-1-arnaud.ferraris@collabora.com>
References: <20220415085018.35063-1-arnaud.ferraris@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
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
 drivers/iio/light/stk3310.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/iio/light/stk3310.c b/drivers/iio/light/stk3310.c
index 1d02dfbc29d1..7792456323ef 100644
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
 
@@ -581,6 +602,11 @@ static int stk3310_probe(struct i2c_client *client,
 	data = iio_priv(indio_dev);
 	data->client = client;
 	i2c_set_clientdata(client, indio_dev);
+
+	if (device_property_read_u32(&client->dev, "proximity-near-level",
+				     &data->ps_near_level))
+		data->ps_near_level = 0;
+
 	mutex_init(&data->lock);
 
 	ret = stk3310_regmap_init(data);
-- 
2.35.1

