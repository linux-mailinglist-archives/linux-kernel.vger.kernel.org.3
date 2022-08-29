Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA0385A5509
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 21:57:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229737AbiH2T4Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 15:56:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229940AbiH2T4G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 15:56:06 -0400
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 572874D16A;
        Mon, 29 Aug 2022 12:56:05 -0700 (PDT)
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-11ba6e79dd1so11741228fac.12;
        Mon, 29 Aug 2022 12:56:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=B6L6A2/pK+teiP71Bwj1SsdHvDI4k1BUKvthZehztGQ=;
        b=QYO/gg+j3fcPlDnpjSTnSm2Zr4sIYKmgc9r6PPM7w0TM6p+obJhXwVMqLhtLyhUUwT
         x8gtBK6jBeCz9gJogbrIeM4a37lMKjt1Mz45M7Jyhk0b9Pbye8cKVW6Y25A+t8fa/Yi3
         I7r53nl5LmFvhtvCPyS0NsZziJXvCO9rTtYOxV9atKWGJpGIQSprSi4vUFeSzNS1cjP8
         9+FcQ30vaU8og5TNK44pJKTKRTbN4WpKDZVXxmBoh2nulU6vjUWPLRqz+d8qWBTv3MQG
         9gNyRw/4iCoIvAdJV6wLrndleKUiBGwpxHjhpYlDm1ls3DxzIRiviiPmvYFWuScsMX69
         f0HQ==
X-Gm-Message-State: ACgBeo1GjgX/bN0/jTteXxVm32V8tMJ6OqRpSGu6uqa8EeFRYKO85rDw
        E2CqiQpVvSbDNcrAOjKJ3w==
X-Google-Smtp-Source: AA6agR4fXlibwEVQQMGUT+dnMLOu+YjkGVEXao/w1QADh4csqcyyouO8sQd4eDsDOErVz7tCaEb3HA==
X-Received: by 2002:a05:6870:f608:b0:11c:26a8:467f with SMTP id ek8-20020a056870f60800b0011c26a8467fmr8414068oab.258.1661802964344;
        Mon, 29 Aug 2022 12:56:04 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id t28-20020a056870f21c00b000f5e89a9c60sm6557080oao.3.2022.08.29.12.56.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Aug 2022 12:56:04 -0700 (PDT)
Received: (nullmailer pid 2312221 invoked by uid 1000);
        Mon, 29 Aug 2022 19:56:01 -0000
Date:   Mon, 29 Aug 2022 14:56:01 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        freedreno@lists.freedesktop.org, Vladimir Zapolskiy <vz@mleia.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        linux-renesas-soc@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        linux-crypto@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-arm-kernel@lists.infradead.org,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Seung-Woo Kim <sw0312.kim@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        linux-samsung-soc@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        "David S. Miller" <davem@davemloft.net>, linux-clk@vger.kernel.org,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Krishna Manikandan <quic_mkrishn@quicinc.com>,
        Inki Dae <inki.dae@samsung.com>, linux-kernel@vger.kernel.org,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Robert Foss <robert.foss@linaro.org>,
        Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        linux-tegra@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Daniel Vetter <daniel@ffwll.ch>, Marek Vasut <marex@denx.de>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        linux-arm-msm@vger.kernel.org,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        dri-devel@lists.freedesktop.org,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Jonas Karlman <jonas@kwiboo.se>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-ide@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Andre Przywara <andre.przywara@arm.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        devicetree@vger.kernel.org,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>
Subject: Re: [PATCH 2/5] dt-bindings: ata: drop minItems equal to maxItems
Message-ID: <20220829195601.GA2312165-robh@kernel.org>
References: <20220825113334.196908-1-krzysztof.kozlowski@linaro.org>
 <20220825113334.196908-2-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220825113334.196908-2-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 25 Aug 2022 14:33:31 +0300, Krzysztof Kozlowski wrote:
> minItems, if missing, are implicitly equal to maxItems, so drop
> redundant piece to reduce size of code.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  Documentation/devicetree/bindings/ata/brcm,sata-brcm.yaml       | 1 -
>  .../devicetree/bindings/ata/cortina,gemini-sata-bridge.yaml     | 2 --
>  Documentation/devicetree/bindings/ata/sata_highbank.yaml        | 1 -
>  3 files changed, 4 deletions(-)
> 

Applied, thanks!
