Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15EA149BB63
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 19:37:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232806AbiAYSgr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 13:36:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232796AbiAYSgo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 13:36:44 -0500
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2743C06173E
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 10:36:43 -0800 (PST)
Received: by mail-oi1-x235.google.com with SMTP id q186so32765383oih.8
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 10:36:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=SxZoYrbO6Ef17p8OqD68kIBpBg+bCtqCFo+bkhGmNNQ=;
        b=fzL68KEeCP4UgED294GYG/eyK5b0BragCU+4mlnREQa76YxYhFwi9qr7EjQHzMhvZp
         mdfnIHWi1WRlef3q5We7mwP3UsN6HM9OEjTspU1GV7eKU+WVM6E0nsFJvyznk9n1J4XC
         mIj9htFQHaLx2r7j5niLmFyMK0gDCTofGYLswSzICA+yc0TQ74Mb4DdbsrGfxJsgZge6
         21uIanhxi36yBKSBwfDc7tDqKS3DBw4LvI6AWqP/IfK6fAe93fGaR4oiut7F874S5bLe
         zt52JSm86bP06oUlQUxCyMkxaDMe/PJtRNqW3Yl/uK31UJ/cMuzgMc8eJ/gmQJDQ3xUk
         UA9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=SxZoYrbO6Ef17p8OqD68kIBpBg+bCtqCFo+bkhGmNNQ=;
        b=S6+6L/MxE0caSGQUWaqlyL3dFi5ouWy+2M2gE12kZGDsVg/LWO8zv9PSowr4nL7WFC
         LtxBDMudXCASXBjg/NeYO5WJ2tMlQNS+CZqwUymPWyEZ1bTYJ9TBHYCYtBTXF51G4dJA
         f+Gjj+Hjr7lwDRla60c+I44HJW5i/vdvCvCi0k1sG1u0VOaFdui3cfZGjtPM+t5lokcn
         gijIky4LOX8qT3ae5XjmAVV4EIkTidCYBWTRnAN21MwKO+LEQrN7PftPcfhEC4DsGrdM
         Zcl+Yb+b4n5EN0SAJs+fYFukTMsl3lsQWS1SAsqeG5UZTbrOB19AIkUWf4nYzuqOxI8F
         Quyw==
X-Gm-Message-State: AOAM532qr1tcRHnlhOLsDrJbJ3fK6UbYNEOTD3L3GTCYFh7yquMdnV+Z
        AeY8xj7ppQ7xVXak6eQqLDc7gg==
X-Google-Smtp-Source: ABdhPJyX1CpJBMK7MpYrdOLjRh+epx5+C9H+o/upp01WwUGlJrqQbQXGfcELn1ur8rYKZslPgbCAnw==
X-Received: by 2002:a05:6808:1184:: with SMTP id j4mr1555706oil.200.1643135802430;
        Tue, 25 Jan 2022 10:36:42 -0800 (PST)
Received: from ripper ([2600:1700:a0:3dc8:205:1bff:fec0:b9b3])
        by smtp.gmail.com with ESMTPSA id 71sm1381668otn.43.2022.01.25.10.36.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jan 2022 10:36:41 -0800 (PST)
Date:   Tue, 25 Jan 2022 10:37:09 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Anjelique Melendez <quic_amelende@quicinc.com>,
        dmitry.torokhov@gmail.com, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        collinsd@codeaurora.org, skakit@codeaurora.org
Subject: Re: [PATCH 3/3] input: misc: pm8941-pwrkey: avoid potential null
 pointer dereference
Message-ID: <YfBDVQeEsLv6Yj9g@ripper>
References: <20220120204132.17875-1-quic_amelende@quicinc.com>
 <20220120204132.17875-4-quic_amelende@quicinc.com>
 <YenpwnE3WrIEAOlm@ripper>
 <e2015c19-b73b-39a7-ba73-708b2c4552c7@quicinc.com>
 <CAE-0n50+1OU2yt2gihHHCEn-cE-CZuqa_U9W=xWCuYeCQdzExw@mail.gmail.com>
 <Ye8nmnQ3F4QcTIJs@ripper>
 <CAE-0n51bYEkvxu8z2gc_KUv0u+J2Esg0_3AiQRLyTaouNoa78g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAE-0n51bYEkvxu8z2gc_KUv0u+J2Esg0_3AiQRLyTaouNoa78g@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 24 Jan 17:55 PST 2022, Stephen Boyd wrote:

> Quoting Bjorn Andersson (2022-01-24 14:26:34)
> > On Thu 20 Jan 20:18 PST 2022, Stephen Boyd wrote:
> >
> > > Quoting Anjelique Melendez (2022-01-20 16:25:26)
> > > >
> > > > On 1/20/2022 3:01 PM, Bjorn Andersson wrote:
> > > > > On Thu 20 Jan 12:41 PST 2022, Anjelique Melendez wrote:
> > > > >
> > > > >> From: David Collins <collinsd@codeaurora.org>
> > > > >>
> > > > >> Add a null check for the pwrkey->data pointer after it is assigned
> > > > >> in pm8941_pwrkey_probe().  This avoids a potential null pointer
> > > > >> dereference when pwrkey->data->has_pon_pbs is accessed later in
> > > > >> the probe function.
> > > > >>
> > > > >> Change-Id: I589c4851e544d79a1863fd110b32a0b45ac03caf
> > > > >> Signed-off-by: David Collins <collinsd@codeaurora.org>
> > > > >> Signed-off-by: Anjelique Melendez <quic_amelende@quicinc.com>
> > > > >> ---
> > > > >>  drivers/input/misc/pm8941-pwrkey.c | 4 ++++
> > > > >>  1 file changed, 4 insertions(+)
> > > > >>
> > > > >> diff --git a/drivers/input/misc/pm8941-pwrkey.c b/drivers/input/misc/pm8941-pwrkey.c
> > > > >> index 0ce00736e695..ac08ed025802 100644
> > > > >> --- a/drivers/input/misc/pm8941-pwrkey.c
> > > > >> +++ b/drivers/input/misc/pm8941-pwrkey.c
> > > > >> @@ -263,6 +263,10 @@ static int pm8941_pwrkey_probe(struct platform_device *pdev)
> > > > >>
> > > > >>      pwrkey->dev = &pdev->dev;
> > > > >>      pwrkey->data = of_device_get_match_data(&pdev->dev);
> > > > >> +    if (!pwrkey->data) {
> > > > > The only way this can happen is if you add a new compatible and forget
> > > > > to specify data and when that happens you will get a print in the log
> > > > > somewhere, which once you realize that you don't have your pwrkey you
> > > > > might be able to find among all the other prints.
> > > > >
> > > > > If you instead don't NULL check this pointer you will get a large splat
> > > > > in the log, with callstack and all, immediately hinting you that
> > > > > pwrkey->data is NULL.
> > > > >
> > > > >
> > > > > In other words, there's already a print, a much larger print and I don't
> > > > > think there's value in handling this mistake gracefully.
> > > > >
> > > > > Regards,
> > > > > Bjorn
> > > >
> > > >
> > > > We would like to the null pointer check in place to avoid static analysis
> > > >
> > > > warnings that can be easily fixed.
> > > >
> > >
> > > Many drivers check that their device_get_match_data() returns a valid
> > > pointer. I'd like to see that API used in addition to checking the
> > > return value for NULL so that we can keep the static analysis tools
> > > happy. Yes it's an impossible case assuming the driver writer didn't
> > > mess up but it shuts SA up and we don't really have a better solution
> > > to tell tools that device_get_match_data() can't return NULL.
> >
> > I'm not saying that device_get_match_data() can't return NULL,
> 
> Indeed, I wasn't implying that you were saying that.
> 
> > I'm
> > saying that in the very specific cases that it would return NULL it's
> > useful to have a kernel panic - as that's a much faster way to figure
> > out that something is wrong.
> 
> I see it as more annoying, but maybe that's my workflow? When my kernel
> oopses I have to go back to a recovery kernel, which takes me a few more
> seconds to "repair" my device. If the driver only failed to probe then
> I'd probably be able to boot far enough to get networking and more
> easily replace my kernel with a working device. And I'd have userspace
> access so I could poke around and figure out why the driver failed to
> probe. Now obviously a big stacktrace would be helpful to know that it's
> the power key driver that's busted, but it's not like we're calling some
> internal API here. We're trying to probe a driver and if that oopses
> because the driver writer failed at their job then it's bad on them for
> writing a bad patch but also annoying for the integrator who has to deal
> with the mess they created. I'd rather have a half working system here
> vs. a totally broken one.

Forgot about your recovery cycle, on most of my boards I just load a new
kernel every boot, so there's no cost of recovering from a panic, it
might even save me some time if it crashes completely before userspace
starts consuming cycles.

My only concern is that this "sets" a quite fuzzy precedence. I don't
want us to just fix SA warnings all over the place, but I don't want it
to be inconvenient to work on the kernel...

Regards,
Bjorn
