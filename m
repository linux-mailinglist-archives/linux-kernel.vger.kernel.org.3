Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CCC5579889
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 13:31:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237197AbiGSLb1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 07:31:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231491AbiGSLbZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 07:31:25 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6753FB85D
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 04:31:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658230283;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XUgxAc6MyBwAS6okxFCp4jN43h6Y+TkbUfp7P1jzs2g=;
        b=TsPWV9032mSZNIZOJkuFYdlYcyGuOkDHwVXxoFG9hSrWzW/zzNDw1qyH8cz6fuf9fBgmdl
        iY5tL3XJa89KXFjOlPFsNExXy6Ge9nlksFu4qt9ViI1G5rrefFZLI3uIvEjufrg/l5e/oC
        71pAGAO7N60KXrhLTKAVpm3ko5UYtHk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-382-bOP5W-BKNMqRFIMxkzO-dQ-1; Tue, 19 Jul 2022 07:31:15 -0400
X-MC-Unique: bOP5W-BKNMqRFIMxkzO-dQ-1
Received: by mail-wm1-f70.google.com with SMTP id r127-20020a1c4485000000b003a2fdeea756so809378wma.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 04:31:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=XUgxAc6MyBwAS6okxFCp4jN43h6Y+TkbUfp7P1jzs2g=;
        b=xv+xSewtRNbRiig7kBPbL/65Q0ZRkjkWMBxtjYPt7k/+ni9R/XuD3ir7OhAW6YiM3M
         jT3gYzp7ffEUSjvzjLMVk3xKry4iwfeOC/wwsl7OGW8/KjMXHvx9UnNC/yU16pt992Lk
         Lwr4XbYvYlAaXrtxkTUY5QoII7lB31nW2bdwky7aSnW1QnXSES8SgZ49Ose6HMVg/A8n
         /jidUQEv8RM9+iAdFN1ExtWUCnxHqqto0/mFsiL8im+1GNmUewHk1/aFXiGkivxEyGaq
         KNv/LsBnv5ts1O6KVzEmMpmeA/ZSjGfvYs2VShlIFBd5hJTuyk9l7EObxxHEohTXGWft
         E54g==
X-Gm-Message-State: AJIora9abj5xePa3RSKDtUpnSZ4QvFFyRN3h7tYgvLBwMYtwSzXoRTMm
        6TDrXH2tS3q/uO4VtNbzi8ju54934Yxky087PmrUlPyfuvEkUf3UCKgjU7eD/KhysFmhj/NP/oo
        OBsPgAfR3ktHlGST0ZB1SKFkM
X-Received: by 2002:a05:600c:3d14:b0:3a3:21ee:ad99 with SMTP id bh20-20020a05600c3d1400b003a321eead99mr3258816wmb.51.1658230273749;
        Tue, 19 Jul 2022 04:31:13 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1sB9l5eRHXxtIpg6R9gvqvNXnhCq30+HWVu6KETFTKOl9+3wsyG9wKT+zEJJbRxzl1xHDoXIA==
X-Received: by 2002:a05:600c:3d14:b0:3a3:21ee:ad99 with SMTP id bh20-20020a05600c3d1400b003a321eead99mr3258785wmb.51.1658230273492;
        Tue, 19 Jul 2022 04:31:13 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-104-164.dyn.eolo.it. [146.241.104.164])
        by smtp.gmail.com with ESMTPSA id h8-20020adff4c8000000b0021d887f9468sm12991548wrp.25.2022.07.19.04.31.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jul 2022 04:31:13 -0700 (PDT)
Message-ID: <8e083ce2c7d2d5a616808889e0d04a488b84fc9f.camel@redhat.com>
Subject: Re: [PATCH net 2/2] net: lantiq_xrx200: fix return value in ENOMEM
 case
From:   Paolo Abeni <pabeni@redhat.com>
To:     Aleksander Jan Bajkowski <olek2@wp.pl>, hauke@hauke-m.de,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 19 Jul 2022 13:31:11 +0200
In-Reply-To: <20220717194824.1017750-2-olek2@wp.pl>
References: <20220717194824.1017750-1-olek2@wp.pl>
         <20220717194824.1017750-2-olek2@wp.pl>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2022-07-17 at 21:48 +0200, Aleksander Jan Bajkowski wrote:
> The xrx200_hw_receive() function can return:
> * XRX200_DMA_PACKET_IN_PROGRESS (the next descriptor contains the
> further part of the packet),
> * XRX200_DMA_PACKET_COMPLETE (a complete packet has been received),
> * -ENOMEM (a memory allocation error occurred).
> 
> Currently, the third of these cases is incorrectly handled. The NAPI
> poll function returns then a negative value (-ENOMEM). Correctly in
> such a situation, the driver should try to receive next packet in
> the hope that this time the memory allocation for the next descriptor
> will succeed.

> This patch replaces the XRX200_DMA_PACKET_IN_PROGRESS definition with
> -EINPROGRESS to simplify the driver.
> 
> Fixes: c3e6b2c35b34 ("net: lantiq_xrx200: add ingress SG DMA support")
> Signed-off-by: Aleksander Jan Bajkowski <olek2@wp.pl>
> ---
>  drivers/net/ethernet/lantiq_xrx200.c | 10 ++--------
>  1 file changed, 2 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/net/ethernet/lantiq_xrx200.c b/drivers/net/ethernet/lantiq_xrx200.c
> index 6a83a6c19484..2865d07f3fc8 100644
> --- a/drivers/net/ethernet/lantiq_xrx200.c
> +++ b/drivers/net/ethernet/lantiq_xrx200.c
> @@ -27,9 +27,6 @@
>  #define XRX200_DMA_TX		1
>  #define XRX200_DMA_BURST_LEN	8
>  
> -#define XRX200_DMA_PACKET_COMPLETE	0
> -#define XRX200_DMA_PACKET_IN_PROGRESS	1
> -
>  /* cpu port mac */
>  #define PMAC_RX_IPG		0x0024
>  #define PMAC_RX_IPG_MASK	0xf
> @@ -272,9 +269,8 @@ static int xrx200_hw_receive(struct xrx200_chan *ch)
>  		netif_receive_skb(ch->skb_head);
>  		ch->skb_head = NULL;
>  		ch->skb_tail = NULL;
> -		ret = XRX200_DMA_PACKET_COMPLETE;
>  	} else {
> -		ret = XRX200_DMA_PACKET_IN_PROGRESS;
> +		ret = -EINPROGRESS;
>  	}
>  
>  	return ret;
> @@ -292,10 +288,8 @@ static int xrx200_poll_rx(struct napi_struct *napi, int budget)
>  
>  		if ((desc->ctl & (LTQ_DMA_OWN | LTQ_DMA_C)) == LTQ_DMA_C) {
>  			ret = xrx200_hw_receive(ch);
> -			if (ret == XRX200_DMA_PACKET_IN_PROGRESS)
> +			if (ret)
>  				continue;
> -			if (ret != XRX200_DMA_PACKET_COMPLETE)
> -				return ret;

Note that in case of persistent pressure and with the device under
flood, 'rx' is not incremented, and this loop can run for an unbound
number of iteration.

If you keep running, you do need to increment 'rx' at every iteration,
even in case of error.

Note that 'rx' is more an estimate of the work done than a 'received
packet counter'.

Paolo

