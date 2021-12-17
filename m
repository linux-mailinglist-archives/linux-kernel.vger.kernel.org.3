Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDB7A4793FE
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 19:22:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240381AbhLQSWD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 13:22:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240379AbhLQSWC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 13:22:02 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C520BC061574
        for <linux-kernel@vger.kernel.org>; Fri, 17 Dec 2021 10:22:01 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id x15so11186221edv.1
        for <linux-kernel@vger.kernel.org>; Fri, 17 Dec 2021 10:22:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WAExYnt/OSqBYKLoNQ4AMfMk/fL9u+7NT5tSWpjmdI8=;
        b=Gz3n1BxAW3inesRdjZjwP6JY1ZwUBdoGATXe0XPrpheq+iSJDucNfTc+062dhVmHVc
         3NIDxUXfMu2M9QL3MSYtbD035GwY56dlchdATSqZQJ2e/rl/Ct7BcOWYpGOdAagSL8i4
         7fW3eNCzIJn3Nun43PigImUhq7eYmY/4cDQoy2Sp/MOa+iTbS+IGD5TXlLQQ+/Rsp8mf
         +aJscfLJ43dKp1pXBhO9x+xLBnLv7f3w78I12JQWAdryL8AFZ3eYmoWgp124QHRImLM2
         KuaL9SalcryCEYd8CDu854BNZGFNZw0vtUpuhxqgc92fHKVOsaws8H4yN7tgI5eOjqds
         IX/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WAExYnt/OSqBYKLoNQ4AMfMk/fL9u+7NT5tSWpjmdI8=;
        b=gZtzXxYGjF27KQB4e6bOFKNs0EXrPd4cxiUQtdAMrxloAlA6AqvZkkDooAgJjQsqIL
         gijbCGzvd27AhYB4Maiaif95inJWhbOs1hJWDVuuBSwRgzeHh5HECd7ifm4Y5y1szmZe
         uxgg4eJwNTQpaLE9GiKHRWctkLBeFpw7GA0meDOG76lri3zUqGO2kCiazv/SZuE9DL/S
         CWf7yAIYoAdVU4qOZjrn6wFe/Wt3YJB4pMuzVEdgSg3dVLs/InHbbldzeXhi5CRsgjcN
         +fr6+fryeiKJB7RqIe4J5L5Fiebeclhb25+noOFNznp7NXAkNBFyMN4jPVoZhvHAQw45
         z9oQ==
X-Gm-Message-State: AOAM533cSpTE3CTJMiF/zXMj3+OM5btu6a0dxLvn/0lH4+MIivGEngYp
        +dqvIvMHm3fvkQp6+biGumIEXizmTeu42UWSSUp3bA==
X-Google-Smtp-Source: ABdhPJwSx3jl6sTcTWyWeR8F5fIS4c+qncPKlI4kl+b96qON4w38ODCcROcMgFkgkfwg5CovKHtzD3apaG0Bxee0ndE=
X-Received: by 2002:a50:e611:: with SMTP id y17mr4055831edm.270.1639765320363;
 Fri, 17 Dec 2021 10:22:00 -0800 (PST)
MIME-Version: 1.0
References: <20211202210839.79140-1-andriy.shevchenko@linux.intel.com>
 <CAMRc=Mct9FuYvT-0gFrpUuNBnCVdmCp_cNESkL5NSgVVP6vezQ@mail.gmail.com> <YbzUJkCsmkz5jraQ@smile.fi.intel.com>
In-Reply-To: <YbzUJkCsmkz5jraQ@smile.fi.intel.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Fri, 17 Dec 2021 19:21:49 +0100
Message-ID: <CAMRc=Me2_v6tx_LNn2bnHFhXHUm4pXuPen=GdX7SOuKxiSVKDA@mail.gmail.com>
Subject: Re: [PATCH v1 1/3] gpio: Get rid of duplicate of_node assignment in
 the drivers
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 17, 2021 at 7:18 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Fri, Dec 17, 2021 at 05:54:00PM +0100, Bartosz Golaszewski wrote:
> > On Thu, Dec 2, 2021 at 10:17 PM Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
>
> ...
>
> > Queued the series for next, thanks!
>
> Thanks!
>
> I hope that v2 is actually queued. There is a tag from Matti and addressed
> comment from Linus.
>

Yes, I queued v2 of course.

Bart
