Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD1AD5066A6
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 10:14:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349778AbiDSIQC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 04:16:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349750AbiDSIPs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 04:15:48 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B823F2A705
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 01:13:06 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id p8so7865368pfh.8
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 01:13:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aL1HiuRk5yYFz4xYpqYuYGNrqygVF3ZLXtA2aUqysL4=;
        b=LEXJrHEJYkHQYt3+NUC0A2RYl/pLHmHf8+SR4yudcy7lD64IgbmhmJrEGIl/XlRzy4
         rFiaOBuVKdRUMLaZQ8MqVHwLjmsChzcrM5Fxza/aAWSZTJBU0uwdjPJiieKpuVt3zPQA
         jnvnNF57z7vm+bjvNPtYai0snAFLFOleiWlmU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aL1HiuRk5yYFz4xYpqYuYGNrqygVF3ZLXtA2aUqysL4=;
        b=wW607R9u5MlPqr9hatbkq6aSTLLZgWW6MzwSDtzacFQnO2wQ6AmhpBhKGODbKbNQ1P
         tlG7GHS59fZVGzJtp3FbvAeEcWC/CuMuz2EO5yUeDYL8II6H4zhOHk531iDb384jTa6z
         HTwI+HcfbDjAOrfzbCxJVmSPWLgtHxDWeqWYYoW9ErnjLGCGn6L8q3tNwUdi0oBWDByI
         u24+rjFbh0yQ2Ghq2vCNYrVK3BHFnsApAj2ahfSpxZked3ZDlssWKOaLiMBIft6kZo/f
         5KNULcBhN9epWvJqJhlxonbepcD/NiAZe+4vSrOWA8RSXAlPGIy672kSIIrXjyZzisd+
         miXw==
X-Gm-Message-State: AOAM530BXZ24KsuvkJObN+6WlR5/2Ur2Ua+AnzBGEJ671r0mJmvrg/sd
        4HsqSt5w6pj0mqq9LQdvS7L1Kw==
X-Google-Smtp-Source: ABdhPJyIGDt6kZVVNhC1txAP0UdKWo807bFxbSvGZaHWUDQrzAwZFAQAwc4BPI5rullX3UT27dxnFA==
X-Received: by 2002:a63:3841:0:b0:399:26da:29af with SMTP id h1-20020a633841000000b0039926da29afmr13364353pgn.489.1650355986330;
        Tue, 19 Apr 2022 01:13:06 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:33f6:f1e6:3e21:a253])
        by smtp.gmail.com with ESMTPSA id n13-20020a654ccd000000b0039db6f73e9dsm15767448pgt.28.2022.04.19.01.13.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Apr 2022 01:13:06 -0700 (PDT)
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
Subject: [RFC PATCH 3/7] clk: mediatek: Convert mtk_{alloc,free}_clk_data to struct clk_hw
Date:   Tue, 19 Apr 2022 16:12:42 +0800
Message-Id: <20220419081246.2546159-4-wenst@chromium.org>
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

For now, the clk_register() and co. usage is retained, with __clk_get_hw()
and (struct clk_hw *)->clk used to bridge the difference between the APIs.
These will be replaced in subsequent patches.

Fix up mtk_{alloc,free}_clk_data to use 'struct clk_hw' by hand. Fix up
all other affected call sites with coccinelle scripts in the next patch.

Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
 drivers/clk/mediatek/clk-mtk.c | 23 ++++++-----------------
 drivers/clk/mediatek/clk-mtk.h |  4 ++--
 2 files changed, 8 insertions(+), 19 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mtk.c b/drivers/clk/mediatek/clk-mtk.c
index 52bacce5dadd..554c6a128460 100644
--- a/drivers/clk/mediatek/clk-mtk.c
+++ b/drivers/clk/mediatek/clk-mtk.c
@@ -18,40 +18,29 @@
 #include "clk-mtk.h"
 #include "clk-gate.h"
 
-struct clk_onecell_data *mtk_alloc_clk_data(unsigned int clk_num)
+struct clk_hw_onecell_data *mtk_alloc_clk_data(unsigned int clk_num)
 {
 	int i;
 	struct clk_onecell_data *clk_data;
 
-	clk_data = kzalloc(sizeof(*clk_data), GFP_KERNEL);
+	clk_data = kzalloc(struct_size(clk_data, hws, clk_num), GFP_KERNEL);
 	if (!clk_data)
 		return NULL;
 
-	clk_data->clks = kcalloc(clk_num, sizeof(*clk_data->clks), GFP_KERNEL);
-	if (!clk_data->clks)
-		goto err_out;
-
-	clk_data->clk_num = clk_num;
+	clk_data->num = clk_num;
 
 	for (i = 0; i < clk_num; i++)
-		clk_data->clks[i] = ERR_PTR(-ENOENT);
+		clk_data->hws[i] = ERR_PTR(-ENOENT);
 
 	return clk_data;
-err_out:
-	kfree(clk_data);
-
-	return NULL;
 }
 EXPORT_SYMBOL_GPL(mtk_alloc_clk_data);
 
-void mtk_free_clk_data(struct clk_onecell_data *clk_data)
+void mtk_free_clk_data(struct clk_hw_onecell_data *clk_data)
 {
-	if (!clk_data)
-		return;
-
-	kfree(clk_data->clks);
 	kfree(clk_data);
 }
+EXPORT_SYMBOL_GPL(mtk_free_clk_data);
 
 int mtk_clk_register_fixed_clks(const struct mtk_fixed_clk *clks, int num,
 				struct clk_onecell_data *clk_data)
diff --git a/drivers/clk/mediatek/clk-mtk.h b/drivers/clk/mediatek/clk-mtk.h
index 9577084790dc..787fdeb1bd93 100644
--- a/drivers/clk/mediatek/clk-mtk.h
+++ b/drivers/clk/mediatek/clk-mtk.h
@@ -181,8 +181,8 @@ int mtk_clk_register_dividers(const struct mtk_clk_divider *mcds, int num,
 void mtk_clk_unregister_dividers(const struct mtk_clk_divider *mcds, int num,
 				 struct clk_onecell_data *clk_data);
 
-struct clk_onecell_data *mtk_alloc_clk_data(unsigned int clk_num);
-void mtk_free_clk_data(struct clk_onecell_data *clk_data);
+struct clk_hw_onecell_data *mtk_alloc_clk_data(unsigned int clk_num);
+void mtk_free_clk_data(struct clk_hw_onecell_data *clk_data);
 
 struct clk *mtk_clk_register_ref2usb_tx(const char *name,
 			const char *parent_name, void __iomem *reg);
-- 
2.36.0.rc0.470.gd361397f0d-goog

