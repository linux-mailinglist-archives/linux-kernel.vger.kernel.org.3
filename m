Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 454B65AD954
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 20:57:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231791AbiIES51 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 14:57:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229818AbiIES50 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 14:57:26 -0400
Received: from proxmox1.postmarketos.org (proxmox1.postmarketos.org [IPv6:2a01:4f8:a0:821d::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9CC102A42A;
        Mon,  5 Sep 2022 11:57:24 -0700 (PDT)
Received: from [192.168.0.10] (cpc76482-cwma10-2-0-cust629.7-3.cable.virginm.net [86.14.22.118])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by proxmox1.postmarketos.org (Postfix) with ESMTPSA id 97379140219;
        Mon,  5 Sep 2022 18:57:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=postmarketos.org;
        s=donut; t=1662404241;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LBvAqqQOyOWJbCs1+9iccQj8h42oT69uG8pHawssG8k=;
        b=bWEvj25cxDUevqNgHjeHPNntNLa7FVW97+Kuh41iluYM8+bU9GZAKGAInlZtOJ1LkyBWwt
        AsKM0+qTDfhFep3xqAYvz8tf9fTMli5hifsgZ+fG2AMfInWvLgFTHvlqjN93bpf06iDnma
        0EfoiidKVs2YT5N8wY04X8EF1a/uT1g=
Message-ID: <23985fdd-c517-6883-6da4-2582655cc4d6@postmarketos.org>
Date:   Mon, 5 Sep 2022 19:57:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH] arm64: dts: rockchip: Fix SD card controller probe on
 Pinephone Pro
Content-Language: en-US
To:     Ondrej Jirman <megi@xff.cz>, linux-rockchip@lists.infradead.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Martijn Braam <martijn@brixit.nl>,
        Tom Fitzhenry <tom@tom-fitzhenry.me.uk>,
        Arnaud Ferraris <arnaud.ferraris@gmail.com>,
        =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= <n@nfraprado.net>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/Rockchip SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20220904233652.3197885-1-megi@xff.cz>
From:   Caleb Connolly <kc@postmarketos.org>
In-Reply-To: <20220904233652.3197885-1-megi@xff.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 05/09/2022 00:36, Ondrej Jirman wrote:
> Voltage constraints on vccio_sd are invalid. They don't match the voltages
> that LDO9 can generate, and this causes rk808-regulator driver to fail
> to probe with -EINVAL when it tries to apply the constraints during boot.
> 
> Fix the constraints to something that LDO9 can be actually configured for.
> 
> Fixes: 78a21c7d5952 ("arm64: dts: rockchip: Add initial support for Pine64 PinePhone Pro")
> Signed-off-by: Ondrej Jirman <megi@xff.cz>

Reviewed-by: Caleb Connolly <kc@postmarketos.org>
> ---
>   arch/arm64/boot/dts/rockchip/rk3399-pinephone-pro.dts | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3399-pinephone-pro.dts b/arch/arm64/boot/dts/rockchip/rk3399-pinephone-pro.dts
> index f00c80361377a..2e058c3150256 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3399-pinephone-pro.dts
> +++ b/arch/arm64/boot/dts/rockchip/rk3399-pinephone-pro.dts
> @@ -253,8 +253,8 @@ regulator-state-mem {
>   
>   			vccio_sd: LDO_REG9 {
>   				regulator-name = "vccio_sd";
> -				regulator-min-microvolt = <1710000>;
> -				regulator-max-microvolt = <3150000>;
> +				regulator-min-microvolt = <1800000>;
> +				regulator-max-microvolt = <3300000>;
>   			};
>   
>   			vcc3v3_s0: SWITCH_REG {
