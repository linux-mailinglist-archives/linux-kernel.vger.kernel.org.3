Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52581554744
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 14:11:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357653AbiFVLxP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 07:53:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357734AbiFVLxM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 07:53:12 -0400
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E422713D2A
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 04:53:10 -0700 (PDT)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-31772f8495fso159141687b3.4
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 04:53:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cdkJSuyjbr2EQOFoPEFwlniKrWgKWxzaIKhASWgR6lo=;
        b=grBjndnrBLggQNfyCQZEiK731bM02i25bZ++Sjhf5Xfo/5gTnI0z0KljbrQaT+H1YQ
         /9ymdQVAr9FAkXDCU/OWiycMNp/EkHRv0/xOJ5uy2/NrqXTlvAOxRXV43ltskB+yVmCv
         KGMGSnKptmVBtWlKupxBUYzdamJDstM/zPtMrG8Y3fxJimZ7jMTKqFb4gUbUZPgSYgd+
         RKL/W5mAWW5r0ueWnTLLEuSFHAempt5r+5nGJbwN+EmK9eCTCgqBp6BsVbJl/YrUE8VH
         p7hTpNsOD++DyY42Zw+JjtdZBIE/0gbGnNbZrCQ83MYmLsav9irOfLHwKBcpvtTLvD2d
         oPpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cdkJSuyjbr2EQOFoPEFwlniKrWgKWxzaIKhASWgR6lo=;
        b=MuXeHw8eQt2mpzAah13a4z8K52hMbxSlkxLfFRoQ65nISIxmsuausm18T9XasVkLwM
         P2TcDr1u32BqLL9e8ntCR7c2Sba9iHFMGjJVz0yKP0iecDRmhMfZA25HESZmhCkVF25G
         isNWpg8sr3Cnwij4fhx8PiCIJVTWO6clh+VsavRQNGTKPTBYnskBCUVlIaZ0iaY/adI8
         tnRYsIYHcUomKLiMkdRGpTQ3U9UxTVSKPy/zDRaAjlQV01LA571MFQT6dZkaIFmQVGbO
         6f89L2ibCCgLwA+oY/mfPIqmGVMauf1fzDEHAmmNxLOVDWX5NSmZmN6tJVgt5P/YYji3
         SPEA==
X-Gm-Message-State: AJIora90SMeuL+QTeVzOyDTs5diOeLlMi1uO6q1IBCo0rEPERKxLzgie
        vRdtGufkfFXZmGDxnzSArGAj6scDQkjfT7Zsn+YPqg==
X-Google-Smtp-Source: AGRyM1tWPj893Gig5gXXOeELDaxqcWxGPeJnl0HlqSTLfsWgodKEjFifMXzzGTYiqbK4zVsWHaOn6tIogEPEfTBiCNs=
X-Received: by 2002:a0d:df50:0:b0:317:9c40:3b8b with SMTP id
 i77-20020a0ddf50000000b003179c403b8bmr3871970ywe.332.1655898789892; Wed, 22
 Jun 2022 04:53:09 -0700 (PDT)
MIME-Version: 1.0
References: <20220622114912.18351-1-colin.i.king@gmail.com>
In-Reply-To: <20220622114912.18351-1-colin.i.king@gmail.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Wed, 22 Jun 2022 13:52:58 +0200
Message-ID: <CANn89iLNPi3jrSH9wDN4Vkh3aY_Pq3PVMqrmuVzo4hoaxdaRZQ@mail.gmail.com>
Subject: Re: [PATCH][next] raw: remove redundant pointers saddr and daddr
To:     Colin Ian King <colin.i.king@gmail.com>
Cc:     "David S . Miller" <davem@davemloft.net>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        David Ahern <dsahern@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        netdev <netdev@vger.kernel.org>, kernel-janitors@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
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

On Wed, Jun 22, 2022 at 1:49 PM Colin Ian King <colin.i.king@gmail.com> wrote:
>
> Pointers saddr and daddr are being assigned and are never used. The
> pointers are redundant and can be removed.
>
> Cleans up clang scan-build warnings:
> net/ipv6/raw.c:348:3: warning: Value stored to 'saddr' is never read
> net/ipv6/raw.c:349:3: warning: Value stored to 'daddr' is never read
>
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>

Thanks, I have posted this already, with proper tags:

https://patchwork.kernel.org/project/netdevbpf/patch/20220622032303.159394-1-edumazet@google.com/

> ---
>  net/ipv6/raw.c | 3 ---
>  1 file changed, 3 deletions(-)
>
> diff --git a/net/ipv6/raw.c b/net/ipv6/raw.c
> index 46b560aacc11..722de9dd0ff7 100644
> --- a/net/ipv6/raw.c
> +++ b/net/ipv6/raw.c
> @@ -332,7 +332,6 @@ static void rawv6_err(struct sock *sk, struct sk_buff *skb,
>  void raw6_icmp_error(struct sk_buff *skb, int nexthdr,
>                 u8 type, u8 code, int inner_offset, __be32 info)
>  {
> -       const struct in6_addr *saddr, *daddr;
>         struct net *net = dev_net(skb->dev);
>         struct hlist_nulls_head *hlist;
>         struct hlist_nulls_node *hnode;
> @@ -345,8 +344,6 @@ void raw6_icmp_error(struct sk_buff *skb, int nexthdr,
>         sk_nulls_for_each(sk, hnode, hlist) {
>                 /* Note: ipv6_hdr(skb) != skb->data */
>                 const struct ipv6hdr *ip6h = (const struct ipv6hdr *)skb->data;
> -               saddr = &ip6h->saddr;
> -               daddr = &ip6h->daddr;
>
>                 if (!raw_v6_match(net, sk, nexthdr, &ip6h->saddr, &ip6h->daddr,
>                                   inet6_iif(skb), inet6_iif(skb)))
> --
> 2.35.3
>
