Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C93E1524B34
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 13:15:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353157AbiELLPW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 07:15:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353086AbiELLOX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 07:14:23 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FE8B238D77
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 04:13:40 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id c14so4502430pfn.2
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 04:13:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3SloLfFU8a1Q2HMNHKnLwbt6pwT6BUy9sQ/8OgycCqI=;
        b=TWkDoQms83WKpuzTNBdzKvhoODw/n2DKAB8PkH+WiozWmeNSuyjVm2KbSvtlMzMYCU
         5AfE9yC2bc67wnsu2Z8Vv8u3Af/Zzx8mURws2tXG8nDAjzY6OYZb425+fGXR8DRY6LPV
         arSq90SoYNx+KnlokAVjO1vz4A8Wz87mIQWyEvLOI0UCBfKL3NQt1u4ln6YGym9EIWej
         ZiFRbwxPQChV0Bb8ZVLe4FQO06jNZD9Af123ar9N0qMbNk8LMocN60z3oQCYCpzAJx63
         imffSCEagiv0jJexube7LgHVJAdDYLcQEPa9aMbEngNzcN1tzHa0Q3mPlseKS7bfJkgZ
         X4BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3SloLfFU8a1Q2HMNHKnLwbt6pwT6BUy9sQ/8OgycCqI=;
        b=r5JsPqYsKgIr4e0WaWRWAXQNPKvJRrpxVdlPYtCjRAEjCGfgw/rtRpTLg8Rs5uBTk6
         HVhC+2bcyO0Gr4XVYQt1C9pPCoJ0qAch5P6xoFie1c4GHdBJIJoAtTvuiS9ucCpZPtcd
         iUYuOxFM7GBNdqJTnb9hc7CI1Us87N75MtoTW7unnrDj7W+cCl+N9+3JdngthR4bMUuB
         +Q5sKVbapHJ02tcsJc/KEAt5I/Kd07Xb/95VLw+ecqi/a1160VRX2fBidYkSBGckrbC7
         Eu2jx6HJwySQHf4VoECx017rGVuoqAprUfHGhoAcU+8XtdNL4sznttymRUeVxMD7io0j
         TOwg==
X-Gm-Message-State: AOAM532wh4MCK2mIljMnOagT1RUZdE7BfZWnuozXP9eODWUW7+2zQtwn
        z/ygoedLIbN6BRgOSnFCqH4=
X-Google-Smtp-Source: ABdhPJy/350N6jJC6Z1dMu9/mg4+Nu0BAcptLFnUjKHPNCWQopVS3tO4EUk5mkrlt09q3p5haIZgow==
X-Received: by 2002:a05:6a00:b87:b0:510:5e02:79f1 with SMTP id g7-20020a056a000b8700b005105e0279f1mr29558222pfj.80.1652354019644;
        Thu, 12 May 2022 04:13:39 -0700 (PDT)
Received: from localhost.localdomain ([202.120.234.246])
        by smtp.googlemail.com with ESMTPSA id c3-20020a170902724300b0015e8d4eb20esm3605859pll.88.2022.05.12.04.13.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 May 2022 04:13:39 -0700 (PDT)
From:   Miaoqian Lin <linmq006@gmail.com>
To:     Peter Ujfalusi <peter.ujfalusi@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Cc:     linmq006@gmail.com
Subject: [PATCH] ASoC: ti: j721e-evm: Fix refcount leak in j721e_soc_probe_*
Date:   Thu, 12 May 2022 15:13:30 +0400
Message-Id: <20220512111331.44774-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.25.1
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

of_parse_phandle() returns a node pointer with refcount
incremented, we should use of_node_put() on it when not needed anymore.
Add missing of_node_put() to avoid refcount leak.

Fixes: 6748d0559059 ("ASoC: ti: Add custom machine driver for j721e EVM (CPB and IVI)")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 sound/soc/ti/j721e-evm.c | 44 ++++++++++++++++++++++++++++++----------
 1 file changed, 33 insertions(+), 11 deletions(-)

diff --git a/sound/soc/ti/j721e-evm.c b/sound/soc/ti/j721e-evm.c
index 4077e15ec48b..6a969874c927 100644
--- a/sound/soc/ti/j721e-evm.c
+++ b/sound/soc/ti/j721e-evm.c
@@ -630,17 +630,18 @@ static int j721e_soc_probe_cpb(struct j721e_priv *priv, int *link_idx,
 	codec_node = of_parse_phandle(node, "ti,cpb-codec", 0);
 	if (!codec_node) {
 		dev_err(priv->dev, "CPB codec node is not provided\n");
-		return -EINVAL;
+		ret = -EINVAL;
+		goto put_dai_node;
 	}
 
 	domain = &priv->audio_domains[J721E_AUDIO_DOMAIN_CPB];
 	ret = j721e_get_clocks(priv->dev, &domain->codec, "cpb-codec-scki");
 	if (ret)
-		return ret;
+		goto put_codec_node;
 
 	ret = j721e_get_clocks(priv->dev, &domain->mcasp, "cpb-mcasp-auxclk");
 	if (ret)
-		return ret;
+		goto put_codec_node;
 
 	/*
 	 * Common Processor Board, two links
@@ -650,8 +651,10 @@ static int j721e_soc_probe_cpb(struct j721e_priv *priv, int *link_idx,
 	comp_count = 6;
 	compnent = devm_kzalloc(priv->dev, comp_count * sizeof(*compnent),
 				GFP_KERNEL);
-	if (!compnent)
-		return -ENOMEM;
+	if (!compnent) {
+		ret = -ENOMEM;
+		goto put_codec_node;
+	}
 
 	comp_idx = 0;
 	priv->dai_links[*link_idx].cpus = &compnent[comp_idx++];
@@ -702,6 +705,12 @@ static int j721e_soc_probe_cpb(struct j721e_priv *priv, int *link_idx,
 	(*conf_idx)++;
 
 	return 0;
+
+put_codec_node:
+	of_node_put(codec_node);
+put_dai_node:
+	of_node_put(dai_node);
+	return ret;
 }
 
 static int j721e_soc_probe_ivi(struct j721e_priv *priv, int *link_idx,
@@ -726,23 +735,25 @@ static int j721e_soc_probe_ivi(struct j721e_priv *priv, int *link_idx,
 	codeca_node = of_parse_phandle(node, "ti,ivi-codec-a", 0);
 	if (!codeca_node) {
 		dev_err(priv->dev, "IVI codec-a node is not provided\n");
-		return -EINVAL;
+		ret = -EINVAL;
+		goto put_dai_node;
 	}
 
 	codecb_node = of_parse_phandle(node, "ti,ivi-codec-b", 0);
 	if (!codecb_node) {
 		dev_warn(priv->dev, "IVI codec-b node is not provided\n");
-		return 0;
+		ret = 0;
+		goto put_codeca_node;
 	}
 
 	domain = &priv->audio_domains[J721E_AUDIO_DOMAIN_IVI];
 	ret = j721e_get_clocks(priv->dev, &domain->codec, "ivi-codec-scki");
 	if (ret)
-		return ret;
+		goto put_codecb_node;
 
 	ret = j721e_get_clocks(priv->dev, &domain->mcasp, "ivi-mcasp-auxclk");
 	if (ret)
-		return ret;
+		goto put_codecb_node;
 
 	/*
 	 * IVI extension, two links
@@ -754,8 +765,10 @@ static int j721e_soc_probe_ivi(struct j721e_priv *priv, int *link_idx,
 	comp_count = 8;
 	compnent = devm_kzalloc(priv->dev, comp_count * sizeof(*compnent),
 				GFP_KERNEL);
-	if (!compnent)
-		return -ENOMEM;
+	if (!compnent) {
+		ret = -ENOMEM;
+		goto put_codecb_node;
+	}
 
 	comp_idx = 0;
 	priv->dai_links[*link_idx].cpus = &compnent[comp_idx++];
@@ -816,6 +829,15 @@ static int j721e_soc_probe_ivi(struct j721e_priv *priv, int *link_idx,
 	(*conf_idx)++;
 
 	return 0;
+
+
+put_codecb_node:
+	of_node_put(codecb_node);
+put_codeca_node:
+	of_node_put(codeca_node);
+put_dai_node:
+	of_node_put(dai_node);
+	return ret;
 }
 
 static int j721e_soc_probe(struct platform_device *pdev)
-- 
2.25.1

