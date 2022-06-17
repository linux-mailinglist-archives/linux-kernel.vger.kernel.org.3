Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A70D454F2AB
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 10:19:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380624AbiFQITV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 04:19:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380384AbiFQITN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 04:19:13 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D79BF68315
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 01:19:11 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id a10so1921166wmj.5
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 01:19:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=i6KN7qFz99qq/ALEKkoJkPgYJrjmF3EU2O4lIDewe7o=;
        b=mtQXnNncLkH5+APNy+qa+gXYlCjcWp0W7PGKAfj+IFRVykr8G5oPo2oW38RIlhfBIU
         oHB2kCRIZLFlAiyyfIO7CcTf6m9MP6snoDpTRdcgCiv3tt2YmCcZBI2LYbw7xDmuXHgv
         Xzqez09XcW9J3W5ttBTNwR498IHRR0N1umoe0EGDdtFJr4ZlYS69p9OsslUiAP5Lpol2
         ver6MQNRB2CHNr5Hi4xAXUv1Rtm5mG973JnVAcSh12HRLgsQBj4HC/Up35ID4CuwmMga
         B7A+t9iG/jUgKD+7gIm1fbV7/Oy33nNsJF7mPodlfOmQHpvYxf7Bn4i1VBxdesgUKVhC
         bxBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=i6KN7qFz99qq/ALEKkoJkPgYJrjmF3EU2O4lIDewe7o=;
        b=UrOLdvTItKJ6AiBrclw763oGVDu/4ppBDBQSJSjJL2/XwpGeNnqbSCC76ORxMEnfuy
         9exZjyxn1WjONebTwajeP0SZDmNFtgjFzDCtpG0e+CJ6tSZJigFWLgNJm4Vci+PBQ9gV
         5orAs98SuseTOi5Y+hZtYUXW6AYan/0b+b34v8yD4NBQ+cxhwbZnwiqNS+SqiLF5lLrg
         mt/jIKE3NnH67SiyfvJVHjhQgqM4Z22fQG1Ep+0m1qeFXImgJ8+cQ5ShJM5MeqQ0+vF7
         KfAnH45fIvl7zpyJY14rA90LlfjsqPHwTE6Qecgovv99k9qGDG4YlI1i9N2FkSb+qlYp
         yzuA==
X-Gm-Message-State: AJIora9tgmt+4iNXWiWeh1M95P0JQFGobew/UrQj5OzhyKSK2c1hH5c7
        AUxiIDhkbJzw0W73fHDEw6h5fg==
X-Google-Smtp-Source: AGRyM1tIXg2YoKkkCqDilEVxCCUSgr+DQnIy9x2PWUwFyjbZee7lkDg9EWeYCjC81sWbPrxlGE3Bvg==
X-Received: by 2002:a05:600c:4f4e:b0:39c:1bbb:734f with SMTP id m14-20020a05600c4f4e00b0039c1bbb734fmr8830394wmq.116.1655453950431;
        Fri, 17 Jun 2022 01:19:10 -0700 (PDT)
Received: from groot.. ([2a01:cb19:85e6:1900:b8a0:45dd:a367:2e65])
        by smtp.gmail.com with ESMTPSA id l9-20020a05600c4f0900b0039db500714fsm4970245wmq.6.2022.06.17.01.19.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jun 2022 01:19:09 -0700 (PDT)
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
Subject: [PATCH v3 2/2] Input: mt6779-keypad - implement row/column selection
Date:   Fri, 17 Jun 2022 10:19:02 +0200
Message-Id: <20220617081902.2931099-3-mkorpershoek@baylibre.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220617081902.2931099-1-mkorpershoek@baylibre.com>
References: <20220617081902.2931099-1-mkorpershoek@baylibre.com>
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
index bd86cb95bde3..bf447bf598fb 100644
--- a/drivers/input/keyboard/mt6779-keypad.c
+++ b/drivers/input/keyboard/mt6779-keypad.c
@@ -17,6 +17,11 @@
 #define MTK_KPD_DEBOUNCE	0x0018
 #define MTK_KPD_DEBOUNCE_MASK	GENMASK(13, 0)
 #define MTK_KPD_DEBOUNCE_MAX_MS	256
+#define MTK_KPD_SEL		0x0020
+#define MTK_KPD_SEL_COL	GENMASK(15, 10)
+#define MTK_KPD_SEL_ROW	GENMASK(9, 4)
+#define MTK_KPD_SEL_COLMASK(c)	GENMASK((c) + 9, 10)
+#define MTK_KPD_SEL_ROWMASK(r)	GENMASK((r) + 3, 4)
 #define MTK_KPD_NUM_MEMS	5
 #define MTK_KPD_NUM_BITS	136	/* 4*32+8 MEM5 only use 8 BITS */
 
@@ -161,6 +166,11 @@ static int mt6779_keypad_pdrv_probe(struct platform_device *pdev)
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
2.34.1

