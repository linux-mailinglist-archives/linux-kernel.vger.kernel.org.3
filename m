Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB8B1565DCB
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 21:07:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234358AbiGDTHK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 15:07:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234070AbiGDTGs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 15:06:48 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B732394
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 12:06:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656961606;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WfXQYFuDfrhz+WVvDK9xALG3EwqA/PP/d2XZNB+VRI8=;
        b=JpzxlYJcBXvQeiEKNcgxUdfUDvudYZ9qwlzyXZAjsca34CTi/gBUjqqfB9lJYLIxA8InDf
        Yt3qEMY4qbe9WPOLn+Q4M5zwoR8vTDmNkj9fHcQkxBp1A7fhI9Ufo1l2YADDegXmxm1c7r
        BR7SQhfCbr1VrJYohaSdSRW2TZ60o00=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-338-SDo1f-vQONmsk2Z2lS_ytA-1; Mon, 04 Jul 2022 15:06:45 -0400
X-MC-Unique: SDo1f-vQONmsk2Z2lS_ytA-1
Received: by mail-ed1-f71.google.com with SMTP id x21-20020a05640226d500b00435bd7f9367so7674858edd.8
        for <linux-kernel@vger.kernel.org>; Mon, 04 Jul 2022 12:06:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WfXQYFuDfrhz+WVvDK9xALG3EwqA/PP/d2XZNB+VRI8=;
        b=J0Fkari6j50rh1swEoB9gGR6m+3LIJhP3sFAqHF0nOIZ5zwTDDFTb8/nsYSW4qwu6J
         Yx5V/DwPFL4Ai32zJsDbrTidC7v1K2t7SpGEXGGxu823vtOpF3X+hboEHEzYk1b/ToGi
         wJjTYJldKlV0vT3PFuicm/dvTct+YZWBpTa2hN9O/C6TiwsRNnS+qZLx3xCPOUeXil48
         UIAvt/yDdazQPlgjC7Q35qrLbb9Z44nl2EON1nND+JAiFekO00TXpaTgU3sIzDiG4/aW
         cv0o9owPnwydbTdNf6JFHxHJFWC4Z2GpGsMws5pSh5vNiMHC04EABM+cNVoeOmhnApOG
         dfng==
X-Gm-Message-State: AJIora/eQNzwfQouDAGH7lQFEKMHynOqXYGEtd3ImHTnl2sAAn7434wG
        fD9ueP52ttwKV8o7Of3R8yxkdlknmPZn6p4iuZwFn/fVIjfVkmOCDsQdbWC0KV/avQ/1eW4QDfE
        vvo6IYcfWULfHnQwpF1an0P1/
X-Received: by 2002:a05:6402:3299:b0:435:787f:8058 with SMTP id f25-20020a056402329900b00435787f8058mr40166317eda.79.1656961604068;
        Mon, 04 Jul 2022 12:06:44 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vWnqDzKiOpdp5G+XIpdRs68Qb1jnMF3TCK3ipZgd7GJIvgSLARSQkr3ouFOBVGku1LmxOrsw==
X-Received: by 2002:a05:6402:3299:b0:435:787f:8058 with SMTP id f25-20020a056402329900b00435787f8058mr40166301eda.79.1656961603881;
        Mon, 04 Jul 2022 12:06:43 -0700 (PDT)
Received: from redhat.com ([2.55.3.188])
        by smtp.gmail.com with ESMTPSA id f19-20020a170906825300b0071160715917sm14659992ejx.223.2022.07.04.12.06.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jul 2022 12:06:43 -0700 (PDT)
Date:   Mon, 4 Jul 2022 15:06:39 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Stefano Garzarella <sgarzare@redhat.com>
Cc:     virtualization@lists.linux-foundation.org,
        Jason Wang <jasowang@redhat.com>, linux-kernel@vger.kernel.org,
        Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>
Subject: Re: [RFC PATCH 3/6] virtio_test: call __virtio_unbreak_device
Message-ID: <20220704150450-mutt-send-email-mst@kernel.org>
References: <20220704171701.127665-1-sgarzare@redhat.com>
 <20220704171701.127665-4-sgarzare@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220704171701.127665-4-sgarzare@redhat.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 04, 2022 at 07:16:58PM +0200, Stefano Garzarella wrote:
> Commit 8b4ec69d7e09 ("virtio: harden vring IRQ") initialize vq->broken
> to true, so we need to call __virtio_unbreak_device() before starting
> to use it.
> 
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>

I think this shouldn't be necessary with latest master.

> ---
>  tools/virtio/linux/virtio.h | 2 ++
>  tools/virtio/virtio_test.c  | 1 +
>  2 files changed, 3 insertions(+)
> 
> diff --git a/tools/virtio/linux/virtio.h b/tools/virtio/linux/virtio.h
> index 363b98228301..feb720d4304f 100644
> --- a/tools/virtio/linux/virtio.h
> +++ b/tools/virtio/linux/virtio.h
> @@ -66,4 +66,6 @@ struct virtqueue *vring_new_virtqueue(unsigned int index,
>  				      const char *name);
>  void vring_del_virtqueue(struct virtqueue *vq);
>  
> +void __virtio_unbreak_device(struct virtio_device *dev);
> +
>  #endif
> diff --git a/tools/virtio/virtio_test.c b/tools/virtio/virtio_test.c
> index 23f142af544a..765e64895dab 100644
> --- a/tools/virtio/virtio_test.c
> +++ b/tools/virtio/virtio_test.c
> @@ -177,6 +177,7 @@ static void run_test(struct vdev_info *dev, struct vq_info *vq,
>  	long long spurious = 0;
>  	const bool random_batch = batch == RANDOM_BATCH;
>  
> +	__virtio_unbreak_device(&dev->vdev);
>  	r = ioctl(dev->control, VHOST_TEST_RUN, &test);
>  	assert(r >= 0);
>  	if (!reset_n) {
> -- 
> 2.36.1

