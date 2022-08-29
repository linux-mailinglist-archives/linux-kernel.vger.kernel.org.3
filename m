Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7663B5A550B
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 21:57:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229940AbiH2T4p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 15:56:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229803AbiH2T4S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 15:56:18 -0400
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60B17844E7;
        Mon, 29 Aug 2022 12:56:17 -0700 (PDT)
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-11ba6e79dd1so11742612fac.12;
        Mon, 29 Aug 2022 12:56:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=AunIincOW/llkkB3oHp4ZHdcx4kpGxMU+RJ3A3IG/tY=;
        b=ew95bmccqoC3iikOxfMO4AWtR9SWRX3dN43d3RgFfHjOsvdLzIIn9yJyIwj3rSDof2
         sSeFsdt9ZiIW8Us2X20CwbSxhVrmd6yT3c3fzJWQlieib+xOsirjrSnr0LFcgi4gNkpM
         jl3qlVDlepQ1qk/0v+Aio42TOuqDfZLxuhGQW+Up9BcBAPvdd23A4izyZcKWmKgkZf5l
         CByxw5uNt0N6F2ttB7aq/dSAMwhUtRHof3L41y60LHK8GD1fxuUWAfE6aRp/eXugbaKv
         AoGTza5bD2DqkYH2sofyH5ow9FA/Hucsi+otoIFZLokaChmEoLOBQ0ilMuCVEoq8HOiu
         XMRQ==
X-Gm-Message-State: ACgBeo1I0s0hicG4VCBMIIzp7EN97WY+ZAyr02XCXSVfdNeCSL40Knxk
        tDZ7r4rKm4TJ/D4utrBTsw==
X-Google-Smtp-Source: AA6agR4J4SxUZcpWUufmTiU9b6O//wx6vi31SnOVg0aW3VqYwToyBsF+9clL+Z+qnxJfLRs+zeT25A==
X-Received: by 2002:a05:6870:c386:b0:102:fcb:86cd with SMTP id g6-20020a056870c38600b001020fcb86cdmr8685701oao.296.1661802976466;
        Mon, 29 Aug 2022 12:56:16 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id s1-20020a4ac101000000b0044565e7ab41sm5473469oop.32.2022.08.29.12.56.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Aug 2022 12:56:15 -0700 (PDT)
Received: (nullmailer pid 2312686 invoked by uid 1000);
        Mon, 29 Aug 2022 19:56:13 -0000
Date:   Mon, 29 Aug 2022 14:56:13 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        "David S. Miller" <davem@davemloft.net>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-samsung-soc@vger.kernel.org,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Sean Paul <sean@poorly.run>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        freedreno@lists.freedesktop.org,
        Andre Przywara <andre.przywara@arm.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        linux-arm-msm@vger.kernel.org, linux-ide@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        linux-crypto@vger.kernel.org,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Robert Foss <robert.foss@linaro.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-tegra@vger.kernel.org,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Seung-Woo Kim <sw0312.kim@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Inki Dae <inki.dae@samsung.com>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Marek Vasut <marex@denx.de>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Krishna Manikandan <quic_mkrishn@quicinc.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-renesas-soc@vger.kernel.org, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        linux-arm-kernel@lists.infradead.org,
        Rob Clark <robdclark@gmail.com>
Subject: Re: [PATCH 4/5] dt-bindings: crypto: drop minItems equal to maxItems
Message-ID: <20220829195613.GA2312632-robh@kernel.org>
References: <20220825113334.196908-1-krzysztof.kozlowski@linaro.org>
 <20220825113334.196908-4-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220825113334.196908-4-krzysztof.kozlowski@linaro.org>
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

On Thu, 25 Aug 2022 14:33:33 +0300, Krzysztof Kozlowski wrote:
> minItems, if missing, are implicitly equal to maxItems, so drop
> redundant piece to reduce size of code.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  Documentation/devicetree/bindings/crypto/samsung-slimsss.yaml | 1 -
>  1 file changed, 1 deletion(-)
> 

Applied, thanks!
