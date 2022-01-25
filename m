Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3D0449A871
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 05:12:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1318810AbiAYDHM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 22:07:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S3416559AbiAYCES (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 21:04:18 -0500
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEFB0C055A83
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 17:55:59 -0800 (PST)
Received: by mail-oi1-x22f.google.com with SMTP id e81so28488901oia.6
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 17:55:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=T4rF0hLY7ipw4hc6cLAFZLFsJmiutz6BweB8Dz29VfE=;
        b=mvEF6fOKLUpg42CVbbypm40M0/3KmMchADzb3NMDmLowUcZqsdQ9ybGgFg0NFGWzwh
         b9WHGpDfddcXAyDpMpRpB5KzlYxFPoJ4xXSMLdA5smZ6UkM91INnKst7AlTuayeQvzbs
         Uxx0n2Jukd4i1d5M70kWyTYutk/S9Qa+S1XOk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=T4rF0hLY7ipw4hc6cLAFZLFsJmiutz6BweB8Dz29VfE=;
        b=BpAZLHnhaCTMYFvEShodUYhqniuSStUE2trWCHwgz03HC3Yn4Hsoq5tUyiA1A0j5gZ
         h3RxZikgjP7ll5gvBCj87roLiklDokkRQuUvJezaTt4+LN0evWKCPs40Nri8qXEM820V
         WteBUJR9eO2es6PI2gd2mxUmV/41HF1rB+mqwFnx6rYZwIjnh/yNW1nuSNXnZzUOh0jY
         mdKIAYjII7IXBt216/g/viJtSk5ksDE5yp8Pa3djcYq8oNqU+4qb8eUOiLQ2vFTOQFOL
         N+CtqOHmyRYh2xpmKr23C2naORa0PZZyk4ozIM9TUAVM47r4VHamiiq159eUvqBpGJs2
         E++A==
X-Gm-Message-State: AOAM531jJg5obZNmf0aD6Oe8tYuoLv1qqj/+3zP38aTL6jFWUg1skVD7
        As8r/NOXCVHdIhK8jP1hPmQFIDQ+WTxAwkWSK5eTUg==
X-Google-Smtp-Source: ABdhPJzHi4N4zlikwEiCyjUIatqOZ90959JBrz7E38fa6Tao/XK98LwlytlQgYDcXpHvnll2OI4toRTtnC5NjDJLSCQ=
X-Received: by 2002:a05:6808:252:: with SMTP id m18mr1234653oie.164.1643075759011;
 Mon, 24 Jan 2022 17:55:59 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 24 Jan 2022 17:55:58 -0800
MIME-Version: 1.0
In-Reply-To: <Ye8nmnQ3F4QcTIJs@ripper>
References: <20220120204132.17875-1-quic_amelende@quicinc.com>
 <20220120204132.17875-4-quic_amelende@quicinc.com> <YenpwnE3WrIEAOlm@ripper>
 <e2015c19-b73b-39a7-ba73-708b2c4552c7@quicinc.com> <CAE-0n50+1OU2yt2gihHHCEn-cE-CZuqa_U9W=xWCuYeCQdzExw@mail.gmail.com>
 <Ye8nmnQ3F4QcTIJs@ripper>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Mon, 24 Jan 2022 17:55:58 -0800
Message-ID: <CAE-0n51bYEkvxu8z2gc_KUv0u+J2Esg0_3AiQRLyTaouNoa78g@mail.gmail.com>
Subject: Re: [PATCH 3/3] input: misc: pm8941-pwrkey: avoid potential null
 pointer dereference
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Anjelique Melendez <quic_amelende@quicinc.com>,
        dmitry.torokhov@gmail.com, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        collinsd@codeaurora.org, skakit@codeaurora.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Bjorn Andersson (2022-01-24 14:26:34)
> On Thu 20 Jan 20:18 PST 2022, Stephen Boyd wrote:
>
> > Quoting Anjelique Melendez (2022-01-20 16:25:26)
> > >
> > > On 1/20/2022 3:01 PM, Bjorn Andersson wrote:
> > > > On Thu 20 Jan 12:41 PST 2022, Anjelique Melendez wrote:
> > > >
> > > >> From: David Collins <collinsd@codeaurora.org>
> > > >>
> > > >> Add a null check for the pwrkey->data pointer after it is assigned
> > > >> in pm8941_pwrkey_probe().  This avoids a potential null pointer
> > > >> dereference when pwrkey->data->has_pon_pbs is accessed later in
> > > >> the probe function.
> > > >>
> > > >> Change-Id: I589c4851e544d79a1863fd110b32a0b45ac03caf
> > > >> Signed-off-by: David Collins <collinsd@codeaurora.org>
> > > >> Signed-off-by: Anjelique Melendez <quic_amelende@quicinc.com>
> > > >> ---
> > > >>  drivers/input/misc/pm8941-pwrkey.c | 4 ++++
> > > >>  1 file changed, 4 insertions(+)
> > > >>
> > > >> diff --git a/drivers/input/misc/pm8941-pwrkey.c b/drivers/input/misc/pm8941-pwrkey.c
> > > >> index 0ce00736e695..ac08ed025802 100644
> > > >> --- a/drivers/input/misc/pm8941-pwrkey.c
> > > >> +++ b/drivers/input/misc/pm8941-pwrkey.c
> > > >> @@ -263,6 +263,10 @@ static int pm8941_pwrkey_probe(struct platform_device *pdev)
> > > >>
> > > >>      pwrkey->dev = &pdev->dev;
> > > >>      pwrkey->data = of_device_get_match_data(&pdev->dev);
> > > >> +    if (!pwrkey->data) {
> > > > The only way this can happen is if you add a new compatible and forget
> > > > to specify data and when that happens you will get a print in the log
> > > > somewhere, which once you realize that you don't have your pwrkey you
> > > > might be able to find among all the other prints.
> > > >
> > > > If you instead don't NULL check this pointer you will get a large splat
> > > > in the log, with callstack and all, immediately hinting you that
> > > > pwrkey->data is NULL.
> > > >
> > > >
> > > > In other words, there's already a print, a much larger print and I don't
> > > > think there's value in handling this mistake gracefully.
> > > >
> > > > Regards,
> > > > Bjorn
> > >
> > >
> > > We would like to the null pointer check in place to avoid static analysis
> > >
> > > warnings that can be easily fixed.
> > >
> >
> > Many drivers check that their device_get_match_data() returns a valid
> > pointer. I'd like to see that API used in addition to checking the
> > return value for NULL so that we can keep the static analysis tools
> > happy. Yes it's an impossible case assuming the driver writer didn't
> > mess up but it shuts SA up and we don't really have a better solution
> > to tell tools that device_get_match_data() can't return NULL.
>
> I'm not saying that device_get_match_data() can't return NULL,

Indeed, I wasn't implying that you were saying that.

> I'm
> saying that in the very specific cases that it would return NULL it's
> useful to have a kernel panic - as that's a much faster way to figure
> out that something is wrong.

I see it as more annoying, but maybe that's my workflow? When my kernel
oopses I have to go back to a recovery kernel, which takes me a few more
seconds to "repair" my device. If the driver only failed to probe then
I'd probably be able to boot far enough to get networking and more
easily replace my kernel with a working device. And I'd have userspace
access so I could poke around and figure out why the driver failed to
probe. Now obviously a big stacktrace would be helpful to know that it's
the power key driver that's busted, but it's not like we're calling some
internal API here. We're trying to probe a driver and if that oopses
because the driver writer failed at their job then it's bad on them for
writing a bad patch but also annoying for the integrator who has to deal
with the mess they created. I'd rather have a half working system here
vs. a totally broken one.
