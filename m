Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABB274D9250
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 02:47:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344038AbiCOBsq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 21:48:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244798AbiCOBso (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 21:48:44 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A429B17AAD
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 18:47:32 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id bt26so30421714lfb.3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 18:47:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=o7LC1rySqP2UTcmKEfpa0g3vuYDw2vZQKtylhm15CgQ=;
        b=DBvsPqPY7quc5FghY3KV9oyJVPN3DUJHwai9U/uvXJIv7et3SfXa64kGUjQMrcMssl
         36pePHaJQ8qa7LF+eCDQW66fzLHRLAERjCjo+mFPFkI1xRqL84j77ewtt1ISKgeVJTUQ
         gIfJGVBmx6Y9Myb+mqNAztZUKL0Gfyf7fyGQE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=o7LC1rySqP2UTcmKEfpa0g3vuYDw2vZQKtylhm15CgQ=;
        b=kKBrOzi8Fq03r/fswokvGz/SgcpVKRY1Vh3V897yhw+XdrIDxGX1Bx605zMpQiCbSk
         xXnmkwgOjZMkFfq1mmAMMbr5Ye7zUzVyXwmm9CaCK4Br050Su2Tll5F6WXrIuXbuAgKF
         NfNL+Q5dfHmitirOMzI60TrFBbrqzOsHuSkCUG3+kQcSYmUFAXyOThBx/KA9h3mIKT5p
         xrBo8uwGDV4S8MCeyRjpPE1atBwzmk2b+yuB4gWAQ2eFmQMv+G47OMEujLNrGP+jMmuc
         IDwx+MCSxuBtSnDsBwA5m05LVpVZZS6++GjkjzSKgXcgZRX3UUMiykeU/A2XS+QA+75m
         wNaA==
X-Gm-Message-State: AOAM531R4E3jNxEcTgLXeuIV9qHQ2mx+gyBaD5arGN+M6WOlNrV1t+1f
        dly1Mr02+eJClJaA7bT0KpchFFo/ObGVYGdH
X-Google-Smtp-Source: ABdhPJzH731qnoxeJrFK7wiMYePYJbsenRSTM57XZYtTbjNzEKvPiDQgZ1csAzXpYGjwPkljmqUVPA==
X-Received: by 2002:a05:6512:398d:b0:448:5f9e:d992 with SMTP id j13-20020a056512398d00b004485f9ed992mr13951466lfu.553.1647308850681;
        Mon, 14 Mar 2022 18:47:30 -0700 (PDT)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com. [209.85.167.48])
        by smtp.gmail.com with ESMTPSA id w10-20020ac2442a000000b0044835a52a08sm3517528lfl.163.2022.03.14.18.47.28
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Mar 2022 18:47:28 -0700 (PDT)
Received: by mail-lf1-f48.google.com with SMTP id 3so30415414lfr.7
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 18:47:28 -0700 (PDT)
X-Received: by 2002:a05:6512:2037:b0:448:92de:21de with SMTP id
 s23-20020a056512203700b0044892de21demr5028302lfs.52.1647308847738; Mon, 14
 Mar 2022 18:47:27 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wiHa0vsZseZES=1T0rJ4Z_bC5cwHMUJfqFL9hVpvB283g@mail.gmail.com>
 <20220314192522.GA3031157@roeck-us.net> <CAHk-=wiEhs+4P1TNh2sNnk04D1FFdNThk6XLOMxzkRL72PEXFw@mail.gmail.com>
 <CACjc_5paC=X4znTty8LBtobqBW2nq4mbQYnw_TMgVEFb1A7mhA@mail.gmail.com>
In-Reply-To: <CACjc_5paC=X4znTty8LBtobqBW2nq4mbQYnw_TMgVEFb1A7mhA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 14 Mar 2022 18:47:11 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh0QBksyaTEn4gk=mn6hgAhp3e8i9mRsr657Dd-kQ3MKg@mail.gmail.com>
Message-ID: <CAHk-=wh0QBksyaTEn4gk=mn6hgAhp3e8i9mRsr657Dd-kQ3MKg@mail.gmail.com>
Subject: Re: Linux 5.17-rc8
To:     Marcelo Roberto Jimenez <marcelo.jimenez@gmail.com>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Thierry Reding <treding@nvidia.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Vidya Sagar <vidyas@nvidia.com>,
        Edmond Chung <edmondchung@google.com>,
        Andrew Chant <achant@google.com>,
        Will McVicker <willmcvicker@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 14, 2022 at 5:45 PM Marcelo Roberto Jimenez
<marcelo.jimenez@gmail.com> wrote:
>
> At a certain point, I tried Thorsten's suggestion to add a gpio-ranges
> property in a way similar to another patch, but the kernel went into
> an EPROBE_DEFER deadlock. Thierry Reding made some comments about this
> in the sequence.

Hmm. The problem does sound like that particular driver doesn't use
the pin_ranges thing, so then the tests for an empty pin_ranges will
always be true.

The EPROBE_DEFER deadlock then sounds like something went wrong in the
gpio-ranges patch when you tried to fix it - but I don't actually find
that patch or that attempt, so I can't even guess at it.

This whole code pin_ranges code looks very odd:
gpiochip_add_pin{group}_range() seems to add the pin ranges properly,
but that actual gpiochip_add_pin_ranges() function does *not*.

It just expects that that the 'add_pin_ranges()' callback exists, and
if it doesn't, does nothing at all.

Which then makes those

        if (list_empty(&gc->gpiodev->pin_ranges))
                return 0;

tests very suspicious - because if some doesn't implement that
add_pin_ranges() callback, it looks like nothing at all ever gets
done, because nothing calls the function to actually add the pinrange.
And then that "list_empty()" test very much will trigger.

IOW, it looks like either a gpio controller has to implement that
'add_pin_ranges()' function (only tegra), or it needs to always add
the pin ranges at probe time.

Am I guessing right that the driver that you use does neither?

LinusW/Bartoz - this all really sounds strange to me. Maybe I'm
misreading the situation entirely. Should there be some sanity-test
that any gpio/pinctrl driver that uses gpiochip_generic_request()
would either have to have that add_pin_ranges() callback, or a
successful probe needs to always populate that 'gpiodev->pin_ranges'
list?

Or maybe I'm misreading the situation entirely. I don't know the code
- I'm just grepping for things and trying to make sense of how that
'->pin_ranges' list is supposed to work.

But for now, I think that patch has to be reverted.

               Linus
