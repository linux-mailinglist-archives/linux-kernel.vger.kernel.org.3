Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9AB24847A8
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 19:20:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236206AbiADSUX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 13:20:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236170AbiADSUT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 13:20:19 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0FC0C061784
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jan 2022 10:20:18 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id k21so83607774lfu.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jan 2022 10:20:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=T90qK5WrIProRXKF6NNglO1QrpHxd/4mhxmZa401pIE=;
        b=hzC6WWrMCZZnON3Pps8dYWInoIrWRr8XyaIWomKCykwky/TndKi6B5JS4x96dYv7Lw
         mvB7jxfylsVmEnNhhwFpEekur00G+XyuJe/0SEbePEexc1hI8PvvxqpnpHqOapJCCwQ2
         mvbA8ixr/8rHLXOWSQLvoStlzCyRmWieZcf33Wqfkf/tw1p0VlvNxFljLVBtyox067D7
         wnBDwSrz4itY+UQF2Mh75EHAtKRPSM30iv83k6sdK2g6A2v9kdtuWoU1pYZfS2vrhNO/
         THbNTifGIkrRd6XYX2i8+IQJ/0YvFic1ZgRLnbxHpv8bepXC/sBJ6CRJuPRw3z+iEPfA
         mmCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=T90qK5WrIProRXKF6NNglO1QrpHxd/4mhxmZa401pIE=;
        b=o7V4E34UaQ8QnAuXz5519DHa+Lvw9Cu1XPujEyG+aYlDIsrKxUYZBiHJtksuiQo26X
         VXc29J/rrJnUyrzsUjSx9rJGMWEK14UtGPsAx6JVoQ5RC9hXWd/wtBqgkRzLik6OEXt2
         CGBf9WaNF1W3wpTtT4SM7hBd98pFLkeD14ZVKvWXV5WOUEObbKvGtkX8EpkBM/g7GVdX
         oNFczPxLUiK3jfFTUxQJmfmRBdYRs3i3DmAuh4ndOD6rF5hmHEmjKNp2QBchNxetluOX
         7ArIrLCvqEg+soDx0S8jXpZWKlB1sjhM0mnZZ7WNakMzjWkksY9NAvgQv/XFTG+IbXzr
         dWaA==
X-Gm-Message-State: AOAM530PPE/pNMdwlBpxcDlUIjph+gLkIcbpq74C4JHfxbFlU5WhUVqi
        FgnQjAG2DxNKsm1JbcJGnjKVjCHo0Vxkh8RRr7x1IQ==
X-Google-Smtp-Source: ABdhPJypw33U6G5rG8rTRnrSCwoXneNV6AvLAVOLne2qf4sGporOzRdQq1RWO5hXnZzFxZmjYVkR27Onq4stAUnh+Uc=
X-Received: by 2002:ac2:446d:: with SMTP id y13mr42503225lfl.210.1641320416701;
 Tue, 04 Jan 2022 10:20:16 -0800 (PST)
MIME-Version: 1.0
References: <63840bf3-2199-3240-bdfa-abb55518b5f9@colorfullife.com>
 <20211223031207.556189-1-chi.minghao@zte.com.cn> <97e94a27-6f9f-1a21-cf3e-11d97f74cbd8@kernel.org>
 <2cfe35d4-3220-dd60-88d3-90b86eb5084a@colorfullife.com>
In-Reply-To: <2cfe35d4-3220-dd60-88d3-90b86eb5084a@colorfullife.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Tue, 4 Jan 2022 10:20:05 -0800
Message-ID: <CALvZod5aTh6ZfQfkHiOhrdRKVxEaMVJ-ixbvD6j9JTLpcQWKzQ@mail.gmail.com>
Subject: Re: [PATCH v2] ipc/sem: do not sleep with a spin lock held
To:     Manfred Spraul <manfred@colorfullife.com>
Cc:     Jiri Slaby <jirislaby@kernel.org>, cgel.zte@gmail.com,
        Andrew Morton <akpm@linux-foundation.org>,
        stable <stable@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        chi.minghao@zte.com.cn, Davidlohr Bueso <dbueso@suse.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>, unixbhaskar@gmail.com,
        Vasily Averin <vvs@virtuozzo.com>, zealci@zte.com.cn
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 3, 2022 at 9:18 AM Manfred Spraul <manfred@colorfullife.com> wrote:
>
> Hi Jiri,
>
> On 1/3/22 10:27, Jiri Slaby wrote:
> > On 23. 12. 21, 4:12, cgel.zte@gmail.com wrote:
> >> From: Minghao Chi <chi.minghao@zte.com.cn>
> >>
> >> We can't call kvfree() with a spin lock held, so defer it.
> >
> > Sorry, defer what?
> >
> First drop the spinlock, then call kvfree().
>
>
> > There are attempts to fix kvfree instead, not sure which of these
> > approaches (fix kvfree or its callers) won in the end?
> >
> Exactly. We have three options - but noone volunteered yet to decide:
>
> - change ipc/sem.c [minimal change]

Let's go with the minimal change for now which can easily be
cherry-picked for the stable tree. It seems other approaches need more
work/discussion.

>
> - change kvfree() to use vfree_atomic() [would also fix other changes
> that did s/kfree/kvfree/]
>
> - Modify the vma handling so that it becomes safe to call vfree() while
> holding a spinlock. [perfect approach, but I'm concerned about side effects]
>
>
> --
>
>      Manfred
>
