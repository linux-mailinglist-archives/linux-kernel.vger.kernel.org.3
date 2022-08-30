Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 822565A6DD5
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 21:51:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231721AbiH3Tvp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 15:51:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231669AbiH3Tvl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 15:51:41 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E27717E802
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 12:51:39 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id b16so15632042edd.4
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 12:51:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=y2BsAU9V1vGdt8p536WRg36dWX8Oh3MzpJrUWzUelg0=;
        b=PKO9Ih5HCXvgFcNbUeRyybhQkiOyrhvI0hcbzTdHIAMDpYBWL9GHOUDjjY9UdWnRNU
         Z5Ojdi4hHX6CCebuGU0G1jKXT+BjL/h/yF6zBNhY0o6zuOgUIOcw5bMFsvIG9jbbgq4F
         5Iq5WrNcC4ROpyxhCYHMZPO3M5Fhv7/kemXOs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=y2BsAU9V1vGdt8p536WRg36dWX8Oh3MzpJrUWzUelg0=;
        b=ZmmrJrVwU1fx9If895CcMTotkbldeDsPWlwrZv+4jAnok8BgHJ55uUW/YJ+dEYauj+
         HqjpaFm9EmbXMxzvHMCR1LW/V27WHvtsODwJGSeHpK+qflsiX1GeIQQlhBXVsIcUSrCC
         ge7M5+bAFdTf2wPLixMAb479cwwrGfMYMW1PMFlDhDUbn8X7vr9uLnGh/d1CqbStVrTX
         ccButR32xr2zyI+jY5sB0hmEU6c2ZAkGpOfGnWAE1zz2scK1xAQEEKm6q1YHGrMZrLik
         67Uhoyh6A2Az6/qDbZ7NGFmISHyo7+aWiParVHl1vrkuiWTAtfUaBVmsuKVNGIwJB2pK
         x9XA==
X-Gm-Message-State: ACgBeo0WqP25lHwB5Vhl87GDqRjuPi/XW0W8vnNsZNimUAgKcJ3L95pG
        tVJsuVsrIwZPZVaGf5MCMkJtOJyzv3MK3YEt
X-Google-Smtp-Source: AA6agR4asCOAZE2cGK0r1RwiOE7nTalPz2cAPiGSj+p7ugPWV1MWaXrbOcUK89ZvZn6m276TagxehQ==
X-Received: by 2002:a05:6402:5c9:b0:446:fb0:56bb with SMTP id n9-20020a05640205c900b004460fb056bbmr22186950edx.173.1661889098322;
        Tue, 30 Aug 2022 12:51:38 -0700 (PDT)
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com. [209.85.221.43])
        by smtp.gmail.com with ESMTPSA id y8-20020a056402170800b0043c0fbdcd8esm7814015edu.70.2022.08.30.12.51.36
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Aug 2022 12:51:37 -0700 (PDT)
Received: by mail-wr1-f43.google.com with SMTP id m16so15569907wru.9
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 12:51:36 -0700 (PDT)
X-Received: by 2002:a5d:6881:0:b0:225:28cb:332f with SMTP id
 h1-20020a5d6881000000b0022528cb332fmr9826377wru.405.1661889096492; Tue, 30
 Aug 2022 12:51:36 -0700 (PDT)
MIME-Version: 1.0
References: <20220830123231.1.I98d30623f13b785ca77094d0c0fd4339550553b6@changeid>
In-Reply-To: <20220830123231.1.I98d30623f13b785ca77094d0c0fd4339550553b6@changeid>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 30 Aug 2022 12:51:22 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XO++XMrdZmupY8ED97W6AaU=H=sB2PN=6EpRxOOo4Afw@mail.gmail.com>
Message-ID: <CAD=FV=XO++XMrdZmupY8ED97W6AaU=H=sB2PN=6EpRxOOo4Afw@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: rockchip: Set RK3399-Gru PCLK_EDP to 24 MHz
To:     Brian Norris <briannorris@chromium.org>
Cc:     Heiko Stuebner <heiko@sntech.de>, zain wang <wzz@rock-chips.com>,
        Lin Huang <hl@rock-chips.com>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Aug 30, 2022 at 12:32 PM Brian Norris <briannorris@chromium.org> wrote:
>
> We've found the AUX channel to be less reliable with PCLK_EDP at a
> higher rate (typically 25 MHz). This is especially important on systems
> with PSR-enabled panels (like Gru-Kevin), since we make heavy, constant
> use of AUX.
>
> According to Rockchip, using any rate other than 24 MHz can cause
> "problems between syncing the PHY an PCLK", which leads to all sorts of
> unreliabilities around register operations.
>
> Signed-off-by: zain wang <wzz@rock-chips.com>
> Signed-off-by: Brian Norris <briannorris@chromium.org>

nit: Sinze zain wang's SoB is first then I think either the patch
needs to be "From" zain wang or you need some different tagging, like
Co-Developed-by or something.

> ---
>
>  arch/arm64/boot/dts/rockchip/rk3399-gru-chromebook.dtsi | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/rockchip/rk3399-gru-chromebook.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-gru-chromebook.dtsi
> index 45796b9fd94f..ee6095baba4d 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3399-gru-chromebook.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3399-gru-chromebook.dtsi
> @@ -244,6 +244,14 @@ &dmc {
>  &edp {
>         status = "okay";
>
> +       /*
> +        * eDP PHY/clk don't sync reliably at anything other than 24 MHz. Only
> +        * set this here, because rk3399-gru.dtsi ensures we can generate this
> +        * off GPLL=600MHz, whereas some other RK3399 boards may not.
> +        */
> +       assigned-clocks = <&cru PCLK_EDP>;
> +       assigned-clock-rates = <24000000>;
> +

Yeah, this looks right to me. From my memory of the problem:

* For some reason, some devices hit it more than others (maybe just
process variance?)

* The problem affected nearly any register read or write on the eDP
controller and wasn't rk3399 specific (other Rockchip models were
impacted) but the failure rate was crazy low so it wasn't discovered
until rk3399 came about and we implemented PSR and the number of
register reads/writes to the eDP controller went through the roof.

* Most other devices use GPLL at 594 so that they can use it to make
certain standard HDMI rates. Changing other devices so GPLL = 600
wouldn't be trivial.

* It's fairly hard to change GPLL to 600 without coordinating with the
bootloader. Certainly it could be possible, but you'd have to make
sure that no important devices were impacted at boot when doing the
change. gru devices bootloaders are the only known ones to set GPLL to
600 MHz.


So:

Reviewed-by: Douglas Anderson <dianders@chromium.org>
