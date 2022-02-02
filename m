Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D3A14A721D
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 14:51:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344649AbiBBNut (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 08:50:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344651AbiBBNu1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 08:50:27 -0500
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14032C06175F
        for <linux-kernel@vger.kernel.org>; Wed,  2 Feb 2022 05:50:23 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id d186so1023424pgc.9
        for <linux-kernel@vger.kernel.org>; Wed, 02 Feb 2022 05:50:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UVzLtEErhGtWV1STn1xNEVEnPyyTfBz7V3UiBlfriHg=;
        b=XQ+2EGR/cYRsPyHfBXXF9d1J9msyxxFm800JBKViuiIz+3BmpFAaHWZHT90R5nj5x+
         RaqgfY9Y0tqPoUWPg2ezdtqs+0Lh9Ps6Fnt4cv1CWcOg3OPidhT3t5iYomsoxjX1Z05a
         5RVDJ7Jhed3DlnGH/zsGsgqiHzv4xNt29Wx44=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UVzLtEErhGtWV1STn1xNEVEnPyyTfBz7V3UiBlfriHg=;
        b=4KNitig/NIJDeP6zrbBbRTj/V0anoksAyPEDVGpHJkG3gP0v12LQsb4LHsBRC12nFW
         jkRVh7E5fek0c5rxOuC/dPLRfHLI3Yrp40uD53fWaDE0bAwm/4HKN46IxD/HenY3Lyir
         8PsQ1ecbsftjTEbgw6vKrovffchNMYiHqgN7LyVeDUSsoOAEZXl3UtWpEswfOpI6521G
         um3sb6OMCcB/xEh+yvNtTTQlFnxPCF/+7UVfQNBtqPojiraohwltEpOMs8ZbB6piClNW
         4Aehagl3w1oecKVXOiRCLwkmq+fWRAJMAr8CS93c+Z5D18y6/5g/UDmZobUNTfV2q/vZ
         WUvQ==
X-Gm-Message-State: AOAM531nSpHKxEZx0AUxC3E4xoaH0JXrjLVfrWN48NbrNbEV0A90jWAK
        Oop73rSa9NkoixG/5Ql0JOcK1gw2m7bxtg==
X-Google-Smtp-Source: ABdhPJyE+pAn7gWEZTYj9bqNkprgRbIA8ZjA9M8QTJUnb3pEdI+FzNwtwWMFArF/buYt6wDUM7t07Q==
X-Received: by 2002:a05:6a00:1652:: with SMTP id m18mr17396585pfc.56.1643809822645;
        Wed, 02 Feb 2022 05:50:22 -0800 (PST)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:78b5:214c:c81:b9aa])
        by smtp.gmail.com with ESMTPSA id w19sm27335684pfu.47.2022.02.02.05.50.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Feb 2022 05:50:22 -0800 (PST)
From:   Chen-Yu Tsai <wenst@chromium.org>
To:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Chen-Yu Tsai <wenst@chromium.org>,
        Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        Miles Chen <miles.chen@mediatek.com>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 22/31] clk: mediatek: gate: Implement error handling in register API
Date:   Wed,  2 Feb 2022 21:48:25 +0800
Message-Id: <20220202134834.690675-23-wenst@chromium.org>
X-Mailer: git-send-email 2.35.0.rc2.247.g8bbb082509-goog
In-Reply-To: <20220202134834.690675-1-wenst@chromium.org>
References: <20220202134834.690675-1-wenst@chromium.org>
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
Reviewed-by: Miles Chen <miles.chen@mediatek.com>
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
2.35.0.rc2.247.g8bbb082509-goog

