Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABDBB4D76EA
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Mar 2022 17:35:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235072AbiCMQgg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Mar 2022 12:36:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235040AbiCMQg3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Mar 2022 12:36:29 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59ED34C436
        for <linux-kernel@vger.kernel.org>; Sun, 13 Mar 2022 09:35:18 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id bg10so29171185ejb.4
        for <linux-kernel@vger.kernel.org>; Sun, 13 Mar 2022 09:35:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5FXIG1Rp9D4NgAZ2oOx6JgdhKdrDvM+0LjdQT4OHOI8=;
        b=G6zx7V4jo8ApkZN8UBzg1MTN2JUozrETeKvP2Z9nB2CGXKGvGgSbxCp36pZojFpBGu
         b9g86LPwtwYszSJMoh/j0fSa0qQ3I9v56mCRX8GQz/dvKanUrPhOZOrUvR/K2ZjRF5NC
         aMXRswQ3uVtroYrDL1uffIF012Wd/ZPyKA01s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5FXIG1Rp9D4NgAZ2oOx6JgdhKdrDvM+0LjdQT4OHOI8=;
        b=XjMi6wDVPays7jtJ++S9DWf9wiOuHVrYkoiuMOx+/BXcVBuy6TqxNT3Ws6xylIR/aI
         F00p8q4G6SESHxtMcGJGtRDWOXMF+ttnGGCzO2NBbDTCkXS8oAquC4BfdAMO/ogrAyDq
         HiVSZ/9tYe1V/ZVebLwMdpq14q8ZVg3BHBptE6eThwkhGoW3qN6AYEo0KT3JRj8KcTGN
         jN4KKV16e21EMHDhXX2h4k6BXQ+8WeCpNJkvbtTfljF2PAuuVqSvsUJxcAmsf6Sio1fp
         BfK96oEB+GVd1czpGZUq8IiXw0GGfoU18s7kFeViCcyVl0gExaXXx4stYekYOgQ4cgfx
         9vXA==
X-Gm-Message-State: AOAM5321O18U634yJNyqpDovdrL4HWBgPbuypeWuemYF5qWNFSwDbD1L
        IcEHPdSBLLUL2lDirAjRGBrJI3kYQeUZqQ==
X-Google-Smtp-Source: ABdhPJz3ACgVElSvXftg4ANP5NlGuUB8tqmTwatVRo8/kCDFuz2StmZDHd+p/Akf9c8S0ANZYSX5zQ==
X-Received: by 2002:a17:906:8585:b0:6db:2c85:2bc8 with SMTP id v5-20020a170906858500b006db2c852bc8mr15595961ejx.747.1647189316535;
        Sun, 13 Mar 2022 09:35:16 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it (host-87-0-15-73.retail.telecomitalia.it. [87.0.15.73])
        by smtp.gmail.com with ESMTPSA id qt22-20020a170906ecf600b006da6ef9b820sm5725028ejb.112.2022.03.13.09.35.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Mar 2022 09:35:16 -0700 (PDT)
From:   Dario Binacchi <dario.binacchi@amarulasolutions.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Marco Felsch <m.felsch@pengutronix.de>,
        Oliver Graute <oliver.graute@kococonnector.com>,
        Stephan Gerhold <stephan@gerhold.net>,
        linux-input@vger.kernel.org
Subject: [PATCH v3 2/6] Input: edt-ft5x06 - get/set M12 report rate by sysfs
Date:   Sun, 13 Mar 2022 17:34:59 +0100
Message-Id: <20220313163503.5183-3-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220313163503.5183-1-dario.binacchi@amarulasolutions.com>
References: <20220313163503.5183-1-dario.binacchi@amarulasolutions.com>
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

