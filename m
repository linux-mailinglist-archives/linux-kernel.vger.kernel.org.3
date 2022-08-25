Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5E545A0F32
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 13:33:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241691AbiHYLdx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 07:33:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241604AbiHYLdr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 07:33:47 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CAABADCD4
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 04:33:42 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id d23so23465189lfl.13
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 04:33:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=5f5tWhIstVtTSwKpxEt2LvelJrCKuLR3PL365pf4QS4=;
        b=pVklcWuFNgj8ttdDE9REKfypKLdUtCn9f/ySSF5qEbDM/toFxSWpQc/MYxWQdNJwu2
         Nlxa70HrmyrR9cDd2ZqKYbbg+kl+13HsP2FwR/+Rx4XiXKvXvRRdSuWC1A0icUhGCx6t
         dyQS15jw+p54nSqSS7aYeOmv5lRBCq2ZIJl3w9gYWBtDZwVXTrp2kpRCb9dwndNZKsQS
         d3lPhpObnhcUhkTmK3xq7CFa+pTwJ8rVaSIjbMnWZgnivbeSC14doHc5zQ2dow6ptE9t
         ZDrOv/Qk+ajcw68RlQ0dUOTHllKHqhtxZw3Ir/BzshJmyMCx1LVCdufFSby1sGYV316g
         ttPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=5f5tWhIstVtTSwKpxEt2LvelJrCKuLR3PL365pf4QS4=;
        b=aVgpUeN9sSvPRojtaBtvDsAd6jeADSrLoUng5uR9SeBCIUzbLQ983hTwxaYSDt45jQ
         rvi/m0xItOob88Z+YjabVWSFCi0bryVwUAiAzqLUxDh5AISug9G2j/dVDRQXFta/Ct0d
         xTp9IHgnxoUdXuVtmPfUeA6H3GYFBvkT/ezGRu2+/mScZWXyQXf8CaJI3iJqdkudXVEs
         Khk4X2XdouOA6Ogt9C3F50AOYOG24DE+n5ydBF/mShNLsf6cUNszwY4yHJMtiyUYM+4V
         TL8imcTIkVROhrZhlh7pRSzACJWC4JaN8b6BwG8rezHsvLXj6nVy+6tOFHJ4g++9WBzj
         QYFQ==
X-Gm-Message-State: ACgBeo2DdSFEOFdyxj1aPpuTlcVOWZTQg20+seFBJzzGhD4XvhBi+gIT
        UHb1BgAOf6M3vRORkz2hAf0XAg==
X-Google-Smtp-Source: AA6agR5Cwlt1QnJQbh16uHaNZuyEAqyKIdLBAYRJgSNUyF+xnOQylMkrtQ8mBl4L0+NErXHiMNgWew==
X-Received: by 2002:a05:6512:3905:b0:493:80a:46ba with SMTP id a5-20020a056512390500b00493080a46bamr956006lfu.69.1661427220406;
        Thu, 25 Aug 2022 04:33:40 -0700 (PDT)
Received: from krzk-bin.starman.ee (82.131.98.15.cable.starman.ee. [82.131.98.15])
        by smtp.gmail.com with ESMTPSA id e18-20020a195012000000b0048b0aa2f87csm446764lfb.181.2022.08.25.04.33.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Aug 2022 04:33:39 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <robert.foss@linaro.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, Inki Dae <inki.dae@samsung.com>,
        Seung-Woo Kim <sw0312.kim@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andre Przywara <andre.przywara@arm.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Marek Vasut <marex@denx.de>,
        Krishna Manikandan <quic_mkrishn@quicinc.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org, linux-crypto@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org, linux-tegra@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 1/5] dt-bindings: socionext,uniphier-system-cache: drop minItems equal to maxItems
Date:   Thu, 25 Aug 2022 14:33:30 +0300
Message-Id: <20220825113334.196908-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

minItems, if missing, are implicitly equal to maxItems, so drop
redundant piece to reduce size of code.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../bindings/arm/socionext/socionext,uniphier-system-cache.yaml  | 1 -
 1 file changed, 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/arm/socionext/socionext,uniphier-system-cache.yaml b/Documentation/devicetree/bindings/arm/socionext/socionext,uniphier-system-cache.yaml
index 7ca5375f278f..6096c082d56d 100644
--- a/Documentation/devicetree/bindings/arm/socionext/socionext,uniphier-system-cache.yaml
+++ b/Documentation/devicetree/bindings/arm/socionext/socionext,uniphier-system-cache.yaml
@@ -22,7 +22,6 @@ properties:
     description: |
       should contain 3 regions: control register, revision register,
       operation register, in this order.
-    minItems: 3
     maxItems: 3
 
   interrupts:
-- 
2.34.1

