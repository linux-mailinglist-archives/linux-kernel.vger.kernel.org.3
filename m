Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12D384DEA6F
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Mar 2022 20:36:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244053AbiCSTh1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Mar 2022 15:37:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235161AbiCSThZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Mar 2022 15:37:25 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1596F1D252B;
        Sat, 19 Mar 2022 12:36:04 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id w4so9570386ply.13;
        Sat, 19 Mar 2022 12:36:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=UZ8U6h8DbGRSowut/xQcVmgxYs4UO4w60NsB+ZlwYpc=;
        b=X/4yx7XnyS372SqqpkOAO79MH5PGnC+hNb0Gg1WJsUcJU4TizrIB6G/+EIN54aZsS2
         qSsvcQLiE5/vFB4wQHDUpmKz3nq02ccDChUSDoFHNbup691+J3iMMAQsB62OQfWyk46u
         plOWYsgrnmOv/tTCtD3IixWCNroI+c6PSWvTJXvJK2peFb2QOCFkt4sYHPWnyiETZDQL
         yttO2z6Ir9LmVDWbY1WiVf3neKpugaRW38nwpqcuWyTIzWadrMnz6YmyuwOicddadngM
         COoT2yQlYrWAIRUNrQRmvCchDntpYOYkj+EqK0/NLYPtFjBJ3tYgwq8L5onQE6g7beoC
         d//w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UZ8U6h8DbGRSowut/xQcVmgxYs4UO4w60NsB+ZlwYpc=;
        b=59WuourGPD3gCKLjN9a00mbcN39/T6aA6n3msrCB0sH76ymoYBQfXfHE2FP98vjc/6
         EoQrN1m6ueiVEtuk1Kedj2uQxxm0NA0HGe1N3vvpH2n4z/jFIsbMQOcAmlDp9J3j+kQ/
         k5pRGDVs63InengMKYow4qS4enn3lzyAltI9YSviDOG31534R6+3tmynQkMJyDRB/H5o
         MGX75G+/Rk/qmJ/ZHEmp1h5G1GWzqkyRao4E0Y25qBLTNHtm75ojOnlKc1i8YUMkubna
         dOLilXmoGU1c0J0K4t04Ojy8mw+ZH+MuQ1MX794TczN3EfN1cflS2ZrDSElor7S64EFW
         OHeA==
X-Gm-Message-State: AOAM532HWPEUnkWxz3DTlWzOA7fxhKoRVSq6njaWfvMmstNapVFSpNMF
        S6M7La+vz9zIKFDcCKOfIhI=
X-Google-Smtp-Source: ABdhPJxAAK0TanabZZwrJJwhIb1Cz9voeTGC0qqXCJn/eolwa5uo0iTNCFoEdenHuC1Sxg16gEQWFw==
X-Received: by 2002:a17:90b:1bc5:b0:1bf:1c96:66ac with SMTP id oa5-20020a17090b1bc500b001bf1c9666acmr28283602pjb.167.1647718562821;
        Sat, 19 Mar 2022 12:36:02 -0700 (PDT)
Received: from tong-desktop.local (99-105-211-126.lightspeed.sntcca.sbcglobal.net. [99.105.211.126])
        by smtp.googlemail.com with ESMTPSA id y12-20020a17090a784c00b001c6bdafc995sm5154425pjl.3.2022.03.19.12.36.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Mar 2022 12:36:02 -0700 (PDT)
From:   Tong Zhang <ztong0001@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Sean Nyekjaer <sean@geanix.com>,
        Alexandru Ardelean <ardeleanalex@gmail.com>,
        Tong Zhang <ztong0001@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jonathan Albrieux <jonathan.albrieux@gmail.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] iio:imu:bmi160: disable regulator in error path
Date:   Sat, 19 Mar 2022 12:34:59 -0700
Message-Id: <20220319193459.2628876-1-ztong0001@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220319162006.13c60c1f@jic23-huawei>
References: <20220319162006.13c60c1f@jic23-huawei>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Regulator should be disabled in error path as mentioned in _regulator_put().
Also disable accel if gyro cannot be enabled.

[   16.233604] WARNING: CPU: 0 PID: 2177 at drivers/regulator/core.c:2257 _regulator_put
[   16.240453] Call Trace:
[   16.240572]  <TASK>
[   16.240676]  regulator_put+0x26/0x40
[   16.240853]  regulator_bulk_free+0x26/0x50
[   16.241050]  release_nodes+0x3f/0x70
[   16.241225]  devres_release_group+0x147/0x1c0
[   16.241441]  ? bmi160_core_probe+0x175/0x3a0 [bmi160_core]

Fixes: 5dea3fb066f0 ("iio: imu: bmi160: added regulator support")
Signed-off-by: Tong Zhang <ztong0001@gmail.com>
---
v2: also disable accel when gyro fail to enable

 drivers/iio/imu/bmi160/bmi160_core.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/imu/bmi160/bmi160_core.c b/drivers/iio/imu/bmi160/bmi160_core.c
index 824b5124a5f5..01336105792e 100644
--- a/drivers/iio/imu/bmi160/bmi160_core.c
+++ b/drivers/iio/imu/bmi160/bmi160_core.c
@@ -730,7 +730,7 @@ static int bmi160_chip_init(struct bmi160_data *data, bool use_spi)
 
 	ret = regmap_write(data->regmap, BMI160_REG_CMD, BMI160_CMD_SOFTRESET);
 	if (ret)
-		return ret;
+		goto disable_regulator;
 
 	usleep_range(BMI160_SOFTRESET_USLEEP, BMI160_SOFTRESET_USLEEP + 1);
 
@@ -741,29 +741,37 @@ static int bmi160_chip_init(struct bmi160_data *data, bool use_spi)
 	if (use_spi) {
 		ret = regmap_read(data->regmap, BMI160_REG_DUMMY, &val);
 		if (ret)
-			return ret;
+			goto disable_regulator;
 	}
 
 	ret = regmap_read(data->regmap, BMI160_REG_CHIP_ID, &val);
 	if (ret) {
 		dev_err(dev, "Error reading chip id\n");
-		return ret;
+		goto disable_regulator;
 	}
 	if (val != BMI160_CHIP_ID_VAL) {
 		dev_err(dev, "Wrong chip id, got %x expected %x\n",
 			val, BMI160_CHIP_ID_VAL);
-		return -ENODEV;
+		ret = -ENODEV;
+		goto disable_regulator;
 	}
 
 	ret = bmi160_set_mode(data, BMI160_ACCEL, true);
 	if (ret)
-		return ret;
+		goto disable_regulator;
 
 	ret = bmi160_set_mode(data, BMI160_GYRO, true);
 	if (ret)
-		return ret;
+		goto disable_accel;
 
 	return 0;
+
+disable_accel:
+	bmi160_set_mode(data, BMI160_ACCEL, false);
+
+disable_regulator:
+	regulator_bulk_disable(ARRAY_SIZE(data->supplies), data->supplies);
+	return ret;
 }
 
 static int bmi160_data_rdy_trigger_set_state(struct iio_trigger *trig,
-- 
2.25.1

