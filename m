Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B6AC4BA3F6
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 16:05:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242307AbiBQPFb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 10:05:31 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242310AbiBQPF2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 10:05:28 -0500
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE676196A3C;
        Thu, 17 Feb 2022 07:05:10 -0800 (PST)
Received: by mail-oi1-x22c.google.com with SMTP id r27so6145019oiw.4;
        Thu, 17 Feb 2022 07:05:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=f2MPqTgNhkg8dMnyXCAFH3rR3QSJvQ1vPpxCo+MKOj8=;
        b=Cx9RS+kG97Yi9fZNROZ4ELjN6xaw3IgW5PlUcROxWJAyZXPTpUrH7LSQiY+r8oBHrU
         Zg1uc69eNVPqLjDBZgBYFiO7oxO9wIm8hjoBa3uUwHZe0op2/9wJ1d069pF0+9GmEaCM
         jxDT7pCm5XfHskXuGHOcpP/O1IeXReO1gjpqJq+OkywIFtmzxbdNyHUqBYZvkffIHbDg
         1THozygIzmLyf58iiULG7km+V0Jo7x58ckme8BnCTx5FqLV0qZp2DKHk6CIc5//O2sCs
         8aTjRIpNqE930fa4bk14F3ve3JwFhgIWGJ9aq5ng0Yy4iTmCijoNPHCQHXqew8Y8/kTG
         gGeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=f2MPqTgNhkg8dMnyXCAFH3rR3QSJvQ1vPpxCo+MKOj8=;
        b=S0AIhFFbMJdV9HK+oiygFaPtL8hQSweIdFcs0rVPVw7uwuTta70quiml1h+8gQ3G7Z
         f6h8r4/3IWW6N7KgE1tRXcxeEAe1mhhZA+FFcgU02/cZL4wi5eRdN87se2SFUtIFa7Tc
         hZFKYXDHstY8lNUg/Zpfhd7gp1G2HKLxRxp2I9QW6GqW0npURUbLyz9F/6OmaGQSyLZ4
         HokxlGISBhuMybeRfymzE9apogmEv0v8XO2lXnqoArd/88t1oOkxY6KDbZIpX4b4wwJa
         GZdQsOJ8oqSa9HbMfkDLadm5t/nzAf6zhGt+vjgBko9jgLzlgudWqo+GItcTB2CvrF8b
         CQqQ==
X-Gm-Message-State: AOAM531EQyF2lLGY8R4nDEabCyFY03EtQchyiRNk+2s2eacw86NSDUuk
        YktKAdHT0gh4mjtExmPkahmHkYcdIvZA8re01vs=
X-Google-Smtp-Source: ABdhPJzHv7jbTD21TTWxDCpiC4x/P9oo3FqS6Kvl2GIeQ/+Bb7O5aFLF5cj7AiplebmaHPOwWdAjJIcJ5tQSeJdvaXo=
X-Received: by 2002:aca:5b45:0:b0:2bc:8362:b053 with SMTP id
 p66-20020aca5b45000000b002bc8362b053mr2789910oib.36.1645110309954; Thu, 17
 Feb 2022 07:05:09 -0800 (PST)
MIME-Version: 1.0
References: <4df50e95-6173-4ed1-9d08-3c1c4abab23f@gmail.com>
 <CAHC9VhSjTqT-4TMxBnQOQHkj+djONihfeoPVyy1egrZY2t10XA@mail.gmail.com>
 <c8a616e4-26a6-af51-212c-31dca0e265cd@gmail.com> <CAHC9VhQTZdeNOx3AXdoc9LXUzDk5n7wyGBX-tV-ZaovhPAdWwQ@mail.gmail.com>
 <e85dd38b-ef7b-ed7e-882e-124cdf942c44@gmail.com> <CAHC9VhROuJtvNHuVaR6pEekNFacH3Tywx58_hn1f5Mwk+kjC8g@mail.gmail.com>
 <b7e55304-d114-bcbe-08d2-b54828121a01@gmail.com> <CAHC9VhSdgD4Nfaxbnnn4r-OK8koSZ7+zQoPShDbGi9PvkJFpng@mail.gmail.com>
 <478e1651-a383-05ff-d011-6dda771b8ce8@linux.microsoft.com>
 <875ypt5zmz.fsf@defensec.nl> <CAFftDdo9JmbyPzPWRjOYgZBOS9b5d+OGKKf8egS8_ysbbWW87Q@mail.gmail.com>
 <CABXk95Az0V0qWyB0Cp9D+MaCKNBfcdk4=bvXRdm5EXzHdjXJJg@mail.gmail.com> <CAHC9VhQKuQuR1pJfa0h2Y5dCjmrpiYaGpymwxxE1sa6jR3h-bA@mail.gmail.com>
In-Reply-To: <CAHC9VhQKuQuR1pJfa0h2Y5dCjmrpiYaGpymwxxE1sa6jR3h-bA@mail.gmail.com>
From:   =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Date:   Thu, 17 Feb 2022 16:04:58 +0100
Message-ID: <CAJ2a_Ddh8p0fzJHf7R=BwAULfS8jYq08x=H45mF9jaR1QbWTww@mail.gmail.com>
Subject: Re: [PATCH] SELinux: Always allow FIOCLEX and FIONCLEX
To:     Paul Moore <paul@paul-moore.com>
Cc:     Demi Marie Obenour <demiobenour@gmail.com>,
        William Roberts <bill.c.roberts@gmail.com>,
        Dominick Grift <dominick.grift@defensec.nl>,
        Chris PeBenito <chpebeni@linux.microsoft.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        SElinux list <selinux@vger.kernel.org>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>,
        selinux-refpolicy@vger.kernel.org,
        Jeffrey Vander Stoep <jeffv@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Feb 2022 at 21:35, Paul Moore <paul@paul-moore.com> wrote:
>
> On Mon, Feb 14, 2022 at 2:11 AM Jeffrey Vander Stoep <jeffv@google.com> wrote:
> > On Tue, Feb 8, 2022 at 3:18 PM William Roberts <bill.c.roberts@gmail.com> wrote:
> > >
> > > <snip>
> > >
> > > This is getting too long for me.
> > >
> > > > >
> > > > > I don't have a strong opinion either way.  If one were to allow this
> > > > > using a policy rule, it would result in a major policy breakage.  The
> > > > > rule would turn on extended perm checks across the entire system,
> > > > > which the SELinux Reference Policy isn't written for.  I can't speak
> > > > > to the Android policy, but I would imagine it would be the similar
> > > > > problem there too.
> > > >
> > > > Excuse me if I am wrong but AFAIK adding a xperm rule does not turn on
> > > > xperm checks across the entire system.
> > >
> > > It doesn't as you state below its target + class.
> > >
> > > >
> > > > If i am not mistaken it will turn on xperm checks only for the
> > > > operations that have the same source and target/target class.
> > >
> > > That's correct.
> > >
> > > >
> > > > This is also why i don't (with the exception TIOSCTI for termdev
> > > > chr_file) use xperms by default.
> > > >
> > > > 1. it is really easy to selectively filter ioctls by adding xperm rules
> > > > for end users (and since ioctls are often device/driver specific they
> > > > know best what is needed and what not)
> > >
> > > > >>> and FIONCLEX can be trivially bypassed unless fcntl(F_SETFD)
> > > >
> > > > 2. if you filter ioctls in upstream policy for example like i do with
> > > > TIOSCTI using for example (allowx foo bar (ioctl chr_file (not
> > > > (0xXXXX)))) then you cannot easily exclude additional ioctls later where source is
> > > > foo and target/tclass is bar/chr_file because there is already a rule in
> > > > place allowing the ioctl (and you cannot add rules)
> > >
> > > Currently, fcntl flag F_SETFD is never checked, it's silently allowed, but
> > > the equivalent FIONCLEX and FIOCLEX are checked. So if you wrote policy
> > > to block the FIO*CLEX flags, it would be bypassable through F_SETFD and
> > > FD_CLOEXEC. So the patch proposed makes the FIO flags behave like
> > > F_SETFD. Which means upstream policy users could drop this allow, which
> > > could then remove the target/class rule and allow all icotls. Which is easy
> > > to prevent and fix you could be a rule in to allowx 0 as documented in the
> > > wiki: https://selinuxproject.org/page/XpermRules
> > >
> > > The questions I think we have here are:
> > > 1. Do we agree that the behavior between SETFD and the FIO flags are equivalent?
> > >   I think they are.
> > > 2. Do we want the interfaces to behave the same?
> > >   I think they should.
> > > 3. Do upstream users of the policy construct care?
> > >   The patch is backwards compat, but I don't want their to be cruft
> > > floating around with extra allowxperm rules.
> >
> > I think this proposed change is fine from Android's perspective. It
> > implements in the kernel what we've already already put in place in
> > our policy - that all domains are allowed to use these IOCLTs.
> > https://cs.android.com/android/platform/superproject/+/master:system/sepolicy/public/domain.te;l=312
> >
> > It'll be a few years before we can clean up our policy since we need
> > to support older kernels, but that's fine.
>
> Thanks for the discussion everyone, it sounds like everybody is okay
> with the change - that's good.  However, as I said earlier in this
> thread I think we need to put this behind a policy capability, how
> does POLICYDB_CAPABILITY_IOCTL_CLOEXEC/"ioctl_skip_cloexec" sound to
> everyone?

May I ask why?
To my understanding policy capabilities exist to retain backwards
compatibility for older
policies, e.g. if a new check is introduced or a new essential class
or permission, which
would break systems running an updated kernel with a non updated policy.
In this case no check or class/permission is added, the xperm checks
against FIO(N)CLEX
are just dropped.  Old policies still defining related allow rules
continue to work.  Existing
polices explicitly not allowing them and relying on SELinux to block changes on
the close-on-exec flag are already broken due to the bypasses via
fnctl(2) and dup(2).

>
> Demi, are you able to respin this patch with policy capability changes?
>
> --
> paul-moore.com
