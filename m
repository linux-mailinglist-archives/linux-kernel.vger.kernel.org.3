Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF5C6485763
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 18:38:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242381AbiAERhy convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 5 Jan 2022 12:37:54 -0500
Received: from mail-qk1-f181.google.com ([209.85.222.181]:41938 "EHLO
        mail-qk1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242352AbiAERhu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 12:37:50 -0500
Received: by mail-qk1-f181.google.com with SMTP id m2so129202qkd.8;
        Wed, 05 Jan 2022 09:37:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=8iMxZbYhfPLFLAuvqMnsUDcM1IC6NSwNdZv/+r1Rp4Y=;
        b=MHcEdheI0Q2YZ12dJdARtR06TTk0QalqkkZaQuRDTyyipvWyhAPQ9IRGWteCt2HQt2
         RCXI3p6lkz0RUutizgjWUEdBIoqXiTninpZ3Ohi4sYxeqfeGVyrvgzaUJEXbgaorrZy8
         eifrVcNZLk8ohznFPdbgGWW9D7SpBgxtPrKDdUaUhNXRMj6WrGC203OizRA9Nwv+ldC8
         2TZh6nDDNvhx86ZcAbXjCdNwFy2g9PvytYY6OHCMOkfhtdbNUTc2Cq/1GdcYmiXFIB4A
         Y2EmDogfYCWaQHX9uTdTtScVzfwYawGhs5/irqFLQf856ywHPZuFbq3ibmfMBZXvwnsN
         miaw==
X-Gm-Message-State: AOAM533re8+tpUukFwc6FqPAj/gAEoGQUpVsVOJqTZnMf+lnagBUDa7Y
        ohsSMTDknrzYpzsVci4Nt8yIlcGYK2G80lbods4=
X-Google-Smtp-Source: ABdhPJyDibxYQx6ZXe8eRF/pirxkLKXUwRwwLCT3iu3yxbLgxLNS8nlIUrgpSs6otTbM9fnjhlssLhP+3cEw9CFRia4=
X-Received: by 2002:a37:b702:: with SMTP id h2mr39893403qkf.135.1641404269688;
 Wed, 05 Jan 2022 09:37:49 -0800 (PST)
MIME-Version: 1.0
References: <20220104214214.198843-1-paul@crapouillou.net> <20220105101737.00000957@Huawei.com>
 <TLW85R.NW4VI31QKSEJ3@crapouillou.net>
In-Reply-To: <TLW85R.NW4VI31QKSEJ3@crapouillou.net>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 5 Jan 2022 18:37:38 +0100
Message-ID: <CAJZ5v0hmsmBeL4sHLwotsD6VmV3BO=UWzZwEtq-jH0N+53psFQ@mail.gmail.com>
Subject: Re: [PATCH 0/8] DEV_PM_OPS macros rework
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, Len Brown <len.brown@intel.com>,
        Pavel Machek <pavel@ucw.cz>, list@opendingux.net,
        linux-iio@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 5, 2022 at 5:32 PM Paul Cercueil <paul@crapouillou.net> wrote:
>
>
>
> Le mer., janv. 5 2022 at 10:17:37 +0000, Jonathan Cameron
> <Jonathan.Cameron@Huawei.com> a écrit :
> > On Tue, 4 Jan 2022 21:42:06 +0000
> > Paul Cercueil <paul@crapouillou.net> wrote:
> >
> >>  Hi,
> >>
> >>  This set of commits rework a bit the *_DEV_PM_OPS() macros that were
> >>  introduced recently.
> >>
> >>  - Remove the DEFINE_UNIVERSAL_DEV_PM_OPS() macro, since I highly
> >> doubt
> >>    anything is going to use it. The macro it replaces
> >>    (UNIVERSAL_DEV_PM_OPS) seems to only be used incorrectly in code
> >> that
> >>    hasn't been updated in ages.
> >>
> >>  - Remove the static qualifier in DEFINE_SIMPLE_DEV_PM_OPS, so that
> >> the
> >>    macro is more in line with what's done elsewhere in the kernel.
> >>
> >>  - Add a DEFINE_RUNTIME_DEV_PM_OPS() macro, for use with drivers
> >> that use
> >>    runtime PM, and use
> >> runtime_pm_force_suspend/runtime_pm_force_resume
> >>    as their system sleep callbacks.
> >>
> >>  - Add EXPORT_*_DEV_PM_OPS macros, which can be used for when the
> >>    underlying dev_pm_ops is to be exported. With CONFIG_PM set, the
> >>    symbol is exported as you would expect. With CONFIG_PM disabled,
> >> the
> >>    dev_pm_ops is garbage-collected along with the suspend/resume
> >>    callbacks.
> >>
> >>  - Update the two places which used DEFINE_SIMPLE_DEV_PM_OPS, to add
> >> back
> >>    the "static" qualifier that was stripped from the macro.
> >>
> >>  - Update one driver to use EXPORT_RUNTIME_DEV_PM_OPS(), just to
> >> showcase
> >>    how to use this macro in the case where a dev_pm_ops is to be
> >>    exported.
> >>    Note that the driver itself is GPL, and the symbol is only used
> >> within
> >>    a GPL driver, so I would assume the symbol would be exported as
> >> GPL.
> >>    But it was not the case in the original code, so I did not change
> >> the
> >>    behaviour.
> >>
> >>  Feedback welcome.
> >
> > Comments on individual patches (in particular bad pick for that final
> > example ;)
> >
> > Given how late we are in the cycle, I'd argue we 'need' patches 2 (+
> > 5,6 which
> > should probably be all one patch to avoid introducing then fixing a
> > warning in
> > different patches).  The others could wait for the following cycle if
> > needed.
>
> Ok, should I V2 with patches 2/5/6 merged together?

Yes, please!
