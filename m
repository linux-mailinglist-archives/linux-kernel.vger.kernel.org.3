Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F17A55201E5
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 18:05:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238789AbiEIQIk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 12:08:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238786AbiEIQIh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 12:08:37 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E035324DC4D
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 09:04:41 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id v11so12633455pff.6
        for <linux-kernel@vger.kernel.org>; Mon, 09 May 2022 09:04:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=UdDrFvMTPlFEuDpVKn6UuLvbfztwhknrVS+8QAPpwmc=;
        b=J3EEQLp2oqp41altc+Q/q8W3s+Sp3eLTohaUdz2/+Rwdmd4uuvgFyd7339k5RbOF5J
         i0AaAoLjX0X1wJgDB49H/+8/KghhdbUfVuMXZ6wcyVjMekL1Y4tpKKCuRDSlVjO38mEI
         kqbccxnmKopU6x3mIy/nRdpyecpwLAQhFCSofqR1aHqCAmthMpMQ5pATK2xOQOOiA3t5
         kS0E483Ul9E+JueJIPeLdAW7+AqXJqBFvvA8X6iSYaWjtxkdccVYu/7JwmC5bb+fTWfl
         3bcuz8MH0oRmoCEcgkEZ+/fcai/GFTzVp9fGDggQyEr+sNilKVrNN0dXynuqcIzL0ed8
         WPWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=UdDrFvMTPlFEuDpVKn6UuLvbfztwhknrVS+8QAPpwmc=;
        b=7QxjkRAwD/ewkQQ1lyFn6aVxxtV6EUvI161weaF6VoQxCNifdLQPHO3hgZV3zcK3R0
         xHXzSEm3DOJtim0dNyGGXRpH7iFfBT0VpixcX4L2cC0U3rF2/DCIgd2vR6YxTir6YpQ/
         jIttxYZ/tfu+DOTvhbv/EmAWqBRo14QOoNH1Tpg6bhmPlIRHI4mtg13WZoP66IqnCaeC
         9E0mqZCwDXWL6eIcASFJx/XZhYESK9NhKy5zM8CEs2vhugrWaO2bfPITdIBHnRhTnIc/
         bQSuKZO4OPPVKW8EIOi6CSuSTmhpEGvsAIArt73FS8SVfjs9K8AU7L9J+AbJeYNy8ROY
         8VHQ==
X-Gm-Message-State: AOAM532VGDQTorVhJMItad+KTklkSh/gZPrPBDVWTd85OOCCvC1wo4ok
        hdl0ElXH9Xr4chU1pqVux7H8lA==
X-Google-Smtp-Source: ABdhPJwMqknPNBUBGaG7wAm1Hvz84PnOG/5jowsuGzw29PwBE4WkdUvnp59PCpFdWkXcrI/bAl0vIA==
X-Received: by 2002:aa7:9085:0:b0:510:90d1:f445 with SMTP id i5-20020aa79085000000b0051090d1f445mr11764534pfa.67.1652112281331;
        Mon, 09 May 2022 09:04:41 -0700 (PDT)
Received: from p14s (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id q1-20020a170902dac100b0015e8d4eb2dfsm7330090plx.297.2022.05.09.09.04.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 May 2022 09:04:39 -0700 (PDT)
Date:   Mon, 9 May 2022 10:04:37 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] dt-bindings: remoteproc: st,stm32-rproc: Fix
 phandle-array parameters description
Message-ID: <20220509160437.GA3043772@p14s>
References: <20220505113639.1344281-1-arnaud.pouliquen@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220505113639.1344281-1-arnaud.pouliquen@foss.st.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 05, 2022 at 01:36:39PM +0200, Arnaud Pouliquen wrote:
> Replace the FIXME by appropriate description.
> 
> Fixes: 39bd2b6a3783 ("dt-bindings: Improve phandle-array schemas")
> Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../bindings/remoteproc/st,stm32-rproc.yaml      | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 

I have applied this patch.

Thanks,
Mathieu

> diff --git a/Documentation/devicetree/bindings/remoteproc/st,stm32-rproc.yaml b/Documentation/devicetree/bindings/remoteproc/st,stm32-rproc.yaml
> index be3d9b0e876b..da50f0e99fe2 100644
> --- a/Documentation/devicetree/bindings/remoteproc/st,stm32-rproc.yaml
> +++ b/Documentation/devicetree/bindings/remoteproc/st,stm32-rproc.yaml
> @@ -43,8 +43,8 @@ properties:
>      items:
>        - items:
>            - description: Phandle of syscon block
> -          - description: FIXME
> -          - description: FIXME
> +          - description: The offset of the trust zone setting register
> +          - description: The field mask of the trust zone state
>  
>    interrupts:
>      description: Should contain the WWDG1 watchdog reset interrupt
> @@ -101,8 +101,8 @@ properties:
>      items:
>        - items:
>            - description: Phandle of syscon block
> -          - description: FIXME
> -          - description: FIXME
> +          - description: The offset of the power setting register
> +          - description: The field mask of the PDDS selection
>  
>    st,syscfg-m4-state:
>      $ref: "/schemas/types.yaml#/definitions/phandle-array"
> @@ -111,8 +111,8 @@ properties:
>      items:
>        - items:
>            - description: Phandle of syscon block with the tamp register
> -          - description: FIXME
> -          - description: FIXME
> +          - description: The offset of the tamp register
> +          - description: The field mask of the Cortex-M4 state
>  
>    st,syscfg-rsc-tbl:
>      $ref: "/schemas/types.yaml#/definitions/phandle-array"
> @@ -122,8 +122,8 @@ properties:
>      items:
>        - items:
>            - description: Phandle of syscon block with the tamp register
> -          - description: FIXME
> -          - description: FIXME
> +          - description: The offset of the tamp register
> +          - description: The field mask of the Cortex-M4 resource table address
>  
>    st,auto-boot:
>      $ref: /schemas/types.yaml#/definitions/flag
> -- 
> 2.25.1
> 
