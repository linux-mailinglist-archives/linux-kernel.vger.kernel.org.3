Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28A604B3EE0
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 02:30:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238968AbiBNB3b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Feb 2022 20:29:31 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:39566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbiBNB3a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Feb 2022 20:29:30 -0500
Received: from mail-ua1-x92a.google.com (mail-ua1-x92a.google.com [IPv6:2607:f8b0:4864:20::92a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC615527E8
        for <linux-kernel@vger.kernel.org>; Sun, 13 Feb 2022 17:29:23 -0800 (PST)
Received: by mail-ua1-x92a.google.com with SMTP id u77so7380586uau.6
        for <linux-kernel@vger.kernel.org>; Sun, 13 Feb 2022 17:29:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YbBn6hVdDrIYewHKWlLGHAJSksMmM5XP0nlu0JS5cLg=;
        b=JkUTiQpYq5GifwK6IkZadP4PRY/WPFeg6qLbNp1Oo7Etl5CxxZX5QKALdylzWBF/Sr
         RMW5d7Z4NSOqbNuJvvRLTDsQiQC/suyUgMAbQvM6DFHkTPgyf2uTAndc4+XAlOnXGs7d
         /7+PtwF2imm1t51tGYLt7zxOhtSScGBckIsQ0JNyABIRoePHYixrHa/4492zkd95Apuc
         jwVCEgjfprxlHNyAZ70sUGMa/jJWRSJObp3bZn11/VyHEzTYx83DXSHN+41h1Mpa7pIA
         N2MzzWqKqZxbMJ/t/zc7zCaH7jBflwPrStJs/ty/iacYHq36crr8z77/Gb1ZqTBwK5q1
         5nrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YbBn6hVdDrIYewHKWlLGHAJSksMmM5XP0nlu0JS5cLg=;
        b=UcNceqHFna7Y4EG98UrNYib2MDSy5Hq+fkLiy6CG44GvFWtiK6768en4GOcbBSz7Ts
         roaK3SF04Jz9eBoUysIdSK+Linaf7oSxY1IgzaULUGf9+2qZkVJraLkKguB6jV0t6fGZ
         0fGmQByp9fEVw0oCYVjTxVLmW2LzPRvWkFb+ORv2RXJBOUq7pOwsOOZt//5s+T9+uiid
         mYNz3T1b62jQywBvskZWLqhO0rxzuGKyMxoyNUcTRgRvdMct08HIX/cD0rLverjcfP18
         Xp4yEeGi5vDKanjwFWAOzHRjUNOLNmiolMKI5dXLR0yastkfKAVDfwBQXMYjDcTaVEYV
         MIKw==
X-Gm-Message-State: AOAM530suKACxoxvJpSizTHaxEaX8BO6z9Xw2y4+Y3hpr4a9HFtgjxAO
        hmxkNGNj6zXh3KY0hwpxSLO6tANfqYQ=
X-Google-Smtp-Source: ABdhPJzPSsNp4W3z1bAys6RURvxCnhbcS5WBKrDGtflCiA2Yk2YuMeQoQYwwwMKIihP4MTr9LMeMLg==
X-Received: by 2002:a9f:3224:: with SMTP id x33mr3018280uad.79.1644802162730;
        Sun, 13 Feb 2022 17:29:22 -0800 (PST)
Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com. [209.85.217.53])
        by smtp.gmail.com with ESMTPSA id m185sm5316931vke.30.2022.02.13.17.29.22
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 13 Feb 2022 17:29:22 -0800 (PST)
Received: by mail-vs1-f53.google.com with SMTP id r20so17144118vsn.0
        for <linux-kernel@vger.kernel.org>; Sun, 13 Feb 2022 17:29:22 -0800 (PST)
X-Received: by 2002:a67:cc14:: with SMTP id q20mr635459vsl.74.1644802161746;
 Sun, 13 Feb 2022 17:29:21 -0800 (PST)
MIME-Version: 1.0
References: <20220213150234.31602-1-thomas.liu@ucloud.cn>
In-Reply-To: <20220213150234.31602-1-thomas.liu@ucloud.cn>
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date:   Sun, 13 Feb 2022 20:28:45 -0500
X-Gmail-Original-Message-ID: <CA+FuTSdODATw3hSAMv9aZUmJNM8ZE-YP58pr17bO9rGJUgfegw@mail.gmail.com>
Message-ID: <CA+FuTSdODATw3hSAMv9aZUmJNM8ZE-YP58pr17bO9rGJUgfegw@mail.gmail.com>
Subject: Re: [PATCH] gso: do not skip outer ip header in case of ipip and net_failover
To:     Tao Liu <thomas.liu@ucloud.cn>
Cc:     davem@davemloft.net, yoshfuji@linux-ipv6.org, dsahern@kernel.org,
        kuba@kernel.org, edumazet@google.com, sridhar.samudrala@intel.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 13, 2022 at 10:10 AM Tao Liu <thomas.liu@ucloud.cn> wrote:
>
> We encouter a tcp drop issue in our cloud environment. Packet GROed in host
> forwards to a VM virtio_net nic with net_failover enabled. VM acts as a
> IPVS LB with ipip encapsulation. The full path like:
> host gro -> vm virtio_net rx -> net_failover rx -> ipvs fullnat
>  -> ipip encap -> net_failover tx -> virtio_net tx
>
> When net_failover transmits a ipip pkt (gso_type = 0x0103), there is no gso
> performed because it supports TSO and GSO_IPXIP4. But network_header has
> been pointing to inner ip header.

If the packet is configured correctly, and net_failover advertises
that it can handle TSO packets with IPIP encap, then still virtio_net
should not advertise it and software GSO be applied on its
dev_queue_xmit call.

This is assuming that the packet not only has SKB_GSO_IPXIP4 correctly
set, but also tunneling fields like skb->encapsulated and
skb_inner_network_header.

> ---
>  net/ipv4/af_inet.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
> index 9c465ba..f8b3f8a 100644
> --- a/net/ipv4/af_inet.c
> +++ b/net/ipv4/af_inet.c
> @@ -1425,10 +1425,18 @@ struct sk_buff *inet_gso_segment(struct sk_buff *skb,
>  static struct sk_buff *ipip_gso_segment(struct sk_buff *skb,
>                                         netdev_features_t features)
>  {
> +       struct sk_buff *segs;
> +       int nhoff;
> +
>         if (!(skb_shinfo(skb)->gso_type & SKB_GSO_IPXIP4))
>                 return ERR_PTR(-EINVAL);
>
> -       return inet_gso_segment(skb, features);
> +       nhoff = skb_network_header(skb) - skb_mac_header(skb);
> +       segs = inet_gso_segment(skb, features);
> +       if (!segs)
> +               skb->network_header = skb_mac_header(skb) + nhoff - skb->head;
> +
> +       return segs;
>  }

If this would be needed for IPIP, then the same would be needed for SIT, etc.

Is the skb_network_header

1. correctly pointing to the outer header of the TSO packet before the
call to inet_gso_segment
2. incorrectly pointing to the inner header of the (still) TSO packet
after the call to inet_gso_segment

inet_gso_segment already does the same operation: save nhoff, pull
network header, call callbacks.gso_segment (which can be
ipip_gso_segment->inet_gso_segment), then place the network header
back at nhoff.
