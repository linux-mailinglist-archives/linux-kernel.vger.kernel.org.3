Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E56EB466BA7
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 22:26:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243442AbhLBV3q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 16:29:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243209AbhLBV3o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 16:29:44 -0500
Received: from mail-ua1-x92b.google.com (mail-ua1-x92b.google.com [IPv6:2607:f8b0:4864:20::92b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF46AC061757
        for <linux-kernel@vger.kernel.org>; Thu,  2 Dec 2021 13:26:21 -0800 (PST)
Received: by mail-ua1-x92b.google.com with SMTP id j14so1612360uan.10
        for <linux-kernel@vger.kernel.org>; Thu, 02 Dec 2021 13:26:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1Hn9In6dG6/T2rUegQRPLN+LJLRotI0z9a+p2oSgmSw=;
        b=WcLNPe7hi8P0a769XfSLDW7w5eRkULcbKfx7dM8r6rxLfqJDSlKAGrRjzWgWCu1yBE
         FTcMiBj74CHLSYb2X7t8R6PffWxPZxiuRiM0VpHebGEJYZMPWozDd4/1DjJXMN9vz+SU
         9h8aWhii8li6bipguj05vVjcXY1Qe7+iUoCqHjelzow8TIE7G0sP3ExCUascltLi4NTH
         gIifVEf+zJhTBoAYpVxGTLo/G7tGu0Y7stdZkUaamJHkAyiinRIFuv0YGcgPFk7aJj05
         upSI/uq4CmgnoIxwcDoH3RKoNxhNAe0qWfmX2r484uDLtutlPGJ89f8DdLEEWVixhBgs
         g8EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1Hn9In6dG6/T2rUegQRPLN+LJLRotI0z9a+p2oSgmSw=;
        b=3reRUqkwr1MuKtzeRkfvgoF0qg0SbqA4svK0LMQzca7f/hEwEb1uBkz/yD9cql8lV+
         tPFI5FQidLTZNTSOVk/R0XpHPJe07STfRpGcrSI/iAkTX0B8NbpyqUjwHAIkXEPiDOVc
         bEFcUsRrwUrBlhFmNfAHoVE5PWnskj5/3RIFd5kMAOCbLyS3SsCue+ZT1Xf8KeUCSxJh
         N9JE841eJIPWbaZJdNroglL627P6qKErtFvuI5DeS/d+RdKmPqbN+bkpVHP4cvGbwN3H
         KcH+4SO0UCUO7jMHNoZTe9gqJ+PnEPkDsBR6qNx0j/+EVW2gcGWLa4pWDdgEwvSW8G10
         KFUw==
X-Gm-Message-State: AOAM533R/HwpJN87kdbd74v3OsK8AOqmqDmWzSRHdmD+7ftOPdbEx6y2
        tFw0Fmz4fu+/U75dkoQ048oR/LtS9Qs=
X-Google-Smtp-Source: ABdhPJzq9xl4Ok2S2prtzAZ21KTD8bfj5laWQG3dK51objUS7OtsqLUZ15VBPsI9jEaSW1igYLRMgg==
X-Received: by 2002:ab0:7c65:: with SMTP id h5mr18490198uax.138.1638480381076;
        Thu, 02 Dec 2021 13:26:21 -0800 (PST)
Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com. [209.85.221.182])
        by smtp.gmail.com with ESMTPSA id a188sm202209vsa.2.2021.12.02.13.26.19
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Dec 2021 13:26:20 -0800 (PST)
Received: by mail-vk1-f182.google.com with SMTP id b192so514682vkf.3
        for <linux-kernel@vger.kernel.org>; Thu, 02 Dec 2021 13:26:19 -0800 (PST)
X-Received: by 2002:a05:6122:1350:: with SMTP id f16mr19584323vkp.10.1638480379557;
 Thu, 02 Dec 2021 13:26:19 -0800 (PST)
MIME-Version: 1.0
References: <cover.1638282789.git.asml.silence@gmail.com> <CA+FuTSf-N08d6pcbie2=zFcQJf3_e2dBJRUZuop4pOhNfSANUA@mail.gmail.com>
 <0d82f4e2-730f-4888-ec82-2354ffa9c2d8@gmail.com> <CA+FuTSf1dk-ZCN_=oFcYo31XdkLLAaHJHHNfHwJKe01CVq3X+A@mail.gmail.com>
 <6e07fb0c-075b-4072-273b-f9d55ba1e1dd@gmail.com>
In-Reply-To: <6e07fb0c-075b-4072-273b-f9d55ba1e1dd@gmail.com>
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date:   Thu, 2 Dec 2021 16:25:42 -0500
X-Gmail-Original-Message-ID: <CA+FuTSfe63=SuuZeC=eZPLWstgOL6oFUrsL4o+J8=3BwHJSTVg@mail.gmail.com>
Message-ID: <CA+FuTSfe63=SuuZeC=eZPLWstgOL6oFUrsL4o+J8=3BwHJSTVg@mail.gmail.com>
Subject: Re: [RFC 00/12] io_uring zerocopy send
To:     Pavel Begunkov <asml.silence@gmail.com>
Cc:     Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        io-uring@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
        Jonathan Lemon <jonathan.lemon@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        David Ahern <dsahern@kernel.org>, Jens Axboe <axboe@kernel.dk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > What if the ubuf pool can be found from the sk, and the index in that
> > pool is passed as a cmsg?
>
> It looks to me that ubufs are by nature is something that is not
> tightly bound to a socket (at least for io_uring API in the patchset),
> it'll be pretty ugly:
>
> 1) io_uring'd need to care to register the pool in the socket. Having
> multiple rings using the same socket would be horrible. It may be that
> it doesn't make much sense to send in parallel from multiple rings, but
> a per thread io_uring is a popular solution, and then someone would
> want to pass a socket from one thread to another and we'd need to support
> it.
>
> 2) And io_uring would also need to unregister it, so the pool would
> store a list of sockets where it's used, and so referencing sockets
> and then we need to bind it somehow to io_uring fixed files or
> register all that for tracking referencing circular dependencies.
>
> 3) IIRC, we can't add a cmsg entry from the kernel, right? May be wrong,
> but if so I don't like exposing basically io_uring's referencing through
> cmsg. And it sounds io_uring would need to parse cmsg then.
>
>
> A lot of nuances :) I'd really prefer to pass it on per-request basis,

Ok

> it's much cleaner, but still haven't got what's up with msghdr
> initialisation...

And passing the struct through multiple layers of functions.

> Maybe, it's better to add a flags field, which would include
> "msg_control_is_user : 1" and whether msghdr includes msg_iocb, msg_ubuf,
> and everything else that may be optional. Does it sound sane?

If sendmsg takes the argument, it will just have to be initialized, I think.

Other functions are not aware of its existence so it can remain
uninitialized there.
