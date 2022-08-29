Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BD395A5709
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 00:21:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229866AbiH2WVN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 18:21:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229832AbiH2WVK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 18:21:10 -0400
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18A1E7C196
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 15:21:06 -0700 (PDT)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-33dce2d4bc8so230887067b3.4
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 15:21:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=yC7Xn5oBtw6noXWiTwMxITW9fGUbbPFit3BuwbqYikY=;
        b=rbjMIzikOkFtg718VqJL0ohceKlt+MCOFy0LBZwxmorGqOKrAL1O8ljSeN2BpObl7t
         kh6ILRZ7YV00BzIOPJAJZng/RfqomVhVbjIL1ursV3rXAl1HxyPtihZkZGXmqdDyhekX
         HP9MM6TwZBVcpPoAW2FGmWm/R8LOcrqxoVRNec2EC71cfV7Z1yzrNYFtZg2//AOWYNT8
         aYChVlC68fgwynn2foxgINFyeHbFqRPirrJmnD5/X7+PxrpqpuyNu7qlkVbNAV8jgbVt
         CyLw3XmKmUgs9rVyBAw7fHCi9iz55ooz5gkv5QWMpqfFuzW2BEMLwCVRVlPnIKLnRhkj
         EU4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=yC7Xn5oBtw6noXWiTwMxITW9fGUbbPFit3BuwbqYikY=;
        b=5D1dADdzzRQBnYESHBPISrmdhQ2ZHImqF3cfG4Yz+i91JjjTMC59Tj5HRcjJ3TKUFH
         4kzwyJFAzbcrGxI6+sG1IKaqGulfMHHn2xXIBsI2PCstLIbQePdl6LHePqiIrpPwOQ37
         eBte0YLU74+aUn3J11Lpkssr4+fPeH58/2aIaH/obMGxAgVrv0wdXUHUyBhvrG2Wf1+8
         A3U19YBWCqOi+dKRW7oAWxSqT32nU0Ld3e7nehzEP2ESjGZlmQyWxgKxcU9lLaUl9JmV
         hoyAuTWXhBri+yR/eOOFY0vg/eqa/f6p6YsWU3lNJKo7NoAnedSvF+r5tI2yvyoibSBq
         Q9FA==
X-Gm-Message-State: ACgBeo1amU0lFontxoV8y7zVie6LbJr6qePnPs8BZLDG+tpuC+A/vFA2
        QlN+v1QL6xzs/V+1UaEKQTqfGCdDDocQWuaCVXo9YQ==
X-Google-Smtp-Source: AA6agR7sSIXDEvLT4XuoInlUnsIOULuJa/QxwlWgVInrtLsyoolb69zlECWbq8HnRHyGUVDjsMpv9iBBolse7YKTTTQ=
X-Received: by 2002:a25:b083:0:b0:695:9a91:317d with SMTP id
 f3-20020a25b083000000b006959a91317dmr9108585ybj.387.1661811665051; Mon, 29
 Aug 2022 15:21:05 -0700 (PDT)
MIME-Version: 1.0
References: <20220829114600.GA2374@debian>
In-Reply-To: <20220829114600.GA2374@debian>
From:   Eric Dumazet <edumazet@google.com>
Date:   Mon, 29 Aug 2022 15:20:54 -0700
Message-ID: <CANn89iLH4nDuOHS-0AzYBYOz4f3byZndKXG3_VefVxUbujJZNg@mail.gmail.com>
Subject: Re: [PATCH 2/4] net-next: ip6: fetch inetpeer in ip6frag_init
To:     Richard Gobert <richardbgobert@gmail.com>
Cc:     David Miller <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        David Ahern <dsahern@kernel.org>,
        Alexander Aring <alex.aring@gmail.com>,
        Stefan Schmidt <stefan@datenfreihafen.org>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Jozsef Kadlecsik <kadlec@netfilter.org>,
        Florian Westphal <fw@strlen.de>,
        Martin KaFai Lau <kafai@fb.com>,
        netdev <netdev@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-wpan@vger.kernel.org,
        netfilter-devel@vger.kernel.org, coreteam@netfilter.org
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

On Mon, Aug 29, 2022 at 4:48 AM Richard Gobert <richardbgobert@gmail.com> wrote:
>
> Obtain the IPv6 peer in ip6frag_init, to allow for peer memory tracking
> in the IPv6 fragment reassembly logic.

Sorry, this is adding yet another bottleneck, and will make DDOS
attacks based on fragments more effective.

Whole concept of 'peers' based on IPv6 addresses is rather weak, as
hosts with IPv6 can easily
get millions of different 'addresses'.

>
> Signed-off-by: Richard Gobert <richardbgobert@gmail.com>
> ---
>  include/net/ipv6_frag.h | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/include/net/ipv6_frag.h b/include/net/ipv6_frag.h
> index 5052c66e22d2..62760cd3bdd1 100644
> --- a/include/net/ipv6_frag.h
> +++ b/include/net/ipv6_frag.h
> @@ -6,6 +6,7 @@
>  #include <net/addrconf.h>
>  #include <net/ipv6.h>
>  #include <net/inet_frag.h>
> +#include <net/inetpeer.h>
>
>  enum ip6_defrag_Richard Goberts {
>         IP6_DEFRAG_LOCAL_DELIVER,
> @@ -33,9 +34,11 @@ static inline void ip6frag_init(struct inet_frag_queue *q, const void *a)
>  {
>         struct frag_queue *fq = container_of(q, struct frag_queue, q);
>         const struct frag_v6_compare_key *key = a;
> +       const struct net *net = q->fqdir->net;
>
>         q->key.v6 = *key;
>         fq->ecn = 0;
> +       q->peer = inet_getpeer_v6(net->ipv6.peers, &key->saddr, 1);
>  }
>
>  static inline u32 ip6frag_key_hashfn(const void *data, u32 len, u32 seed)
> --
> 2.36.1
>
