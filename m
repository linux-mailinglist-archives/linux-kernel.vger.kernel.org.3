Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 095DA53911C
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 14:50:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344395AbiEaMun (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 08:50:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244195AbiEaMu1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 08:50:27 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE23E73552
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 05:50:25 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id r129so2680534wmr.3
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 05:50:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vH18YmztAddzvuuGm66+CYpM63IW/TSQJt/1O1NxYf8=;
        b=mvAUlLlgWq3s1GHJmM8Ti0FVDe+xL07OqxPOiHqygKOx9iLzqVbGNbUBaMqIS75F/n
         ZtrI0pWp+siR+HrEjQH6BEZtH4t7MN19kVaMbsXjlQ2eEHr5cXg5QiJ+89r/+1Eontwo
         ISwF+uIYnlCrUYEzfoUzLYcZpsjIaY1mY70FWxtDMaKzFNm28MFj4DkD1JjojSIvA7bq
         YGy+vyamBVpY4v09jx8MlCfT+EZW+abjXtr9pNa+rujp1wxUqhqin3NJazrx/+p0G6UG
         7Ekx8GidumaYatHriMFCyKVOH5val5StsB/9oASu6zKg68B72/5DpzQzAStVI+jLoaIf
         DjbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vH18YmztAddzvuuGm66+CYpM63IW/TSQJt/1O1NxYf8=;
        b=4UpTSTkH8K4uqWN4pi0ZPCNRHHhKz3vn8h5APPeWwwe/5FisP+k503CM5Eqn7v0Szm
         WD0eEqui445xGVJX/m5p86KsRn75ou7ZDSEKtmVZZ6ASKvMfjMKQlNGXsgQHgblHZeUM
         YT2PsHRtXL3iS9ZKMWSBaOGjZads/aaWlAylzU3jLAH+NEdvraqFv0tDOqXW9LFwblmM
         oAx7rJYYYntKICfXeTuoisy4uqSUX5SE7sC/h/rW9C1/p1GkqLMcqtWfo5DccLoJIu+X
         gQwB7oZngeugQT2a/hhbvavAl00y90PRni9VnmUzOuuQ6d7XOMW7kUOhsQUT92p6tpvM
         K5Lg==
X-Gm-Message-State: AOAM531WQPKuhNFG6jPi2dIFPQh4LkRdYMaN50qBc9Fqr054GKJc8d8P
        0PZdzq1tauV4kqLPM93W2AGHdQ==
X-Google-Smtp-Source: ABdhPJwQ38QgkJzAFctHWeekZJuWWVLy/1P/trpuL3oru//3qDkhF0gce5Krlfm/5Z6spoPXwHobJA==
X-Received: by 2002:a05:600c:34d1:b0:397:4c0d:598a with SMTP id d17-20020a05600c34d100b003974c0d598amr23295563wmq.36.1654001424541;
        Tue, 31 May 2022 05:50:24 -0700 (PDT)
Received: from helium.lan ([88.160.162.107])
        by smtp.gmail.com with ESMTPSA id i13-20020adfaacd000000b0020fc40d006bsm11475019wrc.17.2022.05.31.05.50.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 May 2022 05:50:23 -0700 (PDT)
From:   Fabien Parent <fparent@baylibre.com>
To:     Lee Jones <lee.jones@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Fabien Parent <fparent@baylibre.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 5/7] mfd: mt6358-irq: add MT6357 PMIC support
Date:   Tue, 31 May 2022 14:49:57 +0200
Message-Id: <20220531124959.202787-6-fparent@baylibre.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220531124959.202787-1-fparent@baylibre.com>
References: <20220531124959.202787-1-fparent@baylibre.com>
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

Add MT6357 PMIC IRQ support.

Signed-off-by: Fabien Parent <fparent@baylibre.com>
---
 drivers/mfd/mt6358-irq.c        | 24 ++++++++++++++++++++++++
 include/linux/mfd/mt6397/core.h |  1 +
 2 files changed, 25 insertions(+)

diff --git a/drivers/mfd/mt6358-irq.c b/drivers/mfd/mt6358-irq.c
index ea5e452510eb..389756436af6 100644
--- a/drivers/mfd/mt6358-irq.c
+++ b/drivers/mfd/mt6358-irq.c
@@ -3,6 +3,8 @@
 // Copyright (c) 2020 MediaTek Inc.
 
 #include <linux/interrupt.h>
+#include <linux/mfd/mt6357/core.h>
+#include <linux/mfd/mt6357/registers.h>
 #include <linux/mfd/mt6358/core.h>
 #include <linux/mfd/mt6358/registers.h>
 #include <linux/mfd/mt6359/core.h>
@@ -17,6 +19,17 @@
 
 #define MTK_PMIC_REG_WIDTH 16
 
+static const struct irq_top_t mt6357_ints[] = {
+	MT6357_TOP_GEN(BUCK),
+	MT6357_TOP_GEN(LDO),
+	MT6357_TOP_GEN(PSC),
+	MT6357_TOP_GEN(SCK),
+	MT6357_TOP_GEN(BM),
+	MT6357_TOP_GEN(HK),
+	MT6357_TOP_GEN(AUD),
+	MT6357_TOP_GEN(MISC),
+};
+
 static const struct irq_top_t mt6358_ints[] = {
 	MT6358_TOP_GEN(BUCK),
 	MT6358_TOP_GEN(LDO),
@@ -39,6 +52,13 @@ static const struct irq_top_t mt6359_ints[] = {
 	MT6359_TOP_GEN(MISC),
 };
 
+static struct pmic_irq_data mt6357_irqd = {
+	.num_top = ARRAY_SIZE(mt6357_ints),
+	.num_pmic_irqs = MT6357_IRQ_NR,
+	.top_int_status_reg = MT6357_TOP_INT_STATUS0,
+	.pmic_ints = mt6357_ints,
+};
+
 static struct pmic_irq_data mt6358_irqd = {
 	.num_top = ARRAY_SIZE(mt6358_ints),
 	.num_pmic_irqs = MT6358_IRQ_NR,
@@ -211,6 +231,10 @@ int mt6358_irq_init(struct mt6397_chip *chip)
 	struct pmic_irq_data *irqd;
 
 	switch (chip->chip_id) {
+	case MT6357_CHIP_ID:
+		chip->irq_data = &mt6357_irqd;
+		break;
+
 	case MT6358_CHIP_ID:
 	case MT6366_CHIP_ID:
 		chip->irq_data = &mt6358_irqd;
diff --git a/include/linux/mfd/mt6397/core.h b/include/linux/mfd/mt6397/core.h
index 1cf78726503b..3fecaffe5019 100644
--- a/include/linux/mfd/mt6397/core.h
+++ b/include/linux/mfd/mt6397/core.h
@@ -12,6 +12,7 @@
 
 enum chip_id {
 	MT6323_CHIP_ID = 0x23,
+	MT6357_CHIP_ID = 0x57,
 	MT6358_CHIP_ID = 0x58,
 	MT6359_CHIP_ID = 0x59,
 	MT6366_CHIP_ID = 0x66,
-- 
2.36.1

