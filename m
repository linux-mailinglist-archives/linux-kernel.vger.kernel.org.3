Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C13F14B4D4D
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 12:12:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230402AbiBNLEv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 06:04:51 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350043AbiBNLET (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 06:04:19 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A53542AFD
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 02:32:28 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id y17so24304658edd.10
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 02:32:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UXFVdha6mdWIMpTuHA+4tNIC4aJVupleztPzYIr+WPI=;
        b=I7At3oMdPup7wbHPzTD4p91kx9RZF33ZicvN6qyKhF8FgVHcF/XjWK60kE8i/18t/D
         hKzdoTAdQpZ858vM1aqy3u444vLxTXbX8pwQufaoOPupaKJvsle9wAOhflXtLBz09W9p
         0ciQ/Y5SNnIYddiSceKzMtYvYe8VvrLjI/XHwy4V4mbbXgShwuEfWlFNJIX+1Vadd3Rr
         XkmuJLzRc2N3S0ZLN1p0h3hqvq8qikaobE97MBnWQbM62BfheAE7zNIj2Tps7pdAClLj
         sks7cpHtLsEuMci+DdcAciCYQMN0tj6X8utiSR1c+fLEHl0/71M4XFSUqj/JBgeNs/z8
         XxlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UXFVdha6mdWIMpTuHA+4tNIC4aJVupleztPzYIr+WPI=;
        b=57JG7xM0zQs4G5TWUO4+OmDDZADDHCtXTyNQQFT8vK6Zpo7KYqo1Cr8K/JPWejS7f9
         +XU6p3vU4LIAX2scEt3icydgGf+57GBTU4cph9gt1sgH1h2PDAqcT53s90wEnvByIGnG
         vVgnOYAFa0J1agT4Us2BVkwCKU8pXpHa5LUJYkP7guocAgc8JZdirdiK8l1b2hWGVQha
         IxNacrCwXuE1kOVkMknvp+wMi9zFJWhZvLaE1Ymar12uiLl4RdM6fysuGyHdkJD3Z19s
         KfFVS9Da9rMpu7c3SQ3s+yYF543kKbwg6KLHvMM/W5JbYdyXcv/ACmO5bNrcD1MRXu7E
         f0xg==
X-Gm-Message-State: AOAM530fuM/v4FiTG+mERRSdwU21U4wyzmpffEzonBkkNqMaBTup6ugV
        o9i5+1r4g+2oR4nH4Z2r3/0SMA==
X-Google-Smtp-Source: ABdhPJzD5nvFKd1Dvw1B4oitBAMAX+1avm4qT6z5dihr5dJiuH11VWW/zmw0n+tZaRQuqEEr4mrvPw==
X-Received: by 2002:a05:6402:520e:: with SMTP id s14mr14645822edd.401.1644834746954;
        Mon, 14 Feb 2022 02:32:26 -0800 (PST)
Received: from fedora.lab.9e.network (ip-078-094-000-051.um19.pools.vodafone-ip.de. [78.94.0.51])
        by smtp.gmail.com with ESMTPSA id b19sm1857940ede.37.2022.02.14.02.32.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Feb 2022 02:32:26 -0800 (PST)
From:   Patrick Rudolph <patrick.rudolph@9elements.com>
To:     Peter Rosin <peda@axentia.se>
Cc:     Patrick Rudolph <patrick.rudolph@9elements.com>,
        linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [v5 3/3] i2c: muxes: pca954x: Add regulator support
Date:   Mon, 14 Feb 2022 11:31:16 +0100
Message-Id: <20220214103116.68472-4-patrick.rudolph@9elements.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220214103116.68472-1-patrick.rudolph@9elements.com>
References: <20220214103116.68472-1-patrick.rudolph@9elements.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a vdd regulator and enable it for boards that have the
mux powered off by default.

Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
---
 drivers/i2c/muxes/i2c-mux-pca954x.c | 34 ++++++++++++++++++++++++-----
 1 file changed, 29 insertions(+), 5 deletions(-)

diff --git a/drivers/i2c/muxes/i2c-mux-pca954x.c b/drivers/i2c/muxes/i2c-mux-pca954x.c
index 33b9a6a1fffa..e25383752616 100644
--- a/drivers/i2c/muxes/i2c-mux-pca954x.c
+++ b/drivers/i2c/muxes/i2c-mux-pca954x.c
@@ -49,6 +49,7 @@
 #include <linux/module.h>
 #include <linux/pm.h>
 #include <linux/property.h>
+#include <linux/regulator/consumer.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
 #include <dt-bindings/mux/mux.h>
@@ -119,6 +120,7 @@ struct pca954x {
 	struct irq_domain *irq;
 	unsigned int irq_mask;
 	raw_spinlock_t lock;
+	struct regulator *supply;
 };
 
 /* Provide specs for the PCA954x and MAX735x types we know about */
@@ -459,6 +461,9 @@ static void pca954x_cleanup(struct i2c_mux_core *muxc)
 	struct pca954x *data = i2c_mux_priv(muxc);
 	int c, irq;
 
+	if (!IS_ERR_OR_NULL(data->supply))
+		regulator_disable(data->supply);
+
 	if (data->irq) {
 		for (c = 0; c < data->chip->nchans; c++) {
 			irq = irq_find_mapping(data->irq, c);
@@ -513,15 +518,32 @@ static int pca954x_probe(struct i2c_client *client,
 			     pca954x_select_chan, pca954x_deselect_mux);
 	if (!muxc)
 		return -ENOMEM;
+
 	data = i2c_mux_priv(muxc);
 
 	i2c_set_clientdata(client, muxc);
 	data->client = client;
 
+	data->supply = devm_regulator_get(dev, "vdd");
+	if (IS_ERR(data->supply)) {
+		ret = PTR_ERR(data->supply);
+		if (ret != -EPROBE_DEFER)
+			dev_err(dev, "Failed to request regulator: %d\n", ret);
+		return ret;
+	}
+
+	ret = regulator_enable(data->supply);
+	if (ret) {
+		dev_err(dev, "Failed to enable regulator: %d\n", ret);
+		return ret;
+	}
+
 	/* Reset the mux if a reset GPIO is specified. */
 	gpio = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_HIGH);
-	if (IS_ERR(gpio))
-		return PTR_ERR(gpio);
+	if (IS_ERR(gpio)) {
+		ret = PTR_ERR(gpio);
+		goto fail_cleanup;
+	}
 	if (gpio) {
 		udelay(1);
 		gpiod_set_value_cansleep(gpio, 0);
@@ -538,7 +560,7 @@ static int pca954x_probe(struct i2c_client *client,
 
 		ret = i2c_get_device_id(client, &id);
 		if (ret && ret != -EOPNOTSUPP)
-			return ret;
+			goto fail_cleanup;
 
 		if (!ret &&
 		    (id.manufacturer_id != data->chip->id.manufacturer_id ||
@@ -546,7 +568,8 @@ static int pca954x_probe(struct i2c_client *client,
 			dev_warn(dev, "unexpected device id %03x-%03x-%x\n",
 				 id.manufacturer_id, id.part_id,
 				 id.die_revision);
-			return -ENODEV;
+			ret = -ENODEV;
+			goto fail_cleanup;
 		}
 	}
 
@@ -565,7 +588,8 @@ static int pca954x_probe(struct i2c_client *client,
 	ret = pca954x_init(client, data);
 	if (ret < 0) {
 		dev_warn(dev, "probe failed\n");
-		return -ENODEV;
+		ret = -ENODEV;
+		goto fail_cleanup;
 	}
 
 	ret = pca954x_irq_setup(muxc);
-- 
2.34.1

