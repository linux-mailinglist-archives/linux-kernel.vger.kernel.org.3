Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37DF5559ED3
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 18:54:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230490AbiFXQwZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 12:52:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230451AbiFXQwV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 12:52:21 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F141560F2D;
        Fri, 24 Jun 2022 09:52:18 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id g26so5881254ejb.5;
        Fri, 24 Jun 2022 09:52:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wbymErIEYkOFeBKk/ebEJiqOJG2qjdsYlqZoWmC7QLE=;
        b=PRRbdWpwESnTfnifMOyCgpGVdaGmvXQWwSZ3f6whE1ZxjZFa+545KZbP2dWC4hkBEt
         s8vL/QSlIJgYyoxdYpenaVdfezjz27HCliox/O8r2THavoUObV+SS2MMsEVNQSbOIp+n
         wCH7a7NFJV2lMsxU+B0haGz6nXtJ8llqqjADcitqejPzY0VyRQQXEgP8v5m/7kwr2Gp1
         C0Ymu6A4GldzaR/0OPpjHzgD72fNiKUTcDZ3MUa20hnakwVjsukV94zH2NHIlNVRi5BQ
         HdKJTKnXWgz7g3LCKr7CKtpz9v/RYj2A5eIXNOLJL35/V4eLwAcxTC5oFnu7ukuIBb70
         uv4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wbymErIEYkOFeBKk/ebEJiqOJG2qjdsYlqZoWmC7QLE=;
        b=Cx1DCrz0F6//D/Kx9y/JxwznEMLWfLezKwM++2Z/ro7Tm6nk6hMjEzCp9mxGxGI6L9
         77f5fV4auA14tVoff3DKf2kbZAEDCO9aq+4u22KwABmfnqwOO7f/L3EDhtfi5pbDrPmV
         bS7QVkA85b/Bdhm0lshqBtTC80dJMsHPEcXCrMxHO912g9jTdwjKJyERp+14J+Os2Ttu
         zEAu9pFbVHOTsYMeW/DwCzZvRfAnEpqcrqKhpgK3KvaX/F66knYb6SVNi9Y9cCZFqeUm
         ijzM50frVMhBM9ej4tRK+32Lpmxgp4DaMI6GpDIT1aIZ5Sf+g9+bUVpB5D1sQvUHOpgL
         qV6Q==
X-Gm-Message-State: AJIora/Tn8lgMu6PvXMSYxvL6pJ/dnKPZu76eSP9Q/1cfG+DyvvtXpcF
        XvuFpWmkfIeVYJVk54JjjQJKgTtqj+c=
X-Google-Smtp-Source: AGRyM1vrLg2W+cGGP3wxtvgoeuzjy++7TyLF+nXPHCinNEq5lfVYYODHu3V1BUQIakLhaOy9dyJ/iw==
X-Received: by 2002:a17:907:7249:b0:711:e939:bbb4 with SMTP id ds9-20020a170907724900b00711e939bbb4mr14351418ejc.480.1656089537406;
        Fri, 24 Jun 2022 09:52:17 -0700 (PDT)
Received: from roman-Latitude-3400.globallogic.com ([195.234.74.2])
        by smtp.gmail.com with ESMTPSA id b20-20020a0564021f1400b0042e15364d14sm2494479edb.8.2022.06.24.09.52.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jun 2022 09:52:16 -0700 (PDT)
From:   Roman Stratiienko <r.stratiienko@gmail.com>
To:     peron.clem@gmail.com
Cc:     mturquette@baylibre.com, sboyd@kernel.org, mripard@kernel.org,
        wens@csie.org, jernej.skrabec@gmail.com, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Roman Stratiienko <r.stratiienko@gmail.com>
Subject: [PATCH] clk: sunxi-ng: sun50i: h6: Modify GPU clock configuration to support DFS
Date:   Fri, 24 Jun 2022 19:52:11 +0300
Message-Id: <20220624165211.4318-1-r.stratiienko@gmail.com>
X-Mailer: git-send-email 2.34.1
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

Using simple bash script it was discovered that not all CCU registers
can be safely used for DFS, e.g.:

    while true
    do
        devmem 0x3001030 4 0xb0003e02
        devmem 0x3001030 4 0xb0001e02
    done

Script above changes the GPU_PLL multiplier register value. While the
script is running, the user should interact with the user interface.

Using this method the following results were obtained:

| Register  | Name           | Bits  | Values | Result |
| --        | --             | --    | --     | --     |
| 0x3001030 | GPU_PLL.MULT   | 15..8 | 20-62  | OK     |
| 0x3001030 | GPU_PLL.INDIV  |     1 | 0-1    | OK     |
| 0x3001030 | GPU_PLL.OUTDIV |     0 | 0-1    | FAIL   |
| 0x3001670 | GPU_CLK.DIV    |  3..0 | ANY    | FAIL   |

Once bits that caused system failure disabled (kept default 0),
it was discovered that GPU_CLK.MUX was used during DFS for some
reason and was causing the failure too.

After disabling GPU_PLL.OUTDIV the system started to fail during
booting for some reason until the maximum frequency of GPU_PLL
clock was limited to 756MHz.

After all the changes made DVFS started to work seamlessly.

Signed-off-by: Roman Stratiienko <r.stratiienko@gmail.com>
---
 drivers/clk/sunxi-ng/ccu-sun50i-h6.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/clk/sunxi-ng/ccu-sun50i-h6.c b/drivers/clk/sunxi-ng/ccu-sun50i-h6.c
index 2ddf0a0da526f..d941238cd178a 100644
--- a/drivers/clk/sunxi-ng/ccu-sun50i-h6.c
+++ b/drivers/clk/sunxi-ng/ccu-sun50i-h6.c
@@ -95,13 +95,14 @@ static struct ccu_nkmp pll_periph1_clk = {
 	},
 };
 
+/* For GPU PLL, using an output divider for DFS causes system to fail */
 #define SUN50I_H6_PLL_GPU_REG		0x030
 static struct ccu_nkmp pll_gpu_clk = {
 	.enable		= BIT(31),
 	.lock		= BIT(28),
 	.n		= _SUNXI_CCU_MULT_MIN(8, 8, 12),
 	.m		= _SUNXI_CCU_DIV(1, 1), /* input divider */
-	.p		= _SUNXI_CCU_DIV(0, 1), /* output divider */
+	.max_rate	= 756000000UL,
 	.common		= {
 		.reg		= 0x030,
 		.hw.init	= CLK_HW_INIT("pll-gpu", "osc24M",
@@ -294,12 +295,9 @@ static SUNXI_CCU_M_WITH_MUX_GATE(deinterlace_clk, "deinterlace",
 static SUNXI_CCU_GATE(bus_deinterlace_clk, "bus-deinterlace", "psi-ahb1-ahb2",
 		      0x62c, BIT(0), 0);
 
-static const char * const gpu_parents[] = { "pll-gpu" };
-static SUNXI_CCU_M_WITH_MUX_GATE(gpu_clk, "gpu", gpu_parents, 0x670,
-				       0, 3,	/* M */
-				       24, 1,	/* mux */
-				       BIT(31),	/* gate */
-				       CLK_SET_RATE_PARENT);
+/* GPU_CLK divider kept disabled to avoid interferences with DFS */
+static SUNXI_CCU_GATE(gpu_clk, "gpu", "pll-gpu", 0x670,
+		      BIT(31), CLK_SET_RATE_PARENT);
 
 static SUNXI_CCU_GATE(bus_gpu_clk, "bus-gpu", "psi-ahb1-ahb2",
 		      0x67c, BIT(0), 0);
-- 
2.34.1

