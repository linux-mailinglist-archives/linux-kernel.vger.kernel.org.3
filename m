Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8584C4A71F7
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 14:50:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344501AbiBBNtw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 08:49:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344478AbiBBNtr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 08:49:47 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9CFBC061749
        for <linux-kernel@vger.kernel.org>; Wed,  2 Feb 2022 05:49:46 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id d18so18318275plg.2
        for <linux-kernel@vger.kernel.org>; Wed, 02 Feb 2022 05:49:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OMf5nn0OsphTZ/Hydc0tEKhYqnEvXUsEDc+DYG029q8=;
        b=D1FG1V52XitFXeVkZqAsn3QQZcUCbdgmnDi1C+T4ZeKRV5XYbuCYvD2EJY9qjTKCpb
         MbAGy2uJfxe59OBmHq360f5NmvFRHApC5Al8uvO5R/D4delH7iNnMbbwp8ZOIzZLJFm3
         xz2mFBH6KjdxEslLp3g5Eb9Kekp0dEZku3FL8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OMf5nn0OsphTZ/Hydc0tEKhYqnEvXUsEDc+DYG029q8=;
        b=cGqhU5ErHC3mJ6aLplDBpXuDIFs7lxeT0bgwRMKZN0S+1C3OSTqw21bcZ1qlsHqQvi
         r14Up6r4ViWi9mE8VMeqJYUhUN+aQ9mzMdX1QBLpLQO2WyBhsG3W79gCaFuCYlexvHG5
         Oxfmw2cunUN33W2zyYRhfigwbdlkQdR8aFPhJUuKMmvdnPfjM6zYpYd6r8mZOGEvuVIN
         8INxxqgtsvnJBbUGTtPCI8N/2hjkZQ2omzGneVUBBJew+/aD87VAR2C8gtYHBIWENt7q
         RBjl0YBHHoPR9n/1pNRLpyN1UAEA9ccGLxMWD+wj4OA/XE4oxkBG1jB+og/iTUbByFZH
         tAwg==
X-Gm-Message-State: AOAM530ruKx3mIj8CKPoON+OBK2FR75RSfRJs6UL9oq3TTod2UD8IZ/d
        V3KSXqDw4rFS5DDHEQlObUa/KA==
X-Google-Smtp-Source: ABdhPJzO/sxpRO82Jk6BAZ8mlR/cHgAnt4r+ZC3pxjQmzzd5jN8tM5TqUBAd/Z1uDl1xDWJQs63yKg==
X-Received: by 2002:a17:902:6f10:: with SMTP id w16mr4474576plk.142.1643809786494;
        Wed, 02 Feb 2022 05:49:46 -0800 (PST)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:78b5:214c:c81:b9aa])
        by smtp.gmail.com with ESMTPSA id w19sm27335684pfu.47.2022.02.02.05.49.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Feb 2022 05:49:46 -0800 (PST)
From:   Chen-Yu Tsai <wenst@chromium.org>
To:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Chen-Yu Tsai <wenst@chromium.org>,
        Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        Miles Chen <miles.chen@mediatek.com>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 04/31] clk: mediatek: gate: Implement unregister API
Date:   Wed,  2 Feb 2022 21:48:07 +0800
Message-Id: <20220202134834.690675-5-wenst@chromium.org>
X-Mailer: git-send-email 2.35.0.rc2.247.g8bbb082509-goog
In-Reply-To: <20220202134834.690675-1-wenst@chromium.org>
References: <20220202134834.690675-1-wenst@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The gate clk type within the MediaTek clk driver library only has a
register function, and no corresponding unregister function. This
means there is no way for its users to properly implement cleanup
and removal.

Add a matching unregister function for the gate type clk.

Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
Reviewed-by: Miles Chen <miles.chen@mediatek.com>
---
 drivers/clk/mediatek/clk-gate.c | 35 +++++++++++++++++++++++++++++++++
 drivers/clk/mediatek/clk-gate.h |  3 +++
 2 files changed, 38 insertions(+)

diff --git a/drivers/clk/mediatek/clk-gate.c b/drivers/clk/mediatek/clk-gate.c
index e51cfd8c653c..ed1ad5535d41 100644
--- a/drivers/clk/mediatek/clk-gate.c
+++ b/drivers/clk/mediatek/clk-gate.c
@@ -193,6 +193,21 @@ static struct clk *mtk_clk_register_gate(const char *name,
 	return clk;
 }
 
+static void mtk_clk_unregister_gate(struct clk *clk)
+{
+	struct mtk_clk_gate *cg;
+	struct clk_hw *hw;
+
+	hw = __clk_get_hw(clk);
+	if (!hw)
+		return;
+
+	cg = to_mtk_clk_gate(hw);
+
+	clk_unregister(clk);
+	kfree(cg);
+}
+
 int mtk_clk_register_gates_with_dev(struct device_node *node,
 				    const struct mtk_gate *clks, int num,
 				    struct clk_onecell_data *clk_data,
@@ -244,4 +259,24 @@ int mtk_clk_register_gates(struct device_node *node,
 }
 EXPORT_SYMBOL_GPL(mtk_clk_register_gates);
 
+void mtk_clk_unregister_gates(const struct mtk_gate *clks, int num,
+			      struct clk_onecell_data *clk_data)
+{
+	int i;
+
+	if (!clk_data)
+		return;
+
+	for (i = num; i > 0; i--) {
+		const struct mtk_gate *gate = &clks[i - 1];
+
+		if (IS_ERR_OR_NULL(clk_data->clks[gate->id]))
+			continue;
+
+		mtk_clk_unregister_gate(clk_data->clks[gate->id]);
+		clk_data->clks[gate->id] = ERR_PTR(-ENOENT);
+	}
+}
+EXPORT_SYMBOL_GPL(mtk_clk_unregister_gates);
+
 MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-gate.h b/drivers/clk/mediatek/clk-gate.h
index 3d75521ba20c..344adffb6578 100644
--- a/drivers/clk/mediatek/clk-gate.h
+++ b/drivers/clk/mediatek/clk-gate.h
@@ -55,4 +55,7 @@ int mtk_clk_register_gates_with_dev(struct device_node *node,
 				    struct clk_onecell_data *clk_data,
 				    struct device *dev);
 
+void mtk_clk_unregister_gates(const struct mtk_gate *clks, int num,
+			      struct clk_onecell_data *clk_data);
+
 #endif /* __DRV_CLK_GATE_H */
-- 
2.35.0.rc2.247.g8bbb082509-goog

