Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD74354F508
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 12:13:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381620AbiFQKNH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 06:13:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378259AbiFQKNG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 06:13:06 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 095F912AEC
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 03:13:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655460784;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/Egh8+Gz6P7sJjajReRg4TwcxQZ6PNsT6qhTrjGb38E=;
        b=dv2w+Fa+bcNMpJd3iTDJANgqRwLh9Cezh2AV95qadoD7CDAv6yG2X03mq2M4UuWe1Phv/Q
        /uK8N+Ypr+xdfVXvPSHHzCRqtw57zMJ5RPdxxR3E2X0vbqd0PNPT6Id0n6wXGLFR/E2Q6y
        Vmh5BPloWHaQWIAY7FhPaBW9tGtasb0=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-635-QFtBbfUOMPumlWQVcjTWmQ-1; Fri, 17 Jun 2022 06:13:03 -0400
X-MC-Unique: QFtBbfUOMPumlWQVcjTWmQ-1
Received: by mail-wr1-f71.google.com with SMTP id s14-20020adfa28e000000b0020ac7532f08so850597wra.15
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 03:13:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/Egh8+Gz6P7sJjajReRg4TwcxQZ6PNsT6qhTrjGb38E=;
        b=HpS3SvE8lHDAbTQG8v/sQdfFI38ZvawnBQV1jTF+EGLqpp2uvXlpwuoBMVU55DohcC
         EMhot3COXhAlx2wujKDoj/GhZ2w3H2zQIg/Am7so591700gc88IsF3d+UMwLLxnqXv3T
         Zv0pDDWhvab8HhAY0i18w5EUeQQbpCon82eFKcUN5bOzKZFDcGsUINDl8Ueag62RGChV
         LFl3mTi7xyNjrIIjhZagrW6hfYRirNgMQPiZwWQswsbdkzmlBNeIFDXwdALMtYsdwR3A
         Kn1g6kLIk72FYDzV1kCxCnMk94hLPhfihIoflMy4xKF7+H2ANWukjgu5KlUTl2XnWYDq
         f6vA==
X-Gm-Message-State: AJIora9926FEQn07lw7+isTMKn+zAH16oGkB1sKI4Y/BYpn/lfL/+6lF
        mxRwfUT+/Q+ZLw8UHCRTH/dhysGvbJFoHgBzEnJuGPm1DFo8Ok+nHFlHz55yTNnlac6YXuMbKmx
        I+9LCS6AIMlxPMaG4ItGqM3ag
X-Received: by 2002:a5d:6d8b:0:b0:218:4dc8:293e with SMTP id l11-20020a5d6d8b000000b002184dc8293emr8684810wrs.612.1655460781817;
        Fri, 17 Jun 2022 03:13:01 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1uCeVJ3V3dWfzRxiKB7fJuvCI0FPi1R5vsbVVS3gLAKJyU7vKwteL3gJz5FSVTdXRodiZ6DGg==
X-Received: by 2002:a5d:6d8b:0:b0:218:4dc8:293e with SMTP id l11-20020a5d6d8b000000b002184dc8293emr8684788wrs.612.1655460781577;
        Fri, 17 Jun 2022 03:13:01 -0700 (PDT)
Received: from redhat.com ([2.54.189.19])
        by smtp.gmail.com with ESMTPSA id i188-20020a1c3bc5000000b0039ee52c1345sm2137495wma.4.2022.06.17.03.12.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jun 2022 03:13:01 -0700 (PDT)
Date:   Fri, 17 Jun 2022 06:12:57 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     davem@davemloft.net, kuba@kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] virtio-net: fix race between ndo_open() and
 virtio_device_ready()
Message-ID: <20220617060632-mutt-send-email-mst@kernel.org>
References: <20220617072949.30734-1-jasowang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220617072949.30734-1-jasowang@redhat.com>
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 17, 2022 at 03:29:49PM +0800, Jason Wang wrote:
> We used to call virtio_device_ready() after netdev registration. This
> cause a race between ndo_open() and virtio_device_ready(): if
> ndo_open() is called before virtio_device_ready(), the driver may
> start to use the device before DRIVER_OK which violates the spec.
> 
> Fixing this by switching to use register_netdevice() and protect the
> virtio_device_ready() with rtnl_lock() to make sure ndo_open() can
> only be called after virtio_device_ready().
> 
> Fixes: 4baf1e33d0842 ("virtio_net: enable VQs early")
> Signed-off-by: Jason Wang <jasowang@redhat.com>
> ---
>  drivers/net/virtio_net.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index db05b5e930be..8a5810bcb839 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -3655,14 +3655,20 @@ static int virtnet_probe(struct virtio_device *vdev)
>  	if (vi->has_rss || vi->has_rss_hash_report)
>  		virtnet_init_default_rss(vi);
>  
> -	err = register_netdev(dev);
> +	/* serialize netdev register + virtio_device_ready() with ndo_open() */
> +	rtnl_lock();
> +
> +	err = register_netdevice(dev);
>  	if (err) {
>  		pr_debug("virtio_net: registering device failed\n");
> +		rtnl_unlock();
>  		goto free_failover;
>  	}
>  
>  	virtio_device_ready(vdev);
>  
> +	rtnl_unlock();
> +
>  	err = virtnet_cpu_notif_add(vi);
>  	if (err) {
>  		pr_debug("virtio_net: registering cpu notifier failed\n");


Looks good but then don't we have the same issue when removing the
device?

Actually I looked at  virtnet_remove and I see
        unregister_netdev(vi->dev);

        net_failover_destroy(vi->failover);

        remove_vq_common(vi); <- this will reset the device

a window here?


Really, I think what we had originally was a better idea -
instead of dropping interrupts they were delayed and
when driver is ready to accept them it just enables them.
We just need to make sure driver does not wait for
interrupts before enabling them.

And I suspect we need to make this opt-in on a per driver
basis.



> -- 
> 2.25.1

