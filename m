Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F1E55265DE
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 17:19:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381859AbiEMPTS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 11:19:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381173AbiEMPS4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 11:18:56 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE02B66208
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 08:18:53 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id a5so8075478wrp.7
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 08:18:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=f2ty6Kirg+4vRs3TX4nTiMefjQ+ct09dXtXeTw7jYik=;
        b=WbaTQ5aq4Bu4b0YVerwkrsUQ/6yQQDzdf9GHE7o+pCPX8Q9dXiQ6fGs03IGd8ehlpa
         4EVY0kMcqYzcn0+9w753EwsvopXpcsahI25DgLj9K4wEDRRTPNaAW1ZUYHB4pFdEs7Jh
         UVIl8fAA5Phne9mZdSot0U8dIVJ+0Zw8amcpbIPXZsCjJ2BaOe32Jo48dZLzUQdSofO5
         PpxtbI9D6eB+BhQxbsVoYb5dXyuVQ3m67ZUGdCeM6/ZFGRFlcEOi9jeQZYsz3GeGUYvj
         w7VVfb883s0T3tI/Cz5uVe3NmzpDlV2MnZMfWL0F50XN9f7Zr4QQ9tcYc+myg/Ez50qv
         RnYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=f2ty6Kirg+4vRs3TX4nTiMefjQ+ct09dXtXeTw7jYik=;
        b=5qFp/jMVtIQwwnH3MbYPtqHdbZFwhTATjRahXQ8hgF1JMDoBnqwZE9Iz5YoqhVKhxs
         3YukdhM5NlnWrKO19rBA/feH4IrSiBB19VZihBSEmWWf8w0AHuOGfcAouKBZWdNkSnMj
         c517vQwiQ8/3PK/dBzb7Qr4x4g4Son0+cL5GMlbqqIQfb/NIlxMGoZwiq+v0ORHIc0qZ
         pCGC+cVoza18Jtyph2DiAJ39geL3XNHEBUgGKhTOgdSP7/INFp9r5qk+MDW/j2cqwFyb
         SKZcmkjKAs0f9ONyPTW0l/JWlK5WIWJ5R9vLEjx7aS/Xg1vr+G8bYeWYZE3yzL2/fkwQ
         mYIw==
X-Gm-Message-State: AOAM533D765jOoMNWLos6nbCWd/x5Wnw+sS/7De4ohe6y9sWi5u8o5lr
        NYm/AFPQPaIeT9pUFPjS4W59Dg==
X-Google-Smtp-Source: ABdhPJzGVx2mG3uLphYaJQBr5kbv6MOSDIoEbKda8p2pJEzCBY0bGQx4zlgJAp7c21wm1FvRWpZkKA==
X-Received: by 2002:a5d:4f8b:0:b0:20c:6970:fb3c with SMTP id d11-20020a5d4f8b000000b0020c6970fb3cmr4449912wru.554.1652455132391;
        Fri, 13 May 2022 08:18:52 -0700 (PDT)
Received: from groot.home ([2a01:cb19:85e6:1900:9353:61cb:4e25:b9cd])
        by smtp.gmail.com with ESMTPSA id b9-20020adfc749000000b0020c6a524fd5sm2800825wrh.99.2022.05.13.08.18.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 May 2022 08:18:52 -0700 (PDT)
From:   Mattijs Korpershoek <mkorpershoek@baylibre.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Fabien Parent <fparent@baylibre.com>,
        linux-input@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mattijs Korpershoek <mkorpershoek@baylibre.com>
Subject: [RESEND PATCH 2/2] Input: mt6779-keypad - implement row/column selection
Date:   Fri, 13 May 2022 17:18:45 +0200
Message-Id: <20220513151845.2802795-3-mkorpershoek@baylibre.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220513151845.2802795-1-mkorpershoek@baylibre.com>
References: <20220513151845.2802795-1-mkorpershoek@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The MediaTek keypad has a total of 6 input rows and 6 input columns.
By default, rows/columns 0-2 are enabled.

This is controlled by the KP_SEL register:
- bits[9:4]   control row selection
- bits[15:10] control column selection

Each bit enables the corresponding row/column number (e.g KP_SEL[4]
enables ROW0)

Depending on how the keypad is wired, this may result in wrong readings
of the keypad state.

Program the KP_SEL register to limit the key detection to n_rows,
n_cols we retrieve from the device tree.

Signed-off-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
---
 drivers/input/keyboard/mt6779-keypad.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/input/keyboard/mt6779-keypad.c b/drivers/input/keyboard/mt6779-keypad.c
index 23360de20da5..653dfc619696 100644
--- a/drivers/input/keyboard/mt6779-keypad.c
+++ b/drivers/input/keyboard/mt6779-keypad.c
@@ -17,6 +17,11 @@
 #define MTK_KPD_DEBOUNCE	0x0018
 #define MTK_KPD_DEBOUNCE_MASK	GENMASK(13, 0)
 #define MTK_KPD_DEBOUNCE_MAX_MS	256
+#define MTK_KPD_SEL		0x0020
+#define MTK_KPD_SEL_COL	GENMASK(15, 10)
+#define MTK_KPD_SEL_ROW	GENMASK(9, 4)
+#define MTK_KPD_SEL_COLMASK(c)	(MTK_KPD_SEL_COL >> (6 - (c)))
+#define MTK_KPD_SEL_ROWMASK(r)	(MTK_KPD_SEL_ROW >> (6 - (r)))
 #define MTK_KPD_NUM_MEMS	5
 #define MTK_KPD_NUM_BITS	136	/* 4*32+8 MEM5 only use 8 BITS */
 
@@ -171,6 +176,11 @@ static int mt6779_keypad_pdrv_probe(struct platform_device *pdev)
 	regmap_write(keypad->regmap, MTK_KPD_DEBOUNCE,
 		     (debounce * (1 << 5)) & MTK_KPD_DEBOUNCE_MASK);
 
+	regmap_update_bits(keypad->regmap, MTK_KPD_SEL, MTK_KPD_SEL_ROW,
+			   MTK_KPD_SEL_ROWMASK(keypad->n_rows));
+	regmap_update_bits(keypad->regmap, MTK_KPD_SEL, MTK_KPD_SEL_COL,
+			   MTK_KPD_SEL_COLMASK(keypad->n_cols));
+
 	keypad->clk = devm_clk_get(&pdev->dev, "kpd");
 	if (IS_ERR(keypad->clk))
 		return PTR_ERR(keypad->clk);
-- 
2.32.0

