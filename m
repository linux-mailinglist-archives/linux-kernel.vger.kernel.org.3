Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16C6B55324C
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 14:40:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350522AbiFUMj6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 08:39:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350494AbiFUMjs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 08:39:48 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C08CF237C2
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 05:39:45 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id ej4so15228533edb.7
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 05:39:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NIUuHRgvgWCmYJCricL+FHDsiVQYgUJ0FjEwcnUqvHA=;
        b=gWq873+sESE/ug08HIlhpajhkAH5/6YjB/Wi0lpEju9TWgO/BWQ727bblRKV2pHzwY
         NHMjW4qq9mCgRnxGIhyl+9xMuCnz6LspsIzfEJXBwzE8sXnUgIXiHYuUk2KbbmdBDC3q
         GvUATBF9RB43qxWJWsK4v8sw77gJkC4h5BcFA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NIUuHRgvgWCmYJCricL+FHDsiVQYgUJ0FjEwcnUqvHA=;
        b=z5sKQIn3dhUxeu4qe5YRa7pG7v+QvYmBriukvTM0BOrFhYzQu3cYWes4KMOtcIVyiH
         HWdYAR1IZ1+FfHEvEYygtZHLVmUUymH/elVhlX0YaTYnb2XEAKu0zCmLTwxKUb1BAJqU
         AL6VrI1z5LWNWhp/obGm+3gxne9xso6iP7Ne6/J1jw30/FzZWWL3zCbmYCX+TziTz/47
         zos1NklPzUrxQrOCZl0rA0HCqVCXn98vFYfeabj4F3Kq+JADF8F8OsojMUQq/4ImVCLh
         e1j3iJoRG47HpwKYcKillSz+CmEDrUVyPj8RtoCNrxWbYovbli/xLHTzzb3u18zeOve8
         f19Q==
X-Gm-Message-State: AJIora/dY7ULiA7WyUmGXZMJfEtQpQmOAdGTsAjDndm9TYhV2Ff2vycm
        gl7YW2rkZ1hpxOMShPCdrdWmv+fWHQKPKw==
X-Google-Smtp-Source: AGRyM1vWRZC2rTjzpFcdLFBlYMHd99yNVBLnBQl3nqWi1gNfOcY5sV+TaSYUg95yWXhwsr32p/cUpQ==
X-Received: by 2002:a05:6402:3713:b0:435:539e:a939 with SMTP id ek19-20020a056402371300b00435539ea939mr30972033edb.160.1655815184111;
        Tue, 21 Jun 2022 05:39:44 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it (host-80-116-90-174.pool80116.interbusiness.it. [80.116.90.174])
        by smtp.gmail.com with ESMTPSA id c19-20020aa7c753000000b004357063bf60sm8003945eds.41.2022.06.21.05.39.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jun 2022 05:39:43 -0700 (PDT)
From:   Dario Binacchi <dario.binacchi@amarulasolutions.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Marco Felsch <m.felsch@pengutronix.de>,
        Oliver Graute <oliver.graute@kococonnector.com>,
        linux-input@vger.kernel.org
Subject: [RESEND PATCH v4 3/6] Input: edt-ft5x06 - set report rate by dts property
Date:   Tue, 21 Jun 2022 14:39:34 +0200
Message-Id: <20220621123937.1330389-4-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220621123937.1330389-1-dario.binacchi@amarulasolutions.com>
References: <20220621123937.1330389-1-dario.binacchi@amarulasolutions.com>
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

