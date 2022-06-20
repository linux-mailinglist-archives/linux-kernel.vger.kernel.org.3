Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59A0E5513BC
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 11:09:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240404AbiFTJJ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 05:09:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235819AbiFTJJ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 05:09:28 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 90085634E
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 02:09:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655716166;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ip5gU7n+7tnzIW3sZz7U43hM4W5of8Lp22JutOuA5zs=;
        b=UOOvMIYWYVZ+1pbPdiEFxHS/OBPVoJ1TzGtf4lgPwPPJyuhIszsyiOjGKLTiLGaBKPKvGR
        fmG8k9PYGmUqhjVMOVDFJjM6MgRu1l7DXzpqSgD/wofwSDr+Qi+b+OwT9gtYXG7F7vmbjA
        tE3yG+rYAOv5OSdxOPHxXvCmobeKS3U=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-511-J13o2K1tN0-5sOamI6e7ww-1; Mon, 20 Jun 2022 05:09:25 -0400
X-MC-Unique: J13o2K1tN0-5sOamI6e7ww-1
Received: by mail-wr1-f69.google.com with SMTP id s14-20020adfa28e000000b0020ac7532f08so2275827wra.15
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 02:09:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ip5gU7n+7tnzIW3sZz7U43hM4W5of8Lp22JutOuA5zs=;
        b=hTCTxDIfHsgf+4ADCoRJoH+6Z82kByjkEPm0/U89OEcirfZAaafj61Xbd6839zX9k+
         8M80hBYrHUzrHdt26b+IMNXDfk5OVn6js2C8G+JTG+UJIWyHRTk6lMfKNvTbl362pHOx
         m6QNcWoFBCV2cRQkO3MG7TsirAWdR5Jc4aTI2H4vqayStKUUpE0fFxvTJ4mNfl979Ylp
         J7uBVbKEIq1lgfVvy6XOV/5/HmHqx0P/P9JMvrEQ8NOtf+if69sE9rEvvgL9pmdvNX2d
         E9KEpbWZ3S/K3ztQqahcqm92kBx2k3DLUZ2HPLgNOfvZdvF55Ku1EhOGYwGe58nr0RTI
         T60g==
X-Gm-Message-State: AJIora8zTd3rlul6ITBK54TqvO8ECe/wAGW4ZBiA26Gu3VBeTX8GPi79
        e/KjNYx6kFw2TThwZ5h35YOY3BfVCrnT55W4K1WLyAIKcSVTqRjG+aUe46o0VW1uuLGEIIvTI0K
        RJX3U5CjxNzyZr5wzMUvm8rVn
X-Received: by 2002:adf:f90d:0:b0:20c:de32:4d35 with SMTP id b13-20020adff90d000000b0020cde324d35mr21616162wrr.583.1655716163912;
        Mon, 20 Jun 2022 02:09:23 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tOfjUybmB+bQvA8vD/lOhSPWWZvWt88lj37HQ0oaZRkPTZx6wDkueUlbRqz0hw/1reZ27zfA==
X-Received: by 2002:adf:f90d:0:b0:20c:de32:4d35 with SMTP id b13-20020adff90d000000b0020cde324d35mr21616144wrr.583.1655716163681;
        Mon, 20 Jun 2022 02:09:23 -0700 (PDT)
Received: from redhat.com ([2.52.146.221])
        by smtp.gmail.com with ESMTPSA id p19-20020a05600c359300b0039c54bb28f2sm14884348wmq.36.2022.06.20.02.09.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jun 2022 02:09:23 -0700 (PDT)
Date:   Mon, 20 Jun 2022 05:09:19 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        davem@davemloft.net, kuba@kernel.org, erwan.yvin@stericsson.com
Subject: Re: [PATCH 3/3] caif_virtio: fix the race between reset and netdev
 unregister
Message-ID: <20220620050446-mutt-send-email-mst@kernel.org>
References: <20220620051115.3142-1-jasowang@redhat.com>
 <20220620051115.3142-4-jasowang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220620051115.3142-4-jasowang@redhat.com>
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 20, 2022 at 01:11:15PM +0800, Jason Wang wrote:
> We use to do the following steps during .remove():

We currently do


> static void cfv_remove(struct virtio_device *vdev)
> {
> 	struct cfv_info *cfv = vdev->priv;
> 
> 	rtnl_lock();
> 	dev_close(cfv->ndev);
> 	rtnl_unlock();
> 
> 	tasklet_kill(&cfv->tx_release_tasklet);
> 	debugfs_remove_recursive(cfv->debugfs);
> 
> 	vringh_kiov_cleanup(&cfv->ctx.riov);
> 	virtio_reset_device(vdev);
> 	vdev->vringh_config->del_vrhs(cfv->vdev);
> 	cfv->vr_rx = NULL;
> 	vdev->config->del_vqs(cfv->vdev);
> 	unregister_netdev(cfv->ndev);
> }
> This is racy since device could be re-opened after dev_close() but
> before unregister_netdevice():
> 
> 1) RX vringh is cleaned before resetting the device, rx callbacks that
>    is called after the vringh_kiov_cleanup() will result a UAF
> 2) Network stack can still try to use TX virtqueue even if it has been
>    deleted after dev_vqs()
> 
> Fixing this by unregistering the network device first to make sure not
> device access from both TX and RX side.
> 
> Fixes: 0d2e1a2926b18 ("caif_virtio: Introduce caif over virtio")
> Signed-off-by: Jason Wang <jasowang@redhat.com>
> ---
>  drivers/net/caif/caif_virtio.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/caif/caif_virtio.c b/drivers/net/caif/caif_virtio.c
> index 66375bea2fcd..a29f9b2df5b1 100644
> --- a/drivers/net/caif/caif_virtio.c
> +++ b/drivers/net/caif/caif_virtio.c
> @@ -752,9 +752,8 @@ static void cfv_remove(struct virtio_device *vdev)
>  {
>  	struct cfv_info *cfv = vdev->priv;
>  
> -	rtnl_lock();
> -	dev_close(cfv->ndev);
> -	rtnl_unlock();
> +	/* Make sure NAPI/TX won't try to access the device */
> +	unregister_netdev(cfv->ndev);
>  
>  	tasklet_kill(&cfv->tx_release_tasklet);
>  	debugfs_remove_recursive(cfv->debugfs);
> @@ -764,7 +763,6 @@ static void cfv_remove(struct virtio_device *vdev)
>  	vdev->vringh_config->del_vrhs(cfv->vdev);
>  	cfv->vr_rx = NULL;
>  	vdev->config->del_vqs(cfv->vdev);
> -	unregister_netdev(cfv->ndev);
>  }


This gives me pause, callbacks can now trigger after device
has been unregistered. Are we sure this is safe?
Won't it be safer to just keep the rtnl_lock around
the whole process?

>  static struct virtio_device_id id_table[] = {
> -- 
> 2.25.1

