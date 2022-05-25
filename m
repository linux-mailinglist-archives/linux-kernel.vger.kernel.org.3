Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 560CD533E84
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 16:01:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233870AbiEYN7I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 09:59:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244593AbiEYN6Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 09:58:25 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1845A5AAA;
        Wed, 25 May 2022 06:58:20 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id s188so21303700oie.4;
        Wed, 25 May 2022 06:58:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jigbfHjeWyfJMFDadivDFBM9ghLPytg75FdeUbqDCFM=;
        b=haPiKRgAPRV2kPqf36uQ41Cf/CSFZgrvVIocRjfnxXFj9i4Ub9ndrmXuxZjKyb6Lsu
         1efUQtFDkAXL3n6ExhCeDNqxTwbDZOQz8mJO+gHsVtDudp1TRkmo5cqfcB41Qapyo7SW
         bn8gC5yZEgX2RaL/SGQ+7O1EYlAFq2Bmzqf8lZI6NDwggTYPzrDjYAk3TyGziEXWppDR
         NrrlTkBkhSZhiO/vZ5+z3tie6H/QeLNZk2pr5o8uNTeio1reGGP3rB5bl+BgL/TBmkM3
         g/47V21840YxNm4wd4ZH6u8H1Qc4qYfu81HHahKyUyjc91IepVQmWnkVYg8r82fiUmOO
         4Bdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=jigbfHjeWyfJMFDadivDFBM9ghLPytg75FdeUbqDCFM=;
        b=WU48DWAMsZ6Y61rgqw2dBTvG9QOzTD+eWtTDQH83RVSZiOVLXnusELjmrryirOtUsG
         kxbkHSlQ8DlTpmxgRRr8T3TZwBkQNPoOe3PHa6KxXR/9RIXZO31rNvSgjQabQKJ7gCzU
         Y2K5dNUR8YjCh0PRipqr0h+5oWNvqWbaAJuAarBYq7BmPqEfu7HcpIUQqirGygZxyZZp
         N9oqXOvPV2wgoqeKX1/LNOvF34sUO6MlV1t6TYhAg9Q2S2IsPvjN4LOJwfeER1omrNCT
         5vbGN5FQLz7nD0kWBvo0UoWoe4uKs5aRO1SpRZDA01fM+M9tcKtofV3A1+0VrGYKdM8l
         sPfw==
X-Gm-Message-State: AOAM533u9dMl0T5Wjp4TPeKrx1uwzjxb4KZdsVJ6XzBbYt48Oz22otsn
        yrSALsXi1lxpCTTPhH/lem2MfAAKQ1Qo6w==
X-Google-Smtp-Source: ABdhPJzolhQsMlfgb+N6N2oEz/uyT8sIiBibp/lNR4DcI7IL/glhO6W4c8fk9ddkreOwK0+K0YB5wQ==
X-Received: by 2002:a05:6808:1285:b0:32b:91f2:248a with SMTP id a5-20020a056808128500b0032b91f2248amr2961019oiw.155.1653487100187;
        Wed, 25 May 2022 06:58:20 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id y2-20020a056870e50200b000e686d13890sm5918445oag.42.2022.05.25.06.58.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 May 2022 06:58:19 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
To:     linux-hwmon@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
        Slawomir Stepien <sst@poczta.fm>,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 10/40] hwmon: (lm90) Enable full PEC support for ADT7461A
Date:   Wed, 25 May 2022 06:57:28 -0700
Message-Id: <20220525135758.2944744-11-linux@roeck-us.net>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220525135758.2944744-1-linux@roeck-us.net>
References: <20220525135758.2944744-1-linux@roeck-us.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Experiments show that ADT7461A and NCT1008 support PEC, even though it is
not documented. Enable support for it in the driver. Since ADT7461 only
supports partial PEC, this means that the configuration for ADT7461A
needs to be separated from ADT7461.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/lm90.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/hwmon/lm90.c b/drivers/hwmon/lm90.c
index 6c79422da420..42e72702b9a9 100644
--- a/drivers/hwmon/lm90.c
+++ b/drivers/hwmon/lm90.c
@@ -114,7 +114,7 @@ static const unsigned short normal_i2c[] = {
 	0x18, 0x19, 0x1a, 0x29, 0x2a, 0x2b, 0x48, 0x49, 0x4a, 0x4b, 0x4c,
 	0x4d, 0x4e, 0x4f, I2C_CLIENT_END };
 
-enum chips { adm1032, adt7461, g781, lm86, lm90, lm99,
+enum chips { adm1032, adt7461, adt7461a, g781, lm86, lm90, lm99,
 	max6646, max6654, max6657, max6659, max6680, max6696,
 	sa56004, tmp451, tmp461, w83l771,
 };
@@ -207,7 +207,7 @@ enum chips { adm1032, adt7461, g781, lm86, lm90, lm99,
 static const struct i2c_device_id lm90_id[] = {
 	{ "adm1032", adm1032 },
 	{ "adt7461", adt7461 },
-	{ "adt7461a", adt7461 },
+	{ "adt7461a", adt7461a },
 	{ "g781", g781 },
 	{ "lm90", lm90 },
 	{ "lm86", lm86 },
@@ -224,7 +224,7 @@ static const struct i2c_device_id lm90_id[] = {
 	{ "max6681", max6680 },
 	{ "max6695", max6696 },
 	{ "max6696", max6696 },
-	{ "nct1008", adt7461 },
+	{ "nct1008", adt7461a },
 	{ "w83l771", w83l771 },
 	{ "sa56004", sa56004 },
 	{ "tmp451", tmp451 },
@@ -244,7 +244,7 @@ static const struct of_device_id __maybe_unused lm90_of_match[] = {
 	},
 	{
 		.compatible = "adi,adt7461a",
-		.data = (void *)adt7461
+		.data = (void *)adt7461a
 	},
 	{
 		.compatible = "gmt,g781",
@@ -312,7 +312,7 @@ static const struct of_device_id __maybe_unused lm90_of_match[] = {
 	},
 	{
 		.compatible = "onnn,nct1008",
-		.data = (void *)adt7461
+		.data = (void *)adt7461a
 	},
 	{
 		.compatible = "winbond,w83l771",
@@ -360,6 +360,13 @@ static const struct lm90_params lm90_params[] = {
 		.alert_alarms = 0x7c,
 		.max_convrate = 10,
 	},
+	[adt7461a] = {
+		.flags = LM90_HAVE_OFFSET | LM90_HAVE_REM_LIMIT_EXT
+		  | LM90_HAVE_BROKEN_ALERT | LM90_HAVE_EXTENDED_TEMP
+		  | LM90_HAVE_CRIT | LM90_HAVE_PEC,
+		.alert_alarms = 0x7c,
+		.max_convrate = 10,
+	},
 	[g781] = {
 		.flags = LM90_HAVE_OFFSET | LM90_HAVE_REM_LIMIT_EXT
 		  | LM90_HAVE_BROKEN_ALERT | LM90_HAVE_CRIT,
-- 
2.35.1

