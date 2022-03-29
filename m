Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 504D44EB2BF
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 19:35:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240234AbiC2Rgp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 13:36:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235834AbiC2Rgo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 13:36:44 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB20A23BE2
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 10:35:00 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id bi12so36652905ejb.3
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 10:35:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sweetwater-ai.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zL8Qb+2gKSP2c6o2DRoz5Oq4k0aSHrt0NlsFQOW67pQ=;
        b=BOgBq3juIQwFAKc4hAgJLiwRVOGTVSjvDHh2EK3sajCMpKygdODuNG6y0+hFSGcaIa
         Qd65rAj2ejL1UlKrdXnPIYCSdl5FyHF3g03b+Lwu4dELr+S96YdQFMNjyj35bTCudeEB
         QIB3gvuBYc+WW9XsLaUUJYFYbAySfwsthCKyjVOxbfpmGSqOuVsUctRimJM/qCWaL8CU
         lduSPE9cjjqAbeT4cWjwOl4lk3JeOglENj0yWdD352QfnyyZxmUaJa7rbMCD4F/dvB5h
         Eq7VgIvB0cERyEEMpXzhbtfhQGlrNuTziQvpiNbqJhYt7s5mZWXKiuFu7curSqEWctvM
         scng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zL8Qb+2gKSP2c6o2DRoz5Oq4k0aSHrt0NlsFQOW67pQ=;
        b=dYAzShMWkQiKCYIAL658bEn8mU3/zJUTybU2AxAapW5pgT+E1Cuc1ubeI1F5hREbTC
         R8VLetyMQDMnagD3kyyA+9HcgvCXs3HpAxwaIg4O3308IfxkDMuuBCFmxXAxg3HjHIuj
         lhiDnYA5MlXWQi44f67SaqeyDUfqHB6069JYXcRZtooLUfBMAlySeizuarqKnL9UyOlT
         wqe/wOvuwnH9ij3AxtqCc90FY7Ts4/ppJ+jFoUhPEP2+4CfcJol1ndoHKJoQH9CDgBYD
         9+x24WFoEmfetwBV11E9dYzarsVVNgjc1Gu10bILT7kzFdcwJDM1UlOxJZD2bZ7MDRZi
         /plQ==
X-Gm-Message-State: AOAM533o87ibiqZBA5RVdbBi5NuXlZsEak78M0CtfVuBZ2fk5SdvOV9g
        m9flumPK39WPGthwEeYKuieLuVV6etfLOrhdEehebA==
X-Google-Smtp-Source: ABdhPJzRQY6KZHmBGeWvlLVF+akUYt2iHYoWgMy/f3hjH6kMin6Jwj0Cd/JjJv1GykQD/uqIwQKGWmhz+xmGyNO2+Mg=
X-Received: by 2002:a17:907:3e16:b0:6df:b4f0:5cc2 with SMTP id
 hp22-20020a1709073e1600b006dfb4f05cc2mr35937852ejc.285.1648575299439; Tue, 29
 Mar 2022 10:34:59 -0700 (PDT)
MIME-Version: 1.0
References: <20220328111828.1554086-1-sashal@kernel.org> <20220328111828.1554086-16-sashal@kernel.org>
 <YkH5mhYokPB87FtE@google.com> <YkMoCe+uX6UxfaeM@mit.edu>
In-Reply-To: <YkMoCe+uX6UxfaeM@mit.edu>
From:   Michael Brooks <m@sweetwater.ai>
Date:   Tue, 29 Mar 2022 10:34:49 -0700
Message-ID: <CAOnCY6TNVHLX06mvMZFnNwVx3yE20qnqeGY7fbTx4c2XbyVVEw@mail.gmail.com>
Subject: Re: [PATCH AUTOSEL 5.17 16/43] random: use computational hash for
 entropy extraction
To:     "Theodore Ts'o" <tytso@mit.edu>
Cc:     Eric Biggers <ebiggers@google.com>,
        Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jean-Philippe Aumasson <jeanphilippe.aumasson@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I agree with Ted,  this patch is just to start the discussion on how
we can safely remove these locks for the improvement of safety and
security.  Both boot and interrupt benchmarks stand to benefit from a
patch like this, so it is worth a deep dive.

Feedback welcome, I am always looking for ways I can be a better
engineer, and a better hacker and a better person. And we are all here
to make the very best kernel.

Regards,
Micahel

On Tue, Mar 29, 2022 at 8:39 AM Theodore Ts'o <tytso@mit.edu> wrote:
>
> On Mon, Mar 28, 2022 at 06:08:26PM +0000, Eric Biggers wrote:
> > On Mon, Mar 28, 2022 at 07:18:00AM -0400, Sasha Levin wrote:
> > > From: "Jason A. Donenfeld" <Jason@zx2c4.com>
> > >
> > > [ Upstream commit 6e8ec2552c7d13991148e551e3325a624d73fac6 ]
> > >
> >
> > I don't think it's a good idea to start backporting random commits to random.c
> > that weren't marked for stable.  There were a lot of changes in v5.18, and
> > sometimes they relate to each other in subtle ways, so the individual commits
> > aren't necessarily safe to pick.
> >
> > IMO, you shouldn't backport any non-stable-Cc'ed commits to random.c unless
> > Jason explicitly reviews the exact sequence of commits that you're backporting.
>
> Especially this commit in general, which is making a fundamental
> change in how we extract entropy.  We should be very careful about
> taking such changes into stable; a release or two of additonal "soak"
> time would be a good idea before these go into the LTS releases in particular.
>
>                                           - Ted
