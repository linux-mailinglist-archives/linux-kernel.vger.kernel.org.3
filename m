Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D09D3493FD5
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 19:25:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347495AbiASSZM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 13:25:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356718AbiASSZK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 13:25:10 -0500
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08B11C061574
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jan 2022 10:25:10 -0800 (PST)
Received: by mail-yb1-xb30.google.com with SMTP id c6so10114713ybk.3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jan 2022 10:25:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qhZUjSqSQkfhZLoYn5e7bhCr/SYhnGpXe4Qg5Zbv7IY=;
        b=KcjIc7Fy7AyXlztjvbf4TXqfnkrciDNXOMtpFzvtF3QorWdBdCJcZNxXQir+xqCgM/
         vhWvU4puaDNNHZIf8tBZKxSuEwQBcTPRaILKpqqMlp0EO0agvObWm58HneQ/F52afxd+
         6yk9sB6uJI4kgfYa9xXzLl1IhZoi8Xr/g+mGUrRUzF3gyQ9ppLz97Lc6tXjX5m/whFY+
         ECRNg2HIhE2665MiG3OSXjnIgdouodrSJyK4mwNzw4KfTZvN2jBb+EzlnKNLhNJrQzDp
         62ZPButvLcfnCM8PWDujKudROIKqyKSbycC36/wmwUvk0cT2ZnfhnIf8hQfmUytuiq2F
         Dvuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qhZUjSqSQkfhZLoYn5e7bhCr/SYhnGpXe4Qg5Zbv7IY=;
        b=WRvdQqpmHrlLy29w6diQ6uIixp+9mJj76QcA/WuqitbIXoDrdQHPDV570xwKqaWYiX
         T2VFFenJzSfa51OXj3F8FUW+6oPikX1aPPNJ4qN0kU8YGXCa2ppfe9sD1BBOPP5PyNSh
         KskWeP81kWdBBvo9W9WnxQiuJqP7RhTZT9FkdnOVFyoCL/RpwURgTgeXg6o4gKCTTqdJ
         BcNRqylT8QPj0x51ZK3a7/fF9pJ7uCfrwnFMpGzOganx3Yc1mvlRPw4fw0PcBsNBfaXt
         oxTVUw0fHx17OTwoO67SyQBk9xFR2TUJmcm+1NOla0b4035FonGMEuDdUGSLrm/ZgGwJ
         80fw==
X-Gm-Message-State: AOAM5337LDT6Bd5QCqEujlSIwmZBm9PHMehn4darVJRLz507VyrGr+nU
        Grf518nRHdP6qElWxHUknLl6cV+PmheHUUAixys4yA==
X-Google-Smtp-Source: ABdhPJyn4giiiq8ubwJREn+9rcxttcLhxnSzBFBbGPyp4Qw1J6vVVbQT+Fu9+AYAHNXgggW+6+BF7t8OrokPelbULGw=
X-Received: by 2002:a5b:586:: with SMTP id l6mr28353208ybp.322.1642616709101;
 Wed, 19 Jan 2022 10:25:09 -0800 (PST)
MIME-Version: 1.0
References: <20220115010622.3185921-1-hridya@google.com> <20220115010622.3185921-3-hridya@google.com>
 <aea5b741-c994-4007-156e-d8a3a5b9bbcc@infradead.org>
In-Reply-To: <aea5b741-c994-4007-156e-d8a3a5b9bbcc@infradead.org>
From:   Hridya Valsaraju <hridya@google.com>
Date:   Wed, 19 Jan 2022 10:24:33 -0800
Message-ID: <CA+wgaPNqXSCxhby8xzQGCZ-GGJQ475Nx==ki63=DR_i25P_PiA@mail.gmail.com>
Subject: Re: [RFC 2/6] cgroup: gpu: Add a cgroup controller for allocator
 attribution of GPU memory
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Christian Brauner <christian@brauner.io>,
        Suren Baghdasaryan <surenb@google.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Liam Mark <lmark@codeaurora.org>,
        Laura Abbott <labbott@redhat.com>,
        Brian Starkey <Brian.Starkey@arm.com>,
        John Stultz <john.stultz@linaro.org>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Dave Airlie <airlied@redhat.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Matthew Auld <matthew.auld@intel.com>,
        Matthew Brost <matthew.brost@intel.com>,
        Li Li <dualli@google.com>, Marco Ballesio <balejs@google.com>,
        Hang Lu <hangl@codeaurora.org>,
        Wedson Almeida Filho <wedsonaf@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Vipin Sharma <vipinsh@google.com>,
        Chris Down <chris@chrisdown.name>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Vlastimil Babka <vbabka@suse.cz>,
        Arnd Bergmann <arnd@arndb.de>, dri-devel@lists.freedesktop.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
        cgroups@vger.kernel.org, Kenny.Ho@amd.com, daniels@collabora.com,
        kaleshsingh@google.com, tjmercier@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 19, 2022 at 7:40 AM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> Hi--
>
> On 1/14/22 17:06, Hridya Valsaraju wrote:
> > diff --git a/init/Kconfig b/init/Kconfig
> > index cd23faa163d1..408910b21387 100644
> > --- a/init/Kconfig
> > +++ b/init/Kconfig
> > @@ -990,6 +990,13 @@ config BLK_CGROUP
> >
> >       See Documentation/admin-guide/cgroup-v1/blkio-controller.rst for more information.
> >
> > +config CGROUP_GPU
> > +       bool "gpu cgroup controller (EXPERIMENTAL)"
> > +       select PAGE_COUNTER
> > +       help
> > +     Provides accounting and limit setting for memory allocations by the GPU
> > +     and GPU-related subsystems.
>
> Please follow coding-style for Kconfig files:
>
> (from Documentation/process/coding-style.rst, section 10):
>
> For all of the Kconfig* configuration files throughout the source tree,
> the indentation is somewhat different.  Lines under a ``config`` definition
> are indented with one tab, while help text is indented an additional two
> spaces.

Thanks Randy, sounds good! Will fix it in the next version!

>
>
> thanks.

>
> --
> ~Randy
