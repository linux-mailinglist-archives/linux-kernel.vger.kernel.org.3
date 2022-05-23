Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CBD3530BB4
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 11:03:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232376AbiEWI7x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 04:59:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232389AbiEWI7p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 04:59:45 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98C253FDA6
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 01:59:43 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id v10so13099701pgl.11
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 01:59:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=b4toybDv1M53GirTn8tpXa0Kt2GdamhkRh4OIAgDtc4=;
        b=LugNNq9A1jRao45gwpaFfRD7S7nswT5/bN9+qs88iy9ir1JqkfveP2C+MySEfYAzuT
         mKzKAUZYqsijwo9LBHKKSONhsZWlCsheFWJWw8pZj7p1XZ1w/RX5nroUBXBpJdPidTen
         t6o43jxZtOQ2qPp0yLK3E02PfSxGjfxM864AE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=b4toybDv1M53GirTn8tpXa0Kt2GdamhkRh4OIAgDtc4=;
        b=QHDv5QvXLQTUf1as+lv7jIlFE60bbFNGTPYe/RpdUqhgGeDhGN/wqDdzhi7NQdci4S
         mC4KEGQq3oeNDqtTwYcOQxCJfRaX3knMtpdwiAdaQazhBKwNMEht3Vr14XcbXgBp85ZM
         1DvbfqXOjbhUFKotw83Hzx3+0UDFDijvqzE01NCMgO/Dzr+gqaEsPEXF3vt2sL3I8yg1
         q04IoSjOh+wNcP/2XgUnLF4uYieWjO8zOL/GVxDLIFUuPNNLv8knpezV4HEz/vilPMzs
         VNhTvRNdnBalpASAK/ih5DpSP7reLaWHUuXGpF3HWIdpmmCROg+oNapa/6iYDWIZ6mf7
         bzUQ==
X-Gm-Message-State: AOAM533PosNrr/JIBJxVTP6E3VQSWG3KAnBsXakLGFjI2U1AxDSoxs0G
        cFBH/93ELIA4MiWbjU3U/Zy4KA==
X-Google-Smtp-Source: ABdhPJyzzCmYWZva4xngidgLFHgwZkMLeSN/5IngSAyroT2BA0b9QiJFbU1J1oNzacQ2caYizNg6gw==
X-Received: by 2002:a65:6cc3:0:b0:3f6:26e9:5c1 with SMTP id g3-20020a656cc3000000b003f626e905c1mr19125032pgw.28.1653296383341;
        Mon, 23 May 2022 01:59:43 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:1b8:7eae:9793:ff95])
        by smtp.gmail.com with ESMTPSA id e11-20020a170902cf4b00b0015e8d4eb22csm4524719plg.118.2022.05.23.01.59.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 May 2022 01:59:42 -0700 (PDT)
From:   Chen-Yu Tsai <wenst@chromium.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Chen-Yu Tsai <wenst@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        Miles Chen <miles.chen@mediatek.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/4] clk: mediatek: mt8183: mfgcfg: Propagate rate changes to parent
Date:   Mon, 23 May 2022 16:59:21 +0800
Message-Id: <20220523085923.1430470-3-wenst@chromium.org>
X-Mailer: git-send-email 2.36.1.124.g0e6072fb45-goog
In-Reply-To: <20220523085923.1430470-1-wenst@chromium.org>
References: <20220523085923.1430470-1-wenst@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The only clock in the MT8183 MFGCFG block feeds the GPU. Propagate its
rate change requests to its parent, so that DVFS for the GPU can work
properly.

Fixes: acddfc2c261b ("clk: mediatek: Add MT8183 clock support")
Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
 drivers/clk/mediatek/clk-mt8183-mfgcfg.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt8183-mfgcfg.c b/drivers/clk/mediatek/clk-mt8183-mfgcfg.c
index d774edaf760b..230299728859 100644
--- a/drivers/clk/mediatek/clk-mt8183-mfgcfg.c
+++ b/drivers/clk/mediatek/clk-mt8183-mfgcfg.c
@@ -18,9 +18,9 @@ static const struct mtk_gate_regs mfg_cg_regs = {
 	.sta_ofs = 0x0,
 };
 
-#define GATE_MFG(_id, _name, _parent, _shift)			\
-	GATE_MTK(_id, _name, _parent, &mfg_cg_regs, _shift,	\
-		&mtk_clk_gate_ops_setclr)
+#define GATE_MFG(_id, _name, _parent, _shift)				\
+	GATE_MTK_FLAGS(_id, _name, _parent, &mfg_cg_regs, _shift,	\
+		       &mtk_clk_gate_ops_setclr, CLK_SET_RATE_PARENT)
 
 static const struct mtk_gate mfg_clks[] = {
 	GATE_MFG(CLK_MFG_BG3D, "mfg_bg3d", "mfg_sel", 0)
-- 
2.36.1.124.g0e6072fb45-goog

