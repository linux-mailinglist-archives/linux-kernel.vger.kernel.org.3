Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C27195693F5
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 23:13:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234491AbiGFVMn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 17:12:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234378AbiGFVMl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 17:12:41 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45C725FD3;
        Wed,  6 Jul 2022 14:12:40 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id fd6so20795455edb.5;
        Wed, 06 Jul 2022 14:12:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nLoYnjJYaMuUjmUl/SNVFnEZOR1w2Ji861IF7OAgh9o=;
        b=ma50mw4u5WYVMc6RSKXK+AkZv5yFmXXkZtLIQiTH7JOikTr5cY478/HZfTPOUk0/re
         AEF6m/hsyJpAt+4sm6C54s6K/iVt+Ajg9i9RtF/e31tjW+Q3kED+5u9PN5dqrOzi3ZFo
         T+83Igiu3hBTNyNfk7SBoXYFWd+Q3zjWQLji0onPRxwO3FSObnFRIizkqfEddwVUQXHU
         4f3EXF9dH88K6Vhmfa2fwzPExjQaLUz3aurJkA43NxPLoNsjXOjiww9OJc8QWcAMQTzg
         ktLibi8Pm4yWHoCIChEcRT4PVynGoXaJYsVYkB6AunAR/Wzp+k+tgXHkEz/miqfs3bZ8
         b3uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nLoYnjJYaMuUjmUl/SNVFnEZOR1w2Ji861IF7OAgh9o=;
        b=tPIQCEmLloY6nE8EIsul36o6AAbh5HpwS3/8qC5B2XmMi59+L3/0O18+0mTGu0c2HR
         fDe1Q9VRTU/qngCbzIl1tuYftry6PWT7QUbc2DGLPobcfcCGjnAD72xnQt8uIBcYf8zG
         kt2igFOByVrAA6tV3TxHaDM43eOD95MSHjMWqVDVynID8SeM0wud37sYn+ff1iaNjLO7
         iKQvak7YN3024gs4d+Rt7Q3/cm2ZXfbz2qdCP8CQdFYBrVkqw2cXUTe4ssA+OlHQ2GyI
         0dGoG4VBRk12Zpoho7fmgbLAsIPbrRbyYrPcP4VJ0FMfpKqYYgAH7doGUyPNFvRuqAlv
         D4jg==
X-Gm-Message-State: AJIora8uBpIMhkomyILW3NjCiuak9IQqD3JfFkIVUsGxTr3oz7P8HJBV
        3LVcN4jufE8J11WNPNDNArU=
X-Google-Smtp-Source: AGRyM1uvPqutBp4Awj0Z7Ils1JxvC8YMnPUI9lgklsEXrLB8BAhEEFSDxxc56PyKsgIBVRqlML8P0Q==
X-Received: by 2002:a05:6402:c48:b0:437:d938:9691 with SMTP id cs8-20020a0564020c4800b00437d9389691mr56178570edb.254.1657141958925;
        Wed, 06 Jul 2022 14:12:38 -0700 (PDT)
Received: from localhost (92.40.202.8.threembb.co.uk. [92.40.202.8])
        by smtp.gmail.com with ESMTPSA id 8-20020a170906300800b0072aadbd48c7sm6631357ejz.84.2022.07.06.14.12.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jul 2022 14:12:38 -0700 (PDT)
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     paul@crapouillou.net, lgirdwood@gmail.com, broonie@kernel.org,
        perex@perex.cz, tiwai@suse.com
Cc:     linux-mips@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 01/11] ASoC: jz4740-i2s: Remove Open Firmware dependency
Date:   Wed,  6 Jul 2022 22:13:20 +0100
Message-Id: <20220706211330.120198-2-aidanmacdonald.0x0@gmail.com>
In-Reply-To: <20220706211330.120198-1-aidanmacdonald.0x0@gmail.com>
References: <20220706211330.120198-1-aidanmacdonald.0x0@gmail.com>
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

This driver doesn't require Open Firmware support. Remove the
OF-specific includes and drop the Kconfig dependency.

Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
---
 sound/soc/jz4740/Kconfig      | 2 +-
 sound/soc/jz4740/jz4740-i2s.c | 3 +--
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/sound/soc/jz4740/Kconfig b/sound/soc/jz4740/Kconfig
index 29144720cb62..e72f826062e9 100644
--- a/sound/soc/jz4740/Kconfig
+++ b/sound/soc/jz4740/Kconfig
@@ -2,7 +2,7 @@
 config SND_JZ4740_SOC_I2S
 	tristate "SoC Audio (I2S protocol) for Ingenic JZ4740 SoC"
 	depends on MIPS || COMPILE_TEST
-	depends on OF && HAS_IOMEM
+	depends on HAS_IOMEM
 	select SND_SOC_GENERIC_DMAENGINE_PCM
 	help
 	  Say Y if you want to use I2S protocol and I2S codec on Ingenic JZ4740
diff --git a/sound/soc/jz4740/jz4740-i2s.c b/sound/soc/jz4740/jz4740-i2s.c
index 79afac0c5003..298ff0a83931 100644
--- a/sound/soc/jz4740/jz4740-i2s.c
+++ b/sound/soc/jz4740/jz4740-i2s.c
@@ -5,10 +5,9 @@
 
 #include <linux/init.h>
 #include <linux/io.h>
-#include <linux/of.h>
-#include <linux/of_device.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/mod_devicetable.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
 
-- 
2.35.1

