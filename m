Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F389658CD82
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 20:16:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244237AbiHHSQY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 14:16:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244211AbiHHSQG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 14:16:06 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A8B7B7D1
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 11:16:03 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id s11-20020a1cf20b000000b003a52a0945e8so3046126wmc.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Aug 2022 11:16:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=JCpSNlLLZPCNByyaJJ8bDLMhynHswvT5YpgsApwtx0s=;
        b=dUZFFCl7554xqPEFkFQak0oDLlu70nAxMQbPsM3ONpiKqMar3VY0LRMzOQ7Lgnx1Vl
         W6s2/UpX8NUyQORwW0CCw1GKhOafkSZI4RmUKXz2Yy8rtWyDXXl3WwhlsK45YD3ZWyrS
         GZMEH0YhDVz1XhH9goQsbBcD3Bk2wCupIIR0syHmxl8HjrLV6Z6j9DLBheHvtxHjrSVz
         3fj11dOh/TymGTMOWy45DWx0iJmUdkEpIysPy34vBU3YWYDNBYZFJk+CEcrDNNOE4Eol
         hBv1lyhKI710RKjCD4vQQuH63hKSURmMh+u+s7w0T9dzTP0T1JF4RUOQnIEqPYppCgRw
         3Fww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=JCpSNlLLZPCNByyaJJ8bDLMhynHswvT5YpgsApwtx0s=;
        b=HnRcDVI68QhDJ39aO5amnAH1l3xVFiwJnVnBkkDW5w5FCVf1gYnPx3PIaH5wqkNkk7
         obQDZm0ePiSsnfzHTvY2vvZBzeGFTwZkb4LlrVx7TjJpFn/e9qQ5Yoeuoi+k+fmGZvlq
         Z6k+4B5mTpZU/MPW53h1nlQaFTcYNIIKDoqcl90Zw07H5+71QLpRjsTsdHgMERKJ9ro5
         2p0omv/xe7nVGzs/LtcvTS+5d8f73ZMePqDyq2p/DjiisFP/huWX9aXQwVe0E28W3egu
         ZSSHQ0Uy2w2G3igPMC/br+pQQ1MNuBxN4XjMuNZrFHMDnXDWCSQ4fF8TlVdCSCWjXgFH
         xKPA==
X-Gm-Message-State: ACgBeo3tdbLU3mEn6UVqfZ8l3QfQRMIxFiN1/VwmV1+LZUr3vqbvORNq
        E9SdDSkoWN1VifiKzfYGpYV7ww==
X-Google-Smtp-Source: AA6agR6CfvYjOPTWPPgSiBJmd0D8NCfnfjuIUif6YDmpzrgFWiCw3iy4Hgj3B94jq8imLnNCZs8aIw==
X-Received: by 2002:a05:600c:3586:b0:3a3:2c03:1088 with SMTP id p6-20020a05600c358600b003a32c031088mr13960192wmq.64.1659982562834;
        Mon, 08 Aug 2022 11:16:02 -0700 (PDT)
Received: from localhost ([31.134.121.151])
        by smtp.gmail.com with ESMTPSA id p22-20020a05600c359600b003a31ca9dfb6sm21166283wmq.32.2022.08.08.11.16.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Aug 2022 11:16:02 -0700 (PDT)
From:   Sam Protsenko <semen.protsenko@linaro.org>
To:     Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>
Cc:     Tomasz Figa <tomasz.figa@gmail.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/7] clk: samsung: exynos850: Style fixes
Date:   Mon,  8 Aug 2022 21:16:01 +0300
Message-Id: <20220808181601.10543-1-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.30.2
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

Fix some typos in comments and do small coding style improvements.

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
 drivers/clk/samsung/clk-exynos850.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/samsung/clk-exynos850.c b/drivers/clk/samsung/clk-exynos850.c
index cd9725f1dbf7..ef32546d3090 100644
--- a/drivers/clk/samsung/clk-exynos850.c
+++ b/drivers/clk/samsung/clk-exynos850.c
@@ -173,7 +173,6 @@ PNAME(mout_peri_uart_p)		= { "oscclk", "dout_shared0_div4",
 				    "dout_shared1_div4", "oscclk" };
 PNAME(mout_peri_ip_p)		= { "oscclk", "dout_shared0_div4",
 				    "dout_shared1_div4", "oscclk" };
-
 /* List of parent clocks for Muxes in CMU_TOP: for CMU_DPU */
 PNAME(mout_dpu_p)		= { "dout_shared0_div3", "dout_shared1_div3",
 				    "dout_shared0_div4", "dout_shared1_div4" };
@@ -599,7 +598,7 @@ static const unsigned long hsi_clk_regs[] __initconst = {
 	CLK_CON_GAT_GOUT_HSI_USB20DRD_TOP_BUS_CLK_EARLY,
 };
 
-/* List of parent clocks for Muxes in CMU_PERI */
+/* List of parent clocks for Muxes in CMU_HSI */
 PNAME(mout_hsi_bus_user_p)	= { "oscclk", "dout_hsi_bus" };
 PNAME(mout_hsi_mmc_card_user_p)	= { "oscclk", "dout_hsi_mmc_card" };
 PNAME(mout_hsi_usb20drd_user_p)	= { "oscclk", "dout_hsi_usb20drd" };
@@ -963,7 +962,7 @@ static const unsigned long dpu_clk_regs[] __initconst = {
 	CLK_CON_GAT_GOUT_DPU_SYSREG_PCLK,
 };
 
-/* List of parent clocks for Muxes in CMU_CORE */
+/* List of parent clocks for Muxes in CMU_DPU */
 PNAME(mout_dpu_user_p)		= { "oscclk", "dout_dpu" };
 
 static const struct samsung_mux_clock dpu_mux_clks[] __initconst = {
-- 
2.30.2

