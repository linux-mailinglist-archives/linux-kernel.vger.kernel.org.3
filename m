Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC28350FFB2
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 15:54:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351239AbiDZN46 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 09:56:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351194AbiDZN4p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 09:56:45 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09A7E15CF75
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 06:53:32 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id w4so25535378wrg.12
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 06:53:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IG33gJfmQ/EOz8na70kwRaCTRZKTSW8kT9nFppeB52c=;
        b=7SFdF4zW4cjXauDzX5ndJqFVFTh7/DHREEin69o26mGqlPfl0nG84eROQy35s/D4im
         jUG6HIxe07HEZE9T/vDxZK4ickju6ZQTM4GyRq+f5Ttwl+hKmyq6o9JY6CbSmHIFdPGi
         h20VCnQFAVTNxCP8i45bIqn1AdJIIrODlI1sKI7aT9X1tNIUKfKJhdnDspUCWKePIeo5
         2APk0x3U3rKX+g9oY14l1tZIrrsUIcFop1N7WymIWfz5V42gMJ4bCX70Qej1DSRhJZji
         a23LjglTVJB9+wkW0cLPP+8q/J8iFntvk4wEvG236G1mLfb9GTL228BfptWygNayNnVQ
         /SCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IG33gJfmQ/EOz8na70kwRaCTRZKTSW8kT9nFppeB52c=;
        b=XRgkv0dr5s6qbseu6/mmDTPqUgiGy0BAByGPnL9AzkK2oW+gBtApGy2/vx+ybfLL1N
         3qG+eQeuRglEO2hYhm8xEv1QmCPy5zJJTT94adn1FAEpTuHWi5c6dCSJS5UU0Bj0YuYF
         EamsWnsi/Q8HLwjCrItxXaHtrHLpz2Sf0LOK2vfFkY47hjClkUTjD8u1NWNZbm5c+Bpj
         Z84329SwETnB6Oontw1cO8dh6t74apXF3rIeMsmddLJo7YuTlYkIfi5hAoXIvmyZXlQP
         4QAwjP/WoqF8xm9YFriqnO9xJaBUr4x+Qghzzn5rKj2d1PiCd0Fmiiq4e5J487HsTOEC
         BGhw==
X-Gm-Message-State: AOAM53280k1WMUYDHO4iEwRlzqtZHcmm4R8G+lTTe4ZxcWqbKFNk5fVB
        5AY1+wVTp9qiH3BAggn63WxumA==
X-Google-Smtp-Source: ABdhPJxoxTSsYvW2Te7nLeCmhF9o4bMlwjSRtCtf0E4uy+KjA6IngSDYs7AGW5znIkg5xhCcXc5Icg==
X-Received: by 2002:a5d:59a9:0:b0:20a:9047:24ac with SMTP id p9-20020a5d59a9000000b0020a904724acmr19063965wrr.396.1650981211477;
        Tue, 26 Apr 2022 06:53:31 -0700 (PDT)
Received: from localhost.localdomain ([88.160.162.107])
        by smtp.gmail.com with ESMTPSA id m35-20020a05600c3b2300b00393ebe201a6sm5504775wms.44.2022.04.26.06.53.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Apr 2022 06:53:31 -0700 (PDT)
From:   Fabien Parent <fparent@baylibre.com>
To:     Lee Jones <lee.jones@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Fabien Parent <fparent@baylibre.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/8] mfd: mt6397-core: add resources for PMIC keys for MT6359
Date:   Tue, 26 Apr 2022 15:53:08 +0200
Message-Id: <20220426135313.245466-4-fparent@baylibre.com>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20220426135313.245466-1-fparent@baylibre.com>
References: <20220426135313.245466-1-fparent@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the MFD resources in order to be able to probe and use the keyboard
driver for the MT6359 PMIC.

Signed-off-by: Fabien Parent <fparent@baylibre.com>
---
v2: no changes

 drivers/mfd/mt6397-core.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/mfd/mt6397-core.c b/drivers/mfd/mt6397-core.c
index bddb40054b9e..1a368ad08f58 100644
--- a/drivers/mfd/mt6397-core.c
+++ b/drivers/mfd/mt6397-core.c
@@ -54,6 +54,13 @@ static const struct resource mt6358_keys_resources[] = {
 	DEFINE_RES_IRQ_NAMED(MT6358_IRQ_HOMEKEY_R, "homekey_r"),
 };
 
+static const struct resource mt6359_keys_resources[] = {
+	DEFINE_RES_IRQ_NAMED(MT6359_IRQ_PWRKEY, "powerkey"),
+	DEFINE_RES_IRQ_NAMED(MT6359_IRQ_HOMEKEY, "homekey"),
+	DEFINE_RES_IRQ_NAMED(MT6359_IRQ_PWRKEY_R, "powerkey_r"),
+	DEFINE_RES_IRQ_NAMED(MT6359_IRQ_HOMEKEY_R, "homekey_r"),
+};
+
 static const struct resource mt6323_keys_resources[] = {
 	DEFINE_RES_IRQ_NAMED(MT6323_IRQ_STATUS_PWRKEY, "powerkey"),
 	DEFINE_RES_IRQ_NAMED(MT6323_IRQ_STATUS_FCHRKEY, "homekey"),
@@ -122,6 +129,12 @@ static const struct mfd_cell mt6359_devs[] = {
 		.of_compatible = "mediatek,mt6358-rtc",
 	},
 	{ .name = "mt6359-sound", },
+	{
+		.name = "mtk-pmic-keys",
+		.num_resources = ARRAY_SIZE(mt6359_keys_resources),
+		.resources = mt6359_keys_resources,
+		.of_compatible = "mediatek,mt6359-keys"
+	},
 };
 
 static const struct mfd_cell mt6397_devs[] = {
-- 
2.36.0

