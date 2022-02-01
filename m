Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 533724A589A
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 09:38:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235571AbiBAIiw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 03:38:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235563AbiBAIiu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 03:38:50 -0500
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B0D8C061714
        for <linux-kernel@vger.kernel.org>; Tue,  1 Feb 2022 00:38:50 -0800 (PST)
Received: by mail-oi1-x229.google.com with SMTP id u13so15688486oie.5
        for <linux-kernel@vger.kernel.org>; Tue, 01 Feb 2022 00:38:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GaNMBS8erWAUdjZRyVjICW/2VNsiklNXAamHHGSoKQU=;
        b=HABYAYhUrYZjmmyqCihiIlAUb0ufUo8qHSInxKtuQBJMtUSoTtIMq5LhxK09AevQU3
         o85MeHKnBAV19IFBL44gSC/conhVnm5Za9cn2P0v0T3KcfcX+maC+A+WnLIOBaSwJzL8
         mZijpnqkky9MAhwFlW2m8M2UauTJQ+cHbAgpE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GaNMBS8erWAUdjZRyVjICW/2VNsiklNXAamHHGSoKQU=;
        b=MlgsrpekgvR591yIJWr4LVnMgYlKCnDvbKPIwBP8CKEuFoCNsgUZsOyK7wgGKt8Mel
         l9MxOB5gRiY6dtv1bNkY5XasiHP4w3+5uWsI6hO9dxR4k05z49y/Y7ThdPZvFY4GBUsd
         ieS5KbwuyUAHQxQMyNKlDtQwwwCpodcruqE/UB6RgRYYG36h85joQFNCkoi8Ug0XreB7
         lB05a0P0YdEJkJ7FRXYOqM2hmbzGxBXsI9AWbr2dZzU+/cq1K2T3UBOc4cX+mVEtZvCr
         zhfSJ2fpJ1JYXxVkPw2Eze8aK1qPDylcNHPFIt8Qe6KuhhlibW2fSr15GpSjIkPDxoZE
         bYkg==
X-Gm-Message-State: AOAM531TzQIMFVsqIe9iBDuxuf8YMBBlHCnYX21Gu8Aw7PfbhhD3fQLJ
        m82Qz+xUQVPIFJWMM13Vh8MTa7jLRA0a+4e/QoO7YA==
X-Google-Smtp-Source: ABdhPJziRYIIAKS82JUTrBVu7riWjIYtqJDF+RJ45wmejZddSiqO3gkTl5ef/yc3pbMhI2xP1ibF0MrIHBEZx8oHtXk=
X-Received: by 2002:a54:4803:: with SMTP id j3mr521011oij.279.1643704729863;
 Tue, 01 Feb 2022 00:38:49 -0800 (PST)
MIME-Version: 1.0
References: <20220131201225.2324984-1-javierm@redhat.com> <tIMIWqepcZGntnez-1ss4Kn4K8btXnzDRL7EWd19-745WK90YIC19E_4di9RNvB3gtx-PzWEjBEGQLPNJE_x0T1yyyaWFCoFcCiG4StR9RU=@emersion.fr>
 <wuXPJN-K-rvjoV51c4EBmTBScov8rcJTPoYmlfHe04_-4wD1khVxo9HnUsP7UFd5m4AkzGSw2hXe_c77jbSRhjEJ0JZIYwuvuIkcv_KsR-Y=@emersion.fr>
 <CAMuHMdXKZ=BkvVqdpiNPNJgxm9SzQ3Z0n4SqV2-4oPRveybd6g@mail.gmail.com> <qmhzv6kqs6QdAOP3bNB39glOpc8eeJ6flgjfjcaBniT-shDKZkxo5uB71weGOUKxPE6dq_WBhtHmY5vMmuYwqMoHgtMWnX0ESE5R1Y5g5F8=@emersion.fr>
In-Reply-To: <qmhzv6kqs6QdAOP3bNB39glOpc8eeJ6flgjfjcaBniT-shDKZkxo5uB71weGOUKxPE6dq_WBhtHmY5vMmuYwqMoHgtMWnX0ESE5R1Y5g5F8=@emersion.fr>
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
Date:   Tue, 1 Feb 2022 09:38:38 +0100
Message-ID: <CAKMK7uGPuhrDf8fdDgfuPt5rzO30Rm54T7GvWb203NRbVoVDgw@mail.gmail.com>
Subject: Re: [PATCH 0/4] drm/tiny: Add driver for Solomon SSD1307 OLED displays
To:     Simon Ser <contact@emersion.fr>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PWM List <linux-pwm@vger.kernel.org>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Mark Brown <broonie@kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        =?UTF-8?Q?Noralf_Tr=C3=B8nnes?= <noralf@tronnes.org>,
        Maxime Ripard <maxime@cerno.tech>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Lee Jones <lee.jones@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 1, 2022 at 9:34 AM Simon Ser <contact@emersion.fr> wrote:
>
> On Tuesday, February 1st, 2022 at 09:26, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> > What's the story with the Rn formats?
> >
> > The comments say "n bpp Red", while this is a monochrome (even
> > inverted) display?
>
> I don't think the color matters that much. "Red" was picked just because it was
> an arbitrary color, to make the difference with e.g. C8. Or am I mistaken?

The red comes from gl, where with shaders it really doesn't matter
what meaning you attach to channels, but really just how many you
have. So 2-channel formats are called RxGx, 3-channel RxGxBx,
4-channel RxGxBxAx and single-channel Rx. And we use drm_fourcc for
interop in general, hence why these exist.

We should probably make a comment that this really isn't a red channel
when used for display it's a greyscale/intensity format. Aside from
that documentation gap I think reusing Rx formats for
greyscale/intensity for display makes perfect sense.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
