Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE93E5066A0
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 10:14:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349816AbiDSIQW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 04:16:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241949AbiDSIPy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 04:15:54 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F143B2AC53
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 01:13:11 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id 12so14667593pll.12
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 01:13:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Q5lOWLCy6mzo17nVc6OxwA2xfzBIDoO2WLHgDxNDHwU=;
        b=UIkT4REDZfPRsdJ11SR/ZdC2Do76WZNa+Va1eF95LfAaXajtYYA2tp/mzWSNUKuhYq
         RP4RnXGTaUUjv2hbrmEd9kto5zq6qWtX+NDMyjfEyL6Ao5wSQyVIJPPQnGYmaJCAdRiG
         +4oRwF6Wojcj7gAkFrtOe+PEZUcQgKdrddODU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Q5lOWLCy6mzo17nVc6OxwA2xfzBIDoO2WLHgDxNDHwU=;
        b=CcgzAusa3Rxu/QlKVAhqKbrPuxmMLut09lFXdUjhxYHXbzORI8kIahmJqOmlhKNd58
         dOniaMnl1kAxlZk2bHLzh3+e2t78WR1VU/eGg2d55iaidWFlaUd7b5Trjz/sk5EJYfY1
         7b4oXdeNDM1jPNUMbh3HXkwmdpNUFUWUrZGP2KhugaRuCmSyETSmnVnpLlPXHKeow9AD
         2J3GVgiAtCsctf3XhwcPgwZ8WFt3FZgnbWR0INL985Ww9LWt8vVPuBu/kenWq5kCPz5D
         RiMdLWi1QkOk9GATTPURl0dmHQp0p9GJ8MFeXfLrF2bEpVb42j3pmUyFeWf2KOtgM4gM
         bGRw==
X-Gm-Message-State: AOAM531nAV99duZ+a6KCr2kOooHpXRtwU2Plc+KI1Pd6/Y073+Pe81Wc
        8pvTrJSxmu6+OhEdeec8rg4kNw==
X-Google-Smtp-Source: ABdhPJxnEikCPYUPQ5n/sDV0npRozPxSDZMhD9eq3faczPA3+3E28AMme+Mesz7dtmLr6Hw23Cykcg==
X-Received: by 2002:a17:902:edc5:b0:156:68e4:416 with SMTP id q5-20020a170902edc500b0015668e40416mr14357520plk.87.1650355991320;
        Tue, 19 Apr 2022 01:13:11 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:33f6:f1e6:3e21:a253])
        by smtp.gmail.com with ESMTPSA id n13-20020a654ccd000000b0039db6f73e9dsm15767448pgt.28.2022.04.19.01.13.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Apr 2022 01:13:11 -0700 (PDT)
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
Subject: [RFC PATCH 5/7] clk: mediatek: Switch to clk_hw provider APIs
Date:   Tue, 19 Apr 2022 16:12:44 +0800
Message-Id: <20220419081246.2546159-6-wenst@chromium.org>
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

In a previous patch, 'struct clk_onecell_data' was replaced with
'struct clk_hw_onecell_data', with (struct clk_hw *)->clk and
__clk_get_hw() bridging the new data structures and old code.

Now switch from the old 'clk_(un)?register*()' APIs to the new
'clk_hw_(un)?register*()' ones. This is done with the coccinelle script
below.

Unfortunately this also leaves clk-mt8173.c with a compile error that
would need a coccinelle script longer than the actual diff to fix. This
will be fixed up by hand in the next patch.

    // Fix prototypes
    @@
    identifier F =~ "^mtk_clk_register_";
    @@
    - struct clk *
    + struct clk_hw *
      F(...);

    // Fix calls to mtk_clk_register_<singular>
    @ reg @
    identifier F =~ "^mtk_clk_register_";
    identifier FS =~ "^mtk_clk_register_[a-z_]*s";
    identifier I;
    expression clk_data;
    expression E;
    @@
      FS(...) {
	    ...
    -	struct clk *I;
    +	struct clk_hw *hw;
	    ...
	    for (...;...;...) {
		    ...
    (
    -		I
    +		hw
		    =
    -		clk_register_fixed_rate(
    +		clk_hw_register_fixed_rate(
					    ...
		    );
    |
    -		I
    +		hw
		    =
    -		clk_register_fixed_factor(
    +		clk_hw_register_fixed_factor(
					    ...
		    );
    |
    -		I
    +		hw
		    =
    -		clk_register_divider(
    +		clk_hw_register_divider(
					    ...
		    );
    |
    -		I
    +		hw
		    =
		    F(...);
    )
		    ...
		    if (
    -		    IS_ERR(I)
    +		    IS_ERR(hw)
		       ) {
			    pr_err(...,
    -			       I
    +			       hw
			    ,...);
			    ...
		    }

    -		clk_data->hws[E] = __clk_get_hw(I);
    +		clk_data->hws[E] = hw;
	    }
	    ...
      }

    @ depends on reg @
    identifier reg.I;
    @@
      return PTR_ERR(
    - I
    + hw
      );

    // Fix mtk_clk_register_composite to return clk_hw instead of clk
    @@
    identifier I, R;
    expression E;
    @@
    - struct clk *
    + struct clk_hw *
      mtk_clk_register_composite(...) {
	    ...
    -	struct clk *I;
    +	struct clk_hw *hw;
	    ...
    -	I = clk_register_composite(
    +	hw = clk_hw_register_composite(
		    ...);
	    if (IS_ERR(
    -		   I
    +		   hw
		       )) {
		    ...
		    R = PTR_ERR(
    -			      I
    +			      hw
				  );
		    ...
	    }

	    return
    -		I
    +		hw
	    ;
	    ...
      }

    // Fix other mtk_clk_register_<singular> to return clk_hw instead of clk
    @@
    identifier F =~ "^mtk_clk_register_";
    identifier I, D, C;
    expression E;
    @@
    - struct clk *
    + struct clk_hw *
      F(...) {
	    ...
    -	struct clk *I;
    +	int ret;
	    ...
    -	I = clk_register(D, E);
    +	ret = clk_hw_register(D, E);
	    ...
    (
    -	if (IS_ERR(I))
    +	if (ret) {
		    kfree(C);
    +		return ERR_PTR(ret);
    +	}
    |
    -	if (IS_ERR(I))
    +	if (ret)
	    {
		    kfree(C);
    -		return I;
    +		return ERR_PTR(ret);
	    }
    )

    -	return I;
    +	return E;
      }

    // Fix mtk_clk_unregister_<singular> to take clk_hw instead of clk
    @@
    identifier F =~ "^mtk_clk_unregister_";
    identifier I, I2;
    @@
      static void F(
    - 	struct clk *I
    +	struct clk_hw *I2
      )
      {
	    ...
    -	struct clk_hw *I2;
	    ...
    -	I2 = __clk_get_hw(I);
	    ...
    (
    -	clk_unregister(I);
    +	clk_hw_unregister(I2);
    |
    -	clk_unregister_composite(I);
    +	clk_hw_unregister_composite(I2);
    )
	    ...
      }

    // Fix calls to mtk_clk_unregister_*()
    @@
    identifier F =~ "^mtk_clk_unregister_";
    expression I;
    expression E;
    @@
    - F(I->hws[E]->clk);
    + F(I->hws[E]);

Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
 drivers/clk/mediatek/clk-apmixed.c | 12 +++--
 drivers/clk/mediatek/clk-cpumux.c  | 36 +++++++-------
 drivers/clk/mediatek/clk-gate.c    | 36 +++++++-------
 drivers/clk/mediatek/clk-mtk.c     | 76 +++++++++++++++---------------
 drivers/clk/mediatek/clk-mtk.h     |  2 +-
 drivers/clk/mediatek/clk-mux.c     | 36 +++++++-------
 drivers/clk/mediatek/clk-pll.c     | 35 +++++++-------
 7 files changed, 118 insertions(+), 115 deletions(-)

diff --git a/drivers/clk/mediatek/clk-apmixed.c b/drivers/clk/mediatek/clk-apmixed.c
index 06400c043fe7..fc3d4146f482 100644
--- a/drivers/clk/mediatek/clk-apmixed.c
+++ b/drivers/clk/mediatek/clk-apmixed.c
@@ -70,12 +70,12 @@ static const struct clk_ops mtk_ref2usb_tx_ops = {
 	.unprepare	= mtk_ref2usb_tx_unprepare,
 };
 
-struct clk * __init mtk_clk_register_ref2usb_tx(const char *name,
+struct clk_hw * __init mtk_clk_register_ref2usb_tx(const char *name,
 			const char *parent_name, void __iomem *reg)
 {
 	struct mtk_ref2usb_tx *tx;
 	struct clk_init_data init = {};
-	struct clk *clk;
+	int ret;
 
 	tx = kzalloc(sizeof(*tx), GFP_KERNEL);
 	if (!tx)
@@ -89,12 +89,14 @@ struct clk * __init mtk_clk_register_ref2usb_tx(const char *name,
 	init.parent_names = &parent_name;
 	init.num_parents = 1;
 
-	clk = clk_register(NULL, &tx->hw);
+	ret = clk_hw_register(NULL, &tx->hw);
 
-	if (IS_ERR(clk))
+	if (ret) {
 		kfree(tx);
+		return ERR_PTR(ret);
+	}
 
-	return clk;
+	return &tx->hw;
 }
 
 MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-cpumux.c b/drivers/clk/mediatek/clk-cpumux.c
index 8e80df43e356..2b5d48591738 100644
--- a/drivers/clk/mediatek/clk-cpumux.c
+++ b/drivers/clk/mediatek/clk-cpumux.c
@@ -57,12 +57,12 @@ static const struct clk_ops clk_cpumux_ops = {
 	.set_parent = clk_cpumux_set_parent,
 };
 
-static struct clk *
+static struct clk_hw *
 mtk_clk_register_cpumux(const struct mtk_composite *mux,
 			struct regmap *regmap)
 {
 	struct mtk_clk_cpumux *cpumux;
-	struct clk *clk;
+	int ret;
 	struct clk_init_data init;
 
 	cpumux = kzalloc(sizeof(*cpumux), GFP_KERNEL);
@@ -81,25 +81,24 @@ mtk_clk_register_cpumux(const struct mtk_composite *mux,
 	cpumux->regmap = regmap;
 	cpumux->hw.init = &init;
 
-	clk = clk_register(NULL, &cpumux->hw);
-	if (IS_ERR(clk))
+	ret = clk_hw_register(NULL, &cpumux->hw);
+	if (ret) {
 		kfree(cpumux);
+		return ERR_PTR(ret);
+	}
 
-	return clk;
+	return &cpumux->hw;
 }
 
-static void mtk_clk_unregister_cpumux(struct clk *clk)
+static void mtk_clk_unregister_cpumux(struct clk_hw *hw)
 {
 	struct mtk_clk_cpumux *cpumux;
-	struct clk_hw *hw;
-
-	hw = __clk_get_hw(clk);
 	if (!hw)
 		return;
 
 	cpumux = to_mtk_clk_cpumux(hw);
 
-	clk_unregister(clk);
+	clk_hw_unregister(hw);
 	kfree(cpumux);
 }
 
@@ -108,7 +107,7 @@ int mtk_clk_register_cpumuxes(struct device_node *node,
 			      struct clk_hw_onecell_data *clk_data)
 {
 	int i;
-	struct clk *clk;
+	struct clk_hw *hw;
 	struct regmap *regmap;
 
 	regmap = device_node_to_regmap(node);
@@ -126,13 +125,14 @@ int mtk_clk_register_cpumuxes(struct device_node *node,
 			continue;
 		}
 
-		clk = mtk_clk_register_cpumux(mux, regmap);
-		if (IS_ERR(clk)) {
-			pr_err("Failed to register clk %s: %pe\n", mux->name, clk);
+		hw = mtk_clk_register_cpumux(mux, regmap);
+		if (IS_ERR(hw)) {
+			pr_err("Failed to register clk %s: %pe\n", mux->name,
+			       hw);
 			goto err;
 		}
 
-		clk_data->hws[mux->id] = __clk_get_hw(clk);
+		clk_data->hws[mux->id] = hw;
 	}
 
 	return 0;
@@ -144,11 +144,11 @@ int mtk_clk_register_cpumuxes(struct device_node *node,
 		if (IS_ERR_OR_NULL(clk_data->hws[mux->id]))
 			continue;
 
-		mtk_clk_unregister_cpumux(clk_data->hws[mux->id]->clk);
+		mtk_clk_unregister_cpumux(clk_data->hws[mux->id]);
 		clk_data->hws[mux->id] = ERR_PTR(-ENOENT);
 	}
 
-	return PTR_ERR(clk);
+	return PTR_ERR(hw);
 }
 
 void mtk_clk_unregister_cpumuxes(const struct mtk_composite *clks, int num,
@@ -162,7 +162,7 @@ void mtk_clk_unregister_cpumuxes(const struct mtk_composite *clks, int num,
 		if (IS_ERR_OR_NULL(clk_data->hws[mux->id]))
 			continue;
 
-		mtk_clk_unregister_cpumux(clk_data->hws[mux->id]->clk);
+		mtk_clk_unregister_cpumux(clk_data->hws[mux->id]);
 		clk_data->hws[mux->id] = ERR_PTR(-ENOENT);
 	}
 }
diff --git a/drivers/clk/mediatek/clk-gate.c b/drivers/clk/mediatek/clk-gate.c
index 0955cace5b1b..421806236228 100644
--- a/drivers/clk/mediatek/clk-gate.c
+++ b/drivers/clk/mediatek/clk-gate.c
@@ -152,7 +152,7 @@ const struct clk_ops mtk_clk_gate_ops_no_setclr_inv = {
 };
 EXPORT_SYMBOL_GPL(mtk_clk_gate_ops_no_setclr_inv);
 
-static struct clk *mtk_clk_register_gate(const char *name,
+static struct clk_hw *mtk_clk_register_gate(const char *name,
 					 const char *parent_name,
 					 struct regmap *regmap, int set_ofs,
 					 int clr_ofs, int sta_ofs, u8 bit,
@@ -160,7 +160,7 @@ static struct clk *mtk_clk_register_gate(const char *name,
 					 unsigned long flags, struct device *dev)
 {
 	struct mtk_clk_gate *cg;
-	struct clk *clk;
+	int ret;
 	struct clk_init_data init = {};
 
 	cg = kzalloc(sizeof(*cg), GFP_KERNEL);
@@ -181,25 +181,24 @@ static struct clk *mtk_clk_register_gate(const char *name,
 
 	cg->hw.init = &init;
 
-	clk = clk_register(dev, &cg->hw);
-	if (IS_ERR(clk))
+	ret = clk_hw_register(dev, &cg->hw);
+	if (ret) {
 		kfree(cg);
+		return ERR_PTR(ret);
+	}
 
-	return clk;
+	return &cg->hw;
 }
 
-static void mtk_clk_unregister_gate(struct clk *clk)
+static void mtk_clk_unregister_gate(struct clk_hw *hw)
 {
 	struct mtk_clk_gate *cg;
-	struct clk_hw *hw;
-
-	hw = __clk_get_hw(clk);
 	if (!hw)
 		return;
 
 	cg = to_mtk_clk_gate(hw);
 
-	clk_unregister(clk);
+	clk_hw_unregister(hw);
 	kfree(cg);
 }
 
@@ -209,7 +208,7 @@ int mtk_clk_register_gates_with_dev(struct device_node *node,
 				    struct device *dev)
 {
 	int i;
-	struct clk *clk;
+	struct clk_hw *hw;
 	struct regmap *regmap;
 
 	if (!clk_data)
@@ -230,7 +229,7 @@ int mtk_clk_register_gates_with_dev(struct device_node *node,
 			continue;
 		}
 
-		clk = mtk_clk_register_gate(gate->name, gate->parent_name,
+		hw = mtk_clk_register_gate(gate->name, gate->parent_name,
 					    regmap,
 					    gate->regs->set_ofs,
 					    gate->regs->clr_ofs,
@@ -238,12 +237,13 @@ int mtk_clk_register_gates_with_dev(struct device_node *node,
 					    gate->shift, gate->ops,
 					    gate->flags, dev);
 
-		if (IS_ERR(clk)) {
-			pr_err("Failed to register clk %s: %pe\n", gate->name, clk);
+		if (IS_ERR(hw)) {
+			pr_err("Failed to register clk %s: %pe\n", gate->name,
+			       hw);
 			goto err;
 		}
 
-		clk_data->hws[gate->id] = __clk_get_hw(clk);
+		clk_data->hws[gate->id] = hw;
 	}
 
 	return 0;
@@ -255,11 +255,11 @@ int mtk_clk_register_gates_with_dev(struct device_node *node,
 		if (IS_ERR_OR_NULL(clk_data->hws[gate->id]))
 			continue;
 
-		mtk_clk_unregister_gate(clk_data->hws[gate->id]->clk);
+		mtk_clk_unregister_gate(clk_data->hws[gate->id]);
 		clk_data->hws[gate->id] = ERR_PTR(-ENOENT);
 	}
 
-	return PTR_ERR(clk);
+	return PTR_ERR(hw);
 }
 
 int mtk_clk_register_gates(struct device_node *node,
@@ -284,7 +284,7 @@ void mtk_clk_unregister_gates(const struct mtk_gate *clks, int num,
 		if (IS_ERR_OR_NULL(clk_data->hws[gate->id]))
 			continue;
 
-		mtk_clk_unregister_gate(clk_data->hws[gate->id]->clk);
+		mtk_clk_unregister_gate(clk_data->hws[gate->id]);
 		clk_data->hws[gate->id] = ERR_PTR(-ENOENT);
 	}
 }
diff --git a/drivers/clk/mediatek/clk-mtk.c b/drivers/clk/mediatek/clk-mtk.c
index cfcf740e4e68..b9188000ab3c 100644
--- a/drivers/clk/mediatek/clk-mtk.c
+++ b/drivers/clk/mediatek/clk-mtk.c
@@ -46,7 +46,7 @@ int mtk_clk_register_fixed_clks(const struct mtk_fixed_clk *clks, int num,
 				struct clk_hw_onecell_data *clk_data)
 {
 	int i;
-	struct clk *clk;
+	struct clk_hw *hw;
 
 	if (!clk_data)
 		return -ENOMEM;
@@ -59,15 +59,16 @@ int mtk_clk_register_fixed_clks(const struct mtk_fixed_clk *clks, int num,
 			continue;
 		}
 
-		clk = clk_register_fixed_rate(NULL, rc->name, rc->parent, 0,
+		hw = clk_hw_register_fixed_rate(NULL, rc->name, rc->parent, 0,
 					      rc->rate);
 
-		if (IS_ERR(clk)) {
-			pr_err("Failed to register clk %s: %pe\n", rc->name, clk);
+		if (IS_ERR(hw)) {
+			pr_err("Failed to register clk %s: %pe\n", rc->name,
+			       hw);
 			goto err;
 		}
 
-		clk_data->hws[rc->id] = __clk_get_hw(clk);
+		clk_data->hws[rc->id] = hw;
 	}
 
 	return 0;
@@ -83,7 +84,7 @@ int mtk_clk_register_fixed_clks(const struct mtk_fixed_clk *clks, int num,
 		clk_data->hws[rc->id] = ERR_PTR(-ENOENT);
 	}
 
-	return PTR_ERR(clk);
+	return PTR_ERR(hw);
 }
 EXPORT_SYMBOL_GPL(mtk_clk_register_fixed_clks);
 
@@ -111,7 +112,7 @@ int mtk_clk_register_factors(const struct mtk_fixed_factor *clks, int num,
 			     struct clk_hw_onecell_data *clk_data)
 {
 	int i;
-	struct clk *clk;
+	struct clk_hw *hw;
 
 	if (!clk_data)
 		return -ENOMEM;
@@ -124,15 +125,16 @@ int mtk_clk_register_factors(const struct mtk_fixed_factor *clks, int num,
 			continue;
 		}
 
-		clk = clk_register_fixed_factor(NULL, ff->name, ff->parent_name,
+		hw = clk_hw_register_fixed_factor(NULL, ff->name, ff->parent_name,
 				CLK_SET_RATE_PARENT, ff->mult, ff->div);
 
-		if (IS_ERR(clk)) {
-			pr_err("Failed to register clk %s: %pe\n", ff->name, clk);
+		if (IS_ERR(hw)) {
+			pr_err("Failed to register clk %s: %pe\n", ff->name,
+			       hw);
 			goto err;
 		}
 
-		clk_data->hws[ff->id] = __clk_get_hw(clk);
+		clk_data->hws[ff->id] = hw;
 	}
 
 	return 0;
@@ -148,7 +150,7 @@ int mtk_clk_register_factors(const struct mtk_fixed_factor *clks, int num,
 		clk_data->hws[ff->id] = ERR_PTR(-ENOENT);
 	}
 
-	return PTR_ERR(clk);
+	return PTR_ERR(hw);
 }
 EXPORT_SYMBOL_GPL(mtk_clk_register_factors);
 
@@ -172,10 +174,10 @@ void mtk_clk_unregister_factors(const struct mtk_fixed_factor *clks, int num,
 }
 EXPORT_SYMBOL_GPL(mtk_clk_unregister_factors);
 
-static struct clk *mtk_clk_register_composite(const struct mtk_composite *mc,
+static struct clk_hw *mtk_clk_register_composite(const struct mtk_composite *mc,
 		void __iomem *base, spinlock_t *lock)
 {
-	struct clk *clk;
+	struct clk_hw *hw;
 	struct clk_mux *mux = NULL;
 	struct clk_gate *gate = NULL;
 	struct clk_divider *div = NULL;
@@ -239,18 +241,18 @@ static struct clk *mtk_clk_register_composite(const struct mtk_composite *mc,
 		div_ops = &clk_divider_ops;
 	}
 
-	clk = clk_register_composite(NULL, mc->name, parent_names, num_parents,
+	hw = clk_hw_register_composite(NULL, mc->name, parent_names, num_parents,
 		mux_hw, mux_ops,
 		div_hw, div_ops,
 		gate_hw, gate_ops,
 		mc->flags);
 
-	if (IS_ERR(clk)) {
-		ret = PTR_ERR(clk);
+	if (IS_ERR(hw)) {
+		ret = PTR_ERR(hw);
 		goto err_out;
 	}
 
-	return clk;
+	return hw;
 err_out:
 	kfree(div);
 	kfree(gate);
@@ -259,15 +261,13 @@ static struct clk *mtk_clk_register_composite(const struct mtk_composite *mc,
 	return ERR_PTR(ret);
 }
 
-static void mtk_clk_unregister_composite(struct clk *clk)
+static void mtk_clk_unregister_composite(struct clk_hw *hw)
 {
-	struct clk_hw *hw;
 	struct clk_composite *composite;
 	struct clk_mux *mux = NULL;
 	struct clk_gate *gate = NULL;
 	struct clk_divider *div = NULL;
 
-	hw = __clk_get_hw(clk);
 	if (!hw)
 		return;
 
@@ -279,7 +279,7 @@ static void mtk_clk_unregister_composite(struct clk *clk)
 	if (composite->rate_hw)
 		div = to_clk_divider(composite->rate_hw);
 
-	clk_unregister_composite(clk);
+	clk_hw_unregister_composite(hw);
 	kfree(div);
 	kfree(gate);
 	kfree(mux);
@@ -289,7 +289,7 @@ int mtk_clk_register_composites(const struct mtk_composite *mcs, int num,
 				void __iomem *base, spinlock_t *lock,
 				struct clk_hw_onecell_data *clk_data)
 {
-	struct clk *clk;
+	struct clk_hw *hw;
 	int i;
 
 	if (!clk_data)
@@ -304,14 +304,15 @@ int mtk_clk_register_composites(const struct mtk_composite *mcs, int num,
 			continue;
 		}
 
-		clk = mtk_clk_register_composite(mc, base, lock);
+		hw = mtk_clk_register_composite(mc, base, lock);
 
-		if (IS_ERR(clk)) {
-			pr_err("Failed to register clk %s: %pe\n", mc->name, clk);
+		if (IS_ERR(hw)) {
+			pr_err("Failed to register clk %s: %pe\n", mc->name,
+			       hw);
 			goto err;
 		}
 
-		clk_data->hws[mc->id] = __clk_get_hw(clk);
+		clk_data->hws[mc->id] = hw;
 	}
 
 	return 0;
@@ -323,11 +324,11 @@ int mtk_clk_register_composites(const struct mtk_composite *mcs, int num,
 		if (IS_ERR_OR_NULL(clk_data->hws[mcs->id]))
 			continue;
 
-		mtk_clk_unregister_composite(clk_data->hws[mc->id]->clk);
+		mtk_clk_unregister_composite(clk_data->hws[mc->id]);
 		clk_data->hws[mc->id] = ERR_PTR(-ENOENT);
 	}
 
-	return PTR_ERR(clk);
+	return PTR_ERR(hw);
 }
 EXPORT_SYMBOL_GPL(mtk_clk_register_composites);
 
@@ -345,7 +346,7 @@ void mtk_clk_unregister_composites(const struct mtk_composite *mcs, int num,
 		if (IS_ERR_OR_NULL(clk_data->hws[mc->id]))
 			continue;
 
-		mtk_clk_unregister_composite(clk_data->hws[mc->id]->clk);
+		mtk_clk_unregister_composite(clk_data->hws[mc->id]);
 		clk_data->hws[mc->id] = ERR_PTR(-ENOENT);
 	}
 }
@@ -355,7 +356,7 @@ int mtk_clk_register_dividers(const struct mtk_clk_divider *mcds, int num,
 			      void __iomem *base, spinlock_t *lock,
 			      struct clk_hw_onecell_data *clk_data)
 {
-	struct clk *clk;
+	struct clk_hw *hw;
 	int i;
 
 	if (!clk_data)
@@ -370,16 +371,17 @@ int mtk_clk_register_dividers(const struct mtk_clk_divider *mcds, int num,
 			continue;
 		}
 
-		clk = clk_register_divider(NULL, mcd->name, mcd->parent_name,
+		hw = clk_hw_register_divider(NULL, mcd->name, mcd->parent_name,
 			mcd->flags, base +  mcd->div_reg, mcd->div_shift,
 			mcd->div_width, mcd->clk_divider_flags, lock);
 
-		if (IS_ERR(clk)) {
-			pr_err("Failed to register clk %s: %pe\n", mcd->name, clk);
+		if (IS_ERR(hw)) {
+			pr_err("Failed to register clk %s: %pe\n", mcd->name,
+			       hw);
 			goto err;
 		}
 
-		clk_data->hws[mcd->id] = __clk_get_hw(clk);
+		clk_data->hws[mcd->id] = hw;
 	}
 
 	return 0;
@@ -391,11 +393,11 @@ int mtk_clk_register_dividers(const struct mtk_clk_divider *mcds, int num,
 		if (IS_ERR_OR_NULL(clk_data->hws[mcd->id]))
 			continue;
 
-		mtk_clk_unregister_composite(clk_data->hws[mcd->id]->clk);
+		mtk_clk_unregister_composite(clk_data->hws[mcd->id]);
 		clk_data->hws[mcd->id] = ERR_PTR(-ENOENT);
 	}
 
-	return PTR_ERR(clk);
+	return PTR_ERR(hw);
 }
 
 void mtk_clk_unregister_dividers(const struct mtk_clk_divider *mcds, int num,
diff --git a/drivers/clk/mediatek/clk-mtk.h b/drivers/clk/mediatek/clk-mtk.h
index e736420170a2..adb1304d35d4 100644
--- a/drivers/clk/mediatek/clk-mtk.h
+++ b/drivers/clk/mediatek/clk-mtk.h
@@ -184,7 +184,7 @@ void mtk_clk_unregister_dividers(const struct mtk_clk_divider *mcds, int num,
 struct clk_hw_onecell_data *mtk_alloc_clk_data(unsigned int clk_num);
 void mtk_free_clk_data(struct clk_hw_onecell_data *clk_data);
 
-struct clk *mtk_clk_register_ref2usb_tx(const char *name,
+struct clk_hw *mtk_clk_register_ref2usb_tx(const char *name,
 			const char *parent_name, void __iomem *reg);
 
 void mtk_register_reset_controller(struct device_node *np,
diff --git a/drivers/clk/mediatek/clk-mux.c b/drivers/clk/mediatek/clk-mux.c
index 2f47e59cc528..cd5f9fd8cb98 100644
--- a/drivers/clk/mediatek/clk-mux.c
+++ b/drivers/clk/mediatek/clk-mux.c
@@ -143,13 +143,13 @@ const struct clk_ops mtk_mux_gate_clr_set_upd_ops  = {
 };
 EXPORT_SYMBOL_GPL(mtk_mux_gate_clr_set_upd_ops);
 
-static struct clk *mtk_clk_register_mux(const struct mtk_mux *mux,
+static struct clk_hw *mtk_clk_register_mux(const struct mtk_mux *mux,
 				 struct regmap *regmap,
 				 spinlock_t *lock)
 {
 	struct mtk_clk_mux *clk_mux;
 	struct clk_init_data init = {};
-	struct clk *clk;
+	int ret;
 
 	clk_mux = kzalloc(sizeof(*clk_mux), GFP_KERNEL);
 	if (!clk_mux)
@@ -166,27 +166,24 @@ static struct clk *mtk_clk_register_mux(const struct mtk_mux *mux,
 	clk_mux->lock = lock;
 	clk_mux->hw.init = &init;
 
-	clk = clk_register(NULL, &clk_mux->hw);
-	if (IS_ERR(clk)) {
+	ret = clk_hw_register(NULL, &clk_mux->hw);
+	if (ret) {
 		kfree(clk_mux);
-		return clk;
+		return ERR_PTR(ret);
 	}
 
-	return clk;
+	return &clk_mux->hw;
 }
 
-static void mtk_clk_unregister_mux(struct clk *clk)
+static void mtk_clk_unregister_mux(struct clk_hw *hw)
 {
 	struct mtk_clk_mux *mux;
-	struct clk_hw *hw;
-
-	hw = __clk_get_hw(clk);
 	if (!hw)
 		return;
 
 	mux = to_mtk_clk_mux(hw);
 
-	clk_unregister(clk);
+	clk_hw_unregister(hw);
 	kfree(mux);
 }
 
@@ -196,7 +193,7 @@ int mtk_clk_register_muxes(const struct mtk_mux *muxes,
 			   struct clk_hw_onecell_data *clk_data)
 {
 	struct regmap *regmap;
-	struct clk *clk;
+	struct clk_hw *hw;
 	int i;
 
 	regmap = device_node_to_regmap(node);
@@ -214,14 +211,15 @@ int mtk_clk_register_muxes(const struct mtk_mux *muxes,
 			continue;
 		}
 
-		clk = mtk_clk_register_mux(mux, regmap, lock);
+		hw = mtk_clk_register_mux(mux, regmap, lock);
 
-		if (IS_ERR(clk)) {
-			pr_err("Failed to register clk %s: %pe\n", mux->name, clk);
+		if (IS_ERR(hw)) {
+			pr_err("Failed to register clk %s: %pe\n", mux->name,
+			       hw);
 			goto err;
 		}
 
-		clk_data->hws[mux->id] = __clk_get_hw(clk);
+		clk_data->hws[mux->id] = hw;
 	}
 
 	return 0;
@@ -233,11 +231,11 @@ int mtk_clk_register_muxes(const struct mtk_mux *muxes,
 		if (IS_ERR_OR_NULL(clk_data->hws[mux->id]))
 			continue;
 
-		mtk_clk_unregister_mux(clk_data->hws[mux->id]->clk);
+		mtk_clk_unregister_mux(clk_data->hws[mux->id]);
 		clk_data->hws[mux->id] = ERR_PTR(-ENOENT);
 	}
 
-	return PTR_ERR(clk);
+	return PTR_ERR(hw);
 }
 EXPORT_SYMBOL_GPL(mtk_clk_register_muxes);
 
@@ -255,7 +253,7 @@ void mtk_clk_unregister_muxes(const struct mtk_mux *muxes, int num,
 		if (IS_ERR_OR_NULL(clk_data->hws[mux->id]))
 			continue;
 
-		mtk_clk_unregister_mux(clk_data->hws[mux->id]->clk);
+		mtk_clk_unregister_mux(clk_data->hws[mux->id]);
 		clk_data->hws[mux->id] = ERR_PTR(-ENOENT);
 	}
 }
diff --git a/drivers/clk/mediatek/clk-pll.c b/drivers/clk/mediatek/clk-pll.c
index 89350a1a158c..cabdf25a27f3 100644
--- a/drivers/clk/mediatek/clk-pll.c
+++ b/drivers/clk/mediatek/clk-pll.c
@@ -314,12 +314,12 @@ static const struct clk_ops mtk_pll_ops = {
 	.set_rate	= mtk_pll_set_rate,
 };
 
-static struct clk *mtk_clk_register_pll(const struct mtk_pll_data *data,
+static struct clk_hw *mtk_clk_register_pll(const struct mtk_pll_data *data,
 		void __iomem *base)
 {
 	struct mtk_clk_pll *pll;
 	struct clk_init_data init = {};
-	struct clk *clk;
+	int ret;
 	const char *parent_name = "clk26m";
 
 	pll = kzalloc(sizeof(*pll), GFP_KERNEL);
@@ -354,26 +354,26 @@ static struct clk *mtk_clk_register_pll(const struct mtk_pll_data *data,
 		init.parent_names = &parent_name;
 	init.num_parents = 1;
 
-	clk = clk_register(NULL, &pll->hw);
+	ret = clk_hw_register(NULL, &pll->hw);
 
-	if (IS_ERR(clk))
+	if (ret) {
 		kfree(pll);
+		return ERR_PTR(ret);
+	}
 
-	return clk;
+	return &pll->hw;
 }
 
-static void mtk_clk_unregister_pll(struct clk *clk)
+static void mtk_clk_unregister_pll(struct clk_hw *hw)
 {
-	struct clk_hw *hw;
 	struct mtk_clk_pll *pll;
 
-	hw = __clk_get_hw(clk);
 	if (!hw)
 		return;
 
 	pll = to_mtk_clk_pll(hw);
 
-	clk_unregister(clk);
+	clk_hw_unregister(hw);
 	kfree(pll);
 }
 
@@ -383,7 +383,7 @@ int mtk_clk_register_plls(struct device_node *node,
 {
 	void __iomem *base;
 	int i;
-	struct clk *clk;
+	struct clk_hw *hw;
 
 	base = of_iomap(node, 0);
 	if (!base) {
@@ -400,14 +400,15 @@ int mtk_clk_register_plls(struct device_node *node,
 			continue;
 		}
 
-		clk = mtk_clk_register_pll(pll, base);
+		hw = mtk_clk_register_pll(pll, base);
 
-		if (IS_ERR(clk)) {
-			pr_err("Failed to register clk %s: %pe\n", pll->name, clk);
+		if (IS_ERR(hw)) {
+			pr_err("Failed to register clk %s: %pe\n", pll->name,
+			       hw);
 			goto err;
 		}
 
-		clk_data->hws[pll->id] = __clk_get_hw(clk);
+		clk_data->hws[pll->id] = hw;
 	}
 
 	return 0;
@@ -416,13 +417,13 @@ int mtk_clk_register_plls(struct device_node *node,
 	while (--i >= 0) {
 		const struct mtk_pll_data *pll = &plls[i];
 
-		mtk_clk_unregister_pll(clk_data->hws[pll->id]->clk);
+		mtk_clk_unregister_pll(clk_data->hws[pll->id]);
 		clk_data->hws[pll->id] = ERR_PTR(-ENOENT);
 	}
 
 	iounmap(base);
 
-	return PTR_ERR(clk);
+	return PTR_ERR(hw);
 }
 EXPORT_SYMBOL_GPL(mtk_clk_register_plls);
 
@@ -457,7 +458,7 @@ void mtk_clk_unregister_plls(const struct mtk_pll_data *plls, int num_plls,
 		 */
 		base = mtk_clk_pll_get_base(clk_data->hws[pll->id], pll);
 
-		mtk_clk_unregister_pll(clk_data->hws[pll->id]->clk);
+		mtk_clk_unregister_pll(clk_data->hws[pll->id]);
 		clk_data->hws[pll->id] = ERR_PTR(-ENOENT);
 	}
 
-- 
2.36.0.rc0.470.gd361397f0d-goog

