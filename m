Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 735F24CC3B1
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 18:26:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231726AbiCCR1Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 12:27:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235335AbiCCR1J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 12:27:09 -0500
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com [IPv6:2607:f8b0:4864:20::c2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACF8019E083
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 09:26:22 -0800 (PST)
Received: by mail-oo1-xc2d.google.com with SMTP id 189-20020a4a03c6000000b003179d7b30d8so6561230ooi.2
        for <linux-kernel@vger.kernel.org>; Thu, 03 Mar 2022 09:26:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Hi+eKfkvL+1ELz8vCd2J8tALPiN2Yeq81v7WF2HdAvA=;
        b=ST/Z+X1lhcPRR3gkR9suvwoVxqwduRsMYavBHcuzH6MEWvRTvI8XehW5GVLJKxx+FC
         NE7DS70gcRfuBP+bWOto18cMXOIZPLk609iw8smuy/WxCEcWYm/+G+iCdIlMCCWpSINZ
         +DfLXoHb7999QY5ssTrZRl7n0KNUX8O58zRTFoWlx3ttRtJXmbbewgi9suaOM+NiV36v
         NmeOZAmFGzTuS00K7V5if14XLORNd3xksz9NN+wJMfw08Eh1bK23PFyL0ckhuwl0BCpJ
         0VrqKXWYsDnU5ViWauFzYYUT0AyGj/KfqWwXDxN3Hn0HNlf+Zxf4qRSEUTD/zgtZ55wd
         vatw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Hi+eKfkvL+1ELz8vCd2J8tALPiN2Yeq81v7WF2HdAvA=;
        b=muz3nYPk1UmPMoMuJMNw2LbKaF7W3nfkr/+mBGNcth30TL/t7+i0Vco+uYaJvxgPT5
         tJvIEYAvbBszYgQbfZDulgsafAXPgoSaCGx79aQnOY90TSzpS2kqtATg/ReR225B5JHa
         QCAAaw0dz2ZQMyJa+tlTSSuJBV9m+KRQCl1IW/Yeo0mubw7krMuaYfPbx3OXjNM+YyrU
         fp5hyXw/E2gniUhjDu8ZqslsSnBrW3clyXlgzcmMpoKDyp6FbkJB9M6aL5394Vbh2CM/
         0bXj1V2PugH+LQfV2Br9SncuZ0bdRItA2cDq/gT5s34GE4v36T8u24paf5FgEzJRgAkr
         KI2w==
X-Gm-Message-State: AOAM532Mfit9pDPWkfB/oRTfd0G34zkqGXuJqXLYCcUlEvpGays+fydf
        2+UMaUGt/4BbxfaiHSgC+68qOg==
X-Google-Smtp-Source: ABdhPJwv1sxGTZF0niRgbP0qtUDDm24paYlb1odjA9ejm9/YPSBr9Tb4EAnKGNswbr1L/KDB331RZA==
X-Received: by 2002:a05:6870:a1a0:b0:d9:b198:4cfa with SMTP id a32-20020a056870a1a000b000d9b1984cfamr3722424oaf.159.1646328381877;
        Thu, 03 Mar 2022 09:26:21 -0800 (PST)
Received: from ripper ([2600:1700:a0:3dc8:205:1bff:fec0:b9b3])
        by smtp.gmail.com with ESMTPSA id c26-20020a4ae25a000000b0031c268c5436sm1195619oot.16.2022.03.03.09.26.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Mar 2022 09:26:21 -0800 (PST)
Date:   Thu, 3 Mar 2022 09:28:10 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Doug Anderson <dianders@chromium.org>
Cc:     Pavel Machek <pavel@ucw.cz>,
        Thierry Reding <thierry.reding@gmail.com>,
        Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>,
        Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-leds@vger.kernel.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        linux-pwm <linux-pwm@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Luca Weiss <luca@z3ntu.xyz>
Subject: Re: [PATCH v13 2/2] leds: Add driver for Qualcomm LPG
Message-ID: <YiD6qrLC9B4A8sNz@ripper>
References: <20220218183116.2261770-1-bjorn.andersson@linaro.org>
 <20220218183116.2261770-2-bjorn.andersson@linaro.org>
 <CAD=FV=UOLcu5xycimDsYTO1spwf=CMRPUSU3o0qRRC+a+zuRTQ@mail.gmail.com>
 <CAD=FV=We4Lv25h2XF6BsdYhMbYu4716LBuhAjH5N0s_HHt_Xcw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAD=FV=We4Lv25h2XF6BsdYhMbYu4716LBuhAjH5N0s_HHt_Xcw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 03 Mar 08:41 PST 2022, Doug Anderson wrote:

> Hi,
> 
> On Wed, Mar 2, 2022 at 4:03 PM Doug Anderson <dianders@chromium.org> wrote:
> >
> > Hi,
> >
> > On Fri, Feb 18, 2022 at 10:29 AM Bjorn Andersson
> > <bjorn.andersson@linaro.org> wrote:
> > >
> > > +static void lpg_pwm_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
> > > +                             struct pwm_state *state)
> > > +{
> > > +       struct lpg *lpg = container_of(chip, struct lpg, pwm);
> > > +       struct lpg_channel *chan = &lpg->channels[pwm->hwpwm];
> > > +       unsigned int pre_div;
> > > +       unsigned int refclk;
> > > +       unsigned int val;
> > > +       unsigned int m;
> > > +       u16 pwm_value;
> > > +       int ret;
> > > +
> > > +       ret = regmap_read(lpg->map, chan->base + LPG_SIZE_CLK_REG, &val);
> > > +       if (ret)
> > > +               return;
> > > +
> > > +       refclk = lpg_clk_rates[(val & PWM_CLK_SELECT_MASK) - 1];
> >
> > I don't know why I didn't notice it before (maybe I was accidentally
> > not building with KASAN?), but in my recent boots I'm getting a KASAN
> > error pointing at the line above.
> >
> > Sure enough, the above looks a bit on the unsafe side. If (val & 0x3)
> > is 0 then the "-1" will not be so wonderful. I put some printouts and,
> > indeed, it's not so great.
> >
> > [    7.201635] DOUG: val is 0x00000004
> >
> > Amazingly my `refclk` ends up as 0 and I guess somehow this doesn't
> > cause a divide by 0.
> 
> I dug a little more and found a document that talks about this
> register. I guess the answer here is that at boot time on my device
> the PWM is disabled and has never been enabled. That explains why, at
> boot time, the "clk_select" is 0 AKA "no clock". So we do an invalid
> memory access here and that's not so great, but it doesn't _truly_
> cause any harm. All we need is something like this right before the
> array dereference:
> 
> if ((val & PWM_CLK_SELECT_MASK) == 0)
>   return;
> 

Thanks for spotting and digging that up. I can confirm that the
documentation has 0 as "no clock" and I think it would be nice if
lpg_clk_rates[] reflected the possible hardware values. That way we can
also get rid of the + 1 in lpg_apply_freq().

I will fix this up, as well as fix up the indentation issue spotted by
Uwe in the documentation and repost.

Regards,
Bjorn

> I'm still pretty interested in seeing this patch series land and, if
> it helps it land sooner, I wouldn't object to the above getting fixed
> in a followup patch.
> 
> -Doug
