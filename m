Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D71794E61F6
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 11:48:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243846AbiCXKtx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 06:49:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242718AbiCXKtr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 06:49:47 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 25ACC2DFA
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 03:48:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1648118894;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uWRMRQIguPn0xVAvBXNbH51X5fGoB4gdHQSpKWVAiFE=;
        b=VOjidShX2oiW5ZrE/FhXK7+PFsgLwtaL8PQ/tnPjuntqLUBJHleCMr90YhoNp4ghEAt260
        PWVplJu0Cdi9CNzSRCkWaC5YkyUkP01lRbDO2eQTQdQw8q/O+2EPor8BQYN9JwzKVOYYvZ
        wauHas8Y2jca2CVmM9ikHwaj0G/YGPY=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-592-OB8R4n9-NqyyGhlBaTWkIw-1; Thu, 24 Mar 2022 06:48:13 -0400
X-MC-Unique: OB8R4n9-NqyyGhlBaTWkIw-1
Received: by mail-wr1-f71.google.com with SMTP id s8-20020adfc548000000b00203eba1052eso1547943wrf.1
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 03:48:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=uWRMRQIguPn0xVAvBXNbH51X5fGoB4gdHQSpKWVAiFE=;
        b=pqA9mTGrGSPRJ0vOh3m03G5JOmBgyqOUe4bTuUbC5UGalpLC/aU+GYT3I1GoxgzlDI
         c6fBs4xWC+9oCuzuHXjvQOOX0cA3q5G2CWB9pakMXf04DsbPWmBCValhTm2lm64Peilm
         LSQDyVxEreHo+K+jm8xRW+v2wBL8VLYzO3weaPVDcj6tXZEplwrkSsg1uxJrlK0WJqJ+
         S+PnMqNtBYmozaDXWDUku1HHSPnC/GqM+UCS4wNZ8h66FEfL2LGhK6x/fWKUNVABtZIk
         lM+gtf46DYhVWJe5qJOi7NBH8gbItx5OTQ/SPbSgLILDsQhzRMEz6leUwNTi0nzHk4ci
         w09w==
X-Gm-Message-State: AOAM531HBvKElTe7MEHaUyZMf21N/wswh+ILDWLJq+RIecj96eZ69+8d
        0EK0yMe0JqNphpU4d1/c6VqMK2p6xPP5K/mRqkdNYswf7m6tdIZUhIuqIweAJQmbxIm4PJ+CDpu
        Y4oOkYCRYh3+U8iua4a9jRv9h
X-Received: by 2002:a1c:3587:0:b0:381:50ff:cbd with SMTP id c129-20020a1c3587000000b0038150ff0cbdmr13551079wma.140.1648118891812;
        Thu, 24 Mar 2022 03:48:11 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzRxMJ+YXVZLvhuM9RI7+rgiWVlvl4AwKWXbx5vjGyiTWNJAssKyhMaSULkwjGGH8UgEVT4XA==
X-Received: by 2002:a1c:3587:0:b0:381:50ff:cbd with SMTP id c129-20020a1c3587000000b0038150ff0cbdmr13551062wma.140.1648118891582;
        Thu, 24 Mar 2022 03:48:11 -0700 (PDT)
Received: from redhat.com ([2.55.151.118])
        by smtp.gmail.com with ESMTPSA id e10-20020a056000178a00b0020414f27a58sm2419815wrg.35.2022.03.24.03.48.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Mar 2022 03:48:10 -0700 (PDT)
Date:   Thu, 24 Mar 2022 06:48:05 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, maz@kernel.org, tglx@linutronix.de,
        peterz@infradead.org, sgarzare@redhat.com, keirf@google.com
Subject: Re: [PATCH 1/3] virtio: use virtio_device_ready() in
 virtio_device_restore()
Message-ID: <20220324064205-mutt-send-email-mst@kernel.org>
References: <20220324084004.14349-1-jasowang@redhat.com>
 <20220324084004.14349-2-jasowang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220324084004.14349-2-jasowang@redhat.com>
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 24, 2022 at 04:40:02PM +0800, Jason Wang wrote:
> From: Stefano Garzarella <sgarzare@redhat.com>
> 
> This avoids setting DRIVER_OK twice for those drivers that call
> virtio_device_ready() in the .restore

Is this trying to say it's faster?
If yes this one looks like a red herring. Yes we skip a write but we
replace it with a read which is not better performance-wise.
If we want to optimize this, it is better to just do that inside
virtio_add_status:



diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
index 75c8d560bbd3..cd943c31bdbb 100644
--- a/drivers/virtio/virtio.c
+++ b/drivers/virtio/virtio.c
@@ -161,8 +161,14 @@ static void virtio_config_enable(struct virtio_device *dev)
 
 void virtio_add_status(struct virtio_device *dev, unsigned int status)
 {
+	unsigned int device_status;
+
 	might_sleep();
-	dev->config->set_status(dev, dev->config->get_status(dev) | status);
+
+	device_status = dev->config->get_status(dev);
+
+	if (status & ~device_status)
+		dev->config->set_status(dev, device_status | status);
 }
 EXPORT_SYMBOL_GPL(virtio_add_status);
 

> and it will allows us to do
> extension on virtio_device_ready() without duplicating codes.
> 
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> Signed-off-by: Jason Wang <jasowang@redhat.com>
> ---
>  drivers/virtio/virtio.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
> index 22f15f444f75..75c8d560bbd3 100644
> --- a/drivers/virtio/virtio.c
> +++ b/drivers/virtio/virtio.c
> @@ -526,8 +526,9 @@ int virtio_device_restore(struct virtio_device *dev)
>  			goto err;
>  	}
>  
> -	/* Finally, tell the device we're all set */
> -	virtio_add_status(dev, VIRTIO_CONFIG_S_DRIVER_OK);
> +	/* If restore didn't do it, mark device DRIVER_OK ourselves. */

I preferred the original comment, it said why we are doing this,
new one repeats what code is doing.

> +	if (!(dev->config->get_status(dev) & VIRTIO_CONFIG_S_DRIVER_OK))
> +		virtio_device_ready(dev);
>  
>  	virtio_config_enable(dev);
>  
> -- 
> 2.25.1

