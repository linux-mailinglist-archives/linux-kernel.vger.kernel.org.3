Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F94A519F94
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 14:33:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349686AbiEDMhI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 08:37:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349723AbiEDMgr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 08:36:47 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA5A3340C9;
        Wed,  4 May 2022 05:33:10 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id kq17so2601715ejb.4;
        Wed, 04 May 2022 05:33:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bqWHfh4DenBhYZWygCRQbAilVjZPwr6A8uSbGQA4n4g=;
        b=EZzaLJio+J3mjbbdhdVzx9o+zyM0yUBmXhCHYMUe6sKGiZiRW+p2IPAa4xWiey50Yj
         CZA/rkUSAR3XnRJmilJxvBcro6ohrkcqM5V31qy35yeG1jUaNWkfH3OZEzB5aE22Fqvm
         qK0drlQdJC5dK0OpNtbGrjEnX+WD/M1fLvHKcgQ32xvorx4antbKnPiXByg/y2fZhJwg
         StOIjjopQ9QfPL0WfTtMkA/lnTHUSomeZcwtAvqr3gLaEWjwG/BRJQWAQEjCE4/V1kEm
         KmK5I/BRyRr0KEATiU6yNSY1N+AP74b1yWLPzlnzdEQ4WuvPb+IHNojcmh49oGarhL+F
         r6Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bqWHfh4DenBhYZWygCRQbAilVjZPwr6A8uSbGQA4n4g=;
        b=8BovGrIJYdrHifARh9rd1e7L5WBE8DUDkIHQuvs97ZfLOsMAO4CIMKNkoJxy4TkNwu
         PCI8ND0kTyWzTR5FlXMmJDGaDy8L2/b8THbydCz+1faE/vqR+cy2ou69B1Ulllzf3Kdf
         1p8IesUDnmqoOEm7bfkIgls4VZGqUlZp93MPUmpe7b4ErV8hFpuPYxqO39Ag4Gk8CmWZ
         vUZfWEHcfIxcuEtXPHvLUQE719G8e2qjH3SapNmzt8M+myuekOAMQPKEyatszGHIcH2d
         /reQ9V7vnkVGKqZ1PkF5/wJODmQg/hRhNeTV2X1/4Yx0OdxzYJ9bVXRk4BuefnEKTE6Q
         wnsg==
X-Gm-Message-State: AOAM530GT0wh/7x+DZA6/RvJPBhVSCuKVXa7EkFPO0FNnJ4hWwFkbYEH
        DeAqPSDLM6qKIAVBsg7oB/A=
X-Google-Smtp-Source: ABdhPJxbSCmy6aDiEsDO0UJSjgrOhwaYA7A0tZ1JNTIpOydZSEMbnGEGdNrmCdIAjrEcL2PW8p2vaQ==
X-Received: by 2002:a17:906:2ac9:b0:6ce:dc0f:9139 with SMTP id m9-20020a1709062ac900b006cedc0f9139mr19979129eje.206.1651667589400;
        Wed, 04 May 2022 05:33:09 -0700 (PDT)
Received: from localhost.localdomain (185-177-124-12.hosted-by-worldstream.net. [185.177.124.12])
        by smtp.gmail.com with ESMTPSA id ig1-20020a1709072e0100b006f3ef214e7asm5688693ejc.224.2022.05.04.05.33.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 May 2022 05:33:09 -0700 (PDT)
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
Subject: [PATCH 11/13] clk: mediatek: reset: Implement mtk_unregister_reset_controller() API
Date:   Wed,  4 May 2022 16:26:00 +0400
Message-Id: <20220504122601.335495-12-y.oudjana@protonmail.com>
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

Add a function to unregister a reset controller previously
registered with mtk_register_reset_controller() or
mtk_register_reset_controller_set_clr(), and do the necessary cleanup.

Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
---
 drivers/clk/mediatek/clk-mtk.h | 2 ++
 drivers/clk/mediatek/reset.c   | 7 +++++++
 2 files changed, 9 insertions(+)

diff --git a/drivers/clk/mediatek/clk-mtk.h b/drivers/clk/mediatek/clk-mtk.h
index 317905ec4a36..1a0462d9c20b 100644
--- a/drivers/clk/mediatek/clk-mtk.h
+++ b/drivers/clk/mediatek/clk-mtk.h
@@ -196,6 +196,8 @@ struct mtk_reset *mtk_register_reset_controller(struct device_node *np,
 struct mtk_reset *mtk_register_reset_controller_set_clr(struct device_node *np,
 	unsigned int num_regs, int regofs);
 
+void mtk_unregister_reset_controller(struct mtk_reset *data);
+
 struct mtk_clk_desc {
 	const struct mtk_gate *clks;
 	size_t num_clks;
diff --git a/drivers/clk/mediatek/reset.c b/drivers/clk/mediatek/reset.c
index f853bc8a7092..7201e1f5e07b 100644
--- a/drivers/clk/mediatek/reset.c
+++ b/drivers/clk/mediatek/reset.c
@@ -141,4 +141,11 @@ struct mtk_reset *mtk_register_reset_controller_set_clr(struct device_node *np,
 }
 EXPORT_SYMBOL_GPL(mtk_register_reset_controller_set_clr);
 
+void mtk_unregister_reset_controller(struct mtk_reset *data)
+{
+	reset_controller_unregister(&data->rcdev);
+	kfree(data);
+}
+EXPORT_SYMBOL_GPL(mtk_unregister_reset_controller);
+
 MODULE_LICENSE("GPL");
-- 
2.36.0

