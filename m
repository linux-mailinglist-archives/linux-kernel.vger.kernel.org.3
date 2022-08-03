Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29C875885FE
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 05:20:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234019AbiHCDT6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 23:19:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232491AbiHCDTz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 23:19:55 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18CB43342A
        for <linux-kernel@vger.kernel.org>; Tue,  2 Aug 2022 20:19:54 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id i14so10406609ejg.6
        for <linux-kernel@vger.kernel.org>; Tue, 02 Aug 2022 20:19:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=qy1jWYwnG9452wugTCrRTZvi4+IrGNxgDbnguzeYbro=;
        b=FtIvVutQFKN66fPCXnRjzeFpwAvWlpKdRLN0f0WYZSsGsfCwW8tE2K6dWJp4NVXzLM
         xoqWoshHqUhjfVnshp2MVtFU62WEAnAnmQ3yAwpXwVbJkaFxFvnGUWTvxHEgxuvJfBiT
         qSaFctrDD77fGQ5r5BzrDxED59aKc+efhPRHA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=qy1jWYwnG9452wugTCrRTZvi4+IrGNxgDbnguzeYbro=;
        b=yXtji6EUb8olPKFLjR2pBW8q5G+6V5V3NxDGII3CpfPQAPRG5eoYzuDahHQ8m/o46g
         HYyV6ym5iSJTWzuRgmrJ8msPNut0/stSmr25NAXPdaib1Np51yN/orn5oZgRjvs3fx+C
         8RJmQuJ2XZ5jr3Xov3m4NkhdiR7HCqfwjMEGAztaSfEee88HKfySKilJ8+W5IrHpbQbH
         sMViPuvfk7hTOqAEaDhCfuAWWFnwC2RwpF8qNXVoWXBUCDZCHDW18E3WGoioYO9INkKx
         rDcZwiTGevdveTcJUIfLol6k9k76PtMo//OHmH1Rru1yntcxF6wTNHHbucpUFVoZZfXn
         mMSA==
X-Gm-Message-State: AJIora/ms3o3Y2UHYHyr4ZEslpLrE3zjdxqKCW0UUArdcraaHf4kRUIX
        0/Wh3NA/acW2044Ypc62dRILf7zTmmUfeW7E
X-Google-Smtp-Source: AGRyM1uVMesfJLWYIKW8VJ+FEIHLC7QqmCisppYVtdeYh/jdxcQRsIijIKM3+fTzf41zmiXjZ73Lig==
X-Received: by 2002:a17:907:60cc:b0:72b:40a8:a5b with SMTP id hv12-20020a17090760cc00b0072b40a80a5bmr18444401ejc.379.1659496792395;
        Tue, 02 Aug 2022 20:19:52 -0700 (PDT)
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com. [209.85.221.51])
        by smtp.gmail.com with ESMTPSA id sy7-20020a1709076f0700b0073054d7c51csm4402794ejc.37.2022.08.02.20.19.50
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Aug 2022 20:19:51 -0700 (PDT)
Received: by mail-wr1-f51.google.com with SMTP id h13so719259wrf.6
        for <linux-kernel@vger.kernel.org>; Tue, 02 Aug 2022 20:19:50 -0700 (PDT)
X-Received: by 2002:adf:edcb:0:b0:21e:d043:d271 with SMTP id
 v11-20020adfedcb000000b0021ed043d271mr14820445wro.274.1659496790456; Tue, 02
 Aug 2022 20:19:50 -0700 (PDT)
MIME-Version: 1.0
References: <YufsTLpighCI7qSf@alley>
In-Reply-To: <YufsTLpighCI7qSf@alley>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 2 Aug 2022 20:19:34 -0700
X-Gmail-Original-Message-ID: <CAHk-=wie+VC-R5=Hm=Vrg5PLrJxb1XiV67Efx-9Cr1fBKCWHTQ@mail.gmail.com>
Message-ID: <CAHk-=wie+VC-R5=Hm=Vrg5PLrJxb1XiV67Efx-9Cr1fBKCWHTQ@mail.gmail.com>
Subject: Re: [GIT PULL] printk for 5.20
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>, Jan Kara <jack@suse.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 1, 2022 at 8:08 AM Petr Mladek <pmladek@suse.com> wrote:
>
> - Completely disable printing on consoles with CONFIG_RT.

I don't think this is acceptable.

We don't suddenly change behavior just because some random developer
has decided "this is the RightThing(tm) to do".

Users matter.

For all we know, there may be random users who are playing around with
PREEMPT_RT. They don't *have* to, but they want to.

Just saying "you get no console because you wanted to try it out" is
simply not acceptable.

It's also NOT SANE.

Seriously, even if you have strict RT requirements, you may also have
strict debugging requirements, and if something goes wrong, you want
to KNOW ABOUT IT. At that point, your RT rules may well fly out the
window, because you have more serious problems.

End result: no way will I accept this kind of completely arbitrary and
frankly not very intelligent patch.

If people want to disable console printing, that's THEIR CHOICE. It
could be a new config variable where you ASK people about what they
want. Not this kind of idiotic tying together of things.

And guys, I want to make it really clear how disappointed I am with
the printk tree lately. There seems to be some kind of hardline
religious fervor having taken over to make these kinds of "this is how
it has to be done, screw any sanity or common sense".

There is exactly one thing you should hold sacred: don't break
people's setups. All the rest is just engineering, and a HUGE part of
"engineering" is to realize that everything is a trade-off.

Linux kernel development is a pragmatic thing where existing users and
existing code matters, and you don't get to just throw it all away
because you have some odd personal hangup.

And printing messages to a console is not some "oh, we'll just stop
doing that because you asked for PREEMPT_RT".

Put another way: not only am I not pulling this, I'm concerned that I
will not be pulling printk patches in the future either because of
where these pull requests seem to be trending.

               Linus
