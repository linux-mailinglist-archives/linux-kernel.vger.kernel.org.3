Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71F8A4AD942
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 14:17:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241176AbiBHNQ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 08:16:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358191AbiBHMlL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 07:41:11 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1635BC03FECA
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 04:41:11 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id y5so17713727pfe.4
        for <linux-kernel@vger.kernel.org>; Tue, 08 Feb 2022 04:41:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QqCKqTMNdoAp7+sGE2nBPkF6G+PqsK55lVYsLHkGo/c=;
        b=ldnpoFu3DD5eloRyku85uykx5dM7xP/9mliT08SVLlpMajfgHSGH62rCzJ7c2wiNU9
         tLL99iJhWybm+mEdugFj5TJyCm7plg0oChYxRHmaGsrtcDKb/ToB6sgRmlJ5IYoL4AiX
         +T3px2SJjDdQxkj9GahSUkyDg6YawanCTC39Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QqCKqTMNdoAp7+sGE2nBPkF6G+PqsK55lVYsLHkGo/c=;
        b=HKP8rGFyXP5l8CiG6plplL0kbaXW1qwmW2fcwXeEuvupIg9deczkhy+hqe3e8+VuTi
         627Az4QwGJffw2/cpZB3L7gvZctRWaJihvXckWlWUB098xusma9rkYpaus5Sl+PLUFm/
         TKZng6EumlZG/F0vAfZWUZ8TvcHGLKdG+qIKV6BbOAOh1UOL/uBgGrp0Pa+UBn+Nu3LI
         7/cPB6ab8yH6CiIn3NXxrJ53YBlOJH9gY8Ty81cXB7Q8uTcIGSWZoswjqQ0ymT9tZ1g1
         X3xRhnVXplYv07zqaqtRoKn89PGI6rXTkfsAYuP08WrIjQ+2c41S8dPuDzOYpvBlG4nu
         PEgA==
X-Gm-Message-State: AOAM530WcgZcDEcC2rF2gogkaixZwIFi/rOY4om9IyasOthavgkYLLnd
        2UQR6tqxaHOC9xqWMUwEJ7Zr9A==
X-Google-Smtp-Source: ABdhPJxWcJrY0ZpPqfzhQI+lhqCGqXjIUU+JarLsOFyR0SfIZyB4euS/X0UN+worLnBp2w2IQ1isSg==
X-Received: by 2002:a05:6a00:2283:: with SMTP id f3mr4248506pfe.24.1644324070536;
        Tue, 08 Feb 2022 04:41:10 -0800 (PST)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:41b6:813e:c823:609c])
        by smtp.gmail.com with ESMTPSA id h11sm15056939pfe.214.2022.02.08.04.41.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 04:41:10 -0800 (PST)
From:   Chen-Yu Tsai <wenst@chromium.org>
To:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Chen-Yu Tsai <wenst@chromium.org>,
        Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Miles Chen <miles.chen@mediatek.com>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 10/31] clk: mediatek: mux: Internalize struct mtk_clk_mux
Date:   Tue,  8 Feb 2022 20:40:13 +0800
Message-Id: <20220208124034.414635-11-wenst@chromium.org>
X-Mailer: git-send-email 2.35.0.263.gb82422642f-goog
In-Reply-To: <20220208124034.414635-1-wenst@chromium.org>
References: <20220208124034.414635-1-wenst@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

struct mtk_clk_mux is an implementation detail of the mux clk type,
and is not used outside of the implementation.

Internalize the definition to minimize leakage of details and shrink
the header file.

Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
Reviewed-by: Miles Chen <miles.chen@mediatek.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
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
2.35.0.263.gb82422642f-goog

