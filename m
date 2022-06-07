Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8458E53F805
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 10:18:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238117AbiFGISm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 04:18:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238110AbiFGISj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 04:18:39 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C1682DAB2
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 01:18:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DB1D4B81DCE
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 08:18:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 395B1C3411C;
        Tue,  7 Jun 2022 08:18:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654589910;
        bh=SQc9ZQvKbAS8SE0fRcfUgLsQN2D9074hUVTtRfwimCA=;
        h=In-Reply-To:References:Cc:From:To:Subject:Date:From;
        b=GVkWsBrHyquVZ0iNXb9LPjIm5HnA62QtToF7pqgKmSjHqfbcadDwoAFgUwqUZMVhR
         8dwuYd6ssmb33pXa6RjpBdY9mjALO9B2BPPMgJ6RsvFIh3+BQlfPEFcJ+6K1Lhonfa
         9aP/JAZm1fFNAT7ViS+BWxvu+qWUG03WX904YC+zjlz7Bj1kfddpmveKLoV7KBsw07
         jS2jWIOKD2Zv1jZ9kXzBeC8BgGohV7uCa/L1cQRQfUVz5CmVG/R9ygFzXLRyyGGlo/
         SDPRtp50Az3Q3fhAxrdfYpSK8rYoS+YBq6qBbQZh72iFZ10U7/hkMNjil7jcXbcPm4
         yxEB5blDQEzbw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220607013844.213446-1-jmaxwell37@gmail.com>
References: <20220607013844.213446-1-jmaxwell37@gmail.com>
Cc:     davem@davemloft.net, cjebpub@gmail.com, jmaxwell37@gmail.com
From:   Antoine Tenart <atenart@kernel.org>
To:     Jon Maxwell <jmaxwell37@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: bpf: fix request_sock leak in filter.c
Message-ID: <165458990767.3884.13816861537144030058@kwain>
Date:   Tue, 07 Jun 2022 10:18:27 +0200
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jon,

This patch is targeted at the networking subsystem, as such (see the
"NETWORKING [GENERAL]" section in MAINTAINERS), you should send it to
netdev@vger.kernel.org and to the networking maintainers (David, Jakub,
Paolo & Eric).

This also fixes an issue and should be targeted at [net] instead of
[net-next]. Because of this you'll also need a Fixes: tag.

Quoting Jon Maxwell (2022-06-07 03:38:44)
> A customer reported a request_socket leak in a Calico cloud environment. =
We=20
> found that a BPF program was doing a socket lookup with takes a refcnt on=
=20
> the socket and that it was finding the request_socket but returning the p=
arent=20
> LISTEN socket via sk_to_full_sk() without decrementing the child request =
socket=20
> 1st, resulting in request_sock slab object leak. This patch retains the=20
> existing behaviour of returning full socks to the caller but it also decr=
ements
> the child request_socket if one is present before doing so to prevent the=
 leak.
>=20
> Thanks to Curtis Taylor for all the help in diagnosing and testing this. =
And=20
> thanks to Antoine Tenart for the reproducer and patch input.
>=20
> Signed-off-by: Jon Maxwell <jmaxwell37@gmail.com>
> Tested-by: Curtis Taylor <cjebpub@gmail.com>
> Co-developed-by: Antoine Tenart <atenart@kernel.org>

You need to put my SoB here when using the above tag. You'll also need
to put your SoB at the end of all the above tags instead of the top.

> @@ -6514,13 +6514,14 @@ __bpf_sk_lookup(struct sk_buff *skb, struct bpf_s=
ock_tuple *tuple, u32 len,
>  {
>         struct sock *sk =3D __bpf_skc_lookup(skb, tuple, len, caller_net,
>                                            ifindex, proto, netns_id, flag=
s);
> +       struct sock *sk1 =3D sk;
> =20
>         if (sk) {
>                 sk =3D sk_to_full_sk(sk);
> -               if (!sk_fullsock(sk)) {
> -                       sock_gen_put(sk);

I'd suggest to add a comment here to explain why sock_gen_put is called
on the original sk.

> +               if (!sk_fullsock(sk1))=20
> +                       sock_gen_put(sk1);
> +               if (!sk_fullsock(sk))
>                         return NULL;
> -               }
>         }
> =20
>         return sk;
> @@ -6551,13 +6552,14 @@ bpf_sk_lookup(struct sk_buff *skb, struct bpf_soc=
k_tuple *tuple, u32 len,
>  {
>         struct sock *sk =3D bpf_skc_lookup(skb, tuple, len, proto, netns_=
id,
>                                          flags);
> +       struct sock *sk1 =3D sk;
> =20
>         if (sk) {
>                 sk =3D sk_to_full_sk(sk);
> -               if (!sk_fullsock(sk)) {
> -                       sock_gen_put(sk);

Ditto.

> +               if (!sk_fullsock(sk1))
> +                       sock_gen_put(sk1);
> +               if (!sk_fullsock(sk))
>                         return NULL;
> -               }
>         }
> =20
>         return sk;

Thanks!
Antoine
