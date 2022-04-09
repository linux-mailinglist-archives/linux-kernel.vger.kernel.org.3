Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B89204FA783
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 14:10:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241750AbiDIMLg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Apr 2022 08:11:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237195AbiDIMLW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Apr 2022 08:11:22 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9FCAA5E84;
        Sat,  9 Apr 2022 05:09:14 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d15so10114188pll.10;
        Sat, 09 Apr 2022 05:09:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hkJi3miPsTxhbqZ6yssVUY4uyoiBTmVSZiVffYb+fyk=;
        b=X/Y4JeQv5Lu/WAGoYG/TNY1pEehMI3BHkuouryi6uXcHsr3OkiiboYCmx+MhQV+P9c
         z5/FBDtxB6uH8apjZchfZVT3NU3hlyAtlmVjYlvC+s7pKORyNo8aHDk6WXDNSe3lrqyr
         7TBjE/ZYsW6jKLXtm/c89O4Zx6xIdRKl2czVJfeTgTMuybZHvckIaWy/RRiF8wtNI5MP
         w4bl/GGEGuawSEauf5mvfgcMbd1Nd1Y1fb15yjAqRvms0lWJIZ4BL+NVcwXYKvbWwRjH
         1b7U5gRK/DVsK14LiaCrYAH25HIXx0Q6uZYn1qjIqjAicquVsvnhbgPEfTj+TGG4SXID
         2mqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hkJi3miPsTxhbqZ6yssVUY4uyoiBTmVSZiVffYb+fyk=;
        b=gjVlZRYYamfWlSmx+C1Y6nsrNgpaIcg3uf+cIFwRIRcFc7ZhTpPWR3h/nXQI9vHCTw
         Xx/AdMKt9/Rv/120Gb6d7u+C1ptIJQWcpDTutmK89cW7IUpB1dxJacdb4WUFbwXj6Aj9
         zNJTthHMthxnfSyDBuJSTTLClSGKW3FsIRhrc6nvRuGE2S/Uxf/kZRnIHWRxl0fBdWYD
         vFEJV5G/btjZV1igT7OAYTZsuqN6Is6XR0kktBftya6RPANGchyke/u228ekBggA3G2m
         qa1IaBvPuEAmM9zoqlwi9IgF2w7XPCvHyeII1+lzPWRoePiFbEawO6BBf8ZTFx0fHMzi
         lN/g==
X-Gm-Message-State: AOAM531HBP9pHcdqAUFhHZ+86jg5D0mVwID7leWmvccAasQfUyLDSU9I
        z1dfzSHY4qagDaHchVVZyu5eSwCi9R/Hoy8XHemFSw==
X-Google-Smtp-Source: ABdhPJzqJTFqdg+TWLe8Q4aimTAQyOj6qcVA4P8+LYsYY9dlncJgnXLe+P13s00FFvDvB/cErX83tw==
X-Received: by 2002:a17:902:ea08:b0:156:a809:ef7c with SMTP id s8-20020a170902ea0800b00156a809ef7cmr24259896plg.4.1649506154338;
        Sat, 09 Apr 2022 05:09:14 -0700 (PDT)
Received: from guoguo-omen.lan ([2401:c080:1400:4da2:b701:47d5:9291:4cf9])
        by smtp.gmail.com with ESMTPSA id a85-20020a621a58000000b0050569a135besm8307357pfa.201.2022.04.09.05.09.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Apr 2022 05:09:14 -0700 (PDT)
From:   Chuanhong Guo <gch981213@gmail.com>
To:     linux-spi@vger.kernel.org
Cc:     Chuanhong Guo <gch981213@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Roger Quadros <rogerq@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Cai Huoqing <cai.huoqing@linux.dev>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Colin Ian King <colin.king@intel.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Pratyush Yadav <p.yadav@ti.com>, Yu Kuai <yukuai3@huawei.com>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS),
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/Mediatek SoC
        support),
        linux-mediatek@lists.infradead.org (moderated list:ARM/Mediatek SoC
        support), linux-kernel@vger.kernel.org (open list),
        linux-mtd@lists.infradead.org (open list:NAND FLASH SUBSYSTEM)
Subject: [PATCH v5 3/5] mtd: nand: mtk-ecc: also parse nand-ecc-engine if available
Date:   Sat,  9 Apr 2022 20:08:17 +0800
Message-Id: <20220409120819.3124209-4-gch981213@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220409120819.3124209-1-gch981213@gmail.com>
References: <20220409120819.3124209-1-gch981213@gmail.com>
MIME-Version: 1.0
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

The recently added ECC engine support introduced a generic property
named nand-ecc-engine for ecc engine phandle. This patch adds support
for this new property.

Signed-off-by: Chuanhong Guo <gch981213@gmail.com>
---
Change since v1:
  new patch
Change in v2-v5: None

 drivers/mtd/nand/ecc-mtk.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/ecc-mtk.c b/drivers/mtd/nand/ecc-mtk.c
index 74ddaa46ba7c..9f9b201fe706 100644
--- a/drivers/mtd/nand/ecc-mtk.c
+++ b/drivers/mtd/nand/ecc-mtk.c
@@ -279,7 +279,10 @@ struct mtk_ecc *of_mtk_ecc_get(struct device_node *of_node)
 	struct mtk_ecc *ecc = NULL;
 	struct device_node *np;
 
-	np = of_parse_phandle(of_node, "ecc-engine", 0);
+	np = of_parse_phandle(of_node, "nand-ecc-engine", 0);
+	/* for backward compatibility */
+	if (!np)
+		np = of_parse_phandle(of_node, "ecc-engine", 0);
 	if (np) {
 		ecc = mtk_ecc_get(np);
 		of_node_put(np);
-- 
2.35.1

