Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6815249FAF6
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 14:39:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348802AbiA1Njx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 08:39:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238016AbiA1Njw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 08:39:52 -0500
Received: from mail-vs1-xe31.google.com (mail-vs1-xe31.google.com [IPv6:2607:f8b0:4864:20::e31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AC57C061714;
        Fri, 28 Jan 2022 05:39:52 -0800 (PST)
Received: by mail-vs1-xe31.google.com with SMTP id g23so3028338vsf.7;
        Fri, 28 Jan 2022 05:39:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mhe3GEpJO2nK1ZxndsPmNrp2c6vjPQdZ5vtf4DHCHDc=;
        b=itgdo0vlshIcywh4CMRbFu5RXMgvayKBB+GOx7pNM7xrT/0YZelH1A4IEueWSM2qhM
         O7Y5BEDfBz5jqaczAD4FmX1NCb3wuMzCMvu/q3X0krx9zdbFcxOYER9R2ped2I5b9EHr
         ITt9oagebCvRpxXmr+rk9OVZSrdI7zxMUT5qPLLThPXbxCFIRG2/iYmefFZSyLocG3P5
         7L8TTb12CSUcWiYsxeMrshkpf3+yALx2DiSx26p1Wc+d5LXDt0YvZgJcXYD32d2se3fp
         29iWrKLRlOIAIIJG6fGg8bcnl9NCNQI8E+6oYGpGcn3W59i2Z1xguafNwkPJ2SXgw8I0
         gEAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mhe3GEpJO2nK1ZxndsPmNrp2c6vjPQdZ5vtf4DHCHDc=;
        b=wzjQf/WpwjRdw47AJkfmW0kZlHXiJ/Gtp0fQOmW4ch5LFjPoqYYdgO3KZb799qqPRR
         m0Z/i5kAUQ2ljb3PMi3kxvexZSpyUN4AZhXT5R8JfqPDYvRQ0t3zKOo0S6LuSjL5MK9Z
         prd95gJFLxC6vTK7Uf1apQVYHb3xSj813x6SbzSFILeKAQ9CRzCgXg0dgX9vLe3VxY8M
         w+Cu7FfRoGeT5fTcefRNTfFLnt2OgWuNFLk8haxmKFT71x7Ug6EBEBYx9cqw8/ugKzAE
         w/gszkfy0gTsL4i6JTyuAhO9Y7iz1WxQLzTKfOssRCQLEkJk67dFWmWcypJ5C5aZzSq2
         +Jxg==
X-Gm-Message-State: AOAM533CdZ9eX1DNQ39MnFPvMFslfzRgNAAMSyap40fBjZqhJlqoxYk2
        SqCJ8PjGniK4Lo/jOoxGexJYYliR25N4qRYS8ZU=
X-Google-Smtp-Source: ABdhPJyDKnPkJ4cGV4kAXz8HUzvSm8CAKKLiVF96wbi/6BD/1reJZW9zUnHQf4MuZqCW1f8iA0VIFdQqHTZIhaCjKjc=
X-Received: by 2002:a67:a64a:: with SMTP id r10mr3843909vsh.76.1643377191253;
 Fri, 28 Jan 2022 05:39:51 -0800 (PST)
MIME-Version: 1.0
References: <CAJjP=Bt52AW_w2sKnM=MbckPkH1hevPMJVWm_Wf+wThmR72YTg@mail.gmail.com>
 <CAH2r5mt_2f==5reyc0HmMLvYJVmP4Enykwauo+LQoFGFbVFeRQ@mail.gmail.com>
 <CAJjP=BvNVOj3KRnhFgk6xiwnxVhxE-sN98-pr6e1Kzc5Xg5EvQ@mail.gmail.com>
 <CAH2r5mvsetx5G+c=8ePh+X8ng7FvMrnuM9+FJ4Sid4b3E+T41Q@mail.gmail.com>
 <CAJjP=BvqZUnJPq=C0OUKbXr=mbJd7a6YDSJC-sNY1j_33_e-uw@mail.gmail.com>
 <CAN05THSGwCKckQoeB6D91iBv0Sed+ethK7tde7GSc1UzS-0OYg@mail.gmail.com>
 <CAJjP=BvcWrF-k_sFxak1mgHAHVVS7_JZow+h_47XB1VzG2+Drw@mail.gmail.com> <ebf8c487-0377-834e-fbb7-725cceae1fbb@leemhuis.info>
In-Reply-To: <ebf8c487-0377-834e-fbb7-725cceae1fbb@leemhuis.info>
From:   Davyd McColl <davydm@gmail.com>
Date:   Fri, 28 Jan 2022 15:39:40 +0200
Message-ID: <CAJjP=BuZsA81yr2J1MxYWiGvr0yLOo70h0-ErgUpi4OZ9z6mjw@mail.gmail.com>
Subject: Re: Possible regression: unable to mount CIFS 1.0 shares from older
 machines since 76a3c92ec9e0668e4cd0e9ff1782eb68f61a179c
To:     Thorsten Leemhuis <regressions@leemhuis.info>
Cc:     ronnie sahlberg <ronniesahlberg@gmail.com>,
        Steve French <smfrench@gmail.com>,
        CIFS <linux-cifs@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thorsten

I definitely haven't forgotten - I'm keeping any kernel updates coming
in patched
so that my stuff continues to work as expected. I've pre-emptively implemented
native CIFS support in my sync app just in case, but I'd really prefer
not to need
it since it's using a rather dormant port of a Java library to .net so
there's no
way that I expect the same level of reliability and functionality as a good old
CIFS mount.

-d

On Fri, 28 Jan 2022 at 15:30, Thorsten Leemhuis
<regressions@leemhuis.info> wrote:
>
> Hi, this is your Linux kernel regression tracker speaking.
>
> Top-posting for once, to make this easy accessible to everyone.
>
> Davyd, Ronnie, and/or Steve: What the status here? It seems after some
> productive debugging back and forth it seems everyone forgot about this.
> Or was progress made somewhere and I just missed it?
>
> Ciao, Thorsten
>
> #regzbot poke
>
>
> On 12.01.22 06:49, Davyd McColl wrote:
> > Hi Ronnie
> >
> > The regular fstab line for this mount is:
> >
> > //mede8er/mede8er  /mnt/mede8er-smb  cifs
> > noauto,guest,users,uid=daf,gid=daf,iocharset=utf8,vers=1.0,nobrl,sec=none
> >  0  0
> >
> > Altering the end of the options from "sec=none" to
> > "username=guest,sec=ntlmssp" or "guest,sec=ntlmssp" results in failure
> > to mount
> > (tested on my patched kernel, which still supports the original fstab
> > line), with dmesg containing:
> >
> > [45753.525219] CIFS: VFS: Use of the less secure dialect vers=1.0 is
> > not recommended unless required for acc
> > ess to very old servers
> > [45753.525222] CIFS: Attempting to mount \\mede8er\mede8er
> > [45756.861351] CIFS: VFS: Unable to select appropriate authentication method!
> > [45756.861361] CIFS: VFS: \\mede8er Send error in SessSetup = -22
> > [45756.861395] CIFS: VFS: cifs_mount failed w/return code = -22
> >
> > There is no way that I know of to set up users for smb auth on this
> > device - it only supports guest connections.
> >
> > -d
> >
> >
> > On Wed, 12 Jan 2022 at 04:32, ronnie sahlberg <ronniesahlberg@gmail.com> wrote:
> >>
> >> Thanks for the network traces.
> >>
> >> In the traces, both win11 and linux are not using even NTLM but the
> >> even older "share password" authentication mode where you specify a
> >> password for the share in the TreeConnect command.
> >> That is something I think we should not support at all.
> >>
> >> What is the exact mount command line you use?
> >> Can you try mounting the share using a username and ntlmssp ?
> >> I.e. username=your-user,sec=ntlmssp  on the mount command
> >>
> >> regards
> >> ronnie sahlberg
> >>
> >> On Wed, Jan 12, 2022 at 6:57 AM Davyd McColl <davydm@gmail.com> wrote:
> >>>
> >>> Hi Steve
> >>>
> >>> As requested, wireshark captures to the device in question, as well as
> >>> the fstab entry I have for the device:
> >>> - win11, browsing with explorer
> >>> - win11, net use
> >>> - unpatched linux 5.16.0 attempt to mount
> >>> - patched linux 5.16.0 successful mount
> >>> - fstab entry - note that I have to specify samba version 1.0 as the
> >>> default has changed and the mount fails otherwise. Explicitly
> >>> specifying 2.0 errors and suggests that I should select a different
> >>> version.
> >>>
> >>> -d
> >>>
> >>> On Tue, 11 Jan 2022 at 00:13, Steve French <smfrench@gmail.com> wrote:
> >>>>
> >>>> I would be surprised if Windows 11 still negotiates (with default
> >>>> registry settings) SMB1 much less NTLMv1 in SMB1, but I have not tried
> >>>> Windows 11 with an NTLMv1 only server (they are hard to find - I may
> >>>> have an original NT4 and an NT3.5 CD somewhere - might be possible to
> >>>> install a VM with NT3.5 but that is really really old and not sure I
> >>>> can find those CDs).
> >>>>
> >>>> Is it possible to send me the wireshark trace (or other network trace)
> >>>> of the failing mount from Linux and also the one with the succeeding
> >>>> NET USE from Windows 11 to the same server?
> >>>>
> >>>> Hopefully it is something unrelated to NTLMv1, there has been a LOT of
> >>>> pushback across the world, across products in making sure no one uses
> >>>> SMB1 anymore.  See e.g.
> >>>> https://techcommunity.microsoft.com/t5/storage-at-microsoft/stop-using-smb1/ba-p/425858
> >>>> and https://twitter.com/nerdpyle/status/776900804712148993
> >>>>
> >>>> On Mon, Jan 10, 2022 at 2:30 PM Davyd McColl <davydm@gmail.com> wrote:
> >>>>>
> >>>>> I don't understand. I tracked down the exact commit where the issue
> >>>>> occurs with a 2 hour git bisect. This was after first confirming that
> >>>>> my older 5.14 kernel did not display the symptoms. I can still connect
> >>>>> to the share via windows 11 explorer. I don't know what else I need to
> >>>>> do here to show where the issue was introduced?
> >>>>>
> >>>>> Apologies for bouncing mails - literally no email client I have seems
> >>>>> to be capable of plaintext emails, so every time I forget, I have to
> >>>>> find a browser with the gmail web interface to reply.
> >>>>>
> >>>>> -d
> >>>>>
> >>>>> On Mon, 10 Jan 2022 at 19:31, Steve French <smfrench@gmail.com> wrote:
> >>>>>>
> >>>>>> I want to make sure that we don't have an unrelated regression
> >>>>>> involved here since NTLMv2 replaced NTLMv1 over 20 years ago (googling
> >>>>>> this e.g. I see "NTLMv2, introduced in Windows NT 4.0 SP4 and natively
> >>>>>> supported in Windows 2000")  and should be the default for Windows
> >>>>>> NT4, Windows 2000 etc. as well as any version of Samba from the last
> >>>>>> 15 years+.  I have significant concerns with adding mechanisms that
> >>>>>> were asked to be disabled ~19 years ago e.g. see
> >>>>>> https://support.microsoft.com/en-us/topic/security-guidance-for-ntlmv1-and-lm-network-authentication-da2168b6-4a31-0088-fb03-f081acde6e73
> >>>>>> due to security concerns.
> >>>>>>
> >>>>>> Can we double check that there are not other issues involved in your example?
> >>>>>>
> >>>>>> The concerns about NTLMv1 security concerns (and why it should never
> >>>>>> be used) are very persuasive e.g. many articles like
> >>>>>> https://miriamxyra.com/2017/11/08/stop-using-lan-manager-and-ntlmv1/
> >>>>>>
> >>>>>> On Mon, Jan 10, 2022 at 7:48 AM Davyd McColl <davydm@gmail.com> wrote:
> >>>>>>>
> >>>>>>> Good day
> >>>>>>>
> >>>>>>> I'm following advice from the thread at
> >>>>>>> https://bugzilla.kernel.org/show_bug.cgi?id=215375 as to how to report
> >>>>>>> this, so please bear with me and redirect me as necessary.
> >>>>>>>
> >>>>>>> Since commit 76a3c92ec9e0668e4cd0e9ff1782eb68f61a179c, I'm unable to
> >>>>>>> mount a CIFS 1.0 share ( from a media player: mede8er med600x3d, which
> >>>>>>> runs some older linux). Apparently I'm not the only one, according to
> >>>>>>> that thread, though the other affected party there is windows-based.
> >>>>>>>
> >>>>>>> I first logged this in the Gentoo bugtracker
> >>>>>>> (https://bugs.gentoo.org/821895) and a reversion patch is available
> >>>>>>> there for the time being.
> >>>>>>>
> >>>>>>> I understand that some of the encryption methods upon which the
> >>>>>>> original feature relied are to be removed and, as such, the ability to
> >>>>>>> mount these older shares was removed. This is sure to affect anyone
> >>>>>>> running older Windows virtual machines (or older, internally-visible
> >>>>>>> windows hosts) in addition to anyone attempting to connect to shares
> >>>>>>> from esoteric devices like mine.
> >>>>>>>
> >>>>>>> Whilst I understand the desire to clean up code and remove dead
> >>>>>>> branches, I'd really appreciate it if this particular feature remains
> >>>>>>> available either by kernel configuration (which suits me fine, but is
> >>>>>>> likely to be a hassle for anyone running a binary distribution) or via
> >>>>>>> boot parameters. In the mean-time, I'm updating my own sync software
> >>>>>>> to support this older device because if I can't sync media to the
> >>>>>>> player, the device is not very useful to me.
> >>>>>>>
> >>>>>>> Thanks
> >>>>>>> -d
> >>>>>>
> >>>>>>
> >>>>>>
> >>>>>> --
> >>>>>> Thanks,
> >>>>>>
> >>>>>> Steve
> >>>>>
> >>>>>
> >>>>>
> >>>>> --
> >>>>> -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
> >>>>> If you say that getting the money is the most important thing
> >>>>> You will spend your life completely wasting your time
> >>>>> You will be doing things you don't like doing
> >>>>> In order to go on living
> >>>>> That is, to go on doing things you don't like doing
> >>>>>
> >>>>> Which is stupid.
> >>>>>
> >>>>> - Alan Watts
> >>>>> https://www.youtube.com/watch?v=-gXTZM_uPMY
> >>>>>
> >>>>> Quidquid latine dictum sit, altum sonatur.
> >>>>
> >>>>
> >>>>
> >>>> --
> >>>> Thanks,
> >>>>
> >>>> Steve
> >>>
> >>>
> >>>
> >>> --
> >>> -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
> >>> If you say that getting the money is the most important thing
> >>> You will spend your life completely wasting your time
> >>> You will be doing things you don't like doing
> >>> In order to go on living
> >>> That is, to go on doing things you don't like doing
> >>>
> >>> Which is stupid.
> >>>
> >>> - Alan Watts
> >>> https://www.youtube.com/watch?v=-gXTZM_uPMY
> >>>
> >>> Quidquid latine dictum sit, altum sonatur.
> >
> >
> >
>


-- 
-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
If you say that getting the money is the most important thing
You will spend your life completely wasting your time
You will be doing things you don't like doing
In order to go on living
That is, to go on doing things you don't like doing

Which is stupid.

- Alan Watts
https://www.youtube.com/watch?v=-gXTZM_uPMY

Quidquid latine dictum sit, altum sonatur.
