Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45ACE53C6F4
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 10:34:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242847AbiFCIee (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 04:34:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbiFCIec (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 04:34:32 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89AD21835B
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jun 2022 01:34:30 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id n8so6405440plh.1
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jun 2022 01:34:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GpfF8ItPMk0VJbbfMj/WC62xrovcB2QttagaUM4KJ38=;
        b=hx9nlXm+saSHa0qlQPDeVf9Evb9JKM3WDBSe/Mibf0IxM42umtirmqRX1DYDq9SePl
         Ee+zwR7LTa6mfdGdKNrLO++/HcpuzfJU5qcYnaBqCqy9tPJc9ZOMDI9uF92+Xi+rWDpf
         tU3ysW+XZ2xPe3SqAvyHX9btz9ou+ZwGqhCxQuGDhc2NrMQXH4UVJISjH5yrP7pQCFmt
         LdweHKNZwj9FwGZKLsc0ShA03be9Ok31txrcHV6dyxliOrh8VDHZjotcuo06d9Qjst4X
         ECtzZWJU5jmNsk8eNh9sKDu5PZ1xXDLVi31/FppMY5b61Chhl9ckWdtuzKAdDEAMS0BV
         2WqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GpfF8ItPMk0VJbbfMj/WC62xrovcB2QttagaUM4KJ38=;
        b=fQoVufrOkQecvtDW3rNyVBscvBC6gsAh3CGHef+EpVboCnfns/HE7bSgFSgO6kV+ws
         scXIQhyU4Hbrhsx6EWcg9BTkHbsnmutrMSkRd9/EIA50+/vAa5uWJRrxZAdMJdVLAmrs
         3x/dg84gE5ZQbOm0mcImKCsP1sK/q4FKL8J81idzygyV6N3NyLvuRJHNax7pbU8QRu1m
         dHR7Pi8cRnZHCpoEtEY2RFZlWQtVCM4hODGd6QZuU7JqkzWSFSD65ee9HxJeoMPd2hbn
         bUUzCbq0kQST4LSft/BCrbd53M2Ob2DJigpGSncn1++3ymcUf01tiXKovAPUeKC7jwRl
         2OaQ==
X-Gm-Message-State: AOAM531l7tuC83YVxCv0xlE/hrzwDr9gFN3kCBGcbBdEbb/GPTTY/N3a
        znFZwDvOIj5tGZ3AY6sFJeI=
X-Google-Smtp-Source: ABdhPJy42CKbXP1g6HSFgMNfnYKPHDiOSTgrA1jna9XgHfAtjIeZISzUg9TczCGoz/8M5puUSJSJvg==
X-Received: by 2002:a17:90b:17c6:b0:1e6:8486:b324 with SMTP id me6-20020a17090b17c600b001e68486b324mr8464340pjb.24.1654245269977;
        Fri, 03 Jun 2022 01:34:29 -0700 (PDT)
Received: from localhost.localdomain ([202.120.234.246])
        by smtp.googlemail.com with ESMTPSA id k5-20020a170902760500b0015e8d4eb2b8sm4809485pll.258.2022.06.03.01.34.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jun 2022 01:34:29 -0700 (PDT)
From:   Miaoqian Lin <linmq006@gmail.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Miaoqian Lin <linmq006@gmail.com>, alsa-devel@alsa-project.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: mt6797-mt6351: Fix refcount leak in mt6797_mt6351_dev_probe
Date:   Fri,  3 Jun 2022 12:34:15 +0400
Message-Id: <20220603083417.9011-1-linmq006@gmail.com>
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
incremented, we should use of_node_put() on it when not need anymore.
Add missing of_node_put() to avoid refcount leak.

Fixes: format:f0ab0bf250da ("ASoC: add mt6797-mt6351 driver and config option")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 sound/soc/mediatek/mt6797/mt6797-mt6351.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/sound/soc/mediatek/mt6797/mt6797-mt6351.c b/sound/soc/mediatek/mt6797/mt6797-mt6351.c
index 496f32bcfb5e..d2f6213a6bfc 100644
--- a/sound/soc/mediatek/mt6797/mt6797-mt6351.c
+++ b/sound/soc/mediatek/mt6797/mt6797-mt6351.c
@@ -217,7 +217,8 @@ static int mt6797_mt6351_dev_probe(struct platform_device *pdev)
 	if (!codec_node) {
 		dev_err(&pdev->dev,
 			"Property 'audio-codec' missing or invalid\n");
-		return -EINVAL;
+		ret = -EINVAL;
+		goto put_platform_node;
 	}
 	for_each_card_prelinks(card, i, dai_link) {
 		if (dai_link->codecs->name)
@@ -230,6 +231,9 @@ static int mt6797_mt6351_dev_probe(struct platform_device *pdev)
 		dev_err(&pdev->dev, "%s snd_soc_register_card fail %d\n",
 			__func__, ret);
 
+	of_node_put(codec_node);
+put_platform_node:
+	of_node_put(platform_node);
 	return ret;
 }
 
-- 
2.25.1

