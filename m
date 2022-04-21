Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FFF350A8B2
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 21:02:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1391727AbiDUTFR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 15:05:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1391720AbiDUTFO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 15:05:14 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC82C4BFDE
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 12:02:23 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id f17so7707766edt.4
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 12:02:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=V78a4T+XxMalGYKe1sIzEqFdtRWisjMfkHNLxFh+Xuk=;
        b=HHkEqxTxydBkOPTAWKKQG/XvT+4YPu7xQsaD3xEJkvmj/jeK3VMbwKQ98Hbg4RrxiH
         YELlCFmGs11cjfEKrDmGA95J5WqdeDTp8cqZivOwf0LvaC+Bw6LnM9/isAzazgkYZZhW
         GHhXNNhnP63fA/YlhvZ9WEMMZ1Lf61iZnKvKM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=V78a4T+XxMalGYKe1sIzEqFdtRWisjMfkHNLxFh+Xuk=;
        b=ZT7M24ji+Iqz49fCx3AsxC5KA3CgkORFj9toImmWmAA/33gdaLP5dDRlRSAsAUPe2N
         iWDKv3V/VSyT+j33nKBQsQfVPPU+Z3hlMVbCrvsoo6jdYRK7oQA1yEPIWRJOHmCTEYEb
         n3t7Jz/knNEiBzOdHude/B+j++eicGfk0TYY7Rl7sy1oGvnw5p0vKBnCXhZucM2UTY7A
         5vUkWpStgPqrzCeyLpU6N6rSsXal/n/yWKSn2aI8AeLX0Y8gm4HU0j9iX9oUOBxn6ufR
         XsXwbNe9qHbvXDluF0tqhGN52dN8yOoEfVKPKLUitdsdz5z9eAvUDekK7ZBdzKhnb5+t
         6l0g==
X-Gm-Message-State: AOAM533UDa3eJHa3opiy7WKoBG6CXmlA3+EugRsk13tBqO0w8QwBdtVK
        +IyeZG34T4M68sPkp69PSPFH1Sua/U0WYg==
X-Google-Smtp-Source: ABdhPJz0KGL6rSjm6EhATFv3ykGqeGZcALLvHUMKiYbjmdhG/nGMAxcs10My5jkMKrm9TOdaIQh09w==
X-Received: by 2002:a05:6402:1a44:b0:41d:8969:e4c9 with SMTP id bf4-20020a0564021a4400b0041d8969e4c9mr997941edb.299.1650567741656;
        Thu, 21 Apr 2022 12:02:21 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.amarulasolutions.com (host-87-0-15-73.retail.telecomitalia.it. [87.0.15.73])
        by smtp.gmail.com with ESMTPSA id s11-20020a170906284b00b006e108693850sm7975142ejc.28.2022.04.21.12.02.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Apr 2022 12:02:13 -0700 (PDT)
From:   Dario Binacchi <dario.binacchi@amarulasolutions.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Oliver Graute <oliver.graute@kococonnector.com>,
        Stephan Gerhold <stephan@gerhold.net>,
        linux-input@vger.kernel.org
Subject: [RESEND PATCH v4 6/6] Input: edt-ft5x06 - show crc and header errors by sysfs
Date:   Thu, 21 Apr 2022 21:00:03 +0200
Message-Id: <20220421190003.3228699-7-dario.binacchi@amarulasolutions.com>
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

M06 sends packets with header and crc for data verification. Now you can
check at runtime how many packets have been dropped.

Co-developed-by: Michael Trimarchi <michael@amarulasolutions.com>
Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>

---

(no changes since v2)

Changes in v2:
- Add Oliver Graute's 'Acked-by' tag to:
  * Input: edt-ft5x06 - show model name by sysfs
  * Input: edt-ft5x06 - show firmware version by sysfs
- Fix yaml file. Tested with `make DT_CHECKER_FLAGS=-m dt_binding_check'.

 drivers/input/touchscreen/edt-ft5x06.c | 30 ++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/drivers/input/touchscreen/edt-ft5x06.c b/drivers/input/touchscreen/edt-ft5x06.c
index bab92344b2ea..3deb66d67469 100644
--- a/drivers/input/touchscreen/edt-ft5x06.c
+++ b/drivers/input/touchscreen/edt-ft5x06.c
@@ -133,6 +133,8 @@ struct edt_ft5x06_ts_data {
 
 	struct edt_reg_addr reg_addr;
 	enum edt_ver version;
+	unsigned int crc_errors;
+	unsigned int header_errors;
 };
 
 struct edt_i2c_chip_data {
@@ -181,6 +183,7 @@ static bool edt_ft5x06_ts_check_crc(struct edt_ft5x06_ts_data *tsdata,
 		crc ^= buf[i];
 
 	if (crc != buf[buflen-1]) {
+		tsdata->crc_errors++;
 		dev_err_ratelimited(&tsdata->client->dev,
 				    "crc error: 0x%02x expected, got 0x%02x\n",
 				    crc, buf[buflen-1]);
@@ -238,6 +241,7 @@ static irqreturn_t edt_ft5x06_ts_isr(int irq, void *dev_id)
 	if (tsdata->version == EDT_M06) {
 		if (rdbuf[0] != 0xaa || rdbuf[1] != 0xaa ||
 			rdbuf[2] != datalen) {
+			tsdata->header_errors++;
 			dev_err_ratelimited(dev,
 					"Unexpected header: %02x%02x%02x!\n",
 					rdbuf[0], rdbuf[1], rdbuf[2]);
@@ -552,6 +556,30 @@ static ssize_t fw_version_show(struct device *dev,
 
 static DEVICE_ATTR_RO(fw_version);
 
+/* m06 only */
+static ssize_t header_errors_show(struct device *dev,
+				  struct device_attribute *attr, char *buf)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct edt_ft5x06_ts_data *tsdata = i2c_get_clientdata(client);
+
+	return scnprintf(buf, PAGE_SIZE, "%d\n", tsdata->header_errors);
+}
+
+static DEVICE_ATTR_RO(header_errors);
+
+/* m06 only */
+static ssize_t crc_errors_show(struct device *dev,
+			       struct device_attribute *attr, char *buf)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct edt_ft5x06_ts_data *tsdata = i2c_get_clientdata(client);
+
+	return scnprintf(buf, PAGE_SIZE, "%d\n", tsdata->crc_errors);
+}
+
+static DEVICE_ATTR_RO(crc_errors);
+
 static struct attribute *edt_ft5x06_attrs[] = {
 	&edt_ft5x06_attr_gain.dattr.attr,
 	&edt_ft5x06_attr_offset.dattr.attr,
@@ -561,6 +589,8 @@ static struct attribute *edt_ft5x06_attrs[] = {
 	&edt_ft5x06_attr_report_rate.dattr.attr,
 	&dev_attr_model.attr,
 	&dev_attr_fw_version.attr,
+	&dev_attr_header_errors.attr,
+	&dev_attr_crc_errors.attr,
 	NULL
 };
 
-- 
2.32.0

