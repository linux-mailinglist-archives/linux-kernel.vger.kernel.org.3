Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C240476A60
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 07:31:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234120AbhLPGbQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 01:31:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:25643 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231462AbhLPGbN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 01:31:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639636272;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xQP0U4n69dE+5NPu2PjUvLuvcGm/amzZHr33qUMUH4Y=;
        b=ct8P/gqWelguGKL/nJ+Yr3bVr7Ye6Yz7zHVlezmFiUXCiibvx4GIt7h5MH/FWdi9Zg8lnz
        qs7lRr0JmE/c711akt6sWlapCsKHlOdmC/xco4sSk2XwSs9V70WWLAiSqme9WEPVWKW9Wb
        cgrd7DO4u97VXRandSqvPCrF/Zz+dYs=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-55-glkGamBvP7Gh8KT8MDwCLA-1; Thu, 16 Dec 2021 01:31:08 -0500
X-MC-Unique: glkGamBvP7Gh8KT8MDwCLA-1
Received: by mail-ed1-f69.google.com with SMTP id w17-20020a056402269100b003f7ed57f96bso3343758edd.16
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 22:31:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xQP0U4n69dE+5NPu2PjUvLuvcGm/amzZHr33qUMUH4Y=;
        b=diribyCceliMAdmuA8WcPyBv8ut0zTbrwDW5X+zKC2amuJocISP/9pojej+WCpFk/A
         LrnYOqXfOw5YbExHpSEDysMC5c7O0mK3LaJzCQk8ZfJrNzV7T+cOSbelo5OFiDNfysLJ
         X501+Sh6hUl7XSnSsRQvbIwW9GgIwclMQNzn8o8X/NddLNkHOqROHIuF5jGSsv1glezu
         hVXmcTAMxhpOloNallcDRMKiLGWbH5VUHaIXAXpHdSmBHworhhhzlPWrn/FAjxFmYjx9
         an0D1tG1ysnegyPOEfoi6Ezf6IIy92Ynzw3LRV+8V9bKXj10SfwwYQQ0SFP8UxlZCUPV
         1lsA==
X-Gm-Message-State: AOAM530eKW+GvqMYyjRjdmY97tPP4b2b4lYquaMScaEhQ6/5x6vIfeFT
        ylgTZ9OzwmkS54zrit3q622THuAEeU8mqH628+U6igrN4DmdG9TAm7f5gHkDQ7Z4r/aEjU8t3YH
        RMFDRIhinyZQbxh9HUQ9ZS6np
X-Received: by 2002:a05:6402:148:: with SMTP id s8mr18866705edu.221.1639636267539;
        Wed, 15 Dec 2021 22:31:07 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwVfHIwDKSfwdC3Nw5luWnoYiTqEKCAHOR9VdZOJrXYUUC7cbyIBBf1zlKosoiw5hP+2D0kpg==
X-Received: by 2002:a05:6402:148:: with SMTP id s8mr18866694edu.221.1639636267359;
        Wed, 15 Dec 2021 22:31:07 -0800 (PST)
Received: from redhat.com ([2.55.22.18])
        by smtp.gmail.com with ESMTPSA id 6sm1356660ejj.164.2021.12.15.22.31.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Dec 2021 22:31:06 -0800 (PST)
Date:   Thu, 16 Dec 2021 01:31:03 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Wenliang Wang <wangwenliang.1995@bytedance.com>
Cc:     jasowang@redhat.com, davem@davemloft.net, kuba@kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] virtio_net: fix rx_drops stat for small pkts
Message-ID: <20211216013056-mutt-send-email-mst@kernel.org>
References: <20211216031135.3182660-1-wangwenliang.1995@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211216031135.3182660-1-wangwenliang.1995@bytedance.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 16, 2021 at 11:11:35AM +0800, Wenliang Wang wrote:
> We found the stat of rx drops for small pkts does not increment when
> build_skb fail, it's not coherent with other mode's rx drops stat.
> 
> Signed-off-by: Wenliang Wang <wangwenliang.1995@bytedance.com>

Acked-by: Michael S. Tsirkin <mst@redhat.com>

> ---
>  drivers/net/virtio_net.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 55db6a336f7e..b107835242ad 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -733,7 +733,7 @@ static struct sk_buff *receive_small(struct net_device *dev,
>  		pr_debug("%s: rx error: len %u exceeds max size %d\n",
>  			 dev->name, len, GOOD_PACKET_LEN);
>  		dev->stats.rx_length_errors++;
> -		goto err_len;
> +		goto err;
>  	}
>  
>  	if (likely(!vi->xdp_enabled)) {
> @@ -825,10 +825,8 @@ static struct sk_buff *receive_small(struct net_device *dev,
>  
>  skip_xdp:
>  	skb = build_skb(buf, buflen);
> -	if (!skb) {
> -		put_page(page);
> +	if (!skb)
>  		goto err;
> -	}
>  	skb_reserve(skb, headroom - delta);
>  	skb_put(skb, len);
>  	if (!xdp_prog) {
> @@ -839,13 +837,12 @@ static struct sk_buff *receive_small(struct net_device *dev,
>  	if (metasize)
>  		skb_metadata_set(skb, metasize);
>  
> -err:
>  	return skb;
>  
>  err_xdp:
>  	rcu_read_unlock();
>  	stats->xdp_drops++;
> -err_len:
> +err:
>  	stats->drops++;
>  	put_page(page);
>  xdp_xmit:
> -- 
> 2.30.2

