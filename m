Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C49C472CB8
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 14:01:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237061AbhLMNBW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 08:01:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233102AbhLMNBV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 08:01:21 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B47F5C06173F
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 05:01:20 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id v1so52225652edx.2
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 05:01:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QrQ1DzOMGrjggzx9mPbx3dF9phhQNDA0afO66vnbZC4=;
        b=VAzMlj6VGLfAlq0zMeOhbHcTO6PClEwjCTaIgrhWrc4QJ2xEqdhBoJ+KxY2w5HazMp
         B+DFQXlq63BhCNK16/KtuJGdy/yXDQm9nAU24ad+jM5gcajRW+5UxuPL5lpepfFsFvCD
         haDR5BGcY5haCBJfBJoVr3tnDn9/ax7bEiwiInpy4lxQfdB4he5iN0dsfCUYh8Em0jxb
         m5ljo7G9OURn6rKVbbh5V7J7OmFkkc4s0V+1tXMyhePzGRoB8/dgyTSbaQUvpG9QKVQj
         4o0LjGHe7nZrNhzRLTH80LcmO9RuaP885/TDWiJ4l9fMuu8o9wnihLrQ8gMLLkh5gG5O
         clzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QrQ1DzOMGrjggzx9mPbx3dF9phhQNDA0afO66vnbZC4=;
        b=7/QT2sqQyp8zgD7/xv1B8iNCR4cUR7aMmn+Vi6/49PuIr0/qOePicsx/MF8UM9kgpT
         YINlJnSAblKeaTnEHHXpCMDM+4Kc36sWJVj0swpO+hCHu1/gVv3Wsl4USfpVcBe4r61+
         v+BwSuUz7hT/QnMOhvdkeafdj1Rh0yAgRW8aRkiGkUNbYto+ZSaEDZw17IHkkRYbKYz2
         IU2jg2qTayoEg/LNr86jM79cI7kGgwUrxFi0U2+IWYvRo9HCP5DplSWXUfoXo99RIg7N
         5cC660EMRB48TUPyIpZsxtCopHz3JD9RE+HE20cQ3/d4iHXJajwDWEv0p/zzX5xiTvzo
         9LpQ==
X-Gm-Message-State: AOAM530uXPvL3zl7zTWghBb5AypY+FBzaFt+P9HYgAQFc1BsFo237mcO
        Sym9W9J7vxtlVkGGqi1Q5uwQKBlu0CML2n71qDyp6Q==
X-Google-Smtp-Source: ABdhPJyLSV8jCtxAuien5xpDzhaMmWmDnMgaqrerXBREYw9IJyjuQ1t30sfwFpSGzWD0HFPR9Wj2bDoeE/sQJ47sJp8=
X-Received: by 2002:a17:907:2d8c:: with SMTP id gt12mr43145864ejc.61.1639400475412;
 Mon, 13 Dec 2021 05:01:15 -0800 (PST)
MIME-Version: 1.0
References: <20211207093412.27833-1-brgl@bgdev.pl> <CACRpkdbAs+ZpU_uQziXmz2inPG7VHD=746MmjmR8iY3szfy9+w@mail.gmail.com>
 <CAMRc=MfWv5bpudpfc2L8Y2HdS+nkXGToSgn6Oovxo4NXxHzHmQ@mail.gmail.com>
In-Reply-To: <CAMRc=MfWv5bpudpfc2L8Y2HdS+nkXGToSgn6Oovxo4NXxHzHmQ@mail.gmail.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Mon, 13 Dec 2021 14:01:04 +0100
Message-ID: <CAMRc=Me=BKcf6FjMpmQ9Mu-2h5DvkhyJ3LDtjSSq9P9Hkb0X4w@mail.gmail.com>
Subject: Re: [PATCH v13 0/7] gpio-sim: configfs-based GPIO simulator
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Kent Gibson <warthog618@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Shuah Khan <shuah@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 10, 2021 at 8:08 PM Bartosz Golaszewski <brgl@bgdev.pl> wrote:
>
> On Thu, Dec 9, 2021 at 1:54 AM Linus Walleij <linus.walleij@linaro.org> wrote:
> >
> > On Tue, Dec 7, 2021 at 10:34 AM Bartosz Golaszewski <brgl@bgdev.pl> wrote:
> >
> > > Hopefully this will be the last iteration of this series. Just some
> > > minor changes requested by Andy in this one.
> > >
> > > Tested both with configfs as well as device-tree.
> >
> > This patch set:
> > Acked-by: Linus Walleij <linus.walleij@linaro.org>
> >
> > Thanks for your perseverance!!
> >
> > Yours,
> > Linus Walleij
>
> Thanks, if there are no objections, I'll queue this series on Monday
> to give it some time in next.
>
> Bart

Queued for v5.17.

Bart
