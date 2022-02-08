Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E4EE4ACD89
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 02:08:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344078AbiBHBGk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 20:06:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343882AbiBHACK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 19:02:10 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58F45C0612A4
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 16:02:07 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id cz16so15466021edb.8
        for <linux-kernel@vger.kernel.org>; Mon, 07 Feb 2022 16:02:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZgCHu0+ICvnL8k6W2muySWjXydvVlaN/vmP7wz/mQFY=;
        b=pCnbMW5wmMooaFkSZ0mSGM3ZIf8jFu6CmlIr2CWFy9z1oDf60E6ldaR+EGbd6QFx1y
         F4YDg7iykTCYez3h+/PtIZPncnJOwDTmuVnd6CTKqUjahgy1WGcutSAYYLEqsXNvrBSK
         Dykj/ISEr+7fB69DqkgCC5vGggVUQXnom+ekXeBGkEg3wxjTmD4f63sKbSG1XjmL8QHP
         M7eoY433joZMY68fhoAqtpYoCsauxoqcUZi7j5gAnoTcigmqv7TChsD0O52nNDpk68V2
         lo8h80pi4ZAA890TUh5oyFLEd92YbEITuYLQQxOlMt0o6OaS0269UZUZzs0+mfiholpL
         5Q7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZgCHu0+ICvnL8k6W2muySWjXydvVlaN/vmP7wz/mQFY=;
        b=kKfY/7VjoSSGzgDHsK48dXJ5cpW56YyOJJAL1hL/MWTr+lQhICruYrUBoELhgWZwqf
         fYuEp7EyI1+fPSXmdOYEN+bs+s0kJxB7L1zYdTPALJMNsbtMxQQKkY4CSho3pyDJ1+3F
         h1jvxpJBWmn+6BYJtXXtsqTjV22hPdXCfC4C+74l8Ku3Q3KiKshheqfpn3Kub3t3C686
         3UTSVhMECG24sgTXnxMibFUdSwizl5Z/AgsP6P1mFB5dZ3sWR1yIigc3Mj4K5Tkq4J5T
         KlHae5bD5AIq5CNSb7KGmFq0Rg8EX6+0YKVZdoE1uOx+S4Rf2lwHJiKqtgBqsSG/i/K1
         as8Q==
X-Gm-Message-State: AOAM531JyFczm8KN8cY921yO21sPu/liXPc3Wqda6V/vNTOCYSVHKL3s
        jZDMX8Q9xmqCPe/UcC7MCS5ZVbguopMTwq1Y/hdFZonN0Q==
X-Google-Smtp-Source: ABdhPJy/7N2dApOtDd1nO8TrSbTpNVDMRgx0o1xoib2zXxQy9Pu0hrod6TnynjWPvDMvsE1kW89v0U9rbPxdvH50Z24=
X-Received: by 2002:a05:6402:1d4c:: with SMTP id dz12mr1868198edb.385.1644278525806;
 Mon, 07 Feb 2022 16:02:05 -0800 (PST)
MIME-Version: 1.0
References: <4df50e95-6173-4ed1-9d08-3c1c4abab23f@gmail.com>
 <CAHC9VhSjTqT-4TMxBnQOQHkj+djONihfeoPVyy1egrZY2t10XA@mail.gmail.com>
 <c8a616e4-26a6-af51-212c-31dca0e265cd@gmail.com> <CAHC9VhQTZdeNOx3AXdoc9LXUzDk5n7wyGBX-tV-ZaovhPAdWwQ@mail.gmail.com>
 <e85dd38b-ef7b-ed7e-882e-124cdf942c44@gmail.com> <CAHC9VhROuJtvNHuVaR6pEekNFacH3Tywx58_hn1f5Mwk+kjC8g@mail.gmail.com>
 <b7e55304-d114-bcbe-08d2-b54828121a01@gmail.com> <CAHC9VhSdgD4Nfaxbnnn4r-OK8koSZ7+zQoPShDbGi9PvkJFpng@mail.gmail.com>
 <CAFftDdpxmf4R9zPVGUUCFinST_2t8iW2SAJYG4e=3JeWtDowJw@mail.gmail.com>
 <7798e61c-eb22-7b19-0849-35e5bfccad8b@gmail.com> <CAFftDdpXm3VubMW_d51uEM+F_6eSGZerJbVQ=c8w7B-L1zT+3Q@mail.gmail.com>
 <99d51c4f-d067-2687-e7ae-d42a6d1326b2@gmail.com> <CAFftDdq6VfNfTpAHAYqLitvJcZ+4XuSVb0pMAXkwAPMd5tj-XQ@mail.gmail.com>
 <CAFftDdrhvNTSM0AV4F29xmFktJ0hZjsTTbGQ89dT2r78XaDm2Q@mail.gmail.com>
In-Reply-To: <CAFftDdrhvNTSM0AV4F29xmFktJ0hZjsTTbGQ89dT2r78XaDm2Q@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 7 Feb 2022 19:01:54 -0500
Message-ID: <CAHC9VhRZY2n6ubzih6Qkh6SBcEWu_pT0A0_+w_HgzwehPZiD_g@mail.gmail.com>
Subject: Re: [PATCH] SELinux: Always allow FIOCLEX and FIONCLEX
To:     William Roberts <bill.c.roberts@gmail.com>
Cc:     Demi Marie Obenour <demiobenour@gmail.com>,
        Jeff Vander Stoep <jeffv@google.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        SElinux list <selinux@vger.kernel.org>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>,
        selinux-refpolicy@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 7, 2022 at 4:51 PM William Roberts <bill.c.roberts@gmail.com> wrote:
>
> On Mon, Feb 7, 2022 at 3:42 PM William Roberts <bill.c.roberts@gmail.com> wrote:
> >
> > + NNK and Dan
> - nnk and Dan.
> + Jeff
> Let me try again, looks like Nick left, not sure about Dan.
> Jeff, can you look this over?

FWIW, I'm still not convinced merging this kernel patch is something
we want to do, so please don't assume that it's a done deal on the
kernel side.

> > On Mon, Feb 7, 2022 at 3:12 PM Demi Marie Obenour <demiobenour@gmail.com> wrote:
> > >
> > > On 2/7/22 13:35, William Roberts wrote:
> > > > On Mon, Feb 7, 2022 at 11:09 AM Demi Marie Obenour
> > > > <demiobenour@gmail.com> wrote:
> > > >>
> > > >> On 2/7/22 12:00, William Roberts wrote:
> > > >>> On Mon, Feb 7, 2022 at 9:08 AM Paul Moore <paul@paul-moore.com> wrote:
> > > >>>>
> > > >>>> On Wed, Feb 2, 2022 at 5:13 AM Demi Marie Obenour <demiobenour@gmail.com> wrote:
> > > >>>>> On 2/1/22 12:26, Paul Moore wrote:
> > > >>>>>> On Sat, Jan 29, 2022 at 10:40 PM Demi Marie Obenour
> > > >>>>>> <demiobenour@gmail.com> wrote:
> > > >>>>>>> On 1/26/22 17:41, Paul Moore wrote:
> > > >>>>>>>> On Tue, Jan 25, 2022 at 5:50 PM Demi Marie Obenour
> > > >>>>>>>> <demiobenour@gmail.com> wrote:
> > > >>>>>>>>> On 1/25/22 17:27, Paul Moore wrote:
> > > >>>>>>>>>> On Tue, Jan 25, 2022 at 4:34 PM Demi Marie Obenour
> > > >>>>>>>>>> <demiobenour@gmail.com> wrote:
> > > >>>>>>>>>>>
> > > >>>>>>>>>>> These ioctls are equivalent to fcntl(fd, F_SETFD, flags), which SELinux
> > > >>>>>>>>>>> always allows too.  Furthermore, a failed FIOCLEX could result in a file
> > > >>>>>>>>>>> descriptor being leaked to a process that should not have access to it.
> > > >>>>>>>>>>>
> > > >>>>>>>>>>> Signed-off-by: Demi Marie Obenour <demiobenour@gmail.com>
> > > >>>>>>>>>>> ---
> > > >>>>>>>>>>>  security/selinux/hooks.c | 5 +++++
> > > >>>>>>>>>>>  1 file changed, 5 insertions(+)
> > > >>>>>>>>>>
> > > >>>>>>>>>> I'm not convinced that these two ioctls should be exempt from SELinux
> > > >>>>>>>>>> policy control, can you explain why allowing these ioctls with the
> > > >>>>>>>>>> file:ioctl permission is not sufficient for your use case?  Is it a
> > > >>>>>>>>>> matter of granularity?
> > > >>>>>>>>>
> > > >>>>>>>>> FIOCLEX and FIONCLEX are applicable to *all* file descriptors, not just
> > > >>>>>>>>> files.  If I want to allow them with SELinux policy, I have to grant
> > > >>>>>>>>> *:ioctl to all processes and use xperm rules to determine what ioctls
> > > >>>>>>>>> are actually allowed.  That is incompatible with existing policies and
> > > >>>>>>>>> needs frequent maintenance when new ioctls are added.
> > > >>>>>>>>>
> > > >>>>>>>>> Furthermore, these ioctls do not allow one to do anything that cannot
> > > >>>>>>>>> already be done by fcntl(F_SETFD), and (unless I have missed something)
> > > >>>>>>>>> SELinux unconditionally allows that.  Therefore, blocking these ioctls
> > > >>>>>>>>> does not improve security, but does risk breaking userspace programs.
> > > >>>>>>>>> The risk is especially great because in the absence of SELinux, I
> > > >>>>>>>>> believe FIOCLEX and FIONCLEX *will* always succeed, and userspace
> > > >>>>>>>>> programs may rely on this.  Worse, if a failure of FIOCLEX is ignored,
> > > >>>>>>>>> a file descriptor can be leaked to a child process that should not have
> > > >>>>>>>>> access to it, but which SELinux allows access to.  Userspace
> > > >>>>>>>>> SELinux-naive sandboxes are one way this could happen.  Therefore,
> > > >>>>>>>>> blocking FIOCLEX may *create* a security issue, and it cannot solve one.
> > > >>>>>>>>
> > > >>>>>>>> I can see you are frustrated with my initial take on this, but please
> > > >>>>>>>> understand that excluding an operation from the security policy is not
> > > >>>>>>>> something to take lightly and needs discussion.  I've added the
> > > >>>>>>>> SELinux refpolicy list to this thread as I believe their input would
> > > >>>>>>>> be helpful here.
> > > >>>>>>>
> > > >>>>>>> Absolutely it is not something that should be taken lightly, though I
> > > >>>>>>> strongly believe it is correct in this case.  Is one of my assumptions
> > > >>>>>>> mistaken?
> > > >>>>>>
> > > >>>>>> My concern is that there is a distro/admin somewhere which is relying
> > > >>>>>> on their SELinux policy enforcing access controls on these ioctls and
> > > >>>>>> removing these controls would cause them a regression.
> > > >>>>>
> > > >>>>> I obviously do not have visibility into all systems, but I suspect that
> > > >>>>> nobody is actually relying on this.  Setting and clearing CLOEXEC via
> > > >>>>> fcntl is not subject to SELinux restrictions, so blocking FIOCLEX
> > > >>>>> and FIONCLEX can be trivially bypassed unless fcntl(F_SETFD) is
> > > >>>>> blocked by seccomp or another LSM.  Clearing close-on-exec can also be
> > > >>>>> implemented with dup2(), and setting it can be implemented with dup3()
> > > >>>>> and F_DUPFD_CLOEXEC (which SELinux also allows).  In short, I believe
> > > >>>>> that unconditionally allowing FIOCLEX and FIONCLEX may fix real-world
> > > >>>>> problems, and that it is highly unlikely that anyone is relying on the
> > > >>>>> current behavior.
> > > >>>>
> > > >>>> I understand your point, but I remain concerned about making a kernel
> > > >>>> change for something that can be addressed via policy.  I'm also
> > > >>>> concerned that in the nine days this thread has been on both the mail
> > > >>>> SELinux developers and refpolicy lists no one other than you and I
> > > >>>> have commented on this patch.  In order to consider this patch
> > > >>>> further, I'm going to need to see comments from others, preferably
> > > >>>> those with a background in supporting SELinux policy.
> > > >>>>
> > > >>>
> > > >>> AFAIK/AFAICT Android makes no reference to F_SETFD, and tracing the code
> > > >>> does seem to be ignored, and the code for FIOCLEX FIONCLEX calls into
> > > >>> the same kernel routine set_close_on_exec().
> > > >>> Considering that Android's bionic contains support for "e" flag to
> > > >>> fopen, and it's
> > > >>> used in a lot of places, makes me more sure the check is skipped for F_SETFD
> > > >>>
> > > >>> However, Android does make reference to FIOCLEX FIONCLEX and every
> > > >>> domain has it enabled:
> > > >>> domain.te:allowxperm domain { file_type fs_type domain dev_type }:{
> > > >>> dir notdevfile_class_set blk_file } ioctl { FIOCLEX FIONCLEX };
> > > >>> domain.te:allowxperm domain tun_device:chr_file ioctl { FIOCLEX FIONCLEX };
> > > >>>
> > > >>> Refpolicy doesn't use xperm AFAICT.
> > > >>>
> > > >>> I stayed quiet, I wouldn't ack on this myself, but the premise seems
> > > >>> correct and we
> > > >>> can safely drop this. Note that I didn't review the code. But we need
> > > >>> to ensure we handle
> > > >>> policy correctly and not break anything. I'm not sure what the
> > > >>> compilers are doing
> > > >>> for validation of policy macro values, but we would probably want to
> > > >>> mark it deprecated,
> > > >>> but still allow loading of old compiled policies.
> > > >>
> > > >> Loading of policies is not impacted.  My patch simply skips the
> > > >> checks for FIOCLEX and FIONCLEX, instead unconditionally allowing the
> > > >> operation.  This is actually *more* selective than anything that can
> > > >> be done via policy, as my patch checks the entire ioctl number whereas
> > > >> policy can only check the low 16 bits.  As such, it is safer than using
> > > >> policy to allow FIOCLEX and FIONCLEX system-wide: if my patch causes an
> > > >> ioctl to be allowed, it is guaranteed that that ioctl will change the
> > > >> close-on-exec flag and have no other effect.
> > > >>
> > > >
> > > > What I meant by my comment is that patching the kernel is only 1/2 the
> > > > problem. We
> > > > still need to coordinate with existing policies to deprecate that out,
> > > > but since it's just
> > > > Android (AFIAK), that's pretty simple to do. I just want to make sure
> > > > we don't leave
> > > > confusing cruft floating around. I looked more at how they do xperms
> > > > in Android, and it's just
> > > > an m4 macro to a number. So we would want to coordinate a patch into the kernel
> > > > with a patch that drops that from Android policy.
> > >
> > > The kernel patch needs to come first, but there is no urgency at all
> > > for the Android policy patch.  The existing Android policy will work
> > > fine with a patched kernel.
> >
> > Yes it will work, no one said it wouldn't.
> > **If we make the change in the kernel, we should also do the cleanup
> > in policies.**
> > No cruft left behind, no dead rules.
> > We shouldn't take a patch here without ensuring that AOSP has a clean
> > path forward.
> > and putting a patch through for review gets us buy in and lets them
> > know about the
> > kernel change. This isn't about "technically it works". It's about community and
> > notice to AOSP. We give them a policy patch + link to the kernel patch, it keeps
> > everyone happy. But that's my opinion, let's just ask them (CC'd).
> >
>
> Jeff?
>
> > Dan/Nick do you guys care about these dead ioctl rules after this patch? How
> > would you like to proceed? Do you have any concerns we're not aware of?
> >
> > >  Removing the allowxperms for FIOCLEX and
> > > FIONCLEX will require ensuring that doing so does not make some domains
> > > not subject to xperm rules, and therefore allow ioctls that would
> > > previously have been forbidden.
> >
> > Yes, but this is very solvable. The set of xperms shouldn't change for
> > an affected
> > domain with the exception of FIOCLEX and FIONCLEX. sesearch will give
> > you that, I don't
> > know if sediff ever got updated for xperms.
> >
> > > --
> > > Sincerely,
> > > Demi Marie Obenour (she/her/hers)

-- 
paul-moore.com
