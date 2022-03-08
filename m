Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E0884D0D9A
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 02:40:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244553AbiCHBlV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 20:41:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234625AbiCHBlT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 20:41:19 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81CC93916D
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 17:40:24 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id mv5-20020a17090b198500b001bf2a039831so829610pjb.5
        for <linux-kernel@vger.kernel.org>; Mon, 07 Mar 2022 17:40:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2oZHqNig67lQrBY101pOAHHtLLvXMV3c8bnYL4oUFgs=;
        b=BqC3IovNxG0EX5R6eBwELil4WePyK5xpcSbZKRaGDvvWQv34opW72yKZwwI0ZERwOy
         +q3qkTj8qt2V2lOoPUQusa1YS2V2olRuJFZ4SBpb8q1CVMrRLUdR9981BNODggbtVCme
         dE/RoJ4lXkgCw592blfxLHs1wuvI7YBy+YUdQ6cvp5VtrmI5IBtsaWat8+olN5zakUjC
         7dolRIi314WCbw8yMDCVQ8eyH0JLtoPmwWweeGUHBeui/Y+MmyOMZQ/KAFbsolZcm7fa
         HVxTYqIyWcebbu0sqMVq6Wx5S32fyUmQzMNEqbKDyV1n0YXiZ77VTcOj6jOvPTKgBMSh
         dmzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2oZHqNig67lQrBY101pOAHHtLLvXMV3c8bnYL4oUFgs=;
        b=rllMRew8vdHV+qMP4M6YblmlK5VDgpopuW7A3mopeabbhgQe0eKyldqoAQr6IBCskB
         BNpDI96oEubdTBdjn/agFIh3tIX+H+n+u6VnSswpOboq9H06Tmwb8qzmdSyjso7Jr35R
         LRY8aGukmajZnv+Y4APXteTAIj/mjLd+JbiIb6zC6Nm8QrLECUSudfQWBjbfz+1uDNoj
         yiGX8tGIBeRHsPzIAANlY5bebiai89mAw/b4CBAQI7mgJ6k4M1bYpC25i3jveVQDAKQe
         4C4/MRMqJ4P3NFZUhQN+w6TtIl5eah9rFgdKNnHf5nOmP/WVn8ZUZd2oLzyhBbkUdPSm
         dmLA==
X-Gm-Message-State: AOAM532zDgzpz76m4X0TyomxViW6AN3OuFNTYXPMMwve/63Ph8rG5xav
        LAyWM6UI+ApiP/NiUQJVGFCO54cp7yWps6IKBCqTiQ==
X-Google-Smtp-Source: ABdhPJxEA3atALbfBSMj03rRMPNFxv4vBrK8TkDMyB2LCuJkL3ERSbUrRspo08Cewso0/CaU3sS9Og==
X-Received: by 2002:a17:90a:7e95:b0:1bc:5d56:8d4c with SMTP id j21-20020a17090a7e9500b001bc5d568d4cmr1989175pjl.93.1646703623972;
        Mon, 07 Mar 2022 17:40:23 -0800 (PST)
Received: from localhost.localdomain ([159.226.95.43])
        by smtp.googlemail.com with ESMTPSA id e14-20020a056a001a8e00b004e136d54a15sm17858175pfv.105.2022.03.07.17.40.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 17:40:23 -0800 (PST)
From:   Miaoqian Lin <linmq006@gmail.com>
To:     Codrin Ciubotariu <codrin.ciubotariu@microchip.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Florian Meier <florian.meier@koalo.de>,
        alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     linmq006@gmail.com
Subject: [PATCH v2] ASoC: atmel: Fix error handling in snd_proto_probe
Date:   Tue,  8 Mar 2022 01:39:48 +0000
Message-Id: <20220308013949.20323-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <582c39ac-3099-d54f-5de3-d54a4ace0a04@microchip.com>
References: <582c39ac-3099-d54f-5de3-d54a4ace0a04@microchip.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The device_node pointer is returned by of_parse_phandle()  with refcount
incremented. We should use of_node_put() on it when done.

This function only calls of_node_put() in the regular path.
And it will cause refcount leak in error paths.
Fix this by calling of_node_put() in error handling too.

Fixes: a45f8853a5f9 ("ASoC: Add driver for PROTO Audio CODEC (with a WM8731)")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
Reviewed-by: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
---
changes in v2:
- remove extra line.
---
 sound/soc/atmel/mikroe-proto.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/sound/soc/atmel/mikroe-proto.c b/sound/soc/atmel/mikroe-proto.c
index 627564c18c27..ce46d8a0b7e4 100644
--- a/sound/soc/atmel/mikroe-proto.c
+++ b/sound/soc/atmel/mikroe-proto.c
@@ -115,7 +115,8 @@ static int snd_proto_probe(struct platform_device *pdev)
 	cpu_np = of_parse_phandle(np, "i2s-controller", 0);
 	if (!cpu_np) {
 		dev_err(&pdev->dev, "i2s-controller missing\n");
-		return -EINVAL;
+		ret = -EINVAL;
+		goto put_codec_node;
 	}
 	dai->cpus->of_node = cpu_np;
 	dai->platforms->of_node = cpu_np;
@@ -125,7 +126,8 @@ static int snd_proto_probe(struct platform_device *pdev)
 						       &bitclkmaster, &framemaster);
 	if (bitclkmaster != framemaster) {
 		dev_err(&pdev->dev, "Must be the same bitclock and frame master\n");
-		return -EINVAL;
+		ret = -EINVAL;
+		goto put_cpu_node;
 	}
 	if (bitclkmaster) {
 		if (codec_np == bitclkmaster)
@@ -136,18 +138,20 @@ static int snd_proto_probe(struct platform_device *pdev)
 		dai_fmt |= snd_soc_daifmt_parse_clock_provider_as_flag(np, NULL);
 	}
 
-	of_node_put(bitclkmaster);
-	of_node_put(framemaster);
-	dai->dai_fmt = dai_fmt;
-
-	of_node_put(codec_np);
-	of_node_put(cpu_np);
 
+	dai->dai_fmt = dai_fmt;
 	ret = snd_soc_register_card(&snd_proto);
 	if (ret)
 		dev_err_probe(&pdev->dev, ret,
 			"snd_soc_register_card() failed\n");
 
+
+put_cpu_node:
+	of_node_put(bitclkmaster);
+	of_node_put(framemaster);
+	of_node_put(cpu_np);
+put_codec_node:
+	of_node_put(codec_np);
 	return ret;
 }
 
-- 
2.17.1

