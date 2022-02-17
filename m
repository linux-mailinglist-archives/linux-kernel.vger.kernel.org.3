Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32D454BA687
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 17:58:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243527AbiBQQ4r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 11:56:47 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243502AbiBQQ43 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 11:56:29 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC9292B3AC1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 08:56:13 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id qk11so8793333ejb.2
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 08:56:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qYQz8gky+qHKsHMYT1BO0VS7TpJLRjv0uSqSzI+TAgE=;
        b=dlrddxDbzDVUNrDPxjnn0fmRX/EXv8asQmJobbE6eGLg93BV+JOb3qtyE9hIWqJ3Pd
         tQYzpoGxJf5npBm3k4VgypdVrmFLk8fGYn6jVk7c9XQJwNVdOLxWY0lAOI4S4ToQQjKW
         8HcAqqJQov6RB+eRFZjFKdg6GnKdiy7nKwIs0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qYQz8gky+qHKsHMYT1BO0VS7TpJLRjv0uSqSzI+TAgE=;
        b=4NvDa4RJaH11c04X4/Qto4gx8/Tzbg6Eqjr5iltYOWq+ZhepoaFu6w24L0uIDmrkzk
         IaE90YO05O3TRiKOrPRpbAQkEKvRhVd+QRvdSb8VFLQRVCrOnKM3yasbVIfefB0XW1fO
         4ZRWpPMDRodd8W46trSDS+2F73wnmkQQpr6j/3laUAaNGxaLpVfgnJg80Q5uWYc9nzJF
         tzlKqyfoM/NG/FVcl13Nw4LQw6lXiM4YqGSNH8m3Vv7tB1Qa27JHJQe0ejxcD8x2t1IO
         JdFWUfmc+ngymonLoJq6zs7qCto+zr7J5We/K43mNXJvgt9tfG2ROM5fY/3kbVVwrZal
         xBPg==
X-Gm-Message-State: AOAM531nM/+E//B436apRioj2X2xyOanVFT5UIPexI8BKInwBYq58pgA
        aZkG/13hprc1wzKOGHZS7sjhRT+pocOCTA==
X-Google-Smtp-Source: ABdhPJyPXSGmnM8vcnQUMCoJo0vgIHpbH9uH2okTjPQXaZSSezf4M/eAihkkyXrjbgWTspU2mgStCw==
X-Received: by 2002:a17:907:6006:b0:6ce:46f:fe4b with SMTP id fs6-20020a170907600600b006ce046ffe4bmr2906289ejc.7.1645116971996;
        Thu, 17 Feb 2022 08:56:11 -0800 (PST)
Received: from dario-ThinkPad-T14s-Gen-2i.pdxnet.pdxeng.ch (host-87-0-15-73.retail.telecomitalia.it. [87.0.15.73])
        by smtp.gmail.com with ESMTPSA id v4sm965323ejb.72.2022.02.17.08.56.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Feb 2022 08:56:11 -0800 (PST)
From:   Dario Binacchi <dario.binacchi@amarulasolutions.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        Oliver Graute <oliver.graute@kococonnector.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Stephan Gerhold <stephan@gerhold.net>,
        linux-input@vger.kernel.org
Subject: [PATCH v2 5/6] Input: edt-ft5x06 - show firmware version by sysfs
Date:   Thu, 17 Feb 2022 17:55:57 +0100
Message-Id: <20220217165559.313366-6-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220217165559.313366-1-dario.binacchi@amarulasolutions.com>
References: <20220217165559.313366-1-dario.binacchi@amarulasolutions.com>
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

The firmware version was printed only if debug mode was enabled. Now you
can always get it from sysfs.

Co-developed-by: Michael Trimarchi <michael@amarulasolutions.com>
Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Acked-by: Oliver Graute <oliver.graute@kococonnector.com>
---

(no changes since v1)

 drivers/input/touchscreen/edt-ft5x06.c | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/drivers/input/touchscreen/edt-ft5x06.c b/drivers/input/touchscreen/edt-ft5x06.c
index eb1231d1c0b4..2c946c155108 100644
--- a/drivers/input/touchscreen/edt-ft5x06.c
+++ b/drivers/input/touchscreen/edt-ft5x06.c
@@ -129,6 +129,7 @@ struct edt_ft5x06_ts_data {
 	int max_support_points;
 
 	char name[EDT_NAME_LEN];
+	char fw_version[EDT_NAME_LEN];
 
 	struct edt_reg_addr reg_addr;
 	enum edt_ver version;
@@ -540,6 +541,17 @@ static ssize_t model_show(struct device *dev, struct device_attribute *attr,
 
 static DEVICE_ATTR_RO(model);
 
+static ssize_t fw_version_show(struct device *dev,
+			       struct device_attribute *attr, char *buf)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct edt_ft5x06_ts_data *tsdata = i2c_get_clientdata(client);
+
+	return scnprintf(buf, PAGE_SIZE, "%s\n", tsdata->fw_version);
+}
+
+static DEVICE_ATTR_RO(fw_version);
+
 static struct attribute *edt_ft5x06_attrs[] = {
 	&edt_ft5x06_attr_gain.dattr.attr,
 	&edt_ft5x06_attr_offset.dattr.attr,
@@ -548,6 +560,7 @@ static struct attribute *edt_ft5x06_attrs[] = {
 	&edt_ft5x06_attr_threshold.dattr.attr,
 	&edt_ft5x06_attr_report_rate.dattr.attr,
 	&dev_attr_model.attr,
+	&dev_attr_fw_version.attr,
 	NULL
 };
 
@@ -834,13 +847,13 @@ static void edt_ft5x06_ts_teardown_debugfs(struct edt_ft5x06_ts_data *tsdata)
 #endif /* CONFIG_DEBUGFS */
 
 static int edt_ft5x06_ts_identify(struct i2c_client *client,
-					struct edt_ft5x06_ts_data *tsdata,
-					char *fw_version)
+				  struct edt_ft5x06_ts_data *tsdata)
 {
 	u8 rdbuf[EDT_NAME_LEN];
 	char *p;
 	int error;
 	char *model_name = tsdata->name;
+	char *fw_version = tsdata->fw_version;
 
 	/* see what we find if we assume it is a M06 *
 	 * if we get less than EDT_NAME_LEN, we don't want
@@ -1096,7 +1109,6 @@ static int edt_ft5x06_ts_probe(struct i2c_client *client,
 	struct input_dev *input;
 	unsigned long irq_flags;
 	int error;
-	char fw_version[EDT_NAME_LEN];
 
 	dev_dbg(&client->dev, "probing for EDT FT5x06 I2C\n");
 
@@ -1209,7 +1221,7 @@ static int edt_ft5x06_ts_probe(struct i2c_client *client,
 	tsdata->input = input;
 	tsdata->factory_mode = false;
 
-	error = edt_ft5x06_ts_identify(client, tsdata, fw_version);
+	error = edt_ft5x06_ts_identify(client, tsdata);
 	if (error) {
 		dev_err(&client->dev, "touchscreen probe failed\n");
 		return error;
@@ -1235,7 +1247,7 @@ static int edt_ft5x06_ts_probe(struct i2c_client *client,
 
 	dev_dbg(&client->dev,
 		"Model \"%s\", Rev. \"%s\", %dx%d sensors\n",
-		tsdata->name, fw_version, tsdata->num_x, tsdata->num_y);
+		tsdata->name, tsdata->fw_version, tsdata->num_x, tsdata->num_y);
 
 	input->name = tsdata->name;
 	input->id.bustype = BUS_I2C;
-- 
2.32.0

