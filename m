Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B818D4C58B8
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Feb 2022 00:49:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229513AbiBZXtg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Feb 2022 18:49:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiBZXtf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Feb 2022 18:49:35 -0500
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 346AC24BF2;
        Sat, 26 Feb 2022 15:49:00 -0800 (PST)
Received: by mail-yb1-xb2c.google.com with SMTP id bt13so13209523ybb.2;
        Sat, 26 Feb 2022 15:49:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ket/CFuLQVcpMPfanob90ElrwMFDUMsunTV9FoIi2O4=;
        b=cRrFFaYZUVtz+mUobnnDnYKkn/NpQM6EexIH/jgWbpk4vB8zQYf1aq8qUftkwG1wig
         jMq88JM8lXUtYn3tVkCfRjEc24ZGlPJ3laekldZTVR4+3LQisE6X/KrjPWnHDPFc9XJv
         z2+6OvGXlslLs827YZqevyVwRhh6K8PECi0L34+FOjmJYteMswqZmaPhqhVuR+dzPsRo
         JOqlv5Yh5o2cUMk8HQPPoJO/z4Tx7fTakcfVw5hwxbGKfgtsAw1y35VfM9wSlusByZrc
         5U8ojemyDjfY1rP4y8sd061f6JlZlokdzJqjY920LSJPeMXbn58Bao7n4tMQa4keRoJP
         x0DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ket/CFuLQVcpMPfanob90ElrwMFDUMsunTV9FoIi2O4=;
        b=wyf6OhiYB9QTfzHtCebBT06HFnCVUGDNnXNYbH9PZqXcYhfmH3CLInlRvxLDYbM/g3
         FOJb1sWsp8kDi+2cYlZTgiXU9bmoKAE9SNtiKDuF9DgSgIAQJzeNOsAKVIvn5hITKXdl
         O0ZAGnSy7zz9iObD4Gy8wVPczoUq+X3L1oqqbgzQC4tceJIwdCR9tNXwaJwBGpMhoQJx
         kYnY5w0OXaEVx/cUKn96d7Rd+UhFFX+lAdooeGumhJ65iGDUk+hcDsHtRkYcQf0K56ew
         cPxciOTC14n4+4yHtykA+VctoJlWiBwPVuxc4/Vdrvqlib+N7NayOAaH3IRSEpwVhCrU
         kDXQ==
X-Gm-Message-State: AOAM531GQfBIxss3ZX4pj2iTnJhe2uG2loy0KVhOm8HHmuydu8qnoz9m
        svXetQqlhVtXrYib/cC7bCZ4zjoGMuZW6rCHP58=
X-Google-Smtp-Source: ABdhPJyITcdVPfs1ScLHMux4f+qpKZkjMDONysLqcDqaxcdj8zCdlMT/vGIqB0grmaak1Hb3xP8/pu//ic37ONIgoJ0=
X-Received: by 2002:a25:c752:0:b0:624:71ee:65d7 with SMTP id
 w79-20020a25c752000000b0062471ee65d7mr13371085ybe.366.1645919339347; Sat, 26
 Feb 2022 15:48:59 -0800 (PST)
MIME-Version: 1.0
References: <20220226184147.769964-1-pgwipeout@gmail.com> <20220226184147.769964-9-pgwipeout@gmail.com>
 <cdbf28ae-b54f-dfaf-887b-c5705319ac06@gmail.com>
In-Reply-To: <cdbf28ae-b54f-dfaf-887b-c5705319ac06@gmail.com>
From:   Peter Geis <pgwipeout@gmail.com>
Date:   Sat, 26 Feb 2022 18:48:47 -0500
Message-ID: <CAMdYzYpRhZerT3tnAQ4XdTpGQk9MbfL3CBZT9+FvvytOQ=Ytyg@mail.gmail.com>
Subject: Re: [PATCH v2 08/11] usb: dwc3: add rk3568 dwc3 support
To:     Johan Jonker <jbx6244@gmail.com>
Cc:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        linux-usb@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FROM_FMBLA_NEWDOM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 26, 2022 at 4:43 PM Johan Jonker <jbx6244@gmail.com> wrote:
>
> Hi Peter,
>
> See comments by rob+dt:
>
> https://lore.kernel.org/linux-rockchip/CAL_JsqJwNdUfoYM8SZmOgMG9iAyZkJ4-kzjjiDDm_mdmghTEOA@mail.gmail.com/
>
> > Presumably you are getting lucky here (with link order). The kernel
> > has no logic to decide which driver to bind to if there are 2 matching
> > drivers.
>
> Due to the fall back string you make a mess with two drivers.
> Don't use dwc3-of-simple.c
> (only for rk3399 and legacy support. Not for new SoCs),
> because core.c has now reset support.
> You are creating a race which driver get probed first.
> Handle your quirks in core.

I finally understood what you were trying to get at here.
After some testing, it seems the core driver handles everything we need now.
This makes me want to revisit the rk3399 support.

Thanks!

>
> Johan
>
> On 2/26/22 19:41, Peter Geis wrote:
> > The rk3568 dwc3 controller is backwards compatible with the rk3399 dwc3
> > controller.
> > Add support for it to the dwc3-of-simple driver.
> >
> > Signed-off-by: Peter Geis <pgwipeout@gmail.com>
> > ---
> >  drivers/usb/dwc3/dwc3-of-simple.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/drivers/usb/dwc3/dwc3-of-simple.c b/drivers/usb/dwc3/dwc3-of-simple.c
> > index 57ba9427ad74..d9d1c5bfac3f 100644
> > --- a/drivers/usb/dwc3/dwc3-of-simple.c
> > +++ b/drivers/usb/dwc3/dwc3-of-simple.c
> > @@ -195,6 +195,10 @@ static const struct of_device_id of_dwc3_simple_match[] = {
> >               .compatible = "rockchip,rk3399-dwc3",
> >               .data = &dwc3_of_simple_data_rk3399,
> >       },
> > +     {
> > +             .compatible = "rockchip,rk3568-dwc3",
> > +             .data = &dwc3_of_simple_data_rk3399,
> > +     },
> >       {
> >               .compatible = "sprd,sc9860-dwc3",
> >       },
