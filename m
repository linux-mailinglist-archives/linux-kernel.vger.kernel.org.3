Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A6EB5813A7
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 14:57:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238958AbiGZM4u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 08:56:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238934AbiGZM4f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 08:56:35 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 183F82611B
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 05:56:34 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id b6so8680839wmq.5
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 05:56:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:date:subject:mime-version:content-transfer-encoding:message-id
         :references:in-reply-to:cc;
        bh=l4jlp8HIWV0/SRrpgeD2QZ+LASZjXbcoqy54oDuJlGI=;
        b=NADnXKatNswe0C+IvCk4tc03ZUzTZpk3sn84+xoWFiXrPT7GWye0NSZqFr6/NdWSMl
         9/wwttzMyxUIRsDBbIdZOICfo12+KUVdTwlxduE0LVIfJEwHRpjrP+BQvWIwD92wltrf
         Z4JeojrM6kR0yRjW8ttUZB/sxfUIk7INP2z2HcsbEotWV+FhQuM+6LyvEhnxFGpljCbR
         NhKwNEpYDi2Cb9wOTklQu+nhfHDsfKGzzZ5mOy6hKjHIiiqKP/4uRpuHa1sfZUTiMfgs
         dhjvKJ2JvtAya2HRtktEp9b/RfFy9SPjNLaezvbyVO7g3ruZvijW7iUTKtjNG/cwLDXJ
         f67g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:date:subject:mime-version
         :content-transfer-encoding:message-id:references:in-reply-to:cc;
        bh=l4jlp8HIWV0/SRrpgeD2QZ+LASZjXbcoqy54oDuJlGI=;
        b=S8kRzdV0oVs2KiN9YY7u2ksPPYxOCven0cVu10sFosf00jxGWugyoCpNC6IsZaJl0f
         M8ZiI42eIHLd9XRGdHJBdHdxeYpvEj/h/jA0JGVI0aQyIoM6YRKpiQp64nRQCxwADv5l
         TE/nCKwk4rghMNN2yR5yobVg5Sk/Tji/AI7OXcfVORmRS9CcxqQORgjDGH16niM1P0sT
         0PJ8MedtONhuKOlHvWJGWYWSmrejwouG6ItdnyIS1eA20KMMi2gI+7WY8TudW7qei42l
         d0ioEewv8jPuxOoEbzqMD3mQ/AhsxDXfifk+KHNt+EgV8kdY+JAHcPyhBM6noylgSFxc
         WQvA==
X-Gm-Message-State: AJIora/KbtCHgJ3RUa6SWvQRuSWCPxVQlFbpnPSRi3UfAISU0VOC4sY2
        UArBxzm4EIQZJG4RCaY/Y32e8A==
X-Google-Smtp-Source: AGRyM1tJyMC7Q+SkCcyxEXUMIyPM4vmZWiT2BfgqRy3V7c+2kZ2ogfDtq4Kq/q1vb7+t2z0rbSWCXQ==
X-Received: by 2002:a05:600c:1e27:b0:3a3:26dd:5757 with SMTP id ay39-20020a05600c1e2700b003a326dd5757mr3180782wmb.45.1658840192552;
        Tue, 26 Jul 2022 05:56:32 -0700 (PDT)
Received: from [192.168.2.253] ([82.66.159.240])
        by smtp.gmail.com with ESMTPSA id k1-20020adff5c1000000b0020fff0ea0a3sm14171549wrp.116.2022.07.26.05.56.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jul 2022 05:56:32 -0700 (PDT)
From:   Mattijs Korpershoek <mkorpershoek@baylibre.com>
Date:   Tue, 26 Jul 2022 14:56:09 +0200
Subject: [PATCH v2 4/7] Input: mt6779-keypad - prepare double keys support with
 calc_row_col
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20220720-mt8183-keypad-v2-4-6d42c357cb76@baylibre.com>
References: <20220720-mt8183-keypad-v2-0-6d42c357cb76@baylibre.com>
In-Reply-To: <20220720-mt8183-keypad-v2-0-6d42c357cb76@baylibre.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Fabien Parent <fparent@baylibre.com>,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        Fabien Parent <parent.f@gmail.com>
X-Mailer: b4 0.10.0-dev-78725
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,MISSING_HEADERS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The MediaTek keypad can operate in two modes: single key or double key.
The driver only supports single key mode. In double key mode, the
row/column calculation based on the key is different.

Add a calc_row_col function pointer which will be different based on
single/double key mode.

No functional change.

Suggested-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

diff --git a/drivers/input/keyboard/mt6779-keypad.c b/drivers/input/keyboard/mt6779-keypad.c
index bf447bf598fb..39c931974bde 100644
--- a/drivers/input/keyboard/mt6779-keypad.c
+++ b/drivers/input/keyboard/mt6779-keypad.c
@@ -31,6 +31,7 @@ struct mt6779_keypad {
 	struct clk *clk;
 	u32 n_rows;
 	u32 n_cols;
+	void (*calc_row_col)(unsigned int key, unsigned int *row, unsigned int *col);
 	DECLARE_BITMAP(keymap_state, MTK_KPD_NUM_BITS);
 };
 
@@ -67,8 +68,7 @@ static irqreturn_t mt6779_keypad_irq_handler(int irq, void *dev_id)
 			continue;
 
 		key = bit_nr / 32 * 16 + bit_nr % 32;
-		row = key / 9;
-		col = key % 9;
+		keypad->calc_row_col(key, &row, &col);
 
 		scancode = MATRIX_SCAN_CODE(row, col, row_shift);
 		/* 1: not pressed, 0: pressed */
@@ -94,6 +94,14 @@ static void mt6779_keypad_clk_disable(void *data)
 	clk_disable_unprepare(data);
 }
 
+static void mt6779_keypad_calc_row_col_single(unsigned int key,
+					      unsigned int *row,
+					      unsigned int *col)
+{
+	*row = key / 9;
+	*col = key % 9;
+}
+
 static int mt6779_keypad_pdrv_probe(struct platform_device *pdev)
 {
 	struct mt6779_keypad *keypad;
@@ -148,6 +156,8 @@ static int mt6779_keypad_pdrv_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
+	keypad->calc_row_col = mt6779_keypad_calc_row_col_single;
+
 	wakeup = device_property_read_bool(&pdev->dev, "wakeup-source");
 
 	dev_dbg(&pdev->dev, "n_row=%d n_col=%d debounce=%d\n",

-- 
b4 0.10.0-dev-78725
