Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF1EE4C65BF
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 10:34:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234348AbiB1Jev (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 04:34:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231855AbiB1Jes (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 04:34:48 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 823233ED2F;
        Mon, 28 Feb 2022 01:34:08 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id i11so20297749lfu.3;
        Mon, 28 Feb 2022 01:34:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vNW8B911OQBRBUW/DpOFF8iaYDouAHt80BzfGLFj4rk=;
        b=ifm8un2LzrGCL6C6xB27XvYINTfvoIQNf9qJWpyHsuwa0w8B+Oe0N2oxflFKS+yTG0
         qafUp62HAXtgkMulaEsdBqcm38zCscXbiyu+B1+/4X2mbGTa60UVQ2RvmhAluJnsIwUh
         lngnfNQwh9FEBuFNVXGaVkhxGwFm7cvntg9sDJYSoZp+ng77lN8P2UClkD914TtRfBXk
         2af65uJ3BiAUOwqsepNJvrS3jjLOho3BJ+uLn0b13DPFN21EmHweT4CxSlUQ8Ms18FwS
         xxEXk9I7xZjzd81uWcXDG452YQk0ouE5L4F8TgYtW7Z6a2AIEweNNmpPPnh8aiaXdDKr
         reKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vNW8B911OQBRBUW/DpOFF8iaYDouAHt80BzfGLFj4rk=;
        b=mF82QVoM4+lzZzCtAArY7poRdJXbdAqxpCbzSaZ8MRe0Fo9IN1/aI14La09IJ60bXN
         /SgiS7MMLIheUYiQ0a72FnA6M5Kw7br6jhDFACcwJnEblEuHnzgQ+IeR7YT9bNBV8pxq
         2IjJ3bJAMvO4zb7SgZjW4m8kRkH6pG09dB1OxeGy4vwKPGQOiI0rD62Y1hdTTAKB2dFN
         bZq7qjGYlJsnXbxRm/WsA/LeyqUD/7PpiGH1Y/t5QmeaG3eYHdJs3MyJI1Q3FyKKGrXR
         DorJB+htG8vv2L33sFNPHrkKVF3v2ztOO4d7rWWf5RZl3VsjMv2s+zsN4wihYU6Xq6/5
         BTxw==
X-Gm-Message-State: AOAM533SwMCasJpjm9IYNkZZdH5+VwPJFhH1t3DqTqXDlZxRI0R2BM/q
        mtBId4EUdsY8eiNUSCgMzC0=
X-Google-Smtp-Source: ABdhPJwq15AXczlwtQ3CyPeeEL2d3+ucD7NWWmlTWuUOcnhvnGMcdNyfI2le/5F18R1XrR8MDBKqxQ==
X-Received: by 2002:a05:6512:783:b0:443:ae8d:6eda with SMTP id x3-20020a056512078300b00443ae8d6edamr12574542lfr.153.1646040846889;
        Mon, 28 Feb 2022 01:34:06 -0800 (PST)
Received: from localhost.lan (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by smtp.gmail.com with ESMTPSA id k7-20020a0565123d8700b00443cec880e5sm876184lfv.4.2022.02.28.01.34.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Feb 2022 01:34:06 -0800 (PST)
From:   =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        bcm-kernel-feedback-list@broadcom.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>
Subject: [PATCH 2/2] nvmem: brcm_nvram: find Device Tree nodes for NVMEM cells
Date:   Mon, 28 Feb 2022 10:33:51 +0100
Message-Id: <20220228093351.28162-2-zajec5@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220228093351.28162-1-zajec5@gmail.com>
References: <20220228093351.28162-1-zajec5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafał Miłecki <rafal@milecki.pl>

DT binding for Broadcom's NVRAM supports specifying NVMEM cells as NVMEM
device (provider) subnodes. Look for such subnodes when collecing NVMEM
cells. This allows NVMEM consumers to use NVRAM variables.

Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
---
 drivers/nvmem/brcm_nvram.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/nvmem/brcm_nvram.c b/drivers/nvmem/brcm_nvram.c
index 439f00b9eef6..450b927691c3 100644
--- a/drivers/nvmem/brcm_nvram.c
+++ b/drivers/nvmem/brcm_nvram.c
@@ -8,6 +8,7 @@
 #include <linux/module.h>
 #include <linux/nvmem-consumer.h>
 #include <linux/nvmem-provider.h>
+#include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
 
@@ -72,6 +73,7 @@ static int brcm_nvram_add_cells(struct brcm_nvram *priv, uint8_t *data,
 			return -ENOMEM;
 		priv->cells[idx].offset = value - (char *)data;
 		priv->cells[idx].bytes = strlen(value);
+		priv->cells[idx].np = of_get_child_by_name(dev->of_node, priv->cells[idx].name);
 	}
 
 	return 0;
-- 
2.34.1

