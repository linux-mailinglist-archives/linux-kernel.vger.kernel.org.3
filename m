Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F597496B5D
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jan 2022 10:20:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234203AbiAVJT6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jan 2022 04:19:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234116AbiAVJTM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jan 2022 04:19:12 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC3F2C06173B
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jan 2022 01:18:34 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id u10so6522393pfg.10
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jan 2022 01:18:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1TEZ0MfngpjieBK0SXrIypAK0YzHVKnAErn4UHbTrxk=;
        b=G89iIeSLYaSHnG28ej39jy7C6u1UfWz4foTwDQ3HDtc1rwz7fX2NqHJAzXQGdhTaM7
         7dkLHYZsAY363xBWB4t2vrJVLdsj7YQorPuqazaY1Zwn/+TUsRlc6Ic7+WjjdaooeKuk
         gURdzHetX2DAxi4E6qBVou42HNmx++CcJTDEw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1TEZ0MfngpjieBK0SXrIypAK0YzHVKnAErn4UHbTrxk=;
        b=hsaMFdqUBrz3CqQpOKM4GUBRCvPakuCI+iknDrPiqP/369wrroAzsiHk0QURLozTu3
         GXM4zyaDccfr+p4fHR/6W0GhaZTLsAM/yDFMq33X2CSx+/ADlWDaHJ+RcQYGIsgcy6PB
         7RDlL5EoCGXhRQ1O32sTPgcLqRBbeP0uxw6kBS/b6uYAHqdFXhRu37oKGm2THnz3yW/H
         Zr/zckQiNGjyu6vbcLU13moUrZZsxf0x1I9h00fG9mgY0IqZXw5Bd48Gq2rSKEkpDafr
         WaT8LzYnJ2LBkwzSLrMeKxzkODvIdpUzvofSMcKtmo5HMlFEzNHciS/x/f5HaUVEXAyB
         7iDA==
X-Gm-Message-State: AOAM5335Akl/I+W+AVoid+kH8qpRkPWq49wOQycKcvhSfeZeX1BCZjVB
        +kC+WPhUtKLPKQrYaJ4jVXgjag==
X-Google-Smtp-Source: ABdhPJxJiShS15jsyBrH2j+XqBNlWH2MNjyeLX7mBslEBYwQ2NuEg6RU8qADx6ysHah6+FMDvsbf+Q==
X-Received: by 2002:a63:4e5a:: with SMTP id o26mr5497546pgl.272.1642843113500;
        Sat, 22 Jan 2022 01:18:33 -0800 (PST)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:349f:9373:45d9:eb26])
        by smtp.gmail.com with ESMTPSA id s1sm1608100pjn.42.2022.01.22.01.18.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Jan 2022 01:18:33 -0800 (PST)
From:   Chen-Yu Tsai <wenst@chromium.org>
To:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Chen-Yu Tsai <wenst@chromium.org>,
        Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 22/31] clk: mediatek: gate: Implement error handling in register API
Date:   Sat, 22 Jan 2022 17:17:22 +0800
Message-Id: <20220122091731.283592-23-wenst@chromium.org>
X-Mailer: git-send-email 2.35.0.rc0.227.g00780c9af4-goog
In-Reply-To: <20220122091731.283592-1-wenst@chromium.org>
References: <20220122091731.283592-1-wenst@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The gate clk type registration function does not stop or return errors
if any clk failed to be registered, nor does it implement an error
handling path. This may result in a partially working device if any
step failed.

Make the register function return proper error codes, and bail out if
errors occur. Proper cleanup, i.e. unregister any clks that were
successfully registered, is done in the new error path.

Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
 drivers/clk/mediatek/clk-gate.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/mediatek/clk-gate.c b/drivers/clk/mediatek/clk-gate.c
index e8881ae1489a..631ff170b7b9 100644
--- a/drivers/clk/mediatek/clk-gate.c
+++ b/drivers/clk/mediatek/clk-gate.c
@@ -237,13 +237,26 @@ int mtk_clk_register_gates_with_dev(struct device_node *node,
 
 		if (IS_ERR(clk)) {
 			pr_err("Failed to register clk %s: %pe\n", gate->name, clk);
-			continue;
+			goto err;
 		}
 
 		clk_data->clks[gate->id] = clk;
 	}
 
 	return 0;
+
+err:
+	while (--i >= 0) {
+		const struct mtk_gate *gate = &clks[i];
+
+		if (IS_ERR_OR_NULL(clk_data->clks[gate->id]))
+			continue;
+
+		mtk_clk_unregister_gate(clk_data->clks[gate->id]);
+		clk_data->clks[gate->id] = ERR_PTR(-ENOENT);
+	}
+
+	return PTR_ERR(clk);
 }
 
 int mtk_clk_register_gates(struct device_node *node,
-- 
2.35.0.rc0.227.g00780c9af4-goog

