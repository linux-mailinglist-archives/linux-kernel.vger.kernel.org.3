Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCDBF468D51
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Dec 2021 21:42:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238875AbhLEUph (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Dec 2021 15:45:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238856AbhLEUpf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Dec 2021 15:45:35 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CF56C061751
        for <linux-kernel@vger.kernel.org>; Sun,  5 Dec 2021 12:42:08 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id q3so18132389wru.5
        for <linux-kernel@vger.kernel.org>; Sun, 05 Dec 2021 12:42:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Rhy8UiEQpnUYiYMsnqfzPU8AwFzNfD4+zpkpcL/Vs9I=;
        b=aZPRWWj68yw79Cj6AOj9CaoYBPvlgQJPPH/C8gXeP/WAWH3zqVmVyaBhuT3csJBtAI
         WEAwpnic0rMwbcgVmOGjON7bs+jvmfiN8e7EcineJXv90Mj23NyPIPaYfw+oD2v5TloL
         YcZLMPey/nkMmaCPBWPrVOMosegfQokW6m7gQ+B+0ge2/djVkOzGy98YeNdwBwJxwCQi
         AvBfNbyjkDoqgN6dQc2bwkbxvfcNinzibuUJMvmt7Nutwrn/8Z2YqSmM/YBSY48Fwipm
         vKZvlQTkcch9RXNAGHz61FYy+wxf/3scrxf8SC+9jFzfWhCQd9UYDydUb20TcfxU3jwE
         HdLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Rhy8UiEQpnUYiYMsnqfzPU8AwFzNfD4+zpkpcL/Vs9I=;
        b=uyYvIVJwoVORRaYym2REYl6JeU8HGiNejXplA5gFNuecANNFfIPtRvyGss5wuaBpeZ
         N4f/UKiXEaV4Zwo2yhiLHmo7qOPIVlwJmP/T6zzJsFbmFKQ8LU8OQFjSoKEudK/eMkOy
         YbQyk72wfQXuu5PEvgLg+PlR+0yqkC+Qu3bDP7cvH56lKl7eezoKEM3VhtFmCMwZN8Lb
         g7luy2BdoIOMIOj3CQWHv/KLhQEti7uiKANdxfqU/WjXe0l1nu1wrgAnXlzazZYj/9SR
         idvTcgydpsajHZs+yjpkiPFOXd328gcslP7PP0SXHpUwOPX7sSGei51CeB0J3puS8yXe
         yjZA==
X-Gm-Message-State: AOAM5314EbsYd9r/+FDsjUEFmMHaQvxhGdNe706VoysoS9qrQiFmSDg5
        vrOYR2Jc0JzL2L1+WZhl1HGz31fsya0GdY4l
X-Google-Smtp-Source: ABdhPJxXJvtbk0zbEsczc3eNieyvgsO9yrjJJLB3RdcmFJI5MHdqtIcSMAi81+Wdt+7+Gwmr16iTTQ==
X-Received: by 2002:adf:f489:: with SMTP id l9mr39249389wro.268.1638736926668;
        Sun, 05 Dec 2021 12:42:06 -0800 (PST)
Received: from localhost.localdomain ([39.48.147.147])
        by smtp.gmail.com with ESMTPSA id t11sm9530345wrz.97.2021.12.05.12.42.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Dec 2021 12:42:06 -0800 (PST)
From:   Ameer Hamza <amhamza.mgc@gmail.com>
To:     lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, kuninori.morimoto.gx@renesas.com,
        alsa-devel@alsa-project.org
Cc:     linux-kernel@vger.kernel.org, amhamza.mgc@gmail.com
Subject: [PATCH] ASoC: test-component: fix null pointer dereference.
Date:   Mon,  6 Dec 2021 01:42:00 +0500
Message-Id: <20211205204200.7852-1-amhamza.mgc@gmail.com>
X-Mailer: git-send-email 2.25.1
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
 sound/soc/generic/test-component.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/sound/soc/generic/test-component.c b/sound/soc/generic/test-component.c
index 85385a771d80..8fc97d3ff011 100644
--- a/sound/soc/generic/test-component.c
+++ b/sound/soc/generic/test-component.c
@@ -532,13 +532,16 @@ static int test_driver_probe(struct platform_device *pdev)
 	struct device_node *node = dev->of_node;
 	struct device_node *ep;
 	const struct of_device_id *of_id = of_match_device(test_of_match, &pdev->dev);
-	const struct test_adata *adata = of_id->data;
+	const struct test_adata *adata;
 	struct snd_soc_component_driver *cdriv;
 	struct snd_soc_dai_driver *ddriv;
 	struct test_dai_name *dname;
 	struct test_priv *priv;
 	int num, ret, i;
 
+	if (!of_id)
+		return -EINVAL;
+	adata = of_id->data;
 	num = of_graph_get_endpoint_count(node);
 	if (!num) {
 		dev_err(dev, "no port exits\n");
-- 
2.25.1

