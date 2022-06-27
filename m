Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04C0955D2F1
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:11:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239500AbiF0MIX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 08:08:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240429AbiF0MHn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 08:07:43 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1DD72D12D
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 05:06:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656331566;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oa0hKhTUeCCnu5O/zbJifpjkPRkzcn5Dvdk3HuT+Faw=;
        b=g4ilFo4REN3PdDjBVSvvCMPuY5SFQCEFq7w3s6gCRvKv7HxVeOFk9BzrPh30CB20dibEmT
        +W6J27F2FvDcIHtw/Te8OrSHIi4SnL7C7qK6UlxKFLegNPqYPstmVK5LHL4CfMZhFse1jJ
        Sv4FzwXnNinALXOBdfROJxDLpVVlXU0=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-208-biOtvGxfNfmxj8Qyp1YabQ-1; Mon, 27 Jun 2022 08:06:05 -0400
X-MC-Unique: biOtvGxfNfmxj8Qyp1YabQ-1
Received: by mail-wr1-f69.google.com with SMTP id u9-20020adfa189000000b0021b8b3c8f74so1143375wru.12
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 05:06:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=oa0hKhTUeCCnu5O/zbJifpjkPRkzcn5Dvdk3HuT+Faw=;
        b=wdI9WDuLlu65OCp3s2/vgnxWo0qb9tROqL2gFX3RXHNFiTVzyHhgtXcfvBegcWYEDA
         8LEbKxHr/WhVqaLAig6MumecA8BtsjH/ulbK3X5GqLSoqpYSDAue8fpN67P2g7cHQh25
         SP5NsNLniXAUxeDnNtY5bnRsxVCDCPQ6u3IlwNmVzd8iCPDMkVk9NVmiQzn1CYBlXyjA
         39rqnfF2yruui4DgG+ODpLMxebBL8syY7aOGFdauctyKzjpBMsN9sXS/lEFD9HDDzIy7
         dzze+OwW8U2etWDSOTHrKJR5AIcdjQ58eh6YAaOdvuINw9Dtxig6ArthnLRGWw3I/dwW
         q2Bg==
X-Gm-Message-State: AJIora/3U4+CFf93fFhEiO0ECD617rE8v+Oz1eXuSuGUkj1fMUQt9SBv
        rwKBKLtJgg4v/CvMzY/meTqbJcJHOINhL18LZ8dP2kdYWCoYM9ni9UOel3pa+HoNqW+rSMFPGoI
        0YZ/LPKF8x6SDYXFEwAFyJBvJ
X-Received: by 2002:adf:fad2:0:b0:21b:b947:bfa8 with SMTP id a18-20020adffad2000000b0021bb947bfa8mr12316738wrs.73.1656331564525;
        Mon, 27 Jun 2022 05:06:04 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1uH4dSe1OM+SF7gXPkS4xVRzc70/2+VEa4uCZyX8h1qerL46FWK8xW87SYP/3wUoSpkIGVe8w==
X-Received: by 2002:adf:fad2:0:b0:21b:b947:bfa8 with SMTP id a18-20020adffad2000000b0021bb947bfa8mr12316730wrs.73.1656331564326;
        Mon, 27 Jun 2022 05:06:04 -0700 (PDT)
Received: from redhat.com ([2.54.45.90])
        by smtp.gmail.com with ESMTPSA id h4-20020a5d4304000000b0021b829d111csm10533390wrq.112.2022.06.27.05.06.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 05:06:03 -0700 (PDT)
Date:   Mon, 27 Jun 2022 08:05:59 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     davem@davemloft.net, kuba@kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net V2] virtio-net: fix race between ndo_open() and
 virtio_device_ready()
Message-ID: <20220627080539-mutt-send-email-mst@kernel.org>
References: <20220627083040.53506-1-jasowang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220627083040.53506-1-jasowang@redhat.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 27, 2022 at 04:30:40PM +0800, Jason Wang wrote:
> We currently call virtio_device_ready() after netdev
> registration. Since ndo_open() can be called immediately
> after register_netdev, this means there exists a race between
> ndo_open() and virtio_device_ready(): the driver may start to use the
> device before DRIVER_OK which violates the spec.
> 
> Fix this by switching to use register_netdevice() and protect the
> virtio_device_ready() with rtnl_lock() to make sure ndo_open() can
> only be called after virtio_device_ready().
> 
> Fixes: 4baf1e33d0842 ("virtio_net: enable VQs early")
> Acked-by: Michael S. Tsirkin <mst@redhat.com>
> Signed-off-by: Jason Wang <jasowang@redhat.com>

I reworded the caif commit log similarly and put both on my tree.

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
> -- 
> 2.25.1

