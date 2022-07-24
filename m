Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 443AD57F607
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Jul 2022 18:45:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232446AbiGXQpO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Jul 2022 12:45:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230527AbiGXQpJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jul 2022 12:45:09 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72844E90;
        Sun, 24 Jul 2022 09:45:08 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id w15so6720416lft.11;
        Sun, 24 Jul 2022 09:45:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=piU2ivBsnNtcsLTjxP/dpeo6z5lmoVvScdIkqf0BkWI=;
        b=auNQZF/an+PDImQvOPiO4TqaVFC7oBQYtcXCq6XxRhPVe452zqVxnmWgS4DBecUZ2W
         q7XxdUuOPyOZJgqy8mGvZcrVzOG3Ucnk/gXVmW6/xZl4EYUPqFEF2DAiNlHYg+6vk+HR
         x7zE2UdLY2bguQFEIs3PkFpPSdkVQsh1KSbcHhdym6OuyVKF3hjv6KXwRGLFnEILK3eC
         YoIRMYE9S56qNgUpIK4np8Z0EI2BvYfaudR88vSTrtPwNabBoBE9i6ZuBtaTszJMbCFr
         adzPmIT8BqW3Zme8rai6F5UFhumFmvoOQYrIgtzHdoT5bOg6YMZCZrmjsdFrMF3nSoAH
         UbiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=piU2ivBsnNtcsLTjxP/dpeo6z5lmoVvScdIkqf0BkWI=;
        b=j4VOd8B4jQ3ZBLHTt7PEES9qmHYQ0hzRe9c6QDIR//G0l7gt6BV78WMpWQsvXSHG1M
         B8vV/fClQrT/pIZSJvzpvnkh6U9dz5cIQP/PS5lIpjDyqMsGeplc/nszPT4DcIL2NFRX
         cCo9pa9M+CVKOn5uGBb2NrDy+PWIXYJVTIiORYT97Eethl9Mu4EJGWi3TjdZGC/0P69v
         G98I2IkMoeIVztOqiP8f5iFXki0VwbR6IIxBDCSjIBbuT2wcQtO0bnm1S8J+VKw01Y8M
         KcfFQfa0fP/dmB6e6C+fDI68VfQLcjmwjCkg5sPtLSFM0WsJfWVIxdvX2ggz0qrq2GnZ
         Xkfg==
X-Gm-Message-State: AJIora9hDMdSirsOd8rPsrWLC42plWkpTQBLEviirP2tCyEglfecigou
        5KwvHsUAYEQRFDpMRXyTVUSK/2raWJgMdxiCXLM=
X-Google-Smtp-Source: AGRyM1sqOf09v2SDfVmzk0zkpesE31LDvjVeNV+au85QQ48tSar/SeXBaqBp9+gfK/vKoXnOb2RriQ==
X-Received: by 2002:a05:6512:3083:b0:48a:7f03:2a9d with SMTP id z3-20020a056512308300b0048a7f032a9dmr2609804lfd.383.1658681106640;
        Sun, 24 Jul 2022 09:45:06 -0700 (PDT)
Received: from i-vetokaappi.home.lan (dsl-hkibng42-5673c7-93.dhcp.inet.fi. [86.115.199.93])
        by smtp.gmail.com with ESMTPSA id k12-20020a2eb74c000000b0025d40241c1dsm2267566ljo.6.2022.07.24.09.45.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Jul 2022 09:45:06 -0700 (PDT)
From:   =?UTF-8?q?Matti=20Lehtim=C3=A4ki?= <matti.lehtimaki@gmail.com>
To:     linux-iio@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht,
        =?UTF-8?q?Matti=20Lehtim=C3=A4ki?= <matti.lehtimaki@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Cai Huoqing <cai.huoqing@linux.dev>,
        Alexandru Ardelean <aardelean@deviqon.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] iio: st_sensors: Fix null pointer on defer_probe error
Date:   Sun, 24 Jul 2022 19:43:16 +0300
Message-Id: <20220724164316.68393-2-matti.lehtimaki@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220724164316.68393-1-matti.lehtimaki@gmail.com>
References: <20220724164316.68393-1-matti.lehtimaki@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

dev_err_probe() calls __device_set_deferred_probe_reason()
on -EPROBE_DEFER error. The device pointer to driver core private
structure is not yet initialized at this stage for the iio device causing
a null pointer error. Use parent device instead.

Fixes: 4dff75487695 ("iio: st_sensors: Make use of the helper function dev_err_probe()")
Signed-off-by: Matti Lehtimäki <matti.lehtimaki@gmail.com>
---
 drivers/iio/common/st_sensors/st_sensors_core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/common/st_sensors/st_sensors_core.c b/drivers/iio/common/st_sensors/st_sensors_core.c
index 106f7953683e..575607058291 100644
--- a/drivers/iio/common/st_sensors/st_sensors_core.c
+++ b/drivers/iio/common/st_sensors/st_sensors_core.c
@@ -235,7 +235,7 @@ int st_sensors_power_enable(struct iio_dev *indio_dev)
 	/* Regulators not mandatory, but if requested we should enable them. */
 	pdata->vdd = devm_regulator_get(parent, "vdd");
 	if (IS_ERR(pdata->vdd))
-		return dev_err_probe(&indio_dev->dev, PTR_ERR(pdata->vdd),
+		return dev_err_probe(indio_dev->dev.parent, PTR_ERR(pdata->vdd),
 				     "unable to get Vdd supply\n");
 
 	err = regulator_enable(pdata->vdd);
@@ -251,7 +251,7 @@ int st_sensors_power_enable(struct iio_dev *indio_dev)
 
 	pdata->vdd_io = devm_regulator_get(parent, "vddio");
 	if (IS_ERR(pdata->vdd_io))
-		return dev_err_probe(&indio_dev->dev, PTR_ERR(pdata->vdd_io),
+		return dev_err_probe(indio_dev->dev.parent, PTR_ERR(pdata->vdd_io),
 				     "unable to get Vdd_IO supply\n");
 
 	err = regulator_enable(pdata->vdd_io);
-- 
2.34.1

