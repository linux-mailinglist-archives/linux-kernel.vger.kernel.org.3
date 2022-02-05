Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 325E44AAAFE
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Feb 2022 19:42:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380972AbiBESmt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Feb 2022 13:42:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231970AbiBESms (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Feb 2022 13:42:48 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CED0CC061348
        for <linux-kernel@vger.kernel.org>; Sat,  5 Feb 2022 10:42:47 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id s13so29577218ejy.3
        for <linux-kernel@vger.kernel.org>; Sat, 05 Feb 2022 10:42:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Yedd43eoRIQVyiayOZs+IHIZcg34X3iy8HzQvrX9+vc=;
        b=hJAo4nCSeYMJ9Z1J9DLNxUS3UWhozfpff6fWvdKoMHKOHVRLCUA9T84HiX8JsPuWD+
         zlF7puaUJnJzD2sBbcdSHRZKQXScVFP+1RPq1+bhEyQ6TSceYhr3Kc1o0sz0eIcKdXmQ
         Q09O3kCl53O/XzGFDSeS63WviWTSewwSwtZpw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Yedd43eoRIQVyiayOZs+IHIZcg34X3iy8HzQvrX9+vc=;
        b=Rd5GDLb/VxzAbbtlwtBKeC1VPzKOiO4RZN2WYPpUQrcn/yfnWfe3fBtTkOUDAoD1os
         GpnjYbb1xsVKoaMT6mXQWYsUtP1RjYGMsTGFcSycr8NZETbuC/hqbKEZwJ2ERAD4TMLV
         nnxuPc5J1A60RwNUIWYh0eYLiWaY7Jf+0HFOkzeW2b+69G93kjPNoP9twayRR/o/xNnt
         ixiPQHR/5oiX3PSWXxBNCmtWIE7DO5cdKXs7+PvYVW2a+2fUNCaFUsj2XcJgDXeYOVZf
         F3stm5txlNzvAPJVCwDgVEEoHa+iycJg8GkIMZgHxBhFy9IHMS5F4b7ogsShq89nrkGZ
         f9NQ==
X-Gm-Message-State: AOAM533hxbprNIt7n27/AyqwevkF7/NeaiOV7fsNhi2Ys4O3rXlrVGC9
        1TB1dDGwxGL1AAtyIcGW7AbjBeTQ7tbgtVNA
X-Google-Smtp-Source: ABdhPJxJFrgacLUw9p23ocwxnMRQC7cxHTaPPvWHzzIEHFxwMqxQoZPuwCr7YWQ656/bRxJ2NgqZSQ==
X-Received: by 2002:a17:906:25cb:: with SMTP id n11mr4012293ejb.419.1644086566301;
        Sat, 05 Feb 2022 10:42:46 -0800 (PST)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com. [209.85.128.53])
        by smtp.gmail.com with ESMTPSA id v16sm1856222ejo.156.2022.02.05.10.42.45
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 05 Feb 2022 10:42:45 -0800 (PST)
Received: by mail-wm1-f53.google.com with SMTP id r7so6914699wmq.5
        for <linux-kernel@vger.kernel.org>; Sat, 05 Feb 2022 10:42:45 -0800 (PST)
X-Received: by 2002:a05:600c:3846:: with SMTP id s6mr7597505wmr.26.1644086565037;
 Sat, 05 Feb 2022 10:42:45 -0800 (PST)
MIME-Version: 1.0
References: <20220205110717.16946-1-jgross@suse.com> <CAHk-=wjp-h4bFWsWSPQ+5o6iuiPwiFNRNxfDSaDjURzVU6Af7A@mail.gmail.com>
In-Reply-To: <CAHk-=wjp-h4bFWsWSPQ+5o6iuiPwiFNRNxfDSaDjURzVU6Af7A@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 5 Feb 2022 10:42:29 -0800
X-Gmail-Original-Message-ID: <CAHk-=wj_ObnioAixXdec63_aXXaS8SUEAsMQgfiHwhXNOYMn5Q@mail.gmail.com>
Message-ID: <CAHk-=wj_ObnioAixXdec63_aXXaS8SUEAsMQgfiHwhXNOYMn5Q@mail.gmail.com>
Subject: Re: [GIT PULL] xen: branch for v5.17-rc3
To:     Juergen Gross <jgross@suse.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        xen-devel@lists.xenproject.org,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>
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

On Sat, Feb 5, 2022 at 9:58 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Sat, Feb 5, 2022 at 3:07 AM Juergen Gross <jgross@suse.com> wrote:
> >
> > Please git pull the following tag:
> >
> >  git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git for-linus-5.17a-rc3-tag
>
> Diffstat? Shortlog?
>
> This is not a valid pull request.

Oh well. You're likely offline - I ended up just checking your
description instead.

But in general I really do want shortlog and diffstat as a way to
double-check that the pull contains what you think and claim it does,
and there are no surprises..

               Linus
