Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BED24573E45
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 22:54:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237311AbiGMUx7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 16:53:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237313AbiGMUxr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 16:53:47 -0400
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com [IPv6:2001:4860:4864:20::2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8D4110546
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 13:53:37 -0700 (PDT)
Received: by mail-oa1-x2d.google.com with SMTP id 586e51a60fabf-10c0119dd16so60107fac.6
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 13:53:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=OYmf+T3lRc79u5oDlMjUbDjfxPJAcVJEHMhxiR51+Fs=;
        b=SPhcykdTfoAFVar5hEaib1+zz9NzmHisUsycRp2UDMoNG73WmZTrMmthYDs9PJy+lk
         E5CWEEcNe60QEHQ2UdvFucM3qtTTgDsr/oqFlA/rMjnFSzqmZn61X9WjMnh4LwwjwRc2
         GoruyrKbxN3BuW3Rc2cJ8Whd/8PWXDmhT341ciiBYGyVNxKr+HDznUeYoFGN7kLoVNDy
         i1dzYC6xWbnyAyttKpugkAV1rgFWYKyJpjxQZPThq09IeXIvGJEawVTlVxpKnALIF2mJ
         O22PciPb/l5TNJxCgnTkUVfN2m5aAxEMyKqKi8LmcsepGnvx9VR9//rITXVywg/UQFTL
         zwTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=OYmf+T3lRc79u5oDlMjUbDjfxPJAcVJEHMhxiR51+Fs=;
        b=opqLR/oTVIf7GQLsGIDkCnwij3fKeJ4PVUaNUvouY79XP4L7zbXIIc+JSJOV1N4nbE
         6DN/agBSYsbkwbpryw2JpUsltYVK88CkwX9XlU/wPMFGEEXZoLf4cYelNEt3fMtXUyjy
         O0GG0h+hcPEroWq6w0is/+q/jkWyxGO7ND3+RO8aR9ow58yuy2Z8wW98zlOSZoJl0CI0
         kTrxKVTJLZYxk4KHy/HS6xxmEbsj/dwiySkimuXCcxJwyl9o2AYmIt2V6PdjKig5jB/h
         bkmBWSvqJLN9oDrT1bZJtOkt4RWyLJtk3pV5CiWbTJ+3Ng6BbK3ayUVmPC3hZGKTAZwX
         bPtA==
X-Gm-Message-State: AJIora+NvYxSgQRg5t0Y2oipqF/vPqdfDl7DrcjVoGMbp7WT1q1FnrLz
        oCHcAg5RMmEoEJ5Bek/njryttA==
X-Google-Smtp-Source: AGRyM1vw8R/0Mik936bygCkJyPGmua0fl/ZV3zFCx7E6u2dNDZEHeSILD5mtPkiG+LUPBJJ6xtRWEg==
X-Received: by 2002:a05:6870:e0cd:b0:10c:289b:c8f0 with SMTP id a13-20020a056870e0cd00b0010c289bc8f0mr2800216oab.74.1657745617077;
        Wed, 13 Jul 2022 13:53:37 -0700 (PDT)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id kv17-20020a056870fb9100b00101c76f7831sm6502446oab.24.2022.07.13.13.53.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jul 2022 13:53:36 -0700 (PDT)
Date:   Wed, 13 Jul 2022 15:53:34 -0500
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Joel Selvaraj <jo@jsfamily.in>
Cc:     Andy Gross <agross@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org
Subject: Re: [PATCH 2/5] arm64: dts: qcom: sdm845-xiaomi-beryllium-common:
 generalize the display panel node
Message-ID: <Ys8wzodQNI5ZrUUM@builder.lan>
References: <20220708111207.85249-1-jo@jsfamily.in>
 <MN2PR02MB702479BBA7FE8757E577CA6DD9829@MN2PR02MB7024.namprd02.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MN2PR02MB702479BBA7FE8757E577CA6DD9829@MN2PR02MB7024.namprd02.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 08 Jul 06:12 CDT 2022, Joel Selvaraj wrote:

> Make the display panel nodes generic. The tianma and ebbg variant will
> set the compatabile property as per the display model they use.
> 
> Signed-off-by: Joel Selvaraj <jo@jsfamily.in>
> ---
>  .../boot/dts/qcom/sdm845-xiaomi-beryllium-common.dtsi     | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-common.dtsi b/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-common.dtsi
> index d88dc07205f7..634999cf8987 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-common.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-common.dtsi
> @@ -221,8 +221,8 @@ &dsi0 {
>  	status = "okay";
>  	vdda-supply = <&vreg_l26a_1p2>;
>  
> -	panel@0 {
> -		compatible = "tianma,fhd-video";
> +	display_panel: panel@0 {
> +		status = "disabled";

Please make "status" the last property defined in the node. Same comment
on the next 2 patches.

Thanks,
Bjorn

>  		reg = <0>;
>  		vddio-supply = <&vreg_l14a_1p8>;
>  		vddpos-supply = <&lab>;
> @@ -235,7 +235,7 @@ panel@0 {
>  		reset-gpios = <&tlmm 6 GPIO_ACTIVE_LOW>;
>  
>  		port {
> -			tianma_nt36672a_in_0: endpoint {
> +			panel_in_0: endpoint {
>  				remote-endpoint = <&dsi0_out>;
>  			};
>  		};
> @@ -243,7 +243,7 @@ tianma_nt36672a_in_0: endpoint {
>  };
>  
>  &dsi0_out {
> -	remote-endpoint = <&tianma_nt36672a_in_0>;
> +	remote-endpoint = <&panel_in_0>;
>  	data-lanes = <0 1 2 3>;
>  };
>  
> -- 
> 2.36.1
> 
