Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 225DA53EF74
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 22:20:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233845AbiFFUTp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 16:19:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233932AbiFFUT0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 16:19:26 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04DA36006C
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 13:19:18 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id w3so12981378plp.13
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jun 2022 13:19:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZKgchf40btIWK1MuQdpSZKSX/1eMrpvBCXeKfQlCM0c=;
        b=WIF/p78dmBucCD0VYMMYwKH70nOq+zaDIaCJ9LAtoPv7eyKdRy1BUM3j0la302RRwq
         6wyWClM9UTgpMIw6Mz8dmt2D8JkhWGjZ8G6JqvaDw+gE1uU3RgCZ8J4CGoNsgiAoA1Y9
         Vfm59OXc8URyJKD85J5Y7oGWiuO+4rvvGKpSo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZKgchf40btIWK1MuQdpSZKSX/1eMrpvBCXeKfQlCM0c=;
        b=eLWdj3ZL1acg+fwceoUdevA1k6WPMO57mX7BWAkJLVwaz8UbFHCy6TKKWKsvWU7p6G
         3dnjmb7C3OKbdUi1RFtRaDLrP80wTRY4BKKTLC56dgPu/upBAM0z8Up58urfbl+7LfSS
         JM1yOAR7mOxRd7fw7q+F7Cj5X5AxxlTFa5rS0FloOEWzkzE+g49RrYVdq0L12oXzqWxm
         4E7zWGIAccWxGokBxP4iWZQ8lSd0zAViyXLhJvhrRMHdDGpQm82tdnaEQdAKcmoII/nz
         ClUEvtxJuSPJ61AKzT4XZQWubKIa8MBOg/6eh462/lPSWKLyPsrR6WHX97NjzZgcZoam
         tarw==
X-Gm-Message-State: AOAM531FZUh5vLTHpNq3L2wznVQIH2DCRA1TZblcQSHP3tCtpHZ3Lb+G
        T5MI6mEMS9KbsB7aOzG86CcASLGqHPp7ImR/
X-Google-Smtp-Source: ABdhPJxkHiVN6DgKpmKwdRRTwjOWWrpuGHZS40T6pGHkSBA3jBQUl/2ZcAn9I2rENu2BRz+Bn+qKbQ==
X-Received: by 2002:a17:902:f60e:b0:158:5c4d:d9b0 with SMTP id n14-20020a170902f60e00b001585c4dd9b0mr26200738plg.63.1654546758051;
        Mon, 06 Jun 2022 13:19:18 -0700 (PDT)
Received: from pmalani.c.googlers.com.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id l5-20020a170902d34500b0015ef27092aasm10883034plk.190.2022.06.06.13.19.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jun 2022 13:19:17 -0700 (PDT)
From:   Prashant Malani <pmalani@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     bleung@chromium.org, Prashant Malani <pmalani@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        chrome-platform@lists.linux.dev (open list:CHROME HARDWARE PLATFORM
        SUPPORT), Daisuke Nojiri <dnojiri@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        Lee Jones <lee.jones@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Tzung-Bi Shih <tzungbi@kernel.org>
Subject: [PATCH 1/3] regulator: cros-ec: Use common cros_ec_command()
Date:   Mon,  6 Jun 2022 20:18:01 +0000
Message-Id: <20220606201825.763788-2-pmalani@chromium.org>
X-Mailer: git-send-email 2.36.1.255.ge46751e96f-goog
In-Reply-To: <20220606201825.763788-1-pmalani@chromium.org>
References: <20220606201825.763788-1-pmalani@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reduce code duplication by using the common cros_ec_command() function
instead of the locally defined variant.

Cc: Stephen Boyd <swboyd@chromium.org>
Signed-off-by: Prashant Malani <pmalani@chromium.org>
---
 drivers/regulator/cros-ec-regulator.c | 54 ++++++---------------------
 1 file changed, 12 insertions(+), 42 deletions(-)

diff --git a/drivers/regulator/cros-ec-regulator.c b/drivers/regulator/cros-ec-regulator.c
index c4754f3cf233..1c5fc74a4776 100644
--- a/drivers/regulator/cros-ec-regulator.c
+++ b/drivers/regulator/cros-ec-regulator.c
@@ -22,36 +22,6 @@ struct cros_ec_regulator_data {
 	u16 num_voltages;
 };
 
-static int cros_ec_cmd(struct cros_ec_device *ec, u32 version, u32 command,
-		       void *outdata, u32 outsize, void *indata, u32 insize)
-{
-	struct cros_ec_command *msg;
-	int ret;
-
-	msg = kzalloc(sizeof(*msg) + max(outsize, insize), GFP_KERNEL);
-	if (!msg)
-		return -ENOMEM;
-
-	msg->version = version;
-	msg->command = command;
-	msg->outsize = outsize;
-	msg->insize = insize;
-
-	if (outdata && outsize > 0)
-		memcpy(msg->data, outdata, outsize);
-
-	ret = cros_ec_cmd_xfer_status(ec, msg);
-	if (ret < 0)
-		goto cleanup;
-
-	if (insize)
-		memcpy(indata, msg->data, insize);
-
-cleanup:
-	kfree(msg);
-	return ret;
-}
-
 static int cros_ec_regulator_enable(struct regulator_dev *dev)
 {
 	struct cros_ec_regulator_data *data = rdev_get_drvdata(dev);
@@ -60,8 +30,8 @@ static int cros_ec_regulator_enable(struct regulator_dev *dev)
 		.enable = 1,
 	};
 
-	return cros_ec_cmd(data->ec_dev, 0, EC_CMD_REGULATOR_ENABLE, &cmd,
-			  sizeof(cmd), NULL, 0);
+	return cros_ec_command(data->ec_dev, 0, EC_CMD_REGULATOR_ENABLE, &cmd,
+			       sizeof(cmd), NULL, 0);
 }
 
 static int cros_ec_regulator_disable(struct regulator_dev *dev)
@@ -72,8 +42,8 @@ static int cros_ec_regulator_disable(struct regulator_dev *dev)
 		.enable = 0,
 	};
 
-	return cros_ec_cmd(data->ec_dev, 0, EC_CMD_REGULATOR_ENABLE, &cmd,
-			  sizeof(cmd), NULL, 0);
+	return cros_ec_command(data->ec_dev, 0, EC_CMD_REGULATOR_ENABLE, &cmd,
+			       sizeof(cmd), NULL, 0);
 }
 
 static int cros_ec_regulator_is_enabled(struct regulator_dev *dev)
@@ -85,8 +55,8 @@ static int cros_ec_regulator_is_enabled(struct regulator_dev *dev)
 	struct ec_response_regulator_is_enabled resp;
 	int ret;
 
-	ret = cros_ec_cmd(data->ec_dev, 0, EC_CMD_REGULATOR_IS_ENABLED, &cmd,
-			  sizeof(cmd), &resp, sizeof(resp));
+	ret = cros_ec_command(data->ec_dev, 0, EC_CMD_REGULATOR_IS_ENABLED, &cmd,
+			      sizeof(cmd), &resp, sizeof(resp));
 	if (ret < 0)
 		return ret;
 	return resp.enabled;
@@ -112,8 +82,8 @@ static int cros_ec_regulator_get_voltage(struct regulator_dev *dev)
 	struct ec_response_regulator_get_voltage resp;
 	int ret;
 
-	ret = cros_ec_cmd(data->ec_dev, 0, EC_CMD_REGULATOR_GET_VOLTAGE, &cmd,
-			  sizeof(cmd), &resp, sizeof(resp));
+	ret = cros_ec_command(data->ec_dev, 0, EC_CMD_REGULATOR_GET_VOLTAGE, &cmd,
+			      sizeof(cmd), &resp, sizeof(resp));
 	if (ret < 0)
 		return ret;
 	return resp.voltage_mv * 1000;
@@ -138,8 +108,8 @@ static int cros_ec_regulator_set_voltage(struct regulator_dev *dev, int min_uV,
 	if (min_mV > max_mV)
 		return -EINVAL;
 
-	return cros_ec_cmd(data->ec_dev, 0, EC_CMD_REGULATOR_SET_VOLTAGE, &cmd,
-			   sizeof(cmd), NULL, 0);
+	return cros_ec_command(data->ec_dev, 0, EC_CMD_REGULATOR_SET_VOLTAGE, &cmd,
+			       sizeof(cmd), NULL, 0);
 }
 
 static const struct regulator_ops cros_ec_regulator_voltage_ops = {
@@ -160,8 +130,8 @@ static int cros_ec_regulator_init_info(struct device *dev,
 	struct ec_response_regulator_get_info resp;
 	int ret;
 
-	ret = cros_ec_cmd(data->ec_dev, 0, EC_CMD_REGULATOR_GET_INFO, &cmd,
-			   sizeof(cmd), &resp, sizeof(resp));
+	ret = cros_ec_command(data->ec_dev, 0, EC_CMD_REGULATOR_GET_INFO, &cmd,
+			      sizeof(cmd), &resp, sizeof(resp));
 	if (ret < 0)
 		return ret;
 
-- 
2.36.1.255.ge46751e96f-goog

