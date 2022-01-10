Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6ED5D48A286
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 23:13:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345235AbiAJWNd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 17:13:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345164AbiAJWNc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 17:13:32 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF832C06173F;
        Mon, 10 Jan 2022 14:13:31 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id u13so49408478lff.12;
        Mon, 10 Jan 2022 14:13:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ieq7dv/aWm9aM1KPtLo3FbxOQVdndNHUJT3mQWpEQFA=;
        b=qja7uRin4UgefJzICWKI+LJgdlt65KNFDcYD9v2A3kvLysB5jNj6ymowdHHZ2yEeq7
         VONxIM0mCxP+pAJmZO+TpUZ0YAcjJEMEzkl7owgxcHCdhmtY6JWApMyLLlyRuuPQX+4A
         p5CAJ3L+pXsnocn8591Yqb65jFmyj7hRFQLnyJpzxOOR/kPwjQvblfJN5242tWzApBsY
         ThIizEi6FOyJn1vQhOuEPxfErwl2O71aVDg4oikE9ecFaX/KFXjWB71BbGYm1cYPJb+M
         KwiQLMI+nGm6hzjD9JwFegxC42ERchKQ2r+xVXM4KDEY1momRn0ndfIguZqGuEm78MaN
         GLNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ieq7dv/aWm9aM1KPtLo3FbxOQVdndNHUJT3mQWpEQFA=;
        b=FWS7H6axegZvnCIF5bnS3nTnfl3mVSPNVfuRyS/V+qxTuLKO5vBCzOG3dTDF2GzU3x
         bpz63TX0S4z7pSfD4RjOzC3V+YHM/DKZq8Ckm+fMO+u2IOmB3uinKqiMVNZDagnPBuip
         Lq5iQckagmQjBLxL6vnbjNmlZvDyI5eaWLSBWTWfUGm1Xi+hQ95Ii1pl0KyCkgv0EEg9
         AAH+IDFceEgZ8ae5m63X0cZdTNgxMiTdNvSu5Li4+YeDCWrKlTXwYEvUQUMJsRXhdFFa
         FuJRRz0IsTLftqYjTLoPjKNiS50/lEg6OQVBGrHoYU4A/MWdL5d52ao8UuFzu4O/coNO
         zOMA==
X-Gm-Message-State: AOAM531NyS5l2G1UR1XesRUb0GAYTK2fuTyw8hJc5AO0hL4QSToC4Qcb
        JZ6GIadNNYwCfqX6f8OkGPf6X7FL9Cv1sFnC2N4CDm20NsI=
X-Google-Smtp-Source: ABdhPJzWZjjbaqOt2k7mJpNiyJucrgQma/ZCW2gQQNV352osRWIX9F2MymDqq5Fd3SLYj+30ksPekt4lczhePLVJqmk=
X-Received: by 2002:a05:651c:1505:: with SMTP id e5mr979003ljf.398.1641852809757;
 Mon, 10 Jan 2022 14:13:29 -0800 (PST)
MIME-Version: 1.0
References: <CAJjP=Bt52AW_w2sKnM=MbckPkH1hevPMJVWm_Wf+wThmR72YTg@mail.gmail.com>
 <CAH2r5mt_2f==5reyc0HmMLvYJVmP4Enykwauo+LQoFGFbVFeRQ@mail.gmail.com> <CAJjP=BvNVOj3KRnhFgk6xiwnxVhxE-sN98-pr6e1Kzc5Xg5EvQ@mail.gmail.com>
In-Reply-To: <CAJjP=BvNVOj3KRnhFgk6xiwnxVhxE-sN98-pr6e1Kzc5Xg5EvQ@mail.gmail.com>
From:   Steve French <smfrench@gmail.com>
Date:   Mon, 10 Jan 2022 16:13:18 -0600
Message-ID: <CAH2r5mvsetx5G+c=8ePh+X8ng7FvMrnuM9+FJ4Sid4b3E+T41Q@mail.gmail.com>
Subject: Re: Possible regression: unable to mount CIFS 1.0 shares from older
 machines since 76a3c92ec9e0668e4cd0e9ff1782eb68f61a179c
To:     Davyd McColl <davydm@gmail.com>
Cc:     CIFS <linux-cifs@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I would be surprised if Windows 11 still negotiates (with default
registry settings) SMB1 much less NTLMv1 in SMB1, but I have not tried
Windows 11 with an NTLMv1 only server (they are hard to find - I may
have an original NT4 and an NT3.5 CD somewhere - might be possible to
install a VM with NT3.5 but that is really really old and not sure I
can find those CDs).

Is it possible to send me the wireshark trace (or other network trace)
of the failing mount from Linux and also the one with the succeeding
NET USE from Windows 11 to the same server?

Hopefully it is something unrelated to NTLMv1, there has been a LOT of
pushback across the world, across products in making sure no one uses
SMB1 anymore.  See e.g.
https://techcommunity.microsoft.com/t5/storage-at-microsoft/stop-using-smb1/ba-p/425858
and https://twitter.com/nerdpyle/status/776900804712148993

On Mon, Jan 10, 2022 at 2:30 PM Davyd McColl <davydm@gmail.com> wrote:
>
> I don't understand. I tracked down the exact commit where the issue
> occurs with a 2 hour git bisect. This was after first confirming that
> my older 5.14 kernel did not display the symptoms. I can still connect
> to the share via windows 11 explorer. I don't know what else I need to
> do here to show where the issue was introduced?
>
> Apologies for bouncing mails - literally no email client I have seems
> to be capable of plaintext emails, so every time I forget, I have to
> find a browser with the gmail web interface to reply.
>
> -d
>
> On Mon, 10 Jan 2022 at 19:31, Steve French <smfrench@gmail.com> wrote:
> >
> > I want to make sure that we don't have an unrelated regression
> > involved here since NTLMv2 replaced NTLMv1 over 20 years ago (googling
> > this e.g. I see "NTLMv2, introduced in Windows NT 4.0 SP4 and natively
> > supported in Windows 2000")  and should be the default for Windows
> > NT4, Windows 2000 etc. as well as any version of Samba from the last
> > 15 years+.  I have significant concerns with adding mechanisms that
> > were asked to be disabled ~19 years ago e.g. see
> > https://support.microsoft.com/en-us/topic/security-guidance-for-ntlmv1-and-lm-network-authentication-da2168b6-4a31-0088-fb03-f081acde6e73
> > due to security concerns.
> >
> > Can we double check that there are not other issues involved in your example?
> >
> > The concerns about NTLMv1 security concerns (and why it should never
> > be used) are very persuasive e.g. many articles like
> > https://miriamxyra.com/2017/11/08/stop-using-lan-manager-and-ntlmv1/
> >
> > On Mon, Jan 10, 2022 at 7:48 AM Davyd McColl <davydm@gmail.com> wrote:
> > >
> > > Good day
> > >
> > > I'm following advice from the thread at
> > > https://bugzilla.kernel.org/show_bug.cgi?id=215375 as to how to report
> > > this, so please bear with me and redirect me as necessary.
> > >
> > > Since commit 76a3c92ec9e0668e4cd0e9ff1782eb68f61a179c, I'm unable to
> > > mount a CIFS 1.0 share ( from a media player: mede8er med600x3d, which
> > > runs some older linux). Apparently I'm not the only one, according to
> > > that thread, though the other affected party there is windows-based.
> > >
> > > I first logged this in the Gentoo bugtracker
> > > (https://bugs.gentoo.org/821895) and a reversion patch is available
> > > there for the time being.
> > >
> > > I understand that some of the encryption methods upon which the
> > > original feature relied are to be removed and, as such, the ability to
> > > mount these older shares was removed. This is sure to affect anyone
> > > running older Windows virtual machines (or older, internally-visible
> > > windows hosts) in addition to anyone attempting to connect to shares
> > > from esoteric devices like mine.
> > >
> > > Whilst I understand the desire to clean up code and remove dead
> > > branches, I'd really appreciate it if this particular feature remains
> > > available either by kernel configuration (which suits me fine, but is
> > > likely to be a hassle for anyone running a binary distribution) or via
> > > boot parameters. In the mean-time, I'm updating my own sync software
> > > to support this older device because if I can't sync media to the
> > > player, the device is not very useful to me.
> > >
> > > Thanks
> > > -d
> >
> >
> >
> > --
> > Thanks,
> >
> > Steve
>
>
>
> --
> -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
> If you say that getting the money is the most important thing
> You will spend your life completely wasting your time
> You will be doing things you don't like doing
> In order to go on living
> That is, to go on doing things you don't like doing
>
> Which is stupid.
>
> - Alan Watts
> https://www.youtube.com/watch?v=-gXTZM_uPMY
>
> Quidquid latine dictum sit, altum sonatur.



-- 
Thanks,

Steve
