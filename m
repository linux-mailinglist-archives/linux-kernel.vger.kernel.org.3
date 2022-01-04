Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C521484A5B
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 23:05:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235115AbiADWFq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 17:05:46 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:57870 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229984AbiADWFq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 17:05:46 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B3C8CB817F9;
        Tue,  4 Jan 2022 22:05:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8872CC36AE0;
        Tue,  4 Jan 2022 22:05:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641333943;
        bh=JMMU67OHTGvWbvNl0vtv8aZm8KtVqmI+hKjOhFmLSpI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=fCh4gjtdViUXNVMUnPpLVB99H9WGyH42Q/Ewo1LK2w1FonkZCz/0L1TB8qua+/KRA
         4Sspu+kic+zNeY2gGnYscNHXlRcoW+aNkfwVR821XoQJ0NtdDhmzTS9v7GGjehKnpp
         7GPzWeF5SgzA36BlDjBarSOXx+6kdMxkq6vWf2BKbTXMYzGK2PEms5C9gBXjSbmT1L
         Md7WkexddEzs1wngO/oNuqU+SJiO0aQS3vliQxY+gpzr4250TCSQM9HNMPnCUa39/8
         6yN6hf8RlyTh4/sRk5umc/0/8qL3j2HF4MD/ds/bXShsK4/4grYX7c/h50GyRa18gc
         jTb9+AgjYCx+A==
Received: by mail-ed1-f48.google.com with SMTP id u25so32571712edf.1;
        Tue, 04 Jan 2022 14:05:43 -0800 (PST)
X-Gm-Message-State: AOAM532qUkEOB6RMfPZDUIfNhYT13u7YCa9RYCvFJ6QSrwNdVAc+1FgO
        p2cyeay5BfCdxB8lshQfdAEfmF5X/UhXashq0g==
X-Google-Smtp-Source: ABdhPJz1U69x7VqxrMBu0rR5rcZe2+4JsOQcQMCjTZQxvXUeqCCBgjGhvlFtmmDm+R8qo6fNEpiITkFu9IULXzsYbW0=
X-Received: by 2002:a17:906:7945:: with SMTP id l5mr40578823ejo.82.1641333941863;
 Tue, 04 Jan 2022 14:05:41 -0800 (PST)
MIME-Version: 1.0
References: <20211217113640.59840-1-tony@atomide.com> <YcIZNfTn37uNbj0F@robh.at.kernel.org>
 <YcLElm04V47kP0Z9@atomide.com>
In-Reply-To: <YcLElm04V47kP0Z9@atomide.com>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 4 Jan 2022 16:05:30 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLek5SOypZhTxpLK13x2HEYbLbYYotLGOfM-JTb=QE-Eg@mail.gmail.com>
Message-ID: <CAL_JsqLek5SOypZhTxpLK13x2HEYbLbYYotLGOfM-JTb=QE-Eg@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: clock: Add binding for TI clksel
To:     Tony Lindgren <tony@atomide.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        devicetree@vger.kernel.org,
        linux-omap <linux-omap@vger.kernel.org>,
        Tero Kristo <kristo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 22, 2021 at 12:24 AM Tony Lindgren <tony@atomide.com> wrote:
>
> Hi,
>
> * Rob Herring <robh@kernel.org> [211221 18:13]:
> > On Fri, Dec 17, 2021 at 01:36:40PM +0200, Tony Lindgren wrote:
> > > +additionalProperties: true
> >
> > Like what properties?
> >
> > true is only used for common, incomplete schemas referenced by device
> > schemas.
>
> There is a collection of the current component clock child nodes for each
> clksel instance. I got warnings with "additionalProperties: false", but
> maybe the child clock nodes need to be somehow specified in the binding?

If everything else is a child node, then you can do:

additionalProperties:
  type: object

>
> For example, below is a sample patch for am335x CLKSEL_GFX_FCLK using a
> clksel parent node with the child nodes moved to fix warnings for
> unique_unit_address. It also has clock-output-names property added to
> avoid the node naming warnings. For the other clksel instances, they can
> be a collection of dividers, multipliers, gates and muxes.
>
> Regards,
>
> Tony
>
> 8< --------
> diff --git a/arch/arm/boot/dts/am33xx-clocks.dtsi b/arch/arm/boot/dts/am33xx-clocks.dtsi
> --- a/arch/arm/boot/dts/am33xx-clocks.dtsi
> +++ b/arch/arm/boot/dts/am33xx-clocks.dtsi
> @@ -494,20 +494,27 @@ mmc_clk: mmc_clk {
>                 clock-div = <2>;
>         };
>
> -       gfx_fclk_clksel_ck: gfx_fclk_clksel_ck@52c {
> -               #clock-cells = <0>;
> -               compatible = "ti,mux-clock";
> -               clocks = <&dpll_core_m4_ck>, <&dpll_per_m2_ck>;
> -               ti,bit-shift = <1>;
> -               reg = <0x052c>;
> -       };
> +       clock@52c {
> +               compatible = "ti,clksel";
> +               reg = <0x52c>;
> +               #clock-cells = <1>;
> +               #address-cells = <0>;
> +
> +               gfx_fclk_clksel_ck: clock-gfx-fclk-clksel {
> +                       #clock-cells = <0>;
> +                       compatible = "ti,mux-clock";
> +                       clock-output-names = "gfx_fclk_clksel_ck";
> +                       clocks = <&dpll_core_m4_ck>, <&dpll_per_m2_ck>;
> +                       ti,bit-shift = <1>;
> +               };
>
> -       gfx_fck_div_ck: gfx_fck_div_ck@52c {
> -               #clock-cells = <0>;
> -               compatible = "ti,divider-clock";
> -               clocks = <&gfx_fclk_clksel_ck>;
> -               reg = <0x052c>;
> -               ti,max-div = <2>;
> +               gfx_fck_div_ck: clock-gfx-fck-div {
> +                       #clock-cells = <0>;
> +                       compatible = "ti,divider-clock";
> +                       clock-output-names = "gfx_fck_div_ck";
> +                       clocks = <&gfx_fclk_clksel_ck>;
> +                       ti,max-div = <2>;
> +               };
>         };
>
>         sysclkout_pre_ck: sysclkout_pre_ck@700 {
