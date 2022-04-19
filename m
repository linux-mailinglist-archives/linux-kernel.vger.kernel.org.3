Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1200506CA8
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 14:42:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352364AbiDSMoG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 08:44:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350858AbiDSMnq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 08:43:46 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4917E31928
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 05:41:03 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id 11so16055577edw.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 05:41:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CentrNXKSQFtoskGJlxUqU8zX0zrZiDPIjJai3Ha6oE=;
        b=L5qFBf76Si6AIGEi/Y74BymuYRaRImc3HJIwqI8zppZKsQCg/+5DUo9iOq5nm5vJaw
         8+vBU1vSyMTnN1kGy8+FdYZXbjR3Yh7TiC9CTvTmBfWYNcHY1++wradcfCDogj5gsVw3
         FlVb97xJDCQsVBF8tcielGJkKLEOxUnO16oePCXuO/bvC/jl8y9BqAhxWyxXUND1Pb5x
         eUXxSYCXb6K21I56FFQkuJZ7YpFXMUm52BAvQgjw/IMT/I3Y+w8oCXOlZYslW+Cb3exi
         rgFf1VKJbYsV+rveCwfGlm0zGTuV07THYyQRG4wbmG+Wov1cWAKOq4EbFOkYbTfFmP9e
         af6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CentrNXKSQFtoskGJlxUqU8zX0zrZiDPIjJai3Ha6oE=;
        b=r0a/SiLsX1N23sMwxuYbMkmQRaBDH0CnclAgm/Bc1bIe6HwN4YUvgEENXC0aT6B2lX
         VbfpmGrsADXtx6gcPXyAyMRYRRDaeLnGSCxeDWXbyf9O2c156uDXggoZ6PKLh7PJrCCP
         XeJQ4DiSv0AiMhT99kldrE/6Jd7lu0HN+SPQOgY/Dw5/G4qxBb9/pkIG0dIEj5pnpe70
         blDTCqnpingnntN9uYIXinNVW0IuI+aTHQMtThiQPCPavUJ+lX791YtQWOC0do1zH4Jz
         Hg4ASFnsE4wvUTbGjbx7OIlp2cBkWw5GZbryRp2oqXZ77iIUXKQzYsy24g9/dqXEZoU8
         xW9A==
X-Gm-Message-State: AOAM531S7Mf3XF6s5DFB/QYTn4vnuhSoqp04uEFwK/+KrzxLArLFUW8Y
        OeNU6CTOmTIbOMTB5/RY8LYc4Q==
X-Google-Smtp-Source: ABdhPJz5OZdxiHs9n1uZnwqXmik4cSgvZbFD0OtkKsGyIFzXFLI4Z4Pxf4c4NEql/zBIwVK1OVMynQ==
X-Received: by 2002:a05:6402:1908:b0:423:d634:126d with SMTP id e8-20020a056402190800b00423d634126dmr14705201edz.216.1650372061871;
        Tue, 19 Apr 2022 05:41:01 -0700 (PDT)
Received: from fedora.lab.9e.network (ip-078-094-000-051.um19.pools.vodafone-ip.de. [78.94.0.51])
        by smtp.gmail.com with ESMTPSA id n27-20020a1709062bdb00b006da975173bfsm5709274ejg.170.2022.04.19.05.41.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Apr 2022 05:41:01 -0700 (PDT)
From:   Patrick Rudolph <patrick.rudolph@9elements.com>
To:     Peter Rosin <peda@axentia.se>
Cc:     Patrick Rudolph <patrick.rudolph@9elements.com>,
        linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [v8 3/3] i2c: muxes: pca954x: Add regulator support
Date:   Tue, 19 Apr 2022 14:40:24 +0200
Message-Id: <20220419124025.1733230-4-patrick.rudolph@9elements.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220419124025.1733230-1-patrick.rudolph@9elements.com>
References: <20220419124025.1733230-1-patrick.rudolph@9elements.com>
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
Reviewed-by: Peter Rosin <peda@axentia.se>
---
 drivers/i2c/muxes/i2c-mux-pca954x.c | 34 ++++++++++++++++++++++++-----
 1 file changed, 29 insertions(+), 5 deletions(-)

diff --git a/drivers/i2c/muxes/i2c-mux-pca954x.c b/drivers/i2c/muxes/i2c-mux-pca954x.c
index 122b7a28fc60..6c43d420e349 100644
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
2.35.1

