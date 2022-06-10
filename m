Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C57954680D
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 16:08:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241033AbiFJOIp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 10:08:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349299AbiFJOIm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 10:08:42 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70B42F5AC
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 07:08:41 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id x38so1353497ybd.9
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 07:08:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=PyDV1j65Lx1TNpp+HfLz4mmPCTfG4DwRYS5sO/K+ka8=;
        b=Sdeh8Fo6066+bfOd2m5fJVKaFZzEJ7erlT2qu9MZfJRo/zyyp2dIeM0aBETQyXe1/s
         lJBndoNzAmI4C/EVWjalMxJ/QHsjyg6vZs+MkIxTG+htjfdgvXLvrUMxw9Sr2onWYxqB
         7WEG+czk++2nwPWU3DscC7pbaO5F650hxELX7M/WZHwZxlPa4FZYiNEbn9d4UY9fdFuD
         VJRyXq1wBbArx+Lev+T5fv1vBnwjTiLaFQ8MAYdZQazR0uonpnn1qWyloxZ7unMIE108
         ihpKkBbuJNB+Qs45XTDAef54IuzKgqopy6AgN2iqCl7g+7C73+0MFRA57QPiKBHZqUbX
         pD8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=PyDV1j65Lx1TNpp+HfLz4mmPCTfG4DwRYS5sO/K+ka8=;
        b=H2nfgFZllBTw66+3SetWPJ9ra/8yxYw5yKiQzRjb+O3HcHlYxfc3CPwZfdToFNkgtq
         EM/t8zDP72b1rAe6xqUcxXbOJQeeRd269kGiDFjue/SBfb/pZIvba+jQFMYKPNGrMSeM
         R4l2zUZ3ESHFZ/oyYvb5hVxSEwuPzO35dtgSLMfLDR8oaw7LUh+QJDmFUOgyUK7aiZSd
         0ZAq2+3tCY/q+AAsMZilI0zf7tSl4z5FeG18X/neSJy4ol1H0wWZuZdzV8WSV69ZQDmn
         WvCLBrWNwT5znA7gpHhKCwR8KiVTmB/3e0QHrXUAszeJpu73QB1S8fzpA72Xr56hE77q
         6NaA==
X-Gm-Message-State: AOAM532dMFWdkbi3rTsi6aXoGrsxf9ioo8EDxmRTr+xDMpx47gdiNwvN
        qEB78a/Eoru5obeufBLsQSBTGxyMrEadgK31PXYcmFwOJKScKg==
X-Google-Smtp-Source: ABdhPJygPVRT7z0US6HV++lxmvLlfxhcHVO3Vgdal0mZt/+tPtS7Xx+Lc3STO5t1a7w3CvHR0oCFLEgO9ilfgHl16/Y=
X-Received: by 2002:a05:6902:c9:b0:641:1998:9764 with SMTP id
 i9-20020a05690200c900b0064119989764mr44237460ybs.427.1654870120190; Fri, 10
 Jun 2022 07:08:40 -0700 (PDT)
MIME-Version: 1.0
References: <20220610103653.15261-1-zajec5@gmail.com>
In-Reply-To: <20220610103653.15261-1-zajec5@gmail.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Fri, 10 Jun 2022 07:08:28 -0700
Message-ID: <CANn89iLJwdKXcfCHuEkRT7tknsXpD=UgFh-f61M1UAL9b8JMJw@mail.gmail.com>
Subject: Re: [PATCH] net: gro: respect nf_conntrack_checksum for skipping csum verification
To:     =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Cc:     openwrt-devel@lists.openwrt.org,
        "David S . Miller" <davem@davemloft.net>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        David Ahern <dsahern@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 10, 2022 at 3:37 AM Rafa=C5=82 Mi=C5=82ecki <zajec5@gmail.com> =
wrote:
>
> From: Rafa=C5=82 Mi=C5=82ecki <rafal@milecki.pl>
>
> Netfilter allows disabling checksum verification of incoming packets by
> setting nf_conntrack_checksum variable. That feature is very useful for
> home routers which:
> 1. Most of the time just /forward/ network traffic
> 2. Have slow CPU(s) and csum calculation is a challenge
>
> Some projects like OpenWrt set nf_conntrack_checksum to 0 by default.
>
> It would be nice to allow similar optimization in the GRO code paths.
> This patch simply reuses nf_conntrack_checksum variable to skip
> skb_gro_checksum_validate() calls if applicable.
>

Problem is that GRO will be followed by TSO on the egress side.

TSO will generate segments with recomputed checksums for each one of them.

GRO only keeps one copy of the headers, so does not track original
checksums for all
segments at ingress side.

So if you want to use TSO, GRO has to validate checksums.

I am afraid this nf_conntrack_checksum idea can not be transposed to GRO.

> Signed-off-by: Rafa=C5=82 Mi=C5=82ecki <rafal@milecki.pl>
> ---
> Hi guys,
>
> I'm not very familiar with net subsystem, please let me know if there is
> a better way of implementing such a feature.
> ---
>  net/ipv4/tcp_offload.c   | 3 +++
>  net/ipv6/tcpv6_offload.c | 3 +++
>  2 files changed, 6 insertions(+)
>
> diff --git a/net/ipv4/tcp_offload.c b/net/ipv4/tcp_offload.c
> index 30abde86db45..734a3c0f3d4a 100644
> --- a/net/ipv4/tcp_offload.c
> +++ b/net/ipv4/tcp_offload.c
> @@ -311,6 +311,9 @@ struct sk_buff *tcp4_gro_receive(struct list_head *he=
ad, struct sk_buff *skb)
>  {
>         /* Don't bother verifying checksum if we're going to flush anyway=
. */
>         if (!NAPI_GRO_CB(skb)->flush &&
> +#if IS_ENABLED(CONFIG_NF_CONNTRACK)
> +           dev_net(skb->dev)->ct.sysctl_checksum &&
> +#endif
>             skb_gro_checksum_validate(skb, IPPROTO_TCP,
>                                       inet_gro_compute_pseudo)) {
>                 NAPI_GRO_CB(skb)->flush =3D 1;
> diff --git a/net/ipv6/tcpv6_offload.c b/net/ipv6/tcpv6_offload.c
> index 39db5a226855..2144afa56fa3 100644
> --- a/net/ipv6/tcpv6_offload.c
> +++ b/net/ipv6/tcpv6_offload.c
> @@ -18,6 +18,9 @@ struct sk_buff *tcp6_gro_receive(struct list_head *head=
, struct sk_buff *skb)
>  {
>         /* Don't bother verifying checksum if we're going to flush anyway=
. */
>         if (!NAPI_GRO_CB(skb)->flush &&
> +#if IS_ENABLED(CONFIG_NF_CONNTRACK)
> +           dev_net(skb->dev)->ct.sysctl_checksum &&
> +#endif
>             skb_gro_checksum_validate(skb, IPPROTO_TCP,
>                                       ip6_gro_compute_pseudo)) {
>                 NAPI_GRO_CB(skb)->flush =3D 1;
> --
> 2.34.1
>
