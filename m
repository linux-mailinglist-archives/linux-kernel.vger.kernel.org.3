Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25E9751C45F
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 17:57:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381572AbiEEQAt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 12:00:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381100AbiEEQAa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 12:00:30 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8178B59BA0
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 08:56:47 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id dk23so9571845ejb.8
        for <linux-kernel@vger.kernel.org>; Thu, 05 May 2022 08:56:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YV+qTrBSZlEdVwvYGQdRpxUtm5BLonFPqiCggidUwTw=;
        b=GGOnWmM+dib97LLhpKHFjBcXVhNv1/UEEN1uoYHq/GvckRFSW3S8fQ2sph+fQs2vfT
         czDyYd5J85wk6QFJUkGtfKAFPEQaUhJstFWjMED9ytYezlk9Cg5VHjdD1cdL5i68xlBn
         +tgAldMJ8tKuTWK261uHa1OTcHJWslHOn503U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YV+qTrBSZlEdVwvYGQdRpxUtm5BLonFPqiCggidUwTw=;
        b=4dReSWIe7cfqyVMc2+23TsUN47wIQbtdoMKmnLMKzHOex33Z2ITjSNt0B0YdccR+KD
         3asRG9Yn4Zrmi813Aw2/rdmAEnhibUqG3C4p8g3Mq2AXGcCyDuN1Ffnb9343z/0kyUEc
         I+RcPP0PzDcyFW3BjtiOX3bMnN7Wi45wa/Ah9VL7LHmrps7MC3tQyzqFq54HgLF0tMdD
         sOX3z2TnmqjZRtIRlBVYax7qoNmP8gBspb6TRmr2z7z3jB/Lq6TQaMEXNX6iEqVvO5zm
         yy3OOBsmyxL97IXhkRmnSZPxsQWElbbbMQo8NJQN4SkSJJapAM1fiBQWxGb+gx68BdiT
         lDmQ==
X-Gm-Message-State: AOAM533+KhgVqCM1hoHkf+egcOzCmKA3TygvXEM2z5nJu2xjEztCYeV7
        GARP4MzGdNf5MGJ5u1PZx3gAOWtj4z92kg==
X-Google-Smtp-Source: ABdhPJwMyoTzc/nq6O2tfeWokNKPST4pIXCEVQB7syXeiQf8s5hEItGNUzvQs8TKQ1pL2oR3hVPmsQ==
X-Received: by 2002:a17:906:80d4:b0:6f3:bead:750c with SMTP id a20-20020a17090680d400b006f3bead750cmr27155533ejx.129.1651766206844;
        Thu, 05 May 2022 08:56:46 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.pdxnet.pdxeng.ch (host-87-0-15-73.retail.telecomitalia.it. [87.0.15.73])
        by smtp.gmail.com with ESMTPSA id a4-20020aa7d904000000b0042617ba6385sm1009328edr.15.2022.05.05.08.56.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 May 2022 08:56:46 -0700 (PDT)
From:   Dario Binacchi <dario.binacchi@amarulasolutions.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        Oliver Graute <oliver.graute@kococonnector.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Marco Felsch <m.felsch@pengutronix.de>,
        Stephan Gerhold <stephan@gerhold.net>,
        linux-input@vger.kernel.org
Subject: [RESEND PATCH v4 5/6] Input: edt-ft5x06 - show firmware version by sysfs
Date:   Thu,  5 May 2022 17:56:34 +0200
Message-Id: <20220505155635.419653-6-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220505155635.419653-1-dario.binacchi@amarulasolutions.com>
References: <20220505155635.419653-1-dario.binacchi@amarulasolutions.com>
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

