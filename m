Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 431C250CEF1
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Apr 2022 05:27:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238032AbiDXD3p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Apr 2022 23:29:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234668AbiDXD3X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Apr 2022 23:29:23 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C1F3FAD13;
        Sat, 23 Apr 2022 20:26:23 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d15so19597194pll.10;
        Sat, 23 Apr 2022 20:26:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bx17EcXivOefNPVT0GwtSAGebJ/STejXXqwturRr7B8=;
        b=VnD8Me67cwwcUoKVkBFwr8tkQZRjrLohIPKApXMS5qmJsmyo9z8ww2EzrbiPKDMaZr
         3ClNSEpE/w6BkiUPzrTInNz2DZsTGew31xuANhhq1dTdmDx7LfMzRxF2jOe3rZm94gE2
         rPcSAolPOBcwUttbFm7CD0pYCt/EjAJeYLvJloINhrMk1D/m31lP2ybrzD8Us0EbO+3z
         F8o2ppl2ngetgUHRpxfVlBvbFXRlN+LvJK/H18UuyqNhBcr3a36R3dUSJYECgE9bmtls
         Z3yoTiqZF58OHFM7u7PQRH7ZO39FE/lbxjM1OB4YSQ/k1QXTvIUT65iKDx+M/228156L
         15EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bx17EcXivOefNPVT0GwtSAGebJ/STejXXqwturRr7B8=;
        b=68+G2BS+2tBrf1NxE36io60unTzV+BQ0wMyRm+RDxBS2Nbrg2omms9bal0692HFyEN
         8bzFRkw4g8TqfCgh+3UegOb0ZI1/EqFCWuyXn7c0UILpxzn/tglT96WiKkqQ1/E4fyGp
         vEq2EZq4+rIOFxQkbgwwrl+4NSIi+gEX+Ol9R19yRK1HSe7nQlISZM0+v9AH1IjLPGYW
         5XyPZI4ta2BXEWLZpSMMDMbMDIHI0HImo0TTAVpH1IhLWO3PqmLD6Qa8BEBffS3OoDdo
         noqIqwHOwLOKnFxcaHijFzeL5S6n3T/l+4TUAOF5dmgDLwFS7zZZGD9QNNZpzw980Snj
         qPkw==
X-Gm-Message-State: AOAM532WuoGQmLlOfpi4bGx4FwaYOGO4XYJWpSkwPtGRHMXdSpXC+VTH
        gPkA/YoX6kYyIyrwG9g8Drg+r2dlpVWzyddo
X-Google-Smtp-Source: ABdhPJwfQtqF2Kt/eCQMX/DK0J/qN+ecwIyk4oOsUZX9DIKzFbWhe21C3yXTZt0kur6BmqCQPnjRCA==
X-Received: by 2002:a17:90b:388a:b0:1d2:a380:e622 with SMTP id mu10-20020a17090b388a00b001d2a380e622mr13663216pjb.22.1650770783261;
        Sat, 23 Apr 2022 20:26:23 -0700 (PDT)
Received: from guoguo-omen.lan ([222.201.153.219])
        by smtp.gmail.com with ESMTPSA id r76-20020a632b4f000000b003820643e1c2sm5790724pgr.59.2022.04.23.20.26.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Apr 2022 20:26:22 -0700 (PDT)
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
Subject: [PATCH v6 3/5] mtd: nand: mtk-ecc: also parse nand-ecc-engine if available
Date:   Sun, 24 Apr 2022 11:25:25 +0800
Message-Id: <20220424032527.673605-4-gch981213@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220424032527.673605-1-gch981213@gmail.com>
References: <20220424032527.673605-1-gch981213@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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
Change in v2-v6: None

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

