Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FE31469821
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 15:10:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245658AbhLFON5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 09:13:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245610AbhLFONz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 09:13:55 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FB36C061746;
        Mon,  6 Dec 2021 06:10:26 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id y12so43215146eda.12;
        Mon, 06 Dec 2021 06:10:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/IPec7LtJmYkQ6UpaUG16Ly1vNlEW8mkXLJ1xbddaTg=;
        b=XKgUbUMjFv+M2VWzFzJhf1ZVh1ulHJYq+AZk+AwgucZIxNMaVJE1bMveuElPmBUQct
         LxgLIfArDUsTlcl4G9OW7xr9A+etS6VT40TIyynIQWCkvU2vUR/S+MhJBRB8knYwG9F6
         srBHtUtcym7o65mlFBJS/ZiAm8BiPaiCZyZd4H5rls1wFNfGM9sFL8IYm0eUeCfugKAS
         kDfpwgj/fXmvpePN35UsusqZmetPcNZDcfNPfv+kX9b29tDe65PMY4RijmLzRmK9Bubw
         7ErG2JcjPziWZhPLn+zmM7EEFML8aeCPl0Axlu6vI7lJCHwwVkzjkEB40EE/3CGnIKT9
         bfxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/IPec7LtJmYkQ6UpaUG16Ly1vNlEW8mkXLJ1xbddaTg=;
        b=PzzGR5rGqpg207QnHaQGp+lZtPy5iOFrFJp3K1o1ryEwJ75UQuNTfosIvng03RgvEM
         9V4ma2qDAN+ycpCgXaOya6AoSheeOQnjRDTHwnbFS2MWx2XmgmF9HD9pMiB65sy2Hv04
         vm16VxhwLineEpEMBD/F0yLa9G8+MWizHvN3LzQAK39SJxBmcn/0i8EJ81cTFYYpa4Ff
         Vd8FeWjfhgSNct5Uw1cAHQ7tfeYUXyeyFgtg6fx7fQeG+YBE1G2Xemnud+HE97bCLLoX
         kGtGmhs8kCmrrOUTohFZ2SQa/YVEkI/i5hUVhJnwP1IFOuHY+Z2HKrZ7KfU3KINkMga9
         Eoxw==
X-Gm-Message-State: AOAM532xWJ4CBDRp6AQOjPGaKCQ+2nzRwa1/Xgx1msHtZHM5ngMhzJhC
        b6d9op4Kn/yO+pYc0u7m1c+a+bgElEKbikAbjwI=
X-Google-Smtp-Source: ABdhPJw6hG9H8pdOhe0jJsZ33UsODZbnl7RQvQ9zWQI2SVAVtqr78k0dOGvwfL1fUpipG4mDLPoDQtQYL/qDtd6TF0A=
X-Received: by 2002:a05:6402:405:: with SMTP id q5mr54957380edv.62.1638799824607;
 Mon, 06 Dec 2021 06:10:24 -0800 (PST)
MIME-Version: 1.0
References: <20211205084419.2382395-1-mudongliangabcd@gmail.com> <Ya4XbbVnK/0Getmt@smile.fi.intel.com>
In-Reply-To: <Ya4XbbVnK/0Getmt@smile.fi.intel.com>
From:   Dongliang Mu <mudongliangabcd@gmail.com>
Date:   Mon, 6 Dec 2021 22:09:58 +0800
Message-ID: <CAD-N9QVhB=C6nKHw4AjfMvZuOA8cGjuYv58nEDwy4eeF-2-iUw@mail.gmail.com>
Subject: Re: [PATCH v2] driver: pmc_atom: free pmc->regmap when pmc_setup_clks fails
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Irina Tirdea <irina.tirdea@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        platform-driver-x86@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 6, 2021 at 10:01 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Sun, Dec 05, 2021 at 04:44:19PM +0800, Dongliang Mu wrote:
> > Smatch reports:
> >
> > drivers/platform/x86/pmc_atom.c:496
> > pmc_setup_dev() warn: 'pmc->regmap' not released on lines: 496.
> >
> > Fix this by deallocating pm->regmap when pmc_setup_clks fails.
> >
> > Fixes: 282a4e4ce5f9("platform/x86: Enable Atom PMC platform clocks")
> > Signed-off-by: Dongliang Mu <mudongliangabcd@gmail.com>
> > ---
>
> It says v2 in the subject, what is in v2 exactly in comparison to v1?

Sorry to forget to add this information

v1->v2: move iounmap(pmc->regmap); from success path to the error handling code.

>
> ...
>
> >       ret = pmc_setup_clks(pdev, pmc->regmap, data);
> > -     if (ret)
> > +     if (ret) {
> > +             iounmap(pmc->regmap);
> >               dev_warn(&pdev->dev, "platform clocks register failed: %d\n",
> >                        ret);
>
> In this case it makes sense to move to
>
>                 dev_err(&pdev->dev, "platform clocks register failed: %d\n", ret);
>
> > +     }
>
> --
> With Best Regards,
> Andy Shevchenko
>
>
