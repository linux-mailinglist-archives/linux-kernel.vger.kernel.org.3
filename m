Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C90350E0A0
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 14:44:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242211AbiDYMrZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 08:47:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242195AbiDYMrR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 08:47:17 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6F395DA6D9
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 05:44:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650890652;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VCRRJvi0nBuRvSQkvgjPsxK/+2snqkLfcZ0Y3XDHbLM=;
        b=PsOdKOzwgUPbjSwitTUGECXs5z3IIEjo+krlrcLbeS2C2njRlydpqSt3rHGDvtrF7R65aL
        zoRR7nqdkf2dJbquLCOCV9Rpe7y38xH3YlZnG1rQ1FweN7NSrm7FWaNqci7SN0fHz/qoqy
        BCfXx7OscbaAeCeMqS8DoL5JEtXq45c=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-654--m0OOzMeOMqIjHCnsHzOww-1; Mon, 25 Apr 2022 08:44:09 -0400
X-MC-Unique: -m0OOzMeOMqIjHCnsHzOww-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EC4FF3C01B83;
        Mon, 25 Apr 2022 12:44:08 +0000 (UTC)
Received: from localhost (unknown [10.39.192.116])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9BA7F40FF70E;
        Mon, 25 Apr 2022 12:44:08 +0000 (UTC)
From:   Cornelia Huck <cohuck@redhat.com>
To:     Jason Wang <jasowang@redhat.com>, jasowang@redhat.com,
        mst@redhat.com, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Cc:     sgarzare@redhat.com, eperezma@redhat.com, lulu@redhat.com,
        tglx@linutronix.de, peterz@infradead.org, paulmck@kernel.org,
        maz@kernel.org, pasic@linux.ibm.com
Subject: Re: [PATCH V3 7/9] virtio: allow to unbreak virtqueue
In-Reply-To: <20220425024418.8415-8-jasowang@redhat.com>
Organization: Red Hat GmbH
References: <20220425024418.8415-1-jasowang@redhat.com>
 <20220425024418.8415-8-jasowang@redhat.com>
User-Agent: Notmuch/0.34 (https://notmuchmail.org)
Date:   Mon, 25 Apr 2022 14:44:06 +0200
Message-ID: <87v8ux72p5.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.1
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 25 2022, Jason Wang <jasowang@redhat.com> wrote:

> This patch allows the virtio_break_device() to accept a boolean value
> then we can unbreak the virtqueue.
>
> Signed-off-by: Jason Wang <jasowang@redhat.com>
> ---
>  drivers/char/virtio_console.c              | 2 +-
>  drivers/crypto/virtio/virtio_crypto_core.c | 2 +-
>  drivers/s390/virtio/virtio_ccw.c           | 4 ++--
>  drivers/virtio/virtio_pci_common.c         | 2 +-
>  drivers/virtio/virtio_ring.c               | 4 ++--
>  include/linux/virtio.h                     | 2 +-
>  6 files changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
> index e3c430539a17..afede977f7b3 100644
> --- a/drivers/char/virtio_console.c
> +++ b/drivers/char/virtio_console.c
> @@ -1958,7 +1958,7 @@ static void virtcons_remove(struct virtio_device *vdev)
>  	spin_unlock_irq(&pdrvdata_lock);
>  
>  	/* Device is going away, exit any polling for buffers */
> -	virtio_break_device(vdev);
> +	virtio_break_device(vdev, true);
>  	if (use_multiport(portdev))
>  		flush_work(&portdev->control_work);
>  	else
> diff --git a/drivers/crypto/virtio/virtio_crypto_core.c b/drivers/crypto/virtio/virtio_crypto_core.c
> index c6f482db0bc0..fd17f3f2e958 100644
> --- a/drivers/crypto/virtio/virtio_crypto_core.c
> +++ b/drivers/crypto/virtio/virtio_crypto_core.c
> @@ -215,7 +215,7 @@ static int virtcrypto_update_status(struct virtio_crypto *vcrypto)
>  		dev_warn(&vcrypto->vdev->dev,
>  				"Unknown status bits: 0x%x\n", status);
>  
> -		virtio_break_device(vcrypto->vdev);
> +		virtio_break_device(vcrypto->vdev, true);
>  		return -EPERM;
>  	}
>  
> diff --git a/drivers/s390/virtio/virtio_ccw.c b/drivers/s390/virtio/virtio_ccw.c
> index c19f07a82d62..9a963f5af5b5 100644
> --- a/drivers/s390/virtio/virtio_ccw.c
> +++ b/drivers/s390/virtio/virtio_ccw.c
> @@ -1211,7 +1211,7 @@ static void virtio_ccw_remove(struct ccw_device *cdev)
>  
>  	if (vcdev && cdev->online) {
>  		if (vcdev->device_lost)
> -			virtio_break_device(&vcdev->vdev);
> +			virtio_break_device(&vcdev->vdev, true);
>  		unregister_virtio_device(&vcdev->vdev);
>  		spin_lock_irqsave(get_ccwdev_lock(cdev), flags);
>  		dev_set_drvdata(&cdev->dev, NULL);
> @@ -1228,7 +1228,7 @@ static int virtio_ccw_offline(struct ccw_device *cdev)
>  	if (!vcdev)
>  		return 0;
>  	if (vcdev->device_lost)
> -		virtio_break_device(&vcdev->vdev);
> +		virtio_break_device(&vcdev->vdev, true);
>  	unregister_virtio_device(&vcdev->vdev);
>  	spin_lock_irqsave(get_ccwdev_lock(cdev), flags);
>  	dev_set_drvdata(&cdev->dev, NULL);
> diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_pci_common.c
> index d724f676608b..39a711ddff30 100644
> --- a/drivers/virtio/virtio_pci_common.c
> +++ b/drivers/virtio/virtio_pci_common.c
> @@ -583,7 +583,7 @@ static void virtio_pci_remove(struct pci_dev *pci_dev)
>  	 * layers can abort any ongoing operation.
>  	 */
>  	if (!pci_device_is_present(pci_dev))
> -		virtio_break_device(&vp_dev->vdev);
> +		virtio_break_device(&vp_dev->vdev, true);
>  
>  	pci_disable_sriov(pci_dev);
>  
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index cfb028ca238e..6da13495a70c 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -2382,7 +2382,7 @@ EXPORT_SYMBOL_GPL(virtqueue_is_broken);
>   * This should prevent the device from being used, allowing drivers to
>   * recover.  You may need to grab appropriate locks to flush.
>   */
> -void virtio_break_device(struct virtio_device *dev)
> +void virtio_break_device(struct virtio_device *dev, bool broken)

I think we need to be careful to say when it is safe to unset 'broken'.

The current callers set all queues to broken in case of surprise removal
(ccw, pci), removal (console), or the device behaving badly
(crypto). There's also code setting individual queues to broken. We do
not want to undo any of these, unless the device has gone through a
reset in the meanwhile. Maybe add:

"It is only safe to call this function to *remove* the broken flag for a
device that is (re)transitioning to becoming usable; calling it that way
during normal usage may have unpredictable consequences."

(Not sure how to word this; especially if we consider future usage of
queue reset.)

