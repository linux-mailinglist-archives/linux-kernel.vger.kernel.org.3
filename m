Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB4644F0B1F
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Apr 2022 18:10:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359377AbiDCQMR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Apr 2022 12:12:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359347AbiDCQMI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Apr 2022 12:12:08 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFCB226135
        for <linux-kernel@vger.kernel.org>; Sun,  3 Apr 2022 09:10:13 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id ot30so5395952ejb.12
        for <linux-kernel@vger.kernel.org>; Sun, 03 Apr 2022 09:10:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NIUuHRgvgWCmYJCricL+FHDsiVQYgUJ0FjEwcnUqvHA=;
        b=hd7rJB3C5Y4XSBLY/KDKNm08VdUSXnsrPOnuFOPdrlqeDPMGdLcvJEGg9NRy1ZVmqE
         kIJMPZGO7jdv4gvLF3mT2f7CTWyXpAWq2pxte1SUnWvkOV+pjXbiZ4phZMKeS8uKzI2K
         EghIZ+5W8Qsb0YW2CVvKairMG5L58p1T1ljxE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NIUuHRgvgWCmYJCricL+FHDsiVQYgUJ0FjEwcnUqvHA=;
        b=jWEN1PxuntgLHYnCGGfS45Um8vkFEIbHMeif1LtM8REvpLjNHkqZEgkUsCcOYniRTf
         y/pe63uHOejRUpUa6Onav3Q1mPrbtzw6A2M4ufNJZ2I33LeYYSsd4/5qammclMDOcOdF
         y19rR1DWXoD+PcR+9cR3pInWZiGnSTm0XJBkTy+dFBf7vbnPDTdsl+An/H1TBg8rayZd
         T+3aJWkgVb7uhrxQ7YWZH/CTbfQqdmoz+gtk7rOOjBcsajG9epwsJbPlH2SEUYlH9vva
         5Vw1WGBSbUpJOAmRtPKtMGjnb4X2S1lYmGctY6/vcrgt2Ib+R/jV4W4VhVqK8kJIhT4C
         6Uhw==
X-Gm-Message-State: AOAM533b7Bq0SnjZDgXRc9KC3VYy93NZAoRPtL1fW77pB/yEq+hR8z7Y
        T1scBa8/Os+PHxQ5dNziystrRby79KwK7g==
X-Google-Smtp-Source: ABdhPJwxkkD74Kb5RSwttXg/1bmRJ+1VogERBB+jgoNHYldMlN+gM2rpVZRa1xb20ZeUACCAea1MMA==
X-Received: by 2002:a17:907:6d12:b0:6e4:cd9b:c7f0 with SMTP id sa18-20020a1709076d1200b006e4cd9bc7f0mr7354000ejc.628.1649002212208;
        Sun, 03 Apr 2022 09:10:12 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it (host-87-0-15-73.retail.telecomitalia.it. [87.0.15.73])
        by smtp.gmail.com with ESMTPSA id do8-20020a170906c10800b006dfe2af50d8sm3350119ejc.121.2022.04.03.09.10.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Apr 2022 09:10:11 -0700 (PDT)
From:   Dario Binacchi <dario.binacchi@amarulasolutions.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Oliver Graute <oliver.graute@kococonnector.com>,
        Stephan Gerhold <stephan@gerhold.net>,
        linux-input@vger.kernel.org
Subject: [PATCH v4 3/6] Input: edt-ft5x06 - set report rate by dts property
Date:   Sun,  3 Apr 2022 18:09:36 +0200
Message-Id: <20220403160939.541621-4-dario.binacchi@amarulasolutions.com>
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

