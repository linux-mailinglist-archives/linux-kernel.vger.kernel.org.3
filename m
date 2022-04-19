Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A9BE50669A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 10:13:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349768AbiDSIPx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 04:15:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239810AbiDSIPo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 04:15:44 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74D602A705
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 01:13:02 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id q3so14704662plg.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 01:13:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dbHuIMp6NqIKnY64hxaFgyNKsnlZfy6+G0wX97Ig5HA=;
        b=J2PrilvtBtshJTW6tcuSuriyrmWtLh1/U8UmkNn/ZRQrKqSR7IRRW7Qqld7f55Q3cf
         rrxhVkgpCFX/NIRsKoR5V/FWv6L94yV5dO9rMil1niuqDOA1a6a+EVEsXV5pYyj1XBE8
         gzq+sQBOxYp86Ov71TzxfQDGnM28PMCBiuEHM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dbHuIMp6NqIKnY64hxaFgyNKsnlZfy6+G0wX97Ig5HA=;
        b=dfGkNrqMsuWGUW2KYka35yWZdJr7YWh+D5R2zs+9txjdlKURcS9wYypno84upOtnJb
         sss1+Hu3cdyAn+krQGjgE+SVz8l4uJuuSpo2cNT6ApkJj6svNUNnE/HelYixsymD+1ly
         nmf4cHUTa0TpYCvOPJ0hLQudiuN/z5u+D948ovBVNL+NUy8h1ibVevA28Zu5+Qe2R8e1
         3Lwwj5PQqzjCSasZJEmYaeHxGD6S944Eu8F6whDDh9nwUm0bK6zbOC466U0F6+Qey67v
         ih/iUJgJxFis4IJ5aleAV48lsaIwBnOuR6e7/J53ufKXZJ0lzJOpGMC978FQMo46iIXF
         4+gA==
X-Gm-Message-State: AOAM532LRPkVhfEAXGFKe7Y/f34xZq3aCvPcl+fkfIyj8+vXyjc6SlPj
        nRFjMjDbQbVPfF6BdPdUUAbO0A==
X-Google-Smtp-Source: ABdhPJzdudJnBxIdIosCr5L+LmZy3jMnoSHD6sH5rSKWIoDdz3HtV2F81M6Us0l2M7ee5fHUZcO46w==
X-Received: by 2002:a17:90a:ce0b:b0:1cd:6fff:8dbc with SMTP id f11-20020a17090ace0b00b001cd6fff8dbcmr17075458pju.212.1650355982018;
        Tue, 19 Apr 2022 01:13:02 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:33f6:f1e6:3e21:a253])
        by smtp.gmail.com with ESMTPSA id n13-20020a654ccd000000b0039db6f73e9dsm15767448pgt.28.2022.04.19.01.13.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Apr 2022 01:13:01 -0700 (PDT)
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
Subject: [RFC PATCH 1/7] clk: mediatek: Make mtk_clk_register_composite() static
Date:   Tue, 19 Apr 2022 16:12:40 +0800
Message-Id: <20220419081246.2546159-2-wenst@chromium.org>
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
2.36.0.rc0.470.gd361397f0d-goog

