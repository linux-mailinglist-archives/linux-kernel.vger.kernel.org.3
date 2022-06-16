Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 460A654EB65
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 22:40:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378481AbiFPUkG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 16:40:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378124AbiFPUkC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 16:40:02 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B48105DBE4
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 13:40:01 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id r5so2263254pgr.3
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 13:40:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=JtBNgW1ARnpZB6Usfv9UpMfEN0Bux+WIpRpd7bK6hxQ=;
        b=OSvwT9JLcNTz2PhtzapCz8T4/EZ5bjSd/8SuAYqCmqs9XM+JGPsYPVpZ0Hs6+4PIuA
         a7bYZtU1CVgpeFZFwwMIZ7jZvcgSn8+4wedjyZZRF7y72wvf/W5QFky8iHWAP9FShTxx
         w/B5oRXmdgzFfKAcEI9wfz/+TXI16XsDH5fnI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JtBNgW1ARnpZB6Usfv9UpMfEN0Bux+WIpRpd7bK6hxQ=;
        b=gkT0c2qx0myUgQLR7H2rXSG5FVF2qK9Y2pNAMB/8hwdzPAkgXCDyFDwJLJLqodxpJH
         B01EJbWCBDPr1IrWQHSKbManK3I80dt+AdzWJYrTrQ2U+W104Sp0HqO4kVwpX1ExsttO
         YBZ+hj9PLWIKmOlMDTyn81I1Memfpjd4h0MfG+mmRUwWGfqddB4XtPPmK4gBlJFf/RE8
         fWklmAyij+7IhztZ5lqIibQLQQB8iKfvFz1jEu2Gj6ac+Q+066OZiHpoIyGpc4Y5HZ5b
         Ftc8FLypTYR9WWqQp7QmxJ/LdmW6CvHpaA5OoDEXB2fasPgWx9ABE5+WhdkVDHzRFqQQ
         Y5Jg==
X-Gm-Message-State: AJIora8ET+6hpwpnnGdy3nTYuD993mIkrfA7yrdmCZsBb08nLpZlfwDT
        Wo8kN3ab1P2wyMKASQdTXCwNXA==
X-Google-Smtp-Source: AGRyM1t4XwzbfHdrXzUb66ogKwmRbMD2im+YephNe2bZ85fDvw0CEazfFrh+x12rE1Kl9iAlqYEZ5w==
X-Received: by 2002:a05:6a00:26cf:b0:4f6:fc52:7b6a with SMTP id p15-20020a056a0026cf00b004f6fc527b6amr6529975pfw.39.1655412001211;
        Thu, 16 Jun 2022 13:40:01 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:4709:a407:1ca6:24ea])
        by smtp.gmail.com with ESMTPSA id jc15-20020a17090325cf00b00168dadc7354sm2064393plb.78.2022.06.16.13.40.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jun 2022 13:40:00 -0700 (PDT)
Date:   Thu, 16 Jun 2022 13:39:58 -0700
From:   Brian Norris <briannorris@chromium.org>
To:     Judy Hsiao <judyhsiao@chromium.org>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Chen-Yu Tsai <wenst@chromium.org>, alsa-devel@alsa-project.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] arm64: dts: rk3399: i2s: switch BCLK to GPIO
Message-ID: <YquVHsUoSbKfd2CS@google.com>
References: <20220616155836.3401420-1-judyhsiao@chromium.org>
 <20220616155836.3401420-3-judyhsiao@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220616155836.3401420-3-judyhsiao@chromium.org>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Jun 16, 2022 at 03:58:35PM +0000, Judy Hsiao wrote:
> We discoverd that the state of BCLK on, LRCLK off and SD_MODE on
> may cause the speaker melting issue. Removing LRCLK while BCLK
> is present can cause unexpected output behavior including a large
> DC output voltage as described in the Max98357a datasheet.
> 
> In order to:
>   1. prevent BCLK from turning on by other component.
>   2. keep BCLK and LRCLK being present at the same time
> 
> This patch adjusts the device tree to allow BCLK to switch
> to GPIO func before LRCLK output, and switch back during
> LRCLK is output.
> 
> Signed-off-by: Judy Hsiao <judyhsiao@chromium.org>


> --- a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
> @@ -1662,9 +1662,10 @@ i2s0: i2s@ff880000 {
>  		dma-names = "tx", "rx";
>  		clock-names = "i2s_clk", "i2s_hclk";
>  		clocks = <&cru SCLK_I2S0_8CH>, <&cru HCLK_I2S0_8CH>;
> -		pinctrl-names = "default";
> +		pinctrl-names = "bclk_on", "bclk_off";
>  		pinctrl-0 = <&i2s0_8ch_bus>;
>  		power-domains = <&power RK3399_PD_SDIOAUDIO>;
> +		pinctrl-1 = <&i2s0_8ch_bus_bclk_off>;

It seems like 'pinctrl-1' may make sense after pinctrl-0, not here.
Perhaps you're interacting with my RFC PATCH that removes this
'power-domains' property?

https://lore.kernel.org/linux-rockchip/20220613183556.RFC.1.I9ca71105e505f024d53b7e0ba4462230813ebb8d@changeid/

But that most likely isn't landing upstream as-is.

Otherwise, this patch looks good to me:

Reviewed-by: Brian Norris <briannorris@chromium.org>

>  		#sound-dai-cells = <0>;
>  		status = "disabled";
>  	};
