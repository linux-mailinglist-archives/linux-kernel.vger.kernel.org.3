Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8986C4DA069
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 17:49:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350134AbiCOQuG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 12:50:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350203AbiCOQt6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 12:49:58 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15D42517D0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 09:48:45 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id qa43so42410003ejc.12
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 09:48:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qheZ1ENvb9x/0d1hNVlELAPpvFkCjTkbEefvApG+abE=;
        b=YcBDtxazXi0/rbjjeFXc0/+X6MOk72vz+oc9wZNmmn/hyEyD5oDZ7/AFOtAUlfpJvx
         zvgLtC1TjtUmIfQiW2e35EfuMYVxo8igY34EIWuJEvC0eQFMdcRv//N2etI/2VA7mS1J
         Bk6WIPQUFn5kuQlrCq5PRwBxaphVupZiUFKvI9w4Y1s2szE78fIh7jJbCNLpwH7Ix/Ok
         2vTiQdu2VUqkkQfiZw9dWkJhWTtgsjYbtHrUzmQZEMxDhUAp7DTW3ICVJvlrav7065jX
         b2AKguiStJ5f8kWKa7DwXAUV8xIPITyxe6XR8jaBaM1MH3Z1cNaJY8I8lD/HVVkmwdof
         2bow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qheZ1ENvb9x/0d1hNVlELAPpvFkCjTkbEefvApG+abE=;
        b=XWF2HN1Gh9nHoNvbfzmuCIitD88B8jOb+rBkMu9i8C8KeagAaytJJIOTHUabVzUbBE
         AoDmYVOnwiX9TDjqv6+lKMW9El7ZiDiV1vBG8KUb5JKE/C0qIv29UGvbOn8rDdU5dio1
         9391PBvpo1Eb+ZW6nKS2JYOeDTwncRxWnfl7gMp84JffMiq03Dxj1uwSipU0pyN9I5N7
         V46k4xvvZduNKpryXXLzrL1yU/HoRWL1k44NLmWfFAtAsdGSWaSTUY2CmYps1JabuD32
         a/yt/5E6JGl6MrEou3SPjD6c7O2NRYWsdTR9Dptb+nPVLa/zDbbFNaco3sqGXLgFSZQn
         bHMA==
X-Gm-Message-State: AOAM530KX7dng31mTDET67qFgb4m03J1JKteHicNvjRZR011hk0Z0KHX
        wPz90tgikIYduXY+XBkWKbRUU+ZVlc2eGnxONiCu+w==
X-Google-Smtp-Source: ABdhPJy/j/+WVGZMrpefriH/4KTxPVQAncdabGacEKN41CTV4aFHTGEr8BLYhNPCvCOkv0N/tiEAP018t4ftP0pkVPE=
X-Received: by 2002:a17:907:3f24:b0:6da:68fa:b2cc with SMTP id
 hq36-20020a1709073f2400b006da68fab2ccmr23711912ejc.734.1647362923497; Tue, 15
 Mar 2022 09:48:43 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wiHa0vsZseZES=1T0rJ4Z_bC5cwHMUJfqFL9hVpvB283g@mail.gmail.com>
 <20220314192522.GA3031157@roeck-us.net> <CAHk-=wiEhs+4P1TNh2sNnk04D1FFdNThk6XLOMxzkRL72PEXFw@mail.gmail.com>
 <CACjc_5paC=X4znTty8LBtobqBW2nq4mbQYnw_TMgVEFb1A7mhA@mail.gmail.com> <CAHk-=wh0QBksyaTEn4gk=mn6hgAhp3e8i9mRsr657Dd-kQ3MKg@mail.gmail.com>
In-Reply-To: <CAHk-=wh0QBksyaTEn4gk=mn6hgAhp3e8i9mRsr657Dd-kQ3MKg@mail.gmail.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Tue, 15 Mar 2022 17:48:32 +0100
Message-ID: <CAMRc=MfK1ak6BN27BuLAV3cyD8kRSdfQOovOsKqF35GBhJqpWQ@mail.gmail.com>
Subject: Re: Linux 5.17-rc8
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Marcelo Roberto Jimenez <marcelo.jimenez@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Thierry Reding <treding@nvidia.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Vidya Sagar <vidyas@nvidia.com>,
        Edmond Chung <edmondchung@google.com>,
        Andrew Chant <achant@google.com>,
        Will McVicker <willmcvicker@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 15, 2022 at 2:47 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Mon, Mar 14, 2022 at 5:45 PM Marcelo Roberto Jimenez
> <marcelo.jimenez@gmail.com> wrote:
> >
> > At a certain point, I tried Thorsten's suggestion to add a gpio-ranges
> > property in a way similar to another patch, but the kernel went into
> > an EPROBE_DEFER deadlock. Thierry Reding made some comments about this
> > in the sequence.
>
> Hmm. The problem does sound like that particular driver doesn't use
> the pin_ranges thing, so then the tests for an empty pin_ranges will
> always be true.
>
> The EPROBE_DEFER deadlock then sounds like something went wrong in the
> gpio-ranges patch when you tried to fix it - but I don't actually find
> that patch or that attempt, so I can't even guess at it.
>
> This whole code pin_ranges code looks very odd:
> gpiochip_add_pin{group}_range() seems to add the pin ranges properly,
> but that actual gpiochip_add_pin_ranges() function does *not*.
>
> It just expects that that the 'add_pin_ranges()' callback exists, and
> if it doesn't, does nothing at all.
>
> Which then makes those
>
>         if (list_empty(&gc->gpiodev->pin_ranges))
>                 return 0;
>
> tests very suspicious - because if some doesn't implement that
> add_pin_ranges() callback, it looks like nothing at all ever gets
> done, because nothing calls the function to actually add the pinrange.
> And then that "list_empty()" test very much will trigger.
>
> IOW, it looks like either a gpio controller has to implement that
> 'add_pin_ranges()' function (only tegra), or it needs to always add
> the pin ranges at probe time.
>
> Am I guessing right that the driver that you use does neither?
>

There are more drivers than just tegra that implement add_pin_ranges()
but you're right, pinctrl-at91.c used by Marcelo does not.

> LinusW/Bartoz - this all really sounds strange to me. Maybe I'm

It's BartoSz actually. :)

> misreading the situation entirely. Should there be some sanity-test
> that any gpio/pinctrl driver that uses gpiochip_generic_request()
> would either have to have that add_pin_ranges() callback, or a
> successful probe needs to always populate that 'gpiodev->pin_ranges'
> list?
>

This sounds right to me but I need to spend some more time on this, I
didn't author the code in question.

> Or maybe I'm misreading the situation entirely. I don't know the code
> - I'm just grepping for things and trying to make sense of how that
> '->pin_ranges' list is supposed to work.
>
> But for now, I think that patch has to be reverted.
>

Sounds good, I'll send a revert and make another PR with fixes before v5.17.

Bartosz

>                Linus
