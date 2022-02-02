Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C46F4A7223
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 14:51:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344492AbiBBNuT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 08:50:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344578AbiBBNuI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 08:50:08 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF915C06173B
        for <linux-kernel@vger.kernel.org>; Wed,  2 Feb 2022 05:50:08 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id s16so18249613pgs.13
        for <linux-kernel@vger.kernel.org>; Wed, 02 Feb 2022 05:50:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZiK2XIbHygUp2e9+jzr8Jt6sIllwZaRaY/96jv41JNQ=;
        b=QPQOWHGcG0FhTl+ujSaIWEHoxMADagiEXp90XeOlMwZkYwx9ojL8OrJNcHCeyQ8B0U
         R/yXL+qZKdIOKC4LaWKtoAskERPkRqTwhJKOVTUlQAUyxmHvny5/jSM4zTEdrFpqY/iC
         kXk//XSfqc8FbSmSdylQVoRQRUn8lg1tsPcPo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZiK2XIbHygUp2e9+jzr8Jt6sIllwZaRaY/96jv41JNQ=;
        b=E0N+l1Sri6/2NulF1J64EbDe5CZ07btrpnbCdns+0C76mTxlXYFNejbJhUomr+3NAb
         a/FgZGBkULWklmMd8hEugpE8UG2PYto0AuRyDoXrHDiDO3hoeBu+ima6/9kIEI0HzU4B
         LWoVrAIyt5OSL07Up0arUcYW1KBJpA5TLdZajuP0UE2sOcRDvVjanGCOl81Mmk/t/OnB
         5RiwWG76cVD4EJ6BYW16QwFQM72fC5BDiSXq6piTCCGdgj0Y8zNFPYDsLE5RcX9cXlzJ
         9CGHMoj+9TDlTXAab8at8RYS6MtpMglr+PHn3Gz23iOBbyaGxhgY96t+136bB0q3I/Nh
         3sbA==
X-Gm-Message-State: AOAM533b+rQG9xz+LhqPT1wKxG3yCKLn5sJG+k4ir4nU0bYum02OT2Pi
        tHR+PfQfUCyC19GSHDC+p+8oBTdaLpemhQ==
X-Google-Smtp-Source: ABdhPJzwy7/E419LuvX14RpwYTVofcCB4seqnwxBWNGVvuMqYrjsbRzAkFsSwOwwb553aJSU0DlW0A==
X-Received: by 2002:a65:5543:: with SMTP id t3mr24333608pgr.180.1643809808363;
        Wed, 02 Feb 2022 05:50:08 -0800 (PST)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:78b5:214c:c81:b9aa])
        by smtp.gmail.com with ESMTPSA id w19sm27335684pfu.47.2022.02.02.05.50.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Feb 2022 05:50:08 -0800 (PST)
From:   Chen-Yu Tsai <wenst@chromium.org>
To:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Chen-Yu Tsai <wenst@chromium.org>,
        Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        Miles Chen <miles.chen@mediatek.com>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 15/31] clk: mediatek: Implement mtk_clk_unregister_fixed_clks() API
Date:   Wed,  2 Feb 2022 21:48:18 +0800
Message-Id: <20220202134834.690675-16-wenst@chromium.org>
X-Mailer: git-send-email 2.35.0.rc2.247.g8bbb082509-goog
In-Reply-To: <20220202134834.690675-1-wenst@chromium.org>
References: <20220202134834.690675-1-wenst@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mtk_clk_register_fixed_clks(), as the name suggests, is used to register
a given list of fixed rate clks. However it is lacking a counterpart
unregister API.

Implement said unregister API so that the various clock platform drivers
can utilize it to do proper unregistration, cleanup and removal.

In the header file, the register function's declaration is also
reformatted to fit code style guidelines.

Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
Reviewed-by: Miles Chen <miles.chen@mediatek.com>
---
 drivers/clk/mediatek/clk-mtk.c | 20 ++++++++++++++++++++
 drivers/clk/mediatek/clk-mtk.h |  6 ++++--
 2 files changed, 24 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mtk.c b/drivers/clk/mediatek/clk-mtk.c
index 0c5db3c71fdd..7c0d5706eed7 100644
--- a/drivers/clk/mediatek/clk-mtk.c
+++ b/drivers/clk/mediatek/clk-mtk.c
@@ -80,6 +80,26 @@ void mtk_clk_register_fixed_clks(const struct mtk_fixed_clk *clks,
 }
 EXPORT_SYMBOL_GPL(mtk_clk_register_fixed_clks);
 
+void mtk_clk_unregister_fixed_clks(const struct mtk_fixed_clk *clks, int num,
+				   struct clk_onecell_data *clk_data)
+{
+	int i;
+
+	if (!clk_data)
+		return;
+
+	for (i = num; i > 0; i--) {
+		const struct mtk_fixed_clk *rc = &clks[i - 1];
+
+		if (IS_ERR_OR_NULL(clk_data->clks[rc->id]))
+			continue;
+
+		clk_unregister_fixed_rate(clk_data->clks[rc->id]);
+		clk_data->clks[rc->id] = ERR_PTR(-ENOENT);
+	}
+}
+EXPORT_SYMBOL_GPL(mtk_clk_unregister_fixed_clks);
+
 void mtk_clk_register_factors(const struct mtk_fixed_factor *clks,
 		int num, struct clk_onecell_data *clk_data)
 {
diff --git a/drivers/clk/mediatek/clk-mtk.h b/drivers/clk/mediatek/clk-mtk.h
index 168220f85489..cc7f920eabb4 100644
--- a/drivers/clk/mediatek/clk-mtk.h
+++ b/drivers/clk/mediatek/clk-mtk.h
@@ -34,8 +34,10 @@ struct mtk_fixed_clk {
 		.rate = _rate,				\
 	}
 
-void mtk_clk_register_fixed_clks(const struct mtk_fixed_clk *clks,
-		int num, struct clk_onecell_data *clk_data);
+void mtk_clk_register_fixed_clks(const struct mtk_fixed_clk *clks, int num,
+				 struct clk_onecell_data *clk_data);
+void mtk_clk_unregister_fixed_clks(const struct mtk_fixed_clk *clks, int num,
+				   struct clk_onecell_data *clk_data);
 
 struct mtk_fixed_factor {
 	int id;
-- 
2.35.0.rc2.247.g8bbb082509-goog

