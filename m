Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7142548008
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 09:06:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232442AbiFMG66 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 02:58:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230204AbiFMG64 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 02:58:56 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3154515A2F
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jun 2022 23:58:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655103534;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EVnz/ho9DxlrFHm52CHqQgxEWsPvPMc4vPlhnhiZBWs=;
        b=LfCAHDprYOxWTv+geGXosGNsTYZJxtTbJvBGSh+Ee4gMNwfNDJ7j5zCBHG43RaHqa2Rsux
        Wmj4IS34NhZo9aiz9nQf+JJjRjB3Ig3Mlt9ZEchkP9ogaErdDfqw7/Fry9e+t49Ouf6WTD
        3DEAs6R6KTLmSDCHHF2svnMxiCBw/yw=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-41-5h83uJXrN0eGCW8YTLYLhg-1; Mon, 13 Jun 2022 02:58:52 -0400
X-MC-Unique: 5h83uJXrN0eGCW8YTLYLhg-1
Received: by mail-lf1-f70.google.com with SMTP id c21-20020a056512105500b00479762353a4so2662668lfb.8
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jun 2022 23:58:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EVnz/ho9DxlrFHm52CHqQgxEWsPvPMc4vPlhnhiZBWs=;
        b=2XrN4ItVJ/LUA7WNAUqXszEfWC3OuXOFacfP8pJj/khbmkPpLNjiWNlydyLTy9vZ8n
         OmKUroueUR1OILCR/S/M9D2L//x68rJ6RWj8HJpvt1U8PyJm7S8WYcgGr0OEKLT76gpc
         X7f33dvoU7ZqTEgzM8fhMunO+6VZaqVDvVx04aI+WkBkL2e+MBeny0Urq7B2/erzvHKU
         fcGld12lOLOHQeo/L3BJqZ1SbAdOtd630NIN5oI+VEzBqpj1hAO2llvSKf86JM4lklkP
         J4ILvu2GPiyQNxF5Bdo/1v17Xaw9e1qXzoCtNfV+rKPZpUdN6SMmlibqTnMSX6xv6BQn
         N26A==
X-Gm-Message-State: AOAM530mO/OKDjFlvXtw0ayH0Ut5jyNRNu+6/u42uGgmKBdELBHZqrN8
        ABkCkydW3BWalJNVa6WiFMctzihE0zpMRgqvLmh0OVMFpzXgs9DUiHOU8rTuzGgpSxondtXPcBo
        ceueVNx9K1g0N2dD17gVH6JMF7t5Ff4TBji2vvvzw
X-Received: by 2002:a19:4352:0:b0:479:5d1:3fef with SMTP id m18-20020a194352000000b0047905d13fefmr35820400lfj.411.1655103531237;
        Sun, 12 Jun 2022 23:58:51 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz6a6LGXWm3OgZYwL88xfGuElhH3ga+oNuMA0idjWqNAatJRR7eeOfCIdun56jsCfdiFaoecI4ffL1BftQm+y0=
X-Received: by 2002:a19:4352:0:b0:479:5d1:3fef with SMTP id
 m18-20020a194352000000b0047905d13fefmr35820387lfj.411.1655103531042; Sun, 12
 Jun 2022 23:58:51 -0700 (PDT)
MIME-Version: 1.0
References: <20220610151203.3492541-1-vincent.whitchurch@axis.com>
In-Reply-To: <20220610151203.3492541-1-vincent.whitchurch@axis.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Mon, 13 Jun 2022 14:58:40 +0800
Message-ID: <CACGkMEsf5p=JvHHjd_jtEwtdQijTR7ZAwetEuSG-oprF6RBsVA@mail.gmail.com>
Subject: Re: [PATCH] um: virt-pci: set device ready in probe()
To:     Vincent Whitchurch <vincent.whitchurch@axis.com>
Cc:     Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>, kernel@axis.com,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        linux-um@lists.infradead.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 10, 2022 at 11:12 PM Vincent Whitchurch
<vincent.whitchurch@axis.com> wrote:
>
> Call virtio_device_ready() to make this driver work after commit
> b4ec69d7e09 ("virtio: harden vring IRQ"), since the driver uses the
> virtqueues in the probe function.  (The virtio core sets the device
> ready when probe returns.)
>
> Fixes: 8b4ec69d7e09 ("virtio: harden vring IRQ")
> Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
> ---
>  arch/um/drivers/virt-pci.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/arch/um/drivers/virt-pci.c b/arch/um/drivers/virt-pci.c
> index 5c092a9153ea..027847023184 100644
> --- a/arch/um/drivers/virt-pci.c
> +++ b/arch/um/drivers/virt-pci.c
> @@ -544,6 +544,8 @@ static int um_pci_init_vqs(struct um_pci_device *dev)
>         dev->cmd_vq = vqs[0];
>         dev->irq_vq = vqs[1];
>
> +       virtio_device_ready(dev->vdev);
> +
>         for (i = 0; i < NUM_IRQ_MSGS; i++) {
>                 void *msg = kzalloc(MAX_IRQ_MSG_SIZE, GFP_KERNEL);
>
> @@ -587,7 +589,7 @@ static int um_pci_virtio_probe(struct virtio_device *vdev)
>         dev->irq = irq_alloc_desc(numa_node_id());
>         if (dev->irq < 0) {
>                 err = dev->irq;
> -               goto error;
> +               goto err_reset;
>         }
>         um_pci_devices[free].dev = dev;
>         vdev->priv = dev;
> @@ -604,6 +606,9 @@ static int um_pci_virtio_probe(struct virtio_device *vdev)
>
>         um_pci_rescan();
>         return 0;
> +err_reset:
> +       virtio_reset_device(vdev);
> +       vdev->config->del_vqs(vdev);

This part seems to be an independent fix.

Thanks

>  error:
>         mutex_unlock(&um_pci_mtx);
>         kfree(dev);
> --
> 2.34.1
>

