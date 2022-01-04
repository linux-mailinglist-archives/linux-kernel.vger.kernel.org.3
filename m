Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24771483E26
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 09:33:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234131AbiADIdR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 03:33:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232221AbiADIdQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 03:33:16 -0500
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04758C061761
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jan 2022 00:33:16 -0800 (PST)
Received: by mail-yb1-xb2b.google.com with SMTP id 139so74413652ybd.3
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jan 2022 00:33:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TuWFLKgXKAg1DcZgdzVyLGRZnIepaBtMXoAFbZJAHS8=;
        b=A9/TwBexVxuRcyubf3xirGF93lqxoU2un872R+spPGbQZbTjJEE8KF7hRWixP0+zMG
         Hn6DsWAqhbc3/JbH+i1nZx8APibiQ+17i82oRSeGbPQvoaOZTLiMnAbYo84Te4qkklBN
         hZx+UsTvFlv1BkS4zK2Iac+OqB41ySjQwwfegioSFurbANzW/KtzmgVlHnnGWSKIpK22
         9knVnyOehSPhULliMuu/CGC9UyI1rslKaobbJhMOFk/RU/bRarEc9uPxzQGQbGOO4EEJ
         8JW09oIkHSSJ5SJ6ArBrXjO3A7PkcGP0VFsYWA9lNXNM0Apju/aL0cyvLC6npngjwCpq
         7ZYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TuWFLKgXKAg1DcZgdzVyLGRZnIepaBtMXoAFbZJAHS8=;
        b=W7wnqPzDRIXF/uTJYzR6qLChmbMJwyOETlunvzmst8vNJIbpYHeGp9LlxeHvUi4Ae4
         7Df3MV2Zf9TxuJjm0YY1v4eZ9sVfLO6obEJH/YVZobkuYHai1jUtIt7mdVC8Qx/4CLK0
         egNO0PnOQ8RPLvoc5j7xtFUZhoYjyzUSIZdIiDbn5IQ414XyOCD+aYLLPQed1xPT+j4g
         7NQghIba7j4FWrCs8C9xvay/EenJ1Lqppm3AHxzLgM0scW7FENMrnZVZctsQhRKaNnMd
         kR2tq8TiZUSSU9ARm0Fen7WT+kYBuaAHKeuZpeGXybi5xwEAaVMLHnmC++kZHBSRWzTt
         oaCw==
X-Gm-Message-State: AOAM532SIdlwJBpoMM66LYyXk8tyYUFMSTHcUPeLFVTPWBijSt12E3W2
        dq+SslUWcqjDeG6A8X4TsZmfPWYFlvHD8AhAE1eE7w==
X-Google-Smtp-Source: ABdhPJyLUWHTbj3kmUOrVFVX2p/xvOVAwZJKGsV3jkYhHogB0a5l/ObqqgoBvCEYiC2uGB1xiOykcfaOtf0rc/VWODM=
X-Received: by 2002:a25:d195:: with SMTP id i143mr47991658ybg.711.1641285194859;
 Tue, 04 Jan 2022 00:33:14 -0800 (PST)
MIME-Version: 1.0
References: <20220104003722.73982-1-ivan@cloudflare.com> <20220103164443.53b7b8d5@hermes.local>
In-Reply-To: <20220103164443.53b7b8d5@hermes.local>
From:   Eric Dumazet <edumazet@google.com>
Date:   Tue, 4 Jan 2022 00:33:03 -0800
Message-ID: <CANn89i+bLN4=mHxQoWg88_MTaFRkn9FAeCy9dn3b9W+x=jowRQ@mail.gmail.com>
Subject: Re: [PATCH net] tcp: note that tcp_rmem[1] has a limited range
To:     Stephen Hemminger <stephen@networkplumber.org>
Cc:     Ivan Babrou <ivan@cloudflare.com>, netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-team <kernel-team@cloudflare.com>,
        "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 3, 2022 at 4:44 PM Stephen Hemminger
<stephen@networkplumber.org> wrote:
>
> On Mon,  3 Jan 2022 16:37:22 -0800
> Ivan Babrou <ivan@cloudflare.com> wrote:
>
> > The value of rcv_ssthresh is limited to tcp_rwin, which is limited
> > to 64k at the handshake time, since window scaling is not allowed there.
> >
> > Let's add a note to the docs that increasing tcp_rmem[1] does not have
> > any effect on raising the initial value of rcv_ssthresh past 64k.

I guess you have to define what is the initial window.

There seems to be a confusion between rcv_ssthresh and sk_rcvbuf

If you want to document what is rcv_ssthresh and how it relates to sk_rcvbuf,
you probably need more than few lines in Documentation/networking/ip-sysctl.rst

> >
> > Link: https://lkml.org/lkml/2021/12/22/652
> > Signed-off-by: Ivan Babrou <ivan@cloudflare.com>
> > ---
> >  Documentation/networking/ip-sysctl.rst | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/Documentation/networking/ip-sysctl.rst b/Documentation/networking/ip-sysctl.rst
> > index 2572eecc3e86..16528bc92e65 100644
> > --- a/Documentation/networking/ip-sysctl.rst
> > +++ b/Documentation/networking/ip-sysctl.rst
> > @@ -683,7 +683,8 @@ tcp_rmem - vector of 3 INTEGERs: min, default, max
> >       default: initial size of receive buffer used by TCP sockets.
> >       This value overrides net.core.rmem_default used by other protocols.
> >       Default: 131072 bytes.
> > -     This value results in initial window of 65535.
> > +     This value results in initial window of 65535. Increasing this value
> > +     won't raise the initial advertised window above 65535.
> >
> >       max: maximal size of receive buffer allowed for automatically
> >       selected receiver buffers for TCP socket. This value does not override
>
> Why not add error check or warning in write to sysctl?

Please do not. We set this sysctl to 0.5 MB
DRS is known to have quantization artifacts.
