Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 342F55A5541
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 22:02:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229921AbiH2UBz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 16:01:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiH2UBu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 16:01:50 -0400
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04C2893225;
        Mon, 29 Aug 2022 13:01:50 -0700 (PDT)
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-11ee4649dfcso5398749fac.1;
        Mon, 29 Aug 2022 13:01:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=ogC4r+k0mr20QhnHahw3ccg4AiV6JfA8GAM67/NqzeE=;
        b=nHkDn14XQIlT0v4vnVHxxgrH0Zh/NhFPdbvELHuH+vJ998ji+qvuWeIDos0XUmhvj1
         8HbOj4ioByQilINFhP3VuVs/jxq4Db4xxqwGs31q1eRnmEaNocP3LrroOlnDBeQU2RfB
         z0XXaDUkYK/jiBnQCxidzh4uiN85xdn+/W+5IMpzZ1MzbXTC3tsgjaNWSZtXNLYCp5HY
         CwBPqGnZVi4ZkzXwdiM4YYc6jfzCBJQLpPgSyOEhKm0wwCNJAlHbzLDwrRprQLTIk03s
         C9GYVkwYtCzIbv9sqmesrzM0LYpD+H7vV66N7hofWAvL6nbwSb+w+F/xafqdxCVFYX9E
         UikQ==
X-Gm-Message-State: ACgBeo2I7wnkmAvpz+y0pSY06FqX5IRyy05nb9nHmN0dD3YUdn0R2Amo
        K7sI8C1RfJoBBJ55WKDWsQ==
X-Google-Smtp-Source: AA6agR7DOp+A6RsB1UmGlV9+oiTISpjy2cXXh0pVgvB2TxU3TV9Wi95VNYVNWNoPW19nH+WEFqwQsw==
X-Received: by 2002:a05:6870:ac09:b0:11d:ca1b:d752 with SMTP id kw9-20020a056870ac0900b0011dca1bd752mr8164695oab.93.1661803309253;
        Mon, 29 Aug 2022 13:01:49 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id p4-20020a9d4544000000b0061cbd18bd18sm6316858oti.45.2022.08.29.13.01.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Aug 2022 13:01:48 -0700 (PDT)
Received: (nullmailer pid 2322815 invoked by uid 1000);
        Mon, 29 Aug 2022 20:01:47 -0000
Date:   Mon, 29 Aug 2022 15:01:47 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Jonathan Hunter <jonathanh@nvidia.com>, linux-ide@vger.kernel.org,
        Vladimir Zapolskiy <vz@mleia.com>,
        linux-samsung-soc@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Robert Foss <robert.foss@linaro.org>,
        linux-clk@vger.kernel.org, linux-crypto@vger.kernel.org,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Andre Przywara <andre.przywara@arm.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        devicetree@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Seung-Woo Kim <sw0312.kim@samsung.com>,
        freedreno@lists.freedesktop.org,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Jonas Karlman <jonas@kwiboo.se>,
        Krishna Manikandan <quic_mkrishn@quicinc.com>,
        linux-kernel@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        David Airlie <airlied@linux.ie>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        linux-renesas-soc@vger.kernel.org, Marek Vasut <marex@denx.de>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Sean Paul <sean@poorly.run>,
        "David S. Miller" <davem@davemloft.net>,
        Michael Turquette <mturquette@baylibre.com>,
        dri-devel@lists.freedesktop.org,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        linux-tegra@vger.kernel.org, Inki Dae <inki.dae@samsung.com>
Subject: Re: [PATCH 3/5] dt-bindings: clock: drop minItems equal to maxItems
Message-ID: <20220829200147.GA2322759-robh@kernel.org>
References: <20220825113334.196908-1-krzysztof.kozlowski@linaro.org>
 <20220825113334.196908-3-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220825113334.196908-3-krzysztof.kozlowski@linaro.org>
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

On Thu, 25 Aug 2022 14:33:32 +0300, Krzysztof Kozlowski wrote:
> minItems, if missing, are implicitly equal to maxItems, so drop
> redundant piece to reduce size of code.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  Documentation/devicetree/bindings/clock/cirrus,cs2000-cp.yaml   | 1 -
>  .../devicetree/bindings/clock/renesas,rcar-usb2-clock-sel.yaml  | 2 --
>  Documentation/devicetree/bindings/clock/samsung,s2mps11.yaml    | 1 -
>  3 files changed, 4 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
