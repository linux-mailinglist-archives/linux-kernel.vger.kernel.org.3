Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 885124F927E
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 12:03:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233946AbiDHKFr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 06:05:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234206AbiDHKFa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 06:05:30 -0400
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EF2BAAB4A
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 03:03:19 -0700 (PDT)
Received: by mail-qv1-xf32.google.com with SMTP id ke15so7078283qvb.11
        for <linux-kernel@vger.kernel.org>; Fri, 08 Apr 2022 03:03:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JpqWb+qabLme++eyAmbSMoF69YNe99IcopaKHvnYnE8=;
        b=o1UGymQOBCjDdm5i0afuF4mfy7UgESaASrEg+kHv98rKvf2kjfs+KLgyy67VV1mSF/
         TW3edcjv3JT293ZlEsNVZgP0MplS+xLZLyUtF5jxOmE1zr+siFaLmEXjl7AUw2IliXkF
         z5FEh0vmlu3QfcRNNe7tVcTzcWkk1FOcteC8cvXuPZbNYxdpqKy8Rer2q30XPevLMxQn
         7hBXhC2Y5kTk98vwDs9E842kKJrhCEERlH5rjFV8oNTPfbYnkMcM1LbaiXZ49JVV3RhX
         vRj5WIUXlcgZk6u+e00dyv5GGYih2AOX1ktcDT59USWYDn1pcANUcA9QijkSUhkRb32d
         ltMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JpqWb+qabLme++eyAmbSMoF69YNe99IcopaKHvnYnE8=;
        b=JPitFv/145pkEspL4jfGgsZNp+8c9puKi6gXUlY57hZ5BmfMvinb9a9/GuQckTaZQ6
         KK2C2KkDi7siUY/KiMRrLRjJfb0f7xf+Rl2a5bFzHBXSabbvBAeUmDo5hyto58/TSuYU
         v9ooZ68ehwnztgyd8ZcpZnRl60jtFGMCmdu2CeallMc7+sNbY9SZ4VWE5PvyhSJUpdlL
         vpmAX4Cyrz6hKXnPA3MFl910R/7MN7WbCEP4+0bshfJE4FOKq/GOXPE98Z+v3Q4YVdhs
         bMHkBUppEQRexkjwjTCREyNPJ4F1RsIwYzpVmY1sdPz5Ir1ubSqBpKD4AtwV5ZOfp9Hn
         ab4w==
X-Gm-Message-State: AOAM532mQOZG0tYCFjbgI37PSvDQiWynOe6Q7XIZ2fM2byj3zjewUloM
        rehh31yp5XBmFbsudV/AJcQ=
X-Google-Smtp-Source: ABdhPJwmwY5DgTWhekwLTVj5UPKZKwOWKCsva1KAAGSWO7vxkZYgMV8T2DFwn5GOULQY015v2y5Uvw==
X-Received: by 2002:ad4:5de4:0:b0:443:5d80:e379 with SMTP id jn4-20020ad45de4000000b004435d80e379mr14863077qvb.37.1649412198101;
        Fri, 08 Apr 2022 03:03:18 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id e13-20020ac85dcd000000b002eb9458498esm17174364qtx.95.2022.04.08.03.03.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Apr 2022 03:03:17 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: lv.ruyi@zte.com.cn
To:     lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz
Cc:     tiwai@suse.com, matthias.bgg@gmail.com, trevor.wu@mediatek.com,
        tzungbi@google.com, angelogioacchino.delregno@collabora.com,
        alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Lv Ruyi <lv.ruyi@zte.com.cn>, Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] ASoC: mediatek: mt8195: Make sure of_device_id table are NULL terminated
Date:   Fri,  8 Apr 2022 10:03:09 +0000
Message-Id: <20220408100309.2495462-1-lv.ruyi@zte.com.cn>
X-Mailer: git-send-email 2.25.1
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

From: Lv Ruyi <lv.ruyi@zte.com.cn>

Fix the following coccicheck review:
./sound/soc/mediatek/mt8195/mt8195-mt6359.c:1657:1-2:
mt8195_mt6359_dt_match is not NULL terminated at line 1657

Fixes: 86a6b9c9dfff ("ASoC: mediatek: mt8195: add machine support for max98390 and rt5682")
Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Lv Ruyi <lv.ruyi@zte.com.cn>
---
 sound/soc/mediatek/mt8195/mt8195-mt6359.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/mediatek/mt8195/mt8195-mt6359.c b/sound/soc/mediatek/mt8195/mt8195-mt6359.c
index bc8c30b33969..262a54e590e8 100644
--- a/sound/soc/mediatek/mt8195/mt8195-mt6359.c
+++ b/sound/soc/mediatek/mt8195/mt8195-mt6359.c
@@ -1655,6 +1655,7 @@ static const struct of_device_id mt8195_mt6359_dt_match[] = {
 		.compatible = "mediatek,mt8195_mt6359_max98390_rt5682",
 		.data = &mt8195_mt6359_max98390_rt5682_card,
 	},
+	{},
 };
 #endif
 
-- 
2.25.1

