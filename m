Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07D1D50A8B1
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 21:02:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1391722AbiDUTFG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 15:05:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1391709AbiDUTFE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 15:05:04 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB6DF49924
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 12:02:13 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id u15so11850614ejf.11
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 12:02:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YV+qTrBSZlEdVwvYGQdRpxUtm5BLonFPqiCggidUwTw=;
        b=B1H5ZgGpA63O5v5dDseCQC6tK+EJtNplHma4xWuSCMbmqOMxRoeqCVZLiBpjha9ied
         HJ0QtiOUImNuvD3lpJ8AOVNqvxXLzuO8WMkJNpKLVeGzPXvm9kem0R40B3e3G8TnVk28
         lY31fw5J9GhwRn0P4mOlchEOVhna0sfWs7PKQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YV+qTrBSZlEdVwvYGQdRpxUtm5BLonFPqiCggidUwTw=;
        b=RcsBuVlX/FLisY7A5IdCYkhWEjIH0wFKMLNuagk8UAhctm24ooKAXxR2dI+QauLC4G
         D7C/D+xHHCjyIZ9/0PzrQw96n/+L7M+Pfn5RAanGbd69XxXhVJbnKIy8V/B9n1RgaNSZ
         QSoELY3DBLBvXm5oB5+FcWwedy6wIVBWvEfVJ2E7CNAeiRujDy08iQQUzMkU7RhcXJmE
         f0G7EMijCi1SL9dnqscuSkBIwZSyWvz+c5W7m+TXSSs2n64mXO5UxUCoKNHFMDt0bzlU
         LMCdtW1+PzjWDvRtHu9orkxj7R6jQ8e/4xalMzK5K+ui2UErJU9v4zmQkHsB0JzEsuDj
         68xQ==
X-Gm-Message-State: AOAM533eiiY4uo33MdPyPBTyB887PH7w5wfpxRVl299EjQ7vvMgK5b6F
        XdMcEbI8z1iqChErXx21zKvCbMOYN4fqFw==
X-Google-Smtp-Source: ABdhPJwGnZ7s87UVdhDRJD6kiBB+YdmIaMSZceyr0LboNbbh6ou7VG2d0CGXpF4Nkk6oL49LbjBzEw==
X-Received: by 2002:a17:907:7f09:b0:6f0:2991:9c76 with SMTP id qf9-20020a1709077f0900b006f029919c76mr853725ejc.170.1650567732081;
        Thu, 21 Apr 2022 12:02:12 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.amarulasolutions.com (host-87-0-15-73.retail.telecomitalia.it. [87.0.15.73])
        by smtp.gmail.com with ESMTPSA id s11-20020a170906284b00b006e108693850sm7975142ejc.28.2022.04.21.12.01.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Apr 2022 12:01:48 -0700 (PDT)
From:   Dario Binacchi <dario.binacchi@amarulasolutions.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        Oliver Graute <oliver.graute@kococonnector.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Stephan Gerhold <stephan@gerhold.net>,
        linux-input@vger.kernel.org
Subject: [RESEND PATCH v4 5/6] Input: edt-ft5x06 - show firmware version by sysfs
Date:   Thu, 21 Apr 2022 21:00:02 +0200
Message-Id: <20220421190003.3228699-6-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220421190003.3228699-1-dario.binacchi@amarulasolutions.com>
References: <20220421190003.3228699-1-dario.binacchi@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
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
index 89157deebfcb..bab92344b2ea 100644
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
@@ -1097,7 +1110,6 @@ static int edt_ft5x06_ts_probe(struct i2c_client *client,
 	unsigned long irq_flags;
 	int error;
 	u32 report_rate;
-	char fw_version[EDT_NAME_LEN];
 
 	dev_dbg(&client->dev, "probing for EDT FT5x06 I2C\n");
 
@@ -1210,7 +1222,7 @@ static int edt_ft5x06_ts_probe(struct i2c_client *client,
 	tsdata->input = input;
 	tsdata->factory_mode = false;
 
-	error = edt_ft5x06_ts_identify(client, tsdata, fw_version);
+	error = edt_ft5x06_ts_identify(client, tsdata);
 	if (error) {
 		dev_err(&client->dev, "touchscreen probe failed\n");
 		return error;
@@ -1257,7 +1269,7 @@ static int edt_ft5x06_ts_probe(struct i2c_client *client,
 
 	dev_dbg(&client->dev,
 		"Model \"%s\", Rev. \"%s\", %dx%d sensors\n",
-		tsdata->name, fw_version, tsdata->num_x, tsdata->num_y);
+		tsdata->name, tsdata->fw_version, tsdata->num_x, tsdata->num_y);
 
 	input->name = tsdata->name;
 	input->id.bustype = BUS_I2C;
-- 
2.32.0

