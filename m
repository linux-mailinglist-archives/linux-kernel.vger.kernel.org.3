Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C31E04786D2
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 10:14:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234065AbhLQJOT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 04:14:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234055AbhLQJOS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 04:14:18 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EAA1C06173F
        for <linux-kernel@vger.kernel.org>; Fri, 17 Dec 2021 01:14:18 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id z7so5220853edc.11
        for <linux-kernel@vger.kernel.org>; Fri, 17 Dec 2021 01:14:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=afvs9cxV6+DN35MZPZLfbWczO4mSQLSDs5fWaqi7DIg=;
        b=secagDGADp/iY9V9ymqJ1imVzITkqRHFtVok/Y0hnWA2RupY3QFkcaURVyWWTv+rlw
         IXoeoX3VRdQhXUWa3B24rN4trPU/jtyb2bt4EKxA/HraDA1Log9FUdI+J43CsaBcHD/S
         pZOC5zHjN6gFfQSvJrQnjPYJawCEnDkGzHE83TS6pwvvRk6Jqnl1gyntgbmXrOQYWATZ
         7do6hi16jWqnbOFmp/8BNueOltjMGdj4mA3WvV3Dn2xUeIk8OrTiXKWrMUyhNQR9AJV+
         B5sSm0y7a7ysEKXkRZnF8yfgHj1pLmmG3xxWcWRLoIJINOY+sNsFgawUKNHQc4i46xSN
         WmLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=afvs9cxV6+DN35MZPZLfbWczO4mSQLSDs5fWaqi7DIg=;
        b=kxFdIGP175gCrY5xU2Nfkv+RVXEyhc0AfikzOrqM2RewFpeOivUm1k6R5Hgz4/Pnui
         i+CouE5NIvrBd3oNr8GSQAiXrqFsQ1fSoXapww+KxK3D5WdQcuwlMhVKpZVqKxL1ROF1
         F3687FSn+evXzzCnOVjYfAeYoGPUcMdxVicucYOMsPoGDl+cvkeS+vTVnGn68862opBD
         7rRc9+TXU4b3YAAAlz/aTBXZVjmCTw2WK0xj/7KIJQiE48vFRHHEdZ6J1ogE5NhwPz+u
         z8mF10WyR9Th4dkqbV8DOA0M/UA6fYH224nRMWKCY+wgESIfvAV6hr6mWwISy5zKFHF5
         zwKA==
X-Gm-Message-State: AOAM532EIANjAOEBVv1AWamDTzsl7bPdkfK1FiWavp22mBEv72+huM2P
        huANGUkfF04ur89UDPh6Q5cPr2eC/2ZsK81di9wWkQ==
X-Google-Smtp-Source: ABdhPJzq2gKt6q7R8eSGpv1PxnR3USp3Kk2xUKw1bXXskDXAuoWKtQzCTrsiUSJQgQnyxzBgu686gNH5extokDDr6AQ=
X-Received: by 2002:a17:906:2ac4:: with SMTP id m4mr1847936eje.734.1639732456488;
 Fri, 17 Dec 2021 01:14:16 -0800 (PST)
MIME-Version: 1.0
References: <20211213203112.969238-1-broonie@kernel.org> <b7f4804a-01dd-9dd9-01f1-2187a955cb13@gmail.com>
 <20211217171709.622cbb1d@canb.auug.org.au>
In-Reply-To: <20211217171709.622cbb1d@canb.auug.org.au>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Fri, 17 Dec 2021 10:14:05 +0100
Message-ID: <CAMRc=McDv+dF+=5O16TRtPyph0yRNjPNybQ16Jtzkuew9GibvQ@mail.gmail.com>
Subject: Re: linux-next: build failure after merge of the gpio-brgl tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Xiang wangx <wangxiang@cdjrlc.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 17, 2021 at 7:17 AM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi all,
>
> On Mon, 13 Dec 2021 19:12:05 -0800 Florian Fainelli <f.fainelli@gmail.com> wrote:
> >
> > On 12/13/2021 12:31 PM, broonie@kernel.org wrote:
> > > Hi all,
> > >
> > > After merging the gpio-brgl tree, today's linux-next build (x86_64
> > > allmodconfig) failed like this:
> > >
> > > /tmp/next/build/drivers/gpio/gpio-bcm-kona.c:508:34: error: duplicate 'const' declaration specifier [-Werror=duplicate-decl-specifier]
> > >    508 | static const struct of_device_id const bcm_kona_gpio_of_match[] = {
> > >        |                                  ^~~~~
> > > cc1: all warnings being treated as errors
> > >
> > > Caused by commit
> > >
> > >    19784a059cf47b ("gpio: bcm-kona: add const to of_device_id")
> > >
> > > I used the tree from yesterday instead.
> >
> > Doh! Should have double checked the code as the diff was not giving
> > enough context. This patch should simply be dropped, not even build
> > tested by Xiang it seems.
>
> Today, I have reverted that commit.  Please remove or revert it ASAP.
>
> --
> Cheers,
> Stephen Rothwell

Done, sorry for the delay.

Bartosz
