Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F28294953C1
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 18:59:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233042AbiATR6I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 12:58:08 -0500
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:40738
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233214AbiATR6E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 12:58:04 -0500
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com [209.85.128.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 7EC4140051
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jan 2022 17:58:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1642701482;
        bh=bto/xpfUsOVGNmCnHot8/BAzxWmx4lezX3yYM6aPOPk=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=O9Liw66QRr3+mkQAVdt2+stflkEYRvsSa4usKn2kA0H+YFnzXd8eOOWmtkQPQSLfW
         MfAZzRSo+ScEBtw5H/E3HnlgntkISXrqYHMbn5prZLaEqNZbUbdH3dJdCG9OaVqJa1
         ugdKlm1oyjtKinPrAFw/dXsa2YtGl5QnNukjaWbcnqlaBhfPho4/RlXqWVBHBas4tV
         ZL6ilfTP16eMEQWyoF5gja+JoFZRmQTdxHCPqg68FoRcNdikcW683HHK4aVSfrnEvn
         3kWLIUakJ5SuPVs7KaMbW+zp5ZiFbpBKBfrtVuT39if26w3Sy27Mg2h89r22YuejOp
         Zviz3KoraXUjA==
Received: by mail-wm1-f69.google.com with SMTP id v190-20020a1cacc7000000b0034657bb6a66so3256904wme.6
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jan 2022 09:58:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bto/xpfUsOVGNmCnHot8/BAzxWmx4lezX3yYM6aPOPk=;
        b=ZVlHuKBL+AniGH8P5LTPDNjm/FooCTkKxQmUG4tJSi2OOPrFaZaos2Kffgu+SmxzPK
         6MpvZvDzuIppFITftEvSjXWrRUcUZddN9LTpuMnSIO7TQBY04D+ZZS2K62YR0pTt4+uV
         BhNMWIASr3F89sbEsCwYBy9YacTL7HW6O6v1i/xg3FoQCEfafKNZPdp6GnYMbs6VsLXr
         jFzq3UE+nHqO5CS5UqOl4f5nJBsLJTqMTm6uleCu46mxQk6I70A6fOBbhOyW6DWt3P6H
         VF0aMtyZc0Prdk+poL2li+5CsAtOyC1eXteWN8w5575cGxaOXDeMkA8cuikjE3bg1U/Y
         FSuw==
X-Gm-Message-State: AOAM532ztBHOn+x5bzap6+ybIOtwTEsB4Rbo2RlNE3T0V3DaV9h8sbGo
        08LG4GIfCuODjwfzwQFinzUAfWVF1m37IsY1dpiQrPz4E6GE7tVksqSwlMrTLedQPkb45kKZ12d
        OTExyLkNrD26E5Pf5U5HwnnvY6GzI8i/36D8csngdjQ==
X-Received: by 2002:a1c:f012:: with SMTP id a18mr9989437wmb.73.1642701479318;
        Thu, 20 Jan 2022 09:57:59 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyqTIBDSwhzIJAAvThOjafSh4STpzbcmwUKvBnw8h3aAFohpEEpbyymlmGUkzLSw2lwFS1cZQ==
X-Received: by 2002:a1c:f012:: with SMTP id a18mr9989419wmb.73.1642701479169;
        Thu, 20 Jan 2022 09:57:59 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id a15sm3345248wrp.41.2022.01.20.09.57.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jan 2022 09:57:58 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Andi Shyti <andi@etezian.org>, Mark Brown <broonie@kernel.org>,
        Sam Protsenko <semen.protsenko@linaro.org>,
        Pratyush Yadav <p.yadav@ti.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-spi@vger.kernel.org
Cc:     Alim Akhtar <alim.akhtar@samsung.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v5 4/4] spi: s3c64xx: allow controller-data to be optional
Date:   Thu, 20 Jan 2022 18:57:47 +0100
Message-Id: <20220120175747.43403-5-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220120175747.43403-1-krzysztof.kozlowski@canonical.com>
References: <20220120175747.43403-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Samsung SoC SPI driver requires to provide controller-data node
for each of SPI peripheral device nodes.  Make this controller-data node
optional, so DTS could be simpler.

Suggested-by: Rob Herring <robh@kernel.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>
Reviewed-by: Andi Shyti <andi@etezian.org>
---
 drivers/spi/spi-s3c64xx.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index 8755cd85e83c..386550fca81c 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -796,16 +796,14 @@ static struct s3c64xx_spi_csinfo *s3c64xx_get_slave_ctrldata(
 		return ERR_PTR(-EINVAL);
 	}
 
-	data_np = of_get_child_by_name(slave_np, "controller-data");
-	if (!data_np) {
-		dev_err(&spi->dev, "child node 'controller-data' not found\n");
-		return ERR_PTR(-EINVAL);
-	}
-
 	cs = kzalloc(sizeof(*cs), GFP_KERNEL);
-	if (!cs) {
-		of_node_put(data_np);
+	if (!cs)
 		return ERR_PTR(-ENOMEM);
+
+	data_np = of_get_child_by_name(slave_np, "controller-data");
+	if (!data_np) {
+		dev_info(&spi->dev, "feedback delay set to default (0)\n");
+		return cs;
 	}
 
 	of_property_read_u32(data_np, "samsung,spi-feedback-delay", &fb_delay);
-- 
2.32.0

