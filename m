Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C32C46D36A
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 13:37:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232134AbhLHMky (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 07:40:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230000AbhLHMkw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 07:40:52 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 896BAC061746
        for <linux-kernel@vger.kernel.org>; Wed,  8 Dec 2021 04:37:20 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id i8-20020a7bc948000000b0030db7b70b6bso4073227wml.1
        for <linux-kernel@vger.kernel.org>; Wed, 08 Dec 2021 04:37:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=m5qhQ9MNHXL9LJ6rZcLeSxLX1M+ykgvvbEBVp94brXA=;
        b=R3Q47PcDIGWU6wfCnrz3WWPqZL7veIVDENu6xNqx/KczcRrkyPDsuGK1J66wxg+BTq
         2cjoC/i2QtHzs7eccipbQHF7PvEjTdkZmLga1uS/SoaKE6qcwsiTEol5c8Tq00Pc/Ixq
         2mF9kMxY+fLveuEVf9i8nI+VeYiLmn9uOWeeT81OWFv1igAuW2Vfr2vZa6/a+CIlC7Mu
         9kLXwH3z6ZOqw/9uT4W2fAKoP5dw+O2dv5qCF8BI9ayZi4Hacl/GBTyUK/hb+QsV3K+W
         01c3IL8MPxfnU1DGZ/prChKmJZIwyhfgcZljOqwr0YlKjzMKY8ON6VqOkWgFUFVk5qw6
         jY1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=m5qhQ9MNHXL9LJ6rZcLeSxLX1M+ykgvvbEBVp94brXA=;
        b=2KNp3hloD/ZWKLDlUEKAe2ReAXRb5FsGGD67mnehd1AaEs2lAxtAEjncEIgzohhtPC
         vcXOKxtLAv6dYRGpDOQJUZ/FXK8O3rIsw8HZwsctUszo8WTkPMWgcHUvVXxk+Wot/cmn
         NBB9dCEgjzs8N9q6prGX69sysTNCT8CeoLYCtaEvuPN/4A9o1GgOjnyGCwRGD09T/foV
         YD4jcPBpTv6VKIw+7KS9wMpSFkpdM9cX4N9yDuWdADyu8QCzmEqfzGMpNRYuIHxF4icN
         JcGi6o27dHxr66D8CII2sX7wccRvX7wMe3c5lXBVSy80lgY6A8ouqGgyleAg1LXIXC49
         eRKA==
X-Gm-Message-State: AOAM530ReGndFZJUjQXvcNCWJWLfoK+8yrqL+0Je1gxxzkubppMIhZA6
        +O3TaLBM+0IEDQXYl1WLZ6k=
X-Google-Smtp-Source: ABdhPJwoJQehgSgC3WTBJ8A9+Pvydr7lyxo0AY5wcfJQBORefP6fUW4Oxf6io8fDpvHnRuLll1phYw==
X-Received: by 2002:a1c:287:: with SMTP id 129mr15867599wmc.49.1638967039134;
        Wed, 08 Dec 2021 04:37:19 -0800 (PST)
Received: from localhost.localdomain ([39.48.199.136])
        by smtp.gmail.com with ESMTPSA id z5sm7167562wmp.26.2021.12.08.04.37.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Dec 2021 04:37:18 -0800 (PST)
From:   Ameer Hamza <amhamza.mgc@gmail.com>
To:     kuninori.morimoto.gx@renesas.com
Cc:     lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, Ameer Hamza <amhamza.mgc@gmail.com>
Subject: [PATCH] ASoC: test-component: replace of_match_device() to of_device_get_match_data()
Date:   Wed,  8 Dec 2021 17:36:59 +0500
Message-Id: <20211208123659.15789-1-amhamza.mgc@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211208120526.GA12550@hamza-OptiPlex-7040>
References: <20211208120526.GA12550@hamza-OptiPlex-7040>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Getting device data from of_device_get_match_data() for a cleaner
implementation.

Signed-off-by: Ameer Hamza <amhamza.mgc@gmail.com>
---
 sound/soc/generic/test-component.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/sound/soc/generic/test-component.c b/sound/soc/generic/test-component.c
index 8fc97d3ff011..5da4725d9e16 100644
--- a/sound/soc/generic/test-component.c
+++ b/sound/soc/generic/test-component.c
@@ -531,17 +531,13 @@ static int test_driver_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct device_node *node = dev->of_node;
 	struct device_node *ep;
-	const struct of_device_id *of_id = of_match_device(test_of_match, &pdev->dev);
-	const struct test_adata *adata;
+	const struct test_adata *adata = of_device_get_match_data(&pdev->dev);
 	struct snd_soc_component_driver *cdriv;
 	struct snd_soc_dai_driver *ddriv;
 	struct test_dai_name *dname;
 	struct test_priv *priv;
 	int num, ret, i;
 
-	if (!of_id)
-		return -EINVAL;
-	adata = of_id->data;
 	num = of_graph_get_endpoint_count(node);
 	if (!num) {
 		dev_err(dev, "no port exits\n");
@@ -552,7 +548,7 @@ static int test_driver_probe(struct platform_device *pdev)
 	cdriv	= devm_kzalloc(dev, sizeof(*cdriv),		GFP_KERNEL);
 	ddriv	= devm_kzalloc(dev, sizeof(*ddriv) * num,	GFP_KERNEL);
 	dname	= devm_kzalloc(dev, sizeof(*dname) * num,	GFP_KERNEL);
-	if (!priv || !cdriv || !ddriv || !dname)
+	if (!priv || !cdriv || !ddriv || !dname || !adata)
 		return -EINVAL;
 
 	priv->dev		= dev;
-- 
2.25.1

