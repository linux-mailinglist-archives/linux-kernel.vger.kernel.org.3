Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 045A15B11BF
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 03:03:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229954AbiIHBDN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 21:03:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbiIHBDK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 21:03:10 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A5BFC2759
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 18:03:10 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id v1so2931264plo.9
        for <linux-kernel@vger.kernel.org>; Wed, 07 Sep 2022 18:03:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=jvDToQFtXFl/fXXdAtA0T0IxqEcublWPg7VFJpipTAQ=;
        b=pYaGtvp9DqJTmGd3yUvNnTpThOcFlYjDrK6thviuS+GHE8qL2jCjHncZjmeQ6bxyCb
         ZYI1PeF3eZPFDyeC2tAlNwMCFdUTihCfq52aIq8Fk1RtnAXBtUH2lVYeOsDU2yVg8XWJ
         81Q04up7aCATXk0RGEaUWOsjUrl/R0M6VQ5XNlEMcfulSb6ZPWhhqVbmLrjoqk1IKJM2
         1/tLBVc0EdmUO7bX0v/bKvH2qF1dNlKtga3biYGt8c1kkehrT+BqCy4BKR8KUppYarHL
         mKbYxHkIQS7i+wf2eGLnd7Dec9u9WGGcF9gDp1r2oVV4/9e3xKp7sC7BlWGFWVeQeVT3
         Geuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=jvDToQFtXFl/fXXdAtA0T0IxqEcublWPg7VFJpipTAQ=;
        b=7m3GvuDBwTocyu3iN6v2wI5eLODMmbAtMjny0sZ8uFCoMbJnoh/QqODJMD9iLNIaOc
         t9m0dX2FE3zZdWU9enE+h0tOgT45Mra3l43RVtr5AqA+x34br5nUmGZaBQMRq/z2pxKZ
         9XjYzagrdhv2StkDlyYbudnZ97h02Vs20vRwiMoOX55Pb9pQi8nqQU1zt8gEUwgMTows
         q6RqQKfPdXOa732wQW/vKTNqJyemIvDM57sWGCBCdKpwH7oRB4frtm6iEuPgw5uZdF80
         ENqO5mKWWjn6f1ly/arFZacGrftvHsAneI4eAbz2fzC7P4A9CodUblIVBYbfKUSRKSk1
         Kudg==
X-Gm-Message-State: ACgBeo22PwWGY36zui81nX5VcaxQTSLj/q7uqE70up5iUM4EFfh+tPw4
        OB3FEvGpiWAiWE0zeuGXWI6Px178MqY=
X-Google-Smtp-Source: AA6agR6AA9LQedEcnTizibqzbhGgIseP2qpOWJ7Q3eYXI3X3poyls3EL1+szMq9KuUQHVKJgkGTVDA==
X-Received: by 2002:a17:902:ebd2:b0:174:3e94:d01 with SMTP id p18-20020a170902ebd200b001743e940d01mr6903878plg.112.1662598989436;
        Wed, 07 Sep 2022 18:03:09 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id j1-20020a625501000000b0053804c5b4aesm13400502pfb.208.2022.09.07.18.03.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Sep 2022 18:03:08 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: ye.xingchen@zte.com.cn
To:     broonie@kernel.org
Cc:     lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        ckeepax@opensource.cirrus.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, ye xingchen <ye.xingchen@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH linux-next] ASoC: sti-sas: Remove the unneeded result variable
Date:   Thu,  8 Sep 2022 01:03:04 +0000
Message-Id: <20220908010304.342760-1-ye.xingchen@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: ye xingchen <ye.xingchen@zte.com.cn>

Return the value regmap_write() and sti_sas_init_sas_registers() directly
instead of storing it in another redundant variable.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>
---
 sound/soc/codecs/sti-sas.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/sound/soc/codecs/sti-sas.c b/sound/soc/codecs/sti-sas.c
index f076878908ee..99545bcb2ba9 100644
--- a/sound/soc/codecs/sti-sas.c
+++ b/sound/soc/codecs/sti-sas.c
@@ -96,11 +96,8 @@ static int sti_sas_write_reg(void *context, unsigned int reg,
 			     unsigned int value)
 {
 	struct sti_sas_data *drvdata = context;
-	int status;
-
-	status = regmap_write(drvdata->dac.regmap, reg, value);
 
-	return status;
+	return regmap_write(drvdata->dac.regmap, reg, value);
 }
 
 static int  sti_sas_init_sas_registers(struct snd_soc_component *component,
@@ -385,11 +382,8 @@ static int sti_sas_resume(struct snd_soc_component *component)
 static int sti_sas_component_probe(struct snd_soc_component *component)
 {
 	struct sti_sas_data *drvdata = dev_get_drvdata(component->dev);
-	int ret;
 
-	ret = sti_sas_init_sas_registers(component, drvdata);
-
-	return ret;
+	return sti_sas_init_sas_registers(component, drvdata);
 }
 
 static struct snd_soc_component_driver sti_sas_driver = {
-- 
2.25.1
