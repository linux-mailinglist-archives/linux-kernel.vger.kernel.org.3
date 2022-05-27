Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63374535E26
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 12:26:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350938AbiE0K0O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 06:26:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234079AbiE0K0K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 06:26:10 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2CE77111BB0
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 03:26:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1653647169;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VDuT9p5IVFO/EJoQkNQnFZKYnxf8PK4RwYvLobWGchc=;
        b=AEEFATj0zvaXv9rUeqvvMIuutN49Kwy0INKwbjCAsXvthBUMUW4xqHagF1zYLJ8Fdq5OV6
        uP2Gaxk7XH22+WiJP/omANaQRMhrq21TxGqvIqjR3rz4ymaYPBWkBwLJfHdt8IgMawC1BK
        nH3xIEk11UE4MHGCKolj7EGvQmzybjg=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-379-p6CldcwWMtWXCN-yPCuvgA-1; Fri, 27 May 2022 06:26:07 -0400
X-MC-Unique: p6CldcwWMtWXCN-yPCuvgA-1
Received: by mail-ed1-f70.google.com with SMTP id r8-20020a056402018800b00428b43999feso2817076edv.5
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 03:26:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VDuT9p5IVFO/EJoQkNQnFZKYnxf8PK4RwYvLobWGchc=;
        b=JxlyU5rH9o4Pf5S1NuCaLe9nnFdl9Nnw1h9tvubvvF0ICkl646oKtw6JlOsO9CSxKY
         uMSH++H97zqnrbbKKDF9pp6W6VhMJ1zX3HDArBjYuGINWDoNzNTZW2UyFDmJaps01BmQ
         CzyYdP3uJRRjGVdCdTXmNZn9tn8Y0JPHIFWY022yoWVZKqooLB0Muy29oVesm+QUhbMs
         oVqwI7iZ9VtLeSMfnCO7ooNV4t91t0hHXdj2e4d4J49l6VTgO/KxghfHJZNmZ3riU2dv
         ekKQ1qEXn+/S4/Vmk/FscoE8cLkODVtOHmWxEYXJxbOU0VBgDn1VL5nSqJVKCGbjAQNr
         7KHw==
X-Gm-Message-State: AOAM533Zj3Hn67A3FSyt18YN4MwWqNUaF26oHEtlakuHYmHFHHK32xLp
        b6gdvWhVOXArcjvomfVtJtPsmue2Qu6AwtKQuNCFAnP/ZeYiuqHXjwTh2mAEiFdZ18PTL6la2Lo
        +maaukghPCD+2p96R7OJBGaeL
X-Received: by 2002:a17:907:8a01:b0:6ff:3eab:9dfa with SMTP id sc1-20020a1709078a0100b006ff3eab9dfamr1366878ejc.467.1653647166570;
        Fri, 27 May 2022 03:26:06 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy9zkt6pxv2eemrcADCJv6daaUMF9g2JEKNpj/qII2hYbZ7VhwCc2ToG0nrfb37bYAX4O8kXQ==
X-Received: by 2002:a17:907:8a01:b0:6ff:3eab:9dfa with SMTP id sc1-20020a1709078a0100b006ff3eab9dfamr1366866ejc.467.1653647166363;
        Fri, 27 May 2022 03:26:06 -0700 (PDT)
Received: from redhat.com ([2.55.130.213])
        by smtp.gmail.com with ESMTPSA id p19-20020a50cd93000000b0042617ba63besm1915464edi.72.2022.05.27.03.26.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 May 2022 03:26:05 -0700 (PDT)
Date:   Fri, 27 May 2022 06:26:02 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     keliu <liuke94@huawei.com>
Cc:     jasowang@redhat.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] virtio: Directly use ida_alloc()/free()
Message-ID: <20220527062533-mutt-send-email-mst@kernel.org>
References: <20220527073302.2474073-1-liuke94@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220527073302.2474073-1-liuke94@huawei.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 27, 2022 at 07:33:02AM +0000, keliu wrote:
> Use ida_alloc()/ida_free() instead of deprecated
> ida_simple_get()/ida_simple_remove() .
> 
> Signed-off-by: keliu <liuke94@huawei.com>

Please Cc people that commented on the original patch. thanks!

> ---
>  drivers/virtio/virtio.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
> index 22f15f444f75..143f94652306 100644
> --- a/drivers/virtio/virtio.c
> +++ b/drivers/virtio/virtio.c
> @@ -413,7 +413,7 @@ int register_virtio_device(struct virtio_device *dev)
>  	device_initialize(&dev->dev);
>  
>  	/* Assign a unique device index and hence name. */
> -	err = ida_simple_get(&virtio_index_ida, 0, 0, GFP_KERNEL);
> +	err = ida_alloc(&virtio_index_ida, GFP_KERNEL);
>  	if (err < 0)
>  		goto out;
>  
> @@ -451,7 +451,7 @@ int register_virtio_device(struct virtio_device *dev)
>  out_of_node_put:
>  	of_node_put(dev->dev.of_node);
>  out_ida_remove:
> -	ida_simple_remove(&virtio_index_ida, dev->index);
> +	ida_free(&virtio_index_ida, dev->index);
>  out:
>  	virtio_add_status(dev, VIRTIO_CONFIG_S_FAILED);
>  	return err;
> @@ -469,7 +469,7 @@ void unregister_virtio_device(struct virtio_device *dev)
>  	int index = dev->index; /* save for after device release */
>  
>  	device_unregister(&dev->dev);
> -	ida_simple_remove(&virtio_index_ida, index);
> +	ida_free(&virtio_index_ida, index);
>  }
>  EXPORT_SYMBOL_GPL(unregister_virtio_device);
>  
> -- 
> 2.25.1

