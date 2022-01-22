Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B460496B4F
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jan 2022 10:19:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234168AbiAVJSz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jan 2022 04:18:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234103AbiAVJSK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jan 2022 04:18:10 -0500
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89FACC061749
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jan 2022 01:18:09 -0800 (PST)
Received: by mail-qv1-xf35.google.com with SMTP id t7so13603029qvj.0
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jan 2022 01:18:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0spPJqiyNma/JSwRciV7mlMnnEsvRwtK+rQFLo/is08=;
        b=R5I+rW3l2T7KAn4/rCa8lKm7eS2I2p6sSb3KmPPOSFkb/KVSuHM2ugYPUK2urOucUw
         c5fT9x7ax3oC7MX6mJoQlM1ax7e3Szh3BjrHbbzk/rFWLszCC+ly912TNdKHd4RpV+7V
         yJzMESoZicfzqEsL148u85ddGQQPdAixS56Sk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0spPJqiyNma/JSwRciV7mlMnnEsvRwtK+rQFLo/is08=;
        b=SWNGEcIatpiGQFSkmewMUY10R3MMhu4xo4uElJu5c1wHBq7GSiYVuyN8UQNINxP91F
         jqOVp3b9adkdYYJPDt7dvaby+ajDPBlO8Qihsl1Fihggv0c0uHo+FAkEJ8npiRTFLHwh
         h1GglrY+MalKjhLiyf9LlCL/cssrWd5g8SDLsri1WfWuW+l8gFZMCVq7UsvoqV7CK2YN
         hY4uvYmmM+NEK6YVnvjx8THyVGclN9z/6+lg1ecvVW7C/sOhE70uijBRq0tnZ/X9NfQd
         jleugvhegAvHiv6FUO5q56SyczCstjpVUQlr5Vpx0KR4pD4ZfxV/VGe0ZkGBT7AjxXTL
         Tqtg==
X-Gm-Message-State: AOAM530dXSwce0tSOu0pW1Z0t1GxBvqPjmwAVRJgEg8XIjjAl0sNjYaP
        0uVwjsx18c6Es3Qh8dDVWFK/3U8isuiK+Q==
X-Google-Smtp-Source: ABdhPJyVK4Mt3oHJEIY99aJdCQK6gKiDhx4ht4FV9+3LLoe55aexZOXvspZbiR84kJ+rQS5uLuDxzw==
X-Received: by 2002:a05:6a00:2151:b0:4a2:5c9a:f0a9 with SMTP id o17-20020a056a00215100b004a25c9af0a9mr6679544pfk.39.1642843077957;
        Sat, 22 Jan 2022 01:17:57 -0800 (PST)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:349f:9373:45d9:eb26])
        by smtp.gmail.com with ESMTPSA id s1sm1608100pjn.42.2022.01.22.01.17.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Jan 2022 01:17:57 -0800 (PST)
From:   Chen-Yu Tsai <wenst@chromium.org>
To:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Chen-Yu Tsai <wenst@chromium.org>,
        Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 06/31] clk: mediatek: cpumux: Implement unregister API
Date:   Sat, 22 Jan 2022 17:17:06 +0800
Message-Id: <20220122091731.283592-7-wenst@chromium.org>
X-Mailer: git-send-email 2.35.0.rc0.227.g00780c9af4-goog
In-Reply-To: <20220122091731.283592-1-wenst@chromium.org>
References: <20220122091731.283592-1-wenst@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The cpumux clk type within the MediaTek clk driver library only has
a register function, and no corresponding unregister function. This
means there is no way for its users to properly implement cleanup
and removal.

Add a matching unregister function for the cpumux type clk.

Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
 drivers/clk/mediatek/clk-cpumux.c | 31 +++++++++++++++++++++++++++++++
 drivers/clk/mediatek/clk-cpumux.h |  3 +++
 2 files changed, 34 insertions(+)

diff --git a/drivers/clk/mediatek/clk-cpumux.c b/drivers/clk/mediatek/clk-cpumux.c
index cab5095416b6..99a819e3673f 100644
--- a/drivers/clk/mediatek/clk-cpumux.c
+++ b/drivers/clk/mediatek/clk-cpumux.c
@@ -77,6 +77,21 @@ mtk_clk_register_cpumux(const struct mtk_composite *mux,
 	return clk;
 }
 
+static void mtk_clk_unregister_cpumux(struct clk *clk)
+{
+	struct mtk_clk_cpumux *cpumux;
+	struct clk_hw *hw;
+
+	hw = __clk_get_hw(clk);
+	if (!hw)
+		return;
+
+	cpumux = to_mtk_clk_cpumux(hw);
+
+	clk_unregister(clk);
+	kfree(cpumux);
+}
+
 int mtk_clk_register_cpumuxes(struct device_node *node,
 			      const struct mtk_composite *clks, int num,
 			      struct clk_onecell_data *clk_data)
@@ -106,4 +121,20 @@ int mtk_clk_register_cpumuxes(struct device_node *node,
 	return 0;
 }
 
+void mtk_clk_unregister_cpumuxes(const struct mtk_composite *clks, int num,
+				 struct clk_onecell_data *clk_data)
+{
+	int i;
+
+	for (i = num; i > 0; i--) {
+		const struct mtk_composite *mux = &clks[i - 1];
+
+		if (IS_ERR_OR_NULL(clk_data->clks[mux->id]))
+			continue;
+
+		mtk_clk_unregister_cpumux(clk_data->clks[mux->id]);
+		clk_data->clks[mux->id] = ERR_PTR(-ENOENT);
+	}
+}
+
 MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-cpumux.h b/drivers/clk/mediatek/clk-cpumux.h
index 2aaf1afd4e5f..fda7770fd803 100644
--- a/drivers/clk/mediatek/clk-cpumux.h
+++ b/drivers/clk/mediatek/clk-cpumux.h
@@ -19,4 +19,7 @@ int mtk_clk_register_cpumuxes(struct device_node *node,
 			      const struct mtk_composite *clks, int num,
 			      struct clk_onecell_data *clk_data);
 
+void mtk_clk_unregister_cpumuxes(const struct mtk_composite *clks, int num,
+				 struct clk_onecell_data *clk_data);
+
 #endif /* __DRV_CLK_CPUMUX_H */
-- 
2.35.0.rc0.227.g00780c9af4-goog

