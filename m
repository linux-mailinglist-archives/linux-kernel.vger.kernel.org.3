Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A94A496FCB
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jan 2022 06:12:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232448AbiAWFMV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jan 2022 00:12:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229776AbiAWFMT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jan 2022 00:12:19 -0500
Received: from mail-vk1-xa30.google.com (mail-vk1-xa30.google.com [IPv6:2607:f8b0:4864:20::a30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14AF0C06173B
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jan 2022 21:12:19 -0800 (PST)
Received: by mail-vk1-xa30.google.com with SMTP id l196so5185252vki.5
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jan 2022 21:12:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sV5/zsVQ9W5YHObVzBiwKq568WngDohUQy31mRglxWI=;
        b=Fy17yNS7qU0UurQUefh5Oj8BZDHtILqI9uLVnodEwN8kY8KKZdUpMvotIssRvj0a0O
         IogRyB4qXlQUP0iRGvT3nQSPcpW9FoXR3bMJovq5Y0vYljfjTnE1XRXaXDW79zx2TUXK
         7smviGpR9gHztmPWoNYBVateyTsK0qlm7n52g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sV5/zsVQ9W5YHObVzBiwKq568WngDohUQy31mRglxWI=;
        b=3iCc5Ti/ULqeXgyuhaOLm4/L6ek2VDIOr/yeia/dpH1RPMPVo/ifJF6LsZKEGCPqxD
         XUjft2BkOHwKfNQDhHB+FdMh8SbVnxqbVIgqANlXEcyYL5dn6cXzcjxf06VhzDNQYBh6
         u/41NaNGa4dj5eQD2fmTFyQTSX2ykQvPw7PsEu/gGK/tpctm0cYL5Ch6XxNEe1bYx0mC
         JXEawLHwrOvMewR7efHdae3F4LEzcztniEYWkqCoriI4LAonA6EeFUf3BYaliaXbxI8w
         mr3Od5M0KMvkSmRL0DdZKtOfGQduOGwgBdLRik3JJb/3ClxLa4ZYus1Nt+YqnNzOhNPu
         mPEQ==
X-Gm-Message-State: AOAM530SlqmnPq9x8DGkaVFdk1r5H+EGmD8f6I9NRTFMOKh5dUlKg+jn
        hr6dqXs+GLe1Ncf0GxC3vFJXd+2jEKnQdyupNe98Ew==
X-Google-Smtp-Source: ABdhPJxQbDhgagJOEoacTsnBOmnvqzQJBTerbM4mHQrW0myOKWXrAt9QHxugz6DwehjoM8NkiRaVPbUIUhndFUf/53A=
X-Received: by 2002:a05:6122:887:: with SMTP id 7mr4029514vkf.34.1642914738231;
 Sat, 22 Jan 2022 21:12:18 -0800 (PST)
MIME-Version: 1.0
References: <20220121193544.23231-1-romain.perier@gmail.com> <20220121193544.23231-9-romain.perier@gmail.com>
In-Reply-To: <20220121193544.23231-9-romain.perier@gmail.com>
From:   Daniel Palmer <daniel@0x0f.com>
Date:   Sun, 23 Jan 2022 14:12:07 +0900
Message-ID: <CAFr9PXki+_qsPiX90ZaLcJeQhdo-rfUDMTL2D5Zv8Pk=G0Lo+w@mail.gmail.com>
Subject: Re: [PATCH v3 8/9] ARM: mstar: Add OPP table for mercury5
To:     Romain Perier <romain.perier@gmail.com>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Rob Herring <robh+dt@kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Romain,

On Sat, 22 Jan 2022 at 04:35, Romain Perier <romain.perier@gmail.com> wrote:
>
> From: Daniel Palmer <daniel@0x0f.com>
>
> Add an OPP table for mercury5 so that cpu frequency scaling can
> happen.
>
> Signed-off-by: Daniel Palmer <daniel@0x0f.com>
> ---
>  arch/arm/boot/dts/mstar-mercury5.dtsi | 36 +++++++++++++++++++++++++++
>  1 file changed, 36 insertions(+)
>
> diff --git a/arch/arm/boot/dts/mstar-mercury5.dtsi b/arch/arm/boot/dts/mstar-mercury5.dtsi
> index a7d0dd9d6132..80a19bd23c9c 100644
> --- a/arch/arm/boot/dts/mstar-mercury5.dtsi
> +++ b/arch/arm/boot/dts/mstar-mercury5.dtsi
> @@ -6,6 +6,42 @@
>
>  #include "mstar-v7.dtsi"
>
> +/ {
> +       cpu0_opp_table: opp_table0 {
> +               compatible = "operating-points-v2";
> +               opp-shared;
> +
> +               opp-100000000 {
> +                       opp-hz = /bits/ 64 <100000000>;
> +                       opp-microvolt = <800000 800000 850000>;
> +                       clock-latency-ns = <300000>;
> +               };
> +
> +               opp-200000000 {
> +                       opp-hz = /bits/ 64 <200000000>;
> +                       opp-microvolt = <850000 850000 880000>;
> +                       clock-latency-ns = <300000>;
> +               };
> +
> +               opp-400000000 {
> +                       opp-hz = /bits/ 64 <400000000>;
> +                       opp-microvolt = <880000 880000 890000>;
> +                       clock-latency-ns = <300000>;
> +               };
> +               opp-600000000 {
> +                       opp-hz = /bits/ 64 <600000000>;
> +                       opp-microvolt = <900000 900000 1000000>;
> +                       clock-latency-ns = <300000>;
> +               };
> +
> +               opp-800000000 {
> +                       opp-hz = /bits/ 64 <800000000>;
> +                       opp-microvolt = <900000 900000 1000000>;
> +                       clock-latency-ns = <300000>;
> +               };
> +       };
> +};
> +
>  &imi {
>         reg = <0xa0000000 0x20000>;
>  };
> --
> 2.34.1
>

I think we should drop this one when applying as the frequencies need
to be checked on the hardware again.
I think they should probably match the msc313e settings that Willy verified.

Cheers,

Daniel
