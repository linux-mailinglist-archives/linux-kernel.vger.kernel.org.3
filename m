Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6863B49418D
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 21:10:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357319AbiASUKc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 15:10:32 -0500
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:58682
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1357280AbiASUKV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 15:10:21 -0500
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com [209.85.208.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 43DF240037
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jan 2022 20:10:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1642623020;
        bh=YwgxoMtmx5KJnuRvatZdCUmCdGzGOSTGdP5YKiFMjK8=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=O8tOWnIemRV7rnry0jL12PqDtVFswNrDW0NYG8kk/YGaPZy9zj1aYXxh65kfeeyc3
         76LuvDosLqrU07lGnZsHE2ag4G3xsTUPJwldVXDBZWWQd2zr9IJYRmeb+DZhaHxCru
         QENYo/J5yf8gjPsdOEMqwpRghqYYkSCiC69yqK8azbAfWKroLfZU80qaNL+zArZvNU
         QZ3ozhD0gFNdn3PNiDe4fERIbXhHCELWp56uqXF6HLeFnUN2kowEizt8/j8+6wChxa
         OOdWEFJKqIsDw4fZuEtgF1g+9KNU2qajFN5Tw2gSYwABiYXa4+j2Lrz7eLWs3cYSvk
         YFwB9hrLEvCCg==
Received: by mail-ed1-f71.google.com with SMTP id n16-20020aa7c690000000b00404cfbb888dso359131edq.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jan 2022 12:10:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YwgxoMtmx5KJnuRvatZdCUmCdGzGOSTGdP5YKiFMjK8=;
        b=5MxRuL95hMcB8539kJrvnqP231aPMMapY4YoRXeve6FKW+CbUyiERssqmib++uN+CO
         7BU1p3wUs58uxvWsnVAWLErVUZU0NQPTz1YLjzVSTWpLmUOrGiYgQ04qBuDB1fr3sLHy
         ieizc9S/WyfuInvukveLwujhDtewizwcHuPfELl45V6GTquG6tJvnEWRecE0l/1KVwKq
         cr/DKjLWCNbxmk3WuGWZhzXDcFNOJRrxvuuthynzcdwp6pYKQpawdTFUG06TqENsV0wX
         BG/D5KaBnbqxMWpbEtgkgAfDNpzox2SxrlXS8uMWpu5v0oZxrn8z2sPRscLXZjJk6dUr
         s73Q==
X-Gm-Message-State: AOAM533IA1IXt4suTeTT6pBgMM6xY7+/I+Rt3G6CB8P29xsbPPHbysOp
        hSSmlm7WG93/8PZXhn2elM/+gWj0PatRbJ2yaL+5eNXk97LKwdRNDSbuVEtnxvTVpvvwrsjt0uq
        1RgIIk1095RjpLLgpOSO7BaUk6Qx9XrVsGJnSoCq8/w==
X-Received: by 2002:aa7:de97:: with SMTP id j23mr32294157edv.91.1642623019768;
        Wed, 19 Jan 2022 12:10:19 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyzOqDSpL6eHRmaEIopRqHKYyS27y17ZeCOBY9lq/0sAt9XXAM673SNZJ69DyQ4BP6FLp/q6g==
X-Received: by 2002:aa7:de97:: with SMTP id j23mr32294130edv.91.1642623019610;
        Wed, 19 Jan 2022 12:10:19 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id a26sm215005ejr.213.2022.01.19.12.10.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jan 2022 12:10:19 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Andi Shyti <andi@etezian.org>, Mark Brown <broonie@kernel.org>,
        Balletbo i Serra <enric.balletbo@collabora.com>,
        Sam Protsenko <semen.protsenko@linaro.org>,
        Pratyush Yadav <p.yadav@ti.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-spi@vger.kernel.org
Cc:     Alim Akhtar <alim.akhtar@samsung.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v4 5/5] spi: s3c64xx: allow controller-data to be optional
Date:   Wed, 19 Jan 2022 21:10:05 +0100
Message-Id: <20220119201005.13145-6-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220119201005.13145-1-krzysztof.kozlowski@canonical.com>
References: <20220119201005.13145-1-krzysztof.kozlowski@canonical.com>
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
---
 drivers/spi/spi-s3c64xx.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index 8755cd85e83c..769d958a2f86 100644
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
+		dev_info(&spi->dev, "child node 'controller-data' not found, using defaults\n");
+		return cs;
 	}
 
 	of_property_read_u32(data_np, "samsung,spi-feedback-delay", &fb_delay);
-- 
2.32.0

