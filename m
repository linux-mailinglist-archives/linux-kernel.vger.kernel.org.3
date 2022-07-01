Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19B08563630
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 16:53:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233708AbiGAOvz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 10:51:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233644AbiGAOvr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 10:51:47 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1816D3616B
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jul 2022 07:51:45 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id l6so2574014plg.11
        for <linux-kernel@vger.kernel.org>; Fri, 01 Jul 2022 07:51:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=a9dig3aHD2Gf3AUlWQENSbKW6lk+Nf6n/l74e5q075k=;
        b=gt91rdKf1CenZW38m3WWnMrR2rWxGSogpjozB73ZDlt2hOTb4QHmjW3AqZXHkd38Cj
         U/2ofksQmrVCWrMu7SCw8NhY8jCBIsA8oWGmMjFOq/ZwjcmlwLz5rcfCzromyTUqgR7P
         wgFx5pL4OP5d2Vi4BOr92cww7VU6B9ybecWbs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=a9dig3aHD2Gf3AUlWQENSbKW6lk+Nf6n/l74e5q075k=;
        b=2QyC6NwxPV0ydIcTAX20WmnSqysCinGaxf+Di6f2+2HjQoTtlgld5WNtJm1IgqcGn2
         TTNP8kf4etpLNbtwX/XR4j7nzp3Kp+d5y6H4PNAgKyi/A5aDp0I5+nsLsoSw4TEpZpNX
         wsJhP0tiEuy/ZdxarEMzOlM+2XF0sVjTQEQZKl9373RqmdOgYXm78gW52G/UU7kP+aCy
         IpmbhPUGJu/e+qftzJG5zGvsTGCc+kIFNfvUiYB1GKgrdlhnCQTiSrm0smytRq0LuYv/
         4QQ46EhQuUDIMpFP28MAIDPGPeATXd19/u5tIkI0lhKpXkVXEvEAnNNhwbo2gD3A86jy
         5AGg==
X-Gm-Message-State: AJIora/tmI5SQ7KmOzpl4KDI6RPvJRSsESRUUT7nRbpabNKq6PqXklgC
        j964KilULZDS0jYT+uHElNYZGg==
X-Google-Smtp-Source: AGRyM1v7D2jfmjMtIFo5UkUAyGT8o2GEfxdngj6c9QDeeyT3kwzLM9N8ey5pyiDAoocoTjiIAvo9tg==
X-Received: by 2002:a17:902:f7cf:b0:16a:322d:3f48 with SMTP id h15-20020a170902f7cf00b0016a322d3f48mr20518123plw.148.1656687104568;
        Fri, 01 Jul 2022 07:51:44 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:59bf:8b47:50a0:b04f])
        by smtp.gmail.com with ESMTPSA id i4-20020a17090332c400b0016a214e4afasm15780981plr.125.2022.07.01.07.51.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Jul 2022 07:51:44 -0700 (PDT)
From:   Chen-Yu Tsai <wenst@chromium.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Chen-Yu Tsai <wenst@chromium.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Rex-BC Chen <rex-bc.chen@mediatek.com>,
        Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] clk: mediatek: mt8183-audio: Simplify with mtk_clk_simple_*()
Date:   Fri,  1 Jul 2022 22:51:32 +0800
Message-Id: <20220701145133.1152387-3-wenst@chromium.org>
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
In-Reply-To: <20220701145133.1152387-1-wenst@chromium.org>
References: <20220701145133.1152387-1-wenst@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mtk_clk_simple_*() was added after the MT8183 clock drivers were merged.
They provide shared boiler plate for clock providers that only have
clock gates.

Since the driver also populates child nodes, which are for the audio
subsystem, it can't be completely converted to using the functions.

Simplify the MT8183 audio clock driver using mtk_clk_simple_*(),
sequencing the of_platform_{populate,unpopulate} calls manually and
correctly. This also adds proper remove support for the driver.

Since the mtk_clk_simple_probe() function allocates the clk_hw pointer
array based on .num_clks given, it effectively requires there are no
holes in the clock ID map. Check that the size of the array matches
the number of clocks with a static assertion.

Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
 drivers/clk/mediatek/clk-mt8183-audio.c | 40 ++++++++++++++++---------
 1 file changed, 26 insertions(+), 14 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt8183-audio.c b/drivers/clk/mediatek/clk-mt8183-audio.c
index b2d7746eddbe..b9255e0a36ae 100644
--- a/drivers/clk/mediatek/clk-mt8183-audio.c
+++ b/drivers/clk/mediatek/clk-mt8183-audio.c
@@ -67,35 +67,47 @@ static const struct mtk_gate audio_clks[] = {
 		20),
 };
 
+static_assert(ARRAY_SIZE(audio_clks) == CLK_AUDIO_NR_CLK);
+
+static const struct mtk_clk_desc audio_desc = {
+	.clks = audio_clks,
+	.num_clks = ARRAY_SIZE(audio_clks),
+};
+
 static int clk_mt8183_audio_probe(struct platform_device *pdev)
 {
-	struct clk_hw_onecell_data *clk_data;
-	int r;
-	struct device_node *node = pdev->dev.of_node;
+	int ret;
 
-	clk_data = mtk_alloc_clk_data(CLK_AUDIO_NR_CLK);
+	ret = mtk_clk_simple_probe(pdev);
+	if (ret)
+		return ret;
 
-	mtk_clk_register_gates(node, audio_clks, ARRAY_SIZE(audio_clks),
-			clk_data);
+	ret = of_platform_populate(pdev->dev.of_node, NULL, NULL, &pdev->dev);
+	if (ret)
+		goto err_remove_clks;
 
-	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
-	if (r)
-		return r;
+	return 0;
 
-	r = devm_of_platform_populate(&pdev->dev);
-	if (r)
-		of_clk_del_provider(node);
+err_remove_clks:
+	mtk_clk_simple_remove(pdev);
+	return ret;
+}
+
+static int clk_mt8183_audio_remove(struct platform_device *pdev)
+{
+	of_platform_depopulate(&pdev->dev);
 
-	return r;
+	return mtk_clk_simple_remove(pdev);
 }
 
 static const struct of_device_id of_match_clk_mt8183_audio[] = {
-	{ .compatible = "mediatek,mt8183-audiosys", },
+	{ .compatible = "mediatek,mt8183-audiosys", .data = &audio_desc },
 	{}
 };
 
 static struct platform_driver clk_mt8183_audio_drv = {
 	.probe = clk_mt8183_audio_probe,
+	.remove = clk_mt8183_audio_remove,
 	.driver = {
 		.name = "clk-mt8183-audio",
 		.of_match_table = of_match_clk_mt8183_audio,
-- 
2.37.0.rc0.161.g10f37bed90-goog

