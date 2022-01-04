Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18FC14843F8
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 15:57:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233084AbiADO5Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 09:57:25 -0500
Received: from mail-qt1-f175.google.com ([209.85.160.175]:34707 "EHLO
        mail-qt1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234518AbiADO5U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 09:57:20 -0500
Received: by mail-qt1-f175.google.com with SMTP id o17so34341814qtk.1;
        Tue, 04 Jan 2022 06:57:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WSJgFExu/X7wt2tCNz4jIqrdOE7wTC6/5Y//ZXGA70g=;
        b=l4/UrgaQkblLCgtA4hA2w2HUl34I2FviCZZ+/Fuw57lCRXt6QuiHOldR8710Cut99U
         xNNRfm4vofhigRSZOvFaw+MZn8j6rAtg6Wh++D2Mm+pPGDL4pvokG6LCJMrkFUoqjOji
         Q7U6fji4ejXS2/jcalxoGpToMxt6fu4GvKk1A36h80uJXXqKzG/xo35leEYEljuwQPhH
         DHviEPOO2J7UKfxslXKSeG8E21r/GP3+oRUCTDnqL4p9vFNmzvGNRH4+5frTNnUfITnU
         9xlLJJmtdYRGA7clsVQZlExVi64oGcQaDnKyOs/UxSq+8PLRGriSPNAsl4NULxsyY8Kl
         ZqEQ==
X-Gm-Message-State: AOAM532OEbnDuixp9ANda5R1WcOfvSmePY/Lco0C/oCa239A4pjIAl1W
        SOfCcDCfP9ATG6nB2aXRsraV7l1veT8zPHSG7TVaSMGJ
X-Google-Smtp-Source: ABdhPJxMgNo/xF6dU5+Nzut94xdyfTKHf2qUDqB6uRRKoU2Ihc9s9sMectG5DEeB22/MV2U+0cO/0k+61KwpUMv2L20=
X-Received: by 2002:ac8:7c4e:: with SMTP id o14mr44266202qtv.80.1641308239742;
 Tue, 04 Jan 2022 06:57:19 -0800 (PST)
MIME-Version: 1.0
References: <20220104111551.7f26e893@canb.auug.org.au> <d485fb62-b576-f9b6-13bc-709a2c409240@gmail.com>
 <20220104190220.45c8e0cf@canb.auug.org.au> <c905fd23-19c1-218f-819b-b8ae3434f48c@gmail.com>
In-Reply-To: <c905fd23-19c1-218f-819b-b8ae3434f48c@gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 4 Jan 2022 15:57:08 +0100
Message-ID: <CAJZ5v0i4SNV+NRHW9f0epJu9UAALxD3C3abJjPTJM81Uy292EQ@mail.gmail.com>
Subject: Re: linux-next: build failure after merge of the pm tree
To:     Heiner Kallweit <hkallweit1@gmail.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 4, 2022 at 3:43 PM Heiner Kallweit <hkallweit1@gmail.com> wrote:
>
> On 04.01.2022 09:02, Stephen Rothwell wrote:
> > Hi Heiner,
> >
> > On Tue, 4 Jan 2022 08:29:28 +0100 Heiner Kallweit <hkallweit1@gmail.com> wrote:
> >>
> >> The patch in the pm tree annotating pm_runtime_resume_and_get() as __must_check
> >> follows some fixes of pm_runtime_resume_and_get() usage that went through other
> >> trees. These fixes are in linux-next but don't seem to be in the pm tree.
> >> We talk about:
> >> f04b4fb47d83 ("ASoC: sh: rz-ssi: Check return value of pm_runtime_resume_and_get()")
> >
> > In the sound-asoc tree.
> >
> >> 3d6b661330a7 ("crypto: stm32 - Revert broken pm_runtime_resume_and_get changes")
> >
> > In the crypto tree.
> >
> > Both those are merged into linux-next after the pm tree.  If Linus did
> > the same, the pm tree commit would break his build.  The only way you
> > can have that pm tree commit in linux-next is to ask Andrew Morton to
> > put it in the post linux-next part of his patch series.  Otherwise, it
> > needs to be removed form the pm tree and wait until after the next
> > merge window closes (or at least both the above trees have been merged
> > by Linus).
> >
> Rafael,
> can you take care of this?

Done.

I've dropped the commit in question from pm-core and I'm going to add
it back and submit by the end of the merge window.
