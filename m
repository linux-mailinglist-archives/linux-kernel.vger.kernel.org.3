Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 954D9560BCA
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 23:36:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231143AbiF2Vfn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 17:35:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230332AbiF2Vfd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 17:35:33 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 497993150E;
        Wed, 29 Jun 2022 14:35:26 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id g26so35146960ejb.5;
        Wed, 29 Jun 2022 14:35:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rMFZHu8PDqwv5GHr5nbOBzzYZPK8b+QduZ22FxBHIqo=;
        b=lOWY4O5UFWVGn6+N4v6WE2yC5CcWG2UujeYLFJKPc3rATK1ToRZVdUXp12kVVZp4EA
         Q+qGDGfTnSzuYY0Vu/oLWDnDmPWbBBEbFufxl9epGWkyo7xb6ueK7dGBtRcTKW8rOq/C
         FMCb6+4GqngC04vN/Ia73bXpg69r9xcNc/Lkigv1lTQinUZruFE2D2SsvV9BcAnC8Y1y
         qZ435hJAWDCnXcbFhghghDois8azi8OBWhdJSbgiQzfVhDTEk61h2K6ez1hBJkEheyDV
         tIkCwmHMa6TFn66lBm6dk3ZA0AgrPeEsy19uyKWYghj/NitvFUKbtgIAXbL9xAbXeJyT
         wsVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rMFZHu8PDqwv5GHr5nbOBzzYZPK8b+QduZ22FxBHIqo=;
        b=j0zbMkv7+zLqWiAD1Oa+jkpFVUqdmdEKyykpj9zEB7PxtgPlIL+2FBEaQn0wAgiDG1
         6/KS2rGJrBAcuWIVWyNIKqDtAGuSRVhAs3OXSwO54bU+PU5hpb2Y80tAjCzej5e0718a
         U38NCGzAWmsXMu70/DMDMSAQtAd0GMxpNiAdAs0NjlTGHddouhftwHxdeNPuoCx7VieZ
         Stba/HG1Lw5htH/5qeA8tOeDVS395X4tlDmjiFnZ0haC8612lqQe5/yDYwGE5M1AFunH
         PSYyhOYXPzqCipe6sNIwuD4Q2RiXj9l04k7tFICYvRcW5zPloyd8gehv3V2waGse1QHZ
         3cAA==
X-Gm-Message-State: AJIora81T+Irng9gof7riB5MrhwAalKoupUZHETbngbvV2xci0CAOuAM
        jgE1T7nScghsRp/nXDgoDW0vTuy0bDE=
X-Google-Smtp-Source: AGRyM1ugiuUJV+n2N0SIKZt3j4lTugdBedDqh7stRxX5FTrcmuxq7W2s4KsQay9Vr5flI875x+F8xg==
X-Received: by 2002:a17:907:7f8c:b0:726:2c53:2f82 with SMTP id qk12-20020a1709077f8c00b007262c532f82mr5380349ejc.140.1656538524808;
        Wed, 29 Jun 2022 14:35:24 -0700 (PDT)
Received: from localhost.localdomain (dynamic-077-007-003-132.77.7.pool.telefonica.de. [77.7.3.132])
        by smtp.googlemail.com with ESMTPSA id s7-20020a1709066c8700b0070c4abe4706sm8237889ejr.158.2022.06.29.14.35.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jun 2022 14:35:24 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-mtd@lists.infradead.org, devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, tlanger@maxlinear.com,
        rtanwar@maxlinear.com, miquel.raynal@bootlin.com, richard@nod.at,
        vigneshr@ti.com,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v2 6/8] mtd: rawnand: intel: Remove unused nand_pa member from ebu_nand_cs
Date:   Wed, 29 Jun 2022 23:35:06 +0200
Message-Id: <20220629213508.1989600-7-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.37.0
In-Reply-To: <20220629213508.1989600-1-martin.blumenstingl@googlemail.com>
References: <20220629213508.1989600-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The nand_pa member from struct ebu_nand_cs is only written but never
read. Remove this unused and unneeded member.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 drivers/mtd/nand/raw/intel-nand-controller.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/mtd/nand/raw/intel-nand-controller.c b/drivers/mtd/nand/raw/intel-nand-controller.c
index 3df16d5ecae8..de4f85368988 100644
--- a/drivers/mtd/nand/raw/intel-nand-controller.c
+++ b/drivers/mtd/nand/raw/intel-nand-controller.c
@@ -106,7 +106,6 @@
 
 struct ebu_nand_cs {
 	void __iomem *chipaddr;
-	dma_addr_t nand_pa;
 	u32 addr_sel;
 };
 
@@ -626,7 +625,6 @@ static int ebu_nand_probe(struct platform_device *pdev)
 	ebu_host->cs[cs].chipaddr = devm_ioremap_resource(dev, res);
 	if (IS_ERR(ebu_host->cs[cs].chipaddr))
 		return PTR_ERR(ebu_host->cs[cs].chipaddr);
-	ebu_host->cs[cs].nand_pa = res->start;
 
 	ebu_host->clk = devm_clk_get(dev, NULL);
 	if (IS_ERR(ebu_host->clk))
-- 
2.37.0

