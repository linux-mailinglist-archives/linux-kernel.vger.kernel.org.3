Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEEF548A0F2
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 21:30:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239405AbiAJUah (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 15:30:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbiAJUag (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 15:30:36 -0500
Received: from mail-ua1-x92e.google.com (mail-ua1-x92e.google.com [IPv6:2607:f8b0:4864:20::92e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50A0DC06173F;
        Mon, 10 Jan 2022 12:30:36 -0800 (PST)
Received: by mail-ua1-x92e.google.com with SMTP id c36so25679099uae.13;
        Mon, 10 Jan 2022 12:30:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KjwlEfaEZLwavEBm+S8MGy4LgsUQCHHjbve5dno97HA=;
        b=dOWRJA9HfeYPASeZGxf/diX6GPE+KYwbaL5V7bugUGobDEGztZzUs0vdRzjwZGBw0y
         aQznFuh3xBaUZVhrlK0dLrakjNzdvLYxjHGa6ji8zgiRwIAJ44bfBciqRguTEmIsTDGu
         2M2kATOfzvBA9d7Qz2wnGCTR1A6Ueh1NmYt1eDTMZdAJCnJyJ5TR7/p1LcXZg9LMs4uF
         /on2mGyF0IYtv5X0m3YPZg5t2Km+xyP77osd4tb68/9GfNonojNifBUOYVHoyh4RXfFx
         1GFEMs9PXXOyxVU2owSGBbChHYbCcv45bnj3JxX/JYfDsO/b8gTgw3RBNzCLHqIRnMzK
         EgHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KjwlEfaEZLwavEBm+S8MGy4LgsUQCHHjbve5dno97HA=;
        b=2Ws44e4jUjfLdKxhYdjOu5zH3fwag3NXquI0ToR4SU7IqtUNXZUlFw9tV8enDHzuQl
         B9qBD2EPsHSjH2dPmukJzEtqcrarBnGZ+/3USEQMPRrUhxqxLEtCPRuMKgdGU+6HMLaY
         2933Vm3TrpihNNZE8DZVPYKhMf3b5ptpRpRM1PAbes6OjQgyjN9VBw4XrBCoV2zCxmVJ
         lRFZlbxZuQeswb2UgGbyy7mVB7ezpWcy4x63rMPCwTvA6s3RzylraFNj/0SqN/TFQ5Mi
         rCORVjlZVMkd/RFOOjMF9MPV1JvnzlYByK3yXzcZYG/oz9eaBxmPOayKT3CxeP06CrSz
         7ytA==
X-Gm-Message-State: AOAM5321WU/tNWNVefp23bNQ15y1rRoSlApawEwIAGbTaLTOLNqMR3/I
        3uWEoIs/KplV09/qvWT12UReIGl+T2TzqjV3NYA=
X-Google-Smtp-Source: ABdhPJxUTufEivknw/XvMn3HtXrWw6z1544Zxos0LaK00zDkrZWPV3sLi6kLdDITsmJOabxeX9SYqTlPpV/E56yd+9Q=
X-Received: by 2002:ab0:2411:: with SMTP id f17mr670841uan.97.1641846635198;
 Mon, 10 Jan 2022 12:30:35 -0800 (PST)
MIME-Version: 1.0
References: <CAJjP=Bt52AW_w2sKnM=MbckPkH1hevPMJVWm_Wf+wThmR72YTg@mail.gmail.com>
 <CAH2r5mt_2f==5reyc0HmMLvYJVmP4Enykwauo+LQoFGFbVFeRQ@mail.gmail.com>
In-Reply-To: <CAH2r5mt_2f==5reyc0HmMLvYJVmP4Enykwauo+LQoFGFbVFeRQ@mail.gmail.com>
From:   Davyd McColl <davydm@gmail.com>
Date:   Mon, 10 Jan 2022 22:30:24 +0200
Message-ID: <CAJjP=BvNVOj3KRnhFgk6xiwnxVhxE-sN98-pr6e1Kzc5Xg5EvQ@mail.gmail.com>
Subject: Re: Possible regression: unable to mount CIFS 1.0 shares from older
 machines since 76a3c92ec9e0668e4cd0e9ff1782eb68f61a179c
To:     Steve French <smfrench@gmail.com>
Cc:     CIFS <linux-cifs@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I don't understand. I tracked down the exact commit where the issue
occurs with a 2 hour git bisect. This was after first confirming that
my older 5.14 kernel did not display the symptoms. I can still connect
to the share via windows 11 explorer. I don't know what else I need to
do here to show where the issue was introduced?

Apologies for bouncing mails - literally no email client I have seems
to be capable of plaintext emails, so every time I forget, I have to
find a browser with the gmail web interface to reply.

-d

On Mon, 10 Jan 2022 at 19:31, Steve French <smfrench@gmail.com> wrote:
>
> I want to make sure that we don't have an unrelated regression
> involved here since NTLMv2 replaced NTLMv1 over 20 years ago (googling
> this e.g. I see "NTLMv2, introduced in Windows NT 4.0 SP4 and natively
> supported in Windows 2000")  and should be the default for Windows
> NT4, Windows 2000 etc. as well as any version of Samba from the last
> 15 years+.  I have significant concerns with adding mechanisms that
> were asked to be disabled ~19 years ago e.g. see
> https://support.microsoft.com/en-us/topic/security-guidance-for-ntlmv1-and-lm-network-authentication-da2168b6-4a31-0088-fb03-f081acde6e73
> due to security concerns.
>
> Can we double check that there are not other issues involved in your example?
>
> The concerns about NTLMv1 security concerns (and why it should never
> be used) are very persuasive e.g. many articles like
> https://miriamxyra.com/2017/11/08/stop-using-lan-manager-and-ntlmv1/
>
> On Mon, Jan 10, 2022 at 7:48 AM Davyd McColl <davydm@gmail.com> wrote:
> >
> > Good day
> >
> > I'm following advice from the thread at
> > https://bugzilla.kernel.org/show_bug.cgi?id=215375 as to how to report
> > this, so please bear with me and redirect me as necessary.
> >
> > Since commit 76a3c92ec9e0668e4cd0e9ff1782eb68f61a179c, I'm unable to
> > mount a CIFS 1.0 share ( from a media player: mede8er med600x3d, which
> > runs some older linux). Apparently I'm not the only one, according to
> > that thread, though the other affected party there is windows-based.
> >
> > I first logged this in the Gentoo bugtracker
> > (https://bugs.gentoo.org/821895) and a reversion patch is available
> > there for the time being.
> >
> > I understand that some of the encryption methods upon which the
> > original feature relied are to be removed and, as such, the ability to
> > mount these older shares was removed. This is sure to affect anyone
> > running older Windows virtual machines (or older, internally-visible
> > windows hosts) in addition to anyone attempting to connect to shares
> > from esoteric devices like mine.
> >
> > Whilst I understand the desire to clean up code and remove dead
> > branches, I'd really appreciate it if this particular feature remains
> > available either by kernel configuration (which suits me fine, but is
> > likely to be a hassle for anyone running a binary distribution) or via
> > boot parameters. In the mean-time, I'm updating my own sync software
> > to support this older device because if I can't sync media to the
> > player, the device is not very useful to me.
> >
> > Thanks
> > -d
>
>
>
> --
> Thanks,
>
> Steve



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
