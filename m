Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED2F448BB68
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 00:26:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346810AbiAKX03 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 18:26:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233873AbiAKX02 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 18:26:28 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B38FC06173F;
        Tue, 11 Jan 2022 15:26:27 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id x6so2084576lfa.5;
        Tue, 11 Jan 2022 15:26:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/jUsT80H33sCWVBf7V2AxrGTqngl2aMqhhu5AjObxr4=;
        b=VxZBVPUkr9/78WX3VfUX8ouO3ghZsnJG6/1bZzIFjC1gheG69Om4GG+8ChF9iD9pP8
         oPejsIL8AR4eYEGD8BlO3/UWtlTY7LEXPH/I9T8uhFxqE69GCcipUvpyxccw1zEZ5XvO
         EHaV/q3xk+6dS/scmpTeLUQ14eypWA+V6gEGxhQOQE2njptlexCJTb1GWTDQFX/teqjT
         euQwrPfv2JvfwlZyWheKsWhWrJOguiaYWyNV0ru0RHchXZlxQuk/53HpAE2z+5vp26tY
         R/XnFMZVrB50P8PMGbQd5psv3JaDIUei7VW/1obBYcJ9yNHDtT/YLXaMx+zuZEK+LmDX
         AWnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/jUsT80H33sCWVBf7V2AxrGTqngl2aMqhhu5AjObxr4=;
        b=2tGFKU358HJQjzkNF43ufOKxB5BFJoQ5WU7VFa8CyZKrv06qiJAOyZEylT0zIQSM+j
         vIdW0s6cj7fA+Ftsw6r+T/c86uhtBH0TcSQwyjz84icc0/opOYvMtPnzH4U8xXnLXG16
         81/w9U/pbnwK92GbjIVOrdZZWIi9KGrNA8MqbkcWLUzNqPbMLHiEGxGmu4a2WCo+C11l
         h6AQlbBNDKpR/i/KnYKzPHVMm2l5eNPynIILZ3wx80Z38EuPwQxdPkof/Cl3TaGTcYYv
         WE/REicb2I3XU6XSluR5D6MwQ6hsYygpcvPKbs6sg54Je7WWbYIrRBjP+Q/WnuxLt/pS
         uUVQ==
X-Gm-Message-State: AOAM532iVufpfKuFqF/nJy4PhQJB7X7nOcz9qZtDsongVSWZ6wVAclmH
        tTuXlGaSWczc94skLZSukXN0wbe+x2pR4pn7n1FN7X2G
X-Google-Smtp-Source: ABdhPJxzpEIx/33ls/2TcEgnmGG92ynGj18k8+i4Y/j+X7AwMae0dwH+RLx9dsMFsA5pl3Wo9CrZ+TkkIXkuRFe3YPY=
X-Received: by 2002:a05:6512:74a:: with SMTP id c10mr5201696lfs.234.1641943585709;
 Tue, 11 Jan 2022 15:26:25 -0800 (PST)
MIME-Version: 1.0
References: <CAJjP=Bt52AW_w2sKnM=MbckPkH1hevPMJVWm_Wf+wThmR72YTg@mail.gmail.com>
 <CAH2r5mt_2f==5reyc0HmMLvYJVmP4Enykwauo+LQoFGFbVFeRQ@mail.gmail.com>
 <CAJjP=BvNVOj3KRnhFgk6xiwnxVhxE-sN98-pr6e1Kzc5Xg5EvQ@mail.gmail.com>
 <CAH2r5mvsetx5G+c=8ePh+X8ng7FvMrnuM9+FJ4Sid4b3E+T41Q@mail.gmail.com>
 <CAJjP=BvqZUnJPq=C0OUKbXr=mbJd7a6YDSJC-sNY1j_33_e-uw@mail.gmail.com> <CAH2r5mserz2O8M5YEwHu=PgCxwDCEBAJkYADUZt9XbQWGTZ2Yg@mail.gmail.com>
In-Reply-To: <CAH2r5mserz2O8M5YEwHu=PgCxwDCEBAJkYADUZt9XbQWGTZ2Yg@mail.gmail.com>
From:   Steve French <smfrench@gmail.com>
Date:   Tue, 11 Jan 2022 17:26:14 -0600
Message-ID: <CAH2r5mvjk02Y1YWUw3r10OLbpcs0=5Wzh6HsZNKK4j9frPQeNQ@mail.gmail.com>
Subject: Re: Possible regression: unable to mount CIFS 1.0 shares from older
 machines since 76a3c92ec9e0668e4cd0e9ff1782eb68f61a179c
To:     Davyd McColl <davydm@gmail.com>
Cc:     CIFS <linux-cifs@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

And trying with sec=ntlmv2 ("raw ntlmv2" instead of encapsulated in
NTLMSSP) looks broken.  This very old server does not advertise
"Extended Security" exchanges (NTLMSSP encapsulation) so this is a
very little used codepath and looks broken

On Tue, Jan 11, 2022 at 3:51 PM Steve French <smfrench@gmail.com> wrote:
>
> Interesting but may be a slightly different issue than NTLMv1
>
> Looking at the wireshark trace the problem looks to be the SMB1 tree
> connect being badly formatted (the share name being corrupted due to
> the password field in the treeconnect being empty) not a problem with
> NTLMv1 authentication on the session setup (although there may be an
> issue when we fix the alignment of tree connect request).
>
> Samba server added SMB2.1 support in Samba version 3.5 back in 2010
> and it looks like yours is Samba 3.0.23 (from 2003) so predates SMB2
> support much less SMB3 and SMB3.1.1 support.
>
> On Tue, Jan 11, 2022 at 12:45 AM Davyd McColl <davydm@gmail.com> wrote:
> >
> > Hi Steve
> >
> > As requested, wireshark captures to the device in question, as well as
> > the fstab entry I have for the device:
> > - win11, browsing with explorer
> > - win11, net use
> > - unpatched linux 5.16.0 attempt to mount
> > - patched linux 5.16.0 successful mount
> > - fstab entry - note that I have to specify samba version 1.0 as the
> > default has changed and the mount fails otherwise. Explicitly
> > specifying 2.0 errors and suggests that I should select a different
> > version.
> >
> > -d
> >
> > On Tue, 11 Jan 2022 at 00:13, Steve French <smfrench@gmail.com> wrote:
> > >
> > > I would be surprised if Windows 11 still negotiates (with default
> > > registry settings) SMB1 much less NTLMv1 in SMB1, but I have not tried
> > > Windows 11 with an NTLMv1 only server (they are hard to find - I may
> > > have an original NT4 and an NT3.5 CD somewhere - might be possible to
> > > install a VM with NT3.5 but that is really really old and not sure I
> > > can find those CDs).
> > >
> > > Is it possible to send me the wireshark trace (or other network trace)
> > > of the failing mount from Linux and also the one with the succeeding
> > > NET USE from Windows 11 to the same server?
> > >
> > > Hopefully it is something unrelated to NTLMv1, there has been a LOT of
> > > pushback across the world, across products in making sure no one uses
> > > SMB1 anymore.  See e.g.
> > > https://techcommunity.microsoft.com/t5/storage-at-microsoft/stop-using-smb1/ba-p/425858
> > > and https://twitter.com/nerdpyle/status/776900804712148993
> > >
> > > On Mon, Jan 10, 2022 at 2:30 PM Davyd McColl <davydm@gmail.com> wrote:
> > > >
> > > > I don't understand. I tracked down the exact commit where the issue
> > > > occurs with a 2 hour git bisect. This was after first confirming that
> > > > my older 5.14 kernel did not display the symptoms. I can still connect
> > > > to the share via windows 11 explorer. I don't know what else I need to
> > > > do here to show where the issue was introduced?
> > > >
> > > > Apologies for bouncing mails - literally no email client I have seems
> > > > to be capable of plaintext emails, so every time I forget, I have to
> > > > find a browser with the gmail web interface to reply.
> > > >
> > > > -d
> > > >
> > > > On Mon, 10 Jan 2022 at 19:31, Steve French <smfrench@gmail.com> wrote:
> > > > >
> > > > > I want to make sure that we don't have an unrelated regression
> > > > > involved here since NTLMv2 replaced NTLMv1 over 20 years ago (googling
> > > > > this e.g. I see "NTLMv2, introduced in Windows NT 4.0 SP4 and natively
> > > > > supported in Windows 2000")  and should be the default for Windows
> > > > > NT4, Windows 2000 etc. as well as any version of Samba from the last
> > > > > 15 years+.  I have significant concerns with adding mechanisms that
> > > > > were asked to be disabled ~19 years ago e.g. see
> > > > > https://support.microsoft.com/en-us/topic/security-guidance-for-ntlmv1-and-lm-network-authentication-da2168b6-4a31-0088-fb03-f081acde6e73
> > > > > due to security concerns.
> > > > >
> > > > > Can we double check that there are not other issues involved in your example?
> > > > >
> > > > > The concerns about NTLMv1 security concerns (and why it should never
> > > > > be used) are very persuasive e.g. many articles like
> > > > > https://miriamxyra.com/2017/11/08/stop-using-lan-manager-and-ntlmv1/
> > > > >
> > > > > On Mon, Jan 10, 2022 at 7:48 AM Davyd McColl <davydm@gmail.com> wrote:
> > > > > >
> > > > > > Good day
> > > > > >
> > > > > > I'm following advice from the thread at
> > > > > > https://bugzilla.kernel.org/show_bug.cgi?id=215375 as to how to report
> > > > > > this, so please bear with me and redirect me as necessary.
> > > > > >
> > > > > > Since commit 76a3c92ec9e0668e4cd0e9ff1782eb68f61a179c, I'm unable to
> > > > > > mount a CIFS 1.0 share ( from a media player: mede8er med600x3d, which
> > > > > > runs some older linux). Apparently I'm not the only one, according to
> > > > > > that thread, though the other affected party there is windows-based.
> > > > > >
> > > > > > I first logged this in the Gentoo bugtracker
> > > > > > (https://bugs.gentoo.org/821895) and a reversion patch is available
> > > > > > there for the time being.
> > > > > >
> > > > > > I understand that some of the encryption methods upon which the
> > > > > > original feature relied are to be removed and, as such, the ability to
> > > > > > mount these older shares was removed. This is sure to affect anyone
> > > > > > running older Windows virtual machines (or older, internally-visible
> > > > > > windows hosts) in addition to anyone attempting to connect to shares
> > > > > > from esoteric devices like mine.
> > > > > >
> > > > > > Whilst I understand the desire to clean up code and remove dead
> > > > > > branches, I'd really appreciate it if this particular feature remains
> > > > > > available either by kernel configuration (which suits me fine, but is
> > > > > > likely to be a hassle for anyone running a binary distribution) or via
> > > > > > boot parameters. In the mean-time, I'm updating my own sync software
> > > > > > to support this older device because if I can't sync media to the
> > > > > > player, the device is not very useful to me.
> > > > > >
> > > > > > Thanks
> > > > > > -d
> > > > >
> > > > >
> > > > >
> > > > > --
> > > > > Thanks,
> > > > >
> > > > > Steve
> > > >
> > > >
> > > >
> > > > --
> > > > -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
> > > > If you say that getting the money is the most important thing
> > > > You will spend your life completely wasting your time
> > > > You will be doing things you don't like doing
> > > > In order to go on living
> > > > That is, to go on doing things you don't like doing
> > > >
> > > > Which is stupid.
> > > >
> > > > - Alan Watts
> > > > https://www.youtube.com/watch?v=-gXTZM_uPMY
> > > >
> > > > Quidquid latine dictum sit, altum sonatur.
> > >
> > >
> > >
> > > --
> > > Thanks,
> > >
> > > Steve
> >
> >
> >
> > --
> > -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
> > If you say that getting the money is the most important thing
> > You will spend your life completely wasting your time
> > You will be doing things you don't like doing
> > In order to go on living
> > That is, to go on doing things you don't like doing
> >
> > Which is stupid.
> >
> > - Alan Watts
> > https://www.youtube.com/watch?v=-gXTZM_uPMY
> >
> > Quidquid latine dictum sit, altum sonatur.
>
>
>
> --
> Thanks,
>
> Steve



-- 
Thanks,

Steve
