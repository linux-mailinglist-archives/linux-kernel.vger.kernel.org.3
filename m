Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 473084C8212
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 05:16:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231601AbiCAEQr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 23:16:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbiCAEQn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 23:16:43 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D1902F026
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 20:16:03 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id bx9-20020a17090af48900b001bc64ee7d3cso1113646pjb.4
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 20:16:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=KhWC54mH+BIWxrEus55KBPvsAOUPn79ymjvbcax9p8k=;
        b=W/+o+gzPs0IucCzQpXe/hW7oHCroBWchswx4x+IW1T8ikPLDEevOIe12bLh3Zr+8e+
         uiyAUzIziIqljsw8DZHFoOZRgUr7l0phA2WiuuLZvJ4liy0CSByqY3vGStiUALNWwd8j
         8IrbdA4CkPgDrHESTOhcDW+OAsnwnH+pzzaCJH3tbdSt5c7wFTU1IFPZln6BJ8023MMj
         oihelxVUqWgZ3H65KUlCyVS39o9AFr/9Y7zr+6kJVlfIxQYwvCl5k2CY2oDOEBADqEkh
         jg7DfMSf5n5AdzPcTiVIEKfNxb5cTyiEOT9aVPstpGQkorKzjI00cw0dmJFnQdbgcPWe
         MAhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=KhWC54mH+BIWxrEus55KBPvsAOUPn79ymjvbcax9p8k=;
        b=BAW0HNXWnsSPNZ/Kgn27r8goLX1jdLpBfpX0ncD1LiRKE/ItiN7O/CR2EkzGkezgGg
         TCs1Im51B8sio0KEVZTPQPJKoxfzudrkUBUb7S8v2QrSJl4TvIgzZ3IToZnfoJWfXWOJ
         TdP2sqqLGIK4OjzWTlYxHsBp7FbV6nG+OJGxcobk43iFl76RWm3+WIJci2RyRWmAqXSj
         h9X0kRuBVx1X+VIUzIvz+B2ZueT/rw5qTj5g0f7Kfx5bn9OfPC9OnSyxX8lKL4gOGwfN
         hbdFUqbgcCvmNFtYJ7yVAK9fNS/CICyvxLsF2kTNpSew2chAxdFCJril2UqcJo8PDeBp
         LCaw==
X-Gm-Message-State: AOAM533FAlthL9+pMV/lgHThog0wXV/37iz8x5G/fPzer7qVOvwu4AGR
        WPJNiqpLuC5qlmZPypYD7KLwjw==
X-Google-Smtp-Source: ABdhPJx+KDbaCtnr5/iSs/iENqUtZNEYQYW6xikSgRQFLKJekESfaH4ej9ewUCPL03855qHDRMiBwA==
X-Received: by 2002:a17:90b:3d02:b0:1bc:85fa:e24 with SMTP id pt2-20020a17090b3d0200b001bc85fa0e24mr19926186pjb.239.1646108163083;
        Mon, 28 Feb 2022 20:16:03 -0800 (PST)
Received: from dragon (80.251.214.228.16clouds.com. [80.251.214.228])
        by smtp.gmail.com with ESMTPSA id f13-20020a056a001acd00b004f0f9a967basm15588688pfv.100.2022.02.28.20.16.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Feb 2022 20:16:02 -0800 (PST)
Date:   Tue, 1 Mar 2022 12:15:56 +0800
From:   Shawn Guo <shawn.guo@linaro.org>
To:     Bhupesh Sharma <bhupesh.sharma@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, bhupesh.linux@gmail.com,
        agross@kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, vkoul@kernel.org,
        linux-phy@lists.infradead.org, robh+dt@kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: Re: [PATCH v2 2/8] dt-bindings: phy: qcom,qmp: Describe
 'vdda-max-microamp' & 'vdda-pll-max-microamp' properties
Message-ID: <20220301041556.GJ269879@dragon>
References: <20220228123019.382037-1-bhupesh.sharma@linaro.org>
 <20220228123019.382037-3-bhupesh.sharma@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220228123019.382037-3-bhupesh.sharma@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 28, 2022 at 06:00:13PM +0530, Bhupesh Sharma wrote:
> Since a few boards based on QCoM qmp phy use the
> 'vdda-max-microamp' & 'vdda-pll-max-microamp' properties to
> describe the ufs phy nodes, add them to the dt-bindings doc as well.

Does qmp-phy driver actually use them?

Shawn

> 
> This fixes the following '$ make dtbs_check' warning(s):
> 
> sm8350-microsoft-surface-duo2.dt.yaml: phy@1d87000:
>   'vdda-max-microamp', 'vdda-pll-max-microamp' do not match any of
>    the regexes: '^phy@[0-9a-f]+$', 'pinctrl-[0-9]+'
> 
> Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> Cc: Vinod Koul <vkoul@kernel.org>
> Cc: Rob Herring <robh+dt@kernel.org>
> Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
> ---
>  Documentation/devicetree/bindings/phy/qcom,qmp-phy.yaml | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/phy/qcom,qmp-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,qmp-phy.yaml
> index 48cd6b6171a1..70e7cd75e173 100644
> --- a/Documentation/devicetree/bindings/phy/qcom,qmp-phy.yaml
> +++ b/Documentation/devicetree/bindings/phy/qcom,qmp-phy.yaml
> @@ -87,6 +87,14 @@ properties:
>      minItems: 1
>      maxItems: 3
>  
> +  vdda-max-microamp:
> +    description:
> +      Specifies max. load that can be drawn from phy supply.
> +
> +  vdda-pll-max-microamp:
> +    description:
> +      Specifies max. load that can be drawn from pll supply.
> +
>    vdda-phy-supply:
>      description:
>        Phandle to a regulator supply to PHY core block.
> -- 
> 2.35.1
> 
