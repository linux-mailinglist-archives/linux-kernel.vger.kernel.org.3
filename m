Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0388553248
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 14:40:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350515AbiFUMjw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 08:39:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350480AbiFUMjq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 08:39:46 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5EAC24099
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 05:39:44 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id g26so5828272ejb.5
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 05:39:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5FXIG1Rp9D4NgAZ2oOx6JgdhKdrDvM+0LjdQT4OHOI8=;
        b=nqeYuagDG4VYaSbzaCmy1tqZMz4yp8N0hl1ERuPdogW+lf6Y9/K1Y2I2Xx5BZufqh0
         +ZxOWPo83uLZX9jfNahcgB3YaOLeN5Viv+5gt0YC/3DOWL3dtcwSE6yNLgwjZlzE0ehx
         XMmS5FKcAkTdcjPzYcqBZasbpYKnp2NeTomi0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5FXIG1Rp9D4NgAZ2oOx6JgdhKdrDvM+0LjdQT4OHOI8=;
        b=55bAqXuWvuBi1yyGCJiGi36/aGEdoJbn+XxLHsGeI/iPvhm/uhpRz2aDzjPHCRb6km
         98JKTnxXD3gq8ZsriRfNbRbab5Ok8Hpt2uSPLQ3qfJo9PwFq43R0gW4Qfw8aCWgA+Ce4
         3RxEK3r/QxBASz/9Gm3TIyIoNkkxqQxxQ/LIdAIsQjFCWAolxcMq8bjtgEu9jf3LD2Or
         hHgnV/qusFmjZHjRpfKOweQgAtjYqR7QZfJzj0AHcnIFOQnOSQyGPB0BQ5b7pNb4pBbX
         esDdvlncSOzS6DTZY5D8yM/XY6Rtaejz6XyERyknNvxarjeB0XVayiTrGQN2NBs0xMtP
         qP+w==
X-Gm-Message-State: AJIora/RMpaSDFAtq3gXKUZj3AGqKwZ7u700/g021bU7HNyhuLSUZWkg
        Ezgh/5f/VuHhzInCFsLeiNADpa8LHr68kg==
X-Google-Smtp-Source: AGRyM1snl4Lq8GimgUfgjaF2BN5Pglx7SsqDhORPMHpswAOut39kUfL6kVlUcNgUJ5cXMSx+m6Ioiw==
X-Received: by 2002:a17:907:c202:b0:710:8d0c:6e89 with SMTP id ti2-20020a170907c20200b007108d0c6e89mr25577538ejc.141.1655815183056;
        Tue, 21 Jun 2022 05:39:43 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it (host-80-116-90-174.pool80116.interbusiness.it. [80.116.90.174])
        by smtp.gmail.com with ESMTPSA id c19-20020aa7c753000000b004357063bf60sm8003945eds.41.2022.06.21.05.39.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jun 2022 05:39:42 -0700 (PDT)
From:   Dario Binacchi <dario.binacchi@amarulasolutions.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Marco Felsch <m.felsch@pengutronix.de>,
        Oliver Graute <oliver.graute@kococonnector.com>,
        linux-input@vger.kernel.org
Subject: [RESEND PATCH v4 2/6] Input: edt-ft5x06 - get/set M12 report rate by sysfs
Date:   Tue, 21 Jun 2022 14:39:33 +0200
Message-Id: <20220621123937.1330389-3-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220621123937.1330389-1-dario.binacchi@amarulasolutions.com>
References: <20220621123937.1330389-1-dario.binacchi@amarulasolutions.com>
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

Add support for reading/writing scan rate (SC) register for M12 by
sysfs. The register value is equal to the SC (Hz), unlike M06, where
instead it is equal to SC / 10.

Co-developed-by: Michael Trimarchi <michael@amarulasolutions.com>
Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
Tested-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
---

(no changes since v1)

 drivers/input/touchscreen/edt-ft5x06.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/input/touchscreen/edt-ft5x06.c b/drivers/input/touchscreen/edt-ft5x06.c
index bb2e1cbffba7..77f061af5c61 100644
--- a/drivers/input/touchscreen/edt-ft5x06.c
+++ b/drivers/input/touchscreen/edt-ft5x06.c
@@ -47,6 +47,8 @@
 #define M09_REGISTER_NUM_X		0x94
 #define M09_REGISTER_NUM_Y		0x95
 
+#define M12_REGISTER_REPORT_RATE	0x88
+
 #define EV_REGISTER_THRESHOLD		0x40
 #define EV_REGISTER_GAIN		0x41
 #define EV_REGISTER_OFFSET_Y		0x45
@@ -523,9 +525,9 @@ static EDT_ATTR(offset_y, S_IWUSR | S_IRUGO, NO_REGISTER, NO_REGISTER,
 /* m06: range 20 to 80, m09: range 0 to 30, m12: range 1 to 255... */
 static EDT_ATTR(threshold, S_IWUSR | S_IRUGO, WORK_REGISTER_THRESHOLD,
 		M09_REGISTER_THRESHOLD, EV_REGISTER_THRESHOLD, 0, 255);
-/* m06: range 3 to 14, m12: (0x64: 100Hz) */
+/* m06: range 3 to 14, m12: range 1 to 255 */
 static EDT_ATTR(report_rate, S_IWUSR | S_IRUGO, WORK_REGISTER_REPORT_RATE,
-		NO_REGISTER, NO_REGISTER, 0, 255);
+		M12_REGISTER_REPORT_RATE, NO_REGISTER, 0, 255);
 
 static struct attribute *edt_ft5x06_attrs[] = {
 	&edt_ft5x06_attr_gain.dattr.attr,
@@ -1030,7 +1032,8 @@ static void edt_ft5x06_ts_set_regs(struct edt_ft5x06_ts_data *tsdata)
 	case EDT_M09:
 	case EDT_M12:
 		reg_addr->reg_threshold = M09_REGISTER_THRESHOLD;
-		reg_addr->reg_report_rate = NO_REGISTER;
+		reg_addr->reg_report_rate = tsdata->version == EDT_M12 ?
+			M12_REGISTER_REPORT_RATE : NO_REGISTER;
 		reg_addr->reg_gain = M09_REGISTER_GAIN;
 		reg_addr->reg_offset = M09_REGISTER_OFFSET;
 		reg_addr->reg_offset_x = NO_REGISTER;
-- 
2.32.0

