Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4453497A41
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 09:24:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236216AbiAXIYG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 03:24:06 -0500
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:58640
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242158AbiAXIYA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 03:24:00 -0500
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com [209.85.128.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 9910940051
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 08:23:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1643012638;
        bh=bto/xpfUsOVGNmCnHot8/BAzxWmx4lezX3yYM6aPOPk=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=JSWnxyc6Ynxb4pzX0DEiloksdMGeHVH6a9RN36NM0CxF6rmsONQ+hL2l9dBHMFvjB
         z6JSuTDgV5/BKMd1xaTWFZK1rPg2NhY4OhzxdCqTYvI3Og0fVfnzpwcon8qI397GjX
         iK9t4+pMFlgIwuYpspxZ7nUKciXf11UZYK67XL5sEZLgiPP02j+BBixUbYnjA8aJUs
         z0j7L8lKXGFADXh6fAMbEZDzJWe6YxFdP+I5LFJKRCK7BywQfIGhKAXdicexuhs7tA
         sNekQUWlnhnJeA24NqgDOwaXGtYXHEGwasAA8yeT93d5s87JDZRCGt4QZfMWAE6uyy
         aVoeygH+Oaumg==
Received: by mail-wm1-f70.google.com with SMTP id m127-20020a1ca385000000b0034e992a94a8so1708211wme.5
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 00:23:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bto/xpfUsOVGNmCnHot8/BAzxWmx4lezX3yYM6aPOPk=;
        b=j2RpaJx7qwo7wL8VjVDirBqVCwbo+XeP86GcJUkfpBVFbdCNX7iuuCNvg+WQ1tjKL7
         Xl/3MYQWj12UYIUAe0He+juX2hTJgtnVOA9guXMORXj1rFTUeEWpeo9DOvc8KHLPNY+L
         Bh5SYaYkvm+vLdS0iwmzNk4NKM0Nzz/fkuJDy36KETmg6Ij7inpPt1OHYNSiLGE2SlxZ
         l5eQ5Q2NfzAik/x7Sl1NF2ghpE7Vg/ccYJT+Y7XQ8H6duZcKvfiTGtaGqxvTlSIWcDEU
         tliAhPm3pJj6lTV99jLBFK4xW2g/Zxdmup+NyvuzYNzOaU7iAUFCetHw//gc58C5LIt4
         PeLg==
X-Gm-Message-State: AOAM533cdZZ1wy3wOoX+R5FZh6NfXdf1oB5N0f53wSH10wqUD2KPNuZJ
        VNJcLduZa0Yw7abT9fnuIWRpGcKcp5nlizTmEn6HE/IdmEUxp4W8c7LSFQWnI/bhCWr/k/RRLvS
        n/HMOrQuwZ6eBG4U/dBsXLE2rSxoFAN4NFSgWtt4UFw==
X-Received: by 2002:a5d:64c1:: with SMTP id f1mr13620184wri.214.1643012637896;
        Mon, 24 Jan 2022 00:23:57 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwbDEtlR+A8QosvqD2D6NDMpI/LZF+F4pIQPaln/inShBkt2VmjdWxKP27qiPZUiadTkD+7Dw==
X-Received: by 2002:a5d:64c1:: with SMTP id f1mr13620166wri.214.1643012637710;
        Mon, 24 Jan 2022 00:23:57 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id m64sm7148550wmm.31.2022.01.24.00.23.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jan 2022 00:23:57 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Andi Shyti <andi@etezian.org>, Mark Brown <broonie@kernel.org>,
        Sam Protsenko <semen.protsenko@linaro.org>,
        Pratyush Yadav <p.yadav@ti.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-spi@vger.kernel.org
Cc:     Rob Herring <robh@kernel.org>
Subject: [PATCH v6 4/4] spi: s3c64xx: allow controller-data to be optional
Date:   Mon, 24 Jan 2022 09:23:47 +0100
Message-Id: <20220124082347.32747-5-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220124082347.32747-1-krzysztof.kozlowski@canonical.com>
References: <20220124082347.32747-1-krzysztof.kozlowski@canonical.com>
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

