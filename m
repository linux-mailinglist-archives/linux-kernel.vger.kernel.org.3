Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74F875AF6A0
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 23:09:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230461AbiIFVIn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 17:08:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230370AbiIFVIh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 17:08:37 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E2EBAF0EE;
        Tue,  6 Sep 2022 14:08:37 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id y127so12640731pfy.5;
        Tue, 06 Sep 2022 14:08:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date;
        bh=h2H5G225OB0vtcl3iFnaeBm7itj3Dn9XResMyx5kZE0=;
        b=EPocdg+47XY2JU71oMSoe4mD4VI+HHRUXu6VAQeUwzpgyhA7AaI1uZO9Owm6JWiWAj
         GV8dGx+6WWS0N6GoONYJmO+58cpl+97Q6a4ceuL5BdKD50TItrznEKlXO1VjGF+7yrtW
         INQTkUNBhYrMW6Ih7OSy9BpxKApUQOot+MyQo2sQ+vJf1Szd8Vp+AeWyPT9KWAi7qdoZ
         Ul5PWek9XR9f46s4wCAbvIO2SAXgiVFT7eE7eqXu3paB+BNBrvM6NTsCcDb9c6jKrXFA
         i3FXJPd/+D5lit+3rYSg46sm+eykpZ+2qCqnSj8D3sdY/N4raP1ys0br6u2eskR85nRC
         rtmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date;
        bh=h2H5G225OB0vtcl3iFnaeBm7itj3Dn9XResMyx5kZE0=;
        b=YfRDEL0uSqGtoZ/tXFTU45JZ/bkAk99/cbRVIwM3x74qiNOOEGly/v7NNJR4z6Qc6/
         n1qV+5mx2kRh18vcboj1jHKXG4zAb+1SsWZ8brTfA/F0sBp3LOTIWjoAR3j5YnomhtgH
         yxESq/+v+jpDDBNrOAfkLZg6pFDGYfnHirR4PJ6uDnUenMdWgV+J/ybcTIjMzCqGDMNo
         wOH19hHevM99w4MroRlUoR6R27blwgryHb62fLNxuN7BbXaDIIYopq+4JuD+Tkzmfx+H
         /xvpOBAi6RIVgZMk+y1VzAtxKv8MDXM+isiJBA1BuzVN3cEUaJLDQnEc82rwHCIy6L6C
         cxog==
X-Gm-Message-State: ACgBeo1kLi7DiTjBbkRv8aVoJaUgkbYKFh3U2tD+pnwHgf3Vc4xy4J7c
        ntBlxTIh31/qvD/Mpf5KQhc=
X-Google-Smtp-Source: AA6agR6Hroha8O2iUeGvH+lZoYRguJ3bLOiPDNS4eGQ3/qCjjP+NWtTSJgKgT3j9xseUNogrFX+4eg==
X-Received: by 2002:a05:6a00:99b:b0:536:754a:ab31 with SMTP id u27-20020a056a00099b00b00536754aab31mr534972pfg.45.1662498516671;
        Tue, 06 Sep 2022 14:08:36 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:abc4:5d24:5a73:a96b])
        by smtp.gmail.com with ESMTPSA id n11-20020a17090a2bcb00b001facb7bc1adsm13088376pje.26.2022.09.06.14.08.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Sep 2022 14:08:36 -0700 (PDT)
Date:   Tue, 6 Sep 2022 14:08:33 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     Suman Anna <s-anna@ti.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC/PATCH] remoteproc/keystone: switch to using gpiod API
Message-ID: <Yxe20ehiOnitDGus@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch switches the driver away from legacy gpio/of_gpio API to
gpiod API, and removes use of of_get_named_gpio_flags() which I want to
make private to gpiolib.

Note that there is a behavior change in the driver: previously the
driver did not actually request GPIO, it simply parsed GPIO number out
of device tree and poked at it.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/remoteproc/keystone_remoteproc.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/remoteproc/keystone_remoteproc.c b/drivers/remoteproc/keystone_remoteproc.c
index 594a9b43b7ae..95b39741925d 100644
--- a/drivers/remoteproc/keystone_remoteproc.c
+++ b/drivers/remoteproc/keystone_remoteproc.c
@@ -14,7 +14,7 @@
 #include <linux/workqueue.h>
 #include <linux/of_address.h>
 #include <linux/of_reserved_mem.h>
-#include <linux/of_gpio.h>
+#include <linux/gpio/consumer.h>
 #include <linux/regmap.h>
 #include <linux/mfd/syscon.h>
 #include <linux/remoteproc.h>
@@ -59,10 +59,10 @@ struct keystone_rproc {
 	int num_mems;
 	struct regmap *dev_ctrl;
 	struct reset_control *reset;
+	struct gpio_desc *kick_gpio;
 	u32 boot_offset;
 	int irq_ring;
 	int irq_fault;
-	int kick_gpio;
 	struct work_struct workqueue;
 };
 
@@ -232,10 +232,10 @@ static void keystone_rproc_kick(struct rproc *rproc, int vqid)
 {
 	struct keystone_rproc *ksproc = rproc->priv;
 
-	if (WARN_ON(ksproc->kick_gpio < 0))
+	if (!ksproc->kick_gpio)
 		return;
 
-	gpio_set_value(ksproc->kick_gpio, 1);
+	gpiod_set_value(ksproc->kick_gpio, 1);
 }
 
 /*
@@ -432,9 +432,9 @@ static int keystone_rproc_probe(struct platform_device *pdev)
 		goto disable_clk;
 	}
 
-	ksproc->kick_gpio = of_get_named_gpio_flags(np, "kick-gpios", 0, NULL);
-	if (ksproc->kick_gpio < 0) {
-		ret = ksproc->kick_gpio;
+	ksproc->kick_gpio = gpiod_get(dev, "kick", GPIOD_ASIS);
+	ret = PTR_ERR_OR_ZERO(ksproc->kick_gpio);
+	if (ret) {
 		dev_err(dev, "failed to get gpio for virtio kicks, status = %d\n",
 			ret);
 		goto disable_clk;
@@ -466,6 +466,7 @@ static int keystone_rproc_probe(struct platform_device *pdev)
 
 release_mem:
 	of_reserved_mem_device_release(dev);
+	gpiod_put(ksproc->kick_gpio);
 disable_clk:
 	pm_runtime_put_sync(dev);
 disable_rpm:
@@ -480,6 +481,7 @@ static int keystone_rproc_remove(struct platform_device *pdev)
 	struct keystone_rproc *ksproc = platform_get_drvdata(pdev);
 
 	rproc_del(ksproc->rproc);
+	gpiod_put(ksproc->kick_gpio);
 	pm_runtime_put_sync(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
 	rproc_free(ksproc->rproc);
-- 
2.37.2.789.g6183377224-goog


-- 
Dmitry
