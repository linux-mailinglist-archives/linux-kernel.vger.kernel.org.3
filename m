Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 780945A551D
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 21:58:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230060AbiH2T5b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 15:57:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230050AbiH2T5D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 15:57:03 -0400
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 017ED9835F;
        Mon, 29 Aug 2022 12:56:52 -0700 (PDT)
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-11ba6e79dd1so11746101fac.12;
        Mon, 29 Aug 2022 12:56:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=/MOKxcoJc5kuHgE2PkdiTmIj2qZGQvjtgGW9C5gG2kA=;
        b=nJuJ2Ttp+ltHwiVocC/CmJNzQZ+RyMAFN7Pj5eeckfbG0r3TuTxlaQ0O/V9+WOWDQ0
         mNlwXzL9ccpYByLphqFsbYUY2uAepqnOztO/oNqQEsQdY+be1n2rtsRJdFEW/KQhF7GZ
         r3/cdzzyG+VUeiwcn9zAvDGpeli41WDkq/rocQZuI0LfPScww0OUSRG9sl1blRROVOEr
         +vdGM+FqXzl0bmOZM6B3TfLu7oG7YuFaqR7YCQC4JyKpU9OrnDSM/j/TK599IbL6C7i5
         F2pqM/Oehbg4BAoLFzZgUwSjP+xyhKhFxPAWbLyatXJHH1KN7N1nzrYIdU1gjUXi+Xx0
         f1cg==
X-Gm-Message-State: ACgBeo0j/oRNI7prtXfbhgShAZ34mVPtd/24XieKrvkGIujzPfmbYelt
        jB1LvElJrhUOH1t43DOLPA==
X-Google-Smtp-Source: AA6agR4LCIMUE0t2pFGD5lbI+Ix6tCYdL75rhybEI6Ep3uRgE81TTWzgA53lYeHyjkHiC/kweLtZ1w==
X-Received: by 2002:a05:6870:c884:b0:118:ae35:e200 with SMTP id er4-20020a056870c88400b00118ae35e200mr8851020oab.244.1661803009819;
        Mon, 29 Aug 2022 12:56:49 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id eo33-20020a056870eca100b0011cd9d8a4b7sm6671148oab.19.2022.08.29.12.56.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Aug 2022 12:56:49 -0700 (PDT)
Received: (nullmailer pid 2313735 invoked by uid 1000);
        Mon, 29 Aug 2022 19:56:47 -0000
Date:   Mon, 29 Aug 2022 14:56:47 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Vladimir Zapolskiy <vz@mleia.com>, linux-tegra@vger.kernel.org,
        freedreno@lists.freedesktop.org, Rob Herring <robh+dt@kernel.org>,
        Robert Foss <robert.foss@linaro.org>,
        linux-ide@vger.kernel.org,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Andre Przywara <andre.przywara@arm.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Sean Paul <sean@poorly.run>, Stephen Boyd <sboyd@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        linux-samsung-soc@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Clark <robdclark@gmail.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        linux-clk@vger.kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Seung-Woo Kim <sw0312.kim@samsung.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        David Airlie <airlied@linux.ie>,
        Krishna Manikandan <quic_mkrishn@quicinc.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Marek Vasut <marex@denx.de>, linux-renesas-soc@vger.kernel.org,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Inki Dae <inki.dae@samsung.com>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: Re: [PATCH 5/5] dt-bindings: display: drop minItems equal to maxItems
Message-ID: <20220829195647.GA2313625-robh@kernel.org>
References: <20220825113334.196908-1-krzysztof.kozlowski@linaro.org>
 <20220825113334.196908-5-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220825113334.196908-5-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 25 Aug 2022 14:33:34 +0300, Krzysztof Kozlowski wrote:
> minItems, if missing, are implicitly equal to maxItems, so drop
> redundant piece to reduce size of code.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  Documentation/devicetree/bindings/display/bridge/fsl,ldb.yaml   | 1 -
>  .../devicetree/bindings/display/msm/dsi-controller-main.yaml    | 2 --
>  Documentation/devicetree/bindings/display/msm/dsi-phy-10nm.yaml | 2 --
>  .../bindings/display/samsung/samsung,exynos5433-decon.yaml      | 2 --
>  .../bindings/display/samsung/samsung,exynos5433-mic.yaml        | 1 -
>  .../bindings/display/samsung/samsung,exynos7-decon.yaml         | 1 -
>  .../devicetree/bindings/display/samsung/samsung,fimd.yaml       | 1 -
>  .../devicetree/bindings/display/tegra/nvidia,tegra20-gr3d.yaml  | 1 -
>  .../devicetree/bindings/display/tegra/nvidia,tegra20-mpe.yaml   | 2 --
>  9 files changed, 13 deletions(-)
> 

Applied, thanks!
