Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81C6F4909A3
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 14:38:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232077AbiAQNiD convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 17 Jan 2022 08:38:03 -0500
Received: from mail-qk1-f173.google.com ([209.85.222.173]:44683 "EHLO
        mail-qk1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230190AbiAQNiB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 08:38:01 -0500
Received: by mail-qk1-f173.google.com with SMTP id t1so2837055qkt.11;
        Mon, 17 Jan 2022 05:38:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Vgyxr7ztzV60Xeh7Q7gRuypGNAwuqlHo855fT6ZQ17E=;
        b=PiUDFWDBmU1+9vD4LZmuVbR65V+lCU9F7loiGmX1eZujZTseE8D/3n5/gK3z/DarOl
         FgwlLnRenmiBBehgtd+rIidprM7p26l03tsCuJVY7kl8KZzV0a1AFr3PCeKYdgLuovtN
         2PdoJ8xqSuQS6GjvwpU+2RKSBgGaWEjWiOCWnzZYMn4Huncw/C10BepaY4pUZy1ldVCa
         kLm/aFCLHPSYgIHItB/kpxYZSi0Y7BaXC1NX5cXIlQOx51n4h7chhUGHKfvEYlERUgzr
         sm+HTEDGRnSwkKCgZAgjiS0Bbv6Wciam5yS9ZNeKlgBX+ghOzHxthf3qvzbvcMBqFNMG
         qZcg==
X-Gm-Message-State: AOAM533pUQzBzSmKA6RUzx1GGUD6jpJgwso7Shooe9JhEx+JDWnegzkK
        XP/hCP60M1k6g83EqfYgI23+N+rJJGNE3PtveCI=
X-Google-Smtp-Source: ABdhPJzgqH7VQOVtjyKwk0O6xlkP5eJCKSaa1kHhuN3q3ZPuNR5LB9Fx/9eQnXEjz8YssSHj1lIGXO8rpmxps9J+78A=
X-Received: by 2002:a05:620a:4714:: with SMTP id bs20mr2943693qkb.8.1642426680287;
 Mon, 17 Jan 2022 05:38:00 -0800 (PST)
MIME-Version: 1.0
References: <20220107181723.54392-1-paul@crapouillou.net> <IKXS5R.AB16PVIGN8Z9@crapouillou.net>
In-Reply-To: <IKXS5R.AB16PVIGN8Z9@crapouillou.net>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 17 Jan 2022 14:37:45 +0100
Message-ID: <CAJZ5v0htDq+qFhEoV+PLQ9_pOy_xa7+rMoaGtqK7QpEbpUDA+Q@mail.gmail.com>
Subject: Re: [PATCH v3 0/6] DEV_PM_OPS macros rework v3
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
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

Hi,

On Sun, Jan 16, 2022 at 1:05 PM Paul Cercueil <paul@crapouillou.net> wrote:
>
> Hi Rafael,
>
> Could patches [1/6] and [2/6] make it to 5.17-rc1, or at least -rc2?

Yes.  I'm going to send a PR with the whole series later today.

> I'm afraid that if these two have to wait for the 5.18 cycle, then I'll
> have more drivers to fix later.
>
> Should I add a Fixes tag maybe?

No need, thanks!

> Le ven., janv. 7 2022 at 18:17:17 +0000, Paul Cercueil
> <paul@crapouillou.net> a écrit :
> > Hi,
> >
> > A V2 of my patchset that tweaks a bit the *_DEV_PM_OPS() macros that
> > were introduced recently.
> >
> > Changes since V2:
> > * [1/6]: - Keep UNIVERSAL_DEV_PM_OPS() macro deprecated
> >          - Rework commit message
> > * [3/6]: - Reorder the code to have non-private macros together in the
> >            file
> >        - Add comment about the necesity to use the new export macro
> >          when the dev_pm_ops has to be exported
> > * [5/6]: Add comment about the necesity to use the new export macro
> >          when the dev_pm_ops has to be exported
> >
> > Cheers,
> > -Paul
> >
> > Paul Cercueil (6):
> >   PM: core: Remove DEFINE_UNIVERSAL_DEV_PM_OPS() macro
> >   PM: core: Remove static qualifier in DEFINE_SIMPLE_DEV_PM_OPS macro
> >   PM: core: Add EXPORT[_GPL]_SIMPLE_DEV_PM_OPS macros
> >   PM: runtime: Add DEFINE_RUNTIME_DEV_PM_OPS() macro
> >   PM: runtime: Add EXPORT[_GPL]_RUNTIME_DEV_PM_OPS macros
> >   iio: pressure: bmp280: Use new PM macros
> >
> >  drivers/iio/pressure/bmp280-core.c | 11 ++----
> >  drivers/iio/pressure/bmp280-i2c.c  |  2 +-
> >  drivers/iio/pressure/bmp280-spi.c  |  2 +-
> >  drivers/mmc/host/jz4740_mmc.c      |  4 +--
> >  drivers/mmc/host/mxcmmc.c          |  2 +-
> >  include/linux/pm.h                 | 55
> > ++++++++++++++++++++++--------
> >  include/linux/pm_runtime.h         | 24 +++++++++++++
> >  7 files changed, 71 insertions(+), 29 deletions(-)
> >
> > --
> > 2.34.1
> >
>
>
