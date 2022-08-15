Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB4BA592CFB
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 12:52:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241338AbiHOIkN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 04:40:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241110AbiHOIkM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 04:40:12 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9DB420181
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 01:40:10 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id z16so8255227wrh.12
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 01:40:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=bm9cYKRK81euJlBrGN8MvVluF+drZ+BzmhRUFWVH330=;
        b=gJ5yrzBGibuV05aqPOSwb1FoEJAQ8a7yyHsvre8Cq5bFu/sT1A5miPn20lP1i5oi/i
         dl4IpoSCsZ4OZUvf5Hai/FSvREYx6TgHG/nfPodyIJ02MV7m6HTKw+JMTLJQJkxb4QGi
         ZRlYVQn8URafRJURRlNLQypBkEHjHIJwrna6lJ/424xgrUnaaux8J0SsWwUGyOl1DJRl
         Zl+XHgrwW0YjPQVdWtA21tikSMParSQLhf3jiOWJee9V4j/b9P3vOVwVT1juPosc1+19
         ZoikzieoyimJmgbeG4gKB35wpO2qZAjKJp07yPiU/QGE8mHe0W6tv+WpJxReTfqi6W41
         3kiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=bm9cYKRK81euJlBrGN8MvVluF+drZ+BzmhRUFWVH330=;
        b=O7DAQC8HFQwg/I2p/V2dUyE7SyJpUxgJzIBKn64FTPA37BrCaBPybVvk+Ts1bRIHEu
         /4WBOJ4TGU3gch8JkpgewYz2YuxhfRYUO2F9ibcW4vLLhp9w8JiIGKdiATTdcX+X1Rv0
         AJRmCTTdnVwFP/ogurCx30ZiRtFngvjLhFI9qdddH0QL5DnAF5UQ/05QtKh69olzkEsA
         5OtpNX0GGe8y+FNdgWV9lTv47HPPq5cMe9zgFZW3haNMAIPLD4pukFbqyGo3aZi1sVro
         u40FCX5qy3/tmU5bwkBEZk73tLnv+JP5fWjuR76NWpBalkI/4K3NGgKdSghBuVHDorIF
         Zk5w==
X-Gm-Message-State: ACgBeo0IaHA39QTCKe0my+NeE1vxsrlT1/8z3Dxqduy3DP4WwST96SAM
        6Jhq9FVi96FLDtOl0fWtCrMqWw==
X-Google-Smtp-Source: AA6agR4PzPl+pDuLWXzH5XMOvYgo5VUH0K440o80nb9n02ikvcPs1DEmxQgy5UVZZbh8rYoA6zT3VA==
X-Received: by 2002:adf:fb0e:0:b0:21a:34a2:5ca9 with SMTP id c14-20020adffb0e000000b0021a34a25ca9mr8205199wrr.472.1660552809331;
        Mon, 15 Aug 2022 01:40:09 -0700 (PDT)
Received: from linaro.org ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id s4-20020adfdb04000000b002211fc70174sm8028501wri.99.2022.08.15.01.40.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Aug 2022 01:40:08 -0700 (PDT)
Date:   Mon, 15 Aug 2022 11:40:06 +0300
From:   Abel Vesa <abel.vesa@linaro.org>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, abelvesa@kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, Peng Fan <peng.fan@nxp.com>,
        Rob Herring <robh@kernel.org>
Subject: Re: [PATCH V2 1/8] dt-bindings: clock: imx93-clock: add more MU/SAI
 clocks
Message-ID: <YvoGZqrLOsxDWsWG@linaro.org>
References: <20220815013039.474970-1-peng.fan@oss.nxp.com>
 <20220815013039.474970-2-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220815013039.474970-2-peng.fan@oss.nxp.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22-08-15 09:30:32, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Add MU[1,2]_[A,B] clock entries.
> Add SAI IPG clock entries.
> 
> Acked-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

Reviewed-by: Abel Vesa <abel.vesa@linaro.org>

> ---
>  include/dt-bindings/clock/imx93-clock.h | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/include/dt-bindings/clock/imx93-clock.h b/include/dt-bindings/clock/imx93-clock.h
> index 21fda9c5cb5e..19bc32788d81 100644
> --- a/include/dt-bindings/clock/imx93-clock.h
> +++ b/include/dt-bindings/clock/imx93-clock.h
> @@ -196,6 +196,13 @@
>  #define IMX93_CLK_TMC_GATE		187
>  #define IMX93_CLK_PMRO_GATE		188
>  #define IMX93_CLK_32K			189
> -#define IMX93_CLK_END			190
> +#define IMX93_CLK_SAI1_IPG		190
> +#define IMX93_CLK_SAI2_IPG		191
> +#define IMX93_CLK_SAI3_IPG		192
> +#define IMX93_CLK_MU1_A_GATE		193
> +#define IMX93_CLK_MU1_B_GATE		194
> +#define IMX93_CLK_MU2_A_GATE		195
> +#define IMX93_CLK_MU2_B_GATE		196
> +#define IMX93_CLK_END			197
>  
>  #endif
> -- 
> 2.37.1
> 
