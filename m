Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 706335066A2
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 10:14:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349790AbiDSIQM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 04:16:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349772AbiDSIPy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 04:15:54 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14A162981F
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 01:13:10 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id j17so7869914pfi.9
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 01:13:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=U5yQtBsK7g4SwGLkpuJDtM4+AkHiJ7XL7QYC77XAeQw=;
        b=LezFh7gHKVJEoPCkkHkQlNzC9cEjAdQFrGxznjw4IdFdfhA5Vn90TLvYerbHLQudVz
         3Hnfgrgz3WCCogDPo8ffKm5NdXHtgRM+tjed95t3f5gYB0PFfHG8JAxLEzz7uZplsgRX
         mjV7CfcZcP8dE74QiCAN1z4Q25lQ7MBeVjFwU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=U5yQtBsK7g4SwGLkpuJDtM4+AkHiJ7XL7QYC77XAeQw=;
        b=Gdl0875abfzY8tWXemzEE71BKAhc/9lPYoVmRKr9n1yOYB7U5yFV0PtPobFlH7q9kH
         zdha2XEgEWyvoFyLUIzMLXwylzzjNBC521e3/AIy3oaTEisvyjNsWIqHIK7Vqm0fzBES
         Jk1xeqMsosTLkwiF4eeSQcJvU4u4I63GGyP14NudzXOe+JmsZMXnNvLwRXmf95uGbNNc
         rTuKCGup454+in0M27K+dlidsitxLPSsR5cjrMoEs7O2muUfZvKM03k7k3sRZYrqvFiL
         9guwDiDN+7+DGEM1rxWZcSa/u2N5EPB8xUd2kr6QMUSYmuXa4x1px+9O3goiAKQTcUFo
         OfEg==
X-Gm-Message-State: AOAM530c9Ik0se1nZTUvxe0lAlD6wZ7NhKJsrE8ook1AIcFFnJ2UiC/3
        vCNiUQktDhT0o3aDbTIzBs/A9KAn+zgbQg==
X-Google-Smtp-Source: ABdhPJxMpb9iTDPKdH5ZVnffHIsn1+7NrlW0mNIC6TZi9Hobi71fx4gkPvBcNQ6DBTUghxnQWmc1Kg==
X-Received: by 2002:a63:955a:0:b0:3a7:5c62:96b3 with SMTP id t26-20020a63955a000000b003a75c6296b3mr11804008pgn.337.1650355989017;
        Tue, 19 Apr 2022 01:13:09 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:33f6:f1e6:3e21:a253])
        by smtp.gmail.com with ESMTPSA id n13-20020a654ccd000000b0039db6f73e9dsm15767448pgt.28.2022.04.19.01.13.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Apr 2022 01:13:08 -0700 (PDT)
From:   Chen-Yu Tsai <wenst@chromium.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        Miles Chen <miles.chen@mediatek.com>,
        Rex-BC Chen <rex-bc.chen@mediatek.com>
Cc:     Chen-Yu Tsai <wenst@chromium.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-clk@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 4/7] clk: mediatek: Replace 'struct clk' with 'struct clk_hw'
Date:   Tue, 19 Apr 2022 16:12:43 +0800
Message-Id: <20220419081246.2546159-5-wenst@chromium.org>
X-Mailer: git-send-email 2.36.0.rc0.470.gd361397f0d-goog
In-Reply-To: <20220419081246.2546159-1-wenst@chromium.org>
References: <20220419081246.2546159-1-wenst@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As part of the effort to improve the MediaTek clk drivers, the next step
is to switch from the old 'struct clk' clk prodivder APIs to the new
'struct clk_hw' ones.

Instead of adding new APIs to the MediaTek clk driver library mirroring
the existing ones, moving all drivers to the new APIs, and then removing
the old ones, just migrate everything at the same time. This involves
replacing 'struct clk' with 'struct clk_hw', and 'struct clk_onecell_data'
with 'struct clk_hw_onecell_data', and fixing up all usages.

This is done with the following coccinelle script.

    // Replace type
    @@
    @@
    - struct clk_onecell_data
    + struct clk_hw_onecell_data

    // Replace of_clk_add_provider() & of_clk_src_simple_get()
    @@
    expression NP, DATA;
    symbol of_clk_src_onecell_get;
    @@
    - of_clk_add_provider(
    + of_clk_add_hw_provider(
	    NP,
    -	of_clk_src_onecell_get,
    +	of_clk_hw_onecell_get,
	    DATA
      )

    // Fix register/unregister
    @@
    identifier CD;
    expression E;
    identifier fn =~ "unregister";
    @@
      fn(...,
    -    CD->clks[E]
    +    CD->hws[E]->clk
	 ,...
	);

    // Fix calls to clk_prepare_enable()
    @@
    identifier CD;
    expression E;
    @@
      clk_prepare_enable(
    - 		     CD->clks[E]
    + 		     CD->hws[E]->clk
      );

    // Fix pointer assignment
    @@
    identifier CD;
    identifier CLK;
    expression E;
    @@
    - CD->clks[E]
    + CD->hws[E]
      =
    (
    - CLK
    + __clk_get_hw(CLK)
    |
      ERR_PTR(...)
    )
      ;

    // Fix pointer usage
    @@
    identifier CD;
    expression E;
    @@
    - CD->clks[E]
    + CD->hws[E]

    // Fix mtk_clk_pll_get_base()
    @@
    symbol clk, hw, data;
    @@
      mtk_clk_pll_get_base(
    - 		       struct clk *clk,
    + 		       struct clk_hw *hw,
			   const struct mtk_pll_data *data
      ) {
    - struct clk_hw *hw = __clk_get_hw(clk);
      ...
      }

    // Fix mtk_clk_pll_get_base() usage
    @@
    identifier CD;
    expression E;
    @@
      mtk_clk_pll_get_base(
    -    CD->clks[E]
    +    CD->hws[E]->clk
	 ,...
      );

Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
 drivers/clk/mediatek/clk-cpumux.c            | 20 ++---
 drivers/clk/mediatek/clk-cpumux.h            |  6 +-
 drivers/clk/mediatek/clk-gate.c              | 22 ++---
 drivers/clk/mediatek/clk-gate.h              |  8 +-
 drivers/clk/mediatek/clk-mt2701-aud.c        |  4 +-
 drivers/clk/mediatek/clk-mt2701-bdp.c        |  4 +-
 drivers/clk/mediatek/clk-mt2701-eth.c        |  4 +-
 drivers/clk/mediatek/clk-mt2701-g3d.c        |  4 +-
 drivers/clk/mediatek/clk-mt2701-hif.c        |  4 +-
 drivers/clk/mediatek/clk-mt2701-img.c        |  4 +-
 drivers/clk/mediatek/clk-mt2701-mm.c         |  4 +-
 drivers/clk/mediatek/clk-mt2701-vdec.c       |  4 +-
 drivers/clk/mediatek/clk-mt2701.c            | 26 +++---
 drivers/clk/mediatek/clk-mt2712-bdp.c        |  4 +-
 drivers/clk/mediatek/clk-mt2712-img.c        |  4 +-
 drivers/clk/mediatek/clk-mt2712-jpgdec.c     |  4 +-
 drivers/clk/mediatek/clk-mt2712-mfg.c        |  4 +-
 drivers/clk/mediatek/clk-mt2712-mm.c         |  4 +-
 drivers/clk/mediatek/clk-mt2712-vdec.c       |  4 +-
 drivers/clk/mediatek/clk-mt2712-venc.c       |  4 +-
 drivers/clk/mediatek/clk-mt2712.c            | 28 +++----
 drivers/clk/mediatek/clk-mt6765-audio.c      |  4 +-
 drivers/clk/mediatek/clk-mt6765-cam.c        |  4 +-
 drivers/clk/mediatek/clk-mt6765-img.c        |  4 +-
 drivers/clk/mediatek/clk-mt6765-mipi0a.c     |  4 +-
 drivers/clk/mediatek/clk-mt6765-mm.c         |  4 +-
 drivers/clk/mediatek/clk-mt6765-vcodec.c     |  4 +-
 drivers/clk/mediatek/clk-mt6765.c            | 12 +--
 drivers/clk/mediatek/clk-mt6779-aud.c        |  4 +-
 drivers/clk/mediatek/clk-mt6779-cam.c        |  4 +-
 drivers/clk/mediatek/clk-mt6779-img.c        |  4 +-
 drivers/clk/mediatek/clk-mt6779-ipe.c        |  4 +-
 drivers/clk/mediatek/clk-mt6779-mfg.c        |  4 +-
 drivers/clk/mediatek/clk-mt6779-mm.c         |  4 +-
 drivers/clk/mediatek/clk-mt6779-vdec.c       |  4 +-
 drivers/clk/mediatek/clk-mt6779-venc.c       |  4 +-
 drivers/clk/mediatek/clk-mt6779.c            | 12 +--
 drivers/clk/mediatek/clk-mt6797-img.c        |  4 +-
 drivers/clk/mediatek/clk-mt6797-mm.c         |  4 +-
 drivers/clk/mediatek/clk-mt6797-vdec.c       |  4 +-
 drivers/clk/mediatek/clk-mt6797-venc.c       |  4 +-
 drivers/clk/mediatek/clk-mt6797.c            | 22 ++---
 drivers/clk/mediatek/clk-mt7622-aud.c        |  4 +-
 drivers/clk/mediatek/clk-mt7622-eth.c        |  8 +-
 drivers/clk/mediatek/clk-mt7622-hif.c        |  8 +-
 drivers/clk/mediatek/clk-mt7622.c            | 30 +++----
 drivers/clk/mediatek/clk-mt7629-eth.c        |  8 +-
 drivers/clk/mediatek/clk-mt7629-hif.c        |  8 +-
 drivers/clk/mediatek/clk-mt7629.c            | 30 +++----
 drivers/clk/mediatek/clk-mt7986-apmixed.c    |  6 +-
 drivers/clk/mediatek/clk-mt7986-eth.c        | 12 +--
 drivers/clk/mediatek/clk-mt7986-infracfg.c   |  4 +-
 drivers/clk/mediatek/clk-mt7986-topckgen.c   | 16 ++--
 drivers/clk/mediatek/clk-mt8135.c            | 18 ++--
 drivers/clk/mediatek/clk-mt8167-aud.c        |  4 +-
 drivers/clk/mediatek/clk-mt8167-img.c        |  4 +-
 drivers/clk/mediatek/clk-mt8167-mfgcfg.c     |  4 +-
 drivers/clk/mediatek/clk-mt8167-mm.c         |  4 +-
 drivers/clk/mediatek/clk-mt8167-vdec.c       |  4 +-
 drivers/clk/mediatek/clk-mt8167.c            | 12 +--
 drivers/clk/mediatek/clk-mt8173-mm.c         |  4 +-
 drivers/clk/mediatek/clk-mt8173.c            | 52 ++++++------
 drivers/clk/mediatek/clk-mt8183-audio.c      |  4 +-
 drivers/clk/mediatek/clk-mt8183-cam.c        |  4 +-
 drivers/clk/mediatek/clk-mt8183-img.c        |  4 +-
 drivers/clk/mediatek/clk-mt8183-ipu0.c       |  4 +-
 drivers/clk/mediatek/clk-mt8183-ipu1.c       |  4 +-
 drivers/clk/mediatek/clk-mt8183-ipu_adl.c    |  4 +-
 drivers/clk/mediatek/clk-mt8183-ipu_conn.c   |  4 +-
 drivers/clk/mediatek/clk-mt8183-mfgcfg.c     |  4 +-
 drivers/clk/mediatek/clk-mt8183-mm.c         |  4 +-
 drivers/clk/mediatek/clk-mt8183-vdec.c       |  4 +-
 drivers/clk/mediatek/clk-mt8183-venc.c       |  4 +-
 drivers/clk/mediatek/clk-mt8183.c            | 25 +++---
 drivers/clk/mediatek/clk-mt8192-aud.c        |  4 +-
 drivers/clk/mediatek/clk-mt8192-mm.c         |  4 +-
 drivers/clk/mediatek/clk-mt8192.c            | 21 ++---
 drivers/clk/mediatek/clk-mt8195-apmixedsys.c |  6 +-
 drivers/clk/mediatek/clk-mt8195-apusys_pll.c |  6 +-
 drivers/clk/mediatek/clk-mt8195-topckgen.c   |  6 +-
 drivers/clk/mediatek/clk-mt8195-vdo0.c       |  6 +-
 drivers/clk/mediatek/clk-mt8195-vdo1.c       |  6 +-
 drivers/clk/mediatek/clk-mt8516-aud.c        |  4 +-
 drivers/clk/mediatek/clk-mt8516.c            | 12 +--
 drivers/clk/mediatek/clk-mtk.c               | 88 ++++++++++----------
 drivers/clk/mediatek/clk-mtk.h               | 16 ++--
 drivers/clk/mediatek/clk-mux.c               | 20 ++---
 drivers/clk/mediatek/clk-mux.h               |  6 +-
 drivers/clk/mediatek/clk-pll.c               | 23 +++--
 drivers/clk/mediatek/clk-pll.h               |  6 +-
 90 files changed, 418 insertions(+), 413 deletions(-)

diff --git a/drivers/clk/mediatek/clk-cpumux.c b/drivers/clk/mediatek/clk-cpumux.c
index c11b3fae622e..8e80df43e356 100644
--- a/drivers/clk/mediatek/clk-cpumux.c
+++ b/drivers/clk/mediatek/clk-cpumux.c
@@ -105,7 +105,7 @@ static void mtk_clk_unregister_cpumux(struct clk *clk)
 
 int mtk_clk_register_cpumuxes(struct device_node *node,
 			      const struct mtk_composite *clks, int num,
-			      struct clk_onecell_data *clk_data)
+			      struct clk_hw_onecell_data *clk_data)
 {
 	int i;
 	struct clk *clk;
@@ -120,7 +120,7 @@ int mtk_clk_register_cpumuxes(struct device_node *node,
 	for (i = 0; i < num; i++) {
 		const struct mtk_composite *mux = &clks[i];
 
-		if (!IS_ERR_OR_NULL(clk_data->clks[mux->id])) {
+		if (!IS_ERR_OR_NULL(clk_data->hws[mux->id])) {
 			pr_warn("%pOF: Trying to register duplicate clock ID: %d\n",
 				node, mux->id);
 			continue;
@@ -132,7 +132,7 @@ int mtk_clk_register_cpumuxes(struct device_node *node,
 			goto err;
 		}
 
-		clk_data->clks[mux->id] = clk;
+		clk_data->hws[mux->id] = __clk_get_hw(clk);
 	}
 
 	return 0;
@@ -141,29 +141,29 @@ int mtk_clk_register_cpumuxes(struct device_node *node,
 	while (--i >= 0) {
 		const struct mtk_composite *mux = &clks[i];
 
-		if (IS_ERR_OR_NULL(clk_data->clks[mux->id]))
+		if (IS_ERR_OR_NULL(clk_data->hws[mux->id]))
 			continue;
 
-		mtk_clk_unregister_cpumux(clk_data->clks[mux->id]);
-		clk_data->clks[mux->id] = ERR_PTR(-ENOENT);
+		mtk_clk_unregister_cpumux(clk_data->hws[mux->id]->clk);
+		clk_data->hws[mux->id] = ERR_PTR(-ENOENT);
 	}
 
 	return PTR_ERR(clk);
 }
 
 void mtk_clk_unregister_cpumuxes(const struct mtk_composite *clks, int num,
-				 struct clk_onecell_data *clk_data)
+				 struct clk_hw_onecell_data *clk_data)
 {
 	int i;
 
 	for (i = num; i > 0; i--) {
 		const struct mtk_composite *mux = &clks[i - 1];
 
-		if (IS_ERR_OR_NULL(clk_data->clks[mux->id]))
+		if (IS_ERR_OR_NULL(clk_data->hws[mux->id]))
 			continue;
 
-		mtk_clk_unregister_cpumux(clk_data->clks[mux->id]);
-		clk_data->clks[mux->id] = ERR_PTR(-ENOENT);
+		mtk_clk_unregister_cpumux(clk_data->hws[mux->id]->clk);
+		clk_data->hws[mux->id] = ERR_PTR(-ENOENT);
 	}
 }
 
diff --git a/drivers/clk/mediatek/clk-cpumux.h b/drivers/clk/mediatek/clk-cpumux.h
index b07e89f7c283..325adbef25d1 100644
--- a/drivers/clk/mediatek/clk-cpumux.h
+++ b/drivers/clk/mediatek/clk-cpumux.h
@@ -7,15 +7,15 @@
 #ifndef __DRV_CLK_CPUMUX_H
 #define __DRV_CLK_CPUMUX_H
 
-struct clk_onecell_data;
+struct clk_hw_onecell_data;
 struct device_node;
 struct mtk_composite;
 
 int mtk_clk_register_cpumuxes(struct device_node *node,
 			      const struct mtk_composite *clks, int num,
-			      struct clk_onecell_data *clk_data);
+			      struct clk_hw_onecell_data *clk_data);
 
 void mtk_clk_unregister_cpumuxes(const struct mtk_composite *clks, int num,
-				 struct clk_onecell_data *clk_data);
+				 struct clk_hw_onecell_data *clk_data);
 
 #endif /* __DRV_CLK_CPUMUX_H */
diff --git a/drivers/clk/mediatek/clk-gate.c b/drivers/clk/mediatek/clk-gate.c
index da52023f8455..0955cace5b1b 100644
--- a/drivers/clk/mediatek/clk-gate.c
+++ b/drivers/clk/mediatek/clk-gate.c
@@ -205,7 +205,7 @@ static void mtk_clk_unregister_gate(struct clk *clk)
 
 int mtk_clk_register_gates_with_dev(struct device_node *node,
 				    const struct mtk_gate *clks, int num,
-				    struct clk_onecell_data *clk_data,
+				    struct clk_hw_onecell_data *clk_data,
 				    struct device *dev)
 {
 	int i;
@@ -224,7 +224,7 @@ int mtk_clk_register_gates_with_dev(struct device_node *node,
 	for (i = 0; i < num; i++) {
 		const struct mtk_gate *gate = &clks[i];
 
-		if (!IS_ERR_OR_NULL(clk_data->clks[gate->id])) {
+		if (!IS_ERR_OR_NULL(clk_data->hws[gate->id])) {
 			pr_warn("%pOF: Trying to register duplicate clock ID: %d\n",
 				node, gate->id);
 			continue;
@@ -243,7 +243,7 @@ int mtk_clk_register_gates_with_dev(struct device_node *node,
 			goto err;
 		}
 
-		clk_data->clks[gate->id] = clk;
+		clk_data->hws[gate->id] = __clk_get_hw(clk);
 	}
 
 	return 0;
@@ -252,11 +252,11 @@ int mtk_clk_register_gates_with_dev(struct device_node *node,
 	while (--i >= 0) {
 		const struct mtk_gate *gate = &clks[i];
 
-		if (IS_ERR_OR_NULL(clk_data->clks[gate->id]))
+		if (IS_ERR_OR_NULL(clk_data->hws[gate->id]))
 			continue;
 
-		mtk_clk_unregister_gate(clk_data->clks[gate->id]);
-		clk_data->clks[gate->id] = ERR_PTR(-ENOENT);
+		mtk_clk_unregister_gate(clk_data->hws[gate->id]->clk);
+		clk_data->hws[gate->id] = ERR_PTR(-ENOENT);
 	}
 
 	return PTR_ERR(clk);
@@ -264,14 +264,14 @@ int mtk_clk_register_gates_with_dev(struct device_node *node,
 
 int mtk_clk_register_gates(struct device_node *node,
 			   const struct mtk_gate *clks, int num,
-			   struct clk_onecell_data *clk_data)
+			   struct clk_hw_onecell_data *clk_data)
 {
 	return mtk_clk_register_gates_with_dev(node, clks, num, clk_data, NULL);
 }
 EXPORT_SYMBOL_GPL(mtk_clk_register_gates);
 
 void mtk_clk_unregister_gates(const struct mtk_gate *clks, int num,
-			      struct clk_onecell_data *clk_data)
+			      struct clk_hw_onecell_data *clk_data)
 {
 	int i;
 
@@ -281,11 +281,11 @@ void mtk_clk_unregister_gates(const struct mtk_gate *clks, int num,
 	for (i = num; i > 0; i--) {
 		const struct mtk_gate *gate = &clks[i - 1];
 
-		if (IS_ERR_OR_NULL(clk_data->clks[gate->id]))
+		if (IS_ERR_OR_NULL(clk_data->hws[gate->id]))
 			continue;
 
-		mtk_clk_unregister_gate(clk_data->clks[gate->id]);
-		clk_data->clks[gate->id] = ERR_PTR(-ENOENT);
+		mtk_clk_unregister_gate(clk_data->hws[gate->id]->clk);
+		clk_data->hws[gate->id] = ERR_PTR(-ENOENT);
 	}
 }
 EXPORT_SYMBOL_GPL(mtk_clk_unregister_gates);
diff --git a/drivers/clk/mediatek/clk-gate.h b/drivers/clk/mediatek/clk-gate.h
index 6b5738826a22..d9897ef53528 100644
--- a/drivers/clk/mediatek/clk-gate.h
+++ b/drivers/clk/mediatek/clk-gate.h
@@ -10,7 +10,7 @@
 #include <linux/types.h>
 
 struct clk;
-struct clk_onecell_data;
+struct clk_hw_onecell_data;
 struct clk_ops;
 struct device;
 struct device_node;
@@ -52,14 +52,14 @@ struct mtk_gate {
 
 int mtk_clk_register_gates(struct device_node *node,
 			   const struct mtk_gate *clks, int num,
-			   struct clk_onecell_data *clk_data);
+			   struct clk_hw_onecell_data *clk_data);
 
 int mtk_clk_register_gates_with_dev(struct device_node *node,
 				    const struct mtk_gate *clks, int num,
-				    struct clk_onecell_data *clk_data,
+				    struct clk_hw_onecell_data *clk_data,
 				    struct device *dev);
 
 void mtk_clk_unregister_gates(const struct mtk_gate *clks, int num,
-			      struct clk_onecell_data *clk_data);
+			      struct clk_hw_onecell_data *clk_data);
 
 #endif /* __DRV_CLK_GATE_H */
diff --git a/drivers/clk/mediatek/clk-mt2701-aud.c b/drivers/clk/mediatek/clk-mt2701-aud.c
index e66896a44fad..6ba398eb7df9 100644
--- a/drivers/clk/mediatek/clk-mt2701-aud.c
+++ b/drivers/clk/mediatek/clk-mt2701-aud.c
@@ -145,7 +145,7 @@ static const struct of_device_id of_match_clk_mt2701_aud[] = {
 
 static int clk_mt2701_aud_probe(struct platform_device *pdev)
 {
-	struct clk_onecell_data *clk_data;
+	struct clk_hw_onecell_data *clk_data;
 	struct device_node *node = pdev->dev.of_node;
 	int r;
 
@@ -154,7 +154,7 @@ static int clk_mt2701_aud_probe(struct platform_device *pdev)
 	mtk_clk_register_gates(node, audio_clks, ARRAY_SIZE(audio_clks),
 			       clk_data);
 
-	r = of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
+	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 	if (r) {
 		dev_err(&pdev->dev,
 			"could not register clock provider: %s: %d\n",
diff --git a/drivers/clk/mediatek/clk-mt2701-bdp.c b/drivers/clk/mediatek/clk-mt2701-bdp.c
index ffa09cfbfd51..662a8ab3fbb1 100644
--- a/drivers/clk/mediatek/clk-mt2701-bdp.c
+++ b/drivers/clk/mediatek/clk-mt2701-bdp.c
@@ -101,7 +101,7 @@ static const struct of_device_id of_match_clk_mt2701_bdp[] = {
 
 static int clk_mt2701_bdp_probe(struct platform_device *pdev)
 {
-	struct clk_onecell_data *clk_data;
+	struct clk_hw_onecell_data *clk_data;
 	int r;
 	struct device_node *node = pdev->dev.of_node;
 
@@ -110,7 +110,7 @@ static int clk_mt2701_bdp_probe(struct platform_device *pdev)
 	mtk_clk_register_gates(node, bdp_clks, ARRAY_SIZE(bdp_clks),
 						clk_data);
 
-	r = of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
+	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 	if (r)
 		dev_err(&pdev->dev,
 			"could not register clock provider: %s: %d\n",
diff --git a/drivers/clk/mediatek/clk-mt2701-eth.c b/drivers/clk/mediatek/clk-mt2701-eth.c
index 100ff6ca609e..47c2289f3d1d 100644
--- a/drivers/clk/mediatek/clk-mt2701-eth.c
+++ b/drivers/clk/mediatek/clk-mt2701-eth.c
@@ -43,7 +43,7 @@ static const struct of_device_id of_match_clk_mt2701_eth[] = {
 
 static int clk_mt2701_eth_probe(struct platform_device *pdev)
 {
-	struct clk_onecell_data *clk_data;
+	struct clk_hw_onecell_data *clk_data;
 	int r;
 	struct device_node *node = pdev->dev.of_node;
 
@@ -52,7 +52,7 @@ static int clk_mt2701_eth_probe(struct platform_device *pdev)
 	mtk_clk_register_gates(node, eth_clks, ARRAY_SIZE(eth_clks),
 						clk_data);
 
-	r = of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
+	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 	if (r)
 		dev_err(&pdev->dev,
 			"could not register clock provider: %s: %d\n",
diff --git a/drivers/clk/mediatek/clk-mt2701-g3d.c b/drivers/clk/mediatek/clk-mt2701-g3d.c
index 1328c112a38f..79929ed37f83 100644
--- a/drivers/clk/mediatek/clk-mt2701-g3d.c
+++ b/drivers/clk/mediatek/clk-mt2701-g3d.c
@@ -37,7 +37,7 @@ static const struct mtk_gate g3d_clks[] = {
 
 static int clk_mt2701_g3dsys_init(struct platform_device *pdev)
 {
-	struct clk_onecell_data *clk_data;
+	struct clk_hw_onecell_data *clk_data;
 	struct device_node *node = pdev->dev.of_node;
 	int r;
 
@@ -46,7 +46,7 @@ static int clk_mt2701_g3dsys_init(struct platform_device *pdev)
 	mtk_clk_register_gates(node, g3d_clks, ARRAY_SIZE(g3d_clks),
 			       clk_data);
 
-	r = of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
+	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 	if (r)
 		dev_err(&pdev->dev,
 			"could not register clock provider: %s: %d\n",
diff --git a/drivers/clk/mediatek/clk-mt2701-hif.c b/drivers/clk/mediatek/clk-mt2701-hif.c
index 61444881c539..1aa36cb93ad0 100644
--- a/drivers/clk/mediatek/clk-mt2701-hif.c
+++ b/drivers/clk/mediatek/clk-mt2701-hif.c
@@ -40,7 +40,7 @@ static const struct of_device_id of_match_clk_mt2701_hif[] = {
 
 static int clk_mt2701_hif_probe(struct platform_device *pdev)
 {
-	struct clk_onecell_data *clk_data;
+	struct clk_hw_onecell_data *clk_data;
 	int r;
 	struct device_node *node = pdev->dev.of_node;
 
@@ -49,7 +49,7 @@ static int clk_mt2701_hif_probe(struct platform_device *pdev)
 	mtk_clk_register_gates(node, hif_clks, ARRAY_SIZE(hif_clks),
 						clk_data);
 
-	r = of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
+	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 	if (r) {
 		dev_err(&pdev->dev,
 			"could not register clock provider: %s: %d\n",
diff --git a/drivers/clk/mediatek/clk-mt2701-img.c b/drivers/clk/mediatek/clk-mt2701-img.c
index 631e80f0fc7d..c4f3cd26df60 100644
--- a/drivers/clk/mediatek/clk-mt2701-img.c
+++ b/drivers/clk/mediatek/clk-mt2701-img.c
@@ -43,7 +43,7 @@ static const struct of_device_id of_match_clk_mt2701_img[] = {
 
 static int clk_mt2701_img_probe(struct platform_device *pdev)
 {
-	struct clk_onecell_data *clk_data;
+	struct clk_hw_onecell_data *clk_data;
 	int r;
 	struct device_node *node = pdev->dev.of_node;
 
@@ -52,7 +52,7 @@ static int clk_mt2701_img_probe(struct platform_device *pdev)
 	mtk_clk_register_gates(node, img_clks, ARRAY_SIZE(img_clks),
 						clk_data);
 
-	r = of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
+	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 	if (r)
 		dev_err(&pdev->dev,
 			"could not register clock provider: %s: %d\n",
diff --git a/drivers/clk/mediatek/clk-mt2701-mm.c b/drivers/clk/mediatek/clk-mt2701-mm.c
index cb18e1849492..9ea7abad99d2 100644
--- a/drivers/clk/mediatek/clk-mt2701-mm.c
+++ b/drivers/clk/mediatek/clk-mt2701-mm.c
@@ -83,7 +83,7 @@ static int clk_mt2701_mm_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct device_node *node = dev->parent->of_node;
-	struct clk_onecell_data *clk_data;
+	struct clk_hw_onecell_data *clk_data;
 	int r;
 
 	clk_data = mtk_alloc_clk_data(CLK_MM_NR);
@@ -91,7 +91,7 @@ static int clk_mt2701_mm_probe(struct platform_device *pdev)
 	mtk_clk_register_gates(node, mm_clks, ARRAY_SIZE(mm_clks),
 						clk_data);
 
-	r = of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
+	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 	if (r)
 		dev_err(&pdev->dev,
 			"could not register clock provider: %s: %d\n",
diff --git a/drivers/clk/mediatek/clk-mt2701-vdec.c b/drivers/clk/mediatek/clk-mt2701-vdec.c
index c9def728ad1e..a2f18117f27a 100644
--- a/drivers/clk/mediatek/clk-mt2701-vdec.c
+++ b/drivers/clk/mediatek/clk-mt2701-vdec.c
@@ -54,7 +54,7 @@ static const struct of_device_id of_match_clk_mt2701_vdec[] = {
 
 static int clk_mt2701_vdec_probe(struct platform_device *pdev)
 {
-	struct clk_onecell_data *clk_data;
+	struct clk_hw_onecell_data *clk_data;
 	int r;
 	struct device_node *node = pdev->dev.of_node;
 
@@ -63,7 +63,7 @@ static int clk_mt2701_vdec_probe(struct platform_device *pdev)
 	mtk_clk_register_gates(node, vdec_clks, ARRAY_SIZE(vdec_clks),
 						clk_data);
 
-	r = of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
+	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 	if (r)
 		dev_err(&pdev->dev,
 			"could not register clock provider: %s: %d\n",
diff --git a/drivers/clk/mediatek/clk-mt2701.c b/drivers/clk/mediatek/clk-mt2701.c
index 1eb3e4563c3f..7a4331057adc 100644
--- a/drivers/clk/mediatek/clk-mt2701.c
+++ b/drivers/clk/mediatek/clk-mt2701.c
@@ -666,7 +666,7 @@ static const struct mtk_gate top_clks[] = {
 
 static int mtk_topckgen_init(struct platform_device *pdev)
 {
-	struct clk_onecell_data *clk_data;
+	struct clk_hw_onecell_data *clk_data;
 	void __iomem *base;
 	struct device_node *node = pdev->dev.of_node;
 	struct resource *res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
@@ -692,7 +692,7 @@ static int mtk_topckgen_init(struct platform_device *pdev)
 	mtk_clk_register_gates(node, top_clks, ARRAY_SIZE(top_clks),
 						clk_data);
 
-	return of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
+	return of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 }
 
 static const struct mtk_gate_regs infra_cg_regs = {
@@ -735,7 +735,7 @@ static const struct mtk_fixed_factor infra_fixed_divs[] = {
 	FACTOR(CLK_INFRA_CLK_13M, "clk13m", "clk26m", 1, 2),
 };
 
-static struct clk_onecell_data *infra_clk_data;
+static struct clk_hw_onecell_data *infra_clk_data;
 
 static void __init mtk_infrasys_init_early(struct device_node *node)
 {
@@ -745,7 +745,7 @@ static void __init mtk_infrasys_init_early(struct device_node *node)
 		infra_clk_data = mtk_alloc_clk_data(CLK_INFRA_NR);
 
 		for (i = 0; i < CLK_INFRA_NR; i++)
-			infra_clk_data->clks[i] = ERR_PTR(-EPROBE_DEFER);
+			infra_clk_data->hws[i] = ERR_PTR(-EPROBE_DEFER);
 	}
 
 	mtk_clk_register_factors(infra_fixed_divs, ARRAY_SIZE(infra_fixed_divs),
@@ -754,7 +754,8 @@ static void __init mtk_infrasys_init_early(struct device_node *node)
 	mtk_clk_register_cpumuxes(node, cpu_muxes, ARRAY_SIZE(cpu_muxes),
 				  infra_clk_data);
 
-	r = of_clk_add_provider(node, of_clk_src_onecell_get, infra_clk_data);
+	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get,
+				   infra_clk_data);
 	if (r)
 		pr_err("%s(): could not register clock provider: %d\n",
 			__func__, r);
@@ -771,8 +772,8 @@ static int mtk_infrasys_init(struct platform_device *pdev)
 		infra_clk_data = mtk_alloc_clk_data(CLK_INFRA_NR);
 	} else {
 		for (i = 0; i < CLK_INFRA_NR; i++) {
-			if (infra_clk_data->clks[i] == ERR_PTR(-EPROBE_DEFER))
-				infra_clk_data->clks[i] = ERR_PTR(-ENOENT);
+			if (infra_clk_data->hws[i] == ERR_PTR(-EPROBE_DEFER))
+				infra_clk_data->hws[i] = ERR_PTR(-ENOENT);
 		}
 	}
 
@@ -781,7 +782,8 @@ static int mtk_infrasys_init(struct platform_device *pdev)
 	mtk_clk_register_factors(infra_fixed_divs, ARRAY_SIZE(infra_fixed_divs),
 						infra_clk_data);
 
-	r = of_clk_add_provider(node, of_clk_src_onecell_get, infra_clk_data);
+	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get,
+				   infra_clk_data);
 	if (r)
 		return r;
 
@@ -886,7 +888,7 @@ static const struct mtk_composite peri_muxs[] = {
 
 static int mtk_pericfg_init(struct platform_device *pdev)
 {
-	struct clk_onecell_data *clk_data;
+	struct clk_hw_onecell_data *clk_data;
 	void __iomem *base;
 	int r;
 	struct device_node *node = pdev->dev.of_node;
@@ -904,7 +906,7 @@ static int mtk_pericfg_init(struct platform_device *pdev)
 	mtk_clk_register_composites(peri_muxs, ARRAY_SIZE(peri_muxs), base,
 			&mt2701_clk_lock, clk_data);
 
-	r = of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
+	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 	if (r)
 		return r;
 
@@ -969,7 +971,7 @@ static const struct mtk_fixed_factor apmixed_fixed_divs[] = {
 
 static int mtk_apmixedsys_init(struct platform_device *pdev)
 {
-	struct clk_onecell_data *clk_data;
+	struct clk_hw_onecell_data *clk_data;
 	struct device_node *node = pdev->dev.of_node;
 
 	clk_data = mtk_alloc_clk_data(CLK_APMIXED_NR);
@@ -981,7 +983,7 @@ static int mtk_apmixedsys_init(struct platform_device *pdev)
 	mtk_clk_register_factors(apmixed_fixed_divs, ARRAY_SIZE(apmixed_fixed_divs),
 								clk_data);
 
-	return of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
+	return of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 }
 
 static const struct of_device_id of_match_clk_mt2701[] = {
diff --git a/drivers/clk/mediatek/clk-mt2712-bdp.c b/drivers/clk/mediatek/clk-mt2712-bdp.c
index a200714001d8..9acab4357133 100644
--- a/drivers/clk/mediatek/clk-mt2712-bdp.c
+++ b/drivers/clk/mediatek/clk-mt2712-bdp.c
@@ -60,7 +60,7 @@ static const struct mtk_gate bdp_clks[] = {
 
 static int clk_mt2712_bdp_probe(struct platform_device *pdev)
 {
-	struct clk_onecell_data *clk_data;
+	struct clk_hw_onecell_data *clk_data;
 	int r;
 	struct device_node *node = pdev->dev.of_node;
 
@@ -69,7 +69,7 @@ static int clk_mt2712_bdp_probe(struct platform_device *pdev)
 	mtk_clk_register_gates(node, bdp_clks, ARRAY_SIZE(bdp_clks),
 			clk_data);
 
-	r = of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
+	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 
 	if (r != 0)
 		pr_err("%s(): could not register clock provider: %d\n",
diff --git a/drivers/clk/mediatek/clk-mt2712-img.c b/drivers/clk/mediatek/clk-mt2712-img.c
index 89b2a7197b02..5cc143e65e42 100644
--- a/drivers/clk/mediatek/clk-mt2712-img.c
+++ b/drivers/clk/mediatek/clk-mt2712-img.c
@@ -38,7 +38,7 @@ static const struct mtk_gate img_clks[] = {
 
 static int clk_mt2712_img_probe(struct platform_device *pdev)
 {
-	struct clk_onecell_data *clk_data;
+	struct clk_hw_onecell_data *clk_data;
 	int r;
 	struct device_node *node = pdev->dev.of_node;
 
@@ -47,7 +47,7 @@ static int clk_mt2712_img_probe(struct platform_device *pdev)
 	mtk_clk_register_gates(node, img_clks, ARRAY_SIZE(img_clks),
 			clk_data);
 
-	r = of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
+	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 
 	if (r != 0)
 		pr_err("%s(): could not register clock provider: %d\n",
diff --git a/drivers/clk/mediatek/clk-mt2712-jpgdec.c b/drivers/clk/mediatek/clk-mt2712-jpgdec.c
index 58813c38ab4d..31fc30370d98 100644
--- a/drivers/clk/mediatek/clk-mt2712-jpgdec.c
+++ b/drivers/clk/mediatek/clk-mt2712-jpgdec.c
@@ -34,7 +34,7 @@ static const struct mtk_gate jpgdec_clks[] = {
 
 static int clk_mt2712_jpgdec_probe(struct platform_device *pdev)
 {
-	struct clk_onecell_data *clk_data;
+	struct clk_hw_onecell_data *clk_data;
 	int r;
 	struct device_node *node = pdev->dev.of_node;
 
@@ -43,7 +43,7 @@ static int clk_mt2712_jpgdec_probe(struct platform_device *pdev)
 	mtk_clk_register_gates(node, jpgdec_clks, ARRAY_SIZE(jpgdec_clks),
 			clk_data);
 
-	r = of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
+	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 
 	if (r != 0)
 		pr_err("%s(): could not register clock provider: %d\n",
diff --git a/drivers/clk/mediatek/clk-mt2712-mfg.c b/drivers/clk/mediatek/clk-mt2712-mfg.c
index a6b827db17bc..a4d09675bf18 100644
--- a/drivers/clk/mediatek/clk-mt2712-mfg.c
+++ b/drivers/clk/mediatek/clk-mt2712-mfg.c
@@ -33,7 +33,7 @@ static const struct mtk_gate mfg_clks[] = {
 
 static int clk_mt2712_mfg_probe(struct platform_device *pdev)
 {
-	struct clk_onecell_data *clk_data;
+	struct clk_hw_onecell_data *clk_data;
 	int r;
 	struct device_node *node = pdev->dev.of_node;
 
@@ -42,7 +42,7 @@ static int clk_mt2712_mfg_probe(struct platform_device *pdev)
 	mtk_clk_register_gates(node, mfg_clks, ARRAY_SIZE(mfg_clks),
 			clk_data);
 
-	r = of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
+	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 
 	if (r != 0)
 		pr_err("%s(): could not register clock provider: %d\n",
diff --git a/drivers/clk/mediatek/clk-mt2712-mm.c b/drivers/clk/mediatek/clk-mt2712-mm.c
index 5519c3d68c1f..7d44b09b8a0a 100644
--- a/drivers/clk/mediatek/clk-mt2712-mm.c
+++ b/drivers/clk/mediatek/clk-mt2712-mm.c
@@ -130,7 +130,7 @@ static int clk_mt2712_mm_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct device_node *node = dev->parent->of_node;
-	struct clk_onecell_data *clk_data;
+	struct clk_hw_onecell_data *clk_data;
 	int r;
 
 	clk_data = mtk_alloc_clk_data(CLK_MM_NR_CLK);
@@ -138,7 +138,7 @@ static int clk_mt2712_mm_probe(struct platform_device *pdev)
 	mtk_clk_register_gates(node, mm_clks, ARRAY_SIZE(mm_clks),
 			clk_data);
 
-	r = of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
+	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 
 	if (r != 0)
 		pr_err("%s(): could not register clock provider: %d\n",
diff --git a/drivers/clk/mediatek/clk-mt2712-vdec.c b/drivers/clk/mediatek/clk-mt2712-vdec.c
index 4987ad9d3b11..af13f43dd831 100644
--- a/drivers/clk/mediatek/clk-mt2712-vdec.c
+++ b/drivers/clk/mediatek/clk-mt2712-vdec.c
@@ -52,7 +52,7 @@ static const struct mtk_gate vdec_clks[] = {
 
 static int clk_mt2712_vdec_probe(struct platform_device *pdev)
 {
-	struct clk_onecell_data *clk_data;
+	struct clk_hw_onecell_data *clk_data;
 	int r;
 	struct device_node *node = pdev->dev.of_node;
 
@@ -61,7 +61,7 @@ static int clk_mt2712_vdec_probe(struct platform_device *pdev)
 	mtk_clk_register_gates(node, vdec_clks, ARRAY_SIZE(vdec_clks),
 			clk_data);
 
-	r = of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
+	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 
 	if (r != 0)
 		pr_err("%s(): could not register clock provider: %d\n",
diff --git a/drivers/clk/mediatek/clk-mt2712-venc.c b/drivers/clk/mediatek/clk-mt2712-venc.c
index 07c29daa1ad6..abc08a029753 100644
--- a/drivers/clk/mediatek/clk-mt2712-venc.c
+++ b/drivers/clk/mediatek/clk-mt2712-venc.c
@@ -35,7 +35,7 @@ static const struct mtk_gate venc_clks[] = {
 
 static int clk_mt2712_venc_probe(struct platform_device *pdev)
 {
-	struct clk_onecell_data *clk_data;
+	struct clk_hw_onecell_data *clk_data;
 	int r;
 	struct device_node *node = pdev->dev.of_node;
 
@@ -44,7 +44,7 @@ static int clk_mt2712_venc_probe(struct platform_device *pdev)
 	mtk_clk_register_gates(node, venc_clks, ARRAY_SIZE(venc_clks),
 			clk_data);
 
-	r = of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
+	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 
 	if (r != 0)
 		pr_err("%s(): could not register clock provider: %d\n",
diff --git a/drivers/clk/mediatek/clk-mt2712.c b/drivers/clk/mediatek/clk-mt2712.c
index ff72b9ab945b..1dd90d9a70ac 100644
--- a/drivers/clk/mediatek/clk-mt2712.c
+++ b/drivers/clk/mediatek/clk-mt2712.c
@@ -1260,7 +1260,7 @@ static const struct mtk_pll_data plls[] = {
 
 static int clk_mt2712_apmixed_probe(struct platform_device *pdev)
 {
-	struct clk_onecell_data *clk_data;
+	struct clk_hw_onecell_data *clk_data;
 	int r;
 	struct device_node *node = pdev->dev.of_node;
 
@@ -1268,7 +1268,7 @@ static int clk_mt2712_apmixed_probe(struct platform_device *pdev)
 
 	mtk_clk_register_plls(node, plls, ARRAY_SIZE(plls), clk_data);
 
-	r = of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
+	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 
 	if (r != 0)
 		pr_err("%s(): could not register clock provider: %d\n",
@@ -1277,7 +1277,7 @@ static int clk_mt2712_apmixed_probe(struct platform_device *pdev)
 	return r;
 }
 
-static struct clk_onecell_data *top_clk_data;
+static struct clk_hw_onecell_data *top_clk_data;
 
 static void clk_mt2712_top_init_early(struct device_node *node)
 {
@@ -1287,13 +1287,13 @@ static void clk_mt2712_top_init_early(struct device_node *node)
 		top_clk_data = mtk_alloc_clk_data(CLK_TOP_NR_CLK);
 
 		for (i = 0; i < CLK_TOP_NR_CLK; i++)
-			top_clk_data->clks[i] = ERR_PTR(-EPROBE_DEFER);
+			top_clk_data->hws[i] = ERR_PTR(-EPROBE_DEFER);
 	}
 
 	mtk_clk_register_factors(top_early_divs, ARRAY_SIZE(top_early_divs),
 			top_clk_data);
 
-	r = of_clk_add_provider(node, of_clk_src_onecell_get, top_clk_data);
+	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, top_clk_data);
 	if (r)
 		pr_err("%s(): could not register clock provider: %d\n",
 			__func__, r);
@@ -1318,8 +1318,8 @@ static int clk_mt2712_top_probe(struct platform_device *pdev)
 		top_clk_data = mtk_alloc_clk_data(CLK_TOP_NR_CLK);
 	} else {
 		for (i = 0; i < CLK_TOP_NR_CLK; i++) {
-			if (top_clk_data->clks[i] == ERR_PTR(-EPROBE_DEFER))
-				top_clk_data->clks[i] = ERR_PTR(-ENOENT);
+			if (top_clk_data->hws[i] == ERR_PTR(-EPROBE_DEFER))
+				top_clk_data->hws[i] = ERR_PTR(-ENOENT);
 		}
 	}
 
@@ -1335,7 +1335,7 @@ static int clk_mt2712_top_probe(struct platform_device *pdev)
 	mtk_clk_register_gates(node, top_clks, ARRAY_SIZE(top_clks),
 			top_clk_data);
 
-	r = of_clk_add_provider(node, of_clk_src_onecell_get, top_clk_data);
+	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, top_clk_data);
 
 	if (r != 0)
 		pr_err("%s(): could not register clock provider: %d\n",
@@ -1346,7 +1346,7 @@ static int clk_mt2712_top_probe(struct platform_device *pdev)
 
 static int clk_mt2712_infra_probe(struct platform_device *pdev)
 {
-	struct clk_onecell_data *clk_data;
+	struct clk_hw_onecell_data *clk_data;
 	int r;
 	struct device_node *node = pdev->dev.of_node;
 
@@ -1355,7 +1355,7 @@ static int clk_mt2712_infra_probe(struct platform_device *pdev)
 	mtk_clk_register_gates(node, infra_clks, ARRAY_SIZE(infra_clks),
 			clk_data);
 
-	r = of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
+	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 
 	if (r != 0)
 		pr_err("%s(): could not register clock provider: %d\n",
@@ -1368,7 +1368,7 @@ static int clk_mt2712_infra_probe(struct platform_device *pdev)
 
 static int clk_mt2712_peri_probe(struct platform_device *pdev)
 {
-	struct clk_onecell_data *clk_data;
+	struct clk_hw_onecell_data *clk_data;
 	int r;
 	struct device_node *node = pdev->dev.of_node;
 
@@ -1377,7 +1377,7 @@ static int clk_mt2712_peri_probe(struct platform_device *pdev)
 	mtk_clk_register_gates(node, peri_clks, ARRAY_SIZE(peri_clks),
 			clk_data);
 
-	r = of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
+	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 
 	if (r != 0)
 		pr_err("%s(): could not register clock provider: %d\n",
@@ -1390,7 +1390,7 @@ static int clk_mt2712_peri_probe(struct platform_device *pdev)
 
 static int clk_mt2712_mcu_probe(struct platform_device *pdev)
 {
-	struct clk_onecell_data *clk_data;
+	struct clk_hw_onecell_data *clk_data;
 	int r;
 	struct device_node *node = pdev->dev.of_node;
 	void __iomem *base;
@@ -1406,7 +1406,7 @@ static int clk_mt2712_mcu_probe(struct platform_device *pdev)
 	mtk_clk_register_composites(mcu_muxes, ARRAY_SIZE(mcu_muxes), base,
 			&mt2712_clk_lock, clk_data);
 
-	r = of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
+	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 
 	if (r != 0)
 		pr_err("%s(): could not register clock provider: %d\n",
diff --git a/drivers/clk/mediatek/clk-mt6765-audio.c b/drivers/clk/mediatek/clk-mt6765-audio.c
index 4c989165d795..9c6e9caad597 100644
--- a/drivers/clk/mediatek/clk-mt6765-audio.c
+++ b/drivers/clk/mediatek/clk-mt6765-audio.c
@@ -66,7 +66,7 @@ static const struct mtk_gate audio_clks[] = {
 
 static int clk_mt6765_audio_probe(struct platform_device *pdev)
 {
-	struct clk_onecell_data *clk_data;
+	struct clk_hw_onecell_data *clk_data;
 	int r;
 	struct device_node *node = pdev->dev.of_node;
 
@@ -75,7 +75,7 @@ static int clk_mt6765_audio_probe(struct platform_device *pdev)
 	mtk_clk_register_gates(node, audio_clks,
 			       ARRAY_SIZE(audio_clks), clk_data);
 
-	r = of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
+	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 
 	if (r)
 		pr_err("%s(): could not register clock provider: %d\n",
diff --git a/drivers/clk/mediatek/clk-mt6765-cam.c b/drivers/clk/mediatek/clk-mt6765-cam.c
index c96394893bcf..2586d3ac4cd4 100644
--- a/drivers/clk/mediatek/clk-mt6765-cam.c
+++ b/drivers/clk/mediatek/clk-mt6765-cam.c
@@ -41,7 +41,7 @@ static const struct mtk_gate cam_clks[] = {
 
 static int clk_mt6765_cam_probe(struct platform_device *pdev)
 {
-	struct clk_onecell_data *clk_data;
+	struct clk_hw_onecell_data *clk_data;
 	int r;
 	struct device_node *node = pdev->dev.of_node;
 
@@ -49,7 +49,7 @@ static int clk_mt6765_cam_probe(struct platform_device *pdev)
 
 	mtk_clk_register_gates(node, cam_clks, ARRAY_SIZE(cam_clks), clk_data);
 
-	r = of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
+	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 
 	if (r)
 		pr_err("%s(): could not register clock provider: %d\n",
diff --git a/drivers/clk/mediatek/clk-mt6765-img.c b/drivers/clk/mediatek/clk-mt6765-img.c
index 6fd8bf8030fc..8cc95b98921e 100644
--- a/drivers/clk/mediatek/clk-mt6765-img.c
+++ b/drivers/clk/mediatek/clk-mt6765-img.c
@@ -37,7 +37,7 @@ static const struct mtk_gate img_clks[] = {
 
 static int clk_mt6765_img_probe(struct platform_device *pdev)
 {
-	struct clk_onecell_data *clk_data;
+	struct clk_hw_onecell_data *clk_data;
 	int r;
 	struct device_node *node = pdev->dev.of_node;
 
@@ -45,7 +45,7 @@ static int clk_mt6765_img_probe(struct platform_device *pdev)
 
 	mtk_clk_register_gates(node, img_clks, ARRAY_SIZE(img_clks), clk_data);
 
-	r = of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
+	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 
 	if (r)
 		pr_err("%s(): could not register clock provider: %d\n",
diff --git a/drivers/clk/mediatek/clk-mt6765-mipi0a.c b/drivers/clk/mediatek/clk-mt6765-mipi0a.c
index 81744d0f95a0..c816e26a95f9 100644
--- a/drivers/clk/mediatek/clk-mt6765-mipi0a.c
+++ b/drivers/clk/mediatek/clk-mt6765-mipi0a.c
@@ -34,7 +34,7 @@ static const struct mtk_gate mipi0a_clks[] = {
 
 static int clk_mt6765_mipi0a_probe(struct platform_device *pdev)
 {
-	struct clk_onecell_data *clk_data;
+	struct clk_hw_onecell_data *clk_data;
 	int r;
 	struct device_node *node = pdev->dev.of_node;
 
@@ -43,7 +43,7 @@ static int clk_mt6765_mipi0a_probe(struct platform_device *pdev)
 	mtk_clk_register_gates(node, mipi0a_clks,
 			       ARRAY_SIZE(mipi0a_clks), clk_data);
 
-	r = of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
+	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 
 	if (r)
 		pr_err("%s(): could not register clock provider: %d\n",
diff --git a/drivers/clk/mediatek/clk-mt6765-mm.c b/drivers/clk/mediatek/clk-mt6765-mm.c
index 6d8214c51684..ee6d3b859a6c 100644
--- a/drivers/clk/mediatek/clk-mt6765-mm.c
+++ b/drivers/clk/mediatek/clk-mt6765-mm.c
@@ -63,7 +63,7 @@ static const struct mtk_gate mm_clks[] = {
 
 static int clk_mt6765_mm_probe(struct platform_device *pdev)
 {
-	struct clk_onecell_data *clk_data;
+	struct clk_hw_onecell_data *clk_data;
 	int r;
 	struct device_node *node = pdev->dev.of_node;
 
@@ -71,7 +71,7 @@ static int clk_mt6765_mm_probe(struct platform_device *pdev)
 
 	mtk_clk_register_gates(node, mm_clks, ARRAY_SIZE(mm_clks), clk_data);
 
-	r = of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
+	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 
 	if (r)
 		pr_err("%s(): could not register clock provider: %d\n",
diff --git a/drivers/clk/mediatek/clk-mt6765-vcodec.c b/drivers/clk/mediatek/clk-mt6765-vcodec.c
index baae665fab31..d8045979d48a 100644
--- a/drivers/clk/mediatek/clk-mt6765-vcodec.c
+++ b/drivers/clk/mediatek/clk-mt6765-vcodec.c
@@ -36,7 +36,7 @@ static const struct mtk_gate venc_clks[] = {
 
 static int clk_mt6765_vcodec_probe(struct platform_device *pdev)
 {
-	struct clk_onecell_data *clk_data;
+	struct clk_hw_onecell_data *clk_data;
 	int r;
 	struct device_node *node = pdev->dev.of_node;
 
@@ -45,7 +45,7 @@ static int clk_mt6765_vcodec_probe(struct platform_device *pdev)
 	mtk_clk_register_gates(node, venc_clks,
 			       ARRAY_SIZE(venc_clks), clk_data);
 
-	r = of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
+	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 
 	if (r)
 		pr_err("%s(): could not register clock provider: %d\n",
diff --git a/drivers/clk/mediatek/clk-mt6765.c b/drivers/clk/mediatek/clk-mt6765.c
index 24829ca3bd1f..b6278005d1e6 100644
--- a/drivers/clk/mediatek/clk-mt6765.c
+++ b/drivers/clk/mediatek/clk-mt6765.c
@@ -773,7 +773,7 @@ static const struct mtk_pll_data plls[] = {
 
 static int clk_mt6765_apmixed_probe(struct platform_device *pdev)
 {
-	struct clk_onecell_data *clk_data;
+	struct clk_hw_onecell_data *clk_data;
 	int r;
 	struct device_node *node = pdev->dev.of_node;
 	void __iomem *base;
@@ -791,7 +791,7 @@ static int clk_mt6765_apmixed_probe(struct platform_device *pdev)
 
 	mtk_clk_register_gates(node, apmixed_clks,
 			       ARRAY_SIZE(apmixed_clks), clk_data);
-	r = of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
+	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 
 	if (r)
 		pr_err("%s(): could not register clock provider: %d\n",
@@ -811,7 +811,7 @@ static int clk_mt6765_top_probe(struct platform_device *pdev)
 	int r;
 	struct device_node *node = pdev->dev.of_node;
 	void __iomem *base;
-	struct clk_onecell_data *clk_data;
+	struct clk_hw_onecell_data *clk_data;
 	struct resource *res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 
 	base = devm_ioremap_resource(&pdev->dev, res);
@@ -831,7 +831,7 @@ static int clk_mt6765_top_probe(struct platform_device *pdev)
 	mtk_clk_register_gates(node, top_clks, ARRAY_SIZE(top_clks),
 			       clk_data);
 
-	r = of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
+	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 
 	if (r)
 		pr_err("%s(): could not register clock provider: %d\n",
@@ -848,7 +848,7 @@ static int clk_mt6765_top_probe(struct platform_device *pdev)
 
 static int clk_mt6765_ifr_probe(struct platform_device *pdev)
 {
-	struct clk_onecell_data *clk_data;
+	struct clk_hw_onecell_data *clk_data;
 	int r;
 	struct device_node *node = pdev->dev.of_node;
 	void __iomem *base;
@@ -864,7 +864,7 @@ static int clk_mt6765_ifr_probe(struct platform_device *pdev)
 
 	mtk_clk_register_gates(node, ifr_clks, ARRAY_SIZE(ifr_clks),
 			       clk_data);
-	r = of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
+	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 
 	if (r)
 		pr_err("%s(): could not register clock provider: %d\n",
diff --git a/drivers/clk/mediatek/clk-mt6779-aud.c b/drivers/clk/mediatek/clk-mt6779-aud.c
index 9e889e4c361a..97e44abb7e87 100644
--- a/drivers/clk/mediatek/clk-mt6779-aud.c
+++ b/drivers/clk/mediatek/clk-mt6779-aud.c
@@ -96,7 +96,7 @@ static const struct of_device_id of_match_clk_mt6779_aud[] = {
 
 static int clk_mt6779_aud_probe(struct platform_device *pdev)
 {
-	struct clk_onecell_data *clk_data;
+	struct clk_hw_onecell_data *clk_data;
 	struct device_node *node = pdev->dev.of_node;
 
 	clk_data = mtk_alloc_clk_data(CLK_AUD_NR_CLK);
@@ -104,7 +104,7 @@ static int clk_mt6779_aud_probe(struct platform_device *pdev)
 	mtk_clk_register_gates(node, audio_clks, ARRAY_SIZE(audio_clks),
 			       clk_data);
 
-	return of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
+	return of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 }
 
 static struct platform_driver clk_mt6779_aud_drv = {
diff --git a/drivers/clk/mediatek/clk-mt6779-cam.c b/drivers/clk/mediatek/clk-mt6779-cam.c
index 7f07a2a139ac..9c5117aae146 100644
--- a/drivers/clk/mediatek/clk-mt6779-cam.c
+++ b/drivers/clk/mediatek/clk-mt6779-cam.c
@@ -45,7 +45,7 @@ static const struct of_device_id of_match_clk_mt6779_cam[] = {
 
 static int clk_mt6779_cam_probe(struct platform_device *pdev)
 {
-	struct clk_onecell_data *clk_data;
+	struct clk_hw_onecell_data *clk_data;
 	struct device_node *node = pdev->dev.of_node;
 
 	clk_data = mtk_alloc_clk_data(CLK_CAM_NR_CLK);
@@ -53,7 +53,7 @@ static int clk_mt6779_cam_probe(struct platform_device *pdev)
 	mtk_clk_register_gates(node, cam_clks, ARRAY_SIZE(cam_clks),
 			       clk_data);
 
-	return of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
+	return of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 }
 
 static struct platform_driver clk_mt6779_cam_drv = {
diff --git a/drivers/clk/mediatek/clk-mt6779-img.c b/drivers/clk/mediatek/clk-mt6779-img.c
index f0961fa1a286..801271477d46 100644
--- a/drivers/clk/mediatek/clk-mt6779-img.c
+++ b/drivers/clk/mediatek/clk-mt6779-img.c
@@ -37,7 +37,7 @@ static const struct of_device_id of_match_clk_mt6779_img[] = {
 
 static int clk_mt6779_img_probe(struct platform_device *pdev)
 {
-	struct clk_onecell_data *clk_data;
+	struct clk_hw_onecell_data *clk_data;
 	struct device_node *node = pdev->dev.of_node;
 
 	clk_data = mtk_alloc_clk_data(CLK_IMG_NR_CLK);
@@ -45,7 +45,7 @@ static int clk_mt6779_img_probe(struct platform_device *pdev)
 	mtk_clk_register_gates(node, img_clks, ARRAY_SIZE(img_clks),
 			       clk_data);
 
-	return of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
+	return of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 }
 
 static struct platform_driver clk_mt6779_img_drv = {
diff --git a/drivers/clk/mediatek/clk-mt6779-ipe.c b/drivers/clk/mediatek/clk-mt6779-ipe.c
index 8c6f3e154bf3..f67814ca7dfb 100644
--- a/drivers/clk/mediatek/clk-mt6779-ipe.c
+++ b/drivers/clk/mediatek/clk-mt6779-ipe.c
@@ -39,7 +39,7 @@ static const struct of_device_id of_match_clk_mt6779_ipe[] = {
 
 static int clk_mt6779_ipe_probe(struct platform_device *pdev)
 {
-	struct clk_onecell_data *clk_data;
+	struct clk_hw_onecell_data *clk_data;
 	struct device_node *node = pdev->dev.of_node;
 
 	clk_data = mtk_alloc_clk_data(CLK_IPE_NR_CLK);
@@ -47,7 +47,7 @@ static int clk_mt6779_ipe_probe(struct platform_device *pdev)
 	mtk_clk_register_gates(node, ipe_clks, ARRAY_SIZE(ipe_clks),
 			       clk_data);
 
-	return of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
+	return of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 }
 
 static struct platform_driver clk_mt6779_ipe_drv = {
diff --git a/drivers/clk/mediatek/clk-mt6779-mfg.c b/drivers/clk/mediatek/clk-mt6779-mfg.c
index 9f3372886e6b..fc7387b59758 100644
--- a/drivers/clk/mediatek/clk-mt6779-mfg.c
+++ b/drivers/clk/mediatek/clk-mt6779-mfg.c
@@ -29,7 +29,7 @@ static const struct mtk_gate mfg_clks[] = {
 
 static int clk_mt6779_mfg_probe(struct platform_device *pdev)
 {
-	struct clk_onecell_data *clk_data;
+	struct clk_hw_onecell_data *clk_data;
 	struct device_node *node = pdev->dev.of_node;
 
 	clk_data = mtk_alloc_clk_data(CLK_MFGCFG_NR_CLK);
@@ -37,7 +37,7 @@ static int clk_mt6779_mfg_probe(struct platform_device *pdev)
 	mtk_clk_register_gates(node, mfg_clks, ARRAY_SIZE(mfg_clks),
 			       clk_data);
 
-	return of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
+	return of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 }
 
 static const struct of_device_id of_match_clk_mt6779_mfg[] = {
diff --git a/drivers/clk/mediatek/clk-mt6779-mm.c b/drivers/clk/mediatek/clk-mt6779-mm.c
index 33946e647122..eda8cbee3d23 100644
--- a/drivers/clk/mediatek/clk-mt6779-mm.c
+++ b/drivers/clk/mediatek/clk-mt6779-mm.c
@@ -89,14 +89,14 @@ static int clk_mt6779_mm_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct device_node *node = dev->parent->of_node;
-	struct clk_onecell_data *clk_data;
+	struct clk_hw_onecell_data *clk_data;
 
 	clk_data = mtk_alloc_clk_data(CLK_MM_NR_CLK);
 
 	mtk_clk_register_gates(node, mm_clks, ARRAY_SIZE(mm_clks),
 			       clk_data);
 
-	return of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
+	return of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 }
 
 static struct platform_driver clk_mt6779_mm_drv = {
diff --git a/drivers/clk/mediatek/clk-mt6779-vdec.c b/drivers/clk/mediatek/clk-mt6779-vdec.c
index f4358844c2e0..7e195b082e86 100644
--- a/drivers/clk/mediatek/clk-mt6779-vdec.c
+++ b/drivers/clk/mediatek/clk-mt6779-vdec.c
@@ -46,7 +46,7 @@ static const struct of_device_id of_match_clk_mt6779_vdec[] = {
 
 static int clk_mt6779_vdec_probe(struct platform_device *pdev)
 {
-	struct clk_onecell_data *clk_data;
+	struct clk_hw_onecell_data *clk_data;
 	struct device_node *node = pdev->dev.of_node;
 
 	clk_data = mtk_alloc_clk_data(CLK_VDEC_GCON_NR_CLK);
@@ -54,7 +54,7 @@ static int clk_mt6779_vdec_probe(struct platform_device *pdev)
 	mtk_clk_register_gates(node, vdec_clks, ARRAY_SIZE(vdec_clks),
 			       clk_data);
 
-	return of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
+	return of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 }
 
 static struct platform_driver clk_mt6779_vdec_drv = {
diff --git a/drivers/clk/mediatek/clk-mt6779-venc.c b/drivers/clk/mediatek/clk-mt6779-venc.c
index ff67084af5aa..573efa87c9bd 100644
--- a/drivers/clk/mediatek/clk-mt6779-venc.c
+++ b/drivers/clk/mediatek/clk-mt6779-venc.c
@@ -37,7 +37,7 @@ static const struct of_device_id of_match_clk_mt6779_venc[] = {
 
 static int clk_mt6779_venc_probe(struct platform_device *pdev)
 {
-	struct clk_onecell_data *clk_data;
+	struct clk_hw_onecell_data *clk_data;
 	struct device_node *node = pdev->dev.of_node;
 
 	clk_data = mtk_alloc_clk_data(CLK_VENC_GCON_NR_CLK);
@@ -45,7 +45,7 @@ static int clk_mt6779_venc_probe(struct platform_device *pdev)
 	mtk_clk_register_gates(node, venc_clks, ARRAY_SIZE(venc_clks),
 			       clk_data);
 
-	return of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
+	return of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 }
 
 static struct platform_driver clk_mt6779_venc_drv = {
diff --git a/drivers/clk/mediatek/clk-mt6779.c b/drivers/clk/mediatek/clk-mt6779.c
index 7b61664da18f..a2246d62e491 100644
--- a/drivers/clk/mediatek/clk-mt6779.c
+++ b/drivers/clk/mediatek/clk-mt6779.c
@@ -1214,7 +1214,7 @@ static const struct mtk_pll_data plls[] = {
 
 static int clk_mt6779_apmixed_probe(struct platform_device *pdev)
 {
-	struct clk_onecell_data *clk_data;
+	struct clk_hw_onecell_data *clk_data;
 	struct device_node *node = pdev->dev.of_node;
 
 	clk_data = mtk_alloc_clk_data(CLK_APMIXED_NR_CLK);
@@ -1224,13 +1224,13 @@ static int clk_mt6779_apmixed_probe(struct platform_device *pdev)
 	mtk_clk_register_gates(node, apmixed_clks,
 			       ARRAY_SIZE(apmixed_clks), clk_data);
 
-	return of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
+	return of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 }
 
 static int clk_mt6779_top_probe(struct platform_device *pdev)
 {
 	void __iomem *base;
-	struct clk_onecell_data *clk_data;
+	struct clk_hw_onecell_data *clk_data;
 	struct device_node *node = pdev->dev.of_node;
 
 	base = devm_platform_ioremap_resource(pdev, 0);
@@ -1253,12 +1253,12 @@ static int clk_mt6779_top_probe(struct platform_device *pdev)
 	mtk_clk_register_composites(top_aud_divs, ARRAY_SIZE(top_aud_divs),
 				    base, &mt6779_clk_lock, clk_data);
 
-	return of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
+	return of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 }
 
 static int clk_mt6779_infra_probe(struct platform_device *pdev)
 {
-	struct clk_onecell_data *clk_data;
+	struct clk_hw_onecell_data *clk_data;
 	struct device_node *node = pdev->dev.of_node;
 
 	clk_data = mtk_alloc_clk_data(CLK_INFRA_NR_CLK);
@@ -1266,7 +1266,7 @@ static int clk_mt6779_infra_probe(struct platform_device *pdev)
 	mtk_clk_register_gates(node, infra_clks, ARRAY_SIZE(infra_clks),
 			       clk_data);
 
-	return of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
+	return of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 }
 
 static const struct of_device_id of_match_clk_mt6779[] = {
diff --git a/drivers/clk/mediatek/clk-mt6797-img.c b/drivers/clk/mediatek/clk-mt6797-img.c
index 908bf9784f03..25d17db13bac 100644
--- a/drivers/clk/mediatek/clk-mt6797-img.c
+++ b/drivers/clk/mediatek/clk-mt6797-img.c
@@ -39,7 +39,7 @@ static const struct of_device_id of_match_clk_mt6797_img[] = {
 
 static int clk_mt6797_img_probe(struct platform_device *pdev)
 {
-	struct clk_onecell_data *clk_data;
+	struct clk_hw_onecell_data *clk_data;
 	int r;
 	struct device_node *node = pdev->dev.of_node;
 
@@ -48,7 +48,7 @@ static int clk_mt6797_img_probe(struct platform_device *pdev)
 	mtk_clk_register_gates(node, img_clks, ARRAY_SIZE(img_clks),
 			       clk_data);
 
-	r = of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
+	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 	if (r)
 		dev_err(&pdev->dev,
 			"could not register clock provider: %s: %d\n",
diff --git a/drivers/clk/mediatek/clk-mt6797-mm.c b/drivers/clk/mediatek/clk-mt6797-mm.c
index 01fdce287247..0846011fc894 100644
--- a/drivers/clk/mediatek/clk-mt6797-mm.c
+++ b/drivers/clk/mediatek/clk-mt6797-mm.c
@@ -96,7 +96,7 @@ static int clk_mt6797_mm_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct device_node *node = dev->parent->of_node;
-	struct clk_onecell_data *clk_data;
+	struct clk_hw_onecell_data *clk_data;
 	int r;
 
 	clk_data = mtk_alloc_clk_data(CLK_MM_NR);
@@ -104,7 +104,7 @@ static int clk_mt6797_mm_probe(struct platform_device *pdev)
 	mtk_clk_register_gates(node, mm_clks, ARRAY_SIZE(mm_clks),
 			       clk_data);
 
-	r = of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
+	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 	if (r)
 		dev_err(&pdev->dev,
 			"could not register clock provider: %s: %d\n",
diff --git a/drivers/clk/mediatek/clk-mt6797-vdec.c b/drivers/clk/mediatek/clk-mt6797-vdec.c
index bbbc8119c3af..de857894e033 100644
--- a/drivers/clk/mediatek/clk-mt6797-vdec.c
+++ b/drivers/clk/mediatek/clk-mt6797-vdec.c
@@ -56,7 +56,7 @@ static const struct of_device_id of_match_clk_mt6797_vdec[] = {
 
 static int clk_mt6797_vdec_probe(struct platform_device *pdev)
 {
-	struct clk_onecell_data *clk_data;
+	struct clk_hw_onecell_data *clk_data;
 	int r;
 	struct device_node *node = pdev->dev.of_node;
 
@@ -65,7 +65,7 @@ static int clk_mt6797_vdec_probe(struct platform_device *pdev)
 	mtk_clk_register_gates(node, vdec_clks, ARRAY_SIZE(vdec_clks),
 			       clk_data);
 
-	r = of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
+	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 	if (r)
 		dev_err(&pdev->dev,
 			"could not register clock provider: %s: %d\n",
diff --git a/drivers/clk/mediatek/clk-mt6797-venc.c b/drivers/clk/mediatek/clk-mt6797-venc.c
index 2c75f0cbfb51..78b7ed55f979 100644
--- a/drivers/clk/mediatek/clk-mt6797-venc.c
+++ b/drivers/clk/mediatek/clk-mt6797-venc.c
@@ -41,7 +41,7 @@ static const struct of_device_id of_match_clk_mt6797_venc[] = {
 
 static int clk_mt6797_venc_probe(struct platform_device *pdev)
 {
-	struct clk_onecell_data *clk_data;
+	struct clk_hw_onecell_data *clk_data;
 	int r;
 	struct device_node *node = pdev->dev.of_node;
 
@@ -50,7 +50,7 @@ static int clk_mt6797_venc_probe(struct platform_device *pdev)
 	mtk_clk_register_gates(node, venc_clks, ARRAY_SIZE(venc_clks),
 			       clk_data);
 
-	r = of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
+	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 	if (r)
 		dev_err(&pdev->dev,
 			"could not register clock provider: %s: %d\n",
diff --git a/drivers/clk/mediatek/clk-mt6797.c b/drivers/clk/mediatek/clk-mt6797.c
index 02259e81625a..6cb720926e37 100644
--- a/drivers/clk/mediatek/clk-mt6797.c
+++ b/drivers/clk/mediatek/clk-mt6797.c
@@ -383,7 +383,7 @@ static const struct mtk_composite top_muxes[] = {
 
 static int mtk_topckgen_init(struct platform_device *pdev)
 {
-	struct clk_onecell_data *clk_data;
+	struct clk_hw_onecell_data *clk_data;
 	void __iomem *base;
 	struct device_node *node = pdev->dev.of_node;
 
@@ -399,7 +399,7 @@ static int mtk_topckgen_init(struct platform_device *pdev)
 	mtk_clk_register_composites(top_muxes, ARRAY_SIZE(top_muxes), base,
 				    &mt6797_clk_lock, clk_data);
 
-	return of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
+	return of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 }
 
 static const struct mtk_gate_regs infra0_cg_regs = {
@@ -556,7 +556,7 @@ static const struct mtk_fixed_factor infra_fixed_divs[] = {
 	FACTOR(CLK_INFRA_13M, "clk13m", "clk26m", 1, 2),
 };
 
-static struct clk_onecell_data *infra_clk_data;
+static struct clk_hw_onecell_data *infra_clk_data;
 
 static void mtk_infrasys_init_early(struct device_node *node)
 {
@@ -566,13 +566,14 @@ static void mtk_infrasys_init_early(struct device_node *node)
 		infra_clk_data = mtk_alloc_clk_data(CLK_INFRA_NR);
 
 		for (i = 0; i < CLK_INFRA_NR; i++)
-			infra_clk_data->clks[i] = ERR_PTR(-EPROBE_DEFER);
+			infra_clk_data->hws[i] = ERR_PTR(-EPROBE_DEFER);
 	}
 
 	mtk_clk_register_factors(infra_fixed_divs, ARRAY_SIZE(infra_fixed_divs),
 				 infra_clk_data);
 
-	r = of_clk_add_provider(node, of_clk_src_onecell_get, infra_clk_data);
+	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get,
+				   infra_clk_data);
 	if (r)
 		pr_err("%s(): could not register clock provider: %d\n",
 		       __func__, r);
@@ -590,8 +591,8 @@ static int mtk_infrasys_init(struct platform_device *pdev)
 		infra_clk_data = mtk_alloc_clk_data(CLK_INFRA_NR);
 	} else {
 		for (i = 0; i < CLK_INFRA_NR; i++) {
-			if (infra_clk_data->clks[i] == ERR_PTR(-EPROBE_DEFER))
-				infra_clk_data->clks[i] = ERR_PTR(-ENOENT);
+			if (infra_clk_data->hws[i] == ERR_PTR(-EPROBE_DEFER))
+				infra_clk_data->hws[i] = ERR_PTR(-ENOENT);
 		}
 	}
 
@@ -600,7 +601,8 @@ static int mtk_infrasys_init(struct platform_device *pdev)
 	mtk_clk_register_factors(infra_fixed_divs, ARRAY_SIZE(infra_fixed_divs),
 				 infra_clk_data);
 
-	return of_clk_add_provider(node, of_clk_src_onecell_get, infra_clk_data);
+	return of_clk_add_hw_provider(node, of_clk_hw_onecell_get,
+				      infra_clk_data);
 }
 
 #define MT6797_PLL_FMAX		(3000UL * MHZ)
@@ -659,7 +661,7 @@ static const struct mtk_pll_data plls[] = {
 
 static int mtk_apmixedsys_init(struct platform_device *pdev)
 {
-	struct clk_onecell_data *clk_data;
+	struct clk_hw_onecell_data *clk_data;
 	struct device_node *node = pdev->dev.of_node;
 
 	clk_data = mtk_alloc_clk_data(CLK_APMIXED_NR);
@@ -668,7 +670,7 @@ static int mtk_apmixedsys_init(struct platform_device *pdev)
 
 	mtk_clk_register_plls(node, plls, ARRAY_SIZE(plls), clk_data);
 
-	return of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
+	return of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 }
 
 static const struct of_device_id of_match_clk_mt6797[] = {
diff --git a/drivers/clk/mediatek/clk-mt7622-aud.c b/drivers/clk/mediatek/clk-mt7622-aud.c
index 2bd4295bc36b..9f2e5aa7b5d9 100644
--- a/drivers/clk/mediatek/clk-mt7622-aud.c
+++ b/drivers/clk/mediatek/clk-mt7622-aud.c
@@ -132,7 +132,7 @@ static const struct mtk_gate audio_clks[] = {
 
 static int clk_mt7622_audiosys_init(struct platform_device *pdev)
 {
-	struct clk_onecell_data *clk_data;
+	struct clk_hw_onecell_data *clk_data;
 	struct device_node *node = pdev->dev.of_node;
 	int r;
 
@@ -141,7 +141,7 @@ static int clk_mt7622_audiosys_init(struct platform_device *pdev)
 	mtk_clk_register_gates(node, audio_clks, ARRAY_SIZE(audio_clks),
 			       clk_data);
 
-	r = of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
+	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 	if (r) {
 		dev_err(&pdev->dev,
 			"could not register clock provider: %s: %d\n",
diff --git a/drivers/clk/mediatek/clk-mt7622-eth.c b/drivers/clk/mediatek/clk-mt7622-eth.c
index c9947dc7ba5a..b12d48705496 100644
--- a/drivers/clk/mediatek/clk-mt7622-eth.c
+++ b/drivers/clk/mediatek/clk-mt7622-eth.c
@@ -67,7 +67,7 @@ static const struct mtk_gate sgmii_clks[] = {
 
 static int clk_mt7622_ethsys_init(struct platform_device *pdev)
 {
-	struct clk_onecell_data *clk_data;
+	struct clk_hw_onecell_data *clk_data;
 	struct device_node *node = pdev->dev.of_node;
 	int r;
 
@@ -76,7 +76,7 @@ static int clk_mt7622_ethsys_init(struct platform_device *pdev)
 	mtk_clk_register_gates(node, eth_clks, ARRAY_SIZE(eth_clks),
 			       clk_data);
 
-	r = of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
+	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 	if (r)
 		dev_err(&pdev->dev,
 			"could not register clock provider: %s: %d\n",
@@ -89,7 +89,7 @@ static int clk_mt7622_ethsys_init(struct platform_device *pdev)
 
 static int clk_mt7622_sgmiisys_init(struct platform_device *pdev)
 {
-	struct clk_onecell_data *clk_data;
+	struct clk_hw_onecell_data *clk_data;
 	struct device_node *node = pdev->dev.of_node;
 	int r;
 
@@ -98,7 +98,7 @@ static int clk_mt7622_sgmiisys_init(struct platform_device *pdev)
 	mtk_clk_register_gates(node, sgmii_clks, ARRAY_SIZE(sgmii_clks),
 			       clk_data);
 
-	r = of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
+	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 	if (r)
 		dev_err(&pdev->dev,
 			"could not register clock provider: %s: %d\n",
diff --git a/drivers/clk/mediatek/clk-mt7622-hif.c b/drivers/clk/mediatek/clk-mt7622-hif.c
index 628be0c9f888..58728e35e80a 100644
--- a/drivers/clk/mediatek/clk-mt7622-hif.c
+++ b/drivers/clk/mediatek/clk-mt7622-hif.c
@@ -78,7 +78,7 @@ static const struct mtk_gate pcie_clks[] = {
 
 static int clk_mt7622_ssusbsys_init(struct platform_device *pdev)
 {
-	struct clk_onecell_data *clk_data;
+	struct clk_hw_onecell_data *clk_data;
 	struct device_node *node = pdev->dev.of_node;
 	int r;
 
@@ -87,7 +87,7 @@ static int clk_mt7622_ssusbsys_init(struct platform_device *pdev)
 	mtk_clk_register_gates(node, ssusb_clks, ARRAY_SIZE(ssusb_clks),
 			       clk_data);
 
-	r = of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
+	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 	if (r)
 		dev_err(&pdev->dev,
 			"could not register clock provider: %s: %d\n",
@@ -100,7 +100,7 @@ static int clk_mt7622_ssusbsys_init(struct platform_device *pdev)
 
 static int clk_mt7622_pciesys_init(struct platform_device *pdev)
 {
-	struct clk_onecell_data *clk_data;
+	struct clk_hw_onecell_data *clk_data;
 	struct device_node *node = pdev->dev.of_node;
 	int r;
 
@@ -109,7 +109,7 @@ static int clk_mt7622_pciesys_init(struct platform_device *pdev)
 	mtk_clk_register_gates(node, pcie_clks, ARRAY_SIZE(pcie_clks),
 			       clk_data);
 
-	r = of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
+	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 	if (r)
 		dev_err(&pdev->dev,
 			"could not register clock provider: %s: %d\n",
diff --git a/drivers/clk/mediatek/clk-mt7622.c b/drivers/clk/mediatek/clk-mt7622.c
index 0e1fb30a1e98..a110ee2b5ea6 100644
--- a/drivers/clk/mediatek/clk-mt7622.c
+++ b/drivers/clk/mediatek/clk-mt7622.c
@@ -612,7 +612,7 @@ static struct mtk_composite peri_muxes[] = {
 
 static int mtk_topckgen_init(struct platform_device *pdev)
 {
-	struct clk_onecell_data *clk_data;
+	struct clk_hw_onecell_data *clk_data;
 	void __iomem *base;
 	struct device_node *node = pdev->dev.of_node;
 
@@ -637,17 +637,17 @@ static int mtk_topckgen_init(struct platform_device *pdev)
 	mtk_clk_register_gates(node, top_clks, ARRAY_SIZE(top_clks),
 			       clk_data);
 
-	clk_prepare_enable(clk_data->clks[CLK_TOP_AXI_SEL]);
-	clk_prepare_enable(clk_data->clks[CLK_TOP_MEM_SEL]);
-	clk_prepare_enable(clk_data->clks[CLK_TOP_DDRPHYCFG_SEL]);
+	clk_prepare_enable(clk_data->hws[CLK_TOP_AXI_SEL]->clk);
+	clk_prepare_enable(clk_data->hws[CLK_TOP_MEM_SEL]->clk);
+	clk_prepare_enable(clk_data->hws[CLK_TOP_DDRPHYCFG_SEL]->clk);
 
-	return of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
+	return of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 }
 
 static int mtk_infrasys_init(struct platform_device *pdev)
 {
 	struct device_node *node = pdev->dev.of_node;
-	struct clk_onecell_data *clk_data;
+	struct clk_hw_onecell_data *clk_data;
 	int r;
 
 	clk_data = mtk_alloc_clk_data(CLK_INFRA_NR_CLK);
@@ -658,8 +658,8 @@ static int mtk_infrasys_init(struct platform_device *pdev)
 	mtk_clk_register_cpumuxes(node, infra_muxes, ARRAY_SIZE(infra_muxes),
 				  clk_data);
 
-	r = of_clk_add_provider(node, of_clk_src_onecell_get,
-				clk_data);
+	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get,
+				   clk_data);
 	if (r)
 		return r;
 
@@ -670,7 +670,7 @@ static int mtk_infrasys_init(struct platform_device *pdev)
 
 static int mtk_apmixedsys_init(struct platform_device *pdev)
 {
-	struct clk_onecell_data *clk_data;
+	struct clk_hw_onecell_data *clk_data;
 	struct device_node *node = pdev->dev.of_node;
 
 	clk_data = mtk_alloc_clk_data(CLK_APMIXED_NR_CLK);
@@ -683,15 +683,15 @@ static int mtk_apmixedsys_init(struct platform_device *pdev)
 	mtk_clk_register_gates(node, apmixed_clks,
 			       ARRAY_SIZE(apmixed_clks), clk_data);
 
-	clk_prepare_enable(clk_data->clks[CLK_APMIXED_ARMPLL]);
-	clk_prepare_enable(clk_data->clks[CLK_APMIXED_MAIN_CORE_EN]);
+	clk_prepare_enable(clk_data->hws[CLK_APMIXED_ARMPLL]->clk);
+	clk_prepare_enable(clk_data->hws[CLK_APMIXED_MAIN_CORE_EN]->clk);
 
-	return of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
+	return of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 }
 
 static int mtk_pericfg_init(struct platform_device *pdev)
 {
-	struct clk_onecell_data *clk_data;
+	struct clk_hw_onecell_data *clk_data;
 	void __iomem *base;
 	int r;
 	struct device_node *node = pdev->dev.of_node;
@@ -708,11 +708,11 @@ static int mtk_pericfg_init(struct platform_device *pdev)
 	mtk_clk_register_composites(peri_muxes, ARRAY_SIZE(peri_muxes), base,
 				    &mt7622_clk_lock, clk_data);
 
-	r = of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
+	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 	if (r)
 		return r;
 
-	clk_prepare_enable(clk_data->clks[CLK_PERI_UART0_PD]);
+	clk_prepare_enable(clk_data->hws[CLK_PERI_UART0_PD]->clk);
 
 	mtk_register_reset_controller(node, 2, 0x0);
 
diff --git a/drivers/clk/mediatek/clk-mt7629-eth.c b/drivers/clk/mediatek/clk-mt7629-eth.c
index 88279d0ea1a7..c49fd732c9b2 100644
--- a/drivers/clk/mediatek/clk-mt7629-eth.c
+++ b/drivers/clk/mediatek/clk-mt7629-eth.c
@@ -78,7 +78,7 @@ static const struct mtk_gate sgmii_clks[2][4] = {
 
 static int clk_mt7629_ethsys_init(struct platform_device *pdev)
 {
-	struct clk_onecell_data *clk_data;
+	struct clk_hw_onecell_data *clk_data;
 	struct device_node *node = pdev->dev.of_node;
 	int r;
 
@@ -86,7 +86,7 @@ static int clk_mt7629_ethsys_init(struct platform_device *pdev)
 
 	mtk_clk_register_gates(node, eth_clks, CLK_ETH_NR_CLK, clk_data);
 
-	r = of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
+	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 	if (r)
 		dev_err(&pdev->dev,
 			"could not register clock provider: %s: %d\n",
@@ -99,7 +99,7 @@ static int clk_mt7629_ethsys_init(struct platform_device *pdev)
 
 static int clk_mt7629_sgmiisys_init(struct platform_device *pdev)
 {
-	struct clk_onecell_data *clk_data;
+	struct clk_hw_onecell_data *clk_data;
 	struct device_node *node = pdev->dev.of_node;
 	static int id;
 	int r;
@@ -109,7 +109,7 @@ static int clk_mt7629_sgmiisys_init(struct platform_device *pdev)
 	mtk_clk_register_gates(node, sgmii_clks[id++], CLK_SGMII_NR_CLK,
 			       clk_data);
 
-	r = of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
+	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 	if (r)
 		dev_err(&pdev->dev,
 			"could not register clock provider: %s: %d\n",
diff --git a/drivers/clk/mediatek/clk-mt7629-hif.c b/drivers/clk/mediatek/clk-mt7629-hif.c
index 5c5b37207afb..acaa97fda331 100644
--- a/drivers/clk/mediatek/clk-mt7629-hif.c
+++ b/drivers/clk/mediatek/clk-mt7629-hif.c
@@ -73,7 +73,7 @@ static const struct mtk_gate pcie_clks[] = {
 
 static int clk_mt7629_ssusbsys_init(struct platform_device *pdev)
 {
-	struct clk_onecell_data *clk_data;
+	struct clk_hw_onecell_data *clk_data;
 	struct device_node *node = pdev->dev.of_node;
 	int r;
 
@@ -82,7 +82,7 @@ static int clk_mt7629_ssusbsys_init(struct platform_device *pdev)
 	mtk_clk_register_gates(node, ssusb_clks, ARRAY_SIZE(ssusb_clks),
 			       clk_data);
 
-	r = of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
+	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 	if (r)
 		dev_err(&pdev->dev,
 			"could not register clock provider: %s: %d\n",
@@ -95,7 +95,7 @@ static int clk_mt7629_ssusbsys_init(struct platform_device *pdev)
 
 static int clk_mt7629_pciesys_init(struct platform_device *pdev)
 {
-	struct clk_onecell_data *clk_data;
+	struct clk_hw_onecell_data *clk_data;
 	struct device_node *node = pdev->dev.of_node;
 	int r;
 
@@ -104,7 +104,7 @@ static int clk_mt7629_pciesys_init(struct platform_device *pdev)
 	mtk_clk_register_gates(node, pcie_clks, ARRAY_SIZE(pcie_clks),
 			       clk_data);
 
-	r = of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
+	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 	if (r)
 		dev_err(&pdev->dev,
 			"could not register clock provider: %s: %d\n",
diff --git a/drivers/clk/mediatek/clk-mt7629.c b/drivers/clk/mediatek/clk-mt7629.c
index c0e023bf31eb..118a5af38dd9 100644
--- a/drivers/clk/mediatek/clk-mt7629.c
+++ b/drivers/clk/mediatek/clk-mt7629.c
@@ -572,7 +572,7 @@ static struct mtk_composite peri_muxes[] = {
 
 static int mtk_topckgen_init(struct platform_device *pdev)
 {
-	struct clk_onecell_data *clk_data;
+	struct clk_hw_onecell_data *clk_data;
 	void __iomem *base;
 	struct device_node *node = pdev->dev.of_node;
 
@@ -591,17 +591,17 @@ static int mtk_topckgen_init(struct platform_device *pdev)
 	mtk_clk_register_composites(top_muxes, ARRAY_SIZE(top_muxes),
 				    base, &mt7629_clk_lock, clk_data);
 
-	clk_prepare_enable(clk_data->clks[CLK_TOP_AXI_SEL]);
-	clk_prepare_enable(clk_data->clks[CLK_TOP_MEM_SEL]);
-	clk_prepare_enable(clk_data->clks[CLK_TOP_DDRPHYCFG_SEL]);
+	clk_prepare_enable(clk_data->hws[CLK_TOP_AXI_SEL]->clk);
+	clk_prepare_enable(clk_data->hws[CLK_TOP_MEM_SEL]->clk);
+	clk_prepare_enable(clk_data->hws[CLK_TOP_DDRPHYCFG_SEL]->clk);
 
-	return of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
+	return of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 }
 
 static int mtk_infrasys_init(struct platform_device *pdev)
 {
 	struct device_node *node = pdev->dev.of_node;
-	struct clk_onecell_data *clk_data;
+	struct clk_hw_onecell_data *clk_data;
 
 	clk_data = mtk_alloc_clk_data(CLK_INFRA_NR_CLK);
 
@@ -611,13 +611,13 @@ static int mtk_infrasys_init(struct platform_device *pdev)
 	mtk_clk_register_cpumuxes(node, infra_muxes, ARRAY_SIZE(infra_muxes),
 				  clk_data);
 
-	return of_clk_add_provider(node, of_clk_src_onecell_get,
-				   clk_data);
+	return of_clk_add_hw_provider(node, of_clk_hw_onecell_get,
+				      clk_data);
 }
 
 static int mtk_pericfg_init(struct platform_device *pdev)
 {
-	struct clk_onecell_data *clk_data;
+	struct clk_hw_onecell_data *clk_data;
 	void __iomem *base;
 	int r;
 	struct device_node *node = pdev->dev.of_node;
@@ -634,18 +634,18 @@ static int mtk_pericfg_init(struct platform_device *pdev)
 	mtk_clk_register_composites(peri_muxes, ARRAY_SIZE(peri_muxes), base,
 				    &mt7629_clk_lock, clk_data);
 
-	r = of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
+	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 	if (r)
 		return r;
 
-	clk_prepare_enable(clk_data->clks[CLK_PERI_UART0_PD]);
+	clk_prepare_enable(clk_data->hws[CLK_PERI_UART0_PD]->clk);
 
 	return 0;
 }
 
 static int mtk_apmixedsys_init(struct platform_device *pdev)
 {
-	struct clk_onecell_data *clk_data;
+	struct clk_hw_onecell_data *clk_data;
 	struct device_node *node = pdev->dev.of_node;
 
 	clk_data = mtk_alloc_clk_data(CLK_APMIXED_NR_CLK);
@@ -658,10 +658,10 @@ static int mtk_apmixedsys_init(struct platform_device *pdev)
 	mtk_clk_register_gates(node, apmixed_clks,
 			       ARRAY_SIZE(apmixed_clks), clk_data);
 
-	clk_prepare_enable(clk_data->clks[CLK_APMIXED_ARMPLL]);
-	clk_prepare_enable(clk_data->clks[CLK_APMIXED_MAIN_CORE_EN]);
+	clk_prepare_enable(clk_data->hws[CLK_APMIXED_ARMPLL]->clk);
+	clk_prepare_enable(clk_data->hws[CLK_APMIXED_MAIN_CORE_EN]->clk);
 
-	return of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
+	return of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 }
 
 
diff --git a/drivers/clk/mediatek/clk-mt7986-apmixed.c b/drivers/clk/mediatek/clk-mt7986-apmixed.c
index 21d4c82e782a..1f4266841f29 100644
--- a/drivers/clk/mediatek/clk-mt7986-apmixed.c
+++ b/drivers/clk/mediatek/clk-mt7986-apmixed.c
@@ -67,7 +67,7 @@ static const struct of_device_id of_match_clk_mt7986_apmixed[] = {
 
 static int clk_mt7986_apmixed_probe(struct platform_device *pdev)
 {
-	struct clk_onecell_data *clk_data;
+	struct clk_hw_onecell_data *clk_data;
 	struct device_node *node = pdev->dev.of_node;
 	int r;
 
@@ -77,9 +77,9 @@ static int clk_mt7986_apmixed_probe(struct platform_device *pdev)
 
 	mtk_clk_register_plls(node, plls, ARRAY_SIZE(plls), clk_data);
 
-	clk_prepare_enable(clk_data->clks[CLK_APMIXED_ARMPLL]);
+	clk_prepare_enable(clk_data->hws[CLK_APMIXED_ARMPLL]->clk);
 
-	r = of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
+	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 	if (r) {
 		pr_err("%s(): could not register clock provider: %d\n",
 		       __func__, r);
diff --git a/drivers/clk/mediatek/clk-mt7986-eth.c b/drivers/clk/mediatek/clk-mt7986-eth.c
index 495d023ccad7..6aea4d76478a 100644
--- a/drivers/clk/mediatek/clk-mt7986-eth.c
+++ b/drivers/clk/mediatek/clk-mt7986-eth.c
@@ -79,7 +79,7 @@ static const struct mtk_gate eth_clks[] __initconst = {
 
 static void __init mtk_sgmiisys_0_init(struct device_node *node)
 {
-	struct clk_onecell_data *clk_data;
+	struct clk_hw_onecell_data *clk_data;
 	int r;
 
 	clk_data = mtk_alloc_clk_data(ARRAY_SIZE(sgmii0_clks));
@@ -87,7 +87,7 @@ static void __init mtk_sgmiisys_0_init(struct device_node *node)
 	mtk_clk_register_gates(node, sgmii0_clks, ARRAY_SIZE(sgmii0_clks),
 			       clk_data);
 
-	r = of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
+	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 	if (r)
 		pr_err("%s(): could not register clock provider: %d\n",
 		       __func__, r);
@@ -97,7 +97,7 @@ CLK_OF_DECLARE(mtk_sgmiisys_0, "mediatek,mt7986-sgmiisys_0",
 
 static void __init mtk_sgmiisys_1_init(struct device_node *node)
 {
-	struct clk_onecell_data *clk_data;
+	struct clk_hw_onecell_data *clk_data;
 	int r;
 
 	clk_data = mtk_alloc_clk_data(ARRAY_SIZE(sgmii1_clks));
@@ -105,7 +105,7 @@ static void __init mtk_sgmiisys_1_init(struct device_node *node)
 	mtk_clk_register_gates(node, sgmii1_clks, ARRAY_SIZE(sgmii1_clks),
 			       clk_data);
 
-	r = of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
+	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 
 	if (r)
 		pr_err("%s(): could not register clock provider: %d\n",
@@ -116,14 +116,14 @@ CLK_OF_DECLARE(mtk_sgmiisys_1, "mediatek,mt7986-sgmiisys_1",
 
 static void __init mtk_ethsys_init(struct device_node *node)
 {
-	struct clk_onecell_data *clk_data;
+	struct clk_hw_onecell_data *clk_data;
 	int r;
 
 	clk_data = mtk_alloc_clk_data(ARRAY_SIZE(eth_clks));
 
 	mtk_clk_register_gates(node, eth_clks, ARRAY_SIZE(eth_clks), clk_data);
 
-	r = of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
+	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 
 	if (r)
 		pr_err("%s(): could not register clock provider: %d\n",
diff --git a/drivers/clk/mediatek/clk-mt7986-infracfg.c b/drivers/clk/mediatek/clk-mt7986-infracfg.c
index f209c559fbc3..d90727a53283 100644
--- a/drivers/clk/mediatek/clk-mt7986-infracfg.c
+++ b/drivers/clk/mediatek/clk-mt7986-infracfg.c
@@ -171,7 +171,7 @@ static const struct mtk_gate infra_clks[] = {
 
 static int clk_mt7986_infracfg_probe(struct platform_device *pdev)
 {
-	struct clk_onecell_data *clk_data;
+	struct clk_hw_onecell_data *clk_data;
 	struct device_node *node = pdev->dev.of_node;
 	int r;
 	void __iomem *base;
@@ -195,7 +195,7 @@ static int clk_mt7986_infracfg_probe(struct platform_device *pdev)
 	mtk_clk_register_gates(node, infra_clks, ARRAY_SIZE(infra_clks),
 			       clk_data);
 
-	r = of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
+	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 	if (r) {
 		pr_err("%s(): could not register clock provider: %d\n",
 		       __func__, r);
diff --git a/drivers/clk/mediatek/clk-mt7986-topckgen.c b/drivers/clk/mediatek/clk-mt7986-topckgen.c
index 8f6f79b6e31e..de5121cf2877 100644
--- a/drivers/clk/mediatek/clk-mt7986-topckgen.c
+++ b/drivers/clk/mediatek/clk-mt7986-topckgen.c
@@ -283,7 +283,7 @@ static const struct mtk_mux top_muxes[] = {
 
 static int clk_mt7986_topckgen_probe(struct platform_device *pdev)
 {
-	struct clk_onecell_data *clk_data;
+	struct clk_hw_onecell_data *clk_data;
 	struct device_node *node = pdev->dev.of_node;
 	int r;
 	void __iomem *base;
@@ -306,14 +306,14 @@ static int clk_mt7986_topckgen_probe(struct platform_device *pdev)
 	mtk_clk_register_muxes(top_muxes, ARRAY_SIZE(top_muxes), node,
 			       &mt7986_clk_lock, clk_data);
 
-	clk_prepare_enable(clk_data->clks[CLK_TOP_SYSAXI_SEL]);
-	clk_prepare_enable(clk_data->clks[CLK_TOP_SYSAPB_SEL]);
-	clk_prepare_enable(clk_data->clks[CLK_TOP_DRAMC_SEL]);
-	clk_prepare_enable(clk_data->clks[CLK_TOP_DRAMC_MD32_SEL]);
-	clk_prepare_enable(clk_data->clks[CLK_TOP_F26M_SEL]);
-	clk_prepare_enable(clk_data->clks[CLK_TOP_SGM_REG_SEL]);
+	clk_prepare_enable(clk_data->hws[CLK_TOP_SYSAXI_SEL]->clk);
+	clk_prepare_enable(clk_data->hws[CLK_TOP_SYSAPB_SEL]->clk);
+	clk_prepare_enable(clk_data->hws[CLK_TOP_DRAMC_SEL]->clk);
+	clk_prepare_enable(clk_data->hws[CLK_TOP_DRAMC_MD32_SEL]->clk);
+	clk_prepare_enable(clk_data->hws[CLK_TOP_F26M_SEL]->clk);
+	clk_prepare_enable(clk_data->hws[CLK_TOP_SGM_REG_SEL]->clk);
 
-	r = of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
+	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 
 	if (r) {
 		pr_err("%s(): could not register clock provider: %d\n",
diff --git a/drivers/clk/mediatek/clk-mt8135.c b/drivers/clk/mediatek/clk-mt8135.c
index 09ad272d51f1..19827037b6c0 100644
--- a/drivers/clk/mediatek/clk-mt8135.c
+++ b/drivers/clk/mediatek/clk-mt8135.c
@@ -516,7 +516,7 @@ static const struct mtk_composite peri_clks[] __initconst = {
 
 static void __init mtk_topckgen_init(struct device_node *node)
 {
-	struct clk_onecell_data *clk_data;
+	struct clk_hw_onecell_data *clk_data;
 	void __iomem *base;
 	int r;
 
@@ -533,9 +533,9 @@ static void __init mtk_topckgen_init(struct device_node *node)
 	mtk_clk_register_composites(top_muxes, ARRAY_SIZE(top_muxes), base,
 			&mt8135_clk_lock, clk_data);
 
-	clk_prepare_enable(clk_data->clks[CLK_TOP_CCI_SEL]);
+	clk_prepare_enable(clk_data->hws[CLK_TOP_CCI_SEL]->clk);
 
-	r = of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
+	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 	if (r)
 		pr_err("%s(): could not register clock provider: %d\n",
 			__func__, r);
@@ -544,7 +544,7 @@ CLK_OF_DECLARE(mtk_topckgen, "mediatek,mt8135-topckgen", mtk_topckgen_init);
 
 static void __init mtk_infrasys_init(struct device_node *node)
 {
-	struct clk_onecell_data *clk_data;
+	struct clk_hw_onecell_data *clk_data;
 	int r;
 
 	clk_data = mtk_alloc_clk_data(CLK_INFRA_NR_CLK);
@@ -552,9 +552,9 @@ static void __init mtk_infrasys_init(struct device_node *node)
 	mtk_clk_register_gates(node, infra_clks, ARRAY_SIZE(infra_clks),
 						clk_data);
 
-	clk_prepare_enable(clk_data->clks[CLK_INFRA_M4U]);
+	clk_prepare_enable(clk_data->hws[CLK_INFRA_M4U]->clk);
 
-	r = of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
+	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 	if (r)
 		pr_err("%s(): could not register clock provider: %d\n",
 			__func__, r);
@@ -565,7 +565,7 @@ CLK_OF_DECLARE(mtk_infrasys, "mediatek,mt8135-infracfg", mtk_infrasys_init);
 
 static void __init mtk_pericfg_init(struct device_node *node)
 {
-	struct clk_onecell_data *clk_data;
+	struct clk_hw_onecell_data *clk_data;
 	int r;
 	void __iomem *base;
 
@@ -582,7 +582,7 @@ static void __init mtk_pericfg_init(struct device_node *node)
 	mtk_clk_register_composites(peri_clks, ARRAY_SIZE(peri_clks), base,
 			&mt8135_clk_lock, clk_data);
 
-	r = of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
+	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 	if (r)
 		pr_err("%s(): could not register clock provider: %d\n",
 			__func__, r);
@@ -626,7 +626,7 @@ static const struct mtk_pll_data plls[] = {
 
 static void __init mtk_apmixedsys_init(struct device_node *node)
 {
-	struct clk_onecell_data *clk_data;
+	struct clk_hw_onecell_data *clk_data;
 
 	clk_data = mtk_alloc_clk_data(CLK_APMIXED_NR_CLK);
 	if (!clk_data)
diff --git a/drivers/clk/mediatek/clk-mt8167-aud.c b/drivers/clk/mediatek/clk-mt8167-aud.c
index 3f7bf6485792..ce1ae8d243c3 100644
--- a/drivers/clk/mediatek/clk-mt8167-aud.c
+++ b/drivers/clk/mediatek/clk-mt8167-aud.c
@@ -50,14 +50,14 @@ static const struct mtk_gate aud_clks[] __initconst = {
 
 static void __init mtk_audsys_init(struct device_node *node)
 {
-	struct clk_onecell_data *clk_data;
+	struct clk_hw_onecell_data *clk_data;
 	int r;
 
 	clk_data = mtk_alloc_clk_data(CLK_AUD_NR_CLK);
 
 	mtk_clk_register_gates(node, aud_clks, ARRAY_SIZE(aud_clks), clk_data);
 
-	r = of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
+	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 	if (r)
 		pr_err("%s(): could not register clock provider: %d\n",
 			__func__, r);
diff --git a/drivers/clk/mediatek/clk-mt8167-img.c b/drivers/clk/mediatek/clk-mt8167-img.c
index 3b4ec9eae432..e359e563d2b7 100644
--- a/drivers/clk/mediatek/clk-mt8167-img.c
+++ b/drivers/clk/mediatek/clk-mt8167-img.c
@@ -43,14 +43,14 @@ static const struct mtk_gate img_clks[] __initconst = {
 
 static void __init mtk_imgsys_init(struct device_node *node)
 {
-	struct clk_onecell_data *clk_data;
+	struct clk_hw_onecell_data *clk_data;
 	int r;
 
 	clk_data = mtk_alloc_clk_data(CLK_IMG_NR_CLK);
 
 	mtk_clk_register_gates(node, img_clks, ARRAY_SIZE(img_clks), clk_data);
 
-	r = of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
+	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 
 	if (r)
 		pr_err("%s(): could not register clock provider: %d\n",
diff --git a/drivers/clk/mediatek/clk-mt8167-mfgcfg.c b/drivers/clk/mediatek/clk-mt8167-mfgcfg.c
index 90b871730f2d..4fd82fe87d6e 100644
--- a/drivers/clk/mediatek/clk-mt8167-mfgcfg.c
+++ b/drivers/clk/mediatek/clk-mt8167-mfgcfg.c
@@ -41,14 +41,14 @@ static const struct mtk_gate mfg_clks[] __initconst = {
 
 static void __init mtk_mfgcfg_init(struct device_node *node)
 {
-	struct clk_onecell_data *clk_data;
+	struct clk_hw_onecell_data *clk_data;
 	int r;
 
 	clk_data = mtk_alloc_clk_data(CLK_MFG_NR_CLK);
 
 	mtk_clk_register_gates(node, mfg_clks, ARRAY_SIZE(mfg_clks), clk_data);
 
-	r = of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
+	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 
 	if (r)
 		pr_err("%s(): could not register clock provider: %d\n",
diff --git a/drivers/clk/mediatek/clk-mt8167-mm.c b/drivers/clk/mediatek/clk-mt8167-mm.c
index 963b129aade1..73910060577f 100644
--- a/drivers/clk/mediatek/clk-mt8167-mm.c
+++ b/drivers/clk/mediatek/clk-mt8167-mm.c
@@ -101,7 +101,7 @@ static int clk_mt8167_mm_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct device_node *node = dev->parent->of_node;
 	const struct clk_mt8167_mm_driver_data *data;
-	struct clk_onecell_data *clk_data;
+	struct clk_hw_onecell_data *clk_data;
 	int ret;
 
 	clk_data = mtk_alloc_clk_data(CLK_MM_NR_CLK);
@@ -115,7 +115,7 @@ static int clk_mt8167_mm_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	ret = of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
+	ret = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 	if (ret)
 		return ret;
 
diff --git a/drivers/clk/mediatek/clk-mt8167-vdec.c b/drivers/clk/mediatek/clk-mt8167-vdec.c
index 910b28355ec0..ee4fffb6859d 100644
--- a/drivers/clk/mediatek/clk-mt8167-vdec.c
+++ b/drivers/clk/mediatek/clk-mt8167-vdec.c
@@ -56,14 +56,14 @@ static const struct mtk_gate vdec_clks[] __initconst = {
 
 static void __init mtk_vdecsys_init(struct device_node *node)
 {
-	struct clk_onecell_data *clk_data;
+	struct clk_hw_onecell_data *clk_data;
 	int r;
 
 	clk_data = mtk_alloc_clk_data(CLK_VDEC_NR_CLK);
 
 	mtk_clk_register_gates(node, vdec_clks, ARRAY_SIZE(vdec_clks), clk_data);
 
-	r = of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
+	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 
 	if (r)
 		pr_err("%s(): could not register clock provider: %d\n",
diff --git a/drivers/clk/mediatek/clk-mt8167.c b/drivers/clk/mediatek/clk-mt8167.c
index 812b33a57530..ee83bfb015ba 100644
--- a/drivers/clk/mediatek/clk-mt8167.c
+++ b/drivers/clk/mediatek/clk-mt8167.c
@@ -923,7 +923,7 @@ static const struct mtk_gate top_clks[] __initconst = {
 
 static void __init mtk_topckgen_init(struct device_node *node)
 {
-	struct clk_onecell_data *clk_data;
+	struct clk_hw_onecell_data *clk_data;
 	int r;
 	void __iomem *base;
 
@@ -945,7 +945,7 @@ static void __init mtk_topckgen_init(struct device_node *node)
 	mtk_clk_register_dividers(top_adj_divs, ARRAY_SIZE(top_adj_divs),
 				base, &mt8167_clk_lock, clk_data);
 
-	r = of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
+	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 	if (r)
 		pr_err("%s(): could not register clock provider: %d\n",
 			__func__, r);
@@ -954,7 +954,7 @@ CLK_OF_DECLARE(mtk_topckgen, "mediatek,mt8167-topckgen", mtk_topckgen_init);
 
 static void __init mtk_infracfg_init(struct device_node *node)
 {
-	struct clk_onecell_data *clk_data;
+	struct clk_hw_onecell_data *clk_data;
 	int r;
 	void __iomem *base;
 
@@ -969,7 +969,7 @@ static void __init mtk_infracfg_init(struct device_node *node)
 	mtk_clk_register_composites(ifr_muxes, ARRAY_SIZE(ifr_muxes), base,
 		&mt8167_clk_lock, clk_data);
 
-	r = of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
+	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 	if (r)
 		pr_err("%s(): could not register clock provider: %d\n",
 			__func__, r);
@@ -1037,7 +1037,7 @@ static const struct mtk_pll_data plls[] = {
 
 static void __init mtk_apmixedsys_init(struct device_node *node)
 {
-	struct clk_onecell_data *clk_data;
+	struct clk_hw_onecell_data *clk_data;
 	void __iomem *base;
 	int r;
 
@@ -1053,7 +1053,7 @@ static void __init mtk_apmixedsys_init(struct device_node *node)
 	mtk_clk_register_dividers(apmixed_adj_divs, ARRAY_SIZE(apmixed_adj_divs),
 		base, &mt8167_clk_lock, clk_data);
 
-	r = of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
+	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 	if (r)
 		pr_err("%s(): could not register clock provider: %d\n",
 			__func__, r);
diff --git a/drivers/clk/mediatek/clk-mt8173-mm.c b/drivers/clk/mediatek/clk-mt8173-mm.c
index 36fa20be77b6..8abf42c2030c 100644
--- a/drivers/clk/mediatek/clk-mt8173-mm.c
+++ b/drivers/clk/mediatek/clk-mt8173-mm.c
@@ -115,7 +115,7 @@ static int clk_mt8173_mm_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct device_node *node = dev->parent->of_node;
 	const struct clk_mt8173_mm_driver_data *data;
-	struct clk_onecell_data *clk_data;
+	struct clk_hw_onecell_data *clk_data;
 	int ret;
 
 	clk_data = mtk_alloc_clk_data(CLK_MM_NR_CLK);
@@ -129,7 +129,7 @@ static int clk_mt8173_mm_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	ret = of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
+	ret = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 	if (ret)
 		return ret;
 
diff --git a/drivers/clk/mediatek/clk-mt8173.c b/drivers/clk/mediatek/clk-mt8173.c
index 46b7655feeaa..511b4da9e727 100644
--- a/drivers/clk/mediatek/clk-mt8173.c
+++ b/drivers/clk/mediatek/clk-mt8173.c
@@ -819,25 +819,25 @@ static const struct mtk_gate venclt_clks[] __initconst = {
 	GATE_VENCLT(CLK_VENCLT_CKE1, "venclt_cke1", "venclt_sel", 4),
 };
 
-static struct clk_onecell_data *mt8173_top_clk_data __initdata;
-static struct clk_onecell_data *mt8173_pll_clk_data __initdata;
+static struct clk_hw_onecell_data *mt8173_top_clk_data __initdata;
+static struct clk_hw_onecell_data *mt8173_pll_clk_data __initdata;
 
 static void __init mtk_clk_enable_critical(void)
 {
 	if (!mt8173_top_clk_data || !mt8173_pll_clk_data)
 		return;
 
-	clk_prepare_enable(mt8173_pll_clk_data->clks[CLK_APMIXED_ARMCA15PLL]);
-	clk_prepare_enable(mt8173_pll_clk_data->clks[CLK_APMIXED_ARMCA7PLL]);
-	clk_prepare_enable(mt8173_top_clk_data->clks[CLK_TOP_MEM_SEL]);
-	clk_prepare_enable(mt8173_top_clk_data->clks[CLK_TOP_DDRPHYCFG_SEL]);
-	clk_prepare_enable(mt8173_top_clk_data->clks[CLK_TOP_CCI400_SEL]);
-	clk_prepare_enable(mt8173_top_clk_data->clks[CLK_TOP_RTC_SEL]);
+	clk_prepare_enable(mt8173_pll_clk_data->hws[CLK_APMIXED_ARMCA15PLL]->clk);
+	clk_prepare_enable(mt8173_pll_clk_data->hws[CLK_APMIXED_ARMCA7PLL]->clk);
+	clk_prepare_enable(mt8173_top_clk_data->hws[CLK_TOP_MEM_SEL]->clk);
+	clk_prepare_enable(mt8173_top_clk_data->hws[CLK_TOP_DDRPHYCFG_SEL]->clk);
+	clk_prepare_enable(mt8173_top_clk_data->hws[CLK_TOP_CCI400_SEL]->clk);
+	clk_prepare_enable(mt8173_top_clk_data->hws[CLK_TOP_RTC_SEL]->clk);
 }
 
 static void __init mtk_topckgen_init(struct device_node *node)
 {
-	struct clk_onecell_data *clk_data;
+	struct clk_hw_onecell_data *clk_data;
 	void __iomem *base;
 	int r;
 
@@ -854,7 +854,7 @@ static void __init mtk_topckgen_init(struct device_node *node)
 	mtk_clk_register_composites(top_muxes, ARRAY_SIZE(top_muxes), base,
 			&mt8173_clk_lock, clk_data);
 
-	r = of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
+	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 	if (r)
 		pr_err("%s(): could not register clock provider: %d\n",
 			__func__, r);
@@ -865,7 +865,7 @@ CLK_OF_DECLARE(mtk_topckgen, "mediatek,mt8173-topckgen", mtk_topckgen_init);
 
 static void __init mtk_infrasys_init(struct device_node *node)
 {
-	struct clk_onecell_data *clk_data;
+	struct clk_hw_onecell_data *clk_data;
 	int r;
 
 	clk_data = mtk_alloc_clk_data(CLK_INFRA_NR_CLK);
@@ -877,7 +877,7 @@ static void __init mtk_infrasys_init(struct device_node *node)
 	mtk_clk_register_cpumuxes(node, cpu_muxes, ARRAY_SIZE(cpu_muxes),
 				  clk_data);
 
-	r = of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
+	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 	if (r)
 		pr_err("%s(): could not register clock provider: %d\n",
 			__func__, r);
@@ -888,7 +888,7 @@ CLK_OF_DECLARE(mtk_infrasys, "mediatek,mt8173-infracfg", mtk_infrasys_init);
 
 static void __init mtk_pericfg_init(struct device_node *node)
 {
-	struct clk_onecell_data *clk_data;
+	struct clk_hw_onecell_data *clk_data;
 	int r;
 	void __iomem *base;
 
@@ -905,7 +905,7 @@ static void __init mtk_pericfg_init(struct device_node *node)
 	mtk_clk_register_composites(peri_clks, ARRAY_SIZE(peri_clks), base,
 			&mt8173_clk_lock, clk_data);
 
-	r = of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
+	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 	if (r)
 		pr_err("%s(): could not register clock provider: %d\n",
 			__func__, r);
@@ -991,7 +991,7 @@ static const struct mtk_pll_data plls[] = {
 
 static void __init mtk_apmixedsys_init(struct device_node *node)
 {
-	struct clk_onecell_data *clk_data;
+	struct clk_hw_onecell_data *clk_data;
 	void __iomem *base;
 	struct clk *clk;
 	int r, i;
@@ -1022,15 +1022,15 @@ static void __init mtk_apmixedsys_init(struct device_node *node)
 			continue;
 		}
 
-		clk_data->clks[cku->id] = clk;
+		clk_data->hws[cku->id] = __clk_get_hw(clk);
 	}
 
 	clk = clk_register_divider(NULL, "hdmi_ref", "tvdpll_594m", 0,
 				   base + 0x40, 16, 3, CLK_DIVIDER_POWER_OF_TWO,
 				   NULL);
-	clk_data->clks[CLK_APMIXED_HDMI_REF] = clk;
+	clk_data->hws[CLK_APMIXED_HDMI_REF] = __clk_get_hw(clk);
 
-	r = of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
+	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 	if (r)
 		pr_err("%s(): could not register clock provider: %d\n",
 			__func__, r);
@@ -1042,7 +1042,7 @@ CLK_OF_DECLARE(mtk_apmixedsys, "mediatek,mt8173-apmixedsys",
 
 static void __init mtk_imgsys_init(struct device_node *node)
 {
-	struct clk_onecell_data *clk_data;
+	struct clk_hw_onecell_data *clk_data;
 	int r;
 
 	clk_data = mtk_alloc_clk_data(CLK_IMG_NR_CLK);
@@ -1050,7 +1050,7 @@ static void __init mtk_imgsys_init(struct device_node *node)
 	mtk_clk_register_gates(node, img_clks, ARRAY_SIZE(img_clks),
 						clk_data);
 
-	r = of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
+	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 
 	if (r)
 		pr_err("%s(): could not register clock provider: %d\n",
@@ -1060,7 +1060,7 @@ CLK_OF_DECLARE(mtk_imgsys, "mediatek,mt8173-imgsys", mtk_imgsys_init);
 
 static void __init mtk_vdecsys_init(struct device_node *node)
 {
-	struct clk_onecell_data *clk_data;
+	struct clk_hw_onecell_data *clk_data;
 	int r;
 
 	clk_data = mtk_alloc_clk_data(CLK_VDEC_NR_CLK);
@@ -1068,7 +1068,7 @@ static void __init mtk_vdecsys_init(struct device_node *node)
 	mtk_clk_register_gates(node, vdec_clks, ARRAY_SIZE(vdec_clks),
 						clk_data);
 
-	r = of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
+	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 	if (r)
 		pr_err("%s(): could not register clock provider: %d\n",
 			__func__, r);
@@ -1077,7 +1077,7 @@ CLK_OF_DECLARE(mtk_vdecsys, "mediatek,mt8173-vdecsys", mtk_vdecsys_init);
 
 static void __init mtk_vencsys_init(struct device_node *node)
 {
-	struct clk_onecell_data *clk_data;
+	struct clk_hw_onecell_data *clk_data;
 	int r;
 
 	clk_data = mtk_alloc_clk_data(CLK_VENC_NR_CLK);
@@ -1085,7 +1085,7 @@ static void __init mtk_vencsys_init(struct device_node *node)
 	mtk_clk_register_gates(node, venc_clks, ARRAY_SIZE(venc_clks),
 						clk_data);
 
-	r = of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
+	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 	if (r)
 		pr_err("%s(): could not register clock provider: %d\n",
 			__func__, r);
@@ -1094,7 +1094,7 @@ CLK_OF_DECLARE(mtk_vencsys, "mediatek,mt8173-vencsys", mtk_vencsys_init);
 
 static void __init mtk_vencltsys_init(struct device_node *node)
 {
-	struct clk_onecell_data *clk_data;
+	struct clk_hw_onecell_data *clk_data;
 	int r;
 
 	clk_data = mtk_alloc_clk_data(CLK_VENCLT_NR_CLK);
@@ -1102,7 +1102,7 @@ static void __init mtk_vencltsys_init(struct device_node *node)
 	mtk_clk_register_gates(node, venclt_clks, ARRAY_SIZE(venclt_clks),
 						clk_data);
 
-	r = of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
+	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 	if (r)
 		pr_err("%s(): could not register clock provider: %d\n",
 			__func__, r);
diff --git a/drivers/clk/mediatek/clk-mt8183-audio.c b/drivers/clk/mediatek/clk-mt8183-audio.c
index c87450180b7b..b2d7746eddbe 100644
--- a/drivers/clk/mediatek/clk-mt8183-audio.c
+++ b/drivers/clk/mediatek/clk-mt8183-audio.c
@@ -69,7 +69,7 @@ static const struct mtk_gate audio_clks[] = {
 
 static int clk_mt8183_audio_probe(struct platform_device *pdev)
 {
-	struct clk_onecell_data *clk_data;
+	struct clk_hw_onecell_data *clk_data;
 	int r;
 	struct device_node *node = pdev->dev.of_node;
 
@@ -78,7 +78,7 @@ static int clk_mt8183_audio_probe(struct platform_device *pdev)
 	mtk_clk_register_gates(node, audio_clks, ARRAY_SIZE(audio_clks),
 			clk_data);
 
-	r = of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
+	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 	if (r)
 		return r;
 
diff --git a/drivers/clk/mediatek/clk-mt8183-cam.c b/drivers/clk/mediatek/clk-mt8183-cam.c
index 8643802c4471..fcc598a45165 100644
--- a/drivers/clk/mediatek/clk-mt8183-cam.c
+++ b/drivers/clk/mediatek/clk-mt8183-cam.c
@@ -36,7 +36,7 @@ static const struct mtk_gate cam_clks[] = {
 
 static int clk_mt8183_cam_probe(struct platform_device *pdev)
 {
-	struct clk_onecell_data *clk_data;
+	struct clk_hw_onecell_data *clk_data;
 	struct device_node *node = pdev->dev.of_node;
 
 	clk_data = mtk_alloc_clk_data(CLK_CAM_NR_CLK);
@@ -44,7 +44,7 @@ static int clk_mt8183_cam_probe(struct platform_device *pdev)
 	mtk_clk_register_gates(node, cam_clks, ARRAY_SIZE(cam_clks),
 			clk_data);
 
-	return of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
+	return of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 }
 
 static const struct of_device_id of_match_clk_mt8183_cam[] = {
diff --git a/drivers/clk/mediatek/clk-mt8183-img.c b/drivers/clk/mediatek/clk-mt8183-img.c
index 470d676a4a10..eb2def2cf0ae 100644
--- a/drivers/clk/mediatek/clk-mt8183-img.c
+++ b/drivers/clk/mediatek/clk-mt8183-img.c
@@ -36,7 +36,7 @@ static const struct mtk_gate img_clks[] = {
 
 static int clk_mt8183_img_probe(struct platform_device *pdev)
 {
-	struct clk_onecell_data *clk_data;
+	struct clk_hw_onecell_data *clk_data;
 	struct device_node *node = pdev->dev.of_node;
 
 	clk_data = mtk_alloc_clk_data(CLK_IMG_NR_CLK);
@@ -44,7 +44,7 @@ static int clk_mt8183_img_probe(struct platform_device *pdev)
 	mtk_clk_register_gates(node, img_clks, ARRAY_SIZE(img_clks),
 			clk_data);
 
-	return of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
+	return of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 }
 
 static const struct of_device_id of_match_clk_mt8183_img[] = {
diff --git a/drivers/clk/mediatek/clk-mt8183-ipu0.c b/drivers/clk/mediatek/clk-mt8183-ipu0.c
index c5cb76fc9e5e..b30fc9f47518 100644
--- a/drivers/clk/mediatek/clk-mt8183-ipu0.c
+++ b/drivers/clk/mediatek/clk-mt8183-ipu0.c
@@ -29,7 +29,7 @@ static const struct mtk_gate ipu_core0_clks[] = {
 
 static int clk_mt8183_ipu_core0_probe(struct platform_device *pdev)
 {
-	struct clk_onecell_data *clk_data;
+	struct clk_hw_onecell_data *clk_data;
 	struct device_node *node = pdev->dev.of_node;
 
 	clk_data = mtk_alloc_clk_data(CLK_IPU_CORE0_NR_CLK);
@@ -37,7 +37,7 @@ static int clk_mt8183_ipu_core0_probe(struct platform_device *pdev)
 	mtk_clk_register_gates(node, ipu_core0_clks, ARRAY_SIZE(ipu_core0_clks),
 			clk_data);
 
-	return of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
+	return of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 }
 
 static const struct of_device_id of_match_clk_mt8183_ipu_core0[] = {
diff --git a/drivers/clk/mediatek/clk-mt8183-ipu1.c b/drivers/clk/mediatek/clk-mt8183-ipu1.c
index 8fd5fe002890..b378957e11d0 100644
--- a/drivers/clk/mediatek/clk-mt8183-ipu1.c
+++ b/drivers/clk/mediatek/clk-mt8183-ipu1.c
@@ -29,7 +29,7 @@ static const struct mtk_gate ipu_core1_clks[] = {
 
 static int clk_mt8183_ipu_core1_probe(struct platform_device *pdev)
 {
-	struct clk_onecell_data *clk_data;
+	struct clk_hw_onecell_data *clk_data;
 	struct device_node *node = pdev->dev.of_node;
 
 	clk_data = mtk_alloc_clk_data(CLK_IPU_CORE1_NR_CLK);
@@ -37,7 +37,7 @@ static int clk_mt8183_ipu_core1_probe(struct platform_device *pdev)
 	mtk_clk_register_gates(node, ipu_core1_clks, ARRAY_SIZE(ipu_core1_clks),
 			clk_data);
 
-	return of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
+	return of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 }
 
 static const struct of_device_id of_match_clk_mt8183_ipu_core1[] = {
diff --git a/drivers/clk/mediatek/clk-mt8183-ipu_adl.c b/drivers/clk/mediatek/clk-mt8183-ipu_adl.c
index 3f37d0ef1df1..941b43ac8bec 100644
--- a/drivers/clk/mediatek/clk-mt8183-ipu_adl.c
+++ b/drivers/clk/mediatek/clk-mt8183-ipu_adl.c
@@ -27,7 +27,7 @@ static const struct mtk_gate ipu_adl_clks[] = {
 
 static int clk_mt8183_ipu_adl_probe(struct platform_device *pdev)
 {
-	struct clk_onecell_data *clk_data;
+	struct clk_hw_onecell_data *clk_data;
 	struct device_node *node = pdev->dev.of_node;
 
 	clk_data = mtk_alloc_clk_data(CLK_IPU_ADL_NR_CLK);
@@ -35,7 +35,7 @@ static int clk_mt8183_ipu_adl_probe(struct platform_device *pdev)
 	mtk_clk_register_gates(node, ipu_adl_clks, ARRAY_SIZE(ipu_adl_clks),
 			clk_data);
 
-	return of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
+	return of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 }
 
 static const struct of_device_id of_match_clk_mt8183_ipu_adl[] = {
diff --git a/drivers/clk/mediatek/clk-mt8183-ipu_conn.c b/drivers/clk/mediatek/clk-mt8183-ipu_conn.c
index 7e0eef79c461..ae82c2e17110 100644
--- a/drivers/clk/mediatek/clk-mt8183-ipu_conn.c
+++ b/drivers/clk/mediatek/clk-mt8183-ipu_conn.c
@@ -96,7 +96,7 @@ static const struct mtk_gate ipu_conn_clks[] = {
 
 static int clk_mt8183_ipu_conn_probe(struct platform_device *pdev)
 {
-	struct clk_onecell_data *clk_data;
+	struct clk_hw_onecell_data *clk_data;
 	struct device_node *node = pdev->dev.of_node;
 
 	clk_data = mtk_alloc_clk_data(CLK_IPU_CONN_NR_CLK);
@@ -104,7 +104,7 @@ static int clk_mt8183_ipu_conn_probe(struct platform_device *pdev)
 	mtk_clk_register_gates(node, ipu_conn_clks, ARRAY_SIZE(ipu_conn_clks),
 			clk_data);
 
-	return of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
+	return of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 }
 
 static const struct of_device_id of_match_clk_mt8183_ipu_conn[] = {
diff --git a/drivers/clk/mediatek/clk-mt8183-mfgcfg.c b/drivers/clk/mediatek/clk-mt8183-mfgcfg.c
index 37b4162c5882..d774edaf760b 100644
--- a/drivers/clk/mediatek/clk-mt8183-mfgcfg.c
+++ b/drivers/clk/mediatek/clk-mt8183-mfgcfg.c
@@ -28,7 +28,7 @@ static const struct mtk_gate mfg_clks[] = {
 
 static int clk_mt8183_mfg_probe(struct platform_device *pdev)
 {
-	struct clk_onecell_data *clk_data;
+	struct clk_hw_onecell_data *clk_data;
 	struct device_node *node = pdev->dev.of_node;
 
 	pm_runtime_enable(&pdev->dev);
@@ -38,7 +38,7 @@ static int clk_mt8183_mfg_probe(struct platform_device *pdev)
 	mtk_clk_register_gates_with_dev(node, mfg_clks, ARRAY_SIZE(mfg_clks),
 			clk_data, &pdev->dev);
 
-	return of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
+	return of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 }
 
 static const struct of_device_id of_match_clk_mt8183_mfg[] = {
diff --git a/drivers/clk/mediatek/clk-mt8183-mm.c b/drivers/clk/mediatek/clk-mt8183-mm.c
index 9d60e09619c1..11ecc6fb0065 100644
--- a/drivers/clk/mediatek/clk-mt8183-mm.c
+++ b/drivers/clk/mediatek/clk-mt8183-mm.c
@@ -86,14 +86,14 @@ static int clk_mt8183_mm_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct device_node *node = dev->parent->of_node;
-	struct clk_onecell_data *clk_data;
+	struct clk_hw_onecell_data *clk_data;
 
 	clk_data = mtk_alloc_clk_data(CLK_MM_NR_CLK);
 
 	mtk_clk_register_gates(node, mm_clks, ARRAY_SIZE(mm_clks),
 			clk_data);
 
-	return of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
+	return of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 }
 
 static struct platform_driver clk_mt8183_mm_drv = {
diff --git a/drivers/clk/mediatek/clk-mt8183-vdec.c b/drivers/clk/mediatek/clk-mt8183-vdec.c
index 6250fd1e0edc..0548cde159d0 100644
--- a/drivers/clk/mediatek/clk-mt8183-vdec.c
+++ b/drivers/clk/mediatek/clk-mt8183-vdec.c
@@ -40,7 +40,7 @@ static const struct mtk_gate vdec_clks[] = {
 
 static int clk_mt8183_vdec_probe(struct platform_device *pdev)
 {
-	struct clk_onecell_data *clk_data;
+	struct clk_hw_onecell_data *clk_data;
 	struct device_node *node = pdev->dev.of_node;
 
 	clk_data = mtk_alloc_clk_data(CLK_VDEC_NR_CLK);
@@ -48,7 +48,7 @@ static int clk_mt8183_vdec_probe(struct platform_device *pdev)
 	mtk_clk_register_gates(node, vdec_clks, ARRAY_SIZE(vdec_clks),
 			clk_data);
 
-	return of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
+	return of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 }
 
 static const struct of_device_id of_match_clk_mt8183_vdec[] = {
diff --git a/drivers/clk/mediatek/clk-mt8183-venc.c b/drivers/clk/mediatek/clk-mt8183-venc.c
index 6678ef03fab2..f86ec607d87a 100644
--- a/drivers/clk/mediatek/clk-mt8183-venc.c
+++ b/drivers/clk/mediatek/clk-mt8183-venc.c
@@ -32,7 +32,7 @@ static const struct mtk_gate venc_clks[] = {
 
 static int clk_mt8183_venc_probe(struct platform_device *pdev)
 {
-	struct clk_onecell_data *clk_data;
+	struct clk_hw_onecell_data *clk_data;
 	struct device_node *node = pdev->dev.of_node;
 
 	clk_data = mtk_alloc_clk_data(CLK_VENC_NR_CLK);
@@ -40,7 +40,7 @@ static int clk_mt8183_venc_probe(struct platform_device *pdev)
 	mtk_clk_register_gates(node, venc_clks, ARRAY_SIZE(venc_clks),
 			clk_data);
 
-	return of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
+	return of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 }
 
 static const struct of_device_id of_match_clk_mt8183_venc[] = {
diff --git a/drivers/clk/mediatek/clk-mt8183.c b/drivers/clk/mediatek/clk-mt8183.c
index 68496554dd3d..8a755fadebb5 100644
--- a/drivers/clk/mediatek/clk-mt8183.c
+++ b/drivers/clk/mediatek/clk-mt8183.c
@@ -1155,7 +1155,7 @@ static const struct mtk_pll_data plls[] = {
 
 static int clk_mt8183_apmixed_probe(struct platform_device *pdev)
 {
-	struct clk_onecell_data *clk_data;
+	struct clk_hw_onecell_data *clk_data;
 	struct device_node *node = pdev->dev.of_node;
 
 	clk_data = mtk_alloc_clk_data(CLK_APMIXED_NR_CLK);
@@ -1165,10 +1165,10 @@ static int clk_mt8183_apmixed_probe(struct platform_device *pdev)
 	mtk_clk_register_gates(node, apmixed_clks, ARRAY_SIZE(apmixed_clks),
 		clk_data);
 
-	return of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
+	return of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 }
 
-static struct clk_onecell_data *top_clk_data;
+static struct clk_hw_onecell_data *top_clk_data;
 
 static void clk_mt8183_top_init_early(struct device_node *node)
 {
@@ -1177,12 +1177,12 @@ static void clk_mt8183_top_init_early(struct device_node *node)
 	top_clk_data = mtk_alloc_clk_data(CLK_TOP_NR_CLK);
 
 	for (i = 0; i < CLK_TOP_NR_CLK; i++)
-		top_clk_data->clks[i] = ERR_PTR(-EPROBE_DEFER);
+		top_clk_data->hws[i] = ERR_PTR(-EPROBE_DEFER);
 
 	mtk_clk_register_factors(top_early_divs, ARRAY_SIZE(top_early_divs),
 			top_clk_data);
 
-	of_clk_add_provider(node, of_clk_src_onecell_get, top_clk_data);
+	of_clk_add_hw_provider(node, of_clk_hw_onecell_get, top_clk_data);
 }
 
 CLK_OF_DECLARE_DRIVER(mt8183_topckgen, "mediatek,mt8183-topckgen",
@@ -1217,12 +1217,13 @@ static int clk_mt8183_top_probe(struct platform_device *pdev)
 	mtk_clk_register_gates(node, top_clks, ARRAY_SIZE(top_clks),
 		top_clk_data);
 
-	return of_clk_add_provider(node, of_clk_src_onecell_get, top_clk_data);
+	return of_clk_add_hw_provider(node, of_clk_hw_onecell_get,
+				      top_clk_data);
 }
 
 static int clk_mt8183_infra_probe(struct platform_device *pdev)
 {
-	struct clk_onecell_data *clk_data;
+	struct clk_hw_onecell_data *clk_data;
 	struct device_node *node = pdev->dev.of_node;
 	int r;
 
@@ -1231,7 +1232,7 @@ static int clk_mt8183_infra_probe(struct platform_device *pdev)
 	mtk_clk_register_gates(node, infra_clks, ARRAY_SIZE(infra_clks),
 		clk_data);
 
-	r = of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
+	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 	if (r) {
 		dev_err(&pdev->dev,
 			"%s(): could not register clock provider: %d\n",
@@ -1246,7 +1247,7 @@ static int clk_mt8183_infra_probe(struct platform_device *pdev)
 
 static int clk_mt8183_peri_probe(struct platform_device *pdev)
 {
-	struct clk_onecell_data *clk_data;
+	struct clk_hw_onecell_data *clk_data;
 	struct device_node *node = pdev->dev.of_node;
 
 	clk_data = mtk_alloc_clk_data(CLK_PERI_NR_CLK);
@@ -1254,12 +1255,12 @@ static int clk_mt8183_peri_probe(struct platform_device *pdev)
 	mtk_clk_register_gates(node, peri_clks, ARRAY_SIZE(peri_clks),
 			       clk_data);
 
-	return of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
+	return of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 }
 
 static int clk_mt8183_mcu_probe(struct platform_device *pdev)
 {
-	struct clk_onecell_data *clk_data;
+	struct clk_hw_onecell_data *clk_data;
 	struct device_node *node = pdev->dev.of_node;
 	void __iomem *base;
 
@@ -1272,7 +1273,7 @@ static int clk_mt8183_mcu_probe(struct platform_device *pdev)
 	mtk_clk_register_composites(mcu_muxes, ARRAY_SIZE(mcu_muxes), base,
 			&mt8183_clk_lock, clk_data);
 
-	return of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
+	return of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 }
 
 static const struct of_device_id of_match_clk_mt8183[] = {
diff --git a/drivers/clk/mediatek/clk-mt8192-aud.c b/drivers/clk/mediatek/clk-mt8192-aud.c
index f28d56628045..8c989bffd8c7 100644
--- a/drivers/clk/mediatek/clk-mt8192-aud.c
+++ b/drivers/clk/mediatek/clk-mt8192-aud.c
@@ -79,7 +79,7 @@ static const struct mtk_gate aud_clks[] = {
 
 static int clk_mt8192_aud_probe(struct platform_device *pdev)
 {
-	struct clk_onecell_data *clk_data;
+	struct clk_hw_onecell_data *clk_data;
 	struct device_node *node = pdev->dev.of_node;
 	int r;
 
@@ -91,7 +91,7 @@ static int clk_mt8192_aud_probe(struct platform_device *pdev)
 	if (r)
 		return r;
 
-	r = of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
+	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 	if (r)
 		return r;
 
diff --git a/drivers/clk/mediatek/clk-mt8192-mm.c b/drivers/clk/mediatek/clk-mt8192-mm.c
index 4a0b4c4bc06a..1be3ff4d407d 100644
--- a/drivers/clk/mediatek/clk-mt8192-mm.c
+++ b/drivers/clk/mediatek/clk-mt8192-mm.c
@@ -84,7 +84,7 @@ static int clk_mt8192_mm_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct device_node *node = dev->parent->of_node;
-	struct clk_onecell_data *clk_data;
+	struct clk_hw_onecell_data *clk_data;
 	int r;
 
 	clk_data = mtk_alloc_clk_data(CLK_MM_NR_CLK);
@@ -95,7 +95,7 @@ static int clk_mt8192_mm_probe(struct platform_device *pdev)
 	if (r)
 		return r;
 
-	return of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
+	return of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 }
 
 static struct platform_driver clk_mt8192_mm_drv = {
diff --git a/drivers/clk/mediatek/clk-mt8192.c b/drivers/clk/mediatek/clk-mt8192.c
index ab27cd66b866..dda211b7a745 100644
--- a/drivers/clk/mediatek/clk-mt8192.c
+++ b/drivers/clk/mediatek/clk-mt8192.c
@@ -1178,7 +1178,7 @@ static const struct mtk_pll_data plls[] = {
 	      0, 0, 32, 0x0330, 24, 0, 0, 0, 0x0334, 0),
 };
 
-static struct clk_onecell_data *top_clk_data;
+static struct clk_hw_onecell_data *top_clk_data;
 
 static void clk_mt8192_top_init_early(struct device_node *node)
 {
@@ -1189,11 +1189,11 @@ static void clk_mt8192_top_init_early(struct device_node *node)
 		return;
 
 	for (i = 0; i < CLK_TOP_NR_CLK; i++)
-		top_clk_data->clks[i] = ERR_PTR(-EPROBE_DEFER);
+		top_clk_data->hws[i] = ERR_PTR(-EPROBE_DEFER);
 
 	mtk_clk_register_factors(top_early_divs, ARRAY_SIZE(top_early_divs), top_clk_data);
 
-	of_clk_add_provider(node, of_clk_src_onecell_get, top_clk_data);
+	of_clk_add_hw_provider(node, of_clk_hw_onecell_get, top_clk_data);
 }
 
 CLK_OF_DECLARE_DRIVER(mt8192_topckgen, "mediatek,mt8192-topckgen",
@@ -1222,12 +1222,13 @@ static int clk_mt8192_top_probe(struct platform_device *pdev)
 	if (r)
 		return r;
 
-	return of_clk_add_provider(node, of_clk_src_onecell_get, top_clk_data);
+	return of_clk_add_hw_provider(node, of_clk_hw_onecell_get,
+				      top_clk_data);
 }
 
 static int clk_mt8192_infra_probe(struct platform_device *pdev)
 {
-	struct clk_onecell_data *clk_data;
+	struct clk_hw_onecell_data *clk_data;
 	struct device_node *node = pdev->dev.of_node;
 	int r;
 
@@ -1239,7 +1240,7 @@ static int clk_mt8192_infra_probe(struct platform_device *pdev)
 	if (r)
 		goto free_clk_data;
 
-	r = of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
+	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 	if (r)
 		goto free_clk_data;
 
@@ -1252,7 +1253,7 @@ static int clk_mt8192_infra_probe(struct platform_device *pdev)
 
 static int clk_mt8192_peri_probe(struct platform_device *pdev)
 {
-	struct clk_onecell_data *clk_data;
+	struct clk_hw_onecell_data *clk_data;
 	struct device_node *node = pdev->dev.of_node;
 	int r;
 
@@ -1264,7 +1265,7 @@ static int clk_mt8192_peri_probe(struct platform_device *pdev)
 	if (r)
 		goto free_clk_data;
 
-	r = of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
+	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 	if (r)
 		goto free_clk_data;
 
@@ -1277,7 +1278,7 @@ static int clk_mt8192_peri_probe(struct platform_device *pdev)
 
 static int clk_mt8192_apmixed_probe(struct platform_device *pdev)
 {
-	struct clk_onecell_data *clk_data;
+	struct clk_hw_onecell_data *clk_data;
 	struct device_node *node = pdev->dev.of_node;
 	int r;
 
@@ -1290,7 +1291,7 @@ static int clk_mt8192_apmixed_probe(struct platform_device *pdev)
 	if (r)
 		goto free_clk_data;
 
-	r = of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
+	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 	if (r)
 		goto free_clk_data;
 
diff --git a/drivers/clk/mediatek/clk-mt8195-apmixedsys.c b/drivers/clk/mediatek/clk-mt8195-apmixedsys.c
index eecc7035a56a..0dfed6ec4d15 100644
--- a/drivers/clk/mediatek/clk-mt8195-apmixedsys.c
+++ b/drivers/clk/mediatek/clk-mt8195-apmixedsys.c
@@ -112,7 +112,7 @@ static const struct of_device_id of_match_clk_mt8195_apmixed[] = {
 
 static int clk_mt8195_apmixed_probe(struct platform_device *pdev)
 {
-	struct clk_onecell_data *clk_data;
+	struct clk_hw_onecell_data *clk_data;
 	struct device_node *node = pdev->dev.of_node;
 	int r;
 
@@ -128,7 +128,7 @@ static int clk_mt8195_apmixed_probe(struct platform_device *pdev)
 	if (r)
 		goto unregister_plls;
 
-	r = of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
+	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 	if (r)
 		goto unregister_gates;
 
@@ -148,7 +148,7 @@ static int clk_mt8195_apmixed_probe(struct platform_device *pdev)
 static int clk_mt8195_apmixed_remove(struct platform_device *pdev)
 {
 	struct device_node *node = pdev->dev.of_node;
-	struct clk_onecell_data *clk_data = platform_get_drvdata(pdev);
+	struct clk_hw_onecell_data *clk_data = platform_get_drvdata(pdev);
 
 	of_clk_del_provider(node);
 	mtk_clk_unregister_gates(apmixed_clks, ARRAY_SIZE(apmixed_clks), clk_data);
diff --git a/drivers/clk/mediatek/clk-mt8195-apusys_pll.c b/drivers/clk/mediatek/clk-mt8195-apusys_pll.c
index 8cd88dfc3283..0b52f6a009c4 100644
--- a/drivers/clk/mediatek/clk-mt8195-apusys_pll.c
+++ b/drivers/clk/mediatek/clk-mt8195-apusys_pll.c
@@ -58,7 +58,7 @@ static const struct mtk_pll_data apusys_plls[] = {
 
 static int clk_mt8195_apusys_pll_probe(struct platform_device *pdev)
 {
-	struct clk_onecell_data *clk_data;
+	struct clk_hw_onecell_data *clk_data;
 	struct device_node *node = pdev->dev.of_node;
 	int r;
 
@@ -70,7 +70,7 @@ static int clk_mt8195_apusys_pll_probe(struct platform_device *pdev)
 	if (r)
 		goto free_apusys_pll_data;
 
-	r = of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
+	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 	if (r)
 		goto unregister_plls;
 
@@ -87,7 +87,7 @@ static int clk_mt8195_apusys_pll_probe(struct platform_device *pdev)
 
 static int clk_mt8195_apusys_pll_remove(struct platform_device *pdev)
 {
-	struct clk_onecell_data *clk_data = platform_get_drvdata(pdev);
+	struct clk_hw_onecell_data *clk_data = platform_get_drvdata(pdev);
 	struct device_node *node = pdev->dev.of_node;
 
 	of_clk_del_provider(node);
diff --git a/drivers/clk/mediatek/clk-mt8195-topckgen.c b/drivers/clk/mediatek/clk-mt8195-topckgen.c
index b602fcd7f1d1..ec70e1f65eaf 100644
--- a/drivers/clk/mediatek/clk-mt8195-topckgen.c
+++ b/drivers/clk/mediatek/clk-mt8195-topckgen.c
@@ -1224,7 +1224,7 @@ static const struct of_device_id of_match_clk_mt8195_topck[] = {
 
 static int clk_mt8195_topck_probe(struct platform_device *pdev)
 {
-	struct clk_onecell_data *top_clk_data;
+	struct clk_hw_onecell_data *top_clk_data;
 	struct device_node *node = pdev->dev.of_node;
 	int r;
 	void __iomem *base;
@@ -1267,7 +1267,7 @@ static int clk_mt8195_topck_probe(struct platform_device *pdev)
 	if (r)
 		goto unregister_composite_divs;
 
-	r = of_clk_add_provider(node, of_clk_src_onecell_get, top_clk_data);
+	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, top_clk_data);
 	if (r)
 		goto unregister_gates;
 
@@ -1294,7 +1294,7 @@ static int clk_mt8195_topck_probe(struct platform_device *pdev)
 
 static int clk_mt8195_topck_remove(struct platform_device *pdev)
 {
-	struct clk_onecell_data *top_clk_data = platform_get_drvdata(pdev);
+	struct clk_hw_onecell_data *top_clk_data = platform_get_drvdata(pdev);
 	struct device_node *node = pdev->dev.of_node;
 
 	of_clk_del_provider(node);
diff --git a/drivers/clk/mediatek/clk-mt8195-vdo0.c b/drivers/clk/mediatek/clk-mt8195-vdo0.c
index 3bc7ed19d550..261a7f76dd3c 100644
--- a/drivers/clk/mediatek/clk-mt8195-vdo0.c
+++ b/drivers/clk/mediatek/clk-mt8195-vdo0.c
@@ -92,7 +92,7 @@ static int clk_mt8195_vdo0_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct device_node *node = dev->parent->of_node;
-	struct clk_onecell_data *clk_data;
+	struct clk_hw_onecell_data *clk_data;
 	int r;
 
 	clk_data = mtk_alloc_clk_data(CLK_VDO0_NR_CLK);
@@ -103,7 +103,7 @@ static int clk_mt8195_vdo0_probe(struct platform_device *pdev)
 	if (r)
 		goto free_vdo0_data;
 
-	r = of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
+	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 	if (r)
 		goto unregister_gates;
 
@@ -122,7 +122,7 @@ static int clk_mt8195_vdo0_remove(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct device_node *node = dev->parent->of_node;
-	struct clk_onecell_data *clk_data = platform_get_drvdata(pdev);
+	struct clk_hw_onecell_data *clk_data = platform_get_drvdata(pdev);
 
 	of_clk_del_provider(node);
 	mtk_clk_unregister_gates(vdo0_clks, ARRAY_SIZE(vdo0_clks), clk_data);
diff --git a/drivers/clk/mediatek/clk-mt8195-vdo1.c b/drivers/clk/mediatek/clk-mt8195-vdo1.c
index 90c738a85ff1..3378487d2c90 100644
--- a/drivers/clk/mediatek/clk-mt8195-vdo1.c
+++ b/drivers/clk/mediatek/clk-mt8195-vdo1.c
@@ -109,7 +109,7 @@ static int clk_mt8195_vdo1_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct device_node *node = dev->parent->of_node;
-	struct clk_onecell_data *clk_data;
+	struct clk_hw_onecell_data *clk_data;
 	int r;
 
 	clk_data = mtk_alloc_clk_data(CLK_VDO1_NR_CLK);
@@ -120,7 +120,7 @@ static int clk_mt8195_vdo1_probe(struct platform_device *pdev)
 	if (r)
 		goto free_vdo1_data;
 
-	r = of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
+	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 	if (r)
 		goto unregister_gates;
 
@@ -139,7 +139,7 @@ static int clk_mt8195_vdo1_remove(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct device_node *node = dev->parent->of_node;
-	struct clk_onecell_data *clk_data = platform_get_drvdata(pdev);
+	struct clk_hw_onecell_data *clk_data = platform_get_drvdata(pdev);
 
 	of_clk_del_provider(node);
 	mtk_clk_unregister_gates(vdo1_clks, ARRAY_SIZE(vdo1_clks), clk_data);
diff --git a/drivers/clk/mediatek/clk-mt8516-aud.c b/drivers/clk/mediatek/clk-mt8516-aud.c
index 6ab3a06dc9d5..90f48068a8de 100644
--- a/drivers/clk/mediatek/clk-mt8516-aud.c
+++ b/drivers/clk/mediatek/clk-mt8516-aud.c
@@ -49,14 +49,14 @@ static const struct mtk_gate aud_clks[] __initconst = {
 
 static void __init mtk_audsys_init(struct device_node *node)
 {
-	struct clk_onecell_data *clk_data;
+	struct clk_hw_onecell_data *clk_data;
 	int r;
 
 	clk_data = mtk_alloc_clk_data(CLK_AUD_NR_CLK);
 
 	mtk_clk_register_gates(node, aud_clks, ARRAY_SIZE(aud_clks), clk_data);
 
-	r = of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
+	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 	if (r)
 		pr_err("%s(): could not register clock provider: %d\n",
 			__func__, r);
diff --git a/drivers/clk/mediatek/clk-mt8516.c b/drivers/clk/mediatek/clk-mt8516.c
index a37143f920ce..2507d18df9ee 100644
--- a/drivers/clk/mediatek/clk-mt8516.c
+++ b/drivers/clk/mediatek/clk-mt8516.c
@@ -677,7 +677,7 @@ static const struct mtk_gate top_clks[] __initconst = {
 
 static void __init mtk_topckgen_init(struct device_node *node)
 {
-	struct clk_onecell_data *clk_data;
+	struct clk_hw_onecell_data *clk_data;
 	int r;
 	void __iomem *base;
 
@@ -699,7 +699,7 @@ static void __init mtk_topckgen_init(struct device_node *node)
 	mtk_clk_register_dividers(top_adj_divs, ARRAY_SIZE(top_adj_divs),
 				base, &mt8516_clk_lock, clk_data);
 
-	r = of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
+	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 	if (r)
 		pr_err("%s(): could not register clock provider: %d\n",
 			__func__, r);
@@ -708,7 +708,7 @@ CLK_OF_DECLARE(mtk_topckgen, "mediatek,mt8516-topckgen", mtk_topckgen_init);
 
 static void __init mtk_infracfg_init(struct device_node *node)
 {
-	struct clk_onecell_data *clk_data;
+	struct clk_hw_onecell_data *clk_data;
 	int r;
 	void __iomem *base;
 
@@ -723,7 +723,7 @@ static void __init mtk_infracfg_init(struct device_node *node)
 	mtk_clk_register_composites(ifr_muxes, ARRAY_SIZE(ifr_muxes), base,
 		&mt8516_clk_lock, clk_data);
 
-	r = of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
+	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 	if (r)
 		pr_err("%s(): could not register clock provider: %d\n",
 			__func__, r);
@@ -787,7 +787,7 @@ static const struct mtk_pll_data plls[] = {
 
 static void __init mtk_apmixedsys_init(struct device_node *node)
 {
-	struct clk_onecell_data *clk_data;
+	struct clk_hw_onecell_data *clk_data;
 	void __iomem *base;
 	int r;
 
@@ -801,7 +801,7 @@ static void __init mtk_apmixedsys_init(struct device_node *node)
 
 	mtk_clk_register_plls(node, plls, ARRAY_SIZE(plls), clk_data);
 
-	r = of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
+	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 	if (r)
 		pr_err("%s(): could not register clock provider: %d\n",
 			__func__, r);
diff --git a/drivers/clk/mediatek/clk-mtk.c b/drivers/clk/mediatek/clk-mtk.c
index 554c6a128460..cfcf740e4e68 100644
--- a/drivers/clk/mediatek/clk-mtk.c
+++ b/drivers/clk/mediatek/clk-mtk.c
@@ -21,7 +21,7 @@
 struct clk_hw_onecell_data *mtk_alloc_clk_data(unsigned int clk_num)
 {
 	int i;
-	struct clk_onecell_data *clk_data;
+	struct clk_hw_onecell_data *clk_data;
 
 	clk_data = kzalloc(struct_size(clk_data, hws, clk_num), GFP_KERNEL);
 	if (!clk_data)
@@ -43,7 +43,7 @@ void mtk_free_clk_data(struct clk_hw_onecell_data *clk_data)
 EXPORT_SYMBOL_GPL(mtk_free_clk_data);
 
 int mtk_clk_register_fixed_clks(const struct mtk_fixed_clk *clks, int num,
-				struct clk_onecell_data *clk_data)
+				struct clk_hw_onecell_data *clk_data)
 {
 	int i;
 	struct clk *clk;
@@ -54,7 +54,7 @@ int mtk_clk_register_fixed_clks(const struct mtk_fixed_clk *clks, int num,
 	for (i = 0; i < num; i++) {
 		const struct mtk_fixed_clk *rc = &clks[i];
 
-		if (!IS_ERR_OR_NULL(clk_data->clks[rc->id])) {
+		if (!IS_ERR_OR_NULL(clk_data->hws[rc->id])) {
 			pr_warn("Trying to register duplicate clock ID: %d\n", rc->id);
 			continue;
 		}
@@ -67,7 +67,7 @@ int mtk_clk_register_fixed_clks(const struct mtk_fixed_clk *clks, int num,
 			goto err;
 		}
 
-		clk_data->clks[rc->id] = clk;
+		clk_data->hws[rc->id] = __clk_get_hw(clk);
 	}
 
 	return 0;
@@ -76,11 +76,11 @@ int mtk_clk_register_fixed_clks(const struct mtk_fixed_clk *clks, int num,
 	while (--i >= 0) {
 		const struct mtk_fixed_clk *rc = &clks[i];
 
-		if (IS_ERR_OR_NULL(clk_data->clks[rc->id]))
+		if (IS_ERR_OR_NULL(clk_data->hws[rc->id]))
 			continue;
 
-		clk_unregister_fixed_rate(clk_data->clks[rc->id]);
-		clk_data->clks[rc->id] = ERR_PTR(-ENOENT);
+		clk_unregister_fixed_rate(clk_data->hws[rc->id]->clk);
+		clk_data->hws[rc->id] = ERR_PTR(-ENOENT);
 	}
 
 	return PTR_ERR(clk);
@@ -88,7 +88,7 @@ int mtk_clk_register_fixed_clks(const struct mtk_fixed_clk *clks, int num,
 EXPORT_SYMBOL_GPL(mtk_clk_register_fixed_clks);
 
 void mtk_clk_unregister_fixed_clks(const struct mtk_fixed_clk *clks, int num,
-				   struct clk_onecell_data *clk_data)
+				   struct clk_hw_onecell_data *clk_data)
 {
 	int i;
 
@@ -98,17 +98,17 @@ void mtk_clk_unregister_fixed_clks(const struct mtk_fixed_clk *clks, int num,
 	for (i = num; i > 0; i--) {
 		const struct mtk_fixed_clk *rc = &clks[i - 1];
 
-		if (IS_ERR_OR_NULL(clk_data->clks[rc->id]))
+		if (IS_ERR_OR_NULL(clk_data->hws[rc->id]))
 			continue;
 
-		clk_unregister_fixed_rate(clk_data->clks[rc->id]);
-		clk_data->clks[rc->id] = ERR_PTR(-ENOENT);
+		clk_unregister_fixed_rate(clk_data->hws[rc->id]->clk);
+		clk_data->hws[rc->id] = ERR_PTR(-ENOENT);
 	}
 }
 EXPORT_SYMBOL_GPL(mtk_clk_unregister_fixed_clks);
 
 int mtk_clk_register_factors(const struct mtk_fixed_factor *clks, int num,
-			     struct clk_onecell_data *clk_data)
+			     struct clk_hw_onecell_data *clk_data)
 {
 	int i;
 	struct clk *clk;
@@ -119,7 +119,7 @@ int mtk_clk_register_factors(const struct mtk_fixed_factor *clks, int num,
 	for (i = 0; i < num; i++) {
 		const struct mtk_fixed_factor *ff = &clks[i];
 
-		if (!IS_ERR_OR_NULL(clk_data->clks[ff->id])) {
+		if (!IS_ERR_OR_NULL(clk_data->hws[ff->id])) {
 			pr_warn("Trying to register duplicate clock ID: %d\n", ff->id);
 			continue;
 		}
@@ -132,7 +132,7 @@ int mtk_clk_register_factors(const struct mtk_fixed_factor *clks, int num,
 			goto err;
 		}
 
-		clk_data->clks[ff->id] = clk;
+		clk_data->hws[ff->id] = __clk_get_hw(clk);
 	}
 
 	return 0;
@@ -141,11 +141,11 @@ int mtk_clk_register_factors(const struct mtk_fixed_factor *clks, int num,
 	while (--i >= 0) {
 		const struct mtk_fixed_factor *ff = &clks[i];
 
-		if (IS_ERR_OR_NULL(clk_data->clks[ff->id]))
+		if (IS_ERR_OR_NULL(clk_data->hws[ff->id]))
 			continue;
 
-		clk_unregister_fixed_factor(clk_data->clks[ff->id]);
-		clk_data->clks[ff->id] = ERR_PTR(-ENOENT);
+		clk_unregister_fixed_factor(clk_data->hws[ff->id]->clk);
+		clk_data->hws[ff->id] = ERR_PTR(-ENOENT);
 	}
 
 	return PTR_ERR(clk);
@@ -153,7 +153,7 @@ int mtk_clk_register_factors(const struct mtk_fixed_factor *clks, int num,
 EXPORT_SYMBOL_GPL(mtk_clk_register_factors);
 
 void mtk_clk_unregister_factors(const struct mtk_fixed_factor *clks, int num,
-				struct clk_onecell_data *clk_data)
+				struct clk_hw_onecell_data *clk_data)
 {
 	int i;
 
@@ -163,11 +163,11 @@ void mtk_clk_unregister_factors(const struct mtk_fixed_factor *clks, int num,
 	for (i = num; i > 0; i--) {
 		const struct mtk_fixed_factor *ff = &clks[i - 1];
 
-		if (IS_ERR_OR_NULL(clk_data->clks[ff->id]))
+		if (IS_ERR_OR_NULL(clk_data->hws[ff->id]))
 			continue;
 
-		clk_unregister_fixed_factor(clk_data->clks[ff->id]);
-		clk_data->clks[ff->id] = ERR_PTR(-ENOENT);
+		clk_unregister_fixed_factor(clk_data->hws[ff->id]->clk);
+		clk_data->hws[ff->id] = ERR_PTR(-ENOENT);
 	}
 }
 EXPORT_SYMBOL_GPL(mtk_clk_unregister_factors);
@@ -287,7 +287,7 @@ static void mtk_clk_unregister_composite(struct clk *clk)
 
 int mtk_clk_register_composites(const struct mtk_composite *mcs, int num,
 				void __iomem *base, spinlock_t *lock,
-				struct clk_onecell_data *clk_data)
+				struct clk_hw_onecell_data *clk_data)
 {
 	struct clk *clk;
 	int i;
@@ -298,7 +298,7 @@ int mtk_clk_register_composites(const struct mtk_composite *mcs, int num,
 	for (i = 0; i < num; i++) {
 		const struct mtk_composite *mc = &mcs[i];
 
-		if (!IS_ERR_OR_NULL(clk_data->clks[mc->id])) {
+		if (!IS_ERR_OR_NULL(clk_data->hws[mc->id])) {
 			pr_warn("Trying to register duplicate clock ID: %d\n",
 				mc->id);
 			continue;
@@ -311,7 +311,7 @@ int mtk_clk_register_composites(const struct mtk_composite *mcs, int num,
 			goto err;
 		}
 
-		clk_data->clks[mc->id] = clk;
+		clk_data->hws[mc->id] = __clk_get_hw(clk);
 	}
 
 	return 0;
@@ -320,11 +320,11 @@ int mtk_clk_register_composites(const struct mtk_composite *mcs, int num,
 	while (--i >= 0) {
 		const struct mtk_composite *mc = &mcs[i];
 
-		if (IS_ERR_OR_NULL(clk_data->clks[mcs->id]))
+		if (IS_ERR_OR_NULL(clk_data->hws[mcs->id]))
 			continue;
 
-		mtk_clk_unregister_composite(clk_data->clks[mc->id]);
-		clk_data->clks[mc->id] = ERR_PTR(-ENOENT);
+		mtk_clk_unregister_composite(clk_data->hws[mc->id]->clk);
+		clk_data->hws[mc->id] = ERR_PTR(-ENOENT);
 	}
 
 	return PTR_ERR(clk);
@@ -332,7 +332,7 @@ int mtk_clk_register_composites(const struct mtk_composite *mcs, int num,
 EXPORT_SYMBOL_GPL(mtk_clk_register_composites);
 
 void mtk_clk_unregister_composites(const struct mtk_composite *mcs, int num,
-				   struct clk_onecell_data *clk_data)
+				   struct clk_hw_onecell_data *clk_data)
 {
 	int i;
 
@@ -342,18 +342,18 @@ void mtk_clk_unregister_composites(const struct mtk_composite *mcs, int num,
 	for (i = num; i > 0; i--) {
 		const struct mtk_composite *mc = &mcs[i - 1];
 
-		if (IS_ERR_OR_NULL(clk_data->clks[mc->id]))
+		if (IS_ERR_OR_NULL(clk_data->hws[mc->id]))
 			continue;
 
-		mtk_clk_unregister_composite(clk_data->clks[mc->id]);
-		clk_data->clks[mc->id] = ERR_PTR(-ENOENT);
+		mtk_clk_unregister_composite(clk_data->hws[mc->id]->clk);
+		clk_data->hws[mc->id] = ERR_PTR(-ENOENT);
 	}
 }
 EXPORT_SYMBOL_GPL(mtk_clk_unregister_composites);
 
 int mtk_clk_register_dividers(const struct mtk_clk_divider *mcds, int num,
 			      void __iomem *base, spinlock_t *lock,
-			      struct clk_onecell_data *clk_data)
+			      struct clk_hw_onecell_data *clk_data)
 {
 	struct clk *clk;
 	int i;
@@ -364,7 +364,7 @@ int mtk_clk_register_dividers(const struct mtk_clk_divider *mcds, int num,
 	for (i = 0; i <  num; i++) {
 		const struct mtk_clk_divider *mcd = &mcds[i];
 
-		if (!IS_ERR_OR_NULL(clk_data->clks[mcd->id])) {
+		if (!IS_ERR_OR_NULL(clk_data->hws[mcd->id])) {
 			pr_warn("Trying to register duplicate clock ID: %d\n",
 				mcd->id);
 			continue;
@@ -379,7 +379,7 @@ int mtk_clk_register_dividers(const struct mtk_clk_divider *mcds, int num,
 			goto err;
 		}
 
-		clk_data->clks[mcd->id] = clk;
+		clk_data->hws[mcd->id] = __clk_get_hw(clk);
 	}
 
 	return 0;
@@ -388,18 +388,18 @@ int mtk_clk_register_dividers(const struct mtk_clk_divider *mcds, int num,
 	while (--i >= 0) {
 		const struct mtk_clk_divider *mcd = &mcds[i];
 
-		if (IS_ERR_OR_NULL(clk_data->clks[mcd->id]))
+		if (IS_ERR_OR_NULL(clk_data->hws[mcd->id]))
 			continue;
 
-		mtk_clk_unregister_composite(clk_data->clks[mcd->id]);
-		clk_data->clks[mcd->id] = ERR_PTR(-ENOENT);
+		mtk_clk_unregister_composite(clk_data->hws[mcd->id]->clk);
+		clk_data->hws[mcd->id] = ERR_PTR(-ENOENT);
 	}
 
 	return PTR_ERR(clk);
 }
 
 void mtk_clk_unregister_dividers(const struct mtk_clk_divider *mcds, int num,
-				 struct clk_onecell_data *clk_data)
+				 struct clk_hw_onecell_data *clk_data)
 {
 	int i;
 
@@ -409,18 +409,18 @@ void mtk_clk_unregister_dividers(const struct mtk_clk_divider *mcds, int num,
 	for (i = num; i > 0; i--) {
 		const struct mtk_clk_divider *mcd = &mcds[i - 1];
 
-		if (IS_ERR_OR_NULL(clk_data->clks[mcd->id]))
+		if (IS_ERR_OR_NULL(clk_data->hws[mcd->id]))
 			continue;
 
-		clk_unregister_divider(clk_data->clks[mcd->id]);
-		clk_data->clks[mcd->id] = ERR_PTR(-ENOENT);
+		clk_unregister_divider(clk_data->hws[mcd->id]->clk);
+		clk_data->hws[mcd->id] = ERR_PTR(-ENOENT);
 	}
 }
 
 int mtk_clk_simple_probe(struct platform_device *pdev)
 {
 	const struct mtk_clk_desc *mcd;
-	struct clk_onecell_data *clk_data;
+	struct clk_hw_onecell_data *clk_data;
 	struct device_node *node = pdev->dev.of_node;
 	int r;
 
@@ -436,7 +436,7 @@ int mtk_clk_simple_probe(struct platform_device *pdev)
 	if (r)
 		goto free_data;
 
-	r = of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
+	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 	if (r)
 		goto unregister_clks;
 
@@ -454,7 +454,7 @@ int mtk_clk_simple_probe(struct platform_device *pdev)
 int mtk_clk_simple_remove(struct platform_device *pdev)
 {
 	const struct mtk_clk_desc *mcd = of_device_get_match_data(&pdev->dev);
-	struct clk_onecell_data *clk_data = platform_get_drvdata(pdev);
+	struct clk_hw_onecell_data *clk_data = platform_get_drvdata(pdev);
 	struct device_node *node = pdev->dev.of_node;
 
 	of_clk_del_provider(node);
diff --git a/drivers/clk/mediatek/clk-mtk.h b/drivers/clk/mediatek/clk-mtk.h
index 787fdeb1bd93..e736420170a2 100644
--- a/drivers/clk/mediatek/clk-mtk.h
+++ b/drivers/clk/mediatek/clk-mtk.h
@@ -35,9 +35,9 @@ struct mtk_fixed_clk {
 	}
 
 int mtk_clk_register_fixed_clks(const struct mtk_fixed_clk *clks, int num,
-				struct clk_onecell_data *clk_data);
+				struct clk_hw_onecell_data *clk_data);
 void mtk_clk_unregister_fixed_clks(const struct mtk_fixed_clk *clks, int num,
-				   struct clk_onecell_data *clk_data);
+				   struct clk_hw_onecell_data *clk_data);
 
 struct mtk_fixed_factor {
 	int id;
@@ -56,9 +56,9 @@ struct mtk_fixed_factor {
 	}
 
 int mtk_clk_register_factors(const struct mtk_fixed_factor *clks, int num,
-			     struct clk_onecell_data *clk_data);
+			     struct clk_hw_onecell_data *clk_data);
 void mtk_clk_unregister_factors(const struct mtk_fixed_factor *clks, int num,
-				struct clk_onecell_data *clk_data);
+				struct clk_hw_onecell_data *clk_data);
 
 struct mtk_composite {
 	int id;
@@ -149,9 +149,9 @@ struct mtk_composite {
 
 int mtk_clk_register_composites(const struct mtk_composite *mcs, int num,
 				void __iomem *base, spinlock_t *lock,
-				struct clk_onecell_data *clk_data);
+				struct clk_hw_onecell_data *clk_data);
 void mtk_clk_unregister_composites(const struct mtk_composite *mcs, int num,
-				   struct clk_onecell_data *clk_data);
+				   struct clk_hw_onecell_data *clk_data);
 
 struct mtk_clk_divider {
 	int id;
@@ -177,9 +177,9 @@ struct mtk_clk_divider {
 
 int mtk_clk_register_dividers(const struct mtk_clk_divider *mcds, int num,
 			      void __iomem *base, spinlock_t *lock,
-			      struct clk_onecell_data *clk_data);
+			      struct clk_hw_onecell_data *clk_data);
 void mtk_clk_unregister_dividers(const struct mtk_clk_divider *mcds, int num,
-				 struct clk_onecell_data *clk_data);
+				 struct clk_hw_onecell_data *clk_data);
 
 struct clk_hw_onecell_data *mtk_alloc_clk_data(unsigned int clk_num);
 void mtk_free_clk_data(struct clk_hw_onecell_data *clk_data);
diff --git a/drivers/clk/mediatek/clk-mux.c b/drivers/clk/mediatek/clk-mux.c
index 21ad5a4afd65..2f47e59cc528 100644
--- a/drivers/clk/mediatek/clk-mux.c
+++ b/drivers/clk/mediatek/clk-mux.c
@@ -193,7 +193,7 @@ static void mtk_clk_unregister_mux(struct clk *clk)
 int mtk_clk_register_muxes(const struct mtk_mux *muxes,
 			   int num, struct device_node *node,
 			   spinlock_t *lock,
-			   struct clk_onecell_data *clk_data)
+			   struct clk_hw_onecell_data *clk_data)
 {
 	struct regmap *regmap;
 	struct clk *clk;
@@ -208,7 +208,7 @@ int mtk_clk_register_muxes(const struct mtk_mux *muxes,
 	for (i = 0; i < num; i++) {
 		const struct mtk_mux *mux = &muxes[i];
 
-		if (!IS_ERR_OR_NULL(clk_data->clks[mux->id])) {
+		if (!IS_ERR_OR_NULL(clk_data->hws[mux->id])) {
 			pr_warn("%pOF: Trying to register duplicate clock ID: %d\n",
 				node, mux->id);
 			continue;
@@ -221,7 +221,7 @@ int mtk_clk_register_muxes(const struct mtk_mux *muxes,
 			goto err;
 		}
 
-		clk_data->clks[mux->id] = clk;
+		clk_data->hws[mux->id] = __clk_get_hw(clk);
 	}
 
 	return 0;
@@ -230,11 +230,11 @@ int mtk_clk_register_muxes(const struct mtk_mux *muxes,
 	while (--i >= 0) {
 		const struct mtk_mux *mux = &muxes[i];
 
-		if (IS_ERR_OR_NULL(clk_data->clks[mux->id]))
+		if (IS_ERR_OR_NULL(clk_data->hws[mux->id]))
 			continue;
 
-		mtk_clk_unregister_mux(clk_data->clks[mux->id]);
-		clk_data->clks[mux->id] = ERR_PTR(-ENOENT);
+		mtk_clk_unregister_mux(clk_data->hws[mux->id]->clk);
+		clk_data->hws[mux->id] = ERR_PTR(-ENOENT);
 	}
 
 	return PTR_ERR(clk);
@@ -242,7 +242,7 @@ int mtk_clk_register_muxes(const struct mtk_mux *muxes,
 EXPORT_SYMBOL_GPL(mtk_clk_register_muxes);
 
 void mtk_clk_unregister_muxes(const struct mtk_mux *muxes, int num,
-			      struct clk_onecell_data *clk_data)
+			      struct clk_hw_onecell_data *clk_data)
 {
 	int i;
 
@@ -252,11 +252,11 @@ void mtk_clk_unregister_muxes(const struct mtk_mux *muxes, int num,
 	for (i = num; i > 0; i--) {
 		const struct mtk_mux *mux = &muxes[i - 1];
 
-		if (IS_ERR_OR_NULL(clk_data->clks[mux->id]))
+		if (IS_ERR_OR_NULL(clk_data->hws[mux->id]))
 			continue;
 
-		mtk_clk_unregister_mux(clk_data->clks[mux->id]);
-		clk_data->clks[mux->id] = ERR_PTR(-ENOENT);
+		mtk_clk_unregister_mux(clk_data->hws[mux->id]->clk);
+		clk_data->hws[mux->id] = ERR_PTR(-ENOENT);
 	}
 }
 EXPORT_SYMBOL_GPL(mtk_clk_unregister_muxes);
diff --git a/drivers/clk/mediatek/clk-mux.h b/drivers/clk/mediatek/clk-mux.h
index 903a3c937959..6539c58f5d7d 100644
--- a/drivers/clk/mediatek/clk-mux.h
+++ b/drivers/clk/mediatek/clk-mux.h
@@ -11,7 +11,7 @@
 #include <linux/types.h>
 
 struct clk;
-struct clk_onecell_data;
+struct clk_hw_onecell_data;
 struct clk_ops;
 struct device_node;
 
@@ -84,9 +84,9 @@ extern const struct clk_ops mtk_mux_gate_clr_set_upd_ops;
 int mtk_clk_register_muxes(const struct mtk_mux *muxes,
 			   int num, struct device_node *node,
 			   spinlock_t *lock,
-			   struct clk_onecell_data *clk_data);
+			   struct clk_hw_onecell_data *clk_data);
 
 void mtk_clk_unregister_muxes(const struct mtk_mux *muxes, int num,
-			      struct clk_onecell_data *clk_data);
+			      struct clk_hw_onecell_data *clk_data);
 
 #endif /* __DRV_CLK_MTK_MUX_H */
diff --git a/drivers/clk/mediatek/clk-pll.c b/drivers/clk/mediatek/clk-pll.c
index ccaa2085ab4d..89350a1a158c 100644
--- a/drivers/clk/mediatek/clk-pll.c
+++ b/drivers/clk/mediatek/clk-pll.c
@@ -379,7 +379,7 @@ static void mtk_clk_unregister_pll(struct clk *clk)
 
 int mtk_clk_register_plls(struct device_node *node,
 			  const struct mtk_pll_data *plls, int num_plls,
-			  struct clk_onecell_data *clk_data)
+			  struct clk_hw_onecell_data *clk_data)
 {
 	void __iomem *base;
 	int i;
@@ -394,7 +394,7 @@ int mtk_clk_register_plls(struct device_node *node,
 	for (i = 0; i < num_plls; i++) {
 		const struct mtk_pll_data *pll = &plls[i];
 
-		if (!IS_ERR_OR_NULL(clk_data->clks[pll->id])) {
+		if (!IS_ERR_OR_NULL(clk_data->hws[pll->id])) {
 			pr_warn("%pOF: Trying to register duplicate clock ID: %d\n",
 				node, pll->id);
 			continue;
@@ -407,7 +407,7 @@ int mtk_clk_register_plls(struct device_node *node,
 			goto err;
 		}
 
-		clk_data->clks[pll->id] = clk;
+		clk_data->hws[pll->id] = __clk_get_hw(clk);
 	}
 
 	return 0;
@@ -416,8 +416,8 @@ int mtk_clk_register_plls(struct device_node *node,
 	while (--i >= 0) {
 		const struct mtk_pll_data *pll = &plls[i];
 
-		mtk_clk_unregister_pll(clk_data->clks[pll->id]);
-		clk_data->clks[pll->id] = ERR_PTR(-ENOENT);
+		mtk_clk_unregister_pll(clk_data->hws[pll->id]->clk);
+		clk_data->hws[pll->id] = ERR_PTR(-ENOENT);
 	}
 
 	iounmap(base);
@@ -426,17 +426,16 @@ int mtk_clk_register_plls(struct device_node *node,
 }
 EXPORT_SYMBOL_GPL(mtk_clk_register_plls);
 
-static __iomem void *mtk_clk_pll_get_base(struct clk *clk,
+static __iomem void *mtk_clk_pll_get_base(struct clk_hw *hw,
 					  const struct mtk_pll_data *data)
 {
-	struct clk_hw *hw = __clk_get_hw(clk);
 	struct mtk_clk_pll *pll = to_mtk_clk_pll(hw);
 
 	return pll->base_addr - data->reg;
 }
 
 void mtk_clk_unregister_plls(const struct mtk_pll_data *plls, int num_plls,
-			     struct clk_onecell_data *clk_data)
+			     struct clk_hw_onecell_data *clk_data)
 {
 	__iomem void *base = NULL;
 	int i;
@@ -447,7 +446,7 @@ void mtk_clk_unregister_plls(const struct mtk_pll_data *plls, int num_plls,
 	for (i = num_plls; i > 0; i--) {
 		const struct mtk_pll_data *pll = &plls[i - 1];
 
-		if (IS_ERR_OR_NULL(clk_data->clks[pll->id]))
+		if (IS_ERR_OR_NULL(clk_data->hws[pll->id]))
 			continue;
 
 		/*
@@ -456,10 +455,10 @@ void mtk_clk_unregister_plls(const struct mtk_pll_data *plls, int num_plls,
 		 * pointer to the I/O region base address. We have to fetch
 		 * it from one of the registered clks.
 		 */
-		base = mtk_clk_pll_get_base(clk_data->clks[pll->id], pll);
+		base = mtk_clk_pll_get_base(clk_data->hws[pll->id], pll);
 
-		mtk_clk_unregister_pll(clk_data->clks[pll->id]);
-		clk_data->clks[pll->id] = ERR_PTR(-ENOENT);
+		mtk_clk_unregister_pll(clk_data->hws[pll->id]->clk);
+		clk_data->hws[pll->id] = ERR_PTR(-ENOENT);
 	}
 
 	iounmap(base);
diff --git a/drivers/clk/mediatek/clk-pll.h b/drivers/clk/mediatek/clk-pll.h
index bf06e44caef9..fe3199715688 100644
--- a/drivers/clk/mediatek/clk-pll.h
+++ b/drivers/clk/mediatek/clk-pll.h
@@ -10,7 +10,7 @@
 #include <linux/types.h>
 
 struct clk_ops;
-struct clk_onecell_data;
+struct clk_hw_onecell_data;
 struct device_node;
 
 struct mtk_pll_div_table {
@@ -50,8 +50,8 @@ struct mtk_pll_data {
 
 int mtk_clk_register_plls(struct device_node *node,
 			  const struct mtk_pll_data *plls, int num_plls,
-			  struct clk_onecell_data *clk_data);
+			  struct clk_hw_onecell_data *clk_data);
 void mtk_clk_unregister_plls(const struct mtk_pll_data *plls, int num_plls,
-			     struct clk_onecell_data *clk_data);
+			     struct clk_hw_onecell_data *clk_data);
 
 #endif /* __DRV_CLK_MTK_PLL_H */
-- 
2.36.0.rc0.470.gd361397f0d-goog

