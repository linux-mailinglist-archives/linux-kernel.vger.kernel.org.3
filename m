Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1256F552F6E
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 12:07:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231805AbiFUKHN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 06:07:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbiFUKHL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 06:07:11 -0400
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 395C027FEB
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 03:07:09 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: marcan@marcan.st)
        by mail.marcansoft.com (Postfix) with ESMTPSA id DE18A41DF4;
        Tue, 21 Jun 2022 10:07:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=marcan.st; s=default;
        t=1655806027; bh=mENta8LrzbYHKgS3y0BpqM4Nb7jfJxw8OCgUAYE0nlk=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=p8C3ksm6LXw1QNi98fXAdAcOkNhopVRn2G7HrRekhs3u0CmEbepH5iOgVmRkCFmLd
         KHtajS5pw6+ebcwMSbU4MNtAOKIpUY+Xmp4XBn45lJyXpF8vpA1qz2qzl/AiO+/BY2
         nUJhKf/BSZRI4HacI4K6Ojq1S3ZHw/Crw+1kLT3oNzFLgeV47CuYdGfzi1TvtIlWl7
         XMf1oID/q/NEv/oBjPIjV1ka6ltDMKDFEloEvhzngU/ozuLLIxT4gOnyxMV0hOTvb8
         0hxcUQLP5ENUdKiJLDbQ1ipi4uGREhdNJhAQNoHOh3gZ2ebl0Xyb6p0x6DkbPSvdSE
         Qpj04li02/Mrw==
Message-ID: <9d683b37-abb0-a0d6-417a-b5f7c97673c5@marcan.st>
Date:   Tue, 21 Jun 2022 19:07:02 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 1/2] arm64: dts: apple: Re-parent ANS2 power domains
Content-Language: es-ES
To:     Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220602174213.2737-1-sven@svenpeter.dev>
From:   Hector Martin <marcan@marcan.st>
In-Reply-To: <20220602174213.2737-1-sven@svenpeter.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/06/2022 02.42, Sven Peter wrote:
> From: Hector Martin <marcan@marcan.st>
> 
> Turns out that the APCIE_ST*_SYS domains do hard-depend on ANS2, so
> without this they refuse to power up.
> 
> Signed-off-by: Hector Martin <marcan@marcan.st>
> Reviewed-by: Sven Peter <sven@svenpeter.dev>
> Signed-off-by: Sven Peter <sven@svenpeter.dev>
> ---
>  arch/arm64/boot/dts/apple/t8103-pmgr.dtsi | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/apple/t8103-pmgr.dtsi b/arch/arm64/boot/dts/apple/t8103-pmgr.dtsi
> index fc51bc872468..a6dbb1f485d8 100644
> --- a/arch/arm64/boot/dts/apple/t8103-pmgr.dtsi
> +++ b/arch/arm64/boot/dts/apple/t8103-pmgr.dtsi
> @@ -725,11 +725,6 @@ ps_ans2: power-controller@3f0 {
>  		#power-domain-cells = <0>;
>  		#reset-cells = <0>;
>  		label = "ans2";
> -		/*
> -		 * The ADT makes ps_apcie_st depend on ps_ans2 instead, but this
> -		 * doesn't make much sense since ANS2 uses APCIE_ST.
> -		 */
> -		power-domains = <&ps_apcie_st>;
>  	};
>  
>  	ps_gfx: power-controller@3f8 {
> @@ -836,7 +831,7 @@ ps_apcie_st: power-controller@418 {
>  		#power-domain-cells = <0>;
>  		#reset-cells = <0>;
>  		label = "apcie_st";
> -		power-domains = <&ps_apcie>;
> +		power-domains = <&ps_apcie>, <&ps_ans2>;
>  	};
>  
>  	ps_ane_sys: power-controller@470 {

Applied both patches to asahi-soc/dt. Thanks!

-- 
Hector Martin (marcan@marcan.st)
Public Key: https://mrcn.st/pub
