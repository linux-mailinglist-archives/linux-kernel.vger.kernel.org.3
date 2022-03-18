Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9218B4DD512
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 08:09:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232941AbiCRHKh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 03:10:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230269AbiCRHKe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 03:10:34 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FC35222A6;
        Fri, 18 Mar 2022 00:09:16 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id z66so6150867qke.10;
        Fri, 18 Mar 2022 00:09:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oisiYBwgNe77NYhtZp8TE9csHemqrDrXVik9thaoeSs=;
        b=lDS9sTbAi2rvVxc/T+ptjJaKEJkFmYlaYuJhtpmrMcYNoMKRrPyUTOT+wXHXYriTix
         mg1LAXbGYr6nYlP34ER5Cg3KdkbqdCnSnSFPEKOXIbcPhWJl9sANrptHvR/Oslcn/0yr
         41qB1nc7EWl900TWKkaceLmCGBl3Gjl22EpJLL4mlqfWuHzli8ZutCFFoZlm5D0DTKxR
         VdzGFdntFWZ+uNn0Db0pysbK/nDD/zosDIM+mlFvYpbwfHzue/Du0cj6gHA/dyPN8/Qq
         Sw4t6UElOQDn7aW4yoqKq7Al5qrk8DXgkRMwuryJB9iSJrGhj2MvOQEdC5yzAMA9zHZQ
         ETQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oisiYBwgNe77NYhtZp8TE9csHemqrDrXVik9thaoeSs=;
        b=CHwqb9+Y0h/b1cj0qNX2PDY4IfMsCP7BS0D2vP0Ila2MzwbZdf3Jge+x9hqnxyA3C2
         TYydnRAFYd0R8Um40UGgGf1/oJl61FqqgO6Njmts5/F0RFe0FGbBkBxbveSAreFxp69g
         GuZLvkN2qnCe7YEd4FmAOmBCOsrzUvLQ+7YWGcYuSvnohxo7XNa7DReAFjtB8n/oG4Gw
         hHI/R0gv9mlZBi63m5C53NbUu04fZR3TxvI/WBWTjhhaX3W5CxFev2TvDfiJVICLC5Tc
         dmQrkElu2J3kjDzVyLOHBvx1Xn0qqzuepOSkNqr4pBj2SuDxcEZSEPbgTrNcCCNk5idK
         254g==
X-Gm-Message-State: AOAM5302DLifb1EXfRfytcTKnhz18cg4tN2uwNlpo7kZ6O1agaS/P31G
        czB22hN9z/b8bmIrx4eDB6s=
X-Google-Smtp-Source: ABdhPJz1NasfkBgDNZQy7NDmoLCJsUhMtZza6VpbOiXN44LcFwMBbkgOB4S7okVmQAgDzvYELtVseA==
X-Received: by 2002:a05:620a:4493:b0:67b:1ead:13b8 with SMTP id x19-20020a05620a449300b0067b1ead13b8mr5011387qkp.716.1647587355584;
        Fri, 18 Mar 2022 00:09:15 -0700 (PDT)
Received: from tong-desktop.local (99-105-211-126.lightspeed.sntcca.sbcglobal.net. [99.105.211.126])
        by smtp.googlemail.com with ESMTPSA id d6-20020ac85d86000000b002e1e20444b6sm5248731qtx.57.2022.03.18.00.09.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Mar 2022 00:09:15 -0700 (PDT)
From:   Tong Zhang <ztong0001@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Tong Zhang <ztong0001@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Alexandru Ardelean <ardeleanalex@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jonathan Albrieux <jonathan.albrieux@gmail.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] iio:imu:bmi160: disable regulator in error path
Date:   Fri, 18 Mar 2022 00:09:00 -0700
Message-Id: <20220318070900.2499370-1-ztong0001@gmail.com>
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

regulator should be disabled in error path as mentioned in _regulator_put()

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
 drivers/iio/imu/bmi160/bmi160_core.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/imu/bmi160/bmi160_core.c b/drivers/iio/imu/bmi160/bmi160_core.c
index 824b5124a5f5..f12446edb5ce 100644
--- a/drivers/iio/imu/bmi160/bmi160_core.c
+++ b/drivers/iio/imu/bmi160/bmi160_core.c
@@ -730,7 +730,7 @@ static int bmi160_chip_init(struct bmi160_data *data, bool use_spi)
 
 	ret = regmap_write(data->regmap, BMI160_REG_CMD, BMI160_CMD_SOFTRESET);
 	if (ret)
-		return ret;
+		goto disable_regulator;
 
 	usleep_range(BMI160_SOFTRESET_USLEEP, BMI160_SOFTRESET_USLEEP + 1);
 
@@ -741,29 +741,34 @@ static int bmi160_chip_init(struct bmi160_data *data, bool use_spi)
 	if (use_spi) {
 		ret = regmap_read(data->regmap, BMI160_REG_DUMMY, &val);
 		if (ret)
-			return ret;
+		goto disable_regulator;
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
+		goto disable_regulator;
 
 	return 0;
+
+disable_regulator:
+	regulator_bulk_disable(ARRAY_SIZE(data->supplies), data->supplies);
+	return ret;
 }
 
 static int bmi160_data_rdy_trigger_set_state(struct iio_trigger *trig,
-- 
2.25.1

