Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 935BE58BE1B
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 00:57:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230233AbiHGW5J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Aug 2022 18:57:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbiHGW5G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Aug 2022 18:57:06 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 458152634
        for <linux-kernel@vger.kernel.org>; Sun,  7 Aug 2022 15:57:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659913024;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DRG3kxi36PNmVinjdItykZfWEJs1QIH2+MUoMsMB+M0=;
        b=LTmyR3cThuKtgkMgp9HiJdX4j0nr5jymPxJf6yy2Rpw/E2xCrE5q1LfSsaXygS5LvAwB22
        uaw58RhoizljZzALDueoT/3PRuZEBLs0DYVu8Lay7M9NexFX96lvsp5aQ10I6xOYuJ1lQv
        cWfbge9oOAjIrhICuSDLMpxDuMYyNLo=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-592-4OoprNGdPoGA_fmSGI6BRg-1; Sun, 07 Aug 2022 18:57:03 -0400
X-MC-Unique: 4OoprNGdPoGA_fmSGI6BRg-1
Received: by mail-wm1-f72.google.com with SMTP id v130-20020a1cac88000000b003a4f057ed9fso3945275wme.7
        for <linux-kernel@vger.kernel.org>; Sun, 07 Aug 2022 15:57:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=DRG3kxi36PNmVinjdItykZfWEJs1QIH2+MUoMsMB+M0=;
        b=ihUnBoPYLB6rJfhZJ1jx2jbaRpHVD+HWnMTYSV4ouFLV4RpeTH3kzzpeLJNvo1vKDm
         HddFkMsyjtZepE25Fa6OT5DeNuKyWvlCtAkYhL8fQ7lMvLCZFXAGkbjg+q5FevI6VjcS
         k6ms89aPxGTkjOUBRi8HF/fnnFnvLdAVpgHMXC8/lEkK66dEjdlzEPfDnBkTCNFkK7kS
         FyQ6yjB21ua2Ul2rXKc+ScuvFbGfA7N9gVfXpMb1MYkLe1vmNigg+edc3Ihr+ncGnsaR
         8b3BYGa5B4xTp8MQ0Oz7xyidZC3V3HjGYMNTuEYeA0VdcJvBxhk/71wd0yGzSsofJe2F
         km+g==
X-Gm-Message-State: ACgBeo30zSM7iK629LPZ5ndwtH2xpTO7ncw7YqvnpJ3i+nIqYpYSKVF/
        hnhgESvh9d0pU7no0kmg/UQ+hS0Lrrei+Y/Hr7M2dt5DSToY0ir7I+AB9kDvwAR8hT7Xsptr2Gk
        B3G1xraE5lK+UsEhXW5UBYRKL
X-Received: by 2002:adf:dfca:0:b0:21f:c93:5c36 with SMTP id q10-20020adfdfca000000b0021f0c935c36mr9565188wrn.41.1659913021921;
        Sun, 07 Aug 2022 15:57:01 -0700 (PDT)
X-Google-Smtp-Source: AA6agR4DQBpZdhf0pAyeZfbLu4dv8LJ5Uprgoh7hJXP8hoIGau82PS3zKRDTJ/sqZNm7PtU1kq2lQA==
X-Received: by 2002:adf:dfca:0:b0:21f:c93:5c36 with SMTP id q10-20020adfdfca000000b0021f0c935c36mr9565176wrn.41.1659913021591;
        Sun, 07 Aug 2022 15:57:01 -0700 (PDT)
Received: from redhat.com ([2.52.21.123])
        by smtp.gmail.com with ESMTPSA id w11-20020a1cf60b000000b003a5260b8392sm4523962wmc.23.2022.08.07.15.56.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Aug 2022 15:57:01 -0700 (PDT)
Date:   Sun, 7 Aug 2022 18:56:57 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Igor Skalkin <Igor.Skalkin@opensynergy.com>
Cc:     Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] virtio-mmio: Introduce virtio_mmio hotplug
Message-ID: <20220807185612-mutt-send-email-mst@kernel.org>
References: <20220807215226.36507-1-Igor.Skalkin@opensynergy.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220807215226.36507-1-Igor.Skalkin@opensynergy.com>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 07, 2022 at 11:52:26PM +0200, Igor Skalkin wrote:
> From: Igor Skalkin <igor.skalkin@opensynergy.com>
> 
> While the virtio device is not yet running, the virtual machine manager
> advertises the device with device_id set to 0.
> During virtio mmio probing, the device_id is checked, and if it is 0,
> the rest of the probing function is deferred until the interrupt arrives.
> 
> Signed-off-by: Igor Skalkin <igor.skalkin@opensynergy.com>

Given this is clearly an extension to host/guest ABI, please
propose this on the virtio TC mailing list.


> ---
> In our setup, we have a Linux host running virtio devices and virtualised
> Linux/Android Guest[s] running virtio drivers.
> Situation "the guest OS calls the probe() function for the virtio driver,
> but the virtio device has not yet started in the host OS." keeps happening.
> Also, some devices need to be hot-plugged later instead of starting during
> system sturtup.
> 
> Probing of the guest virtio drivers should be deferred until the host device
> has started.
> ---
>  drivers/virtio/virtio_mmio.c | 58 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 58 insertions(+)
> 
> diff --git a/drivers/virtio/virtio_mmio.c b/drivers/virtio/virtio_mmio.c
> index 083ff1eb743d..c2e28a8faaaa 100644
> --- a/drivers/virtio/virtio_mmio.c
> +++ b/drivers/virtio/virtio_mmio.c
> @@ -91,6 +91,8 @@ struct virtio_mmio_device {
>  	/* a list of queues so we can dispatch IRQs */
>  	spinlock_t lock;
>  	struct list_head virtqueues;
> +
> +	struct work_struct hotplug_work;
>  };
>  
>  struct virtio_mmio_vq_info {
> @@ -592,6 +594,43 @@ static void virtio_mmio_release_dev(struct device *_d)
>  
>  /* Platform device */
>  
> +static irqreturn_t hotplug_interrupt(int irq, void *opaque)
> +{
> +	struct virtio_mmio_device *vm_dev = opaque;
> +
> +	if (readl(vm_dev->base + VIRTIO_MMIO_DEVICE_ID))
> +		schedule_work(&vm_dev->hotplug_work);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static int virtio_mmio_request_irq(irq_handler_t handler,
> +				   struct virtio_mmio_device *vm_dev)
> +{
> +	int err;
> +
> +	err = request_irq(platform_get_irq(vm_dev->pdev, 0), handler,
> +			  IRQF_SHARED, dev_name(&vm_dev->pdev->dev), vm_dev);
> +	if (err)
> +		dev_err(&vm_dev->pdev->dev, "request_irq(%s) returns %d\n",
> +			dev_name(&vm_dev->pdev->dev), err);
> +
> +	return err;
> +}
> +
> +static int finish_probe(struct virtio_mmio_device *vm_dev);
> +static void virtio_mmio_hotplug_work(struct work_struct *hotplug_work)
> +{
> +	struct virtio_mmio_device *vm_dev =
> +		container_of(hotplug_work, struct virtio_mmio_device,
> +			    hotplug_work);
> +
> +	free_irq(platform_get_irq(vm_dev->pdev, 0), vm_dev);
> +
> +	if (finish_probe(vm_dev))
> +		virtio_mmio_request_irq(hotplug_interrupt, vm_dev);
> +}
> +
>  static int virtio_mmio_probe(struct platform_device *pdev)
>  {
>  	struct virtio_mmio_device *vm_dev;
> @@ -628,6 +667,25 @@ static int virtio_mmio_probe(struct platform_device *pdev)
>  		return -ENXIO;
>  	}
>  
> +	vm_dev->vdev.id.device = readl(vm_dev->base + VIRTIO_MMIO_DEVICE_ID);
> +	if (!vm_dev->vdev.id.device) {
> +		rc = virtio_mmio_request_irq(hotplug_interrupt, vm_dev);
> +		if (rc)
> +			return rc;
> +
> +		INIT_WORK(&vm_dev->hotplug_work, virtio_mmio_hotplug_work);
> +
> +		return 0;
> +	}
> +
> +	return finish_probe(vm_dev);
> +}
> +
> +static int finish_probe(struct virtio_mmio_device *vm_dev)
> +{
> +	struct platform_device *pdev = vm_dev->pdev;
> +	int rc;
> +
>  	vm_dev->vdev.id.device = readl(vm_dev->base + VIRTIO_MMIO_DEVICE_ID);
>  	if (vm_dev->vdev.id.device == 0) {
>  		/*
> -- 
> 2.37.1

