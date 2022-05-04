Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40319519F81
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 14:33:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240187AbiEDMgS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 08:36:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349601AbiEDMgG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 08:36:06 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0A703057C;
        Wed,  4 May 2022 05:32:30 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id g23so1502743edy.13;
        Wed, 04 May 2022 05:32:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UYV9WwfLVrhrjjukDe9qosCTrZP5yItzO2ZQyMR1lZc=;
        b=clzbEqsXQv/9j5beNysVRxnHh7EbfdL42WEK+sogVY160hfxT5oK2+IR1IBBklte5t
         ljb7kUC16gyqCia6Y1DO9VfnKQsmElv94rsEBhm5/71Ump62UeGSLcIRqAhZNNoIcDrj
         /d2+1GCvvxljr4i4IwSxzd+zN7RmCWZwPgTid2EQU7r4zlXhXfOVzt4oK/5ZrDB6/15V
         LI78hx3bZppBPCqu/mae/VXn0rWFnZwnac5Mc3eTK4HJ1KKYp/ut3KogNLUhyHK16mSc
         WsdMo1j0Ep4IrzcvMfA7hofu9ZE4xpIeqaz9iFbXt7Vh+BMyk8g4n2fje+1RsfQgxg4e
         OPYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UYV9WwfLVrhrjjukDe9qosCTrZP5yItzO2ZQyMR1lZc=;
        b=VjJHnK9K6MSeJLwkcAbSikmBNYlqjGDW1gaiBKpsL75aViuOk2DoBeDBLMSBnvoY+b
         idVM16OS4t68cSvd0W+6opJG8NlAvs/gqbcYse6W40QXjW2Wc8Y7TUvZE6bPR7Yck44t
         8BzIG4patHR/H+QklqnUemaks7k/OZPMOD33SNa1Bslg03yRbHLGutwRqWk8cbl0VKkZ
         ZYgci+AmpAR1T6KRlJXF34JIXEr68THNZqFLadBb6pywT1Uwwzqo4qcmkNI0Pu4Ni4no
         HySdSkX5puqEmOlUuZKDRO/fYEaDk1NOiTlHrOFazgzbXJqcx32Jid22hipnJH9d9lNZ
         qF7Q==
X-Gm-Message-State: AOAM530sFDJravAd/+64Kxk1UupO73Y+3Sa9AfZD2IhAen5UOcA+hZRk
        RrbpDp/F+8FlkWtNH5HfUhU=
X-Google-Smtp-Source: ABdhPJz9W/mMV44IrVK/27fYXrCOAHDuuLtFYy0c/F+TRA1NVYOwalt2veeTybfEqPXiQUKHfnL3eg==
X-Received: by 2002:a05:6402:d05:b0:425:b7ab:776e with SMTP id eb5-20020a0564020d0500b00425b7ab776emr23169472edb.142.1651667549307;
        Wed, 04 May 2022 05:32:29 -0700 (PDT)
Received: from localhost.localdomain (185-177-124-12.hosted-by-worldstream.net. [185.177.124.12])
        by smtp.gmail.com with ESMTPSA id ig1-20020a1709072e0100b006f3ef214e7asm5688693ejc.224.2022.05.04.05.32.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 May 2022 05:32:28 -0700 (PDT)
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
Subject: [PATCH 04/13] clk: composite: Export clk_unregister_composite
Date:   Wed,  4 May 2022 16:25:53 +0400
Message-Id: <20220504122601.335495-5-y.oudjana@protonmail.com>
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

This is required to build the Mediatek clock core as a module.
Doing so currently fails:

ERROR: modpost: "clk_unregister_composite" [drivers/clk/mediatek/clk-mtk.ko] undefined!

Fixes: cb50864f6cee ("clk: mediatek: Implement mtk_clk_unregister_composites() API")
Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
---
 drivers/clk/clk-composite.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/clk-composite.c b/drivers/clk/clk-composite.c
index b9c5f904f535..0935a54c9d81 100644
--- a/drivers/clk/clk-composite.c
+++ b/drivers/clk/clk-composite.c
@@ -425,6 +425,7 @@ void clk_unregister_composite(struct clk *clk)
 	clk_unregister(clk);
 	kfree(composite);
 }
+EXPORT_SYMBOL_GPL(clk_unregister_composite);
 
 void clk_hw_unregister_composite(struct clk_hw *hw)
 {
-- 
2.36.0

