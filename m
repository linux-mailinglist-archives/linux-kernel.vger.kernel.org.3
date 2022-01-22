Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF1BF496B51
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jan 2022 10:19:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234377AbiAVJTN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jan 2022 04:19:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234136AbiAVJSe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jan 2022 04:18:34 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1068C061756
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jan 2022 01:18:22 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id pf13so11361403pjb.0
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jan 2022 01:18:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OL43s5I7LNHYgmLD2gKEH5DLtt+mhRAmKo34NJ8rtwE=;
        b=Ggo0kYpwoWnwSolmdIbTiIGBqEoKYbbJGe28yVsffQtRCfNStfbzu7ufp6Frh7kLje
         tP7/f8uW+0pNL+bOuvU/y84/uITpHYEb4voWNxDpRawsGCYd/r3YXYAKeQhm0MdB4Mlt
         UhRx3i9YIEqpmxfnvwv7tKZDw0i0XRfWQqIWo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OL43s5I7LNHYgmLD2gKEH5DLtt+mhRAmKo34NJ8rtwE=;
        b=B+r73/D7DuEWE3PX30aQqyg2p4U84V5bjNkE84XWgqtZ1RHURU9vF8O1+uMYAMwdd2
         0t7G40SXks4DD85KnJF53lIbqo4iiHN/FmJxoHAFEo5G5RtpcaU+tMHkY37000q+1/hj
         rnu4/MI9a4VpKubNr/iIurF7oJtqMujcGx3wBJNvPBxxZZ3chslVysqmrWbURWydayCN
         +wpYD/ohtBSadnLgx5o8LlN9y+AAC7j+K4N40RMMNjFXbwJVORYNMNhDSVLaElrQKxWs
         X9wFlltBtCsbwoB4a2GCFRMLu8PWZe85bbfAxsF0uvRFmD5zTVuejZfq2V9QcJp3T9ji
         598g==
X-Gm-Message-State: AOAM533EOMn+xslxPgKCasS2fjIYpWOLt/w7XJoxoweot7HOnv1Uf6NO
        xCGNBRvnNXI1rxkJdmmfG/90AQ==
X-Google-Smtp-Source: ABdhPJxYWG1G6A9uuQSoK+hKtiVNFyIt2rfYZvu/Rc9m92uJiLRu3G1sp2IZGb5nnUAghww4dGPDEA==
X-Received: by 2002:a17:903:32c6:b0:14b:3f5b:e9c6 with SMTP id i6-20020a17090332c600b0014b3f5be9c6mr89273plr.136.1642843102481;
        Sat, 22 Jan 2022 01:18:22 -0800 (PST)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:349f:9373:45d9:eb26])
        by smtp.gmail.com with ESMTPSA id s1sm1608100pjn.42.2022.01.22.01.18.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Jan 2022 01:18:22 -0800 (PST)
From:   Chen-Yu Tsai <wenst@chromium.org>
To:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Chen-Yu Tsai <wenst@chromium.org>,
        Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 17/31] clk: mediatek: Implement mtk_clk_unregister_divider_clks() API
Date:   Sat, 22 Jan 2022 17:17:17 +0800
Message-Id: <20220122091731.283592-18-wenst@chromium.org>
X-Mailer: git-send-email 2.35.0.rc0.227.g00780c9af4-goog
In-Reply-To: <20220122091731.283592-1-wenst@chromium.org>
References: <20220122091731.283592-1-wenst@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mtk_clk_register_divider_clks(), as the name suggests, is used to register
a given list of divider clks. However it is lacking a counterpart
unregister API.

Implement said unregister API so that the various clock platform drivers
can utilize it to do proper unregistration, cleanup and removal.

In the header file, the register function's declaration is also
reformatted to fit code style guidelines.

Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
 drivers/clk/mediatek/clk-mtk.c | 19 +++++++++++++++++++
 drivers/clk/mediatek/clk-mtk.h |  8 +++++---
 2 files changed, 24 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mtk.c b/drivers/clk/mediatek/clk-mtk.c
index b267b2f04b84..3a6dfe445e63 100644
--- a/drivers/clk/mediatek/clk-mtk.c
+++ b/drivers/clk/mediatek/clk-mtk.c
@@ -286,6 +286,25 @@ void mtk_clk_register_dividers(const struct mtk_clk_divider *mcds,
 	}
 }
 
+void mtk_clk_unregister_dividers(const struct mtk_clk_divider *mcds, int num,
+				 struct clk_onecell_data *clk_data)
+{
+	int i;
+
+	if (!clk_data)
+		return;
+
+	for (i = num; i > 0; i--) {
+		const struct mtk_clk_divider *mcd = &mcds[i - 1];
+
+		if (IS_ERR_OR_NULL(clk_data->clks[mcd->id]))
+			continue;
+
+		clk_unregister_divider(clk_data->clks[mcd->id]);
+		clk_data->clks[mcd->id] = ERR_PTR(-ENOENT);
+	}
+}
+
 int mtk_clk_simple_probe(struct platform_device *pdev)
 {
 	const struct mtk_clk_desc *mcd;
diff --git a/drivers/clk/mediatek/clk-mtk.h b/drivers/clk/mediatek/clk-mtk.h
index 4db1a97c1250..e3ae22fb0334 100644
--- a/drivers/clk/mediatek/clk-mtk.h
+++ b/drivers/clk/mediatek/clk-mtk.h
@@ -176,9 +176,11 @@ struct mtk_clk_divider {
 		.div_width = _width,				\
 }
 
-void mtk_clk_register_dividers(const struct mtk_clk_divider *mcds,
-			int num, void __iomem *base, spinlock_t *lock,
-				struct clk_onecell_data *clk_data);
+void mtk_clk_register_dividers(const struct mtk_clk_divider *mcds, int num,
+			       void __iomem *base, spinlock_t *lock,
+			       struct clk_onecell_data *clk_data);
+void mtk_clk_unregister_dividers(const struct mtk_clk_divider *mcds, int num,
+				 struct clk_onecell_data *clk_data);
 
 struct clk_onecell_data *mtk_alloc_clk_data(unsigned int clk_num);
 void mtk_free_clk_data(struct clk_onecell_data *clk_data);
-- 
2.35.0.rc0.227.g00780c9af4-goog

