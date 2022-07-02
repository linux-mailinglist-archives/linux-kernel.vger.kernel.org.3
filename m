Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6458E56434F
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Jul 2022 01:13:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231538AbiGBXNI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Jul 2022 19:13:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230517AbiGBXMx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jul 2022 19:12:53 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D30C8BC3D;
        Sat,  2 Jul 2022 16:12:47 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id k20so7112148edj.13;
        Sat, 02 Jul 2022 16:12:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GtoWH3Twv71XknYtu8BYL5GG9PgQIu+29g9mDNFEswk=;
        b=i2P13B5htVIAXOVn3aOtys9xFRhh9MhWIKQhDBsF3OJp5Bk6Tk3p+wEq5Q6XG4d+Q3
         9qOQS/7iMbs9xuGAUzX3Zjx7kCrCo6AP+ujhWDe1vD+uCoKOtHSAz+64zFvWjvDil71i
         WPHod0c0Et7CBl51X44fINlID1VhPU2FC9DyjvYohqc0cZEF9q/DGtnCan4rlvg1r1oN
         uRYzVjqWSWHWQW+8qKpJAbUzwMSVYOIUNiagrijfmqWH2mOU3vKbFIKdxRWYiQFXg5tH
         WLCzXPenfIjxkPuEvrbL2gM8Eg/EoI3WfQJu9RDfA60fIAdhfJ6XCRGoFP5Sq4EN2yQG
         WGFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GtoWH3Twv71XknYtu8BYL5GG9PgQIu+29g9mDNFEswk=;
        b=q7zh9KBq7jPJCX866IFfczLldDzAr6c0HnzLdiKRYzRVWFE/hNDgRPjvT2j4PkF39y
         U4+psbabeQp6O8DTFo1bpa/ZN4guScR83skittwHZwIZsRzrGeHL2F1OqUeDnUlCrl/h
         R5vR/es8mPxaS32Kg/32r6tisaDPCUrhY4XXmlFgueFV1+NSEUEEiXoXiTowwobNmgma
         1pRR3QmjAW1F4F0GAoLQxqRM25SjqiZQIdhbF3PddUZYgtUhB4A3dkNTICaHI5nEAO+c
         M2tYm90QY+ODIbSkV/fItkxWdWa1aL1D2H5fktcvKPBLpOIovVR+Srgt2mkuebNiLDAs
         Ngpg==
X-Gm-Message-State: AJIora+FIfnqmffkRmhFg54g/SbVS5mGAheaE7zNMufgQh8GXE3DsG9D
        Py9OiJKmWL/BAfVo+x53OUc=
X-Google-Smtp-Source: AGRyM1u5k9aKO+kjClRFeCmf055a08Jc0GwYvjMkLIuQgHTnWlnBVgpFInI7O5yAAkYBIZg06v854Q==
X-Received: by 2002:a05:6402:26d6:b0:435:ba41:dbb0 with SMTP id x22-20020a05640226d600b00435ba41dbb0mr28127029edd.242.1656803566388;
        Sat, 02 Jul 2022 16:12:46 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a01-0c23-c4d4-2700-f22f-74ff-fe21-0725.c23.pool.telefonica.de. [2a01:c23:c4d4:2700:f22f:74ff:fe21:725])
        by smtp.googlemail.com with ESMTPSA id uz12-20020a170907118c00b00711aed17047sm12234329ejb.28.2022.07.02.16.12.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Jul 2022 16:12:46 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-mtd@lists.infradead.org, devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, tlanger@maxlinear.com,
        rtanwar@maxlinear.com, miquel.raynal@bootlin.com, richard@nod.at,
        vigneshr@ti.com,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v3 7/8] mtd: rawnand: intel: Remove unused clk_rate member from struct ebu_nand
Date:   Sun,  3 Jul 2022 01:12:26 +0200
Message-Id: <20220702231227.1579176-8-martin.blumenstingl@googlemail.com>
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

The clk_rate member from struct ebu_nand is only written but never read.
Remove this unused and unneeded member.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 drivers/mtd/nand/raw/intel-nand-controller.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/mtd/nand/raw/intel-nand-controller.c b/drivers/mtd/nand/raw/intel-nand-controller.c
index de4f85368988..e486db11ecc3 100644
--- a/drivers/mtd/nand/raw/intel-nand-controller.c
+++ b/drivers/mtd/nand/raw/intel-nand-controller.c
@@ -118,7 +118,6 @@ struct ebu_nand_controller {
 	struct dma_chan *dma_tx;
 	struct dma_chan *dma_rx;
 	struct completion dma_access_complete;
-	unsigned long clk_rate;
 	struct clk *clk;
 	u32 nd_para0;
 	u8 cs_num;
@@ -636,7 +635,6 @@ static int ebu_nand_probe(struct platform_device *pdev)
 		dev_err(dev, "failed to enable clock: %d\n", ret);
 		return ret;
 	}
-	ebu_host->clk_rate = clk_get_rate(ebu_host->clk);
 
 	ebu_host->dma_tx = dma_request_chan(dev, "tx");
 	if (IS_ERR(ebu_host->dma_tx)) {
-- 
2.37.0

