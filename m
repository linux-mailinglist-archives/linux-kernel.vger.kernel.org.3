Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE2C45699B7
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 07:10:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234694AbiGGFKF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 01:10:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbiGGFKE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 01:10:04 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0A1B831225
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 22:10:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657170601;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=u9lzc6w/Opw97U2hLgEhRkh2O+cH+saQhnPq0SCuszs=;
        b=VignCwS7Kqkb41W05tML3VxtQpHxD4P/lwb15dGlAEkktsO11BEEMU+bk9lf44sMXoPehP
        RMnl0mmVZ5enBeE3gYM2J+0llDfETvLXpdwYVg/xV8AOEuSBorciyE7YDsedDuUQcNFQVe
        kB/FnxW1AtegVbOCx6Pyk7WZsPsY87A=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-608-dT9wpTb_NieJ6Dn_vt_7nQ-1; Thu, 07 Jul 2022 01:10:00 -0400
X-MC-Unique: dT9wpTb_NieJ6Dn_vt_7nQ-1
Received: by mail-ed1-f72.google.com with SMTP id g7-20020a056402424700b00435ac9c7a8bso13123545edb.14
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jul 2022 22:10:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=u9lzc6w/Opw97U2hLgEhRkh2O+cH+saQhnPq0SCuszs=;
        b=Y8Nd7CUJc+/rwla3GbyPhVpUiKqSdGjYggcPZ+XIz1YYgjDYEUguctDqctk73FZxye
         O9NZ26Sol435dAOZGk87S9XWSADstRVm33XdFrygh8Y+EuQi403Uts5X755m5ggr7Ac8
         sEsJ420Qkk8+DnLslm++RoHUAePpWN6kYCYDtmGT1suezlh/GmoKZECwWYSdGhXbeMc7
         lFaoAjvVebDa/3r7qSM3yuPg4hiQWVC5jr/JOSOng/bDlLLEx1aJVvTQ6c3gV5ex2Ad8
         9wd57rcM11KuYfTzdrqTtU0sQwCC+EDdwLiHO9NtKR9fCGZzhgtjWE7O29M1owvnaopX
         BzHQ==
X-Gm-Message-State: AJIora/+NIl1vhtVGudBy+cYkJEVKVOEyJGqKloG4j2i8FYzjNMfG9Z5
        qpUQLbkTizrQRME7TIkpy2SiRMonwaELxrAZsekcY4ThXOs30ER8pui1yAea1N6ntVI0AotURTI
        Cqy7yzmzcvQVDLvWGmXec/viR
X-Received: by 2002:a05:6402:3705:b0:43a:214b:5f40 with SMTP id ek5-20020a056402370500b0043a214b5f40mr30738830edb.83.1657170599291;
        Wed, 06 Jul 2022 22:09:59 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1sohhdZNZE7c0EBG3VjG+K42I/xUZSo8tDQCDdtJmisQuBT4yRmnBw6C2WBL3mzB4KECJQUsw==
X-Received: by 2002:a05:6402:3705:b0:43a:214b:5f40 with SMTP id ek5-20020a056402370500b0043a214b5f40mr30738812edb.83.1657170599059;
        Wed, 06 Jul 2022 22:09:59 -0700 (PDT)
Received: from redhat.com ([2.52.154.68])
        by smtp.gmail.com with ESMTPSA id b4-20020a1709065e4400b00706287ba061sm18290813eju.180.2022.07.06.22.09.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jul 2022 22:09:58 -0700 (PDT)
Date:   Thu, 7 Jul 2022 01:09:55 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Guo Zhi <qtxuning1999@sjtu.edu.cn>
Cc:     jasowang@redhat.com, eperezma@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, sgarzare@redhat.com
Subject: Re: [PATCH v2 2/4] virtio_test: move magic number in code as defined
 constant
Message-ID: <20220707010036-mutt-send-email-mst@kernel.org>
References: <20220707024409.1869-1-qtxuning1999@sjtu.edu.cn>
 <20220707024409.1869-3-qtxuning1999@sjtu.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220707024409.1869-3-qtxuning1999@sjtu.edu.cn>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 07, 2022 at 10:44:07AM +0800, Guo Zhi wrote:
> We should avoid using magic numbers directly.

Not necessarily. For repeated values - I guess.
But this kind of thing:

	#define BUF_SIZE 1024
	int buf_size = BUF_SIZE;

brings no benefit IMHO.

And this has cost - values are now removed from code.


> Signed-off-by: Guo Zhi <qtxuning1999@sjtu.edu.cn>
> ---
>  tools/virtio/virtio_test.c | 18 +++++++++++-------
>  1 file changed, 11 insertions(+), 7 deletions(-)
> 
> diff --git a/tools/virtio/virtio_test.c b/tools/virtio/virtio_test.c
> index 95f78b311..1ecd64271 100644
> --- a/tools/virtio/virtio_test.c
> +++ b/tools/virtio/virtio_test.c
> @@ -20,7 +20,10 @@
>  #include "../../drivers/vhost/test.h"
>  
>  #define RANDOM_BATCH -1
> -
> +#define ALIGN 4096
> +#define RINGSIZE   256
> +#define TEST_BUF_NUM 0x100000
> +#define BUF_SIZE   1024
>  /* Unused */
>  void *__kmalloc_fake, *__kfree_ignore_start, *__kfree_ignore_end;
>  
> @@ -100,8 +103,8 @@ static void vq_reset(struct vq_info *info, int num, struct virtio_device *vdev)
>  	if (info->vq)
>  		vring_del_virtqueue(info->vq);
>  
> -	memset(info->ring, 0, vring_size(num, 4096));
> -	vring_init(&info->vring, num, info->ring, 4096);
> +	memset(info->ring, 0, vring_size(num, ALIGN));
> +	vring_init(&info->vring, num, info->ring, ALIGN);
>  	info->vq = __vring_new_virtqueue(info->idx, info->vring, vdev, true,
>  					 false, vq_notify, vq_callback, "test");
>  	assert(info->vq);
> @@ -115,7 +118,7 @@ static void vq_info_add(struct vdev_info *dev, int num)
>  	info->idx = dev->nvqs;
>  	info->kick = eventfd(0, EFD_NONBLOCK);
>  	info->call = eventfd(0, EFD_NONBLOCK);
> -	r = posix_memalign(&info->ring, 4096, vring_size(num, 4096));
> +	r = posix_memalign(&info->ring, PAGE_SIZE, vring_size(num, ALIGN));
>  	assert(r >= 0);
>  	vq_reset(info, num, &dev->vdev);
>  	vhost_vq_setup(dev, info);

This is actually doing more than what commit log says.

> @@ -131,7 +134,7 @@ static void vdev_info_init(struct vdev_info* dev, unsigned long long features)
>  	dev->vdev.features = features;
>  	INIT_LIST_HEAD(&dev->vdev.vqs);
>  	spin_lock_init(&dev->vdev.vqs_list_lock);
> -	dev->buf_size = 1024;
> +	dev->buf_size = BUF_SIZE;


This seems to have zero added value.

>  	dev->buf = malloc(dev->buf_size);
>  	assert(dev->buf);
>          dev->control = open("/dev/vhost-test", O_RDWR);
> @@ -396,7 +399,8 @@ int main(int argc, char **argv)
>  
>  done:
>  	vdev_info_init(&dev, features);
> -	vq_info_add(&dev, 256);
> -	run_test(&dev, &dev.vqs[0], delayed, batch, reset, 0x100000);
> +	vq_info_add(&dev, RINGSIZE);
> +
> +	run_test(&dev, &dev.vqs[0], delayed, batch, reset, TEST_BUF_NUM);
>  	return 0;


This replacement does not buy us anything either.

>  }
> -- 
> 2.17.1

