Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61790475578
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 10:51:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241305AbhLOJvX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 04:51:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236419AbhLOJvW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 04:51:22 -0500
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7C7BC06173E
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 01:51:21 -0800 (PST)
Received: by mail-yb1-xb30.google.com with SMTP id g17so53501388ybe.13
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 01:51:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tFT9slFzR2Yf0j3yzAPs2dGyzL0oVYEo3K/VfvSACI8=;
        b=PzOIJV4Yjhq/PSV/T+fa0v+1hgjWHgeE6yJBgYxRqr+ZseW+QBtxyuFZXfZtcWhsOY
         7h5kOfpz2lh2bRXJHQw4XjbD2aW5AozdVTqMj2U8dMpxBDaEUo1Kq9ERzOctW0QyV3Ky
         CBxsbrJu0S7QLbVf+57RQPRZXr4EGpjJFqk0GR59q33rO4TVDsdDcht3F9mSWJEqSTUF
         ZEqwUnyChANbfawGpcIQfCmQ2JkCX2+WSfyzDpr/TqcYtzmwJ8koSdmcqSvzV1Mi2ALK
         qovQux4WZIS2IidFpLXCxy8/gN3ahMqWeEkzQVSddcmwvPD3n2dp68Ik43kyxjPRhrVk
         G+5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tFT9slFzR2Yf0j3yzAPs2dGyzL0oVYEo3K/VfvSACI8=;
        b=XxwmRB4f+0QZDNjtkbQHYPmFek04aDh/AHIATB0YcaE/P5Dd0ZWTQYVS4WfZNTpOBX
         a3gHHoDF7O5zx2vcpnR7cSakhAruEZdfadUAHEwZ3UOZoCYF14M/KXoKCwy8ZZ0wj7eX
         AWcHaPptVM4qhmyx7y/BiWjciE89mjmyNaBoVJ2R+tI5iyLNYWdvcTIVTrGwV+8LzLJN
         fZXVCVjsKM6V+XF8M9yeCQViYKKbnmKHLjZE/aTVSPtJMaVD1S85N2z6tuL275PjiaKy
         bMP9HOATeNuFfM88O5pZBK1mM/FXBZ7qJKCMhayCAm3b3g8GSMVdzzjyRKmCtNM/6kVj
         XB4g==
X-Gm-Message-State: AOAM53294mOuUMRWoD5DVJyjCsuSqbdf4fOHYuhvibwhWJ6gD0njCldF
        Zs7mOzGYRjGQcolqJAkpX0ly9QslH7fAvGg+9cTniw==
X-Google-Smtp-Source: ABdhPJxEcUv+QwNjP0pSGrF5WpKqx1mIIo85nwLnFmdOfBLktNHZo6YNCXbpOXqvbqVqj+IUJSZy9qZqfJ3eyTBVT9Q=
X-Received: by 2002:a25:df4f:: with SMTP id w76mr5399025ybg.711.1639561880366;
 Wed, 15 Dec 2021 01:51:20 -0800 (PST)
MIME-Version: 1.0
References: <0b6c06487234b0fb52b7a2fbd2237af42f9d11a6.1639560869.git.geert+renesas@glider.be>
In-Reply-To: <0b6c06487234b0fb52b7a2fbd2237af42f9d11a6.1639560869.git.geert+renesas@glider.be>
From:   Eric Dumazet <edumazet@google.com>
Date:   Wed, 15 Dec 2021 01:51:08 -0800
Message-ID: <CANn89iKdorp0Ki0KFf6LAdjtKOm2np=vYY_YtkmJCoGfet1q-g@mail.gmail.com>
Subject: Re: [PATCH -next] lib: TEST_REF_TRACKER should depend on REF_TRACKER
 instead of selecting it
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Jakub Kicinski <kuba@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 15, 2021 at 1:36 AM Geert Uytterhoeven
<geert+renesas@glider.be> wrote:
>
> TEST_REF_TRACKER selects REF_TRACKER, thus enabling an optional feature
> the user may not want to have enabled.  Fix this by making the test
> depend on REF_TRACKER instead.

I do not understand this.

How can I test this infra alone, without any ref_tracker being selected ?

I have in my configs

CONFIG_TEST_REF_TRACKER=m
# CONFIG_NET_DEV_REFCNT_TRACKER is not set
# CONFIG_NET_NS_REFCNT_TRACKER is not set

This should work.

I would not have sent patches built around ref_tracker if I had no
ways of testing the base infrastructure.



>
> Fixes: 914a7b5000d08f14 ("lib: add tests for reference tracker")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  lib/Kconfig.debug | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index c77fe36bb3d89685..d5e4afee09d78a1e 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -2114,8 +2114,7 @@ config BACKTRACE_SELF_TEST
>
>  config TEST_REF_TRACKER
>         tristate "Self test for reference tracker"
> -       depends on DEBUG_KERNEL && STACKTRACE_SUPPORT
> -       select REF_TRACKER
> +       depends on DEBUG_KERNEL && STACKTRACE_SUPPORT && REF_TRACKER
>         help
>           This option provides a kernel module performing tests
>           using reference tracker infrastructure.
> --
> 2.25.1
>
