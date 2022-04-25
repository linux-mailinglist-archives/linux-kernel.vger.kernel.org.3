Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54F2350DACF
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 10:02:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232835AbiDYICP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 04:02:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235905AbiDYIBW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 04:01:22 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79BDB27B39
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 00:58:14 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id m15-20020a7bca4f000000b0038fdc1394b1so11942876wml.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 00:58:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=+bRYkBAn8sJsc8S2sn1YixNkNlBLK97NL9Q4uOqNbl8=;
        b=x6WtLuYWYuF97BgnCNc9JW0y/6GvCi2/ay6eRQNC9ttlaB8lhAbKfcDwpy37nGsXY4
         2U6CQsQLXByP3D/B9vOuWvUgDAsCSFYbYPXCwvL0xFnCOSkatlifKdOKSsXwQy2VEqr6
         uwvUOcmk9sRh5M4iDm2ZsIgYhTzI/OCPB34c4gyy9vY9ihgO5c5Laq0ok43mVDSm1rzd
         wSkV5jUxyDGp3P0yRMLK30v1vOxg347tCfv3GQw6g5pVKg1mCVOWdmMVukOoPKLxKHhP
         9v2SUzF3Z1V1X/7iQulzKuMe4S9FHgR1s8YnKIxrFi9zY2EBlDDxcX/ffnWQ1NJa3dmi
         yL2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=+bRYkBAn8sJsc8S2sn1YixNkNlBLK97NL9Q4uOqNbl8=;
        b=Dd0OyxDcQbNg4dndZGyiCyFgM6MVOfnXgXWflPuXCdjGQ0VdbU0zR7KB/SzRLB5Vf8
         JEFWvkUoG4iod8iDxHBrIGyBJ12BmtSND7GJ+LPS6xw9hH8v+luYXTy0HuaPD2/86f0s
         /ArtAJvCTE5P9UP9erLoRCyLhMZMjQ9RnumJWXTltGmehyW7Xd0JB5xIXIHr+Xf3Pz9E
         JP6eLERsh7Wl5I3vpa+kbFeJ7Yh0w27g1qfMs0+X73oK/A19EqxN8xrBZkFC5Tuc43fB
         RQ4BDT068VAO1cRIXcsdiFQZo9IaemNd3WArw+RlF1KRuH3wLKFJWi5prJa7D6HyYln+
         EBmA==
X-Gm-Message-State: AOAM532OB7odmbRrn4TIeDiryRTgLC3W3SSGUB5adgtTIlOqRrTmjkZd
        zWdJ0YjMAXujBxQ21RAe770gnw==
X-Google-Smtp-Source: ABdhPJylAV5y97CjPKk6ZjamGuPD2bl7abNODAPfaYuKP1LaIVk/UKUAWnSA93i5CUWcJx8BlG2U6Q==
X-Received: by 2002:a1c:2542:0:b0:38e:b64c:6afb with SMTP id l63-20020a1c2542000000b0038eb64c6afbmr15255147wml.65.1650873492893;
        Mon, 25 Apr 2022 00:58:12 -0700 (PDT)
Received: from google.com (cpc155339-bagu17-2-0-cust87.1-3.cable.virginm.net. [86.27.177.88])
        by smtp.gmail.com with ESMTPSA id p125-20020a1c2983000000b0038e6c62f527sm9572862wmp.14.2022.04.25.00.58.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Apr 2022 00:58:12 -0700 (PDT)
Date:   Mon, 25 Apr 2022 08:58:10 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Peter Rosin <peda@axentia.se>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: Drop undocumented i.MX iomuxc-gpr bindings
 in examples
Message-ID: <YmZUko/EQkKl6Npl@google.com>
References: <20220422192121.2592030-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220422192121.2592030-1-robh@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Apr 2022, Rob Herring wrote:

> The i.MX iomuxc-gpr bindings are undocumented and a mess. Drop their use
> from the examples.
> 
> The problem with the binding beyond the just random variations is that
> the iomuxc-gpr is not a separate block, but registers within the iomuxc
> block containing random leftover controls. As a separate DT node, it
> creates nodes with overlapping memory addresses.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  Documentation/devicetree/bindings/mfd/syscon.yaml  | 8 --------
>  Documentation/devicetree/bindings/mux/reg-mux.yaml | 1 -
>  2 files changed, 9 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/mfd/syscon.yaml b/Documentation/devicetree/bindings/mfd/syscon.yaml
> index 13baa452cc9d..fb784045013f 100644
> --- a/Documentation/devicetree/bindings/mfd/syscon.yaml
> +++ b/Documentation/devicetree/bindings/mfd/syscon.yaml
> @@ -100,12 +100,4 @@ examples:
>          compatible = "allwinner,sun8i-h3-system-controller", "syscon";
>          reg = <0x01c00000 0x1000>;
>      };
> -
> -  - |
> -    gpr: iomuxc-gpr@20e0000 {
> -        compatible = "fsl,imx6q-iomuxc-gpr", "syscon";
> -        reg = <0x020e0000 0x38>;
> -        hwlocks = <&hwlock1 1>;
> -    };
> -
>  ...
> diff --git a/Documentation/devicetree/bindings/mux/reg-mux.yaml b/Documentation/devicetree/bindings/mux/reg-mux.yaml
> index 60d5746eb39d..df4db96b5391 100644
> --- a/Documentation/devicetree/bindings/mux/reg-mux.yaml
> +++ b/Documentation/devicetree/bindings/mux/reg-mux.yaml
> @@ -96,7 +96,6 @@ examples:
>  
>      #include <dt-bindings/mux/mux.h>
>      syscon@1000 {
> -        compatible = "fsl,imx7d-iomuxc-gpr", "fsl,imx6q-iomuxc-gpr", "syscon", "simple-mfd";
>          reg = <0x1000 0x100>;

Is leaving no compatible the correct solution here?

Do we have another (working) platform that we can use in its place?

Does it make sense to leave the "syscon" and "simple-mfd" entries?

>          mux2: mux-controller {

-- 
Lee Jones [李琼斯]
Principal Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
