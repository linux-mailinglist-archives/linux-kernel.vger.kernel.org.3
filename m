Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBB5B484F87
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 09:46:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238609AbiAEIq1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 03:46:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238594AbiAEIqL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 03:46:11 -0500
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BF45C061761;
        Wed,  5 Jan 2022 00:46:09 -0800 (PST)
Received: by mail-yb1-xb2c.google.com with SMTP id 139so84312778ybd.3;
        Wed, 05 Jan 2022 00:46:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yLB7IVB0dD9yr5YnGhjjp/a2jSmJoziesxnjCGMoDoY=;
        b=gAVBjNrmdb+d3COR6tf2hQ+x0SSML3S7ERiWKgpKItRITaD3VfmKJMUY5TtdlGLWGs
         wHZ6ILuHatqoSIfnAqQUrrv1+jddN8tdNNUlqsbklOOvZPsjI5PQUZi1AZf/7QB6qZh+
         9Gg+uH2Mx18SN5KLJ0vu2RCkWCBBY2aMSqkyxrDAF1pXvjBJnxp5p++NEArkVLiThp9c
         +Hg617J5FmXjDd9m1dWqkIxta13vliEqWsHXwTemoiKniatyAvWjCm/TJaNJx9U3zCkB
         Nq9LZO3a9EL4vKk40l/cgGa4B0zDGk9U2GUKcRcNRN7oRKCJtVNjJPWqPx0gv1q2BInB
         4uQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yLB7IVB0dD9yr5YnGhjjp/a2jSmJoziesxnjCGMoDoY=;
        b=QoMGsNIMWmnWQX0v9ntuv0xiiO6pJNHI6bTnqbCP0zeQnBoWQ2Cd6eU0f3mapl3lJW
         gr/wo9tWX8o0P9E7oOMpnN0OX2z6MAAEUENwgKeqK9oFSZ5bQXxpgrQMCcGPSgrCdu80
         ZmUSffhUzP+liC3vP1jx3YqtAyNLX8fGi+KXgSksMzaT8FQTIDNXMSyIKLiov5UyFeJm
         7NVvM6XTA8OR8MxXXu8u9TNic/aSvK1Cydcsg4ajqJwUcUaI3p8ONc9PJwu8PQQE5O0J
         6re4hFuZg1S2h2HhrQvTO3KBcdlneeWSG/q5ckrMhl/M4jm9c0l4Vp08Z0vupipNYrxK
         rkBQ==
X-Gm-Message-State: AOAM533W0eStVf4bVNztkWZZxCCHOt3W58FB5SJhmoys6WSUULmZi7mt
        eWL6h2IJhdfOUNFthGRgs0E57WHPa9nc3b2wmfI=
X-Google-Smtp-Source: ABdhPJxKZjdguPQpuQsvmAp5F1BhlZCZ6ebR5Bj5fxyFwSy+2/nGEQi7EBQlFxacNNdKDpomt4+Gd78R6DmVXO9YSf4=
X-Received: by 2002:a25:d44:: with SMTP id 65mr56328146ybn.510.1641372368709;
 Wed, 05 Jan 2022 00:46:08 -0800 (PST)
MIME-Version: 1.0
References: <cover.1641203216.git.linux@leemhuis.info> <7b71a1262b8b72d30154203bb14f00db7d4170ef.1641203216.git.linux@leemhuis.info>
 <CAKXUXMy-RT5kc5yzafQyxRQ1pfY2-K3KE9iAxFXvcB2o0V+ceQ@mail.gmail.com> <72fcaa40-5884-710f-58b6-bf40a1f58e57@leemhuis.info>
In-Reply-To: <72fcaa40-5884-710f-58b6-bf40a1f58e57@leemhuis.info>
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
Date:   Wed, 5 Jan 2022 09:45:57 +0100
Message-ID: <CAKXUXMwJU2vZp2C8Q6xEUCgKox2z_Qt5gH_UpSa5BJiVeRkoyg@mail.gmail.com>
Subject: Re: [RFC PATCH v1 1/2] docs: add a document about regression handling
To:     Thorsten Leemhuis <linux@leemhuis.info>
Cc:     "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        workflows@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 4, 2022 at 6:57 PM Thorsten Leemhuis <linux@leemhuis.info> wrote:
>
>
> On 04.01.22 15:17, Lukas Bulwahn wrote:
> > On Mon, Jan 3, 2022 at 3:23 PM Thorsten Leemhuis <linux@leemhuis.info> wrote:
> >>
> >> Create a document explaining various aspects around regression handling
> >> and tracking both for users and developers. Among others describe the
> >> first rule of Linux kernel development and what it means in practice.
> >> Also explain what a regression actually is and how to report them
> >> properly. The text additionally provides a brief introduction to the bot
> >> the kernel's regression tracker users to facilitate the work. To sum
> >> things up, provide a few quotes from Linus to show how serious the he
> >> takes regressions.
> >>
> >> [...]
> >
> > [lots of helpful suggestions for fixes and small improvements]
>
> Many thx, addressed all of them, not worth commenting on each of them
> individually.
>
>
> >> +What is the goal of the 'no regressions rule'?
> >> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >> +
> >> +Users should feel safe when updating kernel versions and not have to worry
> >> +something might break. This is in the interest of the kernel developers to make
> >> +updating attractive: they don't want users to stay on stable or longterm Linux
> >> +series either abandoned or more than one and a half year old, as `those might
> >> +have known problems, security issues, or other aspects already improved in later
> >> +versions
> >> +<http://www.kroah.com/log/blog/2018/08/24/what-stable-kernel-should-i-use/>`_.
> >> +
> > Maybe add something like this:
> >
> > A larger user community means more exposure and more confidence that
> > any critical bug introduced is likely to be found closer to the point
> > in time it was introduced, and hence the shipped kernels have less
> > critical bugs.
> >
> > Just to close the line of thought here.
>
> Hmmm. How about this instead:
>
> The kernel developers also want to make it simple and appealing for
> users to test the latest (pre-)release, as it's a lot easier to track
> down and fix problems, if they are reported shortly after being introduced.

Yes, your sentence conveys the same point and is much more down to
earth. My sentence looks much more "academic".

> > Okay, that is how far I got reading for now.
>
> Great, many thx for your help, much appreciated. FWIW, find below the
> current version of the plain text which contains a few more fixes. Note,
> thunderbird will insert wrong line breaks here.
>
> Ciao, Thorsten
>

All good, I will wait until the next version of this patch series shows up.

Lukas
