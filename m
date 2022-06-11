Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2A33547089
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Jun 2022 02:34:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244552AbiFKAeP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 20:34:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229693AbiFKAeM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 20:34:12 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 93DFF237E5
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 17:34:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654907650;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=V38chhU7Rt8pI+XdIYY3ayCSIYGMzE0MLR8B7qxjG4o=;
        b=BAvnRsckRHK23hf1+/18iK7QaWW1iz1E01ve3eVSFrbaIcw+BzKkjA8ohaxagV4eNO5SuT
        INOR5p324SjZz3tJj7toGOUdxZoiW8yrdAftPmin/rLZaSbWLkSO6V8cac7V3YFTU4uPOp
        YbkJjEGgNme6a6repmbTA2ktgZl2C2Y=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-177-JHzy1UWzNJ6SqYPZjoutZA-1; Fri, 10 Jun 2022 20:34:09 -0400
X-MC-Unique: JHzy1UWzNJ6SqYPZjoutZA-1
Received: by mail-ed1-f71.google.com with SMTP id f9-20020a056402354900b0042ded146259so414336edd.20
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 17:34:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=V38chhU7Rt8pI+XdIYY3ayCSIYGMzE0MLR8B7qxjG4o=;
        b=oRCfGz2oRywGHFeaC0q8Bl3oacCF1+zUApv1/UjSyyckB+rl87zOBXA+/7vVrxAjF6
         9MgMN+1Rbe51nlSadaDf8CvyHSp4HLvpRVk9Wyd7ZcGIXDenDJxoaJSYcG/uAkqzmgsB
         7kcyJ/RQ59VPFqXnBpWqhY4JwkKSjHB1giGpZt+C2cdQF/oeTU96qfH3zCxL3P5e8cil
         71n9ZidtDqu2pCkM8HIIKdGbOYziQKgH8gRoRdqO9AH2ll3hnpF6LSZO3D+sBJwF6pN6
         DNgi2BLggvzplwQBPy9UyYafg9Da7ElCg6wbB+6XoVBHysPUdIXttSD3pgoaQHu40+09
         7JXw==
X-Gm-Message-State: AOAM533tNikNSDYtrMbdpX8wGp0R6LNUgrI5NHPMKH9dSSQYqIlJ/7yz
        KSPjrBd2RmO5ZJs11yMSyDXHpaSmwMqZaGT/bAHW5i8YKNUgchxl/zk+2Vy5Hakj/gI5H5X2x9A
        YxDw5FpxOStNR/P90aRPyzEP7
X-Received: by 2002:a17:906:25d8:b0:6fe:9f11:3906 with SMTP id n24-20020a17090625d800b006fe9f113906mr41849306ejb.538.1654907648054;
        Fri, 10 Jun 2022 17:34:08 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw64BHWErs2WYKLYmaViPJEf5qIVFc06JTy7cov2ambzElJmWiq1g08SZ00zN56jWtYF0/qEA==
X-Received: by 2002:a17:906:25d8:b0:6fe:9f11:3906 with SMTP id n24-20020a17090625d800b006fe9f113906mr41849284ejb.538.1654907647803;
        Fri, 10 Jun 2022 17:34:07 -0700 (PDT)
Received: from redhat.com ([212.116.178.142])
        by smtp.gmail.com with ESMTPSA id l21-20020a056402125500b0042dddaa8af3sm429357edw.37.2022.06.10.17.34.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jun 2022 17:34:07 -0700 (PDT)
Date:   Fri, 10 Jun 2022 20:34:04 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Vincent Whitchurch <vincent.whitchurch@axis.com>
Cc:     Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>, kernel@axis.com,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        Jason Wang <jasowang@redhat.com>, linux-um@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] um: virt-pci: set device ready in probe()
Message-ID: <20220610203029-mutt-send-email-mst@kernel.org>
References: <20220610151203.3492541-1-vincent.whitchurch@axis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220610151203.3492541-1-vincent.whitchurch@axis.com>
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 10, 2022 at 05:12:03PM +0200, Vincent Whitchurch wrote:
> Call virtio_device_ready() to make this driver work after commit
> b4ec69d7e09 ("virtio: harden vring IRQ"), since the driver uses the
> virtqueues in the probe function.  (The virtio core sets the device
> ready when probe returns.)
> 
> Fixes: 8b4ec69d7e09 ("virtio: harden vring IRQ")
> Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>

Also fixes this commit:

commit 68f5d3f3b6543266b29e047cfaf9842333019b4c
Author: Johannes Berg <johannes.berg@intel.com>
Date:   Fri Mar 5 13:19:58 2021 +0100

    um: add PCI over virtio emulation driver
    

BTW Johannes I think you need to spec this device and get
an ID - what's the plan for that? Current hack of punting
this to userspace isn't really any good long term.


> ---
>  arch/um/drivers/virt-pci.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/um/drivers/virt-pci.c b/arch/um/drivers/virt-pci.c
> index 5c092a9153ea..027847023184 100644
> --- a/arch/um/drivers/virt-pci.c
> +++ b/arch/um/drivers/virt-pci.c
> @@ -544,6 +544,8 @@ static int um_pci_init_vqs(struct um_pci_device *dev)
>  	dev->cmd_vq = vqs[0];
>  	dev->irq_vq = vqs[1];
>  
> +	virtio_device_ready(dev->vdev);
> +
>  	for (i = 0; i < NUM_IRQ_MSGS; i++) {
>  		void *msg = kzalloc(MAX_IRQ_MSG_SIZE, GFP_KERNEL);
>  
> @@ -587,7 +589,7 @@ static int um_pci_virtio_probe(struct virtio_device *vdev)
>  	dev->irq = irq_alloc_desc(numa_node_id());
>  	if (dev->irq < 0) {
>  		err = dev->irq;
> -		goto error;
> +		goto err_reset;
>  	}
>  	um_pci_devices[free].dev = dev;
>  	vdev->priv = dev;
> @@ -604,6 +606,9 @@ static int um_pci_virtio_probe(struct virtio_device *vdev)
>  
>  	um_pci_rescan();
>  	return 0;
> +err_reset:
> +	virtio_reset_device(vdev);
> +	vdev->config->del_vqs(vdev);
>  error:
>  	mutex_unlock(&um_pci_mtx);
>  	kfree(dev);
> -- 
> 2.34.1

