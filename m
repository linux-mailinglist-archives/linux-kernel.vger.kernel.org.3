Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54392474E89
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 00:27:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238212AbhLNX0r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 18:26:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:32749 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231684AbhLNX0q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 18:26:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639524405;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LDA9jVOy/ZRGCA3pqs+Olfx4vK3cOd0BCYRpSVgNd3U=;
        b=gUujYyJvPIi5+p4RcZkgRxrDhGXzW/l73WEIFA/dtQ77ZqENG5WOPbV9H8F5uC5vcnJx91
        GrRY4M+BMQl9yfQLbiml0YFqtiGR1RPhB/ANkWplI3f+dZjPHGIklKIBFQ7ikVqSNwctm1
        f+BEPOI7rRZa73lEIfXKKnErbWXYO7c=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-142-tV2okwQRN2yDqWW9BwWa_A-1; Tue, 14 Dec 2021 18:26:44 -0500
X-MC-Unique: tV2okwQRN2yDqWW9BwWa_A-1
Received: by mail-ed1-f69.google.com with SMTP id l11-20020a056402254b00b003f6a9bd7e81so4232775edb.13
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 15:26:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LDA9jVOy/ZRGCA3pqs+Olfx4vK3cOd0BCYRpSVgNd3U=;
        b=4628SYFD9vapeu0Pa7AuPyVSiuJkjHAQ9WsyS0ZT6BWXKdZFXo2MdR6fqRe0a4nlyd
         vir9AAAdAlGDS+IAMYc7/21qgg/vzDoks+NSMyW2Ece8pGo1lanWxcg/VrTZHW4avpKv
         L1pAbOp9Ya0DmecNBVD0QE6esBnAn3/xTGvfXaDnl/BsL3SlecUsDS+1kYcz0rcQbE5/
         pXqEHRVv/LARALVHhIRSLrU7EXOMGbxryGVybKI4yuQzC6nNto9Csw2t+FUJzpupzdGI
         V6MAshoe779DWBbOywQMAqjDsS3nnQs8w1ps4jQUtqrPI813AMxE6LnmQ8D4wi65tzw5
         JDSQ==
X-Gm-Message-State: AOAM5337vsf0GHWwIsOo8JjrCbnd5wuEZ3ASIEcXzp4L4dqPbYfjn8Ll
        rPT0UhB2ZxMvkbrvDf6UWQhEtGzILY1nL06AG/waJWQKmwSEYx8BuH/WNxurNY9iU8ZNTnVY2HZ
        35WJRl9vZw0OgOIALI33+kuUR
X-Received: by 2002:a17:907:8a13:: with SMTP id sc19mr8319056ejc.130.1639524403063;
        Tue, 14 Dec 2021 15:26:43 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxY9VeEUwbwOQjfz6ubzWVYWdjmxkerIQ6XgtO+Jvoh1RAxswqJWM3ChpSChcFlpxDXjdGQtw==
X-Received: by 2002:a17:907:8a13:: with SMTP id sc19mr8319045ejc.130.1639524402869;
        Tue, 14 Dec 2021 15:26:42 -0800 (PST)
Received: from redhat.com ([2.55.154.189])
        by smtp.gmail.com with ESMTPSA id d18sm90019edj.23.2021.12.14.15.26.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Dec 2021 15:26:42 -0800 (PST)
Date:   Tue, 14 Dec 2021 18:26:39 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Mikhail Golubev <Mikhail.Golubev@opensynergy.com>
Cc:     Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org,
        Anton Yakovlev <Anton.Yakovlev@opensynergy.com>
Subject: Re: [RFC PATCH] virtio: do not reset stateful devices on resume
Message-ID: <20211214182611-mutt-send-email-mst@kernel.org>
References: <20211214163249.GA253555@opensynergy.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211214163249.GA253555@opensynergy.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 14, 2021 at 05:33:05PM +0100, Mikhail Golubev wrote:
> From: Anton Yakovlev <Anton.Yakovlev@opensynergy.com>
> 
> We assume that stateful devices can maintain their state while
> suspended. And for this reason they don't have a freeze callback. If
> such a device is reset during resume, the device state/context will be
> lost on the device side. And the virtual device will stop working.
> 
> Signed-off-by: Anton Yakovlev <Anton.Yakovlev@opensynergy.com>
> Signed-off-by: Mikhail Golubev <mikhail.golubev@opensynergy.com>

A bit more specific? Which configs does this patch fix?

> ---
>  drivers/virtio/virtio.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
> index 236081afe9a2..defa15b56eb8 100644
> --- a/drivers/virtio/virtio.c
> +++ b/drivers/virtio/virtio.c
> @@ -472,6 +472,13 @@ int virtio_device_restore(struct virtio_device *dev)
>  	struct virtio_driver *drv = drv_to_virtio(dev->dev.driver);
>  	int ret;
>  
> +	/* Short path for stateful devices. Here we assume that if the device
> +	 * does not have a freeze callback, its state was not changed when
> +	 * suspended.
> +	 */
> +	if (drv && !drv->freeze)
> +		goto on_config_enable;
> +
>  	/* We always start by resetting the device, in case a previous
>  	 * driver messed it up. */
>  	dev->config->reset(dev);
> @@ -503,6 +510,7 @@ int virtio_device_restore(struct virtio_device *dev)
>  	/* Finally, tell the device we're all set */
>  	virtio_add_status(dev, VIRTIO_CONFIG_S_DRIVER_OK);
>  
> +on_config_enable:
>  	virtio_config_enable(dev);
>  
>  	return 0;
> -- 
> 2.34.1
> 
> 
> -- 

