Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31FAB4A6253
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 18:26:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241464AbiBAR0W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 12:26:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237515AbiBAR0S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 12:26:18 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36BB1C06173D
        for <linux-kernel@vger.kernel.org>; Tue,  1 Feb 2022 09:26:18 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id s5so56132360ejx.2
        for <linux-kernel@vger.kernel.org>; Tue, 01 Feb 2022 09:26:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+FUAlOlMa07eJpdtWBtFxltqcXW5pKh9hMDtYHtwGqE=;
        b=SQ4fed4ky5Yr+isS1uetmg/gwgm8f0vVjIfE7jcqJuXtyxLJi8F17af80tpltf0pzw
         0XK1qOovI5k+anlfTXeEbgW43YyCHRclMUqwQwItNE5mAvmUDTmXOnxO9vDZKrgKXeok
         T3YxoBoWwklT3IkIo4bIqtjzOr0tLUpSY2jY3AN+Gm7oTNIhKh1ijX0dlK0HVxU3OWD7
         ZfDTX/CazHRKW8p/ZUAipqSm8UbRtVJbY2DgAj7HzQ+CBg0HMZnwmXD84sBNBI9bGZmp
         Fy2jmq/uEGMEL7eRCCJq1yWHmkwWtLitt4fDRGkr5PjWn7bLIGTAqJztrpiM/m5vug5m
         5dog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+FUAlOlMa07eJpdtWBtFxltqcXW5pKh9hMDtYHtwGqE=;
        b=M6PWHyVZhKW3DzEcZAIi6kRi3Cfcb9UP644WnDmD8fTZbtHE/tRxinGBhLrBy18iLf
         LVluRUrYq8fPBEP8mHJ5DQCH1xNQ6vDM5f3ehwMxlraKUFq2cQwRKeraQkb0ElCfUg3R
         B2DWgBGU1a9PHSNj52TZDXZX/ROCGyNt1JP7ndpBG90EKc74/4bwTlA+NTImje29IPZi
         ANmQRyH32ChYr9bOl7Fe3CJCUioczSP2E6GAYpGPgPR06ERVKwN+RAEO9+xqrEc63xsQ
         /BovRFRo3U2JNVeEiVYetclZpII2qb/8he8a7aeGCh/84JTfjBTSL/Ds8VN03EPDldZQ
         J8RA==
X-Gm-Message-State: AOAM531CgtXkk+Pq2jn/560Mes2YUMVAeMzzlNT4g29nWeBJ3tCHCQ4W
        8CtE2nTtz5X3XVb7KmWqoJBroMKLtphKfBzZeR0/e+5GSg==
X-Google-Smtp-Source: ABdhPJwOJ7OYrim5y2fo7QvQeZhn3mGe6aj933uSWnep/EaBqhiOPldWRZuF7RwgzDN4UKwqG/U+NY1OQyzhKX5yKcU=
X-Received: by 2002:a17:907:3e8a:: with SMTP id hs10mr21951252ejc.112.1643736376357;
 Tue, 01 Feb 2022 09:26:16 -0800 (PST)
MIME-Version: 1.0
References: <4df50e95-6173-4ed1-9d08-3c1c4abab23f@gmail.com>
 <CAHC9VhSjTqT-4TMxBnQOQHkj+djONihfeoPVyy1egrZY2t10XA@mail.gmail.com>
 <c8a616e4-26a6-af51-212c-31dca0e265cd@gmail.com> <CAHC9VhQTZdeNOx3AXdoc9LXUzDk5n7wyGBX-tV-ZaovhPAdWwQ@mail.gmail.com>
 <e85dd38b-ef7b-ed7e-882e-124cdf942c44@gmail.com>
In-Reply-To: <e85dd38b-ef7b-ed7e-882e-124cdf942c44@gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 1 Feb 2022 12:26:05 -0500
Message-ID: <CAHC9VhROuJtvNHuVaR6pEekNFacH3Tywx58_hn1f5Mwk+kjC8g@mail.gmail.com>
Subject: Re: [PATCH] SELinux: Always allow FIOCLEX and FIONCLEX
To:     Demi Marie Obenour <demiobenour@gmail.com>
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>, selinux@vger.kernel.org,
        linux-kernel@vger.kernel.org, selinux-refpolicy@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 29, 2022 at 10:40 PM Demi Marie Obenour
<demiobenour@gmail.com> wrote:
> On 1/26/22 17:41, Paul Moore wrote:
> > On Tue, Jan 25, 2022 at 5:50 PM Demi Marie Obenour
> > <demiobenour@gmail.com> wrote:
> >> On 1/25/22 17:27, Paul Moore wrote:
> >>> On Tue, Jan 25, 2022 at 4:34 PM Demi Marie Obenour
> >>> <demiobenour@gmail.com> wrote:
> >>>>
> >>>> These ioctls are equivalent to fcntl(fd, F_SETFD, flags), which SELinux
> >>>> always allows too.  Furthermore, a failed FIOCLEX could result in a file
> >>>> descriptor being leaked to a process that should not have access to it.
> >>>>
> >>>> Signed-off-by: Demi Marie Obenour <demiobenour@gmail.com>
> >>>> ---
> >>>>  security/selinux/hooks.c | 5 +++++
> >>>>  1 file changed, 5 insertions(+)
> >>>
> >>> I'm not convinced that these two ioctls should be exempt from SELinux
> >>> policy control, can you explain why allowing these ioctls with the
> >>> file:ioctl permission is not sufficient for your use case?  Is it a
> >>> matter of granularity?
> >>
> >> FIOCLEX and FIONCLEX are applicable to *all* file descriptors, not just
> >> files.  If I want to allow them with SELinux policy, I have to grant
> >> *:ioctl to all processes and use xperm rules to determine what ioctls
> >> are actually allowed.  That is incompatible with existing policies and
> >> needs frequent maintenance when new ioctls are added.
> >>
> >> Furthermore, these ioctls do not allow one to do anything that cannot
> >> already be done by fcntl(F_SETFD), and (unless I have missed something)
> >> SELinux unconditionally allows that.  Therefore, blocking these ioctls
> >> does not improve security, but does risk breaking userspace programs.
> >> The risk is especially great because in the absence of SELinux, I
> >> believe FIOCLEX and FIONCLEX *will* always succeed, and userspace
> >> programs may rely on this.  Worse, if a failure of FIOCLEX is ignored,
> >> a file descriptor can be leaked to a child process that should not have
> >> access to it, but which SELinux allows access to.  Userspace
> >> SELinux-naive sandboxes are one way this could happen.  Therefore,
> >> blocking FIOCLEX may *create* a security issue, and it cannot solve one.
> >
> > I can see you are frustrated with my initial take on this, but please
> > understand that excluding an operation from the security policy is not
> > something to take lightly and needs discussion.  I've added the
> > SELinux refpolicy list to this thread as I believe their input would
> > be helpful here.
>
> Absolutely it is not something that should be taken lightly, though I
> strongly believe it is correct in this case.  Is one of my assumptions
> mistaken?

My concern is that there is a distro/admin somewhere which is relying
on their SELinux policy enforcing access controls on these ioctls and
removing these controls would cause them a regression.

-- 
paul-moore.com
