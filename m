Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C200E521294
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 12:48:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240071AbiEJKw1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 06:52:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240047AbiEJKwL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 06:52:11 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE6711BDD82
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 03:48:14 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id c1-20020a17090a558100b001dca2694f23so1803643pji.3
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 03:48:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XcXvrzCKRkvMjoTglIwrmd9YHvm7gFOZru7ILwv4qWo=;
        b=JCPl8sz3WKzAF/6JbVXUgUBrYQqRTrMd41klY8IAoo/7IqReq+ljf9XEyGlrmxQxRr
         dwezcauH02UwkUZ3jZ58Cp9SCAWLh1sgmQhlBzymcy75BNEmjIL1VC2Nfi6679oyobk8
         DET2xt6zupRMgcL70N/i1rms1dWfzR8l72kkA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XcXvrzCKRkvMjoTglIwrmd9YHvm7gFOZru7ILwv4qWo=;
        b=qaUaXK3CloshNfFJlNjJxHmeWlxn3QfsSEQ1XILNnemSbFsVaI3iDZky5GUZtKilXO
         fq4XmI+SWgZFEDjJRnDl7Ob4g2q9aR3NQhXoKSMVjxEm+QmaddvIn22i1Av4qWhflS4v
         GGaqqvs+VqabTq+afhdGv9MFDvOVywn4KgwhtfFu0YwDHzDn6cfhRwvq3IyDzVc0NPue
         jdiP90XqN19NSAregyyDPj9Q6ZT+NzrH5jpfCC6lgsr3mwvKDD0nosSVmYZt+jMYohrG
         V30ycdmAxL4ayZOgsh9uBUxTYuw/MMDl5lMSnoYqGfDu9hP8NJRQaV4YSR4qBlGwhM5T
         TtcQ==
X-Gm-Message-State: AOAM530O8X/z7b7O4aM+UM8hzKGTbDf7TFcpdIxuCs47L1zOPQ+p2vqd
        5ZRIlHLrCVil1L6qcW16jBR17w==
X-Google-Smtp-Source: ABdhPJySPtnzkVDxD+u43Oe6Tq0fYqhqnm5ETuFJ0osUM/JKHVhbOY16yRdV8PxEiTwXS4avc6lRPw==
X-Received: by 2002:a17:90b:1811:b0:1dc:8d37:b4cb with SMTP id lw17-20020a17090b181100b001dc8d37b4cbmr31065435pjb.101.1652179694256;
        Tue, 10 May 2022 03:48:14 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:6dcd:8578:55cf:2b12])
        by smtp.gmail.com with ESMTPSA id q9-20020a170902e30900b0015e8d4eb21esm1659691plc.104.2022.05.10.03.48.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 May 2022 03:48:14 -0700 (PDT)
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
Subject: [PATCH v2 01/11] clk: mediatek: Make mtk_clk_register_composite() static
Date:   Tue, 10 May 2022 18:47:54 +0800
Message-Id: <20220510104804.544597-2-wenst@chromium.org>
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

mtk_clk_register_composite() is not used anywhere outside of the file it
is defined.

Make it static.

Fixes: 9741b1a68035 ("clk: mediatek: Add initial common clock support for Mediatek SoCs.")
Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
 drivers/clk/mediatek/clk-mtk.c | 2 +-
 drivers/clk/mediatek/clk-mtk.h | 3 ---
 2 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mtk.c b/drivers/clk/mediatek/clk-mtk.c
index b4063261cf56..52bacce5dadd 100644
--- a/drivers/clk/mediatek/clk-mtk.c
+++ b/drivers/clk/mediatek/clk-mtk.c
@@ -183,7 +183,7 @@ void mtk_clk_unregister_factors(const struct mtk_fixed_factor *clks, int num,
 }
 EXPORT_SYMBOL_GPL(mtk_clk_unregister_factors);
 
-struct clk *mtk_clk_register_composite(const struct mtk_composite *mc,
+static struct clk *mtk_clk_register_composite(const struct mtk_composite *mc,
 		void __iomem *base, spinlock_t *lock)
 {
 	struct clk *clk;
diff --git a/drivers/clk/mediatek/clk-mtk.h b/drivers/clk/mediatek/clk-mtk.h
index bf6565aa7319..9577084790dc 100644
--- a/drivers/clk/mediatek/clk-mtk.h
+++ b/drivers/clk/mediatek/clk-mtk.h
@@ -147,9 +147,6 @@ struct mtk_composite {
 		.flags = 0,						\
 	}
 
-struct clk *mtk_clk_register_composite(const struct mtk_composite *mc,
-		void __iomem *base, spinlock_t *lock);
-
 int mtk_clk_register_composites(const struct mtk_composite *mcs, int num,
 				void __iomem *base, spinlock_t *lock,
 				struct clk_onecell_data *clk_data);
-- 
2.36.0.512.ge40c2bad7a-goog

