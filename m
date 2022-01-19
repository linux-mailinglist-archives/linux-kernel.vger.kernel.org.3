Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10A624931BD
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 01:19:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350399AbiASATK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 19:19:10 -0500
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:47284
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244782AbiASATJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 19:19:09 -0500
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com [209.85.210.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 34E3D40515
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jan 2022 00:19:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1642551548;
        bh=QSCplCLjAh3bK8fuBrxiKgKrA0P0KcoqVOgcqtRLwHE=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=dO1jq4/pu7V7Qr85pdDQ1/ZYgFq6qniknp0d9jxAk0VFJML2+JL2RfzOkPmiY2J0V
         EVWu0yRY+webtJaZej+qmsZIkXq4P4vyyjmBid4dejnbKsR56g7/baTWeSrl5HRDO2
         4RFZHggvZbHmX8tIe1dfg+RWpvTAhyYZWHl/KTb0kBIuha7KJnVP7c6y5p70uZpIyG
         fG8KS/w+s4T4XOdY1BVGOZdY9EAmsgOfqVXP8s4ikuNVkmicGEcdVy0bBxXh0r8UYP
         U9H7e79aHxyPsPzTgF3eEH+mJYMDYrQsO6MtUdgt+c/3ogEwHJPWv+us5B+ZXXRAzV
         CPtCeSp/TUEEg==
Received: by mail-ot1-f70.google.com with SMTP id w8-20020a9d3608000000b0058f5caabe0dso313108otb.21
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jan 2022 16:19:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QSCplCLjAh3bK8fuBrxiKgKrA0P0KcoqVOgcqtRLwHE=;
        b=PX6P/NBvFcPetagdgp32voK9WTnOehgCB031msZ2ZTGWWy1YTAJA2cFphvi7ecq7o3
         LbVaeN2x9g/SUFLOgK0QGHjx78ez6iIkcB66QV8s8osABz2ofms8SgkTgMfZwBRltr/r
         7UKJ1SJnlEPIV19IACX8HSoj9HSSB2hqcOQCNwURgy7+eUbIc5FS1mtaajAjhRU/x1oq
         TtEJ+Ie+BtuXA/04+3XigFWZUIVVcefrajTwGy5ywCbM6WSA565b8+Wv7EXHeLovww25
         lbe6c8dRYqnlx7782pKCNzWQfnnF+f0GNhh8o4EphktxPUtdjXw36N9Y1+I2494IFwbT
         dUUA==
X-Gm-Message-State: AOAM531AKeYoCZM3n5LzfGgqdowGN8S0YIpjF9V0P8fx59BuBQON2jBB
        NvEtL8oWFLmumQx0G6s7kT0EEHybLP5vRQ4qCHGj5o3Z84tmFdl5NpIkVYDHuAz40MiwjyJa3OB
        Gy2GbFx5nLu4sTp5JtN8AIv6+tBQ9tyc9lmkkx6Pk6lBs2/AnCJY97jRtMQ==
X-Received: by 2002:a4a:4994:: with SMTP id z142mr20364633ooa.78.1642551545413;
        Tue, 18 Jan 2022 16:19:05 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwK/qk0KbWw4aZe2tSGjXq4jI8Rl1MTLRatX+XFGTTKTsxvw3z9+j+R4HQU6W1TjVQYUbkgr5oXAPwXmzqbR7s=
X-Received: by 2002:a4a:4994:: with SMTP id z142mr20364618ooa.78.1642551545067;
 Tue, 18 Jan 2022 16:19:05 -0800 (PST)
MIME-Version: 1.0
References: <20220114164904.lgj7yimbei6fmloe@localhost.localdomain>
 <20220114165050.ouw2nknuspclynro@localhost.localdomain> <CAAd53p6KXD2mEHgkU_TpTrsU-vQ9Vxdip+6sPfDaVoSOkmaz-g@mail.gmail.com>
 <20220115163208.xmvum6ehqcadonj7@localhost.localdomain> <CAAd53p64w38NCo7c0cnKCyjaswa0_Rns-CjWBwOnph3V5J2taQ@mail.gmail.com>
 <20220117181112.bmbjcofdjjpsfgzo@localhost.localdomain>
In-Reply-To: <20220117181112.bmbjcofdjjpsfgzo@localhost.localdomain>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Wed, 19 Jan 2022 08:18:52 +0800
Message-ID: <CAAd53p7OWs2ULT10hwC=E7t+KHEidUFMiRmDHGwEM_8+Bib8fA@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] ALSA: hda/realtek: fix speakers and micmute on HP
 855 G8
To:     Alexander Sergeyev <sergeev917@gmail.com>
Cc:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Jeremy Szu <jeremy.szu@canonical.com>,
        Werner Sembach <wse@tuxedocomputers.com>,
        Hui Wang <hui.wang@canonical.com>,
        Cameron Berkenpas <cam@neo-zeon.de>,
        Kailang Yang <kailang@realtek.com>, Sami Loone <sami@loone.fi>,
        Elia Devito <eliadevito@gmail.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 18, 2022 at 2:05 AM Alexander Sergeyev <sergeev917@gmail.com> wrote:
>
> On Mon, Jan 17, 2022 at 08:12:08AM +0800, Kai-Heng Feng wrote:
> > If this issue also happens to cold boot it seems to be a BIOS issue.
>
> I've discussed the problem in more detail [1] before sending the patch.
> In short, speakers seems to reliably work in live Ubuntu which differs in
> using initrd with modules vs UEFI stub with built-in drivers in my case
> (I've tried Ubuntu kernel sources). I've tried using modules as well
> (modprobe'ing the list of modules which are load by Ubuntu) with no
> success.
>
> It was suggested that there is a timing issue somewhere. I'm opened for
> ideas to try to debug the problem origins further (to avoid the need in
> the fixup).

Yes it does sound like a timing issue.
Most system firmwares are only test against Windows.

HP has started to enable Ubuntu on some of their systems, but your
case (EFI stub) is uncovered.

>
> > > > If the issue only happen to warm boot, please try reverting commit
> > > > 9d3fcb28f9b9 "Revert "PM: ACPI: reboot: Use S5 for reboot"".
> > > > Many HP systems requires it to have a functional reboot.
> >
> > If possible, please still give that commit a try.
>
> Well, the first cold boot (with this commit reverted) didn't have any
> sound, the same goes for the subsequent reboot.

Thanks for the testing.

Kai-Heng

>
> [1] https://lkml.org/lkml/2022/1/12/221
