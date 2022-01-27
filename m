Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DA7649EDC1
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 22:50:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238341AbiA0Vun (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 16:50:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233574AbiA0Vum (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 16:50:42 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F4F2C061714;
        Thu, 27 Jan 2022 13:50:42 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id b1-20020a17090a990100b001b14bd47532so4454237pjp.0;
        Thu, 27 Jan 2022 13:50:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bPYN1y0P5vV2Se4amYQVixGh8Z0Upgf/B1r9635Dq04=;
        b=bkyYQxusr3zSqNY4Xt/NT/oMbZsjX0v5CJwGSwmXvL9pROv3rTHnXgFouQYjHEynGw
         mk/ieFvAk6YukjrVSeM77IhHHsDOG8QJDTkzlm7Qa+r9S6pLilRiLZwre60zJyMrhtjj
         X6f57BqpFDgeraghfMb6mTjp6Zfyb3uTClLQxjZj3sNTr2y9vSgRbptjEGm4FE9HL8ey
         LQk9e8mQtCaWk8X6sG7LfzUTHgNatTrm2LhqKaLPU/Tl79b6+VcVfaVXhUShNomLeQTc
         YORdr3RIPUNdFOHN9ABJX/EqSL8XhH11awY/PzQDqI5oLsIBHd+SZDw/zfLJyv7YZnrl
         D3NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bPYN1y0P5vV2Se4amYQVixGh8Z0Upgf/B1r9635Dq04=;
        b=kmlpmY9QkZfkVh7l6ImVSgWGBaxB6e32ybJiot37O3z9e2miQ7IMkaC8I2zGwqgg7D
         cnOMyrn2EZTB97vwzvjQqAdcMHhlSDRsc0mEgqCG3gnAsViw2hYWqMyUS4wJQ78RdA+P
         6bBoNGGA0jv1rX8jqCXY6eWChshAsCfk1XbYQouIgRljidTs7wJfBpqFxWQ4JIkWSlR8
         d7kGCLlHdVJnMpvKF/G7OxI6KzSxgRN3X1/CHVyX33VJYkRpkIuQn9aLJbwH+tLH0fhj
         72wHRP8xas/eTFpVu4Qx/UVBwb/vok1AnaA2an6H5zJmpuCK9c3p8galn/61+JbYNJ6w
         EPOQ==
X-Gm-Message-State: AOAM531fyBhBQ2eyNhtLO2vW9KVeZCCous6g7DWBvWBWfZQYEFF99m7I
        1u4H3mNgv1oEVhNI4b4EJfYZFqp7HGE=
X-Google-Smtp-Source: ABdhPJyDiKOPVs7PSeybcMqGT+1WLcaLVA9hNTX4HM3cU1nMFQNppy/umKeKJWkVxkFJVMtMUCPjHQ==
X-Received: by 2002:a17:90b:1d01:: with SMTP id on1mr5407800pjb.77.1643320241519;
        Thu, 27 Jan 2022 13:50:41 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id j6sm7073973pfu.18.2022.01.27.13.50.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jan 2022 13:50:40 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com (maintainer:BROADCOM
        BCM281XX/BCM11XXX/BCM216XX ARM ARCHITE...),
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Phil Elwell <phil@raspberrypi.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jason Wang <wangborong@cdjrlc.com>,
        Marc Zyngier <maz@kernel.org>,
        linux-gpio@vger.kernel.org (open list:PIN CONTROL SUBSYSTEM),
        linux-rpi-kernel@lists.infradead.org (moderated list:BROADCOM
        BCM2711/BCM2835 ARM ARCHITECTURE),
        linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM
        BCM2711/BCM2835 ARM ARCHITECTURE)
Subject: [PATCH] pinctrl: bcm2835: Fix a few error paths
Date:   Thu, 27 Jan 2022 13:50:31 -0800
Message-Id: <20220127215033.267227-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After commit 266423e60ea1 ("pinctrl: bcm2835: Change init order for gpio
hogs") a few error paths would not unwind properly the registration of
gpio ranges. Correct that by assigning a single error label and goto it
whenever we encounter a fatal error.

Fixes: 266423e60ea1 ("pinctrl: bcm2835: Change init order for gpio hogs")
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/pinctrl/bcm/pinctrl-bcm2835.c | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/drivers/pinctrl/bcm/pinctrl-bcm2835.c b/drivers/pinctrl/bcm/pinctrl-bcm2835.c
index c4ebfa852b42..47e433e09c5c 100644
--- a/drivers/pinctrl/bcm/pinctrl-bcm2835.c
+++ b/drivers/pinctrl/bcm/pinctrl-bcm2835.c
@@ -1269,16 +1269,18 @@ static int bcm2835_pinctrl_probe(struct platform_device *pdev)
 				     sizeof(*girq->parents),
 				     GFP_KERNEL);
 	if (!girq->parents) {
-		pinctrl_remove_gpio_range(pc->pctl_dev, &pc->gpio_range);
-		return -ENOMEM;
+		err = -ENOMEM;
+		goto out_remove;
 	}
 
 	if (is_7211) {
 		pc->wake_irq = devm_kcalloc(dev, BCM2835_NUM_IRQS,
 					    sizeof(*pc->wake_irq),
 					    GFP_KERNEL);
-		if (!pc->wake_irq)
-			return -ENOMEM;
+		if (!pc->wake_irq) {
+			err = -ENOMEM;
+			goto out_remove;
+		}
 	}
 
 	/*
@@ -1306,8 +1308,10 @@ static int bcm2835_pinctrl_probe(struct platform_device *pdev)
 
 		len = strlen(dev_name(pc->dev)) + 16;
 		name = devm_kzalloc(pc->dev, len, GFP_KERNEL);
-		if (!name)
-			return -ENOMEM;
+		if (!name) {
+			err = -ENOMEM;
+			goto out_remove;
+		}
 
 		snprintf(name, len, "%s:bank%d", dev_name(pc->dev), i);
 
@@ -1326,11 +1330,14 @@ static int bcm2835_pinctrl_probe(struct platform_device *pdev)
 	err = gpiochip_add_data(&pc->gpio_chip, pc);
 	if (err) {
 		dev_err(dev, "could not add GPIO chip\n");
-		pinctrl_remove_gpio_range(pc->pctl_dev, &pc->gpio_range);
-		return err;
+		goto out_remove;
 	}
 
 	return 0;
+
+out_remove:
+	pinctrl_remove_gpio_range(pc->pctl_dev, &pc->gpio_range);
+	return err;
 }
 
 static struct platform_driver bcm2835_pinctrl_driver = {
-- 
2.25.1

