Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87E0F55CBE0
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:00:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241072AbiF0UHr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 16:07:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241066AbiF0UHn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 16:07:43 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 771E91EAC6
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 13:07:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656360461;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ecqp7u4gJaJ1mXBxwxi4FG5ZEdhI/0Q2gMOetVHGIac=;
        b=I6uygNf9NLWyYkiVXyTpjNLUpaz+LuiTCtj6gpREk4VOJPZhL4jERePVIVtS5JnSiI0s4c
        mn1zkfedANnxANVWsHqzUq6idFDGvvxdi6LaDkPekAYSl+E5pskKFxU/lrsLx7NqdpeuvC
        4G7usOLIghLRV3T16cGbig5v+Tx0iHk=
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com
 [209.85.166.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-437-8e6gJHyuPgmVoe2sfJ6wKQ-1; Mon, 27 Jun 2022 16:07:38 -0400
X-MC-Unique: 8e6gJHyuPgmVoe2sfJ6wKQ-1
Received: by mail-io1-f70.google.com with SMTP id d11-20020a6bb40b000000b006727828a19fso6205229iof.15
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 13:07:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=Ecqp7u4gJaJ1mXBxwxi4FG5ZEdhI/0Q2gMOetVHGIac=;
        b=Am55Y5xWhkdjoW4fupTS9J0b7v1Vc3FQ4urEuV4RC9fPy8JTFQEdGrdF6BvcIsJu9y
         LCfbD0Z3JliE1dxbuwNR4WpYu7LuTemEQVdiKFxisBH3L3NaI6X34WC9bTsPkQABqfuN
         7PHMgq22dtydysVo0M21cJf9Uak9tczkZwyoFlUYpUUZmmUAUnmWCczuhTnZ0hLk+h6C
         9u8xedYTa5FQJUQMIudRxFHCgiU0yg9i2A904+zYNapsjDxMSj5h6PxGmQnDdBWDIopk
         4F281a+IhqQ6o83+1AdcHvUaMIjxJk9aTsYW6Yw0DEbBPk4U2F2vMwTd1ImjBRjwedGG
         fqPw==
X-Gm-Message-State: AJIora/ZryJtZBk4BZdAYhyFYO+FyaXQVRGo8m1wguoJsHeJ7s5e2SWO
        FLcX56RUlaPsMk6ZKueTkjAWfYOCDOG2On6uUJtmXTCZffXsxmjUzfS66KOqngr8sVvcYhKoY9b
        //FsLayky6Kr+dUlHmEr9EcN8
X-Received: by 2002:a05:6638:22c7:b0:333:f684:ccc4 with SMTP id j7-20020a05663822c700b00333f684ccc4mr8853611jat.57.1656360457270;
        Mon, 27 Jun 2022 13:07:37 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1sNIPUYijEfnPKfQZWxOpm7YokpOplZ2wBAN4sSDoCyh8jOJGTEHm2vhuygZD7iG02GUVE7+w==
X-Received: by 2002:a05:6638:22c7:b0:333:f684:ccc4 with SMTP id j7-20020a05663822c700b00333f684ccc4mr8853601jat.57.1656360457084;
        Mon, 27 Jun 2022 13:07:37 -0700 (PDT)
Received: from redhat.com ([38.15.36.239])
        by smtp.gmail.com with ESMTPSA id x66-20020a0294c8000000b00339dd803fddsm5190825jah.174.2022.06.27.13.07.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 13:07:36 -0700 (PDT)
Date:   Mon, 27 Jun 2022 14:07:35 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk,
        Jens Axboe <axboe@kernel.dk>, linux-fsdevel@vger.kernel.org,
        Cornelia Huck <cohuck@redhat.com>, kvm@vger.kernel.org
Subject: Re: [PATCH v2 8/8] vfio: do not set FMODE_LSEEK flag
Message-ID: <20220627140735.32723d4a.alex.williamson@redhat.com>
In-Reply-To: <20220625110115.39956-9-Jason@zx2c4.com>
References: <20220625110115.39956-1-Jason@zx2c4.com>
        <20220625110115.39956-9-Jason@zx2c4.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 25 Jun 2022 13:01:15 +0200
"Jason A. Donenfeld" <Jason@zx2c4.com> wrote:

> This file does not support llseek, so don't set the flag advertising it.
> 
> Cc: Alex Williamson <alex.williamson@redhat.com>
> Cc: Cornelia Huck <cohuck@redhat.com>
> Cc: kvm@vger.kernel.org
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
> ---
>  drivers/vfio/vfio.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/vfio/vfio.c b/drivers/vfio/vfio.c
> index 61e71c1154be..d194dda89542 100644
> --- a/drivers/vfio/vfio.c
> +++ b/drivers/vfio/vfio.c
> @@ -1129,7 +1129,7 @@ static struct file *vfio_device_open(struct vfio_device *device)
>  	 * Appears to be missing by lack of need rather than
>  	 * explicitly prevented.  Now there's need.
>  	 */
> -	filep->f_mode |= (FMODE_LSEEK | FMODE_PREAD | FMODE_PWRITE);
> +	filep->f_mode |= (FMODE_PREAD | FMODE_PWRITE);
>  
>  	if (device->group->type == VFIO_NO_IOMMU)
>  		dev_warn(device->dev, "vfio-noiommu device opened by user "

Acked-by: Alex Williamson <alex.williamson@redhat.com>

