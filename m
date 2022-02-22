Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 411D34C055B
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 00:28:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236291AbiBVX3N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 18:29:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236272AbiBVX3K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 18:29:10 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED5A4A27B5
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 15:28:43 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id hw13so47366210ejc.9
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 15:28:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0sDj0qMJJiN5G76triZ2YOQFF95CL0AvqXtgUFOJ/qk=;
        b=hPpp7SkwemAPoCxUmzJK8Z9jEuz2Ipp1/bHRj8z9satZdk6aNRAmEZ1xsvLdbSt7Fj
         CGTAEBI2ZwJ7tklGkS0Y4emJNlChkcpsrDDtHIIsI253bWpbBE3OtDR7USWHSUIlGxan
         IiyjiQCNYab6YGCbWjIPcp8tUsuN2Qc20uPWtpzA+syN1WUN6D1ogO/8Ca14REDOzxem
         cvHIcjGhdEQZvofhwdxgsOLguJF87p/WhFstfmPeTd5neXlk9uIKr6fiQQfaibKXN9X9
         nCc/y+Wuw6LOgyKv5lTFUaivLmqGa9C3z/T05HMWVWQbxdo7dUXWrw2l/ePGBVMj1sp6
         oUQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0sDj0qMJJiN5G76triZ2YOQFF95CL0AvqXtgUFOJ/qk=;
        b=KUsbhX+NXvC7BG+lB0mC5pKl0KpXFU7bKi+E2yDGofGs5Ay5QAKDGU47DibMEiOB59
         b4BTxjMZRyhKxHHrqb5EkvpStUmLW4mjD2L9uhJ1RyPQ7/8Woc13Kr3xE6ofyZx8h5Of
         OW9Sjev2OWGMG71SeGMOmm0aXZUhjKs1Uo+/kqLQNtSkq/7C87xPHGl7PUu/EPfr0crK
         r69QBuNbxiunzyPYIaydMMbGXcj4q4mucMuCltT89BT9nLzzkQX4o59WhdW8/9xcsEwh
         1lTbMxNAaYVWplznxBjbH7vG5c8UpJevIZnwZf4rk2FDRJWZMzXK1t6/2olVVpNMw4sS
         IUPQ==
X-Gm-Message-State: AOAM531VVJq7iZ1/iOgdQpN8NADOUHnpIgcGjKKaMWi2uemLOqljxzVx
        ZLfJZsdroxLSdhYkoggtALN/p9glbnEL0kzvq632
X-Google-Smtp-Source: ABdhPJy51IWDBSElZ4OCACw6vfJARdAcG+E2xuozKMf80uepmG8u0le8bdcjGxHhoQ2VySs/aduZM0VYpM77G+KdSJU=
X-Received: by 2002:a17:906:c318:b0:6cf:d118:59d8 with SMTP id
 s24-20020a170906c31800b006cfd11859d8mr20829134ejz.112.1645572522506; Tue, 22
 Feb 2022 15:28:42 -0800 (PST)
MIME-Version: 1.0
References: <20220221131533.74238-1-richard_c_haines@btinternet.com>
In-Reply-To: <20220221131533.74238-1-richard_c_haines@btinternet.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 22 Feb 2022 18:28:31 -0500
Message-ID: <CAHC9VhQnRQFrM-mTzUQ3UsyVp2JYw1wUh=7yrdjH7-QmHKidAg@mail.gmail.com>
Subject: Re: [PATCH V2] security/selinux: Always allow FIOCLEX and FIONCLEX
To:     Richard Haines <richard_c_haines@btinternet.com>
Cc:     stephen.smalley.work@gmail.com, eparis@parisplace.org,
        demiobenour@gmail.com, selinux@vger.kernel.org,
        linux-kernel@vger.kernel.org, selinux-refpolicy@vger.kernel.org,
        jeffv@google.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 21, 2022 at 8:15 AM Richard Haines
<richard_c_haines@btinternet.com> wrote:
>
> These ioctls are equivalent to fcntl(fd, F_SETFD, flags), which SELinux
> always allows too.  Furthermore, a failed FIOCLEX could result in a file
> descriptor being leaked to a process that should not have access to it.
>
> As this patch removes access controls, a policy capability needs to be
> enabled in policy to always allow these ioctls.
>
> Based-on-patch-by: Demi Marie Obenour <demiobenour@gmail.com>
> Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
> ---
> V2 Change: Control via a policy capability. See this thread for discussion:
> https://lore.kernel.org/selinux/CAHC9VhQEPxYP_KU56gAGNHKQaxucY8gSsHiUB42PVgADBAccRQ@mail.gmail.com/T/#t
>
> With this patch and the polcap enabled, the selinux-testsuite will fail:
> ioctl/test at line 47 - Will need a fix.
>
>  security/selinux/hooks.c                   | 7 +++++++
>  security/selinux/include/policycap.h       | 1 +
>  security/selinux/include/policycap_names.h | 3 ++-
>  security/selinux/include/security.h        | 7 +++++++
>  4 files changed, 17 insertions(+), 1 deletion(-)

Thanks Richard for putting together the v2 of this patch.

As far as the test is concerned, it seems like the quick-n-dirty fix
is to simply remove the ioctl(FIOCLEX) test in test_noioctl.c; is
everyone okay with that?  At least that is what I'm going to do with
my local copy that I use to validate the kernel-secnext builds unless
someone has a better patch :)

> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 5b6895e4f..030c41652 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -3745,6 +3745,13 @@ static int selinux_file_ioctl(struct file *file, unsigned int cmd,
>                                             CAP_OPT_NONE, true);
>                 break;
>
> +       case FIOCLEX:
> +       case FIONCLEX:
> +               /* Must always succeed if polcap set, else default: */
> +               if (selinux_policycap_ioctl_skip_cloexec())
> +                       break;
> +               fallthrough;
> +

The break/fallthrough looks like it might be a little more fragile
than necessary, how about something like this:

  case FIOCLEX:
  case FIONCLEX:
    if (!selinux_policycap_ioctl_skip_cloexec())
      error = ioctl_has_perm(cred, file, FILE__IOCTL, (u16) cmd);
      break;

Yes, it does duplicate the default ioctl_has_perm() call, but since we
are effectively deprecating this and locking the FIOCLEX/FIONCLEX
behavior with this policy capability it seems okay to me (and
preferable to relying on the fallthrough).

Thoughts?

-- 
paul-moore.com
