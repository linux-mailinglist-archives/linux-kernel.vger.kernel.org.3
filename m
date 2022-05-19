Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43FD852CCB6
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 09:18:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234646AbiESHRe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 03:17:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234621AbiESHRA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 03:17:00 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7CE76D38D
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 00:16:51 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id 31so4279160pgp.8
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 00:16:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/Lobr1vMx7rDaM5B+yUv81HVaD1u4SedAKGtA+u9eB0=;
        b=iR0EAiANHpgr6qqiXvJm8TqFB+PzivUbHjXAByQCTPk+RQfY2cGvzwMkoow9PlOcVW
         463hMSQao/hqbeQ1WB96f4CaYMV456vxf+1BjGIhP8k0GXT6Ub2Ja0amLXUK0yIltbmh
         qmBeFKkgPHy4W0AOQwgYpcRgI7ZdFfaaZXEF4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/Lobr1vMx7rDaM5B+yUv81HVaD1u4SedAKGtA+u9eB0=;
        b=fWu4NG72dWZjvg+AbjRLrl4eiHtRrGUFHh7/Edno8f4vy9hKUa6Q8SbHSkmcmrr39w
         2p2jgwxKhCqL/MjwtMaPlC2g/miPxB270CgK9QqgPtkVWpXQuqIFEl6vNCV+QFQH9WZf
         MeS9DmFLAbezzWBKwRTcUWg/7CT8nwrKGLJn0biKLFW30NS7BaPGGYGjVUCGSF3vqymr
         GQ1lnqzjzLXMLLqCZ3VhbjDXNiuUKxKvjgPDifdKAbLqxfCu7CG1Vu4pgi4T2JOEJdi8
         bKZOC6Qy4zgUo2o64JbybZ+FKSddTEckZUCT2xG92NRlJNMLROkOSUdWYpCePqnjR2qn
         KLyA==
X-Gm-Message-State: AOAM533J/RHCbvr4UthRwRkyuMs+2kmUYPEGgjrTrr/anN4SVR3XnxwN
        yuD4c8p+ogVhxwWb9S0bsmBdLA==
X-Google-Smtp-Source: ABdhPJylSUfb3Z55yfaTqVg3bRO6QxvkbPPkHOaMcXrMUTD5T6cI7rFyVdO46NS5CA47zzipp9of8g==
X-Received: by 2002:a63:381e:0:b0:3c6:d5e4:fed9 with SMTP id f30-20020a63381e000000b003c6d5e4fed9mr2797165pga.553.1652944611201;
        Thu, 19 May 2022 00:16:51 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:2338:2871:9320:bed0])
        by smtp.gmail.com with ESMTPSA id q2-20020a170902dac200b00160c970eeb7sm2972945plx.234.2022.05.19.00.16.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 May 2022 00:16:50 -0700 (PDT)
From:   Chen-Yu Tsai <wenst@chromium.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Chen-Yu Tsai <wenst@chromium.org>,
        Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        Miles Chen <miles.chen@mediatek.com>,
        Rex-BC Chen <rex-bc.chen@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-clk@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 5/5] clk: mediatek: mt8173: Switch to clk_hw provider APIs
Date:   Thu, 19 May 2022 15:16:10 +0800
Message-Id: <20220519071610.423372-6-wenst@chromium.org>
X-Mailer: git-send-email 2.36.1.124.g0e6072fb45-goog
In-Reply-To: <20220519071610.423372-1-wenst@chromium.org>
References: <20220519071610.423372-1-wenst@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
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
Reviewed-by: Miles Chen <miles.chen@mediatek.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Tested-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Tested-by: Miles Chen <miles.chen@mediatek.com>
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
2.36.1.124.g0e6072fb45-goog

