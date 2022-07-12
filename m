Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8009857211B
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 18:38:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232686AbiGLQil (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 12:38:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbiGLQie (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 12:38:34 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B65AE1032
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 09:38:32 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id h14-20020a1ccc0e000000b0039eff745c53so5146351wmb.5
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 09:38:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BXuXiklFcl+vK0kmoMLD007iJW5hMW9mAc7xKGHZhfc=;
        b=Vro/dFbucTFTfY+imZQ1WkqMIYTcCBhqfgdDiw/JxxWQ4P0kgHI1akI7oBBajJOTcy
         fbxA1sjcXfsXZLM99JJDrF61XuA+Yt9jfRPrRvI3zXRuuGT7veCBHYlrtDqUdAQ+D5c1
         cMitPM2+JPJEXy7DL12czQV+/2Sn+56Qdjx8V6cX8gMRHKptYtO03R1BLJtLKAddLq+L
         WV3lRDp5jE6pKPVhtV8QTqOEKc52tvlJWaM3udCW28xwQLzT7c42ozqDXTuGjKOWOBVa
         ho9d/HjLRIza73WOIfqiULK1bQG7PxQh9nnVHAkg4U2TDMLuy79CM6fiq8BlTjB2WWyg
         Wr0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BXuXiklFcl+vK0kmoMLD007iJW5hMW9mAc7xKGHZhfc=;
        b=HfuU9SPwQpR0HAkJAc6aaGLodvirmXRVdZFjUGbuWVJsJ/fotp75uUzeThv1zMcOa4
         33XPXCmXA5C++TrakgZFCy8DpT7NBtsod3opPXecrg/fHWoRHUbjX7H+U0VMyHbTmpDF
         v1WYMFDSbHQYuvXe5WGD/JLUnCZeI/layOP1h2Bx1sv4CDdG42nH/GM6N3mOb942/J4E
         CoTGzR1Bcyr02Ds5+2A9XpyhzCOmyCLu+hpk8xOQu4mxNl2Nb9DqFrfZqonOduBn8dXU
         YpiBD5qEXNPY34SwU6ym8x1CnmvX7JF2MCPf+8lSh0VuToFWyfABvzo6RuLWg+ntZZOb
         aKwA==
X-Gm-Message-State: AJIora+GoEOUYd6DQlJuH0dGu+5l00wFTeQK/sGwD7X2d9Yfr8WAuMji
        c802FH7Y9OUFxnZ71PRLdmj6HQ==
X-Google-Smtp-Source: AGRyM1tb4EZs5ZikIvKJ/L8Kuec2ek3EENJV7eDH3jpkwW7n1kyTihutuzdDuVWp/U0dOXQ1AV41Lw==
X-Received: by 2002:a05:600c:354e:b0:3a1:9ddf:468d with SMTP id i14-20020a05600c354e00b003a19ddf468dmr4841011wmq.145.1657643911325;
        Tue, 12 Jul 2022 09:38:31 -0700 (PDT)
Received: from localhost.localdomain (host-78-150-47-22.as13285.net. [78.150.47.22])
        by smtp.gmail.com with ESMTPSA id s14-20020a5d424e000000b0021d4d6355efsm8623751wrr.109.2022.07.12.09.38.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jul 2022 09:38:30 -0700 (PDT)
From:   Sudip Mukherjee <sudip.mukherjee@sifive.com>
To:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Michael Walle <michael@walle.cc>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     greentime.hu@sifive.com, jude.onyenegecha@sifive.com,
        william.salmon@sifive.com, adnan.chowdhury@sifive.com,
        ben.dooks@sifive.com, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Sudip Mukherjee <sudip.mukherjee@sifive.com>
Subject: [PATCH 1/3] mtd: spi-nor: extend no_sfdp_flags to use u16
Date:   Tue, 12 Jul 2022 17:38:21 +0100
Message-Id: <20220712163823.428126-2-sudip.mukherjee@sifive.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220712163823.428126-1-sudip.mukherjee@sifive.com>
References: <20220712163823.428126-1-sudip.mukherjee@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently no_sfdp_flags is u8 and all the bits have been used. Extend
it to use u16 so that we can add more support.

Signed-off-by: Sudip Mukherjee <sudip.mukherjee@sifive.com>
---
 drivers/mtd/spi-nor/core.c | 2 +-
 drivers/mtd/spi-nor/core.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
index ce5d69317d46c..e5f7691c5bd40 100644
--- a/drivers/mtd/spi-nor/core.c
+++ b/drivers/mtd/spi-nor/core.c
@@ -2335,7 +2335,7 @@ static void spi_nor_no_sfdp_init_params(struct spi_nor *nor)
 {
 	struct spi_nor_flash_parameter *params = nor->params;
 	struct spi_nor_erase_map *map = &params->erase_map;
-	const u8 no_sfdp_flags = nor->info->no_sfdp_flags;
+	const u16 no_sfdp_flags = nor->info->no_sfdp_flags;
 	u8 i, erase_mask;
 
 	if (no_sfdp_flags & SPI_NOR_DUAL_READ) {
diff --git a/drivers/mtd/spi-nor/core.h b/drivers/mtd/spi-nor/core.h
index 61886868cd022..58fbedc94080f 100644
--- a/drivers/mtd/spi-nor/core.h
+++ b/drivers/mtd/spi-nor/core.h
@@ -501,7 +501,7 @@ struct flash_info {
 #define NO_CHIP_ERASE			BIT(7)
 #define SPI_NOR_NO_FR			BIT(8)
 
-	u8 no_sfdp_flags;
+	u16 no_sfdp_flags;
 #define SPI_NOR_SKIP_SFDP		BIT(0)
 #define SECT_4K				BIT(1)
 #define SPI_NOR_DUAL_READ		BIT(3)
-- 
2.30.2

