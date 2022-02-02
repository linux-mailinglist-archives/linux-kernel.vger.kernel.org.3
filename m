Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 173314A720E
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 14:51:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344653AbiBBNu2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 08:50:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344551AbiBBNuB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 08:50:01 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E300EC061756
        for <linux-kernel@vger.kernel.org>; Wed,  2 Feb 2022 05:49:58 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id d187so18835601pfa.10
        for <linux-kernel@vger.kernel.org>; Wed, 02 Feb 2022 05:49:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=koVwH4W47ZnmdMQC+i7F7tu84t6ApcfQpNxUmrQL9bs=;
        b=EUM4BcWxvZOnU+GfCT/HmA+o6iiYZ40xeNYZXdyjB43nQld9ZRzxpOBZJN3lPU1dkh
         nNfqSuXf5AQE4HSoKTJJowRfXBPTAHMVVa4V+AwB2qZoP1hvwei1qItoMr/uwbVyENfO
         R/SOqvzD2gT1TnOw+QeTbgU2hZ08ncFdINjaU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=koVwH4W47ZnmdMQC+i7F7tu84t6ApcfQpNxUmrQL9bs=;
        b=V/p8YhBu3qJftOqvSLkq3W+SK0SsYQlhCb7MCGHwExHeghYTTXU1+R0cF/0Svj1DAK
         yVadW0hx8svExaw39PZJy9QLXC1pkY3rkCW09Tg/Dv+c8q/MFnWxmkIp5CodFyist/TO
         F0RwLGNIACZvnVwUcdWrEUPd6w36qX94yCmXB3graVhEC5Uf+1SoOmhxIi3I95ydh8cA
         Tk3FkEbFXeWYugfnCqdlz9XfOwdKUgscsPSGMhWN8xcwdBPZVXwqvkOHoZG0DOE4iMl3
         LpyI7PlstZHBgWFwtoRL7q8Wcf2tZFksYXfSLpr8hePiW6Lf3ixjujh2P/Iipy3SH7Tl
         u24g==
X-Gm-Message-State: AOAM530EtKA20fzVlKYQWCx504PTYX7613mWthvpfQBQLPnFYbS/ZtCI
        3A/LdwWdOJpF8YkkvldRm3MFAQ==
X-Google-Smtp-Source: ABdhPJxTnVZoIVxU07+X5AzoQO2ik1+O5errakn66KV31/A9bAV8mo0hGkeH+5Qokg4S8y6zDVCYZQ==
X-Received: by 2002:a05:6a00:841:: with SMTP id q1mr8267625pfk.21.1643809798495;
        Wed, 02 Feb 2022 05:49:58 -0800 (PST)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:78b5:214c:c81:b9aa])
        by smtp.gmail.com with ESMTPSA id w19sm27335684pfu.47.2022.02.02.05.49.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Feb 2022 05:49:58 -0800 (PST)
From:   Chen-Yu Tsai <wenst@chromium.org>
To:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Chen-Yu Tsai <wenst@chromium.org>,
        Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        Miles Chen <miles.chen@mediatek.com>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 10/31] clk: mediatek: mux: Internalize struct mtk_clk_mux
Date:   Wed,  2 Feb 2022 21:48:13 +0800
Message-Id: <20220202134834.690675-11-wenst@chromium.org>
X-Mailer: git-send-email 2.35.0.rc2.247.g8bbb082509-goog
In-Reply-To: <20220202134834.690675-1-wenst@chromium.org>
References: <20220202134834.690675-1-wenst@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

struct mtk_clk_mux is an implementation detail of the mux clk type,
and is not used outside of the implementation.

Internalize the definition to minimize leakage of details and shrink
the header file.

Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
Reviewed-by: Miles Chen <miles.chen@mediatek.com>
---
 drivers/clk/mediatek/clk-mux.c | 8 ++++++++
 drivers/clk/mediatek/clk-mux.h | 8 --------
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mux.c b/drivers/clk/mediatek/clk-mux.c
index 6f0c22a699c3..2d4d8dc0120a 100644
--- a/drivers/clk/mediatek/clk-mux.c
+++ b/drivers/clk/mediatek/clk-mux.c
@@ -13,6 +13,14 @@
 #include "clk-mtk.h"
 #include "clk-mux.h"
 
+struct mtk_clk_mux {
+	struct clk_hw hw;
+	struct regmap *regmap;
+	const struct mtk_mux *data;
+	spinlock_t *lock;
+	bool reparent;
+};
+
 static inline struct mtk_clk_mux *to_mtk_clk_mux(struct clk_hw *hw)
 {
 	return container_of(hw, struct mtk_clk_mux, hw);
diff --git a/drivers/clk/mediatek/clk-mux.h b/drivers/clk/mediatek/clk-mux.h
index cb2ac4f04c58..38a2b6014b08 100644
--- a/drivers/clk/mediatek/clk-mux.h
+++ b/drivers/clk/mediatek/clk-mux.h
@@ -9,14 +9,6 @@
 
 #include <linux/clk-provider.h>
 
-struct mtk_clk_mux {
-	struct clk_hw hw;
-	struct regmap *regmap;
-	const struct mtk_mux *data;
-	spinlock_t *lock;
-	bool reparent;
-};
-
 struct mtk_mux {
 	int id;
 	const char *name;
-- 
2.35.0.rc2.247.g8bbb082509-goog

