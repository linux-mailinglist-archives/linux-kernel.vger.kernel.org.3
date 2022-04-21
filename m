Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 297AB50A8AA
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 21:02:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1391692AbiDUTDs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 15:03:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1391693AbiDUTDl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 15:03:41 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD96142EC4
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 12:00:50 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id f17so7702389edt.4
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 12:00:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NIUuHRgvgWCmYJCricL+FHDsiVQYgUJ0FjEwcnUqvHA=;
        b=m2IC8FNcMpgWptpAk5irJwhOTaeWH7pd1WYL0g/hEONSJ34jgGfLZtZiLIJJSCUJ0l
         JmrOJQSrFs2W7lnz/IKcWhRnBQx5ZYZPmiTjP+A+R8IusFP4rSZKWgtKgzQnaJy0lDR4
         ovtzUi7Nyiz5PfyX9jbzD91/J6mi+3Ez71YjE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NIUuHRgvgWCmYJCricL+FHDsiVQYgUJ0FjEwcnUqvHA=;
        b=sw+mlQi7Lv+HPRx5g4lbR2MdDs+H9wdmqvm7kKKDUhOOHE2Si2ORpgv7lEw5P5cflw
         uxx6O2OLBhr1o8EM2mQJPQSRz2/e4/pCkuy8j971pIBD8iT1aIQXw4pSrrK1KFYR9a31
         Q+Cs7tiYInV71fBzjp6w61GgNqUZ8FSKVVCA7XJXAa6Pl/N5Cq5VGl0TOTspMTAR+9Wm
         swjoxpv0AiTm808doD8ngkPR43jgeJDG9XlarmTkkBcykiaoJM2mr0Jp+0klwH7VRWuz
         fg9KLU4iwZhsJOJK0edvYblZNjRH597l6+HzSDxABkn++3cFPkxwQ6KN+DSRRf/tG1gh
         sBOA==
X-Gm-Message-State: AOAM532ZB3ncnMUyDaSpfOGEex+3XcwzHvB5uuTRHEGJwTGonna0l9cH
        f0YKFlVpoz9QClSylpAaG0K9U5lTQdtiAQ==
X-Google-Smtp-Source: ABdhPJxQiLhPFSbkfabOPaFiFv0NiEGVjipYprjVWUNCWZdLj48Nxc0yKpYdzzHF3PJT+UpVZvBAeQ==
X-Received: by 2002:a05:6402:1707:b0:41d:9794:6421 with SMTP id y7-20020a056402170700b0041d97946421mr1047302edu.212.1650567649267;
        Thu, 21 Apr 2022 12:00:49 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.amarulasolutions.com (host-87-0-15-73.retail.telecomitalia.it. [87.0.15.73])
        by smtp.gmail.com with ESMTPSA id s11-20020a170906284b00b006e108693850sm7975142ejc.28.2022.04.21.12.00.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Apr 2022 12:00:42 -0700 (PDT)
From:   Dario Binacchi <dario.binacchi@amarulasolutions.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Marco Felsch <m.felsch@pengutronix.de>,
        Oliver Graute <oliver.graute@kococonnector.com>,
        Stephan Gerhold <stephan@gerhold.net>,
        linux-input@vger.kernel.org
Subject: [RESEND PATCH v4 3/6] Input: edt-ft5x06 - set report rate by dts property
Date:   Thu, 21 Apr 2022 21:00:00 +0200
Message-Id: <20220421190003.3228699-4-dario.binacchi@amarulasolutions.com>
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

It allows to change the M06/M12 default scan rate on driver probing.

Co-developed-by: Michael Trimarchi <michael@amarulasolutions.com>
Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>

---

(no changes since v3)

Changes in v3:
- Check the lower and upper limits of the report-rate-hz value
- Convert the M06 report-rate-hz value

 drivers/input/touchscreen/edt-ft5x06.c | 30 ++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/drivers/input/touchscreen/edt-ft5x06.c b/drivers/input/touchscreen/edt-ft5x06.c
index 77f061af5c61..843e8b0522f7 100644
--- a/drivers/input/touchscreen/edt-ft5x06.c
+++ b/drivers/input/touchscreen/edt-ft5x06.c
@@ -1084,6 +1084,7 @@ static int edt_ft5x06_ts_probe(struct i2c_client *client,
 	struct input_dev *input;
 	unsigned long irq_flags;
 	int error;
+	u32 report_rate;
 	char fw_version[EDT_NAME_LEN];
 
 	dev_dbg(&client->dev, "probing for EDT FT5x06 I2C\n");
@@ -1213,6 +1214,35 @@ static int edt_ft5x06_ts_probe(struct i2c_client *client,
 	edt_ft5x06_ts_get_defaults(&client->dev, tsdata);
 	edt_ft5x06_ts_get_parameters(tsdata);
 
+	if (tsdata->reg_addr.reg_report_rate != NO_REGISTER &&
+	    !of_property_read_u32(client->dev.of_node, "report-rate-hz",
+				  &report_rate)) {
+		tsdata->report_rate = report_rate;
+		if (tsdata->version == EDT_M06) {
+			if (report_rate < 30)
+				report_rate = 30;
+			else if (report_rate > 140)
+				report_rate = 140;
+		} else if (report_rate < 1) {
+			report_rate = 1;
+		} else if (report_rate > 255)
+			report_rate = 255;
+
+		if (report_rate != tsdata->report_rate)
+			dev_warn(&client->dev,
+				 "report-rate %dHz is unsupported, use %dHz\n",
+				 tsdata->report_rate, report_rate);
+
+		if (tsdata->version == EDT_M06)
+			report_rate /= 10;
+
+		tsdata->report_rate = report_rate;
+
+		edt_ft5x06_register_write(tsdata,
+					  tsdata->reg_addr.reg_report_rate,
+					  tsdata->report_rate);
+	}
+
 	dev_dbg(&client->dev,
 		"Model \"%s\", Rev. \"%s\", %dx%d sensors\n",
 		tsdata->name, fw_version, tsdata->num_x, tsdata->num_y);
-- 
2.32.0

