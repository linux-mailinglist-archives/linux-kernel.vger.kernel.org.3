Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBA2449605D
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 15:05:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241868AbiAUOE2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 09:04:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350781AbiAUODw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 09:03:52 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09650C06175A
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jan 2022 06:03:30 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id i187-20020a1c3bc4000000b0034d2ed1be2aso27828023wma.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jan 2022 06:03:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ubz92V3MNOcnXuX2tQRXSV5KJOVjCllK6LUruWkrRxU=;
        b=kHpYdrnVSjlgT6Y7rsIIE25S3iFVvp2QHcJfQ0aPOci6HIAGnbZ1yuN19J+BcTT0Bw
         YtGdz1Xb7wbSVWlfVFcs13ntB8C/N38MquVtWtAmKuOowMBdEZ2w5JtWg2Ctb4eiowtE
         Dqq6WTpe9lbyxxKoF23+0JVx+JGH2W4L3FpuBEs6zI0qjTDwlkOhqQ0AA/SZL3Iirrgr
         ewlGeeTaxzI3UKDAG5NBpv/Oyh01b9s+LDK6vMJfOqpsxKFFREbM/vsI5lgywsksGlST
         UBsRRY+4pBkKgCVN/4WeqltsOoZGvS3uFtzc8qLvpo7jbhOnJWCZnSGzFACJ4I5Bubai
         gpDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ubz92V3MNOcnXuX2tQRXSV5KJOVjCllK6LUruWkrRxU=;
        b=NxH35sF7fyYkMMpRoJK9GtMUvqf28SL5uvxRbAzPZKp9itb2g7jIQiJcejPoz1E61d
         CZs8GEXoGwt3EFqG9m4OPb2q89CqthOTgnbXcxwG1LpYhe7lwEJgvCCE7Gw2mNOwFdx9
         ygk5cyEYXqDsRuf2ARtNOGHzVZQhq//j5m0Kuu5UXAhWDTs7kDTfKachayfxUzZbbca4
         00jUi++BQyTtA7JPj3cexK5arB9tmxHSzh9l7UCztW+lBnjnX/KOF8WSBWJFs4Ef93Kq
         nbRp5K5tAdC34SQqEvOSwO/T2byXvpnXdEsgUvud8jnEU3I5AHZ6IswbQ19qfliYqcdD
         SzHQ==
X-Gm-Message-State: AOAM533azcb9XC5hnec3+IXuLI7gr8vQeYivGFbQ6sJZVr6RjwR4aMpl
        YOdV+3GmgENDXVsDkxNKg9tefQ==
X-Google-Smtp-Source: ABdhPJyT2dSh0BWpE3RsPLYyk9pNAlhiRIXgl2BBXrgRPQOeTr7YVMe4x28OyBuQ/pfFpeQImqsXhw==
X-Received: by 2002:adf:fe86:: with SMTP id l6mr3927973wrr.403.1642773808449;
        Fri, 21 Jan 2022 06:03:28 -0800 (PST)
Received: from groot.home (lfbn-tou-1-205-205.w86-201.abo.wanadoo.fr. [86.201.52.205])
        by smtp.gmail.com with ESMTPSA id p29sm9225129wms.5.2022.01.21.06.03.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jan 2022 06:03:28 -0800 (PST)
From:   Mattijs Korpershoek <mkorpershoek@baylibre.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Fabien Parent <fparent@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mattijs Korpershoek <mkorpershoek@baylibre.com>
Subject: [PATCH v4 1/4] Input: mtk-pmic-keys - use get_irq_byname() instead of index
Date:   Fri, 21 Jan 2022 15:03:20 +0100
Message-Id: <20220121140323.4080640-2-mkorpershoek@baylibre.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220121140323.4080640-1-mkorpershoek@baylibre.com>
References: <20220121140323.4080640-1-mkorpershoek@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some pmics of the mt6397 family (such as MT6358), have two IRQs per
physical key: one for press event, another for release event.

The mtk-pmic-keys driver assumes that each key only has one
IRQ. The key index and the RES_IRQ resource index have a 1/1 mapping.

This won't work for MT6358, as we have multiple resources (2) for one key.

To prepare mtk-pmic-keys to support MT6358, retrieve IRQs by name
instead of by index.

Signed-off-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
---
 drivers/input/keyboard/mtk-pmic-keys.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/input/keyboard/mtk-pmic-keys.c b/drivers/input/keyboard/mtk-pmic-keys.c
index 62391d6c7da6..d1abf95d5701 100644
--- a/drivers/input/keyboard/mtk-pmic-keys.c
+++ b/drivers/input/keyboard/mtk-pmic-keys.c
@@ -241,6 +241,7 @@ static int mtk_pmic_keys_probe(struct platform_device *pdev)
 	unsigned int keycount;
 	struct mt6397_chip *pmic_chip = dev_get_drvdata(pdev->dev.parent);
 	struct device_node *node = pdev->dev.of_node, *child;
+	static const char *const irqnames[] = { "powerkey", "homekey" };
 	struct mtk_pmic_keys *keys;
 	const struct mtk_pmic_regs *mtk_pmic_regs;
 	struct input_dev *input_dev;
@@ -268,7 +269,8 @@ static int mtk_pmic_keys_probe(struct platform_device *pdev)
 	input_dev->id.version = 0x0001;
 
 	keycount = of_get_available_child_count(node);
-	if (keycount > MTK_PMIC_MAX_KEY_COUNT) {
+	if (keycount > MTK_PMIC_MAX_KEY_COUNT ||
+	    keycount > ARRAY_SIZE(irqnames)) {
 		dev_err(keys->dev, "too many keys defined (%d)\n", keycount);
 		return -EINVAL;
 	}
@@ -276,7 +278,8 @@ static int mtk_pmic_keys_probe(struct platform_device *pdev)
 	for_each_child_of_node(node, child) {
 		keys->keys[index].regs = &mtk_pmic_regs->keys_regs[index];
 
-		keys->keys[index].irq = platform_get_irq(pdev, index);
+		keys->keys[index].irq =
+			platform_get_irq_byname(pdev, irqnames[index]);
 		if (keys->keys[index].irq < 0) {
 			of_node_put(child);
 			return keys->keys[index].irq;
-- 
2.32.0

