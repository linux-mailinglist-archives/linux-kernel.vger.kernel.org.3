Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6641526518
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 16:46:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381295AbiEMOpV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 10:45:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381840AbiEMOlX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 10:41:23 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBD5D1BA8C2;
        Fri, 13 May 2022 07:35:24 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id j10-20020a17090a94ca00b001dd2131159aso11036984pjw.0;
        Fri, 13 May 2022 07:35:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vHHqtzMVlHfYcU1U8QOow9ihTtqg81EMmNGRPSLtClk=;
        b=lW6JuU4F569aT6xpHtRRuo1Ok8OC6O0nynwFQ5TpDqx6lJdEp9Wdgdd2Gp/eBGWRsO
         imyenh+44frXfEyCijqT6ex41NKNLbZZap2Q8gUDQjtbohmWDLq6bHQoC7VCyvKANla3
         7XrmMSjt3gWXtNymStECijYnFx9G7CAVSXX33glrwodUmg+CgfigMfe9/gEOF90K931p
         nx4U34qK5lkljSzPiGvJXoO9GinypmYSHpHQCdJgYd5+SU6yIhumiC6yM1Q6ZdX9Qdtq
         jkGmzOmpc76CjQHlrUnYEY9ef2Xe3qs0JenN2+tNKRZVVCutZZPTMoI27zrK6MfUpRzN
         nD5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vHHqtzMVlHfYcU1U8QOow9ihTtqg81EMmNGRPSLtClk=;
        b=A+w2M9s2NkWxuhENB+81QZvWUm1FL3owzzFLPsYY3VkC+O+N+JLM7MfKCa3saG9ba3
         +YpHuT8Q0pYOpftm1UAhyq1oGWqX3Ydp6/0LnNfLDG7nWpn2Ff2IBaA7HtJDZw2pgoYw
         armpya9JZS+yeX7Bk5D1BGJAEt7kGkro+wL73T7YhfT1VmUrxiNHpe1PGlV5PoLo1BK9
         lAcPfR0sSKwOWpx93PIWP9VdbWRbPSMTmHYhwXl+kmzeicUC54AM6wLkUAorNR3kZTK0
         8ApC4aU7+unU/rFmM2MK2vFN/Vmidl9X85Qf/OTJt2ev26UK2ZOYSO+xdIPxAEAcJOHe
         Ni5Q==
X-Gm-Message-State: AOAM532rsXedAnzCIXZqb3sCDsjSZ5ntY32BTGGJ0hHe3lI3PlAG3XsA
        F2PJ2Iece5IzdCdyhRk/HADvUUEJGnEfK74=
X-Google-Smtp-Source: ABdhPJw0pa5BbXPxdkcjwG5RAVOFLGCOc0pYpfw6NHdEcO6smejYUeuNW6BphUGd2i9TLXpDo7EmvA==
X-Received: by 2002:a17:902:da90:b0:15e:adc2:191d with SMTP id j16-20020a170902da9000b0015eadc2191dmr4985750plx.134.1652452524252;
        Fri, 13 May 2022 07:35:24 -0700 (PDT)
Received: from localhost.localdomain ([144.202.91.207])
        by smtp.gmail.com with ESMTPSA id b13-20020a170902e94d00b0015e8d4eb208sm1923696pll.82.2022.05.13.07.35.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 May 2022 07:35:23 -0700 (PDT)
From:   Zheyu Ma <zheyuma97@gmail.com>
To:     jic23@kernel.org, lars@metafoo.de
Cc:     andriy.shevchenko@linux.intel.com, sean@geanix.com,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Zheyu Ma <zheyuma97@gmail.com>
Subject: [PATCH] iio: imu: bmi160: Fix the error handling at bmi160_chip_init()
Date:   Fri, 13 May 2022 22:35:13 +0800
Message-Id: <20220513143513.2284425-1-zheyuma97@gmail.com>
X-Mailer: git-send-email 2.25.1
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

When the driver fails in bmi160_chip_init(), it should disable the
regulator.

The following log shows it:

[   18.709662] WARNING: CPU: 0 PID: 294 at drivers/regulator/core.c:2257 _regulator_put+0x3ec/0x4e0
[   18.712069] RIP: 0010:_regulator_put+0x3ec/0x4e0
[   18.716395] Call Trace:
[   18.716522]  <TASK>
[   18.716636]  regulator_bulk_free+0x82/0xe0
[   18.717077]  i2c_device_probe+0x6f0/0x800

Fixes: 5dea3fb066f0 ("iio: imu: bmi160: added regulator support")
Signed-off-by: Zheyu Ma <zheyuma97@gmail.com>
---
 drivers/iio/imu/bmi160/bmi160_core.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/imu/bmi160/bmi160_core.c b/drivers/iio/imu/bmi160/bmi160_core.c
index 824b5124a5f5..33abfc2bbd7c 100644
--- a/drivers/iio/imu/bmi160/bmi160_core.c
+++ b/drivers/iio/imu/bmi160/bmi160_core.c
@@ -730,7 +730,7 @@ static int bmi160_chip_init(struct bmi160_data *data, bool use_spi)
 
 	ret = regmap_write(data->regmap, BMI160_REG_CMD, BMI160_CMD_SOFTRESET);
 	if (ret)
-		return ret;
+		goto err_regulator_disable;
 
 	usleep_range(BMI160_SOFTRESET_USLEEP, BMI160_SOFTRESET_USLEEP + 1);
 
@@ -741,29 +741,34 @@ static int bmi160_chip_init(struct bmi160_data *data, bool use_spi)
 	if (use_spi) {
 		ret = regmap_read(data->regmap, BMI160_REG_DUMMY, &val);
 		if (ret)
-			return ret;
+			goto err_regulator_disable;
 	}
 
 	ret = regmap_read(data->regmap, BMI160_REG_CHIP_ID, &val);
 	if (ret) {
 		dev_err(dev, "Error reading chip id\n");
-		return ret;
+		goto err_regulator_disable;
 	}
 	if (val != BMI160_CHIP_ID_VAL) {
 		dev_err(dev, "Wrong chip id, got %x expected %x\n",
 			val, BMI160_CHIP_ID_VAL);
-		return -ENODEV;
+		ret = -ENODEV;
+		goto err_regulator_disable;
 	}
 
 	ret = bmi160_set_mode(data, BMI160_ACCEL, true);
 	if (ret)
-		return ret;
+		goto err_regulator_disable;
 
 	ret = bmi160_set_mode(data, BMI160_GYRO, true);
 	if (ret)
-		return ret;
+		goto err_regulator_disable;
 
 	return 0;
+
+err_regulator_disable:
+	regulator_bulk_disable(ARRAY_SIZE(data->supplies), data->supplies);
+	return ret;
 }
 
 static int bmi160_data_rdy_trigger_set_state(struct iio_trigger *trig,
-- 
2.25.1

