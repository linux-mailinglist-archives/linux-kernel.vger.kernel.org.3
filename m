Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A98A52129D
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 12:49:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240105AbiEJKwr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 06:52:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240068AbiEJKwU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 06:52:20 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 379AE1DE54D
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 03:48:19 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id o69so15523358pjo.3
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 03:48:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BgslsEogXlKVS6YgmGBau7rB/PozAnQ9JbNWL5WvtzQ=;
        b=eeegiiDyg8zBjp+38Ak4S2h+TENIgN+Wg1Ah92NtPSt0rViIon6zR1UebJEsrRsADM
         HfuuLtPXcMZ2L0ggIUZqyRVeiAQcyLUBZVP778kiDr0O07iJEp3aLviSLwffxd+ddLL3
         l5EhZeuxz/BxsbOAyGC/n5hoY4aK15q8NFlkI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BgslsEogXlKVS6YgmGBau7rB/PozAnQ9JbNWL5WvtzQ=;
        b=pKw2yihr0cNo6sDcdY1Fy29hbGA3Qsq4tM2Af8uEaiVgbH8KmEFbz/qdUMm5oqsL+R
         AK2RS+94WxyRkcCIsOlyQKveq/qbBmFzHEOwhrUTEEpxY+xAQ8tEiiRw67EfR59bRSg6
         /iX5HYLPHJox4jI3eYL6mNyY5+U3u5rqSCzPZOtlBGivn9nDMZcSppX+/E0z4G3107mT
         EuxwNCv4bP/edW0etBTnZMAfj/CiflmqL/X570F84JjPUfGpmdxdnJMA1Yv6eywnQsvS
         NVkR6dpyyIxmzr/Z5cg/VueAuT7LI4VTIVVqrcnCmoOhCjjLW+BMEeQLPdRABFWzIDSk
         1Yjw==
X-Gm-Message-State: AOAM533tJaYG2mhQCB8OvTN4ZeS/Syov+Miv0WQsFG0ewbM3ezOu5Fsz
        hqiIMDpkJVn+XD5TvdNMGPdLbg==
X-Google-Smtp-Source: ABdhPJw10UwOLp67CjDtkNkfRua2MKhIRejC2gaM1vRRb/MptjwBoEt6lU0qbuOUEwpl9bnJ0cubyw==
X-Received: by 2002:a17:902:d896:b0:15e:fb07:ba92 with SMTP id b22-20020a170902d89600b0015efb07ba92mr14461409plz.148.1652179698922;
        Tue, 10 May 2022 03:48:18 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:6dcd:8578:55cf:2b12])
        by smtp.gmail.com with ESMTPSA id q9-20020a170902e30900b0015e8d4eb21esm1659691plc.104.2022.05.10.03.48.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 May 2022 03:48:18 -0700 (PDT)
From:   Chen-Yu Tsai <wenst@chromium.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        Miles Chen <miles.chen@mediatek.com>,
        Rex-BC Chen <rex-bc.chen@mediatek.com>
Cc:     Chen-Yu Tsai <wenst@chromium.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-clk@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 03/11] clk: mediatek: Convert mtk_{alloc,free}_clk_data to struct clk_hw
Date:   Tue, 10 May 2022 18:47:56 +0800
Message-Id: <20220510104804.544597-4-wenst@chromium.org>
X-Mailer: git-send-email 2.36.0.512.ge40c2bad7a-goog
In-Reply-To: <20220510104804.544597-1-wenst@chromium.org>
References: <20220510104804.544597-1-wenst@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
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
2.36.0.512.ge40c2bad7a-goog

