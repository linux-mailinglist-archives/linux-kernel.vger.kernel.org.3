Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A2F44F0B24
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Apr 2022 18:10:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359383AbiDCQMU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Apr 2022 12:12:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359365AbiDCQMN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Apr 2022 12:12:13 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79AF826AC3
        for <linux-kernel@vger.kernel.org>; Sun,  3 Apr 2022 09:10:17 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id dr20so15279609ejc.6
        for <linux-kernel@vger.kernel.org>; Sun, 03 Apr 2022 09:10:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YV+qTrBSZlEdVwvYGQdRpxUtm5BLonFPqiCggidUwTw=;
        b=iNbeRPoQ0lC1x2A8rGJ8qnjRYe9Z4CPywbDg+PdtSPQ2sL/dhoyKjxLexQjrSM1mlh
         3qZhVVaQ0gGMh4FKXGbkDg7ANq+TKjj0oHtFsypJqF/79T2PZ4FRLFgNQvglTykHLmEc
         VyGHfyznGcIAxNtcqrMUwNbxM0jIC6HoNR2yw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YV+qTrBSZlEdVwvYGQdRpxUtm5BLonFPqiCggidUwTw=;
        b=EiK5iuveyckCgZrnrynhu3W2gToFqpZa+Yysg66xwL4NajLOCz5aKgXRcpDamZIPZp
         KOeFxI2jqHEY2mfuyKU0H3ZW4nvZCXStmVB+TbrIc+H+OCvlV56ldKlQMj3n4GR+a3r4
         v+Ls/TGitavpQVFEHDRpbqMsC/QjWPdi7C+jAbwqehh0c5bxMkEWQPNeU27KL21LRnws
         ndi4yHVkK9VJ7El+SIDx7NyJzXYz9/hTvJ6Ju89LKohbLFNkGahEqrUEXYMtNBuT2ep8
         6Y7j9kBFygCJ/EEe00KTvdpF1bgq8KEnIF96Cbvd2xvoKVL4t+giQ8Edw6iInPX6OLa8
         SPfw==
X-Gm-Message-State: AOAM531wtOwCmXMRG0g1F9pcXLslzJftz1irFp4pgvX83shF/scdDU5h
        UgwKnf+KZZ6AkCPRz8SZzYcBsx60371+Ag==
X-Google-Smtp-Source: ABdhPJy9vg4Bj1FgF7E/aH2B732BM37r6W+MbxnO/cO1+8k6fuxoGlX3NE9wwVDKXTEF2jmrOCgn7A==
X-Received: by 2002:a17:907:3f9a:b0:6e0:e2f5:aded with SMTP id hr26-20020a1709073f9a00b006e0e2f5adedmr7464654ejc.743.1649002215867;
        Sun, 03 Apr 2022 09:10:15 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it (host-87-0-15-73.retail.telecomitalia.it. [87.0.15.73])
        by smtp.gmail.com with ESMTPSA id do8-20020a170906c10800b006dfe2af50d8sm3350119ejc.121.2022.04.03.09.10.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Apr 2022 09:10:15 -0700 (PDT)
From:   Dario Binacchi <dario.binacchi@amarulasolutions.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        Oliver Graute <oliver.graute@kococonnector.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Stephan Gerhold <stephan@gerhold.net>,
        linux-input@vger.kernel.org
Subject: [PATCH v4 5/6] Input: edt-ft5x06 - show firmware version by sysfs
Date:   Sun,  3 Apr 2022 18:09:38 +0200
Message-Id: <20220403160939.541621-6-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220403160939.541621-1-dario.binacchi@amarulasolutions.com>
References: <20220403160939.541621-1-dario.binacchi@amarulasolutions.com>
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

