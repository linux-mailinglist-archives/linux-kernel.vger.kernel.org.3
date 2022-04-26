Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9418250FFAE
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 15:54:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351263AbiDZN5H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 09:57:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351215AbiDZN4q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 09:56:46 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76D2115DD7E
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 06:53:37 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id s21so10890792wrb.8
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 06:53:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qek8WhKX0R1hchr7sewuE/CWJLJNrj/b//Vrg13RV5s=;
        b=uM2UEk3aImwHE6qFhV3CyW6+TuirIyp6LnmblEvuDSJAZMIzZc1m+gOFbqP/RjTQEI
         HjG/j2jhXKM7AwvpWXiR3m/hN5fyUxXZFmNsHUxkOSgRW3lDZU/vryXlk85JzE/hFMs1
         B+7BTJUsQEAlPnrroSd49bUYmEjRxYx88fHT9axNXJZGKupxGuTs/3fnc7fbnkjrMlfm
         xxoF7nBpXQAaVNGgMHdtTLzd9B5dHKR8n+Dd5Kz8vlpMeA5Nm3W2E6RGleTrzyi/O9i6
         4bwhOeLOwvOla0GTEMCNp+04CH2vD2i0oNR8S9XF2vdlto4CU8JTvnGnAo7MvtTJc4cJ
         4hFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qek8WhKX0R1hchr7sewuE/CWJLJNrj/b//Vrg13RV5s=;
        b=EaWhcQ7oT6a5jOtT+VcyxaVjg1EKn5xOVL1BD6LUgMijuMKLdk9/8wchva8u0Fs3lR
         6WhCe83WKz8P8X8kAHeTbHPWDpev7ps8crzSYLxxuXxb3Ugx7iyZXh0mSBLhf2b2XNfZ
         PsRs2nEWVrYnJTIj+1OE782MLaJaq0WAq+u537a1NdSv782hWwiak/xksZNvQ4O7rpW8
         1yf2dwZgPj+DrI2aX+a9NJkTufyM9DVvkdWf0acseczWAfJCvSDA8dGgoPCTTUgOUNif
         xxqAYEN9MQ0EqiBJXa930oYpRxsRyG6fviqQ2B08k+A3SvVVJjKAwwQEaBdhLb8raOEK
         jZqw==
X-Gm-Message-State: AOAM531Ym7RUxCFmIopfRdegvF4UPwgdb3/hmnudHE472sIuEtOK22lk
        pF+7VHfNCa1XhyBc0tCwkqXxjA==
X-Google-Smtp-Source: ABdhPJxUR9Jtuqq119l4xJed5Lzq8/81nYLzjxAkVb3AcK+LTLpg18lkx0agwYhFDZnMSWgT2t7s5g==
X-Received: by 2002:a5d:47c3:0:b0:20a:d856:8a9c with SMTP id o3-20020a5d47c3000000b0020ad8568a9cmr9762114wrc.181.1650981216041;
        Tue, 26 Apr 2022 06:53:36 -0700 (PDT)
Received: from localhost.localdomain ([88.160.162.107])
        by smtp.gmail.com with ESMTPSA id m35-20020a05600c3b2300b00393ebe201a6sm5504775wms.44.2022.04.26.06.53.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Apr 2022 06:53:35 -0700 (PDT)
From:   Fabien Parent <fparent@baylibre.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Fabien Parent <fparent@baylibre.com>, linux-input@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 6/8] Input: keyboard: mtk-pmic-keys: add support for MT6359
Date:   Tue, 26 Apr 2022 15:53:11 +0200
Message-Id: <20220426135313.245466-7-fparent@baylibre.com>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20220426135313.245466-1-fparent@baylibre.com>
References: <20220426135313.245466-1-fparent@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for the MT6359 PMIC.

Signed-off-by: Fabien Parent <fparent@baylibre.com>
---
v2: no changes

 drivers/input/keyboard/mtk-pmic-keys.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/input/keyboard/mtk-pmic-keys.c b/drivers/input/keyboard/mtk-pmic-keys.c
index 609b87afd020..115ed4aaae81 100644
--- a/drivers/input/keyboard/mtk-pmic-keys.c
+++ b/drivers/input/keyboard/mtk-pmic-keys.c
@@ -10,6 +10,7 @@
 #include <linux/kernel.h>
 #include <linux/mfd/mt6323/registers.h>
 #include <linux/mfd/mt6358/registers.h>
+#include <linux/mfd/mt6359/registers.h>
 #include <linux/mfd/mt6397/core.h>
 #include <linux/mfd/mt6397/registers.h>
 #include <linux/module.h>
@@ -87,6 +88,17 @@ static const struct mtk_pmic_keys_pdata mt6358_pdata = {
 	.has_key_release_irqs = true,
 };
 
+static const struct mtk_pmic_keys_pdata mt6359_pdata = {
+	.keys_regs[MTK_PMIC_PWRKEY_INDEX] =
+		MTK_PMIC_KEYS_REGS(MT6359_TOPSTATUS,
+		0x2, MT6359_PSC_TOP_INT_CON0, 0x5),
+	.keys_regs[MTK_PMIC_HOMEKEY_INDEX] =
+		MTK_PMIC_KEYS_REGS(MT6359_TOPSTATUS,
+		0x8, MT6359_PSC_TOP_INT_CON0, 0xa),
+	.pmic_rst_reg = MT6359_TOP_RST_MISC,
+	.has_key_release_irqs = true,
+};
+
 struct mtk_pmic_keys_info {
 	struct mtk_pmic_keys *keys;
 	const struct mtk_pmic_keys_regs *regs;
@@ -264,6 +276,9 @@ static const struct of_device_id of_mtk_pmic_keys_match_tbl[] = {
 	}, {
 		.compatible = "mediatek,mt6358-keys",
 		.data = &mt6358_pdata,
+	}, {
+		.compatible = "mediatek,mt6359-keys",
+		.data = &mt6359_pdata,
 	}, {
 		/* sentinel */
 	}
-- 
2.36.0

