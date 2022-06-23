Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 384E3558A87
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 23:14:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230177AbiFWVN7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 17:13:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230045AbiFWVNk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 17:13:40 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FF2B5133C
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 14:13:39 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id l126-20020a1c2584000000b0039c1a10507fso427106wml.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 14:13:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yGdqQ4oAuggJEmpNM1D1Sw+hLvuTVREq9oE+Alw71tA=;
        b=UakyC0v/Hrh2824Aqybuwxif2gEioO2b7Sf1r9Na9QA+QN7/5sfsN3t2M3YT46lZrH
         cC3mdOfG4n8TjHp596Czsytxl3HwwaZAySClyl+6ZD4Z0gaXNAhN56arW1GjqN94fKt5
         jpydmLF80JbtuA1Q9q6T6iNEQwq5YUaOLERY7r9FgjY0g1L6eprVBnBb0b0W/q/gnlkC
         k+bmfLbl8mPt7dkgmvuTJk9HOurCkED0c2j0DGrFnV4CduAo3xwvPK+3pDWK8dg0kQWR
         xTjGoq1nhxwOK5wXV5vPegb+G3RK95a0lDL9pHD1q4ogc0N2KOkcjkY1PS1u+bGerkKo
         0XfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yGdqQ4oAuggJEmpNM1D1Sw+hLvuTVREq9oE+Alw71tA=;
        b=fqJuuTPozUPM6HaJd4OHXpenTuSqiqNhJGdRyyf+XW9F0OqYOgZkqGwOD5Lx60nLHv
         dAJzFcF8O3wQ3+Mw7rbTpTPgyMzmUuhMYF39opOcT6ljmf2IxBJGC/DKap17ucH5VIZW
         aTIuJIxrbt+jmOicBeiXmHYdwAt5ibmDmfTil5VqndgdZ2qglbMeRubehzCZYreamKAq
         Zkq6DTyBeS/7xLXH3x/X1D2Dacv3bmHqFcwaOi2OhLV2c9+Znye7ttCZ08nVmeRovUWb
         XXzj1igrahu5Fj1kDfNujLoyleWQaiSqEgYYpU+6jFriMCiGOJpnOq/r3fScrA+Ja+8l
         JZVA==
X-Gm-Message-State: AJIora9bfIBqAjFj7SjYuaIFv2lJrHwqwHHmueWEfS/cMoBSimUXnVmh
        DUEpvDB/aDw9I4jSlFE2Ffg=
X-Google-Smtp-Source: AGRyM1tIhQE9Sjr3YNubI5e68iAaqJex/k2T0jRFnMVJDWS166kL60cHijoh/PbTHpTAMCe0R4Q2nw==
X-Received: by 2002:a05:600c:247:b0:39c:8088:68fe with SMTP id 7-20020a05600c024700b0039c808868femr6343596wmj.162.1656018817496;
        Thu, 23 Jun 2022 14:13:37 -0700 (PDT)
Received: from localhost (92.40.171.44.threembb.co.uk. [92.40.171.44])
        by smtp.gmail.com with ESMTPSA id 10-20020a05600c26ca00b003973b9d0447sm5070980wmv.36.2022.06.23.14.13.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jun 2022 14:13:37 -0700 (PDT)
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     broonie@kernel.org
Cc:     gregkh@linuxfoundation.org, rafael@kernel.org,
        andy.shevchenko@gmail.com, mazziesaccount@gmail.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 07/12] regmap-irq: Refactor checks for status bulk read support
Date:   Thu, 23 Jun 2022 22:14:15 +0100
Message-Id: <20220623211420.918875-8-aidanmacdonald.0x0@gmail.com>
In-Reply-To: <20220623211420.918875-1-aidanmacdonald.0x0@gmail.com>
References: <20220623211420.918875-1-aidanmacdonald.0x0@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are several conditions that must be satisfied to support
bulk read of status registers. Move the check into a function
to avoid duplicating it in two places.

Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
---
 drivers/base/regmap/regmap-irq.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/base/regmap/regmap-irq.c b/drivers/base/regmap/regmap-irq.c
index 7e93dd8af56b..5f9a5856c45e 100644
--- a/drivers/base/regmap/regmap-irq.c
+++ b/drivers/base/regmap/regmap-irq.c
@@ -73,6 +73,14 @@ struct regmap_irq *irq_to_regmap_irq(struct regmap_irq_chip_data *data,
 	return &data->chip->irqs[irq];
 }
 
+static bool regmap_irq_can_bulk_read_status(struct regmap_irq_chip_data *data)
+{
+	struct regmap *map = data->map;
+
+	return data->irq_reg_stride == 1 && map->reg_stride == 1 &&
+	       !map->use_single_read;
+}
+
 static void regmap_irq_lock(struct irq_data *data)
 {
 	struct regmap_irq_chip_data *d = irq_data_get_irq_chip_data(data);
@@ -467,8 +475,7 @@ static irqreturn_t regmap_irq_thread(int irq, void *d)
 			}
 
 		}
-	} else if (!map->use_single_read && map->reg_stride == 1 &&
-		   data->irq_reg_stride == 1) {
+	} else if (regmap_irq_can_bulk_read_status(data)) {
 
 		u8 *buf8 = data->status_reg_buf;
 		u16 *buf16 = data->status_reg_buf;
@@ -729,8 +736,7 @@ int regmap_add_irq_chip_fwnode(struct fwnode_handle *fwnode,
 	else
 		d->irq_reg_stride = 1;
 
-	if (!map->use_single_read && map->reg_stride == 1 &&
-	    d->irq_reg_stride == 1) {
+	if (regmap_irq_can_bulk_read_status(d)) {
 		d->status_reg_buf = kmalloc_array(chip->num_regs,
 						  map->format.val_bytes,
 						  GFP_KERNEL);
-- 
2.35.1

