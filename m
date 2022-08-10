Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F2A258F427
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 00:07:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233431AbiHJWHb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 18:07:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233214AbiHJWHP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 18:07:15 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [176.9.125.105])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B217792DA
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 15:07:14 -0700 (PDT)
Received: from mwalle01.kontron.local. (unknown [213.135.10.150])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 4D80722253;
        Thu, 11 Aug 2022 00:07:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1660169230;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=41mI0uugblWMUTssmahtd2l/fAYAHT04UlAk02aSkT8=;
        b=vYjfLZ8+Cr3jl63gwAXfHrTKRcp4pPUkS0dW33d3fW7wkLV8Jr+dwHVhc02l5esXB0nb3Z
        4LULct3uLgYVeqy6cXM+2NX9RXYJgXAJtA6/gOJN7nOb1zxp8Xot2RtPcWQ1JqE2UwDcOx
        DwQ/XOBVjO8Q4APucjgm09g2+QDaLWA=
From:   Michael Walle <michael@walle.cc>
To:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Pratyush Yadav <pratyush@kernel.org>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        Michael Walle <michael@walle.cc>,
        Jae Hyun Yoo <quic_jaehyoo@quicinc.com>
Subject: [PATCH v2 5/7] mtd: spi-nor: fix select_uniform_erase to skip 0 erase size
Date:   Thu, 11 Aug 2022 00:06:52 +0200
Message-Id: <20220810220654.1297699-6-michael@walle.cc>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220810220654.1297699-1-michael@walle.cc>
References: <20220810220654.1297699-1-michael@walle.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4bait will set the erase size to 0 if there is no corresponding
opcode for the 4byte erase. Fix spi_nor_select_uniform_erase to skip
the 0 erase size to avoid mtd device registration failure cases.

Reported-by: Jae Hyun Yoo <quic_jaehyoo@quicinc.com>
Signed-off-by: Michael Walle <michael@walle.cc>
---
 drivers/mtd/spi-nor/core.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
index f1d01c7dacce..42f9bb63919c 100644
--- a/drivers/mtd/spi-nor/core.c
+++ b/drivers/mtd/spi-nor/core.c
@@ -2118,6 +2118,10 @@ spi_nor_select_uniform_erase(struct spi_nor_erase_map *map,
 
 		tested_erase = &map->erase_type[i];
 
+		/* Skip masked erase types. */
+		if (!tested_erase->size)
+			continue;
+
 		/*
 		 * If the current erase size is the one, stop here:
 		 * we have found the right uniform Sector Erase command.
-- 
2.30.2

