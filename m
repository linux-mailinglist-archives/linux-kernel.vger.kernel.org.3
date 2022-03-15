Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1E1E4D971E
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 10:06:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346366AbiCOJHP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 05:07:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234309AbiCOJHN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 05:07:13 -0400
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73B734BB8B
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 02:06:01 -0700 (PDT)
Received: by mail-qv1-f42.google.com with SMTP id im7so14517529qvb.4
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 02:06:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=z3LfIJkfGS6Zp6FqW3s9C0kvNrJ6zr2A5j+g5hiGGpA=;
        b=yT3DiYXx5xIveRAN13zHZKCRgoYGnjZBxqvT3eLk6oVb7AEXKw7kg0iaZcM1VEQ78P
         aXgVSbXiRgf4CxFg3L5IDH8xiyP+wT5k2iJwLtfDRPgmYMGbpcVOibW9EO1um4xu70Bk
         xwXjcKRA+Y6IpOZou2jOJQn+1bMRR7palv+Y6Jils7vRrrsjIvIUiSovYCFB2f/GdnxI
         6oo9ht7zMh9wkAd7cU08VDPpUTWIY7V/GTL8V8N7Py0NVeZgReor2a+/bQm1CWucNCZl
         TGiqtW505nBfrUxb1SnHs1g0yPQGF0n8rzBBbP+gFiyVGHsXBBYOFqcftWxEveGe6BY5
         ufuQ==
X-Gm-Message-State: AOAM531M3Bj0PTgMBSFjZRs0gS2LTKslnNPQI52wh058lh2P9LW/h+6Q
        3keHF1Wa7Sts0/aJJIia/IjjT61XcI9hIQ==
X-Google-Smtp-Source: ABdhPJwCqDtU3KUtJ8pCzzIQhFqFdVh/RXPgHo13bWQ2T8mvcfwoRoW2m9KTzAT5I0k3IFfzniABGg==
X-Received: by 2002:a05:6214:2487:b0:435:92e5:7f with SMTP id gi7-20020a056214248700b0043592e5007fmr20423488qvb.76.1647335159578;
        Tue, 15 Mar 2022 02:05:59 -0700 (PDT)
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com. [209.85.128.177])
        by smtp.gmail.com with ESMTPSA id k1-20020ac85fc1000000b002e1c6420790sm7706027qta.40.2022.03.15.02.05.58
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Mar 2022 02:05:58 -0700 (PDT)
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-2dc242a79beso193134457b3.8
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 02:05:58 -0700 (PDT)
X-Received: by 2002:a81:49d0:0:b0:2db:dc6d:445d with SMTP id
 w199-20020a8149d0000000b002dbdc6d445dmr23815441ywa.512.1647335158278; Tue, 15
 Mar 2022 02:05:58 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wiHa0vsZseZES=1T0rJ4Z_bC5cwHMUJfqFL9hVpvB283g@mail.gmail.com>
 <20220314192522.GA3031157@roeck-us.net> <CAHk-=wiEhs+4P1TNh2sNnk04D1FFdNThk6XLOMxzkRL72PEXFw@mail.gmail.com>
In-Reply-To: <CAHk-=wiEhs+4P1TNh2sNnk04D1FFdNThk6XLOMxzkRL72PEXFw@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 15 Mar 2022 10:05:47 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUzCckOXNPpucG5HEHwJ6LzGGJis30m+trX7fibyQU8vw@mail.gmail.com>
Message-ID: <CAMuHMdUzCckOXNPpucG5HEHwJ6LzGGJis30m+trX7fibyQU8vw@mail.gmail.com>
Subject: Re: Linux 5.17-rc8
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Thierry Reding <treding@nvidia.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Vidya Sagar <vidyas@nvidia.com>,
        Edmond Chung <edmondchung@google.com>,
        Andrew Chant <achant@google.com>,
        Will McVicker <willmcvicker@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Marcelo Roberto Jimenez <marcelo.jimenez@gmail.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Thorsten Leemhuis <linux@leemhuis.info>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 15, 2022 at 9:43 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> [ Adding more people to the cc, since this last change was triggered
> by earlier changes.
>
> On Mon, Mar 14, 2022 at 12:25 PM Guenter Roeck <linux@roeck-us.net> wrote:
> >
> > Build results:
> >         total: 155 pass: 155 fail: 0
> > Qemu test results:
> >         total: 488 pass: 484 fail: 4
>
> Uhhuh. We got all the previous problems sorted out, but a new one instead.
>
> > This is a new problem. It bisects to commit fc328a7d1fcc ("gpio: Revert
> > regression in sysfs-gpio (gpiolib.c)"). The network connection fails
> > in the affected tests. Reverting the offending commit (ie reverting the
> > revert) fixes the problem.
>
> Hmm. Looking at the changes since 5.16, that commit fc328a7d1fcc looks
> somewhat suspicious.
>
> It claims to "revert" things, but the behavior it reverts goes
> basically all the way back to v5.7 (with one of the patches going into
> 5.10).
>
> And it clearly breaks things that used to work much more recently (ie
> this worked in rc7, but it was also the state in every release since
> 5.10).
>
> So unless somebody can find the _real_ issue here, I suspect very
> strongly that that "fix" that came in last week was just wrong.
>
> It is also very non-specific "Some GPIO lines have stopped working"
> with no pointer to actual reports.
>
> LinusW? Thierry? Bartoz? Anybody?
>
> Yes, there;s something bad going on here, but we can't randomly "fix"
> things in an rc8 that have worked for several releases by now.

People really need to learn[1] to add proper Link tags to each and every
commit:
https://lore.kernel.org/all/20211217153555.9413-1-marcelo.jimenez@gmail.com
The last mail in that thread is a regression report for the fix.
Note that this "fix" has only been in next-20220308 and later, so
more breakage may show up soon...

[1] https://www.kernel.org/doc/html/v5.6/maintainer/configure-git.html#creating-commit-links-to-lore-kernel-org

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
