Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC75249F1A0
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 04:01:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241856AbiA1DBE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 22:01:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231668AbiA1DBD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 22:01:03 -0500
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF19DC061714
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 19:01:02 -0800 (PST)
Received: by mail-lj1-x230.google.com with SMTP id z20so7077958ljo.6
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 19:01:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=F84DYakvuLBEq/LFB2ws2YNLFQbiWLW7yWyIuFSGm9A=;
        b=P3BDa79Q79WUZxRorc58wRuL9vXb5o3A+Z1yoD1tHD5glgzELmUdkNc48bNqKHcQ+K
         1w9kJSuvvSEwU/Xvcl5MSWgSiAZULCbEkHzU1YIsG/a3JWXKXps3Z+e6Awif8hFqCYFs
         EwHS0haTILGDkXl+dghorZIXNgajMah8fMcCVK7deKhJ4kzxwVxKWmBYzFDeGZx5SYzi
         hTDFiXPl6fTiuwJlruATBthypY8/tdFzcMriHwU3+38Qiy3+bYgOyHh/WAuZFDlkXBDN
         FShj2tWnOdWZO1yTZXHlAgh5yqKOxTsKeU5UgduB6n3ZracgZj7kNO7ancJtIHYJr/jK
         P2jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=F84DYakvuLBEq/LFB2ws2YNLFQbiWLW7yWyIuFSGm9A=;
        b=C+cbDkAddjIU0tkSrqoTtgTz5iLvX+DqKQvHOMGQH3+KhjRLyr3c7OQsvhp+/80/zL
         +nOrTQsRw8UklfIHdRxot7UHdxUWz5uoPG/PFf2paSRr+qY5b+2KBlPP5QA+3ElWwvop
         aYhiSoJMJ/SQp4dYdyLjmXoi9eAgyTHtIdR5U0s1vQo55QkaG/modMtcrU8X2VwS2R6T
         EQ48KGtJWoxoocZr6cqKx9G0NGhuIi0PWsjzvzotA1p7ppEjXnfF7DqvCuuzqXtgxm+C
         mmdThwKrrBCRerHJZSmdldE244ey8oYCqeGEouIR+d9MrkHFspXfoDR1CJVnAyaLRwxI
         davA==
X-Gm-Message-State: AOAM533/s9evxWmZ6zQlf8zIdZ2RdNbmJkmZFKov+sMtqkT1YLnwwFat
        3373Pc3rm4KcrIaoywQL2T0UnHS8myyOtyajokK4wg==
X-Google-Smtp-Source: ABdhPJzqLHEPA7wSh2amBSoys9ADVcZGpARaznHy7BG0OynBIzR4PwT4xJVYpvRpS1tC4bN36yQbOTXPY53moY2C/mc=
X-Received: by 2002:a2e:9f4a:: with SMTP id v10mr4633421ljk.47.1643338861173;
 Thu, 27 Jan 2022 19:01:01 -0800 (PST)
MIME-Version: 1.0
References: <20220128014303.2334568-1-jannh@google.com> <CANn89iKWaERfs1iW8jVyRZT8K1LwWM9efiRsx8E1U3CDT39dyw@mail.gmail.com>
 <CAG48ez0sXEjePefCthFdhDskCFhgcnrecEn2jFfteaqa2qwDnQ@mail.gmail.com>
 <CANn89iKmCYq+WBu_S4OvKOXqRSagTg=t8xKq0WC_Rrw+TpKsbw@mail.gmail.com>
 <CAG48ez2wyQwc5XMKKw8835-4t6+x=X3kPY_CPUqZeh=xQ2krqQ@mail.gmail.com> <CANn89iKVQBDoAwx+yuJ0P0OAV59bav_abh87BA6n7JuzMKMtCQ@mail.gmail.com>
In-Reply-To: <CANn89iKVQBDoAwx+yuJ0P0OAV59bav_abh87BA6n7JuzMKMtCQ@mail.gmail.com>
From:   Jann Horn <jannh@google.com>
Date:   Fri, 28 Jan 2022 04:00:34 +0100
Message-ID: <CAG48ez0WY2WgPjk4zuT5tZdEy_qt+fh+R_XTr21_Vug9a8ggmg@mail.gmail.com>
Subject: Re: [PATCH net] net: dev: Detect dev_hold() after netdev_wait_allrefs()
To:     Eric Dumazet <edumazet@google.com>
Cc:     "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Oliver Neukum <oneukum@suse.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 28, 2022 at 3:53 AM Eric Dumazet <edumazet@google.com> wrote:
> On Thu, Jan 27, 2022 at 6:48 PM Jann Horn <jannh@google.com> wrote:
>
> > When someone is using NET_DEV_REFCNT_TRACKER for slow debugging, they
> > should also be able to take the performance hit of
> > CONFIG_PCPU_DEV_REFCNT and rely on the normal increment-from-zero
> > detection of the generic refcount code, right? (Maybe
> > NET_DEV_REFCNT_TRACKER should depend on !CONFIG_PCPU_DEV_REFCNT?)
>
> NET_DEV_REFCNT_TRACKER is not slow, I think it has neglectable cost really.
> (I could not see any difference in my tests)

Ah, sorry. I misread the Kconfig text.
