Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C353519F8E
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 14:33:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349675AbiEDMgo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 08:36:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349627AbiEDMgf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 08:36:35 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C99AC32EF6;
        Wed,  4 May 2022 05:32:52 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id bv19so2587229ejb.6;
        Wed, 04 May 2022 05:32:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PUVxfJrhsniJtnQ7nz0gUaC/9RR8AYztqQ8GdhvVU68=;
        b=HEJn9ahozroDJ2MNeRspCwpjwGh54adJdjlEW5nC2Z4kGL8cZKo2DhcvGKBTAJSEq+
         R1crI71Geo4C7IwGhUVxJLo/jffNS4jwOcK8ynC95bgwCQlFUVbpdfFsMBZEc35eUUQ1
         J7pfHqMr71Ju+L/evYzQBx+CBku6/iL+J2uSxz6mvXp4033IYEYHhB6FqhK2uBNssh4p
         uIch3cnITzd7PoJ3rC+LV8h284zjM/qVws//9XfPYbc/CgAlSygl7IPwy9wmVGCHrnpZ
         WwEfAC/WMnMeNGvwUb6bJqeEUlast7AGBB2VWksrXwsnt72Zy3hbGoqEtE4mzNYrUUS0
         iB+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PUVxfJrhsniJtnQ7nz0gUaC/9RR8AYztqQ8GdhvVU68=;
        b=EN3J63ax8mz6oPF7CZwEzrYVgqQnrCUMNpatLbVkiVw8JxwvU8KIvfwIobNO/6ftmn
         owtSdvpRA5c6g36zsyoDgEhZa/3ia30Kcg+htnH7x5pNvbBOMjEJpe4qgp+Sd/hhoAjy
         1eCc/9jARWkzFLIo8QN5BtlnC/EZv4jjb2XxPIeeppVuA2RnqsKkgEdj01vrRF0wOg5b
         QfBWXl/4IeZEOWhcbQzyS5NuNUQfKN3WMGevAbjzK7/KjHsk3qWI+8D0QW0RDyETJ/VB
         ULpIe8AKAerkKSiUwQQoohnAQfuO28PW8fbN34qr4eQ2jb8Z0sCQJ/Jw+SEx+WZBVM1L
         TUmA==
X-Gm-Message-State: AOAM532IG194akHwhn2zt5zXaCrB0km0bLpfqo3Ltcp2Iu8BTwK36fWV
        2BoTzoZ+G7FAqVHHZymbB5c=
X-Google-Smtp-Source: ABdhPJysMRSbHfcoJzQlOOSojNDvkOkjioWOUaFZqOEhre5gzFXjpjw3ryjINkEIAXIBd/cSPm5NNw==
X-Received: by 2002:a17:907:761c:b0:6d6:e553:7bd1 with SMTP id jx28-20020a170907761c00b006d6e5537bd1mr19590051ejc.5.1651667572462;
        Wed, 04 May 2022 05:32:52 -0700 (PDT)
Received: from localhost.localdomain (185-177-124-12.hosted-by-worldstream.net. [185.177.124.12])
        by smtp.gmail.com with ESMTPSA id ig1-20020a1709072e0100b006f3ef214e7asm5688693ejc.224.2022.05.04.05.32.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 May 2022 05:32:52 -0700 (PDT)
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
Subject: [PATCH 08/13] clk: mediatek: gate: Export mtk_clk_register_gates_with_dev
Date:   Wed,  4 May 2022 16:25:57 +0400
Message-Id: <20220504122601.335495-9-y.oudjana@protonmail.com>
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

This allows it to be used in drivers built as modules.

Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
---
 drivers/clk/mediatek/clk-gate.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/mediatek/clk-gate.c b/drivers/clk/mediatek/clk-gate.c
index da52023f8455..8af907b82f8f 100644
--- a/drivers/clk/mediatek/clk-gate.c
+++ b/drivers/clk/mediatek/clk-gate.c
@@ -261,6 +261,7 @@ int mtk_clk_register_gates_with_dev(struct device_node *node,
 
 	return PTR_ERR(clk);
 }
+EXPORT_SYMBOL_GPL(mtk_clk_register_gates_with_dev);
 
 int mtk_clk_register_gates(struct device_node *node,
 			   const struct mtk_gate *clks, int num,
-- 
2.36.0

