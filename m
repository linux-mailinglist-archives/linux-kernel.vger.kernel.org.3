Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15B824E8879
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Mar 2022 17:40:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235876AbiC0PmM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Mar 2022 11:42:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232094AbiC0PmJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Mar 2022 11:42:09 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01F92340C9;
        Sun, 27 Mar 2022 08:40:31 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id o68-20020a17090a0a4a00b001c686a48263so10130525pjo.1;
        Sun, 27 Mar 2022 08:40:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=kreZfOtcisOTnml8W90tAIXoUjRu/s5AG1dtKzhwH84=;
        b=fWXHJ6At+IMlrusJiEsKH2IDCPezbhS3cXGdZJ3wn1pe5b73ZbnMYDbBr72Ca20A6n
         gASapkrcj4KGZd5hCqlgWMQGEXyiyZj2K1pv+qm7bH9bGvPG3Ob2dmiTaANY3SP0dhAs
         90QfVq09RXfVYNfj2D3SI1T+prenczoZBdYgmy9jVe23k6sB/7ndxMsuxOSRKeDVZfNL
         44/p5L9t35GdG0FoMUJSyUrpqtHugpnIoafAtj2K28DtFE29G6e98RexMUjR2MoTn7tt
         g4KZ+C6hkWzSKjSvk+r61pkP96FObwE0UhZY+oWlmz+l+XVi+m6mEKJhBkhKd1LWlHHA
         xcpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kreZfOtcisOTnml8W90tAIXoUjRu/s5AG1dtKzhwH84=;
        b=kYebGLUWUeBK9/tTInrOP4/lKx5cnEsF9gM/D3KYLy6ZHdaLlskYZEd3tne6fxCePZ
         CbcMKGuDvaj4WojumQcBNUxAwu52Z7fp2HA9OY6m4LC2QCWbIbyIa1NNqTJ11CtAImt7
         D9KoA+a9p53mO/GEhGprYFxLM5BveymrSpmVqErF4Wy5qM13Hyjmva560sPMXb0PFtX7
         ZQUi3bkDcK4AXggxcQLg7MvUyoSmKh0cftmLeNYiCzlmB+T/BtmXJ0VYlM7m8UCn4tqh
         qiFjj+iMgbSIi0Na0HCrr4XfOxlSWrX3bE0K+jtZVSdqk2AzTEUgd/XE5VXUtBRelWQY
         d1HQ==
X-Gm-Message-State: AOAM531DYTuqrOLJefyj5Zm1HUvHqPsln/+O2MH31GYDUW39CPVtXtHq
        LMHmOvYQ3MKDbdRoXKqVnYE=
X-Google-Smtp-Source: ABdhPJzPDAM7vgFyjcWLVVVz+TIZCH4/oqTss580KSxoKXccxa3B/WC/PLFd3YtqY64z+IliQbYV/Q==
X-Received: by 2002:a17:902:9008:b0:14f:b1f9:5271 with SMTP id a8-20020a170902900800b0014fb1f95271mr21502345plp.86.1648395630347;
        Sun, 27 Mar 2022 08:40:30 -0700 (PDT)
Received: from tong-desktop.local ([2600:1700:3ec7:421f:a2f1:f139:4101:142a])
        by smtp.googlemail.com with ESMTPSA id o65-20020a17090a0a4700b001bef5cffea7sm13331959pjo.0.2022.03.27.08.40.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Mar 2022 08:40:29 -0700 (PDT)
From:   Tong Zhang <ztong0001@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Tong Zhang <ztong0001@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Sean Nyekjaer <sean@geanix.com>,
        Alexandru Ardelean <ardeleanalex@gmail.com>,
        Jonathan Albrieux <jonathan.albrieux@gmail.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3] iio:imu:bmi160: disable regulator in error path
Date:   Sun, 27 Mar 2022 08:40:05 -0700
Message-Id: <20220327154005.806049-1-ztong0001@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220318070900.2499370-1-ztong0001@gmail.com>
References: <20220318070900.2499370-1-ztong0001@gmail.com>
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
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Tong Zhang <ztong0001@gmail.com>
---
v2: also disable accel when gyro fail to enable
v3: add tag
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

