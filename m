Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE02E5551AD
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 18:51:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376896AbiFVQuW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 12:50:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359267AbiFVQs3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 12:48:29 -0400
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFD4663F6
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 09:48:01 -0700 (PDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-3185f5623edso8648727b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 09:48:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Kp/yh5bW8TY1dw8lD/1Ylcedrm+ARISJLh6F2D0W1cA=;
        b=PWBElkZJqkDtHVG9XPIEPuTSazCJ9NORWl85Rkm97/RzMnzrcQgeO45lKXkqhn1Shp
         5QNG+YIhtG/eQi/VWtkTOHwTTZ2vjJmMCzZ8yj68cfd8Pb1/ZuNa7MtPaRdPcpYTXKJN
         j7WXElGkHxpgHHkWcwa/ZKm9/Zvdyi7nUm6oQ3zHuObjUfijkYjrxwDD/TY2t5zoXQ3o
         BDaKDnl5jLDemAWp3iB44WExeyUrjCIoVik7pZkIrBEOeP3MVsCB8arbkG4XHzjKHyc9
         geUWSL9Nnpk9FP+jlnd7alivOiB0Cs4pcpM+lbM4owjdJD5KP2T7A+dWAKPxq+4mW4jk
         Ph5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Kp/yh5bW8TY1dw8lD/1Ylcedrm+ARISJLh6F2D0W1cA=;
        b=yQjY6X8y+i2uqX68lQ2tRmh17JyI0/c1kUBK9YnB8R5O/611kQ0/ULLsrP8mIlTfU0
         E55dPHqfZMma+RWx5F0VV1Ip4EMXOO8JPd6cXKdoXHtuiANCSo5e9LGtJtgnjzuzt6d/
         oxuejNAdmKGaDKShQ0y94APqdbaB5UGf4Nif3KRqWnaL5gtdrG+9a4bP58O3q1kOIsBd
         1jT1IT2kmjXQWHPGOIlJFkwMg/IFsYCEeKjfs7aFSlVblQadvIyKxWcpJINW8xvBpy7S
         lCAIuMkx13QqPxgJ89tI/ZaFNm06FPpKebUpW72YzcP2JlHUUZVJMSmaHtvjZOmY0lUy
         9zRA==
X-Gm-Message-State: AJIora+raoh0G4ceDB1+oJcBX7jjV3bhAF7lmCk4+fsIqXHDby0f5KV5
        81n+V8rpbejuocAFy/6VTHt9Gu+XTU5ayQeCq9Mjdg==
X-Google-Smtp-Source: AGRyM1tWj+cwpVYjfap8gVH72OmUbiehYc/hbn491XF/tfwmgdAP1iGoGe1mWaa9dreJ/2rqLr6HwIcoB6qMIeBf6ak=
X-Received: by 2002:a0d:fac6:0:b0:317:5202:b8c1 with SMTP id
 k189-20020a0dfac6000000b003175202b8c1mr5252536ywf.467.1655916480918; Wed, 22
 Jun 2022 09:48:00 -0700 (PDT)
MIME-Version: 1.0
References: <20220619003919.394622-1-i.maximets@ovn.org> <CANn89iL_EmkEgPAVdhNW4tyzwQbARyji93mUQ9E2MRczWpNm7g@mail.gmail.com>
 <20220622102813.GA24844@breakpoint.cc> <CANn89iLGKbeeBNoDQU9C7nPRCxc6FUsrwn0LfrAKrJiJ14PH+w@mail.gmail.com>
 <c7ab4a7b-a987-e74b-dd2d-ee2c8ca84147@ovn.org> <CANn89iLxqae9wZ-h5M-whSsmAZ_7hW1e_=krvSyF8x89Y6o76w@mail.gmail.com>
 <068ad894-c60f-c089-fd4a-5deda1c84cdd@ovn.org> <CANn89iJ=Xc57pdZ-NaRF7FXZnq2skh5MJ3aDtDCGp8RNG4oowA@mail.gmail.com>
 <CANn89i+yy3mL2BUT=uhhkACVviWXCA9fdE1mrG=ZMuSQKdK8SQ@mail.gmail.com>
In-Reply-To: <CANn89i+yy3mL2BUT=uhhkACVviWXCA9fdE1mrG=ZMuSQKdK8SQ@mail.gmail.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Wed, 22 Jun 2022 18:47:49 +0200
Message-ID: <CANn89iLVHAE5aMwo0dow14mdFK0JjokE9y5KV+67AxKJdSjx=w@mail.gmail.com>
Subject: Re: [PATCH net] net: ensure all external references are released in
 deferred skbuffs
To:     Ilya Maximets <i.maximets@ovn.org>
Cc:     Steffen Klassert <steffen.klassert@secunet.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Florian Westphal <fw@strlen.de>,
        netdev <netdev@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>, dev@openvswitch.org,
        LKML <linux-kernel@vger.kernel.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 22, 2022 at 6:39 PM Eric Dumazet <edumazet@google.com> wrote:
>
> On Wed, Jun 22, 2022 at 6:29 PM Eric Dumazet <edumazet@google.com> wrote:
> >
> > On Wed, Jun 22, 2022 at 4:26 PM Ilya Maximets <i.maximets@ovn.org> wrote:
> > >
> > > On 6/22/22 13:43, Eric Dumazet wrote:
> >
> > >
> > > I tested the patch below and it seems to fix the issue seen
> > > with OVS testsuite.  Though it's not obvious for me why this
> > > happens.  Can you explain a bit more?
> >
> > Anyway, I am not sure we can call nf_reset_ct(skb) that early.
> >
> > git log seems to say that xfrm check needs to be done before
> > nf_reset_ct(skb), I have no idea why.
>
> Additional remark: In IPv6 side, xfrm6_policy_check() _is_ called
> after nf_reset_ct(skb)
>
> Steffen, do you have some comments ?
>
> Some context:
> commit b59c270104f03960069596722fea70340579244d
> Author: Patrick McHardy <kaber@trash.net>
> Date:   Fri Jan 6 23:06:10 2006 -0800
>
>     [NETFILTER]: Keep conntrack reference until IPsec policy checks are done
>
>     Keep the conntrack reference until policy checks have been performed for
>     IPsec NAT support. The reference needs to be dropped before a packet is
>     queued to avoid having the conntrack module unloadable.
>
>     Signed-off-by: Patrick McHardy <kaber@trash.net>
>     Signed-off-by: David S. Miller <davem@davemloft.net>
>

Oh well... __xfrm_policy_check() has :

nf_nat_decode_session(skb, &fl, family);

This  answers my questions.

This means we are probably missing at least one XFRM check in TCP
stack in some cases.
(Only after adding this XFRM check we can call nf_reset_ct(skb))

>
> >
> > I suspect some incoming packets are not going through
> > xfrm4_policy_check() and end up being stored in a TCP receive queue.
> >
> > Maybe something is missing before calling tcp_child_process()
> >
> >
> > >
> > > >
> > > > I note that IPv6 does the nf_reset_ct() earlier, from ip6_protocol_deliver_rcu()
> > > >
> > > > diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
> > > > index fda811a5251f2d76ac24a036e6b4f4e7d7d96d6f..a06464f96fe0cc94dd78272738ddaab2c19e87db
> > > > 100644
> > > > --- a/net/ipv4/tcp_ipv4.c
> > > > +++ b/net/ipv4/tcp_ipv4.c
> > > > @@ -1919,6 +1919,8 @@ int tcp_v4_rcv(struct sk_buff *skb)
> > > >         struct sock *sk;
> > > >         int ret;
> > > >
> > > > +       nf_reset_ct(skb);
> > > > +
> > > >         drop_reason = SKB_DROP_REASON_NOT_SPECIFIED;
> > > >         if (skb->pkt_type != PACKET_HOST)
> > > >                 goto discard_it;
> > > > @@ -2046,8 +2048,6 @@ int tcp_v4_rcv(struct sk_buff *skb)
> > > >         if (drop_reason)
> > > >                 goto discard_and_relse;
> > > >
> > > > -       nf_reset_ct(skb);
> > > > -
> > > >         if (tcp_filter(sk, skb)) {
> > > >                 drop_reason = SKB_DROP_REASON_SOCKET_FILTER;
> > > >                 goto discard_and_relse;
> > >
