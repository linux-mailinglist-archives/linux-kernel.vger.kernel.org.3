Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E7C0518B8E
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 19:54:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240756AbiECR6N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 13:58:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240745AbiECR6L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 13:58:11 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B891B2BB1A;
        Tue,  3 May 2022 10:54:37 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id ba17so659288edb.5;
        Tue, 03 May 2022 10:54:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DYnWSimLii7XmldXmtY2L01MclTrGLMilzsrbNwgPjk=;
        b=Z7OEEo6j2fNdaFTwVE47DarXux+705QL5n+yJ8Pfvm5DWGEz59nbOyDURUpT9QPHz5
         PNmaG2PCWtkrV1hfpLE5MSTik9c4YHZVObdY1ILBwRldIhLqnEhZvTqYBGWOv1ih49hx
         vYU9jochiOKhn5tin10fSHl0v8sszkDykyhDkmB6OHTGZlp3LdMjSkn3/78BVSBdSGuq
         xOe9zOBlFMrjBGR3rpBndsRjFwJwHY1G+VGjPNFITYgRB7DjnT9WFApeCi6EvRdAYELL
         cCaDNjb/ZlEyMQcQav41fHzmqqzFKM8xWqbJoqC3OmqZfaFLXq3SzzKuheCs9K/wAWQe
         nq+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DYnWSimLii7XmldXmtY2L01MclTrGLMilzsrbNwgPjk=;
        b=oqrssnKxk0Neu0J7+2v/ib85pAYiOMntViOXuzkakncnzWBXtWutpiRl2tibXZ2brp
         xPPg7YDdGXlkHJm/yAiHFnGSuXpJaG2jW9lNQL+oVCd4gFILj+X2xfhzQSWK3n4aYOW/
         dBNanatnthIT9x8JAlTWnJUUqDttKwETBHKlsI8uk+7vK6iTcH7F6+RcUwjsSxxnZk7S
         7wTk3yYqcOBHLLc7ALKL2cf04DVUkYI+TqBRiFVGGzh59grxOwydNeyYTXf5SWYZ3FZj
         iiAZuYAzMNt6nGhrt7thqXMISR61zyMA3Wbv3AzX4CSRcVNx3cGgAuW/QKTSBeJFCZw+
         3PhQ==
X-Gm-Message-State: AOAM5316E2Vwu8UHTDOUCUpX2D7nGmsTlwtdC8eIEiEsOkYA8+FwSbTp
        JHnehys+1Yb91CGeORqTRmUEt5/d1gg=
X-Google-Smtp-Source: ABdhPJxuZO00Q1eHmTZPmNGW7ManjOSzRlW8AwOypcs2vrYzGgOspXEleSxteXoztBVce5zDqER1zA==
X-Received: by 2002:aa7:c790:0:b0:41d:7e0f:f15c with SMTP id n16-20020aa7c790000000b0041d7e0ff15cmr18965786eds.129.1651600476354;
        Tue, 03 May 2022 10:54:36 -0700 (PDT)
Received: from kista.localnet (cpe1-3-76.cable.triera.net. [213.161.3.76])
        by smtp.gmail.com with ESMTPSA id bm13-20020a0564020b0d00b0042617ba63cfsm8234900edb.89.2022.05.03.10.54.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 May 2022 10:54:35 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     Chen-Yu Tsai <wens@csie.org>, Chukun Pan <amadeus@jmu.edu.cn>
Cc:     Samuel Holland <samuel@sholland.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        Chukun Pan <amadeus@jmu.edu.cn>
Subject: Re: [PATCH] arm64: dts: allwinner: define USB3 Ethernet on NanoPi R1S H5
Date:   Tue, 03 May 2022 19:54:34 +0200
Message-ID: <4393725.LvFx2qVVIh@kista>
In-Reply-To: <20220502144009.44575-1-amadeus@jmu.edu.cn>
References: <20220502144009.44575-1-amadeus@jmu.edu.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne ponedeljek, 02. maj 2022 ob 16:40:09 CEST je Chukun Pan napisal(a):
> The NanoPi R1S H5 has a Realtek RTL8153B USB 3.0 Ethernet chip
> connected to the USB 2.0 port of the Allwinner H5 SoC.
> 
> Signed-off-by: Chukun Pan <amadeus@jmu.edu.cn>
> ---
>  arch/arm64/boot/dts/allwinner/sun50i-h5-nanopi-r1s-h5.dts | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h5-nanopi-r1s-h5.dts b/
arch/arm64/boot/dts/allwinner/sun50i-h5-nanopi-r1s-h5.dts
> index 55b369534a08..dd655a491549 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-h5-nanopi-r1s-h5.dts
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-h5-nanopi-r1s-h5.dts
> @@ -21,7 +21,8 @@ / {
>  
>  	aliases {
>  		ethernet0 = &emac;
> -		ethernet1 = &rtl8189etv;
> +		ethernet1 = &rtl8153;
> +		ethernet2 = &rtl8189etv;
>  		serial0 = &uart0;
>  	};
>  
> @@ -116,6 +117,11 @@ &cpu0 {
>  
>  &ehci1 {
>  	status = "okay";

You need to add #address-cells and #size-cells properties, otherwise "make 
dtbs_check W=1" generates warnings.

Best regards,
Jernej

> +
> +	rtl8153: device@1 {
> +		compatible = "usbbda,8153";
> +		reg = <1>;
> +	};
>  };
>  
>  &ehci2 {
> -- 
> 2.25.1
> 
> 


