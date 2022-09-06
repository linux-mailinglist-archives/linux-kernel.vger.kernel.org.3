Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C2BA5ADCA6
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 02:46:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233023AbiIFAqL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 20:46:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229817AbiIFAqJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 20:46:09 -0400
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::223])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BD70696E5;
        Mon,  5 Sep 2022 17:46:04 -0700 (PDT)
Received: (Authenticated sender: n@nfraprado.net)
        by mail.gandi.net (Postfix) with ESMTPSA id C8C4D60005;
        Tue,  6 Sep 2022 00:45:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nfraprado.net;
        s=gm1; t=1662425160;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Qc6NYY5YexS1HOTxn9qDikjXhg24+BGxEee+8YgWJDE=;
        b=B3cTm8GfX1EYIoLJc4q1Z3RO2PR3LQp/UZ9kTf3g3hvmUIAqtFl5XKHYnzCJCYMW23Z0ra
        xQRSSSnkS4Co4YBkIvIy+L5sc9mMw85G/3qkS/RYUbeNE+0MMXCNIB4iHE3LE2erUszrCX
        CLm73BkIp8Kz7UhULj5fKQ+yIabJIYZBuvh3OFm6/6uPsdhmkyC/2LxEpRKn/jpEf3iirD
        w9MmR0CQGP1gSY6tsKpo7yzk1uvtxPsU9m4WLcHv/OhX2ttxtu4aYFUtEHtR3NmzfQyuWe
        7Fm2jy9dat9B0JOvEVXkcjx5Jqq7Q8I12aS1kbX/muRY6VWx/ZQ9NPfttQ2bqQ==
Date:   Mon, 5 Sep 2022 20:45:54 -0400
From:   =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado <n@nfraprado.net>
To:     Ondrej Jirman <megi@xff.cz>
Cc:     linux-rockchip@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Martijn Braam <martijn@brixit.nl>,
        Tom Fitzhenry <tom@tom-fitzhenry.me.uk>,
        Caleb Connolly <kc@postmarketos.org>,
        Arnaud Ferraris <arnaud.ferraris@gmail.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/Rockchip SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] arm64: dts: rockchip: Fix SD card controller probe on
 Pinephone Pro
Message-ID: <20220906004554.btzmcjqox4n3hdtf@notapiano>
References: <20220904233652.3197885-1-megi@xff.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220904233652.3197885-1-megi@xff.cz>
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 05, 2022 at 01:36:47AM +0200, Ondrej Jirman wrote:
> Voltage constraints on vccio_sd are invalid. They don't match the voltages
> that LDO9 can generate, and this causes rk808-regulator driver to fail
> to probe with -EINVAL when it tries to apply the constraints during boot.
> 
> Fix the constraints to something that LDO9 can be actually configured for.
> 
> Fixes: 78a21c7d5952 ("arm64: dts: rockchip: Add initial support for Pine64 PinePhone Pro")
> Signed-off-by: Ondrej Jirman <megi@xff.cz>
> ---
>  arch/arm64/boot/dts/rockchip/rk3399-pinephone-pro.dts | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3399-pinephone-pro.dts b/arch/arm64/boot/dts/rockchip/rk3399-pinephone-pro.dts
> index f00c80361377a..2e058c3150256 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3399-pinephone-pro.dts
> +++ b/arch/arm64/boot/dts/rockchip/rk3399-pinephone-pro.dts
> @@ -253,8 +253,8 @@ regulator-state-mem {
>  
>  			vccio_sd: LDO_REG9 {
>  				regulator-name = "vccio_sd";
> -				regulator-min-microvolt = <1710000>;
> -				regulator-max-microvolt = <3150000>;
> +				regulator-min-microvolt = <1800000>;
> +				regulator-max-microvolt = <3300000>;

Shouldn't the maximum be 3.1V? The SDMMC0_VDD pin on RK3399 that this regulator
is connected to expects a maximum voltage of 3.15V, so 3.3V would be too high.
The output voltage for LDO9 is configured in 100mV steps, so I imagine that's
why 3.15V fails, but 3.1V should work fine. I haven't tested yet though.

Thanks,
Nícolas
