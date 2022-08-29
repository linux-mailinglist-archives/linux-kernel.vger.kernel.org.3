Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C35F5A54F2
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 21:56:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229894AbiH2T4E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 15:56:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229886AbiH2Tzu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 15:55:50 -0400
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F8621FCFB;
        Mon, 29 Aug 2022 12:55:48 -0700 (PDT)
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-11e9a7135easo9292486fac.6;
        Mon, 29 Aug 2022 12:55:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=022FZqEM+NZk/+qjcdGcVImONgP3k7o4bYGRw++11q0=;
        b=TcdHWNIivMlrJaRyfbKzK29apZdNivi3Sl1dayoRXqtxljG7MPpWphtUadyAIwgnRP
         U9syAu9/3LPeyV893toKpSEnr2drx5X1Sguh+KRlyT0oKYSRZKLJ38X/K31uZ/VbY5JS
         Y8/ftVug1f8WsyrqX0wBBsuAhx1+qBGBwqft3N7IiCyAUG4H413c9PqNNMsYR8iMSjef
         sHWO6NkSDEFI3eA7zK0eceU2KK+sSm7sqebG45oPp11F8pgCQiNgQ5ltZvqPkTnDJkBc
         13n+pri14vdaj6Zer9ytgyQIYanOV8Gh12XM0Ya1Ivld6w04CiZy9jI5zvwdGOHf73/9
         8q7g==
X-Gm-Message-State: ACgBeo3obwl2VgZIhAH6qpEXnf7bMnSCeuj63cTLAT9GtkfS9r/Emp9u
        aqkoLZC3ri9iptjLSlas1w==
X-Google-Smtp-Source: AA6agR4HrxNsAlmaBU/KnvvfB3vzL2uHFpEExor1t4Jl8og9mSVI0Y1aS92n6CWLoQsobrsXrw2Zdw==
X-Received: by 2002:a05:6870:c68a:b0:11d:124c:5d37 with SMTP id cv10-20020a056870c68a00b0011d124c5d37mr8209083oab.64.1661802946957;
        Mon, 29 Aug 2022 12:55:46 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id t7-20020a05683014c700b00616e2d2204csm6236948otq.21.2022.08.29.12.55.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Aug 2022 12:55:46 -0700 (PDT)
Received: (nullmailer pid 2311548 invoked by uid 1000);
        Mon, 29 Aug 2022 19:55:43 -0000
Date:   Mon, 29 Aug 2022 14:55:43 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Andre Przywara <andre.przywara@arm.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org,
        Jonas Karlman <jonas@kwiboo.se>,
        dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Inki Dae <inki.dae@samsung.com>,
        linux-arm-kernel@lists.infradead.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-ide@vger.kernel.org,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        devicetree@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        linux-tegra@vger.kernel.org, Sean Paul <sean@poorly.run>,
        Stephen Boyd <sboyd@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-samsung-soc@vger.kernel.org,
        Seung-Woo Kim <sw0312.kim@samsung.com>,
        Rob Clark <robdclark@gmail.com>,
        linux-renesas-soc@vger.kernel.org, freedreno@lists.freedesktop.org,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Marek Vasut <marex@denx.de>,
        Michael Turquette <mturquette@baylibre.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Rob Herring <robh+dt@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Krishna Manikandan <quic_mkrishn@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        linux-crypto@vger.kernel.org, linux-clk@vger.kernel.org,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Robert Foss <robert.foss@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 1/5] dt-bindings: socionext,uniphier-system-cache: drop
 minItems equal to maxItems
Message-ID: <20220829195543.GA2311490-robh@kernel.org>
References: <20220825113334.196908-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220825113334.196908-1-krzysztof.kozlowski@linaro.org>
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

On Thu, 25 Aug 2022 14:33:30 +0300, Krzysztof Kozlowski wrote:
> minItems, if missing, are implicitly equal to maxItems, so drop
> redundant piece to reduce size of code.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../bindings/arm/socionext/socionext,uniphier-system-cache.yaml  | 1 -
>  1 file changed, 1 deletion(-)
> 

Applied, thanks!
