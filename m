Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84B524B5AD3
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 21:07:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229751AbiBNUDi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 15:03:38 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:35486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbiBNUDf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 15:03:35 -0500
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F106510F20D
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 12:03:17 -0800 (PST)
Received: by mail-yb1-f177.google.com with SMTP id j2so49686605ybu.0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 12:03:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=EBOPhqSf+aywWxhUqpiwT6NM6RUx7mAerBj7xaF4Kxk=;
        b=qqO3lcD+cemdiR+mXW04vHX6a84DDvxfqa3p1ElfyL7Az/3/hsz4DHtC0bT5Yk7bgc
         INz5aMjx/fsdmICmRWrJswQ4SGCwyu1FXzE6zfxapPHAaNVwXwzEpw+Qlp5wGWWjMIl6
         o/xV5PMrldoKsPnq/3NEeEI97fMyQ3TWtMaxWYZLb6dU49Gd7NMjBp/vhDPcTpI4Qq99
         td/j/ORxFAlhA7kxpiv77vhZ3RYK8VFWwkPO/D5yEPMgaGSQj5u63nO/4hWCd0fiZBzl
         tugxlyFWyrfblP5Z1lOJ5ZHvPXW9pkG1BfPNwfh7VMvsIU30MOa8GBcPrSUI1SwC1ruA
         Ffpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=EBOPhqSf+aywWxhUqpiwT6NM6RUx7mAerBj7xaF4Kxk=;
        b=BJRUXSTHZMVVtgEc1zNRUOR0GotAPSLQkFAI5hpp/PhloJ++5xyaySG789aUhfLMVr
         5d3/rt6XyQwQWzGGN7LR+GzQyX3Sqz8dKQsVfY8qKIlbbiL9CygbbXZeglj+g/V+CqEV
         o+kjtf70g5Hw0/9DMx2asiEP7ZdlrO9qTQTeyVkN/xgrSLxuTk0ZFBh/RI9CnEsTqD50
         pOZTtFNcVBgxX7AZt384nuyVh3aGHHtKk7IJeJN5PR/1PllMHY7DF/Yrri90XWxyi4BM
         4/0ktdr6E/FYZnVGzlZAbNQfvCACzdK7sa0OLHN6w9lGHNkQ3zXPrfFZZ2zOwodg+qzo
         ikPQ==
X-Gm-Message-State: AOAM530rJMrQvI+2sdY0WPPD2qunHjt7umlaunzr9XrDgIdlVwa/0dgw
        ZTL3sd5iafnMtjYIoTiCUrPOlTnad4EJrkbla84=
X-Google-Smtp-Source: ABdhPJwX1fQ9ooMynxhV+ZrSEHGFOuJ0zg+b9O+K7gr/d7kRmT6xVhPHiGTrk1wl/8FC9OBbmpm+FeVkqtr7K5Jd3Ng=
X-Received: by 2002:a25:148b:: with SMTP id 133mr724420ybu.270.1644868706855;
 Mon, 14 Feb 2022 11:58:26 -0800 (PST)
MIME-Version: 1.0
References: <20220213065106.48062-1-ztong0001@gmail.com> <YglQW7gVNoRJ7QpQ@dev-arch.archlinux-ax161>
In-Reply-To: <YglQW7gVNoRJ7QpQ@dev-arch.archlinux-ax161>
From:   Tong Zhang <ztong0001@gmail.com>
Date:   Mon, 14 Feb 2022 11:58:16 -0800
Message-ID: <CAA5qM4AMf0Tzdsm3jX5_gVw0Uh3d5DwqFB0PGTvsfEwL-v4Nhw@mail.gmail.com>
Subject: Re: [PATCH] drm/i915: fix build issue when using clang
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Nick Desaulniers <ndesaulniers@google.com>,
        intel-gfx@lists.freedesktop.org,
        DRI Development <dri-devel@lists.freedesktop.org>,
        open list <linux-kernel@vger.kernel.org>, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 13, 2022 at 10:39 AM Nathan Chancellor <nathan@kernel.org> wrot=
e:
>
> On Sat, Feb 12, 2022 at 10:51:06PM -0800, Tong Zhang wrote:
> > drm/i915 target adds some extra cflags, especially it does re-apply -Wa=
ll.
> > In clang this will override -Wno-format-security and cause the build to
> > fail when CONFIG_DRM_I915_WERROR=3Dy. While with GCC this does not happ=
en.
> > We reapply -Wno-format-security here to get around this issue.
>
> For what it's worth, GCC would warn in the exact same way if
> -Wformat-security was included within -Wall like it is for clang:
>
> drivers/gpu/drm/i915/gt/intel_gt.c: In function =E2=80=98intel_gt_invalid=
ate_tlbs=E2=80=99:
> drivers/gpu/drm/i915/gt/intel_gt.c:988:9: error: format not a string lite=
ral and no format arguments [-Werror=3Dformat-security]
>   988 |         GEM_TRACE("\n");
>       |         ^~~~~~~~~
> cc1: all warnings being treated as errors
>
> drivers/gpu/drm/i915/gt/selftest_execlists.c: In function =E2=80=98live_s=
anitycheck=E2=80=99:
> drivers/gpu/drm/i915/gt/selftest_execlists.c:142:25: error: format not a =
string literal and no format arguments [-Werror=3Dformat-security]
>   142 |                         GEM_TRACE("spinner failed to start\n");
>       |                         ^~~~~~~~~
> drivers/gpu/drm/i915/gt/selftest_execlists.c: In function =E2=80=98live_p=
reempt=E2=80=99:
> drivers/gpu/drm/i915/gt/selftest_execlists.c:1775:25: error: format not a=
 string literal and no format arguments [-Werror=3Dformat-security]
>  1775 |                         GEM_TRACE("lo spinner failed to start\n")=
;
>       |                         ^~~~~~~~~
> drivers/gpu/drm/i915/gt/selftest_execlists.c:1792:25: error: format not a=
 string literal and no format arguments [-Werror=3Dformat-security]
>  1792 |                         GEM_TRACE("hi spinner failed to start\n")=
;
>       |                         ^~~~~~~~~
> cc1: all warnings being treated as errors
>
> If fixing these warnings instead of just disabling the warning is
> undesirable (since I feel like the entire point of the i195 cflags
> situation is to enable more warnings than the main Makefile), I think
> the commit message should be rewritten to something along the lines of:
>
> "drm/i915 adds some extra cflags, namely -Wall, which causes
> instances of -Wformat-security to appear when building with clang, even
> though this warning is turned off kernel-wide in the main Makefile:"
>
> > drivers/gpu/drm/i915/gt/intel_gt.c:983:2: error: format string is not a=
 string literal (potentially insecure) [-Werror,-Wformat-security]
> >         GEM_TRACE("ERROR\n");
> >         ^~~~~~~~~~~~~~~~~~~~
> > ./drivers/gpu/drm/i915/i915_gem.h:76:24: note: expanded from macro 'GEM=
_TRACE'
> >  #define GEM_TRACE(...) trace_printk(__VA_ARGS__)
> >                        ^~~~~~~~~~~~~~~~~~~~~~~~~
> > ./include/linux/kernel.h:369:3: note: expanded from macro 'trace_printk=
'
> >                 do_trace_printk(fmt, ##__VA_ARGS__);    \
> >                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > ./include/linux/kernel.h:383:30: note: expanded from macro 'do_trace_pr=
intk'
> >                 __trace_bprintk(_THIS_IP_, trace_printk_fmt, ##args);  =
 \
> >                                            ^~~~~~~~~~~~~~~~
> > drivers/gpu/drm/i915/gt/intel_gt.c:983:2: note: treat the string as an =
argument to avoid this
>
> "This does not happen with GCC because it does not enable
> -Wformat-security with -Wall. Disable -Wformat-security within the i915
> Makefile so that these warnings do not show up with clang."
>
> The actual diff itself looks fine to me.
>
> Cheers,
> Nathan
>
> > Signed-off-by: Tong Zhang <ztong0001@gmail.com>
> > ---
> >  drivers/gpu/drm/i915/Makefile | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/gpu/drm/i915/Makefile b/drivers/gpu/drm/i915/Makef=
ile
> > index 1b62b9f65196..c04e05a3d39f 100644
> > --- a/drivers/gpu/drm/i915/Makefile
> > +++ b/drivers/gpu/drm/i915/Makefile
> > @@ -13,6 +13,7 @@
> >  # will most likely get a sudden build breakage... Hopefully we will fi=
x
> >  # new warnings before CI updates!
> >  subdir-ccflags-y :=3D -Wall -Wextra
> > +subdir-ccflags-y +=3D -Wno-format-security
> >  subdir-ccflags-y +=3D -Wno-unused-parameter
> >  subdir-ccflags-y +=3D -Wno-type-limits
> >  subdir-ccflags-y +=3D -Wno-missing-field-initializers
> > --
> > 2.25.1
> >

Thank you Nathan!
I will send a v2 with a revised commit message.
Thanks,
- Tong
