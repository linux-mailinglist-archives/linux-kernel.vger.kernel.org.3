Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EE3F4D76DF
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Mar 2022 17:35:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235099AbiCMQgt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Mar 2022 12:36:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235054AbiCMQg3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Mar 2022 12:36:29 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D39DA4FC41
        for <linux-kernel@vger.kernel.org>; Sun, 13 Mar 2022 09:35:21 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id qx21so29077267ejb.13
        for <linux-kernel@vger.kernel.org>; Sun, 13 Mar 2022 09:35:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YV+qTrBSZlEdVwvYGQdRpxUtm5BLonFPqiCggidUwTw=;
        b=hVvZW1vFZuoALeRtNg+nupOSqvCar6vit8h6s5B0q+LGTk71v6fb6GKOv0nc4TB3BB
         HAyKxdUC4FZAPoH/qXEnm51kTot3esfUm1Wurn230/9LuFfumSVuggPbK/Jtf+PZIChM
         gAgPxfBd2tVRNM64aqlweeSeVgGz5VGOfsNcA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YV+qTrBSZlEdVwvYGQdRpxUtm5BLonFPqiCggidUwTw=;
        b=bjj0fe1kthN6nEHIkVTZpYUhkqe3CJeTnI9k1WIYL2wNIfCTybXIgLLR1CzjXE+EtI
         mZRpgABUCU3fqTYFRYYEcuu+LggqgoOtV74D159fXvN5l7TWlhzG15iSutJYSYlQiTdw
         KtwmyppzZiKhrwaMJSOnW7ZDtwAiN3E6RB3/sBfrI4Hgn6jTYd3JFwbL2vNFGF37iyAN
         wRAW8A7kPpa6+RI7B8HjRqnQqhcIsOv10XwTyxu+XcK72zFhHgDIwDr/JiFA6+lbnxYO
         mjhE0zv/TuGhXaJtEC9aC/WiMlfgRqwU0F/oesKUDsH49EkkH3Ecr9gtpWujsbGIuFq9
         RZWw==
X-Gm-Message-State: AOAM532ZJm6KPlRsp1dLHNnENaQfsfBzrt8q/14JOOKhbCAUEGVQULCr
        vrHOZOUP1sgkm4oHRXT235zeZx/HuRECZw==
X-Google-Smtp-Source: ABdhPJzTTWmFuuwMkXu99r1WcdCrDhruBnvuUaJkEqxoWfB32IrVvElnk+Qwc1rKy5YT1i7kFISS4Q==
X-Received: by 2002:a17:906:6547:b0:6bd:e2ad:8c82 with SMTP id u7-20020a170906654700b006bde2ad8c82mr15619634ejn.693.1647189320120;
        Sun, 13 Mar 2022 09:35:20 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it (host-87-0-15-73.retail.telecomitalia.it. [87.0.15.73])
        by smtp.gmail.com with ESMTPSA id qt22-20020a170906ecf600b006da6ef9b820sm5725028ejb.112.2022.03.13.09.35.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Mar 2022 09:35:19 -0700 (PDT)
From:   Dario Binacchi <dario.binacchi@amarulasolutions.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        Oliver Graute <oliver.graute@kococonnector.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Stephan Gerhold <stephan@gerhold.net>,
        linux-input@vger.kernel.org
Subject: [PATCH v3 5/6] Input: edt-ft5x06 - show firmware version by sysfs
Date:   Sun, 13 Mar 2022 17:35:02 +0100
Message-Id: <20220313163503.5183-6-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220313163503.5183-1-dario.binacchi@amarulasolutions.com>
References: <20220313163503.5183-1-dario.binacchi@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
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

