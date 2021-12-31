Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5ECD74824CB
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Dec 2021 17:20:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229699AbhLaQUS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Dec 2021 11:20:18 -0500
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:46500
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229669AbhLaQUR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Dec 2021 11:20:17 -0500
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com [209.85.208.199])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 039CE3FFDF
        for <linux-kernel@vger.kernel.org>; Fri, 31 Dec 2021 16:20:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1640967616;
        bh=Z5ioY/F3t7PzEeZt89hQh1G0ZQnghAHpzWba5N0rXNM=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=WBkNCBMiSw5kLBH+8ozClnbMsw34QNzg616H5Ps8B0hbiRxcGlHbGZ+GyzhdB6CJQ
         LmH4tVTZ2y9xRBeF7MEMxPhEqU+Mq/l3FDrUZ8f5WTePRZCi5RP7eU/XlNhlSWSeAA
         1u1AAVyJK/b8ngGiRNx8nRJ58gDd+Sxx+xg3NuzVtIKZVBZC41gu6R6zOlARF7usky
         p8yCL5yp8w4vHvYfMZzMCPfTQdlB9IfmgBUH0woQ45ybk9hJY38mp1xYRuz/we9azU
         LMclOWRh9MdCxvqydXMGqNeh+mvCXP7sHjgod0320bx5d2Zs1NODK+DWrEs34annVV
         b+SEYzpqBMkHA==
Received: by mail-lj1-f199.google.com with SMTP id v19-20020a2e87d3000000b0022dbe4687f1so6707332ljj.7
        for <linux-kernel@vger.kernel.org>; Fri, 31 Dec 2021 08:20:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Z5ioY/F3t7PzEeZt89hQh1G0ZQnghAHpzWba5N0rXNM=;
        b=k3IloEg7O05x0TAby+8w1jIBf7FN/lKM9TbMQX07jDjoXWhkY7hpzwp2NVhqA4F6vk
         wHRe3wSoWwAjFfFJY3NrhaFKzW1z1WTX9+d5Mm2vDnhzax1wRS+wXEX0Z61/2Z97VW0q
         8+5r/f0Z4qbDbIiSel5Euro/rlxJFjZ02WAf45BbkpMakivqjC49hWmvqErGjvX2nLYZ
         3/l91SYWiGRQSIPw0oSSbCI5iDBIOC8WnKMjUKYC/BbE6H6vsc+CpaOgDW9ld9Vu9YDo
         gWMrmo/023co9RDeZKOnI53qulxMpZCqsw998kko6aE2pxvGTanVRDbxyb4/pNh3UROU
         eYzA==
X-Gm-Message-State: AOAM533j3nzgCsGAG7MJ3TiHsLGUbrvztA5JcVnuc6OZSAzQ6a58BNQv
        oUEU0Z+Mbf8wRmI4JL3+kQgtFHC+ajCFyL4sq4EZ2qsSycKW3EjEKQbJjCAnJt7Xp9LI24R5MCM
        HO/aASGA+LNR/naa9E74a1yjguRA+K3aLtEt5f6J1rg==
X-Received: by 2002:a05:651c:a09:: with SMTP id k9mr9172158ljq.180.1640967615228;
        Fri, 31 Dec 2021 08:20:15 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzc+4kTYgqygG16URIJFVj2z6Z4ttRC0uwPhq5+1fKUZ9If5v0MZQV6COmgWUmppRWM7qDBog==
X-Received: by 2002:a05:651c:a09:: with SMTP id k9mr9172134ljq.180.1640967614996;
        Fri, 31 Dec 2021 08:20:14 -0800 (PST)
Received: from krzk-bin.lan (89-77-68-124.dynamic.chello.pl. [89.77.68.124])
        by smtp.gmail.com with ESMTPSA id bx10sm2817607ljb.3.2021.12.31.08.20.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Dec 2021 08:20:14 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Tomasz Figa <tomasz.figa@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Sylwester Nawrocki <snawrocki@kernel.org>,
        Sam Protsenko <semen.protsenko@linaro.org>,
        Chanho Park <chanho61.park@samsung.com>, stable@vger.kernel.org
Subject: [PATCH 01/24] pinctrl: samsung: drop pin banks references on error paths
Date:   Fri, 31 Dec 2021 17:19:07 +0100
Message-Id: <20211231161930.256733-2-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211231161930.256733-1-krzysztof.kozlowski@canonical.com>
References: <20211231161930.256733-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver iterates over its devicetree children with
for_each_child_of_node() and stores for later found node pointer.  This
has to be put in error paths to avoid leak during re-probing.

Fixes: ab663789d697 ("pinctrl: samsung: Match pin banks with their device nodes")
Cc: <stable@vger.kernel.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 drivers/pinctrl/samsung/pinctrl-samsung.c | 29 +++++++++++++++++------
 1 file changed, 22 insertions(+), 7 deletions(-)

diff --git a/drivers/pinctrl/samsung/pinctrl-samsung.c b/drivers/pinctrl/samsung/pinctrl-samsung.c
index 8941f658e7f1..f2864a7869b3 100644
--- a/drivers/pinctrl/samsung/pinctrl-samsung.c
+++ b/drivers/pinctrl/samsung/pinctrl-samsung.c
@@ -1002,6 +1002,15 @@ samsung_pinctrl_get_soc_data_for_of_alias(struct platform_device *pdev)
 	return &(of_data->ctrl[id]);
 }
 
+static void samsung_banks_of_node_put(struct samsung_pinctrl_drv_data *d)
+{
+	struct samsung_pin_bank *bank;
+	unsigned int i;
+
+	for (i = 0; i < d->nr_banks; ++i, ++bank)
+		of_node_put(bank->of_node);
+}
+
 /* retrieve the soc specific data */
 static const struct samsung_pin_ctrl *
 samsung_pinctrl_get_soc_data(struct samsung_pinctrl_drv_data *d,
@@ -1116,19 +1125,19 @@ static int samsung_pinctrl_probe(struct platform_device *pdev)
 	if (ctrl->retention_data) {
 		drvdata->retention_ctrl = ctrl->retention_data->init(drvdata,
 							  ctrl->retention_data);
-		if (IS_ERR(drvdata->retention_ctrl))
-			return PTR_ERR(drvdata->retention_ctrl);
+		if (IS_ERR(drvdata->retention_ctrl)) {
+			ret = PTR_ERR(drvdata->retention_ctrl);
+			goto err_put_banks;
+		}
 	}
 
 	ret = samsung_pinctrl_register(pdev, drvdata);
 	if (ret)
-		return ret;
+		goto err_put_banks;
 
 	ret = samsung_gpiolib_register(pdev, drvdata);
-	if (ret) {
-		samsung_pinctrl_unregister(pdev, drvdata);
-		return ret;
-	}
+	if (ret)
+		goto err_unregister;
 
 	if (ctrl->eint_gpio_init)
 		ctrl->eint_gpio_init(drvdata);
@@ -1138,6 +1147,12 @@ static int samsung_pinctrl_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, drvdata);
 
 	return 0;
+
+err_unregister:
+	samsung_pinctrl_unregister(pdev, drvdata);
+err_put_banks:
+	samsung_banks_of_node_put(drvdata);
+	return ret;
 }
 
 /*
-- 
2.32.0

