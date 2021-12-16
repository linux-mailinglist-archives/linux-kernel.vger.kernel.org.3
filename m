Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D275C4768A8
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 04:26:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233351AbhLPDX6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 22:23:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:60302 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233339AbhLPDX5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 22:23:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639625037;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NpP4+hk92r4w2B9+P9RZxFn4KHsmw9feHBEAh+dzxBI=;
        b=WiRNsWCcUTAf5GfvswQWFtmvEOtfsEGhlPZrhdiwjgS+1Hb8LxjzLMWupx0ZLkimy1TXay
        JnEfglhvodiHZWaY6GJ5PHcqofdUk0oqI6UhWkHCs2McX+qsDLK6NW4Ac6dOPDjwASys7G
        zguZxBJGiNENtjLirbxW3EQv3QsQLbU=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-209-8tT0r6qUPbCK_yeeflgj9A-1; Wed, 15 Dec 2021 22:23:55 -0500
X-MC-Unique: 8tT0r6qUPbCK_yeeflgj9A-1
Received: by mail-lf1-f71.google.com with SMTP id e23-20020a196917000000b0041bcbb80798so10120319lfc.3
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 19:23:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NpP4+hk92r4w2B9+P9RZxFn4KHsmw9feHBEAh+dzxBI=;
        b=RvtCtX1mMj2o2DyEzJAW4KfqCoLWc5bBDOD3g2LX21tDVyUZjgVSJX6sOq8JAZUrny
         Ar6tQNnZOiyDFX8Oz0NVMd2hOFFd3DH8bL8z6xoi5JGAZ1cwvk2q1ekzk39e1a0+FSr2
         K7JOqSLEu5luWs+4y3Q1VZZJDjGYlG0V0X65XMpaQIzV2VP8pptlQuhnEO4REa0XX5hi
         vawHniB6OF7K2npqAtF48Bkv2Khh3/gSWZNSPAuoZ7rdLvFTdq9F/Z2+Hav5yAzuK9pZ
         k/zMG4SkB3io1pDHojPQGfJuZghHr8ZYujt9Uow8+nLFhFyyZlxVCKDWtwG9ty79vZJe
         dXag==
X-Gm-Message-State: AOAM531+OATdQwKucD+AF2P6ThHx3ZboG0d2ONRyykWt6NU9b+ufZlNA
        rtxP3U/MIOqFhs/38KwcywMRoSxD6HfSzfnrkaAeVyGjRdaHbuL8NWxYF1Fk5tR4zIW6nG7ciSs
        9vcqNRpjfuCR4TeILgzGzka/uHAYMPQg2xsQch5/w
X-Received: by 2002:a2e:9f55:: with SMTP id v21mr13762192ljk.420.1639625033575;
        Wed, 15 Dec 2021 19:23:53 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwBMixYaEZyd4edEWw5Bj/aizM8U5Uj0hSuNa6Ik2s82KlOktsgxUZAtKHuh6rOaExNcjN8fE1mOpyHnQE3Im8=
X-Received: by 2002:a2e:9f55:: with SMTP id v21mr13762176ljk.420.1639625033370;
 Wed, 15 Dec 2021 19:23:53 -0800 (PST)
MIME-Version: 1.0
References: <20211216031135.3182660-1-wangwenliang.1995@bytedance.com>
In-Reply-To: <20211216031135.3182660-1-wangwenliang.1995@bytedance.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Thu, 16 Dec 2021 11:23:42 +0800
Message-ID: <CACGkMEtPkybSyPRXqcqtBGbEHvMEw04dcWpUDswuXgwEnshBSA@mail.gmail.com>
Subject: Re: [PATCH] virtio_net: fix rx_drops stat for small pkts
To:     Wenliang Wang <wangwenliang.1995@bytedance.com>
Cc:     mst <mst@redhat.com>, davem <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        virtualization <virtualization@lists.linux-foundation.org>,
        netdev <netdev@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 16, 2021 at 11:12 AM Wenliang Wang
<wangwenliang.1995@bytedance.com> wrote:
>
> We found the stat of rx drops for small pkts does not increment when
> build_skb fail, it's not coherent with other mode's rx drops stat.
>
> Signed-off-by: Wenliang Wang <wangwenliang.1995@bytedance.com>

Acked-by: Jason Wang <jasowang@redhat.com>

> ---
>  drivers/net/virtio_net.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 55db6a336f7e..b107835242ad 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -733,7 +733,7 @@ static struct sk_buff *receive_small(struct net_device *dev,
>                 pr_debug("%s: rx error: len %u exceeds max size %d\n",
>                          dev->name, len, GOOD_PACKET_LEN);
>                 dev->stats.rx_length_errors++;
> -               goto err_len;
> +               goto err;
>         }
>
>         if (likely(!vi->xdp_enabled)) {
> @@ -825,10 +825,8 @@ static struct sk_buff *receive_small(struct net_device *dev,
>
>  skip_xdp:
>         skb = build_skb(buf, buflen);
> -       if (!skb) {
> -               put_page(page);
> +       if (!skb)
>                 goto err;
> -       }
>         skb_reserve(skb, headroom - delta);
>         skb_put(skb, len);
>         if (!xdp_prog) {
> @@ -839,13 +837,12 @@ static struct sk_buff *receive_small(struct net_device *dev,
>         if (metasize)
>                 skb_metadata_set(skb, metasize);
>
> -err:
>         return skb;
>
>  err_xdp:
>         rcu_read_unlock();
>         stats->xdp_drops++;
> -err_len:
> +err:
>         stats->drops++;
>         put_page(page);
>  xdp_xmit:
> --
> 2.30.2
>

