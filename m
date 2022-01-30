Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 505204A3AF1
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 00:21:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235582AbiA3XV3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jan 2022 18:21:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229903AbiA3XV1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jan 2022 18:21:27 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63AABC061714;
        Sun, 30 Jan 2022 15:21:26 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id s13so37106206ejy.3;
        Sun, 30 Jan 2022 15:21:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :content-transfer-encoding;
        bh=B9+YmLMz9I8JI2bkFvn0VlkY5FsMRd/W96Q8oAu4JeY=;
        b=jzltUS/OOqnoq0aCALuHKrCgY1M33O8WdCBO0Ku4iUFPWnc8bguxpdqaBP8zJ266K4
         q+NGPjI7PR4xyUD0mc/xT1b8rYhQw6KmbthYcRqkEniWEszdbvHQ8ENZvOvC1Y2bSeGQ
         5QXcXOzqjSXVLsVLpdEXC1Em/cOokai5wz2V5dyHk4KmaUes/WniOEw3WycxXs2my6mw
         oNkybyMgakseYn3zInHsKpiKstboRSRRWiMRb/84D776NTfxL25ap2dPu2u/BjIUlW6Y
         GnQpT4pBT+b6aHVVrgI5P3xhZ6k4dOpEOILYtVBJ33HY+9FShe4oCbGzx/zSd2Q6/65H
         1Z4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding;
        bh=B9+YmLMz9I8JI2bkFvn0VlkY5FsMRd/W96Q8oAu4JeY=;
        b=Yz017GmFX9nFKohNt6pEQzVbPQoMxbghaRX5Uiy02XwIGZZkspVBl4sieDxxFZUxqK
         hhXSl9o5icT7HWE7TEyXCskies7a4qUrgUakAkihuaTDybiTVDKU0dkqt5j7sz7wHZv0
         2N4/WhoA45maFW208mKOVUDLZ79SoJbK60PRDTmNdlulKSE7ru7VTRq4WtsEOcodwqYA
         TzgGxe/n7Nce/0UCHANDdmayRgg1ADJ+2P+IhVU6PaCUcDDxplRWxyskOsW1R1aFUDL3
         cHfmPx09MUWmDrztV0i7vJrGjPe22WGcHrK+1EnJCF+MUXSw659FNRdlDWXEteS2m5AT
         W54g==
X-Gm-Message-State: AOAM530rhQTf9VUsUcNdaQzZJefFrETaBe+JwIqm1TicUnbbr5CPYEDV
        6dC7f94P+iP3HBUW+6m6Q2Q=
X-Google-Smtp-Source: ABdhPJyQajb/lyPVjck/laY6fY4dUFQYyCHEEkgA3IzlEV7WHTV13LQtR0ycykAIf9lTT8Ag9hCIMQ==
X-Received: by 2002:a17:907:3e16:: with SMTP id hp22mr14901004ejc.710.1643584884841;
        Sun, 30 Jan 2022 15:21:24 -0800 (PST)
Received: from adroid (027-177-184-091.ip-addr.vsenet.de. [91.184.177.27])
        by smtp.gmail.com with ESMTPSA id h3sm12472945ejl.193.2022.01.30.15.21.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Jan 2022 15:21:24 -0800 (PST)
Date:   Mon, 31 Jan 2022 00:21:22 +0100
From:   Martin =?iso-8859-1?Q?J=FCcker?= <martin.juecker@gmail.com>
To:     Tomasz Figa <tomasz.figa@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Martin =?iso-8859-1?Q?J=FCcker?= <martin.juecker@gmail.com>
Subject: [PATCH] pinctrl: samsung: improve wake irq info on console
Message-ID: <20220130232122.GA119248@adroid>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Improve the wake irq message by also printing the bank name and hwirq
number that matches this irq number.

Signed-off-by: Martin Jücker <martin.juecker@gmail.com>
---
 drivers/pinctrl/samsung/pinctrl-exynos.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pinctrl/samsung/pinctrl-exynos.c b/drivers/pinctrl/samsung/pinctrl-exynos.c
index 0489c899b401..30293fc23354 100644
--- a/drivers/pinctrl/samsung/pinctrl-exynos.c
+++ b/drivers/pinctrl/samsung/pinctrl-exynos.c
@@ -344,7 +344,8 @@ static int exynos_wkup_irq_set_wake(struct irq_data *irqd, unsigned int on)
 	struct samsung_pin_bank *bank = irq_data_get_irq_chip_data(irqd);
 	unsigned long bit = 1UL << (2 * bank->eint_offset + irqd->hwirq);
 
-	pr_info("wake %s for irq %d\n", on ? "enabled" : "disabled", irqd->irq);
+	pr_info("wake %s for irq %u (%s-%lu)\n", on ? "enabled" : "disabled",
+		irqd->irq, bank->name, irqd->hwirq);
 
 	if (!on)
 		*our_chip->eint_wake_mask_value |= bit;
-- 
2.25.1

