Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B12D14A9148
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 00:44:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243572AbiBCXod (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 18:44:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241226AbiBCXob (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 18:44:31 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF8D8C06173B
        for <linux-kernel@vger.kernel.org>; Thu,  3 Feb 2022 15:44:30 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id u24so9395831eds.11
        for <linux-kernel@vger.kernel.org>; Thu, 03 Feb 2022 15:44:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AmSNhDG6FW6yzlPpCdGKepqD+t+GFrCkOSovI2o4uvI=;
        b=A/uDj8h0TiRQQH5mrt6TQPc7Y0azsfr7kb4qI+LVJLLCIDOWDLgOVwRohllzo5rrBM
         CG8Kamrm7loe3c0ameljz4bFqOr7sxayOW1rPAn1UKBNZvmmWfVQewc8ecFDhYWp7IGY
         MkMjo/8uJtaGlIPCHPDzS5S0rZLqI/3/YCIIQrmV9rQeJrKMBxRuddxkEiEBqkhJIK53
         EoD2PuMhMpJgRI4sMzORjEZ9mK9WNlSsc+nN3lxtJn/92xGkVVA+BdNMfMwYBembFmn6
         Q1rSzs8uiS8ZXk4qLq1MQP+m6YxXHxzHFwZyq/+3G/bTvcQI1tMLeDTAt96B87dK+3cz
         kk4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AmSNhDG6FW6yzlPpCdGKepqD+t+GFrCkOSovI2o4uvI=;
        b=guHZTrzsTnhC4tAA7SJrzeapr6bKtx6IVG60MAP1oZ6TqoPv8LfN5yIDANwK7gDlVP
         WfmcaMSZK1zRJu+hGm87YqCCFrNozAwQFSNXc3MHuoygT1UvIoIbPeEAo3toz1fi67FR
         HiWqJr+yWXQGuOZfPnuB0KiXzaVesa10kChWJFfQCv7vGcfz9rUD8jPd/PYKQGn97hn5
         JRBHxIH99HJLeagEXhy8sdkGKhYv68ZAMdWXJEm6ovgMZUK4ENYTBGoM5PW0CUlnn0Zz
         rfgLzm3+9AxM+6uU0j8Z6KrShII9PTzvHAuKk24mHQ4BYy79hHH9p4CcU1zibpycqLrp
         azbw==
X-Gm-Message-State: AOAM531YrseBYsiB050tVFqCXH4iCX3VtvmYLxUnRN4YZa9LUHgI2gll
        JAY4VjEb2QdvKW/XkkkJ1PuQbqUtEwxJund/xwPE
X-Google-Smtp-Source: ABdhPJxGEVmy+RObrcV0WQWV29B0TcmCAkYfMWGOM+Q9bEEISBaNbVM2Z5RBpMjztX8L3SEpdMZRdHZ0sHH6jJrCBQ8=
X-Received: by 2002:aa7:dcc9:: with SMTP id w9mr550521edu.434.1643931869390;
 Thu, 03 Feb 2022 15:44:29 -0800 (PST)
MIME-Version: 1.0
References: <4df50e95-6173-4ed1-9d08-3c1c4abab23f@gmail.com>
 <CAHC9VhSjTqT-4TMxBnQOQHkj+djONihfeoPVyy1egrZY2t10XA@mail.gmail.com>
 <c8a616e4-26a6-af51-212c-31dca0e265cd@gmail.com> <CAHC9VhQTZdeNOx3AXdoc9LXUzDk5n7wyGBX-tV-ZaovhPAdWwQ@mail.gmail.com>
 <e85dd38b-ef7b-ed7e-882e-124cdf942c44@gmail.com> <CAHC9VhROuJtvNHuVaR6pEekNFacH3Tywx58_hn1f5Mwk+kjC8g@mail.gmail.com>
 <b7e55304-d114-bcbe-08d2-b54828121a01@gmail.com>
In-Reply-To: <b7e55304-d114-bcbe-08d2-b54828121a01@gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 3 Feb 2022 18:44:18 -0500
Message-ID: <CAHC9VhSdgD4Nfaxbnnn4r-OK8koSZ7+zQoPShDbGi9PvkJFpng@mail.gmail.com>
Subject: Re: [PATCH] SELinux: Always allow FIOCLEX and FIONCLEX
To:     Demi Marie Obenour <demiobenour@gmail.com>
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>, selinux@vger.kernel.org,
        linux-kernel@vger.kernel.org, selinux-refpolicy@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 2, 2022 at 5:13 AM Demi Marie Obenour <demiobenour@gmail.com> wrote:
> On 2/1/22 12:26, Paul Moore wrote:
> > On Sat, Jan 29, 2022 at 10:40 PM Demi Marie Obenour
> > <demiobenour@gmail.com> wrote:
> >> On 1/26/22 17:41, Paul Moore wrote:
> >>> On Tue, Jan 25, 2022 at 5:50 PM Demi Marie Obenour
> >>> <demiobenour@gmail.com> wrote:
> >>>> On 1/25/22 17:27, Paul Moore wrote:
> >>>>> On Tue, Jan 25, 2022 at 4:34 PM Demi Marie Obenour
> >>>>> <demiobenour@gmail.com> wrote:
> >>>>>>
> >>>>>> These ioctls are equivalent to fcntl(fd, F_SETFD, flags), which SELinux
> >>>>>> always allows too.  Furthermore, a failed FIOCLEX could result in a file
> >>>>>> descriptor being leaked to a process that should not have access to it.
> >>>>>>
> >>>>>> Signed-off-by: Demi Marie Obenour <demiobenour@gmail.com>
> >>>>>> ---
> >>>>>>  security/selinux/hooks.c | 5 +++++
> >>>>>>  1 file changed, 5 insertions(+)
> >>>>>
> >>>>> I'm not convinced that these two ioctls should be exempt from SELinux
> >>>>> policy control, can you explain why allowing these ioctls with the
> >>>>> file:ioctl permission is not sufficient for your use case?  Is it a
> >>>>> matter of granularity?
> >>>>
> >>>> FIOCLEX and FIONCLEX are applicable to *all* file descriptors, not just
> >>>> files.  If I want to allow them with SELinux policy, I have to grant
> >>>> *:ioctl to all processes and use xperm rules to determine what ioctls
> >>>> are actually allowed.  That is incompatible with existing policies and
> >>>> needs frequent maintenance when new ioctls are added.
> >>>>
> >>>> Furthermore, these ioctls do not allow one to do anything that cannot
> >>>> already be done by fcntl(F_SETFD), and (unless I have missed something)
> >>>> SELinux unconditionally allows that.  Therefore, blocking these ioctls
> >>>> does not improve security, but does risk breaking userspace programs.
> >>>> The risk is especially great because in the absence of SELinux, I
> >>>> believe FIOCLEX and FIONCLEX *will* always succeed, and userspace
> >>>> programs may rely on this.  Worse, if a failure of FIOCLEX is ignored,
> >>>> a file descriptor can be leaked to a child process that should not have
> >>>> access to it, but which SELinux allows access to.  Userspace
> >>>> SELinux-naive sandboxes are one way this could happen.  Therefore,
> >>>> blocking FIOCLEX may *create* a security issue, and it cannot solve one.
> >>>
> >>> I can see you are frustrated with my initial take on this, but please
> >>> understand that excluding an operation from the security policy is not
> >>> something to take lightly and needs discussion.  I've added the
> >>> SELinux refpolicy list to this thread as I believe their input would
> >>> be helpful here.
> >>
> >> Absolutely it is not something that should be taken lightly, though I
> >> strongly believe it is correct in this case.  Is one of my assumptions
> >> mistaken?
> >
> > My concern is that there is a distro/admin somewhere which is relying
> > on their SELinux policy enforcing access controls on these ioctls and
> > removing these controls would cause them a regression.
>
> I obviously do not have visibility into all systems, but I suspect that
> nobody is actually relying on this.  Setting and clearing CLOEXEC via
> fcntl is not subject to SELinux restrictions, so blocking FIOCLEX
> and FIONCLEX can be trivially bypassed unless fcntl(F_SETFD) is
> blocked by seccomp or another LSM.  Clearing close-on-exec can also be
> implemented with dup2(), and setting it can be implemented with dup3()
> and F_DUPFD_CLOEXEC (which SELinux also allows).  In short, I believe
> that unconditionally allowing FIOCLEX and FIONCLEX may fix real-world
> problems, and that it is highly unlikely that anyone is relying on the
> current behavior.

I understand your point, but I remain concerned about making a kernel
change for something that can be addressed via policy.  I'm also
concerned that in the nine days this thread has been on both the mail
SELinux developers and refpolicy lists no one other than you and I
have commented on this patch.  In order to consider this patch
further, I'm going to need to see comments from others, preferably
those with a background in supporting SELinux policy.

Also, while I'm sure you are already well aware of this, I think it is
worth mentioning that SELinux does apply access controls when file
descriptors are inherited across an exec() boundary.

-- 
paul-moore.com
