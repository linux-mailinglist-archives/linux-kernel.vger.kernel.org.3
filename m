Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04BF35513A5
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 11:04:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240439AbiFTJEx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 05:04:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240405AbiFTJEt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 05:04:49 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B30ADBDB
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 02:04:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655715885;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XvT2/EIqirhY+p5g64uUJvmK6JkYzBXCB04zVu3nQHE=;
        b=Q5cDxUeei/6tuFFfuZg+zYItaso9WgspcpOWh4CLKXsPvx70swQ9d5vi2zJ4cCTQM1GZvT
        F2QtzIlE4zuUEU7coRp11YOVNVWPWOEkt11jBMVfNHlBbsfuRsMDSsbkabsvN3ofKlbGJJ
        3yZBxBfxPg4uba+QTEsN3JXE/QcSlEA=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-592-_HlnDeGqM8irUqCX6p-P4w-1; Mon, 20 Jun 2022 05:04:41 -0400
X-MC-Unique: _HlnDeGqM8irUqCX6p-P4w-1
Received: by mail-ed1-f72.google.com with SMTP id m5-20020a056402430500b004319d8ba8afso8291163edc.5
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 02:04:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XvT2/EIqirhY+p5g64uUJvmK6JkYzBXCB04zVu3nQHE=;
        b=3OIAYE9JJY0m9cWpRiKT2v57C/A4rfrRgN6sSFCHCaP3djni+9j2Tc86x4BMIZ6u93
         EKUa8sf9Slyexu7GFPQHuGMzygVJYoRGF4waWcSZZo70kDzIeng9257xX0D4pI9tMGi+
         e5N/4kZ2ubBxZhumol4aTUYn62MBHaa/6lPqJL3ldVvLfVurbXzngK+2hEel4Afvi8u4
         u+sNkCO5xPn2iDDzbjxsj4IujXMhJNYHJwsXdemHMjTT3iSyHcX7U2FuAZe7xciQFCO5
         XG4hrhtTSpF14n5ruYcgW+fVQ/66ZP/v7upevPwjnEsPba7Ccwq8YkEO2DxUdt2qLPIn
         DAsQ==
X-Gm-Message-State: AJIora/E6D0Sbw6ohlcRdKIL3MX9rTd1bhWE0rbI102kmUw6/G+YYNv5
        ITmm2r/LGD0dEZkesq+HLNTeqO+TiTE1Rx8/kr3etYepNoBHKNN+ZuE6plw37bR9DSg+qLRU5Zq
        szFG+xDJlQZ+I1dp+BiSfmEOJ
X-Received: by 2002:a05:6402:5412:b0:435:5997:ccb5 with SMTP id ev18-20020a056402541200b004355997ccb5mr22879961edb.167.1655715880626;
        Mon, 20 Jun 2022 02:04:40 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1u1V+8Z1olE7xRgb2e9/tLuRkZXYmTbhDWHE3J4zi9+b+f3sbuOtlQmw5zirNa6vEQBRLEWbA==
X-Received: by 2002:a05:6402:5412:b0:435:5997:ccb5 with SMTP id ev18-20020a056402541200b004355997ccb5mr22879947edb.167.1655715880436;
        Mon, 20 Jun 2022 02:04:40 -0700 (PDT)
Received: from redhat.com ([2.52.146.221])
        by smtp.gmail.com with ESMTPSA id o17-20020aa7dd51000000b0042df0c7deccsm9739758edw.78.2022.06.20.02.04.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jun 2022 02:04:39 -0700 (PDT)
Date:   Mon, 20 Jun 2022 05:04:36 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        davem@davemloft.net, kuba@kernel.org, erwan.yvin@stericsson.com
Subject: Re: [PATCH 2/3] caif_virtio: fix the race between
 virtio_device_ready() and ndo_open()
Message-ID: <20220620050251-mutt-send-email-mst@kernel.org>
References: <20220620051115.3142-1-jasowang@redhat.com>
 <20220620051115.3142-3-jasowang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220620051115.3142-3-jasowang@redhat.com>
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 20, 2022 at 01:11:14PM +0800, Jason Wang wrote:
> We used to depend on the virtio_device_ready() that is called after

"We used to" implies it's not the case currently.
I think you mean "we currently depend".

> probe() by virtio_dev_probe() after netdev registration. This
> cause 

causes

>a race between ndo_open() and virtio_device_ready(): if
> ndo_open() is called before virtio_device_ready(), the driver may
> start to use the device (e.g TX) before DRIVER_OK which violates the
> spec.
> 
> Fixing this

Fix this

> by switching to use register_netdevice() and protect the
> virtio_device_ready() with rtnl_lock() to make sure ndo_open() can
> only be called after virtio_device_ready().
> 
> Fixes: 0d2e1a2926b18 ("caif_virtio: Introduce caif over virtio")
> Signed-off-by: Jason Wang <jasowang@redhat.com>

Acked-by: Michael S. Tsirkin <mst@redhat.com>

> ---
>  drivers/net/caif/caif_virtio.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/caif/caif_virtio.c b/drivers/net/caif/caif_virtio.c
> index c677ded81133..66375bea2fcd 100644
> --- a/drivers/net/caif/caif_virtio.c
> +++ b/drivers/net/caif/caif_virtio.c
> @@ -719,13 +719,21 @@ static int cfv_probe(struct virtio_device *vdev)
>  	/* Carrier is off until netdevice is opened */
>  	netif_carrier_off(netdev);
>  
> +	/* serialize netdev register + virtio_device_ready() with ndo_open() */
> +	rtnl_lock();
> +
>  	/* register Netdev */
> -	err = register_netdev(netdev);
> +	err = register_netdevice(netdev);
>  	if (err) {
> +		rtnl_unlock();
>  		dev_err(&vdev->dev, "Unable to register netdev (%d)\n", err);
>  		goto err;
>  	}
>  
> +	virtio_device_ready(vdev);
> +
> +	rtnl_unlock();
> +
>  	debugfs_init(cfv);
>  
>  	return 0;
> -- 
> 2.25.1

