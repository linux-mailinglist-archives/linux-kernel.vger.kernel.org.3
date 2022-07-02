Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BD42564351
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Jul 2022 01:13:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231782AbiGBXNQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Jul 2022 19:13:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230506AbiGBXMx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jul 2022 19:12:53 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0406DBC3A;
        Sat,  2 Jul 2022 16:12:47 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id e40so7178221eda.2;
        Sat, 02 Jul 2022 16:12:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rMFZHu8PDqwv5GHr5nbOBzzYZPK8b+QduZ22FxBHIqo=;
        b=LmMpJrmNWZeApdyuPOlUWyIq9xXhlUREoibq6Q6UO4K47VwQD2ByfL3DwZaGQ/eLhc
         c9Z46PM3h5NxHMI9zEfHzJnVJ/vacO204dRiwGf+p2amHUA6KBExp/Wcnzu1Jy+CDdQ0
         k4nDLlsNF+zX36ib8uD8VTPTtbQ6afyLNe2KKOj18X8enaCOmeVmW+r7FnACrAqn5/mF
         fgRhbJqjwYiwW8V+JQC1wwL3A8VZ1qIsZKomzgx0c61lkRxPyvB6zFZsQ80b1WOF/In0
         JFMoKYaBxH1tR035v25j5whzFlj78ce0onBkRMDFht5l6aQ9Tqkf6e7XedQDZH63ve+S
         ieew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rMFZHu8PDqwv5GHr5nbOBzzYZPK8b+QduZ22FxBHIqo=;
        b=apsvtp0fc2V5Z0WTA9hk3CXEimP7Et0YiDbvcNCBxIFgEH497nKBqRRE+UV/tEXWdN
         mhNU+Rp+d9jHVEwg3d+xSnzdm2EXPyd3H9ost7uIzcO1FM/vHX1Hmp5OBqQPbxWET5wx
         W7bWIL41b5vwgS2ybQeL4GUB11Ym1zF0RDOFQiKV7sHquYDm7xKPUIjzADC2zY9TZLa3
         Q3Mc/orH5RX3w4vBSqUiPUu5OEfEvda5aHQN8KACfqPJsiD/Ikls/HltPN42pORNwuMB
         hzKpw8AbjRxBWjQJw2USUZyHLb1wYKnqq3NODo5ftw4ieevs7LfaVfnh0ypcTTM7dAQY
         i32w==
X-Gm-Message-State: AJIora+fi2jWCVurdnw0dt5W/NlHL1FCAtnvelvq8oOW4rDIhK+Rph4t
        FqtnbzJpQRDkANbhlSY8FZs=
X-Google-Smtp-Source: AGRyM1sD+hNDqYlRurGJOdDI4Xbt/HFa3sI09ympVXFOMrrvtT1B020+WOXrAo26KkGChwkm/eBf0Q==
X-Received: by 2002:a05:6402:2549:b0:437:788d:b363 with SMTP id l9-20020a056402254900b00437788db363mr27528790edb.406.1656803565559;
        Sat, 02 Jul 2022 16:12:45 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a01-0c23-c4d4-2700-f22f-74ff-fe21-0725.c23.pool.telefonica.de. [2a01:c23:c4d4:2700:f22f:74ff:fe21:725])
        by smtp.googlemail.com with ESMTPSA id uz12-20020a170907118c00b00711aed17047sm12234329ejb.28.2022.07.02.16.12.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Jul 2022 16:12:45 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-mtd@lists.infradead.org, devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, tlanger@maxlinear.com,
        rtanwar@maxlinear.com, miquel.raynal@bootlin.com, richard@nod.at,
        vigneshr@ti.com,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v3 6/8] mtd: rawnand: intel: Remove unused nand_pa member from ebu_nand_cs
Date:   Sun,  3 Jul 2022 01:12:25 +0200
Message-Id: <20220702231227.1579176-7-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.37.0
In-Reply-To: <20220702231227.1579176-1-martin.blumenstingl@googlemail.com>
References: <20220702231227.1579176-1-martin.blumenstingl@googlemail.com>
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

