Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 368FF4CFF85
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 14:04:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242742AbiCGNFU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 08:05:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241944AbiCGNFQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 08:05:16 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C6228B6C2
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 05:04:21 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id v1-20020a17090a088100b001bf25f97c6eso6399856pjc.0
        for <linux-kernel@vger.kernel.org>; Mon, 07 Mar 2022 05:04:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=JXzVQ2ZdweQIJEbxKcie2X+tclhUtVN1X52+YVLb9ho=;
        b=hNqgxl7RZ8Mz040Am5Mimahm0M96u9CqSIyWge99EgmYicdlsy6/4yXWTt1VRmYceo
         a4Qx+jCcdhcD4oOshOyNqiez1FjjwI5PR/N0MGQma0EtRXD/jxchdtQwxKc8Uyqff6/c
         1F+WlFB0HjdbdxqwPArIWmStkvMUZkgeGFd/MIsPiMbGjAXCPfWMmYihRs3P1/6b5RVv
         0DAtxY4e0C/FFcFDzaNu3mqIQSpe/GTuJVvJI7jyjjfYqe59p7Oc2JUpKxbP3HeOsaLf
         RW9cLtWOiUMqgj54p7Gp2ozGtg1sm3RlITsynlUdPdUfXQ+D8g9AlbHGjROY4NxISx2s
         Fwwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=JXzVQ2ZdweQIJEbxKcie2X+tclhUtVN1X52+YVLb9ho=;
        b=cBZJBzBcK3qBAkT74qLLx1YpSX1GtswVicdpEpNa+i9wzifIC33eOUdxMXKtpf0b2k
         zjNV6sr5qxuCjdPH+K3yTBv18p9L4a+Xhl8Cg0WcgZwxzgEkamnuFnyaT/t6x3OLp/Cc
         au3pS6KTOti4kHyqc94vbuwrTLOPfwopoh+C5CcBKssHR6D4iIMFdejXAbyTqMnx00zs
         cdzL9+RXF472p1pmeXyQftpT9AdDRnmUSGWBDY9M7wJoUVCORVp9WVXA+DyNGktxVQQc
         klXl/q53i69i9qsZt6fFoBh/Yorm6NCuBdmAUL6HFiXv86HTOSLUtT/CRSa46K9qTiMo
         cdVw==
X-Gm-Message-State: AOAM532/haAusKAY16cnXfIV40uarm7zZnmTHFUPGqa9tWYgSsyM2K69
        HLln3dt73k/Xdh8aohl+kLI=
X-Google-Smtp-Source: ABdhPJxyQZKjSR7O+jwWjm2Gm0nSCiz028BLT0JG5cVW38JeaVoEIj4UC0qg9LQoFwz0NAFzxiPbHw==
X-Received: by 2002:a17:90a:1941:b0:1bf:3918:d49e with SMTP id 1-20020a17090a194100b001bf3918d49emr12833754pjh.136.1646658261409;
        Mon, 07 Mar 2022 05:04:21 -0800 (PST)
Received: from localhost.localdomain ([159.226.95.43])
        by smtp.googlemail.com with ESMTPSA id y12-20020a62640c000000b004f104f0ee75sm15099513pfb.185.2022.03.07.05.04.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 05:04:21 -0800 (PST)
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
Subject: [PATCH] ASoC: atmel: Fix error handling in snd_proto_probe
Date:   Mon,  7 Mar 2022 13:04:14 +0000
Message-Id: <20220307130415.5720-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.17.1
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
---
 sound/soc/atmel/mikroe-proto.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/sound/soc/atmel/mikroe-proto.c b/sound/soc/atmel/mikroe-proto.c
index 627564c18c27..9ed634ee9dfc 100644
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
@@ -136,18 +138,21 @@ static int snd_proto_probe(struct platform_device *pdev)
 		dai_fmt |= snd_soc_daifmt_parse_clock_provider_as_flag(np, NULL);
 	}
 
-	of_node_put(bitclkmaster);
-	of_node_put(framemaster);
-	dai->dai_fmt = dai_fmt;
 
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

