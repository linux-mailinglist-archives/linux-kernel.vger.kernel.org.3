Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6657150669F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 10:14:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349799AbiDSIQg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 04:16:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349798AbiDSIQH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 04:16:07 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CE2B2AE39
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 01:13:16 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id be5so14659538plb.13
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 01:13:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ymcXL9mZkOXE1tvy2X8sRlDYOjiY7V/45QxE3N+k/bg=;
        b=d2lwlqxOipd23SNVAohwHf+gxo5amqNUclnUkRETxFfTTn1ZTq3HvQws+brlFkt85c
         Hfof9ZusLxWdVXKJ3l1Gg3TZenarfIXBwbKaK3la2n/LByuTNRdooFo/cte6FrHY39Eq
         9ncMqc58sVmkJwKE9Skxnh51bHyEICko8Uspo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ymcXL9mZkOXE1tvy2X8sRlDYOjiY7V/45QxE3N+k/bg=;
        b=U1h7T/B09aCkzbbm14cLYbyByG1WvzqO7HVTicM8sWIhkxKLhBCboWw7qanLYyrQbZ
         cRxDf3SozMsuDX5v3TeLvZbmvcF/86kOaRPhHiWnLPB83r4H4e+/OVe/zC+cCfRK0fFZ
         7qgvQtWD4sFlfeDtagPO47sZWzysZRZSxz18MH2qkTQVzUhILanL1QolHXYg2QBZRnN0
         Us455vBL7lSrE26xSsfhdP9B96GarHV+6rQk/SHApFBJnFPwnl/5Fle48dX1k/0rgbQ9
         5x8inlcMKaF43Q4q8t49mtMf82wP0rCoadrN9OPnHjO525nR3i2PcJYp7a/klailAooO
         Ev1g==
X-Gm-Message-State: AOAM531+3fEHr8em6/s7H9mHQlEt2o00kiVUE9iLr1ItY91KEVNKDfm4
        /LcYns47SbSalwMBFOEF3Rb0Ro7gy9z9dQ==
X-Google-Smtp-Source: ABdhPJyPJGvPpTMNIeDwzlbJl89ma0IN1rYEVyRw7X+rYVNTUlAWEMm81vh00KrOJ1Q0dNCJ5surTw==
X-Received: by 2002:a17:902:eb8c:b0:158:4cc9:6998 with SMTP id q12-20020a170902eb8c00b001584cc96998mr14826627plg.35.1650355995603;
        Tue, 19 Apr 2022 01:13:15 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:33f6:f1e6:3e21:a253])
        by smtp.gmail.com with ESMTPSA id n13-20020a654ccd000000b0039db6f73e9dsm15767448pgt.28.2022.04.19.01.13.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Apr 2022 01:13:15 -0700 (PDT)
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
Subject: [RFC PATCH 7/7] clk: mediatek: mt8173: Switch to clk_hw provider APIs
Date:   Tue, 19 Apr 2022 16:12:46 +0800
Message-Id: <20220419081246.2546159-8-wenst@chromium.org>
X-Mailer: git-send-email 2.36.0.rc0.470.gd361397f0d-goog
In-Reply-To: <20220419081246.2546159-1-wenst@chromium.org>
References: <20220419081246.2546159-1-wenst@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As part of the effort to improve the MediaTek clk drivers, the next step
is to switch from the old 'struct clk' clk prodivder APIs to the new
'struct clk_hw' ones.

The MT8173 clk driver has one clk that is registered directly with the
clk provider APIs, instead of going through the MediaTek clk library.

Switch this instance to use the clk_hw provider API.

Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
 drivers/clk/mediatek/clk-mt8173.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt8173.c b/drivers/clk/mediatek/clk-mt8173.c
index 68d3a9749316..d34b248c42ca 100644
--- a/drivers/clk/mediatek/clk-mt8173.c
+++ b/drivers/clk/mediatek/clk-mt8173.c
@@ -994,7 +994,6 @@ static void __init mtk_apmixedsys_init(struct device_node *node)
 	struct clk_hw_onecell_data *clk_data;
 	void __iomem *base;
 	struct clk_hw *hw;
-	struct clk *clk;
 	int r, i;
 
 	base = of_iomap(node, 0);
@@ -1023,10 +1022,10 @@ static void __init mtk_apmixedsys_init(struct device_node *node)
 		clk_data->hws[cku->id] = hw;
 	}
 
-	clk = clk_register_divider(NULL, "hdmi_ref", "tvdpll_594m", 0,
-				   base + 0x40, 16, 3, CLK_DIVIDER_POWER_OF_TWO,
-				   NULL);
-	clk_data->hws[CLK_APMIXED_HDMI_REF] = __clk_get_hw(clk);
+	hw = clk_hw_register_divider(NULL, "hdmi_ref", "tvdpll_594m", 0,
+				     base + 0x40, 16, 3, CLK_DIVIDER_POWER_OF_TWO,
+				     NULL);
+	clk_data->hws[CLK_APMIXED_HDMI_REF] = hw;
 
 	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 	if (r)
-- 
2.36.0.rc0.470.gd361397f0d-goog

