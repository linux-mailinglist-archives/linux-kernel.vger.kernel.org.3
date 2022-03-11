Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAFD24D5F8D
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 11:33:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347955AbiCKKej (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 05:34:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347945AbiCKKef (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 05:34:35 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ED44F460F
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 02:33:31 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id f20-20020a05600c155400b00389d73ceb43so637434wmg.4
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 02:33:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tHzWauNR3dX3JRCdUQ2Wh7sQFhVa1g70Y/fsse/k3yk=;
        b=OgmwPVe3iTZnA/fxf5BvpufbW18UFWKBkE6DauL5sDY3H5EGsXZuQnYiUcls3Xp/Yb
         ngodX1pS/phKVnyzuXFIoy84AfunMsefM49Ss1BSHYZl6/FrupaTRIDnlfY0f8IBKgXd
         7Sb27GyhcyaZiEt0ybiWuBKbtISdNMGVC5OqP/hs6OCZ0k6uAggfx7ulG284ELodkOSO
         b9BmifiA+AEWhfDJsB+JV8hPlwMmAQCKiHeN5IdCpB9fFof9PgSNmRPrZHLq2qijnyLW
         kIzOHxQUZjxBbpRfgPQRVk0EUp+1ki1OYhihN8GHetTjVQ0uIC4DknrszIyxGchHGiaL
         VVRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tHzWauNR3dX3JRCdUQ2Wh7sQFhVa1g70Y/fsse/k3yk=;
        b=zGhX+F5HVGf2ZyFQPp1iULPVgW9KMp+sdv3r6Xyypdf6d4kq/w3yInRPwcTkYK4K4Y
         MpgtgDZijq9X0w+c+YkWkSfAfrLa1wj16b1hNTPKXwjfm9IUSVQjADRcVkotw6Nc/fMC
         h5WNhp7cP9wh6hbbX4J5ZwOdONu7Gp4nUTHVquK20x0img99f3Ubd/iFHWS69w3NuLkv
         HYJE+jLpc9eq9EIbr+xrkzRNtnETyq20SMPDIVYi2GAz6vWazOIawtFGSz/AgE0NDREf
         8RdywrhAwb67yOagKnHQqjxmNvm9Dpyp9HU1aImwyjKNPGMig4p7GQm7F2iB0dWlPykq
         MenQ==
X-Gm-Message-State: AOAM532RoxpW5pdx69gkzXGcG5HHPnN7hnwgj1Lh4Qvvoo1ELuhnkuuA
        u8Vl3ipyGee2iNzeIhL8QnwuBQ==
X-Google-Smtp-Source: ABdhPJwR2NyG/o0epriqRgWZiafPO4iha8N9ZD/x+FYDnBCO3aAzDwH1hjTV0yNCeh6rbGezo3zDgQ==
X-Received: by 2002:a05:600c:4615:b0:386:9f67:8c63 with SMTP id m21-20020a05600c461500b003869f678c63mr15020537wmo.12.1646994809922;
        Fri, 11 Mar 2022 02:33:29 -0800 (PST)
Received: from xps-9300.baylibre (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id e10-20020a056000178a00b0020393321552sm2264138wrg.85.2022.03.11.02.33.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Mar 2022 02:33:29 -0800 (PST)
From:   Alexandre Bailon <abailon@baylibre.com>
To:     chaotian.jing@mediatek.com, ulf.hansson@linaro.org,
        matthias.bgg@gmail.com
Cc:     linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Alexandre Bailon <abailon@baylibre.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: [PATCH v2] mmc: mtk-sd: Silence delay phase calculation debug log
Date:   Fri, 11 Mar 2022 11:33:20 +0100
Message-Id: <20220311103320.3072171-1-abailon@baylibre.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver prints the following log everytime data is written to RPMB:
mtk-msdc 11230000.mmc: phase: [map:ffffffff] [maxlen:32] [final:10]

dev_info is used to print that log but it seems that log is only
useful for debbuging. Use dev_dbg instead of dev_info.

Signed-off-by: Alexandre Bailon <abailon@baylibre.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/mmc/host/mtk-sd.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
index d5a9c269d492..05c8b4de46f3 100644
--- a/drivers/mmc/host/mtk-sd.c
+++ b/drivers/mmc/host/mtk-sd.c
@@ -1914,8 +1914,8 @@ static struct msdc_delay_phase get_best_delay(struct msdc_host *host, u32 delay)
 		final_phase = (start_final + len_final / 3) % PAD_DELAY_MAX;
 	else
 		final_phase = (start_final + len_final / 2) % PAD_DELAY_MAX;
-	dev_info(host->dev, "phase: [map:%x] [maxlen:%d] [final:%d]\n",
-		 delay, len_final, final_phase);
+	dev_dbg(host->dev, "phase: [map:%x] [maxlen:%d] [final:%d]\n",
+		delay, len_final, final_phase);
 
 	delay_phase.maxlen = len_final;
 	delay_phase.start = start_final;
-- 
2.34.1

