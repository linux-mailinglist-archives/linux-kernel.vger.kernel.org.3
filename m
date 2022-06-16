Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC94F54E5F5
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 17:24:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377409AbiFPPYk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 11:24:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233993AbiFPPYh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 11:24:37 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF5DA338B6;
        Thu, 16 Jun 2022 08:24:34 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id h23so2736478lfe.4;
        Thu, 16 Jun 2022 08:24:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wERZkRXyaF/yhUHrF2+CwLMtx6qioAnoch5k8zt02BE=;
        b=qqev2nWuJtHKAy2NRmgs7KQtMEfFyXYr973lcTQ/3gb9Beq26TLw01HNBtP3bJBXJ/
         9c714prPoCM6uBK+03SL5aSsfQhv3fAyuKSotWljo93Y6QQE/AilHY5SdoWot6/arMsu
         bOtdzk50B5G0lHoJSg8h0jW8mAKDUdVRWwHYbjjwLET1EFVqYe1COubiG+Tmqe176asL
         aGKeMdH/RTBGm4aZKhVmRIKSjDyvGz5NPoSxWwsePZ2PokI6ktESypzQ+0dgULgcIznz
         GqkxLGEWSW5GDe0agVs4pdkAf4+3sf89wqlbygw3gA7rL+FicZ9uUI/cGvwREfbP/yXj
         OQVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wERZkRXyaF/yhUHrF2+CwLMtx6qioAnoch5k8zt02BE=;
        b=JjdA4JArbobMIghLQ6F9JEGIDr+4fccN1N9U/SkyTw/b+0UzfLHLlW+ThRgl5dSOtv
         BljZWuWH0OxtSIDVfmu4FQqfVd9hzFD5BKm5Cw5qxWN9sAxWr/m85kVpmJoPkxLaqZNM
         hMnKMr7fzIjCpFxPpauZ/Wbe68qwg5F80dOcjUlCcbjGnaS3+RO/CQhVy6jV8luwGxWC
         0Tic4hYaopsSfsORB0xNhaAUdxHJkZ0xqwaiyXMdI4CawFQujLIaIzLL78mUkRxsiqCH
         xJFsHgMtT+KmBvlMKBRsgyEA1Es2Te9MsEsn+YoRFSiTi7CmENJE9yWzcJZ08QBcWjFN
         loYg==
X-Gm-Message-State: AJIora84wTHXVThNh6hY79E0mejZx308Oag7SpXW8sC193kSvre7OAST
        pEQAtSAVzb9SbKeLZYjbCGQ=
X-Google-Smtp-Source: AGRyM1um5hqlsEfM5M/bxVqMCqjhSFQ0nHg9h/eo9duBqbu7PtPlevoJ43ArQk9DCohkn0hDcQVYqg==
X-Received: by 2002:a05:6512:249:b0:479:a3c:de with SMTP id b9-20020a056512024900b004790a3c00demr3114355lfo.128.1655393073057;
        Thu, 16 Jun 2022 08:24:33 -0700 (PDT)
Received: from localhost.localdomain (91-159-150-230.elisa-laajakaista.fi. [91.159.150.230])
        by smtp.gmail.com with ESMTPSA id t27-20020a192d5b000000b0047dab95a0d5sm273830lft.109.2022.06.16.08.24.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jun 2022 08:24:32 -0700 (PDT)
From:   Peter Ujfalusi <peter.ujfalusi@gmail.com>
To:     tony@atomide.com, lee.jones@linaro.org
Cc:     linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] mfd: twl4030-audio: Drop legacy, non DT boot support
Date:   Thu, 16 Jun 2022 18:31:58 +0300
Message-Id: <20220616153158.29302-1-peter.ujfalusi@gmail.com>
X-Mailer: git-send-email 2.36.1
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

Legacy or non DT boot is no longer possible on systems where the
tw4030/5030 is used.

Drop the support for handling legacy pdata.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@gmail.com>
---
 drivers/mfd/twl4030-audio.c | 29 ++++++-----------------------
 1 file changed, 6 insertions(+), 23 deletions(-)

diff --git a/drivers/mfd/twl4030-audio.c b/drivers/mfd/twl4030-audio.c
index 4536d829b43e..c61da99e9681 100644
--- a/drivers/mfd/twl4030-audio.c
+++ b/drivers/mfd/twl4030-audio.c
@@ -144,14 +144,10 @@ unsigned int twl4030_audio_get_mclk(void)
 }
 EXPORT_SYMBOL_GPL(twl4030_audio_get_mclk);
 
-static bool twl4030_audio_has_codec(struct twl4030_audio_data *pdata,
-			      struct device_node *parent)
+static bool twl4030_audio_has_codec(struct device_node *parent)
 {
 	struct device_node *node;
 
-	if (pdata && pdata->codec)
-		return true;
-
 	node = of_get_child_by_name(parent, "codec");
 	if (node) {
 		of_node_put(node);
@@ -161,14 +157,10 @@ static bool twl4030_audio_has_codec(struct twl4030_audio_data *pdata,
 	return false;
 }
 
-static bool twl4030_audio_has_vibra(struct twl4030_audio_data *pdata,
-			      struct device_node *node)
+static bool twl4030_audio_has_vibra(struct device_node *node)
 {
 	int vibra;
 
-	if (pdata && pdata->vibra)
-		return true;
-
 	if (!of_property_read_u32(node, "ti,enable-vibra", &vibra) && vibra)
 		return true;
 
@@ -178,14 +170,13 @@ static bool twl4030_audio_has_vibra(struct twl4030_audio_data *pdata,
 static int twl4030_audio_probe(struct platform_device *pdev)
 {
 	struct twl4030_audio *audio;
-	struct twl4030_audio_data *pdata = dev_get_platdata(&pdev->dev);
 	struct device_node *node = pdev->dev.of_node;
 	struct mfd_cell *cell = NULL;
 	int ret, childs = 0;
 	u8 val;
 
-	if (!pdata && !node) {
-		dev_err(&pdev->dev, "Platform data is missing\n");
+	if (!node) {
+		dev_err(&pdev->dev, "Only DT boot si supported\n");
 		return -EINVAL;
 	}
 
@@ -222,22 +213,14 @@ static int twl4030_audio_probe(struct platform_device *pdev)
 	audio->resource[TWL4030_AUDIO_RES_APLL].reg = TWL4030_REG_APLL_CTL;
 	audio->resource[TWL4030_AUDIO_RES_APLL].mask = TWL4030_APLL_EN;
 
-	if (twl4030_audio_has_codec(pdata, node)) {
+	if (twl4030_audio_has_codec(node)) {
 		cell = &audio->cells[childs];
 		cell->name = "twl4030-codec";
-		if (pdata) {
-			cell->platform_data = pdata->codec;
-			cell->pdata_size = sizeof(*pdata->codec);
-		}
 		childs++;
 	}
-	if (twl4030_audio_has_vibra(pdata, node)) {
+	if (twl4030_audio_has_vibra(node)) {
 		cell = &audio->cells[childs];
 		cell->name = "twl4030-vibra";
-		if (pdata) {
-			cell->platform_data = pdata->vibra;
-			cell->pdata_size = sizeof(*pdata->vibra);
-		}
 		childs++;
 	}
 
-- 
2.36.1

