Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8842555CCED
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:02:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345552AbiF1L2l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 07:28:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345459AbiF1L2S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 07:28:18 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8FC7B863;
        Tue, 28 Jun 2022 04:28:17 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id u12so25057171eja.8;
        Tue, 28 Jun 2022 04:28:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8kX3dUaWuulkCwAMYcRWq/5OXE7N5XumBNg6KTJej40=;
        b=XsIH+2HQO1P1rHXYTPerAkTGiIM2ijXN6e2a8nA1YzRXVJbepZFT2gr/QLqLOsdi+U
         R6G1p3JiVf6mXXRNy2NwloPk+XpjErzFnhr9+k90lHUa87Hw8EtMPJv2yTM0jvL5jxIy
         cg3XL87XUQuJOf2cG+9nqf5K1DHKQ+mKiVBvUSyODcI2i/WNvHG5edVqsGJ1J348XXk8
         J97p/fwJN94dnl6V9doQJxzxuZbfvkOO23QWSPDehyMLfsm/H33kznaTuk0VMa0a47k1
         4sGwUw1gascOFrbo6akRUDX+vbAX3Kwt74m+SlY72fmFvNUUh5mTVdylQ8v35dmhAqxx
         kUeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8kX3dUaWuulkCwAMYcRWq/5OXE7N5XumBNg6KTJej40=;
        b=kWCY0F0Ujbf/uOlPvLp5WSk+h6hs7gbEttnuRdF8zqD6CV6s8FBtVx7bDhGj5Rv9/T
         eBLc/Jd7MY00SL33az7h9osn3R93VPb6XhwrgV18ZTR+kQNqSjTi2SKq0ai2plcNA/rj
         AY2hiyQfDted9HvDfPW/8xDiQk+6gsDZuHJKmc4Kcenwj64WjGY69fv/B9J3rfFzXva0
         BH3Hlt4TqW2252p2u5I/jttaK6X+u1+vfX2DNIrVwh2mp3KZacGj3SUi8taqwonbGDFT
         VjVBe+OLHFUcg/k1lI0qTJvaRcmvRW2rQ3I/vg5CO86B0F5E1L8+zyktJHqxt/GDrRRY
         LqXQ==
X-Gm-Message-State: AJIora+eyUUANRUqzM/9qjuG7jNSy8SLo5vdXGVx6NA/x6G0onWf2fYT
        qivp/yE+sh5ZhAYv8jmxW74=
X-Google-Smtp-Source: AGRyM1skiyvCQpAlrk4WuoP4RqWyZwZfLZtvvrUmns96lKuveEOF6JxVfQfbbceXtsM4XMNcuXhTAg==
X-Received: by 2002:a17:906:7315:b0:711:db45:af4c with SMTP id di21-20020a170906731500b00711db45af4cmr16554359ejc.412.1656415696584;
        Tue, 28 Jun 2022 04:28:16 -0700 (PDT)
Received: from localhost.localdomain (dynamic-095-114-061-215.95.114.pool.telefonica.de. [95.114.61.215])
        by smtp.googlemail.com with ESMTPSA id h6-20020aa7cdc6000000b00435720b7a1csm9456318edw.20.2022.06.28.04.28.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jun 2022 04:28:16 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-mtd@lists.infradead.org, devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, tlanger@maxlinear.com,
        rtanwar@maxlinear.com, miquel.raynal@bootlin.com, richard@nod.at,
        vigneshr@ti.com,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH RFC v1 6/8] mtd: rawnand: intel: Remove unused nand_pa member from ebu_nand_cs
Date:   Tue, 28 Jun 2022 13:27:29 +0200
Message-Id: <20220628112731.2041976-7-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220628112731.2041976-1-martin.blumenstingl@googlemail.com>
References: <20220628112731.2041976-1-martin.blumenstingl@googlemail.com>
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
2.36.1

