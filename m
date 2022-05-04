Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBBF4519F80
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 14:33:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349635AbiEDMgW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 08:36:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349586AbiEDMgQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 08:36:16 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D42030F65;
        Wed,  4 May 2022 05:32:36 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id l18so2582713ejc.7;
        Wed, 04 May 2022 05:32:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CNKzAxju2H5F78AxmBtE86NJhowOrzcymru33IBzxRo=;
        b=fhgI+VpoueobRqvh9tlA+tLmknI0/GBMBlZVChuFNtle9pQIpmqvLOhKfM6Dmjr1xw
         R3/4j2ipVTMcLVfcdiFVhPLlaPqRNY5t3H+rxBSFArOYE5xwpZxH3Jq/6mwZQVR5g5nH
         DS3m+OPLGiWRLFkR1OgFSMe8XxRKuEH9W86Sit7CTWaS36IS1BcjrV89ZJ+WtFIIoN5V
         SMHkwP1Nl0jDUWaKx2biMH+3mBhtuY+mAxeY2i82RlP9W3AZmkdHxsVek7a/DNULJQMK
         QeOxtBznr+PojfyE1rhzKOyrX/n2xr6Tt/U/VTGSbiKJy7ewUjeVFX4fuW8b/wFLsQHw
         dYPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CNKzAxju2H5F78AxmBtE86NJhowOrzcymru33IBzxRo=;
        b=LHQOpehIJ1Hurb3xWnwrkhyESwzosbRzkTY2X9AZpjU9RiMuI8MJM649fzjVC23Zqs
         5Om1LfB8Yf/K0dI04D1jC0hHOzM9qkQ1kE0LT1/KtTQrdYwGq+NLx0H2VqUSNL1vjnZ9
         UbjZR63M3XTERR46GyTXE7eOiE5cxtgxIpp8wtvidWaCxnuIegJdpZSsugZEjKTII0fF
         zNPuue4qwFwO9XgFudF2NkGm9nwAqp0FfNBbe2Vs14zbpYu2JoAzMNRoWbEYkbrxra2u
         FU04v3EWXydS2AxsTGKKQHoZQfBWRpI1bRoS8Ab6bX0CMNalT5tRy8E38mc/1bKOrLGW
         jzbQ==
X-Gm-Message-State: AOAM532A3BWJX6qhQCDyK0VekUf6BCH0M76JPTNcUsfebjkGluSU1M8r
        lR7hxpvrLYdLdsaQMj+/lVs=
X-Google-Smtp-Source: ABdhPJz1LfNQyXPrgPpEVU72LKcwzEzy3aEBePRzfJCjCXhN8ogrNFGeDXHVMFOxKgDBPTqeQGtifQ==
X-Received: by 2002:a17:907:980d:b0:6d6:f910:513a with SMTP id ji13-20020a170907980d00b006d6f910513amr18770753ejc.643.1651667555088;
        Wed, 04 May 2022 05:32:35 -0700 (PDT)
Received: from localhost.localdomain (185-177-124-12.hosted-by-worldstream.net. [185.177.124.12])
        by smtp.gmail.com with ESMTPSA id ig1-20020a1709072e0100b006f3ef214e7asm5688693ejc.224.2022.05.04.05.32.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 May 2022 05:32:34 -0700 (PDT)
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
Subject: [PATCH 05/13] clk: mediatek: Export mtk_free_clk_data
Date:   Wed,  4 May 2022 16:25:54 +0400
Message-Id: <20220504122601.335495-6-y.oudjana@protonmail.com>
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

Export mtk_free_clk_data to allow using it in clock drivers
built as modules.

Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
---
 drivers/clk/mediatek/clk-mtk.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/mediatek/clk-mtk.c b/drivers/clk/mediatek/clk-mtk.c
index b4063261cf56..0746b0f5beda 100644
--- a/drivers/clk/mediatek/clk-mtk.c
+++ b/drivers/clk/mediatek/clk-mtk.c
@@ -52,6 +52,7 @@ void mtk_free_clk_data(struct clk_onecell_data *clk_data)
 	kfree(clk_data->clks);
 	kfree(clk_data);
 }
+EXPORT_SYMBOL_GPL(mtk_free_clk_data);
 
 int mtk_clk_register_fixed_clks(const struct mtk_fixed_clk *clks, int num,
 				struct clk_onecell_data *clk_data)
-- 
2.36.0

