Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E34BD4F827D
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 17:08:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344463AbiDGPKG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 11:10:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240357AbiDGPKF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 11:10:05 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 524F21F0C9D;
        Thu,  7 Apr 2022 08:08:05 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id o10so5177088ple.7;
        Thu, 07 Apr 2022 08:08:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9wctp4cgAJ87lym2Zv0WCtTlOTlt46quZgOg+vNxZ18=;
        b=PBBIGryJF8tfWy0x1g6mwppJAs1AYIoQvNHFky8NFszEcHHl9itybinRftiUu2QU31
         CKVbJVlw3vLomDBKs0daHpk7W9gmqUSzUxl3mbHTaYo0c6ZL3Vs8F94AwSONpV+vT5ga
         GMZjPeJJmSAnYuMdLR2l0O5c7w97HNIqodjGH21kGTdt5rpWSClC3BZG3qkAuzIVFa2Z
         tHIgWVnsBSlo+FhV6SmzXm2HB6rrnr5Oro3x9oCNRMFLT/XyLleDN2rH4t4Oo2s2fvuH
         8iza5YpWlrFuKIPYDKHvcePmRzSG9FDywtxkXhiIhbliTPmtD9jFutzFGYPcbr4RG9dB
         wSvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9wctp4cgAJ87lym2Zv0WCtTlOTlt46quZgOg+vNxZ18=;
        b=nM1IOtg2KFrIl5RWoOHAYpNFPwRNb10bTpO0pS/xJzBmgudTLZsu4f9unNsrUBzGs1
         3YbkLg48PtpKOTInG4QRyM9CvlJfaGqxpMZwMlBb/zbPC70C3dGfkvxh88N53VjuCpeP
         KFepBPBpgG9bgGNcGcPJHZWxvwiA/M6xn3e7O8/8NSmIb71UIHqDYxyJQ5cenP2DjbHz
         yHs+vL28r9CwzJroFMqnib6oEy+C/WVL0fwV+ZheOm7Bt4QCstTzN9BjhiaxPrd9t1gQ
         70sL7elB4BOUU9kBCgVh0Ib3sGR6Hf/dub+4//tbIjuG6NKFoHcoFnmsQThFZllYG1Bo
         PzBw==
X-Gm-Message-State: AOAM531JoztZT1xm1H/f6cdSPcXQh3/vR+OahZ7/vJ1X/fshz4yVLwRC
        H7KtpFo10fdBBwvaszdkMzMJkyozof8rHSvKw+8=
X-Google-Smtp-Source: ABdhPJyF3QnXvJvnMFeToyMWG3RSHtDgbSTQx3khxh/9V9tdOdT/dnG35UUAYK0Q8sRtHT6q+lxVfw==
X-Received: by 2002:a17:902:c408:b0:156:96d1:1744 with SMTP id k8-20020a170902c40800b0015696d11744mr14482486plk.134.1649344052923;
        Thu, 07 Apr 2022 08:07:32 -0700 (PDT)
Received: from guoguo-omen.lan ([2401:c080:1400:4da2:b701:47d5:9291:4cf9])
        by smtp.gmail.com with ESMTPSA id x2-20020a63aa42000000b0038265eb2495sm19329908pgo.88.2022.04.07.08.07.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Apr 2022 08:07:32 -0700 (PDT)
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
Subject: [PATCH v4 3/5] mtd: nand: mtk-ecc: also parse nand-ecc-engine if available
Date:   Thu,  7 Apr 2022 23:06:50 +0800
Message-Id: <20220407150652.21885-4-gch981213@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220407150652.21885-1-gch981213@gmail.com>
References: <20220407150652.21885-1-gch981213@gmail.com>
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
Change since v3: none
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

