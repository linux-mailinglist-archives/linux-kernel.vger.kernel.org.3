Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6406519F8F
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 14:33:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349739AbiEDMgw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 08:36:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349617AbiEDMgh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 08:36:37 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BE9933A28;
        Wed,  4 May 2022 05:32:59 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id be20so1503288edb.12;
        Wed, 04 May 2022 05:32:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aPFSi/mWYMYdcINHgbvPpjSUWnzyR9p2rv5umtn3cjI=;
        b=UEFVed+rgiC1aLFETWO3cJXmKIhCocpF3HO/nI8utDBVg39ruLl5QFVsv4iuKvsveR
         5qATWQ8FXfIGg/WmYfD4hppEDR+bjU9R2cpZK2b80cZj7hMm+DyQg4GkyCqvOrn9a6Hn
         Jf33IeqUyVSd18068d9DNkH5Ci1mOYNBziuQ4Kaaevxnfjp8ORdU3Y25YF4pBNcjVqPh
         K8jQg1FaR/BuZ27aXWahyAQCbLO6jopxmHRzaaxQPMilhwrwlBSIB0tsiMLKv1NQ4Njf
         ekXwbKBISFCg5eZx9ktY6Ge82DA4gMnJYoZ6k/x/ApvaQftQjfV5cP8tDj0Y4xVYp4Jy
         sDnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aPFSi/mWYMYdcINHgbvPpjSUWnzyR9p2rv5umtn3cjI=;
        b=RwFR3sACu6AVUrRD8IMeDnpXg7G1KwQ3SX1FkB/pPhrH/uMPSzS1+JygdaSrOMnnXa
         KlRweMn9xyHjvLMsnxJjLDDazRpjuYA2jMxjMyPdpvVl9pz6AgUg/eDykDWGjvPmBT/p
         oK9LodtlATLu2Dpa9/nWeqLrIuOxC82CcFXR8N9BCW4WuAnlGzUeh6itfg/03bN5/yLN
         /agJz1CsOoCQkvfAmzQQZ0KlboPo44fQ82oDnErNF47MyBzE5SE/Bd8IZpxJRg3hkIIE
         u/XDArccnWwzRj1tWlf8TocObtkoa0wsEHZOt4QrvKX+orkelTbInMr5f/yEJpr3OaG2
         mcCA==
X-Gm-Message-State: AOAM530Pe6hJQXLLmSGPbEcdh7xQ336Vl8kVd5fsJnSJY9rppgxY8xpW
        Mu4d148L4/UAy1wOdXacX9M=
X-Google-Smtp-Source: ABdhPJw1ji77MznXPOLUih012rHNfyRY1v0DSI/u5kQreEXOVa6/qDVm+wA0fswuDakV4xVmX1s1FA==
X-Received: by 2002:aa7:c318:0:b0:426:4aae:de6d with SMTP id l24-20020aa7c318000000b004264aaede6dmr22660856edq.208.1651667578090;
        Wed, 04 May 2022 05:32:58 -0700 (PDT)
Received: from localhost.localdomain (185-177-124-12.hosted-by-worldstream.net. [185.177.124.12])
        by smtp.gmail.com with ESMTPSA id ig1-20020a1709072e0100b006f3ef214e7asm5688693ejc.224.2022.05.04.05.32.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 May 2022 05:32:57 -0700 (PDT)
From:   Yassine Oudjana <yassine.oudjana@gmail.com>
X-Google-Original-From: Yassine Oudjana <y.oudjana@protonmail.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Yassine Oudjana <y.oudjana@protonmail.com>,
        Yassine Oudjana <yassine.oudjana@gmail.com>,
        Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        Chen-Yu Tsai <wenst@chromium.org>,
        Tinghan Shen <tinghan.shen@mediatek.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Weiyi Lu <weiyi.lu@mediatek.com>,
        Ikjoon Jang <ikjn@chromium.org>,
        Miles Chen <miles.chen@mediatek.com>,
        Sam Shih <sam.shih@mediatek.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 09/13] clk: mediatek: reset: Export mtk_register_reset_controller symbols
Date:   Wed,  4 May 2022 16:25:58 +0400
Message-Id: <20220504122601.335495-10-y.oudjana@protonmail.com>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20220504122601.335495-1-y.oudjana@protonmail.com>
References: <20220504122601.335495-1-y.oudjana@protonmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yassine Oudjana <y.oudjana@protonmail.com>

Export mtk_register_reset_controller and
mtk_register_reset_controller_set_clr to support building reset
drivers as modules.

Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
---
 drivers/clk/mediatek/reset.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/clk/mediatek/reset.c b/drivers/clk/mediatek/reset.c
index bcec4b89f449..6c2effe6afef 100644
--- a/drivers/clk/mediatek/reset.c
+++ b/drivers/clk/mediatek/reset.c
@@ -129,6 +129,7 @@ void mtk_register_reset_controller(struct device_node *np,
 	mtk_register_reset_controller_common(np, num_regs, regofs,
 		&mtk_reset_ops);
 }
+EXPORT_SYMBOL_GPL(mtk_register_reset_controller);
 
 void mtk_register_reset_controller_set_clr(struct device_node *np,
 	unsigned int num_regs, int regofs)
@@ -136,5 +137,6 @@ void mtk_register_reset_controller_set_clr(struct device_node *np,
 	mtk_register_reset_controller_common(np, num_regs, regofs,
 		&mtk_reset_ops_set_clr);
 }
+EXPORT_SYMBOL_GPL(mtk_register_reset_controller_set_clr);
 
 MODULE_LICENSE("GPL");
-- 
2.36.0

