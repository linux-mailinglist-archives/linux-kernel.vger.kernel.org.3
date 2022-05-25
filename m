Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCF26533EA7
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 16:03:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244678AbiEYOCB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 10:02:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244651AbiEYN7d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 09:59:33 -0400
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com [IPv6:2001:4860:4864:20::2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8FAAAEE3D;
        Wed, 25 May 2022 06:59:00 -0700 (PDT)
Received: by mail-oa1-x2e.google.com with SMTP id 586e51a60fabf-f2c296d320so1897598fac.8;
        Wed, 25 May 2022 06:59:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XUqJGLuP/c7Bm/TAQRQJphmcdhLgiPPwGVlgWtslK8E=;
        b=Jle2CO9DBrH3quxzKlYFFFWVWkxYAVm5wDBC7rMy/1nMWjdcYxRuzxIWyiqM+fD+bd
         QS40jJABtqXEx8xWSsPORNTPZnLA1WXGyXJb9Q1KaPXc1T+wK+b92cmfMXzdLXKr+DeA
         vuituOqNokc6raPS0FRUiNzpkV6DNmOg9Kp56aAkWol6vShSlaXAsWQEnJbD8ZdHnyNu
         Jl0AaVrSlXSmO/+tT1d6z7eS3xTSHI4JXaf8zyjyXw9ji47vB1BrFR0a2xq5Ju1GpFUi
         petw0VBD7M/u7u7uc8QVg9optpv0jWdDcoc5hIBVXyt3SSdiGG/VtcnwdhZFj55YYK7l
         Y9Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=XUqJGLuP/c7Bm/TAQRQJphmcdhLgiPPwGVlgWtslK8E=;
        b=2nlJ2FbScl5YmEwrRmJ60LGYCRRc5Q3ORAS7OqW6b8Ak3UvJzOC90WqlKY+7l5w3v0
         +yKcE0K9Sr+850ToUftx2UzfP0M2w3tIKVy4ZJardksghzg3AgECrdpSoIaAtR0tQ8v+
         TNL9b/w3EpBkgdzsYVzke+eEk8+yzDwWtQVVOK1cIl7OIdlrtSNLa1BlzE6CAATDz4JX
         srAKMSQz4YYW/a1PE5P2rLAlq+slcbv3b1DzDz5njpwFkv9Rk3MwwW5cIwOEIannQ3v8
         oQEb2OY9XNYevSjDmqBuKBPcJKcye4DkLojWp/6FqFrV4kcAexmYkqOwJSEZYMf4iMqU
         wXrg==
X-Gm-Message-State: AOAM530rd1AUDW8IN5jIsVz4SuYiSAOK3jSuxq89VFNHxZislt5nuJgI
        iNaeypEO4V8b4mBUxAH4vpxbnt2AeLtNOQ==
X-Google-Smtp-Source: ABdhPJwb/6EK4UvnLeRp3uMGQ2Xlq5DwSRlsPo+Px8mYXvLtSM0/0RWrpXtv3G87HnGHQiTeXabuAw==
X-Received: by 2002:a05:6870:538d:b0:de:aa91:898e with SMTP id h13-20020a056870538d00b000deaa91898emr5581582oan.54.1653487139995;
        Wed, 25 May 2022 06:58:59 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id n186-20020a4a53c3000000b0035f627ac898sm4113784oob.10.2022.05.25.06.58.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 May 2022 06:58:59 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
To:     linux-hwmon@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
        Slawomir Stepien <sst@poczta.fm>,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 31/40] hwmon: (lm90) Combine lm86 and lm90 configuration
Date:   Wed, 25 May 2022 06:57:49 -0700
Message-Id: <20220525135758.2944744-32-linux@roeck-us.net>
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

LM86 and LM90 support exactly the same features, so there is no need
to keep their configuration options separate. Combine to reduce data
size.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/lm90.c | 17 +++++------------
 1 file changed, 5 insertions(+), 12 deletions(-)

diff --git a/drivers/hwmon/lm90.c b/drivers/hwmon/lm90.c
index 97453a7de1fa..16481051a530 100644
--- a/drivers/hwmon/lm90.c
+++ b/drivers/hwmon/lm90.c
@@ -123,7 +123,7 @@ static const unsigned short normal_i2c[] = {
 	0x4d, 0x4e, 0x4f, I2C_CLIENT_END };
 
 enum chips { adm1023, adm1032, adt7461, adt7461a, adt7481,
-	g781, lm84, lm86, lm90, lm99,
+	g781, lm84, lm90, lm99,
 	max1617, max6642, max6646, max6648, max6654, max6657, max6659, max6680, max6696,
 	sa56004, tmp451, tmp461, w83l771,
 };
@@ -235,8 +235,8 @@ static const struct i2c_device_id lm90_id[] = {
 	{ "g781", g781 },
 	{ "gl523sm", max1617 },
 	{ "lm84", lm84 },
-	{ "lm86", lm86 },
-	{ "lm89", lm86 },
+	{ "lm86", lm90 },
+	{ "lm89", lm90 },
 	{ "lm90", lm90 },
 	{ "lm99", lm99 },
 	{ "max1617", max1617 },
@@ -289,11 +289,11 @@ static const struct of_device_id __maybe_unused lm90_of_match[] = {
 	},
 	{
 		.compatible = "national,lm86",
-		.data = (void *)lm86
+		.data = (void *)lm90
 	},
 	{
 		.compatible = "national,lm89",
-		.data = (void *)lm86
+		.data = (void *)lm90
 	},
 	{
 		.compatible = "national,lm99",
@@ -443,13 +443,6 @@ static const struct lm90_params lm90_params[] = {
 		.flags = LM90_HAVE_ALARMS,
 		.resolution = 8,
 	},
-	[lm86] = {
-		.flags = LM90_HAVE_OFFSET | LM90_HAVE_REM_LIMIT_EXT
-		  | LM90_HAVE_CRIT | LM90_HAVE_ALARMS | LM90_HAVE_LOW
-		  | LM90_HAVE_CONVRATE | LM90_HAVE_REMOTE_EXT,
-		.alert_alarms = 0x7b,
-		.max_convrate = 9,
-	},
 	[lm90] = {
 		.flags = LM90_HAVE_OFFSET | LM90_HAVE_REM_LIMIT_EXT
 		  | LM90_HAVE_CRIT | LM90_HAVE_ALARMS | LM90_HAVE_LOW
-- 
2.35.1

