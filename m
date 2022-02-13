Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6C624B3C6A
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Feb 2022 18:16:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237299AbiBMRQF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Feb 2022 12:16:05 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237293AbiBMRQE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Feb 2022 12:16:04 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29ACE5938D
        for <linux-kernel@vger.kernel.org>; Sun, 13 Feb 2022 09:15:58 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id w2so5188803edc.8
        for <linux-kernel@vger.kernel.org>; Sun, 13 Feb 2022 09:15:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FrUQuHtQGj/olmQcr/n4ScE+eFPqjZP07zyR2QXuUyo=;
        b=RXpZl8YC9hanx1D2+vwt7BQkAYxHhGoOdEVbmEjf4wONwi8ijXLzFrKwEaCfxMlBoq
         2n6GoVQtS883m7X/+K0OhuZtkfFCgyDxkBA6QuxeeDWWPHkyvuXNwIJ6zNkXCa9HjSq1
         lLq6BCD/Z5LrbemtYYi41eVsZzzbZckTt/h94=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FrUQuHtQGj/olmQcr/n4ScE+eFPqjZP07zyR2QXuUyo=;
        b=b8YYN+mByv9et9dtstywIbq+8+5RMO5u4qN1Vb+ZSBZuAPX0hIR8gKLW6EHUwkVCKR
         J4P137Y6Kn5gPaA5qsNo2indFsA0vyWmF9tF3lvdBe2qHiZJYfkjPIyf3DO5mplZTvVq
         REqNo5V905M58ms9PVUDJtutwzKT2yCwSpm2Sx55BMgPDbsNbfMewOb3HcSiSJer6wMW
         h5cXtjvYHuV+cd9jHPbBKsnRPojilRcjVxOonsmyUQaVSS2MZHP0Yrs7IH/Vc32QMhB2
         +9Vd2Qo0DNmQqB5PEgNqLKq+BhevzA+Y/RSZ5CqjVWllAOwB4FvMRcR2m0Gv8H1aoQ5r
         MhKQ==
X-Gm-Message-State: AOAM5331YucgxP8uzdVtr77PFbGXqTSOEn9IGQK277DJ+ZmFoE8zFsC2
        KL1FnvMcmD6LTm0v2GesnO2GaSk7Yud3Cw==
X-Google-Smtp-Source: ABdhPJxyWFo4IjRBoQ1Gocg+ptlDZguqCDuolaKqN2bMpfmuccQowxnGKwOh6uY6XIhaAwyHEMDOJA==
X-Received: by 2002:a05:6402:2987:: with SMTP id eq7mr2738833edb.330.1644772556567;
        Sun, 13 Feb 2022 09:15:56 -0800 (PST)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it (host-82-52-8-210.retail.telecomitalia.it. [82.52.8.210])
        by smtp.gmail.com with ESMTPSA id o10sm6598878ejj.6.2022.02.13.09.15.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Feb 2022 09:15:56 -0800 (PST)
From:   Dario Binacchi <dario.binacchi@amarulasolutions.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Marco Felsch <m.felsch@pengutronix.de>,
        Oliver Graute <oliver.graute@kococonnector.com>,
        Stephan Gerhold <stephan@gerhold.net>,
        linux-input@vger.kernel.org
Subject: [PATCH 2/6] Input: edt-ft5x06 - get/set M12 report rate by sysfs
Date:   Sun, 13 Feb 2022 18:15:28 +0100
Message-Id: <20220213171532.346270-3-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220213171532.346270-1-dario.binacchi@amarulasolutions.com>
References: <20220213171532.346270-1-dario.binacchi@amarulasolutions.com>
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

