Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C7A848B8E5
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 21:52:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235623AbiAKUwP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 15:52:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235132AbiAKUwE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 15:52:04 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A54DC028BF0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 12:51:43 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id b13so1448223edn.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 12:51:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PJOwhp3ym4DBH3RV0e5Fa2srd2TuQC5f+y1GIJOJymg=;
        b=Poqh7tlps0nmydJNHuTFFz+1v91n9FBjuZDF9S/cEn3/lSPJU4mRgLKzcVJ9y2szxK
         w3QHdSzWPsF4aFUX1EWxGT3ZSvos+xqomNwyXjbgIrXwlEUEiTBA8POYMyy8nXDbHfJe
         utQNYyrqtWyiR/ZNc+DKBtuKMA5VAvLH46Wag=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PJOwhp3ym4DBH3RV0e5Fa2srd2TuQC5f+y1GIJOJymg=;
        b=BvI/VrhFvVVI16bCz+M/Ujt/p10aDu0SfhjL3mshf+3e2EuqYB05DHwtjZDPb59FnH
         wanQGW0WU8wpSsZlJQl2D8gIFbBLztcDqwIElCz05xeciD2SuUfQ3137sGae4C7Ge/MF
         G0kq91blIucMjDZRzO8lVQ8jH1rhRfZ6ZQspBXdbyZ1p9UQ62W4zU6JyL/HGPz4Gc6wY
         J6bN4zfTjjDpbepr2wyh4zR9AAOeWuIIGYmRnOEl57PUUROmVuMN2kX+4k4fiQGW3gX5
         Jip+a1MvwKeWAWQxJPdvOZvOoXCdAx3bLUg/ssvaeuC6EOMTuklN+5WCIntnuXDGTF8p
         8oDg==
X-Gm-Message-State: AOAM5330bU6CI/700738qTgN/OezDCT1JHfS3R5cFGBKDCy8rxSbWjMG
        DFYgNOR71pFSJxYZk8Sv0WhmkHLG/NAAI24D+9I=
X-Google-Smtp-Source: ABdhPJy+qFVNpzIoyqtoueQlQ/Y71wlKpknzIiY6cGnD02g2MXZAtkZKn88pHB+xzfEtpqNd8gQjrQ==
X-Received: by 2002:a05:6402:518a:: with SMTP id q10mr5865593edd.29.1641934301646;
        Tue, 11 Jan 2022 12:51:41 -0800 (PST)
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com. [209.85.221.54])
        by smtp.gmail.com with ESMTPSA id ho9sm3892316ejc.86.2022.01.11.12.51.35
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Jan 2022 12:51:38 -0800 (PST)
Received: by mail-wr1-f54.google.com with SMTP id d19so571656wrb.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 12:51:35 -0800 (PST)
X-Received: by 2002:a5d:6083:: with SMTP id w3mr1799927wrt.281.1641934295380;
 Tue, 11 Jan 2022 12:51:35 -0800 (PST)
MIME-Version: 1.0
References: <CAPM=9tz=_hRpQV1V3M-=KmVVEbr1K166qeb-ne64PHk9Sn-ozg@mail.gmail.com>
 <CAHk-=wg9hDde_L3bK9tAfdJ4N=TJJ+SjO3ZDONqH5=bVoy_Mzg@mail.gmail.com>
 <CAKMK7uEag=v-g6ygHPcT-uQJJx+5KOh2ZRzC2QtM-MCjjW67TA@mail.gmail.com>
 <CADnq5_P9n39RQ5+Nm8O=YKXXvXh1CEzwC2fOEzEJuS2zQLUWEw@mail.gmail.com>
 <CAHk-=wgDGcaRxUwRCR6p-rxDVO78Yj4YyM6ZsPRGiT2JOCoQ6A@mail.gmail.com>
 <CADnq5_OYO7kq+9DBnDvbSfpouFvdLB0LPSL6+f1ZPRBsV=qEqA@mail.gmail.com>
 <CAHk-=wiCCRG9Lwzr+Cur=K1V2GJ9ab_ket7EnG4RZhJ8jJM7xQ@mail.gmail.com>
 <CAHk-=wi8b-YKHeNfwyYHMcgR2vJh4xpSZ0qjkv8E8Y9V8Sv2Tg@mail.gmail.com>
 <CAHk-=whnWnB9yjVaqWNKjavSJxDOEbTAPwef=O7qjL8nKZgV6A@mail.gmail.com>
 <CAHk-=whSAYiO_TkKut6XckdQigFj39ft1Kcs2qJe5niHWPGdwg@mail.gmail.com>
 <CADnq5_OZR9Ft=WVVbpM_WUpFZurni4yVxGPpa4nDkhupmod_ag@mail.gmail.com> <6490ec74-7de2-c3a3-d852-31b8594110d8@amd.com>
In-Reply-To: <6490ec74-7de2-c3a3-d852-31b8594110d8@amd.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 11 Jan 2022 12:51:19 -0800
X-Gmail-Original-Message-ID: <CAHk-=whZW+Cy++vucKQd6Lrj7B1bhd1-pKkgV8xxPJr35Dh2UA@mail.gmail.com>
Message-ID: <CAHk-=whZW+Cy++vucKQd6Lrj7B1bhd1-pKkgV8xxPJr35Dh2UA@mail.gmail.com>
Subject: Re: [git pull] drm for 5.17-rc1 (pre-merge window pull)
To:     Harry Wentland <harry.wentland@amd.com>
Cc:     Alex Deucher <alexdeucher@gmail.com>, Jun Lei <Jun.Lei@amd.com>,
        Mustapha Ghaddar <mustapha.ghaddar@amd.com>,
        Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>,
        meenakshikumar somasundaram <meenakshikumar.somasundaram@amd.com>,
        Daniel Wheeler <daniel.wheeler@amd.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Dave Airlie <airlied@gmail.com>,
        "Koenig, Christian" <christian.koenig@amd.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 11, 2022 at 7:38 AM Harry Wentland <harry.wentland@amd.com> wrote:
>
> Attached is a v2 of the buggy patch that should get this right.
> If you have a chance to try it out let us know

I can confirm that I do not see the horribly flickering behavior with
this patch.

I didn't look at what the actual differences were from the one I
reverted, but at least on my machine this version works.

                Linus
