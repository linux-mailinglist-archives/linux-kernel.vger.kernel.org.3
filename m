Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2726746BD85
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 15:23:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237746AbhLGO0y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 09:26:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233131AbhLGO0x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 09:26:53 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CCF9C061574
        for <linux-kernel@vger.kernel.org>; Tue,  7 Dec 2021 06:23:23 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id a18so29875894wrn.6
        for <linux-kernel@vger.kernel.org>; Tue, 07 Dec 2021 06:23:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uY+Ye5lZK/paRfbOIv1ilOUmqS6UHZavsbAKwAI2Ayo=;
        b=K3IUYo1B7pu/wgpmnj5bernzE9trlHIFClUHa0V8zVeHm0hf0QwfDKtFh/hEol2P+I
         GZuUSDRzddkmH1Zab8ISaKbpcsrE/tXEnbWh+s8yClNOxj2NrTF1aWKNWIWtb1k8D2IA
         bM1dSMFqx1R3jZ/l+40UEoore5l8lyKO8Zh9thpw+nQ2hczIRxG3dE1IrH1mVfxuyF40
         4kNQjOlzxKNn+42q8M0/qWb0W1bXC4LJvcXBosgdlOe3Hms9aCH5L24eUmQ8Sse2Shpk
         E05pAjLY5Flu9kYILYteFpf7c6jdqriH1Cr1A0a9F5LGvW759vdsT/NbLyBn02/Gdrr/
         9wQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uY+Ye5lZK/paRfbOIv1ilOUmqS6UHZavsbAKwAI2Ayo=;
        b=ThWIjbIj9GnnNitVTQxnhPZYRoTs/MJrcq6pABGPjDQigLV8iAd1dpIIxXJDJWR2D4
         hPcVSiFfWnZcfsYdilUQpEduperYpEgBRDo5seKYrYaMO85jidokSd4Zo0TMuA7KqjLN
         edOJhMFDtnFrwOyg4g7wOmTUboiaVekY/C6UKTrH2m8JOh0ks+SsTqsOZ/n9+6dMe3/W
         lXEv5+rpgpZa0jL2TvvBdsAxa55jBV1jyO65B9QN3XFxonpSFQmC2oY4Qc+W99oWv2SQ
         oT5IBspUr7rf1d/I0NHysoKtkSWsWY5jQ76lzCeK9i3wmY5i/Yu30xERebazPwmBlxT1
         gYfQ==
X-Gm-Message-State: AOAM531g2+vgAkexfWU/YgXW6e79tq7lEhjBZPDBtqg5VLzOL15qOHrs
        fQXNDsuq6l6tjz5x6T8LyUM=
X-Google-Smtp-Source: ABdhPJzEGZxqvOkgDTrQ2wpZCusW5PWJyq2nGJ4WUdYa/7ExbD3EXioqx2hhLFY6t6Q7uUsVNmZu/Q==
X-Received: by 2002:a5d:45c4:: with SMTP id b4mr51085122wrs.222.1638887001943;
        Tue, 07 Dec 2021 06:23:21 -0800 (PST)
Received: from localhost.localdomain ([39.48.199.136])
        by smtp.gmail.com with ESMTPSA id h18sm16075887wre.46.2021.12.07.06.23.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Dec 2021 06:23:21 -0800 (PST)
From:   Ameer Hamza <amhamza.mgc@gmail.com>
To:     lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, kuninori.morimoto.gx@renesas.com,
        alsa-devel@alsa-project.org
Cc:     linux-kernel@vger.kernel.org, amhamza.mgc@gmail.com
Subject: [PATCH v2] ASoC: test-component: fix null pointer dereference.
Date:   Tue,  7 Dec 2021 19:23:09 +0500
Message-Id: <20211207142309.222820-1-amhamza.mgc@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <Ya9YxoUqkATCOASh@sirena.org.uk>
References: <Ya9YxoUqkATCOASh@sirena.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dereferncing of_id pointer will result in exception in current
implementation since of_match_device() will assign it to NULL.
Adding NULL check for protection.

Signed-off-by: Ameer Hamza <amhamza.mgc@gmail.com>
---
changes in v2:
Replace of_match_device() with of_device_get_match_data to simplify the
logic as suggested by Kuninori Morimoto
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

