Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B58964F628E
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 17:08:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235477AbiDFPIN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 11:08:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235728AbiDFPH3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 11:07:29 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DD2F226E013
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 05:01:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649246161;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lwNNz6rv0ilLVyQt3W6CEr1qMQ3DvsSiZ2/o8ivJazg=;
        b=KLXLSSv+/teC/FVfczXF/du+2yhjpCgA4izOVL7L29BCWnn1Wrvz8ftstBjBRF02HfMFEx
        X4UdeFaixvVLZpr3Qj6/kmtntJf2kdBal/tYH8urCZnVckYaS640lH3Xkd8HIk1hygQhXA
        AmKr6rrguzZ08LNe1F9Qjc/jONb+oo8=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-556-FiuID8EsP2O7MCA6HurYXQ-1; Wed, 06 Apr 2022 07:44:26 -0400
X-MC-Unique: FiuID8EsP2O7MCA6HurYXQ-1
Received: by mail-ed1-f69.google.com with SMTP id bc9-20020a056402204900b0041cc2b0bff3so1090564edb.2
        for <linux-kernel@vger.kernel.org>; Wed, 06 Apr 2022 04:44:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=lwNNz6rv0ilLVyQt3W6CEr1qMQ3DvsSiZ2/o8ivJazg=;
        b=ZQfKn9R9Pf5uWRy+FSYDB8MegkgONse5q2hRIIXDTU6o7W1HN04CTwiFDIgb7+vzCw
         k2DxUnd08usvBwbNVhIL1x2GmXC6+LCR9/rtXKnUTIPDRZ0bm4NqjLVuGgmfJMrvkva1
         7yrxPXzJ0Zv8rafFJCvYHFSEpaX7iwZ2ZVRjmXpZpTFeBwjc1XyFK8L8Ci4f/DnK4p8H
         AA92pxlU9G02j0i/g2lD3sHsPsVK4FsYL3GBVusMzAV6Fk+eVa3yFDHCUklWMQy7VNx9
         uzlk6WFeOExsOK7VSFugC5U13PqYAFml6oSEI+NTHvFm7Sa4HRjzDzSG2sFtf5ZPzIFH
         5ppg==
X-Gm-Message-State: AOAM533YzH/jbHzbSu92V0AS0hQ47RS2Y8uO//VlxxIz3W6k0qfE/mg1
        5xeRDnAYBbPr/9tuaHIB2hymMtgNcpI0V1NRH4yRK/3QBshusrdYauKN/yRfD3K2I7u6y0vrRjN
        17r9U21xEUR+esJkHFKeOWPSS
X-Received: by 2002:a05:6402:524c:b0:419:4d8c:e959 with SMTP id t12-20020a056402524c00b004194d8ce959mr8424476edd.398.1649245465593;
        Wed, 06 Apr 2022 04:44:25 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzyKyG/d/nbodp530VzQNr4iKM6ymM514uQFrWnWG0H+UPlyK/E2bEzixWxtvJ10YNdOZnTlA==
X-Received: by 2002:a05:6402:524c:b0:419:4d8c:e959 with SMTP id t12-20020a056402524c00b004194d8ce959mr8424453edd.398.1649245465410;
        Wed, 06 Apr 2022 04:44:25 -0700 (PDT)
Received: from redhat.com ([2.53.144.12])
        by smtp.gmail.com with ESMTPSA id n9-20020a05640205c900b00418d79d4a61sm8070317edx.97.2022.04.06.04.44.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Apr 2022 04:44:24 -0700 (PDT)
Date:   Wed, 6 Apr 2022 07:44:20 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, maz@kernel.org, tglx@linutronix.de,
        peterz@infradead.org, sgarzare@redhat.com,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH V2 1/5] virtio: use virtio_device_ready() in
 virtio_device_restore()
Message-ID: <20220406073803-mutt-send-email-mst@kernel.org>
References: <20220406083538.16274-1-jasowang@redhat.com>
 <20220406083538.16274-2-jasowang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220406083538.16274-2-jasowang@redhat.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

patch had wrong mime type. I managed to extra it but pls fix.

> 
> 
> From: Stefano Garzarella <sgarzare@redhat.com>
> 
> It will allows us

will allow us

> to do extension on virtio_device_ready() without
> duplicating codes.

code

> 
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: "Paul E. McKenney" <paulmck@kernel.org>
> Cc: Marc Zyngier <maz@kernel.org>
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
> +	if (!(dev->config->get_status(dev) & VIRTIO_CONFIG_S_DRIVER_OK))
> +		virtio_device_ready(dev);
>  
>  	virtio_config_enable(dev);

it's unfortunate that this adds an extra vmexit since virtio_device_ready
calls get_status too.

We now have:

static inline
void virtio_device_ready(struct virtio_device *dev)
{
        unsigned status = dev->config->get_status(dev);
                
        BUG_ON(status & VIRTIO_CONFIG_S_DRIVER_OK);
        dev->config->set_status(dev, status | VIRTIO_CONFIG_S_DRIVER_OK);
}


I propose adding a helper and putting common code there.

>  
> -- 
> 2.25.1

