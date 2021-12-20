Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAE0247AD44
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 15:51:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235557AbhLTOvD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 09:51:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236800AbhLTOsG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 09:48:06 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C68E6C06137A
        for <linux-kernel@vger.kernel.org>; Mon, 20 Dec 2021 06:44:40 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id w16so10823160edc.11
        for <linux-kernel@vger.kernel.org>; Mon, 20 Dec 2021 06:44:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UgjRXLZ8zEM9swW3S0X0xGPTByoQbXi5jcIJaLiTSAo=;
        b=zYBtr02Jn04mI/25JNzSBEHHTOuaZ+edjlciMIIKqa1v7lbZeGTysCKuBaC5UzxLAd
         mSj3D+o0Pxi0EhtPRw4/WXCnSzelRPY8QEhszcgbi6oWWudcsBSF7t5OiZfI2gL6UkZ3
         u3+uk+6F8CT1w1uepzXiWYeR5NKm/2qw6k418fywg/jdqz31xSe8rO8GmrVJN67XVSyu
         PtmoDr52Xm66RUo4cEwIRR89pqtKKzvAVXq2XIvN3mGKDmCN5TBwHxZeAyLEGMxroXkq
         FAV9I3jiOeInAI8IMH0j0RuKFwJwC/FGBBTgGHxAoEnUHtFpwvz+Xjpur/t7Xw+uMHkO
         fWAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UgjRXLZ8zEM9swW3S0X0xGPTByoQbXi5jcIJaLiTSAo=;
        b=yQiwzF0xfcntxm+XGesb9zawNmFGXRRoz3HHH4rxqz8+odFkhbGqYUgmVrOHjKDut0
         oCf+5uXpTugFLMj7172FTwMgYkw8CiNJ2FM7mi02v3k+Msp/aGUaQbhhgJkpaZn8tx3b
         GeTt5sd6GuyNU+Ygq6t6gJqwdFSvVBEwQrO3odg54qMo5CtzPyzon4DeeryryxPtWZBy
         fNwFm2nDEwk784l8gUFFrRf4hNUg7vmMghL1T68/FRWnTP05HiqbqGe0om4sgsr7U6aO
         BNX5K6eIzHWYtDIWJG17DdlHeu3ZISRyvbXPu7pHvy2EbLOxswLYj1T5oMlcn/fbyNXX
         heWw==
X-Gm-Message-State: AOAM531aSle2PxQdWcOzBzGzqXRYj/unZuDSfMew/2UjmOO6VE29srIM
        8sryezbbxziHOQ/aL7tKkB8kZWdYoRdRb3kh+1V/K2NbLig=
X-Google-Smtp-Source: ABdhPJzEftytyVH4ub2mmS/VCHivbnf+DIGyGTobuYTO/xbrSZfw00I5YKTiJFtqjZckXgJcl3Iou5ZwburLic3fI9g=
X-Received: by 2002:aa7:d619:: with SMTP id c25mr12086494edr.405.1640011479391;
 Mon, 20 Dec 2021 06:44:39 -0800 (PST)
MIME-Version: 1.0
References: <20211213094036.1787950-1-daniel@0x0f.com> <CACRpkdaLt8O4ONZL0vY44gMbuSR_tT3Gkbh9f3sg7m23tUKO2g@mail.gmail.com>
 <CAHp75VfC6mED_yGrHR4Gv3ykL-ckC89s3to5MtW+WSbUPLT0KA@mail.gmail.com>
In-Reply-To: <CAHp75VfC6mED_yGrHR4Gv3ykL-ckC89s3to5MtW+WSbUPLT0KA@mail.gmail.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Mon, 20 Dec 2021 15:44:28 +0100
Message-ID: <CAMRc=MeGMvBMtZd4T-riXB+-FS20bVqfDMPT7z9HOztydF6w_Q@mail.gmail.com>
Subject: Re: [PATCH v3 0/5] gpio: msc313: Add gpio support for ssd20xd
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Daniel Palmer <daniel@0x0f.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 20, 2021 at 2:38 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Thu, Dec 16, 2021 at 11:05 AM Linus Walleij <linus.walleij@linaro.org> wrote:
> > On Mon, Dec 13, 2021 at 10:40 AM Daniel Palmer <daniel@0x0f.com> wrote:
> >
> > > As suggested by Linus I have dropped the DTS commits that were
> > > in the series to add a usage of this code to a target.
> > > If possible can you take the first 4 commits for the GPIO driver
> > > for me? The final DTS commit will go via our tree.
> >
> > Looks to me like patches 1-4 are good to go, but Bartosz
> > must decide if he wants to merge this late in the development
> > cycle.
>
> JFYI, it will be rc8.
>
> --
> With Best Regards,
> Andy Shevchenko

Yep. I'll take those and let them bake in next over Christmas.

Bart
