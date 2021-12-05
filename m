Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A4CA4688B7
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Dec 2021 01:30:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230077AbhLEAdt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Dec 2021 19:33:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbhLEAds (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Dec 2021 19:33:48 -0500
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F214C061751
        for <linux-kernel@vger.kernel.org>; Sat,  4 Dec 2021 16:30:22 -0800 (PST)
Received: by mail-ot1-x334.google.com with SMTP id a23-20020a9d4717000000b0056c15d6d0caso8583141otf.12
        for <linux-kernel@vger.kernel.org>; Sat, 04 Dec 2021 16:30:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6y71zrGyUm53y6etkENkH9vk53uSF1GEIKxh02HrJ44=;
        b=yN5cu+ds8GQINJ5qZy5fjmyWkWQVxzZg2Q5Is9ekfb+VTtXPDu2MrvFT5SgLathLDb
         Frex9UuWeygJNnL3xsAZu1F0NzhApY6g3eEK0KhjldnOi1vSAVFpNCs4Fai1H5xOhoHz
         3WPhAXqeUeJJA7gFlJ/hq1aPa8ZrmuECvlMUfhMdiG9RNop260MHGUVwNiBmmC17QzXo
         X+35GyKBrePRmitKCV23+dD+bDsb2lR2PbZs8GNfgz5yiCMzIRIVpy65eFQb1A/w+Vh9
         Bc92eSgLRLRtWUmLMPS50dZXhXAJcxKgRuLrJCzOD3gC630rt2S7zT9nqZGAExiZiY2B
         Swjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6y71zrGyUm53y6etkENkH9vk53uSF1GEIKxh02HrJ44=;
        b=4uuDgXtWO/+yAlwfofzu76eZx4kM8JGSDgOp3Im24aUjlVvOF23yKYsjuQ9u40hth2
         D1UiF/tLWgO1BJGpoUxN/xH8g17wxBPD4hpWGJDlwBWiKjywU4V+RRrkOUbZ5G1i7VXT
         lvXcbob8JijFKuPtjPiHg2CxBxvz0YBvqjIcHHWy76770sdM1wnvrvvMrC3YbHfvQ9j3
         yv7jGp5fnllLDiir88qwDK9niYcM42sqJzGnpS89xagxJKccsEUGds2ZmoCuTo6a3Wi5
         ODYQTaoAbgMyxwDSQfVUmz0KpwWnWMuZa0hn7Jt0QTyNs+8rHOY2XD6dTnQo7a5RJyeZ
         SOew==
X-Gm-Message-State: AOAM533ZaJCrA+0v6esjbHV+T/YT5Pa4e1+cxCSHiRl5thjD0EogkCHV
        msqjMxz+FffYZyrq/y3omIEyaw/RNqyPBo2lkBkZ0g==
X-Google-Smtp-Source: ABdhPJwkGm2r7mHDrjNl3YQJbeXL52IHT7NtrtzaW/i6kh0H/ZxP82a0eia2lqUU9Gm25ADttUCPF+N1M9UL1kKteio=
X-Received: by 2002:a9d:ed6:: with SMTP id 80mr22880693otj.35.1638664221225;
 Sat, 04 Dec 2021 16:30:21 -0800 (PST)
MIME-Version: 1.0
References: <cover.1637061794.git.matti.vaittinen@fi.rohmeurope.com>
 <6123f62ac44e6513a498d15034a4b6b22abe5f5b.1637061794.git.matti.vaittinen@fi.rohmeurope.com>
 <CACRpkdbKeW+pJ8SZ0fPD+9kEtgHgi2A9U=f6XyKTHogKU-9F9g@mail.gmail.com>
 <7b34e88f-54f3-6d0a-293e-b2b411d1c5c2@fi.rohmeurope.com> <676253b9-ff69-7891-1f26-a8b5bb5a421b@fi.rohmeurope.com>
 <CACRpkdZXhw9+txdLv-k01nzH3+GvGivyAoCO1JCf2VyYK96CnQ@mail.gmail.com>
 <57f97c5f-aedb-7f7e-d269-90bd97bbba09@fi.rohmeurope.com> <CACRpkdZ9EEmWSb4mq7WJywma4dFCms+Z3BAKfntcsb9y_1THNQ@mail.gmail.com>
 <d14580b3-1647-5105-4770-2cd8751d9fe5@fi.rohmeurope.com> <CACRpkdYvi7__DJNWRRHgL=4QcA0XV2uXXbW+boVU8dy10rEuVw@mail.gmail.com>
 <78f44e65-e788-22a0-5141-fb86f08c5522@fi.rohmeurope.com>
In-Reply-To: <78f44e65-e788-22a0-5141-fb86f08c5522@fi.rohmeurope.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sun, 5 Dec 2021 01:30:09 +0100
Message-ID: <CACRpkdZgm3k7D1pYvzeX+JwNpkD4U3ORUcUFzaphFAp+cXQwRw@mail.gmail.com>
Subject: Re: [RFC PATCH v3 3/9] power: supply: Support DT originated
 temperature-capacity tables
To:     "Vaittinen, Matti" <matti.vaittinen@fi.rohmeurope.com>
Cc:     Matti Vaittinen <mazziesaccount@gmail.com>,
        Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        "rostokus@gmail.com" <rostokus@gmail.com>,
        "fan.chen@mediatek.com" <fan.chen@mediatek.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-power <linux-power@fi.rohmeurope.com>,
        =?UTF-8?B?c2hpbWkgPj4g5riF5rC0IOW0h+W8mA==?= 
        <shimizu394@lapis-tech.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matti,

On Thu, Dec 2, 2021 at 7:29 AM Vaittinen, Matti
<Matti.Vaittinen@fi.rohmeurope.com> wrote:

(fast forward the stuff where we are in violent agreement)

> What I was now considering is that maybe the capacity drop (in uAhs)
> caused by the temperature change - is not the same for new and old
> battery. It sounds more logical to me that the capacity drop caused by
> the temperature is proportional to the maximum capacity battery is
> having at that point of it's life. Eg, if new battery can hold 80 units
> of energy, and drops 20 units of energy when temperature changes from T0
> => T1 - an badly aged battery which now only can hold 40 units would
> lose only 10 units at that same temperature drop T0 => T1. I was
> wondering if such an assumption is closer to the truth than saying that
> bot of the batteries would lose same 20 units - meaning that the new
> battery would lose 25% of energy at temperature drop T0 => T1 but old
> one would lose 50% of the capacity. I somehow think both of the
> batteries, old and new, would lose same % of capacity at the temperature
> change.
>
> So, if this assumption is correct, then we should give the temperature
> impact as proportion of the full capacity taking the aging into account.

This looks plausible.

> My problem here is that I just assume the impact of temperature is
> proportional to the full-capacity which takes the aging into account.
> Knowing how this really is would be cool so we could get the temperature
> impact modelled correctly in DT.

I suppose we should check some IEEE articles to verify that this is the
case before assuming. I have access to them but no time to read :(

> > Yes there is some tight community of electronic engineers who read the
> > right articles and design these things. We don't know them :(
>
> Right. By the way, I heard tha the TI has patent protecting some type of
> battery internal resistance usage here. OTOH, ROHM has patent over some
> of the VDROP value table stuff. Occasionally it feels like the ice is
> getting thinner at each step here. :/

This is none of our concern. Patents are concerns for people shipping
devices, not for open source code. Also patents are only valid for
20 years and we are looking at longer times anyway. If we define
generic DT properties for this they will be used more than 20 years
from now. We even have patented code in the kernel, see:
Documentation/RCU/rcu.rst

Yours,
Linus Walleij
