Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AE6F561381
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 09:46:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233233AbiF3Hpv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 03:45:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233186AbiF3Hpk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 03:45:40 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05FC03B3E8
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 00:45:40 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id o25so4845564ejm.3
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 00:45:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VBaQhh8M0SGoulgjZzCVQ2UkjFdtWV7Yt+dzNHvww78=;
        b=JCcxg9P/Qzd0goJ7WT9kRMcUwBSR0+QniS+dbJ8ePAquHKkURaZCDhsoeXGDw4Th+p
         pYxS34BY+bL9BH+CUO5St6BRL9iD8ddkcYVr8T1pz1N1stKRy6zMLAScsfLlYZsKL67h
         dKoJ5XuTadatvpcT2QMB/DCK7BbYwY6G1E3Fc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VBaQhh8M0SGoulgjZzCVQ2UkjFdtWV7Yt+dzNHvww78=;
        b=OKY/m2UIHlVMxqF4xEuv7SzF0T/gCTSnuiSwW0gcQ09D9xBKiBjWW0otlm8oYNriB0
         qiZRaO/UaNwAIw88ASuIDH/sP0beqJxijv2mNHXfQpYkeuyuPquKb4GuLR0ffrSB/2dp
         dEe3RY883QO6vDqEpOriKTUeSobijgPRdF4DyFCmGtqE/ftsnijkyR9GVz62H4ref4vJ
         LpD1NIHn8dvuhtgibGraIwh/26QEMpv93fVFq9g9xHoCbZFeElTv8Z4xDfgCQP14/+Xy
         pX/gCpVAqSdx7hPEP4/oRHflcTVkjcwSyyJcDan+TY769bc4F8BG6zCho6zlMV0tPT7e
         G0gg==
X-Gm-Message-State: AJIora9ArWItdhjdPBgHUC4HnoBMl28oblkxDOR0OAb0JdLJdg7y6OW7
        g2/06EY7bL19DUg84uBbdpf7lQ==
X-Google-Smtp-Source: AGRyM1sDgEvklapqUFjo5inrAdF/mgAhHliKgdgUttcbfqZDFoCqIsitSjQSSgoZ1BPm6ZU7nGW4gw==
X-Received: by 2002:a17:907:7fa9:b0:711:d214:36cd with SMTP id qk41-20020a1709077fa900b00711d21436cdmr7285524ejc.600.1656575138524;
        Thu, 30 Jun 2022 00:45:38 -0700 (PDT)
Received: from tom-ThinkPad-T14s-Gen-2i.station (net-188-217-58-216.cust.vodafonedsl.it. [188.217.58.216])
        by smtp.gmail.com with ESMTPSA id b13-20020aa7c90d000000b0043564320274sm12594731edt.19.2022.06.30.00.45.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jun 2022 00:45:38 -0700 (PDT)
From:   Tommaso Merciai <tommaso.merciai@amarulasolutions.com>
To:     tommaso.merciai@amarulasolutions.com
Cc:     linuxfancy@googlegroups.com, linux-amarula@amarulasolutions.com,
        quentin.schulz@theobroma-systems.com,
        Jacopo Mondi <jacopo@jmondi.org>,
        Sakari Ailus <sakari.ailus@iki.fi>,
        Daniel Scally <djrscally@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 6/6] media: ov5693: add ov5693_of_match, dts support
Date:   Thu, 30 Jun 2022 09:45:25 +0200
Message-Id: <20220630074525.481790-7-tommaso.merciai@amarulasolutions.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220630074525.481790-1-tommaso.merciai@amarulasolutions.com>
References: <20220630074525.481790-1-tommaso.merciai@amarulasolutions.com>
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

Add ov5693_of_match. Device tree support

Signed-off-by: Tommaso Merciai <tommaso.merciai@amarulasolutions.com>
Reviewed-by: Jacopo Mondi <jacopo@jmondi.org>
Reviewed-by: Sakari Ailus <sakari.ailus@iki.fi>
---
Changes since v2:
 - Change patch order 7 -> 6 as suggested by Sakari
 - Add missing signed-off as suggested by Jacopo

Changes since v3:
 - Add reviewed-by tags, suggested by Jacopo, Krzysztof

 drivers/media/i2c/ov5693.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/media/i2c/ov5693.c b/drivers/media/i2c/ov5693.c
index 3c805a5a5181..5930207193c7 100644
--- a/drivers/media/i2c/ov5693.c
+++ b/drivers/media/i2c/ov5693.c
@@ -1532,10 +1532,17 @@ static const struct acpi_device_id ov5693_acpi_match[] = {
 };
 MODULE_DEVICE_TABLE(acpi, ov5693_acpi_match);
 
+static const struct of_device_id ov5693_of_match[] = {
+	{ .compatible = "ovti,ov5693", },
+	{ /* sentinel */ },
+};
+MODULE_DEVICE_TABLE(of, ov5693_of_match);
+
 static struct i2c_driver ov5693_driver = {
 	.driver = {
 		.name = "ov5693",
 		.acpi_match_table = ov5693_acpi_match,
+		.of_match_table = ov5693_of_match,
 		.pm = &ov5693_pm_ops,
 	},
 	.probe_new = ov5693_probe,
-- 
2.25.1

