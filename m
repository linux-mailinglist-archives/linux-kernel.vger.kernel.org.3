Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6EBA4B3C71
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Feb 2022 18:16:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237328AbiBMRQQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Feb 2022 12:16:16 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237332AbiBMRQP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Feb 2022 12:16:15 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 418D3593BE
        for <linux-kernel@vger.kernel.org>; Sun, 13 Feb 2022 09:16:09 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id y17so21900906edd.10
        for <linux-kernel@vger.kernel.org>; Sun, 13 Feb 2022 09:16:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=S/AsjkW3t1KrHMKTVETxff67/Nhsqoh6KaKB0r1nIHg=;
        b=OhSfpnRD1YPDchKrwVRFJJYXMk6u5meI3NMZMrYecw0xMUGolwUHGc4TvGAdcbOxKk
         ElDkIIplEyEzpiVNPQaVGtjMFbS8/eGfUDk04HDOMtV+4vMuXoQbryADR3Qh1cnUiCf9
         h4uoxj3FF1vTgabKpTjPExR5YPRqDhykRrgRA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=S/AsjkW3t1KrHMKTVETxff67/Nhsqoh6KaKB0r1nIHg=;
        b=Wyg1K1Sor6RyoSsSTUeRmlgL2gHJ7lOboMc4dq6ULqR3QiJl3ZyvbzghOwWd92ZSGT
         DKou6PJaJXVOKhUU2fVlFqSuejZle/iKK1kMzNPRZ9AMgT87cOtTkAGPnJSHSZlWmNmU
         scFnUAZ8th9OP+Ix2gS8Yn8dZoDa+hNMu9hREEpFoNHWUckUBJRBLsTy7qnliUNULgnz
         dwRAG5HoCLKRL3N96yfIrQ2u6NyjWz8PSK0le6ZyvqznPnxUFnI//28hfoziOUy3j8cE
         5+F6mOsOyDkmhMbLpxSKx5h9nSG41Aba5PT88U2H+BcYPOAtqILbK86HVtuNnPzkj3r9
         7yug==
X-Gm-Message-State: AOAM530LEkUEE151vcKJ5T9OGoiHzQZQ1wXkRLFyuRI3rMLseSfSpwnM
        t8JwxKI/BqIBpD4b7RogcVyKrEBUY0gk1w==
X-Google-Smtp-Source: ABdhPJxrhwPuYKOdIizMvYFMLYKBgKqQ2+EcHj42DduLcW8oPZq34Prkn2uqnjs7rfzzQAlyou1mEg==
X-Received: by 2002:a05:6402:2947:: with SMTP id ed7mr11924581edb.141.1644772567637;
        Sun, 13 Feb 2022 09:16:07 -0800 (PST)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it (host-82-52-8-210.retail.telecomitalia.it. [82.52.8.210])
        by smtp.gmail.com with ESMTPSA id o10sm6598878ejj.6.2022.02.13.09.16.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Feb 2022 09:16:07 -0800 (PST)
From:   Dario Binacchi <dario.binacchi@amarulasolutions.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Marco Felsch <m.felsch@pengutronix.de>,
        Oliver Graute <oliver.graute@kococonnector.com>,
        Stephan Gerhold <stephan@gerhold.net>,
        linux-input@vger.kernel.org
Subject: [PATCH 4/6] Input: edt-ft5x06 - show model name by sysfs
Date:   Sun, 13 Feb 2022 18:15:30 +0100
Message-Id: <20220213171532.346270-5-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220213171532.346270-1-dario.binacchi@amarulasolutions.com>
References: <20220213171532.346270-1-dario.binacchi@amarulasolutions.com>
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

The model name was printed only if debug mode was enabled. Now you can
always get it from sysfs.

Co-developed-by: Michael Trimarchi <michael@amarulasolutions.com>
Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
---

 drivers/input/touchscreen/edt-ft5x06.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/input/touchscreen/edt-ft5x06.c b/drivers/input/touchscreen/edt-ft5x06.c
index b3e492cfc41c..eb1231d1c0b4 100644
--- a/drivers/input/touchscreen/edt-ft5x06.c
+++ b/drivers/input/touchscreen/edt-ft5x06.c
@@ -529,6 +529,17 @@ static EDT_ATTR(threshold, S_IWUSR | S_IRUGO, WORK_REGISTER_THRESHOLD,
 static EDT_ATTR(report_rate, S_IWUSR | S_IRUGO, WORK_REGISTER_REPORT_RATE,
 		M12_REGISTER_REPORT_RATE, NO_REGISTER, 0, 255);
 
+static ssize_t model_show(struct device *dev, struct device_attribute *attr,
+			  char *buf)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct edt_ft5x06_ts_data *tsdata = i2c_get_clientdata(client);
+
+	return scnprintf(buf, PAGE_SIZE, "%s\n", tsdata->name);
+}
+
+static DEVICE_ATTR_RO(model);
+
 static struct attribute *edt_ft5x06_attrs[] = {
 	&edt_ft5x06_attr_gain.dattr.attr,
 	&edt_ft5x06_attr_offset.dattr.attr,
@@ -536,6 +547,7 @@ static struct attribute *edt_ft5x06_attrs[] = {
 	&edt_ft5x06_attr_offset_y.dattr.attr,
 	&edt_ft5x06_attr_threshold.dattr.attr,
 	&edt_ft5x06_attr_report_rate.dattr.attr,
+	&dev_attr_model.attr,
 	NULL
 };
 
-- 
2.32.0

