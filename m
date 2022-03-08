Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90EBE4D13C8
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 10:49:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345477AbiCHJu1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 04:50:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345463AbiCHJu0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 04:50:26 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3233B344C4
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 01:49:29 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id 19so10506403wmy.3
        for <linux-kernel@vger.kernel.org>; Tue, 08 Mar 2022 01:49:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4AMWeZkxp95RTDe+wPDPpAGms0iHGajzkgE4/KUX8bI=;
        b=H8aMYJdR1rsOnt5DsE/e5rdF/g5CVV/ImrAKuw+9/cPZfWZFiO38RKfkOvUCOzHRn8
         XqHP7+POHekXwKNA2LJVFDHwX+y+rUUhqpN+UDJJiOP9kpvWRKUzcDrjA7dZDZ6ZFcuG
         lR77zCxBUR8/BaJhSXHGHagB54eapbQhSvnO7oaIsLzsZIo+g5XDnNZ/tR3IA39RQ3Ue
         1mX0ri0O8X/Doruf5c5kTxOKzZiu3HcYBDifhFyTMf4rpLsMed0VvxDc2+rIjKVUehDs
         /FB/JGFsa5DbFlN2zWnoxDd/1EIYwRbp1nGtO5+Xrc0XJn6TmBBRWsZIqqDuKUB9YT8l
         SkPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4AMWeZkxp95RTDe+wPDPpAGms0iHGajzkgE4/KUX8bI=;
        b=F1cm9vszo3VKqTd9/lF5DzMbaxkU75DYFxVZKzzlVLPPfcTfR45I/IHPYZPlNN4omt
         hEPqyvwpMQdysZGOi0yuJfi+ZHmseWxsjpFzilmWzdZV3l8WdcoIZjJslxCArK+PwulU
         hmb2zX4oENbDr4a1Ojr0XSiqdT4e3HxHDA4oCDrO8G2PhlEvUTPYSV2JToJGC5ZdpVjl
         HdYgqKlp8wl/XE70YSSwuRSma3F8zRTdHFP2x3JPhOoelJTJcofJMf6c3n2gXngNQ4ZZ
         um06jEFW4KPVVGu+pLuNEUJ9h+wSyBVXzGxswnfFsVKlYcQfi+urttoCb+AsKGhUabmO
         qLkQ==
X-Gm-Message-State: AOAM530vw8HHulh7P8piFzHPbmQsSyiWmzqO6M5kNioYKVX4QkAsGXnq
        VRDJoJsRVEJ4E7/7hzLgLBNwZw==
X-Google-Smtp-Source: ABdhPJygU94zXAM1Uu54IBoLXA1LSudb52qrcnlJ03Lk9v6Rot2IWk4fYtPCBHBO4UAJEig/w3RXCg==
X-Received: by 2002:a1c:f616:0:b0:37d:1e1c:f90a with SMTP id w22-20020a1cf616000000b0037d1e1cf90amr2688313wmc.148.1646732967642;
        Tue, 08 Mar 2022 01:49:27 -0800 (PST)
Received: from xps-9300.baylibre (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id b1-20020a5d40c1000000b001f1dd6ea504sm8014205wrq.59.2022.03.08.01.49.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Mar 2022 01:49:27 -0800 (PST)
From:   Alexandre Bailon <abailon@baylibre.com>
To:     chaotian.jing@mediatek.com, ulf.hansson@linaro.org,
        matthias.bgg@gmail.com
Cc:     linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Alexandre Bailon <abailon@baylibre.com>
Subject: [PATCH] mmc: mtk-msdc: change a log level
Date:   Tue,  8 Mar 2022 10:49:24 +0100
Message-Id: <20220308094924.2868042-1-abailon@baylibre.com>
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

We write data to RPMB, we get many time the following log:
mtk-msdc 11230000.mmc: phase: [map:ffffffff] [maxlen:32] [final:10]

dev_info is used to print that log but it seems that log is only
useful for debbuging. Use dev_dbg instead of dev_info.

Signed-off-by: Alexandre Bailon <abailon@baylibre.com>
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

