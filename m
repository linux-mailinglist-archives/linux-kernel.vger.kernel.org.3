Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 339D248A629
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 04:16:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243826AbiAKDQT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 22:16:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231293AbiAKDQS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 22:16:18 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEECBC06173F;
        Mon, 10 Jan 2022 19:16:17 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id m1so18276081lfq.4;
        Mon, 10 Jan 2022 19:16:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tnWatjEgyJ9FaJC0eKyvOWSFHkKwoNBRdfNz32BOWbE=;
        b=pvQgk6WPtiBTpIIyj88Tt/GisS81oFMofetcLKN3sOU6bPpnu0GDVyxIytbhDGZOkN
         eRKNihQzDJUElKaZ4vTc+dQw6CLObT2uqdDjw5srFd7RMIe37sXcGDvjADJiCdi1oeOT
         ssJqESC0Ww4m0+P+evVF5e3MVETSy/0TfrolckyYCiYVcT87vr6myAaFMvHFpL1LhZWh
         NMEP3ja4iIVCAPAOSEZhi8hEtbZ4bvicmK4XxV6/U59gh+cLpmSOxHg3rU+yP8YJWzjM
         T4gBySONopcqtbPh25Sa1xDlOOSbSs5MsuL5A3fKLEE0E4kPyVtf9wxNMkcS64L8bZzR
         yZlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tnWatjEgyJ9FaJC0eKyvOWSFHkKwoNBRdfNz32BOWbE=;
        b=bK9fvm4b+xtf9wyurCf2BSA18FxgF2CHW04NaecH/eqZ752WPKCRa7rkacqEtGCWEM
         yVJ4sAfv9KdI0ycaIV1UWqY8GlacKSBy9QvKEuXHwRz/4ChWdWYE4cTcp3y4LoXluohJ
         91YkpT4+lNaNYR5Zf1QhXR2wDKHpyS05hB+3NsiiIifWUi4PrMo3eM3VM0LRKMJlG6tZ
         caaBvlHDlC7qnowda2D4Lv7/kQpv2GAiFYKS0JPUvFfIHjnYUkVabK1llTQhDYedJpAQ
         xiB+rRIkHXLc+YjsFKDigKhtgVKZAESM0hgc5/lOaPkHhFnFsgUkKlr2P1oXeih1QFx4
         U4Dg==
X-Gm-Message-State: AOAM533jCu6JAm5Zl1qsUjPe8CDHVv7AFPAbIvmVJyy+2mmbpEIpdj69
        AO4hRN4R+xvjrq/BlCfaVONfb1lwteBnwCAKHK3jUibR
X-Google-Smtp-Source: ABdhPJz0pfbIUNFY/jTTUD+wPeqdHZIzltUsCUeAh/QExyS0hTGeCDFj1To+Ow5RM7SA564uZgvAiNV97+dt9BvaT5w=
X-Received: by 2002:a19:8c4a:: with SMTP id i10mr1885122lfj.537.1641870975462;
 Mon, 10 Jan 2022 19:16:15 -0800 (PST)
MIME-Version: 1.0
References: <D58238A4-F04E-458E-AB05-4A74235B2C65@getmailspring.com> <ff982786-4033-7450-c10c-8ce71c28d6eb@leemhuis.info>
In-Reply-To: <ff982786-4033-7450-c10c-8ce71c28d6eb@leemhuis.info>
From:   Steve French <smfrench@gmail.com>
Date:   Mon, 10 Jan 2022 21:16:04 -0600
Message-ID: <CAH2r5mtE-EjNbF3OhCLmbGQFMbJgRZphQHS+hHLBiWRJPEBqKA@mail.gmail.com>
Subject: Re: Possible regression: unable to mount CIFS 1.0 shares from older
 machines since 76a3c92ec9e0668e4cd0e9ff1782eb68f61a179c
To:     Thorsten Leemhuis <regressions@leemhuis.info>
Cc:     Davyd McColl <davydm@gmail.com>,
        "lsahlber@redhat.com" <lsahlber@redhat.com>,
        "stfrench@microsoft.com" <stfrench@microsoft.com>,
        "linux-cifs@vger.kernel.org" <linux-cifs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We do still need a little more data from the users affected to ensure
that it isn't something more subtle.  One user noted Windows 11 worked
as a client, but not Linux which would imply that it is probably
something other than NTLM (NTLM has been strongly discouraged if not
disabled for more than 20 years).

On Mon, Jan 10, 2022 at 9:07 PM Thorsten Leemhuis
<regressions@leemhuis.info> wrote:
>
> Hi, this is your Linux kernel regression tracker speaking.
>
> On 10.01.22 06:53, Davyd McColl wrote:
> >
> > I'm following advice from the thread at
> > https://bugzilla.kernel.org/show_bug.cgi?id=215375
> > <https://bugzilla.kernel.org/show_bug.cgi?id=215375> as to how to report
> > this, so please bear with me and redirect me as necessary.
> >
> > Since commit 76a3c92ec9e0668e4cd0e9ff1782eb68f61a179c,
>
> FWIW, that is "cifs: remove support for NTLM and weaker authentication
> algorithms"
>
> > I'm unable to
> > mount a CIFS 1.0 share ( from a media player: mede8er med600x3d, which
> > runs some older linux). Apparently I'm not the only one, according to
> > that thread, though the other affected party there is windows-based.
> >
> > I first logged this in the Gentoo bugtracker
> > (https://bugs.gentoo.org/821895 <https://bugs.gentoo.org/821895>) and a
> > reversion patch is available there for the time being.
> >
> > I understand that some of the encryption methods upon which the original
> > feature relied are to be removed and, as such, the ability to mount
> > these older shares was removed. This is sure to affect anyone running
> > older Windows virtual machines (or older, internally-visible windows
> > hosts) in addition to anyone attempting to connect to shares from
> > esoteric devices like mine.
>
> > Whilst I understand the desire to clean up code and remove dead
> > branches, I'd really appreciate it if this particular feature remains
> > available either by kernel configuration (which suits me fine, but is
> > likely to be a hassle for anyone running a binary distribution) or via
> > boot parameters. In the mean-time, I'm updating my own sync software to
> > support this older device because if I can't sync media to the player,
> > the device is not very useful to me.
>
> From my point of view this afaics looks like one of those issues where
> the "no regressions" rule gets tricky. But I told Davyd to bring it
> forward here to get it discussed in the open. I also wonder if some
> middle-ground solution could be found in this particular case -- e.g.
> one where the commit stated above gets reverted and the code then
> slightly changed to only allow weaker authentication if the user
> manually requests in somehow, for example using a module parameter or
> something in /proc or /sys.
>
> Ciao, Thorsten
>
> P.S.: Anyway, getting this tracked:
>
> #regzbot ^introduced 76a3c92ec9e0668e4cd0e9ff1782eb68f61a179c
> #regzbot title cifs: unable to shares that require NTLM or weaker
> authentication algorithms
> #regzbot link: https://bugzilla.kernel.org/show_bug.cgi?id=215375



-- 
Thanks,

Steve
