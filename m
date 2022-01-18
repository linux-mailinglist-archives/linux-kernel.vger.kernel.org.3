Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F37874923CD
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 11:33:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237530AbiARKdU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 05:33:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237475AbiARKdM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 05:33:12 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D03C2C06173F
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jan 2022 02:33:11 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id bu18so45696944lfb.5
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jan 2022 02:33:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ragnatech-se.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=nPt9N64IaDnBh7bjJWIKwHKKVjvabFOfHbFr+GEBwYs=;
        b=TfPJquluQSbMwDcvHHqtZcvbQjYmPCvkq8cadU/kDGgsd5GrhblkHtkczwVoPL94GU
         bO2xZw8LnjqPLON52DLB9Rve7Nfa3A0EF7Hfji/oAKdIhoZ4gN0VR3qUM4m/LvR7Q2+e
         hr9Fre2K0UWmumptpXzQiZ9Ta12CdyfcC4eEcGAFbUew4YXEl+SfFZSWnBRI0KgFx3Ed
         jGh1A0k4JI1OnNU7QgiSzQZa6tf94EULghl6+Ex0N1S2P5re60q18bZJwPU+0IQ4PF4g
         j+EEDg27OPIaKLEIA76dAfTJ2r9nnowLtuGwsippyz+jl0+0ZEaeS9OYIPMTG7AESjIX
         uyKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=nPt9N64IaDnBh7bjJWIKwHKKVjvabFOfHbFr+GEBwYs=;
        b=p3CgQNko5PkVM2vN9coNcTpCh89zyFOAqlBsL+lzVBykqYjM5tXJAX1kip/esYRz29
         h+rJHIBGIvUW0lLI347LLn9TXyWmIQ8AqJor1u1vAMgoiN0cAGJQnQk3KtKHlaKQD7Qh
         AT/QNcXlaKE7bVyp3U4Jq7zDJw+F6PjcrUtI8QaLYAYJBEIqRcA6dQQed94XgbozJbAN
         N72diC5fhQMppCI0GjHi+xwOm65IhM91ndgld/s3U/sd6NqbfCuRV0DgDB8hHYEGDKGx
         8VQhMoCHcN9HNvhNJyHFYJMkwE68jMX9nJMUObKecq8B0XC0DJXH6V8hGHBvDtMVvILX
         FJfg==
X-Gm-Message-State: AOAM532n0A5EOXo2tZp88dPwpn2uiDDprb3Y9Lqf7J878i+rgOtW9Hv8
        aiCUXbdOGBpiS1N5kUpvhOYPrQ==
X-Google-Smtp-Source: ABdhPJwA7A7zpmc4ThmmWmtw+pSJmj5zJ+ScssktIWiZz+OY41oO0kfTZpaHCvwLwJKw2olK/g/yzw==
X-Received: by 2002:a2e:531c:: with SMTP id h28mr19125625ljb.400.1642501990022;
        Tue, 18 Jan 2022 02:33:10 -0800 (PST)
Received: from localhost (h-85-24-188-65.A463.priv.bahnhof.se. [85.24.188.65])
        by smtp.gmail.com with ESMTPSA id h11sm1645652lfv.281.2022.01.18.02.33.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jan 2022 02:33:09 -0800 (PST)
Date:   Tue, 18 Jan 2022 11:33:08 +0100
From:   Niklas =?iso-8859-1?Q?S=F6derlund?= 
        <niklas.soderlund@ragnatech.se>
To:     Jacopo Mondi <jacopo@jmondi.org>
Cc:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        linux-media@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] media: dt-bindings: media: renesas,csi2: Update
 data-lanes property
Message-ID: <YeaXZO+3C/fUM7ex@oden.dyn.berto.se>
References: <20220113103215.27080-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220117081110.bkwr3ttoexgr2wjt@uno.localdomain>
 <YeU1kDee7L26QJ86@oden.dyn.berto.se>
 <20220117100040.wa3ple6meahebtni@uno.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220117100040.wa3ple6meahebtni@uno.localdomain>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jacopo,

Thanks for your feedback.

On 2022-01-17 11:00:40 +0100, Jacopo Mondi wrote:
> Hi Niklas,
> 
> On Mon, Jan 17, 2022 at 10:23:28AM +0100, Niklas Söderlund wrote:
> > Hello Jacopo,
> >
> > On 2022-01-17 09:11:10 +0100, Jacopo Mondi wrote:
> > > Hello Prabhakar,
> > >
> > > On Thu, Jan 13, 2022 at 10:32:14AM +0000, Lad Prabhakar wrote:
> > > > CSI-2 (CSI4LNK0) on R-Car and RZ/G2 supports 4-lane mode which is already
> > > > handled by rcar-csi2.c driver. This patch updates the data-lanes property
> > > > to describe the same.
> > > >
> > > > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > > > ---
> > > >  .../devicetree/bindings/media/renesas,csi2.yaml          | 9 ++++++++-
> > > >  1 file changed, 8 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/Documentation/devicetree/bindings/media/renesas,csi2.yaml b/Documentation/devicetree/bindings/media/renesas,csi2.yaml
> > > > index e6a036721082..064a0a4c5737 100644
> > > > --- a/Documentation/devicetree/bindings/media/renesas,csi2.yaml
> > > > +++ b/Documentation/devicetree/bindings/media/renesas,csi2.yaml
> > > > @@ -67,7 +67,14 @@ properties:
> > > >                  maxItems: 1
> > > >
> > > >                data-lanes:
> > > > -                maxItems: 1
> > > > +                items:
> > > > +                  minItems: 1
> > > > +                  maxItems: 4
> > > > +                  items:
> > > > +                    - const: 1
> > > > +                    - const: 2
> > > > +                    - const: 3
> > > > +                    - const: 4
> > >
> > > Seeing "maxItems: 1" there confuses me too, as the property is an
> > > array of data-lanes, but I'm afraid your change does not what you
> > > intend as it would allow you to specify the number of data lanes as an
> > > integer rather than as an array.
> > >
> > > I think it would probably be correct to set
> > >
> > >                 data-lanes: true
> > >
> > > (maybe maxItems: 1 is correct already)
> > >
> > > And restrict the number of valid combinations in the board DTS file
> > > with a construct like:
> > >
> > >     data-lanes:
> > >       oneOf:
> > >         - items:
> > >             - const: 1
> > >             - const: 2
> > >             - const: 3
> > >             - const: 4
> > >         - items:
> > >             - const: 1
> > >             - const: 2
> >
> > I don't think this is correct, what if data lanes 2 and 3 are used?
> >
> 
> These were examples that allow you to accept <1 2> and <1 2 3 4> as
> valid properties. If other combinations are accepted they can be
> specified there, in your example, <2 3> with
> 
>              - items:
>                - const: 2
>                - const: 3
> 
> As lane re-reordering is quite unusual as a feature (afaik) there are
> usually just an handful of supported combinations for 1, 2 and 4 data
> lanes setups.

R-Car CSI-2 hardware and driver supports full lane swapping, see the 
LSWAP register and usage of struct rcar_csi2.lane_swap.

I think it's a good idea to extend the binding description to limit the 
data-lanes property to an array of max 4 items where each value use is 
ether a 1, 2, 3 or 4. But it must allow for any combination of the 
values.

> 
> If full lane re-ordering is supported then it's enough to set
> data-lanes: true and accepts all combinations.
> 
> Also, the reason why imho the property should go in the board DTS and
> not in the SoC .dtsi is that not all the available data lanes of the
> IP-core might be routed out on a specific board.
> 
> That's at least my understanding which I would be glad to be disproved
> as specifying the valid combinations in each board dts is rather
> un-convenient.
> 
> Thanks
>    j
> 
> > >
> > > Thanks
> > >    j
> > >
> > > >
> > > >              required:
> > > >                - clock-lanes
> > > > --
> > > > 2.17.1
> > > >
> >
> > --
> > Kind Regards,
> > Niklas Söderlund

-- 
Kind Regards,
Niklas Söderlund
