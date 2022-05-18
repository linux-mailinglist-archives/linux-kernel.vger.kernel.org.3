Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 607B152B453
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 10:06:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232935AbiERH71 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 03:59:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232896AbiERH7R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 03:59:17 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 219CA122B44
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 00:59:16 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id a14-20020a7bc1ce000000b00393fb52a386so2679334wmj.1
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 00:59:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=n37OLhluDeZRZjQV8gqjswMetHIVJY0WAfxFDmSPshs=;
        b=BW34tKuFY3dYsRa6d9qALrie8sssLLFboJeX2+kC6OJrQ5TfgGTzIBKQQHohBfcNZk
         bYIds93O59FlA8sQcuxILI1lv/ktt5LDnb0xCg/vN8RCdU5jFzrMPI4ZVWofVgfVOsUd
         14331uJXaQoHYkESFOFgCKOw4Yk8JLeXG4DAaKZPhY0QDFpmf6gI+cGlkIP/YlU6y0TF
         F66rGc4GOx7GT55IR5uFokoMlaFReP33WcQoRNqlwsjhbv7PpkgYT7jrnL5sbuA5Fi1j
         Xy9cu3XfAK4+kwJt+NAT0KPQMCQfFAjUGIj8AFfgVGqJoTw5Ox8ZnRJCXX+jUCeNhQj4
         xmSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=n37OLhluDeZRZjQV8gqjswMetHIVJY0WAfxFDmSPshs=;
        b=V8tfhZ5KoTkfUnSr4zQk1AFQwMZIDfFglvLMHN0oBAkYRX/T2Z0bItAvKPFRo24IHa
         sDGc38SzIFK1humRgIONcPRy7gzJbDSimBrYZjx2rX6X73d2NpzP/SLViWige7/GmW9T
         jUb9pqUAtB7iXCIDHHFMG0feY5jmnh1i7slf/HSz/GubFqBE8EL5ytK8R9iEFHRahl2r
         r2CG72LnhTFv9BMBByOFrR0su5qV6K681VWJiYHJbPsr6TigGQFywk3ciWRdrILl0iNx
         ymsGZBi9kkPV/KSa5kqGVmfvKYQUJKuiY7X1/l+ub57uwqu1fOCYY0rvIxPXQd9DSyRC
         S7qQ==
X-Gm-Message-State: AOAM531eebJru+oegbMDe372SicXNNHmXHphsASDoGZjqYFRv1s3R1Xe
        WaWNDyDpmzvVQDUs0IotSBBAFA==
X-Google-Smtp-Source: ABdhPJyEDKmFLRtJYfnFPvmAhLChghVgJ7rMcWed6hs0AcueTZLx1tLS3abGpGneOm6CWaHFi8gqag==
X-Received: by 2002:a1c:2c3:0:b0:38f:f280:caa3 with SMTP id 186-20020a1c02c3000000b0038ff280caa3mr24284284wmc.14.1652860754650;
        Wed, 18 May 2022 00:59:14 -0700 (PDT)
Received: from groot.home ([2a01:cb19:85e6:1900:bda6:8356:4db1:4539])
        by smtp.gmail.com with ESMTPSA id ay1-20020a05600c1e0100b0039706782e06sm1041300wmb.33.2022.05.18.00.59.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 May 2022 00:59:14 -0700 (PDT)
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
Subject: [PATCH v2 2/2] Input: mt6779-keypad - implement row/column selection
Date:   Wed, 18 May 2022 09:59:09 +0200
Message-Id: <20220518075909.180629-3-mkorpershoek@baylibre.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220518075909.180629-1-mkorpershoek@baylibre.com>
References: <20220518075909.180629-1-mkorpershoek@baylibre.com>
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
index 23360de20da5..9a8133970f5b 100644
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
2.34.1

