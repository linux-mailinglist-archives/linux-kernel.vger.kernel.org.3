Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A10447969E
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 22:55:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230359AbhLQVzx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 16:55:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229928AbhLQVzw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 16:55:52 -0500
Received: from mail-vk1-xa35.google.com (mail-vk1-xa35.google.com [IPv6:2607:f8b0:4864:20::a35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 545B5C061574;
        Fri, 17 Dec 2021 13:55:52 -0800 (PST)
Received: by mail-vk1-xa35.google.com with SMTP id e27so2418310vkd.4;
        Fri, 17 Dec 2021 13:55:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4ROh+XFIGpiGvMiQOAk5QnIRCcb0UTWBl8//feLa5XY=;
        b=VIbjgrz39uPfk/U8sHbitCJK/EIJKQWNA/5ypkOobmFxnKLlNRe4gsM0kxVxWdXCoz
         GOeSxooJmlYUr2JCmDbFMef98c81jTz7ZTWaZPVE85hMcM7UfR3BVGmQhJhduOBRo2M1
         J7zQ97s5S7I0K8hnK5+ntFBs4iteFIQ5lzDXYXngE816aD75rJMpMdzjwJtWLpnM0UNV
         Y4Wk3UrhlU3OCCS493yeyd+8PIpzgg10683IKorHKkaYGWgN4Y9A0maR6UXIx8hGzLmm
         W6kout63LiF/5YIe1VtgLqWIxrSdjqR4ULm073gwJMc1mz3sCxnAi25ys/KZfLnOhFyV
         tXog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4ROh+XFIGpiGvMiQOAk5QnIRCcb0UTWBl8//feLa5XY=;
        b=4vNs2QfLIK1QZpVDD+Edajc1kJGb9jyzYanjbnC4+9tHlfaSPTa4/WxhgZpG86Zgsb
         9PhIf2P3JpM766BdIpxHDBcvTwjGjUYVTN5yJYOiRoC67zMEEUtZAfjyx98CHb1Z+RCN
         zX3wPkhi6vrD3yp4ClgytAO5J6j3mt398adBZ3Y/kMhFovzdEs83WnXNR8eFDQE4LpHg
         Pc1oAylQETQ0N1EQ3rEIb/+/jsxwiagR0iM+d6qdIYUZuaRzVHdUR8KTGR+6QXwOuv4K
         LMxrHfa2JpF1RcEx5Sq9l+kLAdei/9SAG18B9kcgplo786mNkiOP2iheft+SpR49sFfE
         CbIw==
X-Gm-Message-State: AOAM532pcCfINxyyuYxGOxuK0E3EOzvD3HtChs62r/zgwXonHTmxJZ76
        lHxTW8wMpVT+3SRMz8DiyZPvqal2h6Y76upLWjI=
X-Google-Smtp-Source: ABdhPJy1SbHX5lv+nKt7lJrnrUqHKzMUnFi0uz6ev8NFTmxe+htkTw+S23anR8v1eglOr6qpfhbIzDgd0GwVWSif+d8=
X-Received: by 2002:a05:6122:d05:: with SMTP id az5mr2242229vkb.9.1639778151577;
 Fri, 17 Dec 2021 13:55:51 -0800 (PST)
MIME-Version: 1.0
References: <20211216092651.18878-1-yajun.deng@linux.dev> <CAPhsuW5+sb7S14zaSJQ8FwgGL0F2O_RSuBMXgq_VE68Rnsow4w@mail.gmail.com>
In-Reply-To: <CAPhsuW5+sb7S14zaSJQ8FwgGL0F2O_RSuBMXgq_VE68Rnsow4w@mail.gmail.com>
From:   Daniel Vacek <neelx.g@gmail.com>
Date:   Fri, 17 Dec 2021 22:55:40 +0100
Message-ID: <CAA7rmPFnEkKxH2i4yfEGiZ_ngVme0SfrFhok49_AgqLEcdHicQ@mail.gmail.com>
Subject: Re: [PATCH v2] lib/raid6: Reduce high latency by using migrate
 instead of preempt
To:     Song Liu <song@kernel.org>
Cc:     Yajun Deng <yajun.deng@linux.dev>,
        Paul Menzel <pmenzel@molgen.mpg.de>, williams@redhat.com,
        masahiroy@kernel.org, open list <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        linux-raid <linux-raid@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

NACK. This is a BUG.

--nX

On Fri, Dec 17, 2021 at 1:02 AM Song Liu <song@kernel.org> wrote:
>
> On Thu, Dec 16, 2021 at 1:27 AM Yajun Deng <yajun.deng@linux.dev> wrote:
> >
> > We found an abnormally high latency when executing modprobe raid6_pq, the
> > latency is greater than 1.2s when CONFIG_PREEMPT_VOLUNTARY=y, greater than
> > 67ms when CONFIG_PREEMPT=y, and greater than 16ms when CONFIG_PREEMPT_RT=y.
> >
> > This is caused by ksoftirqd fail to scheduled due to disable preemption,
> > this time is too long and unreasonable.
> >
> > Reduce high latency by using migrate_disabl()/emigrate_enable() instead of
> > preempt_disable()/preempt_enable().
> >
> > How to reproduce:
> >  - Install cyclictest
> >      sudo apt install rt-tests
> >  - Run cyclictest example in one terminal
> >      sudo cyclictest -S -p 95 -d 0 -i 1000 -D 24h -m
> >  - Modprobe raid6_pq in another terminal
> >       sudo modprobe raid6_pq
> >
> > This patch beneficial for CONFIG_PREEMPT=y and CONFIG_PREEMPT_RT=y, but
> > no effect for CONFIG_PREEMPT_VOLUNTARY=y.
> >
> > Fixes: fe5cbc6e06c7 ("md/raid6 algorithms: delta syndrome functions")
> > Fixes: cc4589ebfae6 ("Rename raid6 files now they're in a 'raid6' directory.")
> > Link: https://lore.kernel.org/linux-raid/b06c5e3ef3413f12a2c2b2a241005af9@linux.dev/T/#t
> > Signed-off-by: Yajun Deng <yajun.deng@linux.dev>
>
> Updated the patch and CC'ed stable. It should make to LTS kernels.
>
> Thanks,
> Song
