Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0F5748A584
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 03:23:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346556AbiAKCXF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 21:23:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239445AbiAKCXE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 21:23:04 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA9AFC06173F
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 18:23:03 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id c71so49786830edf.6
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 18:23:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VDFF6vcwE/TPS4Bt0jt6DdR/lz4gZprEiARRzw5a6Io=;
        b=dJDgY15gVyHjJT/hG1Aj8S+rnxUuUkTSco0i4Zn3r+05ajdLaK9tNqk0tN5/w79pm4
         TVTwm7UzrvGzsqw1IHEx42V1ZvgeO26COuPrXlqA/Ap7orFBU4WfHPAqYCWNVlJPYMmo
         9BuDDZRgWcpPZH1lr19ZH6e6VF87hE6uN/Ewg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VDFF6vcwE/TPS4Bt0jt6DdR/lz4gZprEiARRzw5a6Io=;
        b=wK/GJt3QeBPHCksMHFJAKJ4oKHQOjIk1oqEW2egJsQza/FSsQNcIDnFW5cmInL2FWX
         saDFLhfkHsXNi5WLlYeX+4dUdjpEEnBf2HBQ15uL1xRzIbN4MjFt+y2z0kS155Rj1sID
         ljo8vRl6bPPqKLXpOMBAyzM9uL6hE+RHfmUPxTVJOc3Dg6LVXoKftyQ1NtWGz8+aHJbk
         zpEieBXMYJkcabRAC8qzj5q2LP1/EDxjcgZR9Ft3JbWqe43ODB8SY6NKFN6yvJdbHooy
         OG35LLO9CWK1h8ag/p/ZuUq6euXUgcUDIqax6A6CIKYhUkgBHh7mUshV7qgOesJyXM0X
         pjNA==
X-Gm-Message-State: AOAM530L1FzpUjD5jokCprvjb+S7WZ+wShLeK+17ZSfA9dAX4NQs8/5h
        /DYcKmK0S66mah8h+w950IAlVYe8YqUhYMa/lcg=
X-Google-Smtp-Source: ABdhPJyO8l4jcE/oRYUQNF/S6NwkTKL4mfgYQnhZez2h+2yVmB+Pg1Cd8sfl6j3qjLXWhDtRnycJfQ==
X-Received: by 2002:a17:906:d555:: with SMTP id cr21mr2006735ejc.299.1641867782200;
        Mon, 10 Jan 2022 18:23:02 -0800 (PST)
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com. [209.85.221.54])
        by smtp.gmail.com with ESMTPSA id c12sm4508118edx.80.2022.01.10.18.23.01
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Jan 2022 18:23:01 -0800 (PST)
Received: by mail-wr1-f54.google.com with SMTP id k30so12681996wrd.9
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 18:23:01 -0800 (PST)
X-Received: by 2002:adf:f54e:: with SMTP id j14mr1838192wrp.442.1641867780948;
 Mon, 10 Jan 2022 18:23:00 -0800 (PST)
MIME-Version: 1.0
References: <CAPM=9tz=_hRpQV1V3M-=KmVVEbr1K166qeb-ne64PHk9Sn-ozg@mail.gmail.com>
 <CAHk-=wg9hDde_L3bK9tAfdJ4N=TJJ+SjO3ZDONqH5=bVoy_Mzg@mail.gmail.com>
 <CAKMK7uEag=v-g6ygHPcT-uQJJx+5KOh2ZRzC2QtM-MCjjW67TA@mail.gmail.com>
 <CADnq5_P9n39RQ5+Nm8O=YKXXvXh1CEzwC2fOEzEJuS2zQLUWEw@mail.gmail.com>
 <CAHk-=wgDGcaRxUwRCR6p-rxDVO78Yj4YyM6ZsPRGiT2JOCoQ6A@mail.gmail.com>
 <CADnq5_OYO7kq+9DBnDvbSfpouFvdLB0LPSL6+f1ZPRBsV=qEqA@mail.gmail.com> <CAHk-=wiCCRG9Lwzr+Cur=K1V2GJ9ab_ket7EnG4RZhJ8jJM7xQ@mail.gmail.com>
In-Reply-To: <CAHk-=wiCCRG9Lwzr+Cur=K1V2GJ9ab_ket7EnG4RZhJ8jJM7xQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 10 Jan 2022 18:22:44 -0800
X-Gmail-Original-Message-ID: <CAHk-=wi8b-YKHeNfwyYHMcgR2vJh4xpSZ0qjkv8E8Y9V8Sv2Tg@mail.gmail.com>
Message-ID: <CAHk-=wi8b-YKHeNfwyYHMcgR2vJh4xpSZ0qjkv8E8Y9V8Sv2Tg@mail.gmail.com>
Subject: Re: [git pull] drm for 5.17-rc1 (pre-merge window pull)
To:     Alex Deucher <alexdeucher@gmail.com>
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        "Wentland, Harry" <harry.wentland@amd.com>,
        Dave Airlie <airlied@gmail.com>,
        "Koenig, Christian" <christian.koenig@amd.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 10, 2022 at 5:21 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> I'll see if I can bisect it at least partially.

It seems to be very reliable. I can see the flickering even at early
boot before gdb has started - the graphical screen where you type the
encrypted disk password at boot already shows it as you type.

Right now it is

  bad: 9602044d1cc12280e20c88885f2cd640ae80f69e
  good: 3867e3704f136beadf5e004b61696ef7f990bee4

so it's going to be one of these:

  9602044d1cc1 drm/amd/display: Fix for the no Audio bug with Tiled Displays
  a896f870f8a5 drm/amd/display: Fix for otg synchronization logic
  aba3c3fede54 drm/amd/display: Clear DPCD lane settings after repeater training
  9311ed1e1241 drm/amd/display: add hdmi disable debug check
  6421f7c750e9 drm/amd/display: Allow DSC on supported MST branch devices
  ebe5ffd8e271 drm/amd/display: Enable P010 for DCN3x ASICs
  c022375ae095 drm/amd/display: Add DP-HDMI FRL PCON Support in DC
  50b1f44ec547 drm/amd/display: Add DP-HDMI FRL PCON SST Support in DM
  81d104f4afbf drm/amdgpu: Don't halt RLC on GFX suspend
  fe9c5c9affc9 drm/amdgpu: Use MAX_HWIP instead of HW_ID_MAX
  370016988665 drm/amdgpu: fix the missed handling for SDMA2 and SDMA3
  6c18ecefaba7 drm/amdgpu: declare static function to fix compiler warning
  94a80b5bc7a2 amdgpu/pm: Modify implmentations of
get_power_profile_mode to use amdgpu_pp_profile_name

and I guess I'll do the few more bisections to pick out the exact one.

             Linus
