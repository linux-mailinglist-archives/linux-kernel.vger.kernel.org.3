Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B41552E938
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 11:44:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347904AbiETJoH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 05:44:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346078AbiETJn7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 05:43:59 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC8B5149AAF
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 02:43:58 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id q18so6919406pln.12
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 02:43:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=b4toybDv1M53GirTn8tpXa0Kt2GdamhkRh4OIAgDtc4=;
        b=WWvNjRlc9R3ylkT71F/0tYY4edxwlaAQp+Dvd7vVK/bnjQvRih4OUAVVzo1biCrAmn
         YkhIzbWoHtuygjdR112SzgAHPZOxtb/tDDeieVB2abJW58imdO1Eo9vL3NtIFG2nqgbw
         b1p6Sn1k7r4GowNho+ENI+EsKo91JVoN3LK/E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=b4toybDv1M53GirTn8tpXa0Kt2GdamhkRh4OIAgDtc4=;
        b=q/L4jCHh2VwnS9bREzR/qE9nft9ahnA+we/tRKaFw3ZnCQUPYIhnZdgp5dYPq+FSMC
         qyHWky/qkdweZL5tPZ5Tuj0FSCqrGRjUpOtDUWrYgOBViEcHA+vyaAri0TMkJpPLmlEN
         GL1nr6B/DlBbGGKbT5TB42QigYoyoA0iOTwY1/ro1BfC0ZRGjbpL92aUZzIJHBC0BdDL
         olUYxserS/9cmhcleCoFoZ2gjMPFBxNNcXcYtwBUfUShXZOFNhq3sBbdwbxnMCevdYU8
         lhPcvGcbA9EVQcG0q4XrqYC5RdJSEZwiq8XNIyo+YO5yAkz5AHBPBqA8TBHrk119KpsV
         spRg==
X-Gm-Message-State: AOAM530eFQy2T9NxBppWan0cR5rzrTjnxQfZchjhOqFzLV5616yvzl6H
        oK5w/5pVTingaUMdkZpYUxzApg==
X-Google-Smtp-Source: ABdhPJwnbKiL/9EFkMezmfR/RGWpPtvvom3H3Yyp6HcfhsLZSqErmLrIH1CjIf5RMqWmmYanZhLuQA==
X-Received: by 2002:a17:903:22c7:b0:161:cf2e:2ce2 with SMTP id y7-20020a17090322c700b00161cf2e2ce2mr8793814plg.59.1653039838197;
        Fri, 20 May 2022 02:43:58 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:ec49:9912:894:222d])
        by smtp.gmail.com with ESMTPSA id 23-20020aa79217000000b0050dc76281bfsm1290597pfo.153.2022.05.20.02.43.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 May 2022 02:43:57 -0700 (PDT)
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
Subject: [PATCH 2/4] clk: mediatek: mt8183: mfgcfg: Propagate rate changes to parent
Date:   Fri, 20 May 2022 17:43:21 +0800
Message-Id: <20220520094323.754971-3-wenst@chromium.org>
X-Mailer: git-send-email 2.36.1.124.g0e6072fb45-goog
In-Reply-To: <20220520094323.754971-1-wenst@chromium.org>
References: <20220520094323.754971-1-wenst@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
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

