Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8804A477AAF
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 18:34:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240276AbhLPReg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 12:34:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235931AbhLPRef (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 12:34:35 -0500
Received: from mail-ua1-x935.google.com (mail-ua1-x935.google.com [IPv6:2607:f8b0:4864:20::935])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 922C6C061574;
        Thu, 16 Dec 2021 09:34:34 -0800 (PST)
Received: by mail-ua1-x935.google.com with SMTP id 30so48449815uag.13;
        Thu, 16 Dec 2021 09:34:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=1WwsvBOKb5aX+7eqWhUm/uoX6lfXr8RZdkxy0n4Fz4s=;
        b=RDBvdE0bUi5JdAcMg1593mCZMzNOzbQ9WHJ8AcibwrfxBmy/azeOP9tq0sDkERkMnx
         QPGqVKHBrwFMZsekIZSGb67J9U3WMjPaFf1m2SxArhunwy+LKTB+qkR/WFX0hz4uMNJA
         Fz/7FZBXXCieMOxzVRYbYLuKJEgESwOSsRMH4/fB7Gspz/9Ay2SaxeSZkgZh9Xfogyvc
         MQm6xF3dn1PcXKZV5hvyx0jN4SfrEfSeh2YLX8D6LOwDhpu5AInRzHr631xc1zpLXV2K
         ltR5fAsLjR/uY9tspXhsdSpRISfRrh0XPtsqa9HS9Kg2jJIec++di4Z9yn/exj7S2pJ3
         h01w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=1WwsvBOKb5aX+7eqWhUm/uoX6lfXr8RZdkxy0n4Fz4s=;
        b=0u9GdjpiT41daTvmGu9JQJIFaU/o3CPis8lx8oB26/3IKIZXNNvRJVZFwND+9b/veg
         vaZAgcAf+Y13eEjl+fv+KR4XL7EtjyQ+WMWrHsYSZycdDlHdbZZYEM4KkSpGBulR4nBl
         Gvp2+/51O5MbM3iCIsjdH9O3CcMJOz0FOADSc39fg8LviGLexAe2f7uQcHovkZFpr/2Y
         HlbB6++B/z4f6PLhku97CmJjWJy14jZMNv1nK7O2J10Evckj00TI+5hiArCGv4ISOgN2
         u9iLNaT2cMYx4x1F66bgULeecS8S+NayiHRMgxXAI1IRstIkpwQOYMNwhPWtvNVGXiae
         TaNA==
X-Gm-Message-State: AOAM531lpGUm4StIh52bE6tg9Zd4ktzf4mgcUG9cNrbAdh0uGX8F9gw2
        09RchiXXffawRThPZuT6MmXKikTqJFguBtzL1sKci/omp3Q=
X-Google-Smtp-Source: ABdhPJxGuxrBofPK+/tqhZ2EQUieRPUWmqtTJTpLaLexgWTODqhNlP5cHqIDWb8G61IzN89uQmQd9bwu8KOZUIjpMKw=
X-Received: by 2002:a67:eb54:: with SMTP id x20mr6413005vso.18.1639676073726;
 Thu, 16 Dec 2021 09:34:33 -0800 (PST)
MIME-Version: 1.0
References: <20211216105246.3548133-1-daniel@0x0f.com> <CABgxDoKJRc_qORcpFx=eNPS=bGV68hPrbeH0VtcQ2Jjx2ruqmg@mail.gmail.com>
 <CAFr9PX=AAssT1imCfpU_piGBOemD23RGBZzngznyia-4TXrK=g@mail.gmail.com>
In-Reply-To: <CAFr9PX=AAssT1imCfpU_piGBOemD23RGBZzngznyia-4TXrK=g@mail.gmail.com>
From:   Romain Perier <romain.perier@gmail.com>
Date:   Thu, 16 Dec 2021 18:34:21 +0100
Message-ID: <CABgxDoLuOoE5qzzymE-htYz68Nrh8TzZ4d=LgbuNhJs9geevZg@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] ARM: mstar: Initial Miyoo Mini support
To:     Daniel Palmer <daniel@0x0f.com>
Cc:     devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Rob Herring <robh+dt@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,


Le jeu. 16 d=C3=A9c. 2021 =C3=A0 17:15, Daniel Palmer <daniel@0x0f.com> a =
=C3=A9crit :
>
> Hi Romain,
>
> On Fri, 17 Dec 2021 at 00:53, Romain Perier <romain.perier@gmail.com> wro=
te:
> >
> > Hi Daniel,
> >
> > Le jeu. 16 d=C3=A9c. 2021 =C3=A0 11:52, Daniel Palmer <daniel@0x0f.com>=
 a =C3=A9crit :
> >>
> >>   - I've left the link tags as-is as using them for linking
> >>     to background info seems acceptable.
> >
> >
> > https://www.kernel.org/doc/html/latest/maintainer/configure-git.html#cr=
eating-commit-links-to-lore-kernel-org
>
> The explanation of Link seem to have been updated recently in
> 1f57bd42b77cdc4b8e05ba9f4417872a6691b66d
> (https://www.kernel.org/doc/html/latest/process/submitting-patches.html#d=
escribe-your-changes
> a few paragraphs down).
>
> My reading of the paragraph since that commit is: Explain what the
> commit does in the commit message. If there is a bug that prompted the
> change then link it. If there is some background for the commit then
> link it.
>
> If it needs to be changed around I'll do that but I personally think
> it looks nicer. It seems like the right way to provide links to
> datasheets etc without putting a bunch of long messy urls into the
> commit message.

Well, I agree it is confusing. So I have discussed privately about
this with Arnd (on IRC):

<rperier> What is the real usage of the "Link:" tag ? it is mainly
used as background informations for referencing archives or patches on
lore.k.o  , but it can also be used for referencing something else or
not ?
(like information for a board)
[...]
<arnd> right, it's pretty much never wrong to add a Link: tag for the
patch submission that was picked up, but you can also add it for any
other reference, e.g.issue trackers or datasheets that may be relevant

----

Which replies to the question, so it is okay for me ;)

Romain
