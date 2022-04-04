Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0387D4F15BA
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 15:19:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351221AbiDDNVB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 09:21:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350689AbiDDNU7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 09:20:59 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD99A3D1F9;
        Mon,  4 Apr 2022 06:19:02 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id n9so3439297plc.4;
        Mon, 04 Apr 2022 06:19:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tr9MXM2WGjlcOGtwp7Avizlxz3VlU8PL1ya73J3s4Ig=;
        b=Xf91QF0idYVwUahX8ttAZz14sSrH+eixEI3rSHYsili6Ih/R7nHWcCRBZxB9N5ECth
         RMptGkG0Ph1znURnR7mrrPpbijT4ZSnkpAz4zN0FEbMh5OBFK26CExBjTnO+tEzmm/1y
         ZzeVY792mP60j7vxBOwsGntJ0SMV649Vb/aobHBVLbQxL5OeDq1v25qlEWmAQkfs09A5
         dKu4orpVuYkFl87bvFkrymuNEOQcsOFItsGjK9AA56iGyDP4f+qJxaDf7qcERdQ5ESsD
         Z1XCF341CYv3nlKNgo0unN0VwdfRVf6D5thUKlWPnj8bQOgXcZjZwzJRRb/FHmXwQJh/
         Av8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tr9MXM2WGjlcOGtwp7Avizlxz3VlU8PL1ya73J3s4Ig=;
        b=31vatTs+2DE5UonsEp3tzuJxmZpY0j/3m5/MXqJTrPBMEFzNoV8srALQ0eJKNuK2wd
         4On1hUCyBZ/BNHvqw0017CAQ5njo5ekguWDiAk5hCmJC+fOVUS6ccwN5jtKe5WUKyG7d
         y9wV2+stvOXtjygV7qoj87wLcBDr9zT4gTq0gKEz+0dKL8vN8ZvJ6zon6GiVnRaJdYTR
         EQs1BykaynDYNsqyVaXfTC63mkkcpCqAhKzaLO2khHj/nSLWzv+mtNc8dfusWEy2EDTM
         d07yylIq9XsecjGjl07YAgex+3o/7OIIwaFrMG9AqDLkeTvOf8vHhWm10+tgJaudYoiN
         +mmg==
X-Gm-Message-State: AOAM53235pMs2qnnPOY9VYC/vrFfQ5BPAmMjBPPUfHmaBQ2HFXBkABKU
        jb+maDvW1JV+KuiAa9e/z5RLJXCsXRYJeUMZqV0=
X-Google-Smtp-Source: ABdhPJxHIowboWR6OquGW3jejuoZgLb6nqgQOKG84z4iHSVnDNhg8f8dxwGH8twCkweJzpJKMPx0CQ==
X-Received: by 2002:a17:902:c643:b0:156:b53e:60e1 with SMTP id s3-20020a170902c64300b00156b53e60e1mr2434713pls.43.1649078341990;
        Mon, 04 Apr 2022 06:19:01 -0700 (PDT)
Received: from guoguo-omen.lan ([2401:c080:1400:4da2:b701:47d5:9291:4cf9])
        by smtp.gmail.com with ESMTPSA id q13-20020a056a00088d00b004e1bea9c582sm12475705pfj.43.2022.04.04.06.18.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Apr 2022 06:19:01 -0700 (PDT)
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
Subject: [PATCH v3 3/5] mtd: nand: mtk-ecc: also parse nand-ecc-engine if available
Date:   Mon,  4 Apr 2022 21:18:16 +0800
Message-Id: <20220404131818.1817794-4-gch981213@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220404131818.1817794-1-gch981213@gmail.com>
References: <20220404131818.1817794-1-gch981213@gmail.com>
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
Change since v2: none
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

