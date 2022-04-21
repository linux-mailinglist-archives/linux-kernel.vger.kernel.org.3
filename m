Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7204250A8AB
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 21:02:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1391699AbiDUTEh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 15:04:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386191AbiDUTEf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 15:04:35 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2928C49924
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 12:01:45 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id y10so11871466ejw.8
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 12:01:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=b85JvDSGn8w4tr7JpVbjtxkbsu1O4D+F+hX3OsbfqCs=;
        b=ka0bSzqelK6lJUthcRpFwJgtlNk/odO7kgggb5rUBc+F9MxHrAiagKn17SvGC6jvkl
         BTE5CZ+DkTc2VSfuLv8wBIWTDffVF0jwMdBKR7zX4NT7PHstkijKl8PQtxkOShOghHUz
         bzl8LWmOaNwYy0ryHBX5rA1mezy5nnM/gyp+o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=b85JvDSGn8w4tr7JpVbjtxkbsu1O4D+F+hX3OsbfqCs=;
        b=ngX1GX89L4MKUD2nnuTe/Sb5OYrzI7Exfmw+xLW8P11fbNtn3hfS2S+M8Gax7ab/JV
         3y7Q1/QKoMVgWDoSVpY1haM0HDTZdI1lnryBsiBmGo3YuweFvUNiul5NsE2QRKPThy2R
         RA63/Hlr8FSxLez9PF4UpVeQyRzzBqMjZNip3XttZ2ooZ8E1t8wwg/+lwSwzNf3nYj90
         gWVjlwHpKjGgO+G0qh+QM7rvYlpAabSzIS8y+9HlfiqZFo9zEFec+idKvdTC3pjnvTua
         FJiPXuvgmAbBZBffeRO9KMB1vN/MyOWwL0zj3/jksxz1ltKC+mvjWw1ob5brP5cxXTqt
         GvYQ==
X-Gm-Message-State: AOAM532/DpsFcZzZYu2uzOHhUuI9MYRH6K4Wpz78u5UmKWdfLpfrhwkp
        nW6uekjX+J+gueZg6uW/kvm7SnExieB7BQ==
X-Google-Smtp-Source: ABdhPJxVGUh+88fza3C0hBCin08Pv3Ewf46UwISRqQuu2FYh8ryW+j/atM0tg7WYIEtPnpITj/krSA==
X-Received: by 2002:a17:906:2bcb:b0:6e7:f655:3b96 with SMTP id n11-20020a1709062bcb00b006e7f6553b96mr801376ejg.175.1650567703496;
        Thu, 21 Apr 2022 12:01:43 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.amarulasolutions.com (host-87-0-15-73.retail.telecomitalia.it. [87.0.15.73])
        by smtp.gmail.com with ESMTPSA id s11-20020a170906284b00b006e108693850sm7975142ejc.28.2022.04.21.12.00.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Apr 2022 12:01:04 -0700 (PDT)
From:   Dario Binacchi <dario.binacchi@amarulasolutions.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        Oliver Graute <oliver.graute@kococonnector.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Stephan Gerhold <stephan@gerhold.net>,
        linux-input@vger.kernel.org
Subject: [RESEND PATCH v4 4/6] Input: edt-ft5x06 - show model name by sysfs
Date:   Thu, 21 Apr 2022 21:00:01 +0200
Message-Id: <20220421190003.3228699-5-dario.binacchi@amarulasolutions.com>
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

The model name was printed only if debug mode was enabled. Now you can
always get it from sysfs.

Co-developed-by: Michael Trimarchi <michael@amarulasolutions.com>
Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Acked-by: Oliver Graute <oliver.graute@kococonnector.com>
---

(no changes since v1)

 drivers/input/touchscreen/edt-ft5x06.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/input/touchscreen/edt-ft5x06.c b/drivers/input/touchscreen/edt-ft5x06.c
index 843e8b0522f7..89157deebfcb 100644
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

