Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 371DC50E2A4
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 16:05:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242336AbiDYOIT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 10:08:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242350AbiDYOIO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 10:08:14 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8093DF7D
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 07:05:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650895507;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=auigtvJ39UZ3RGxjn70hyOBkPz9Npiberg9KFWHx8Ck=;
        b=g6/64WZt/O10n/4UpOG6WhVZs1VYWaGEptbbhSM8ruko2CbuV70ZgeiuFMOYvnNLy6nAaO
        qZyRo36YJ3JXcUH38r8udVpufk+08Qth/35/8C0tFTmT/7X8jSjPcEd3oddfOJW/+K38Ze
        8hi0UKR8kBdVnLD/vYbDcA4J+wXD5XY=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-576-qYR9QcJuNJajTNEY-t6vMA-1; Mon, 25 Apr 2022 10:05:01 -0400
X-MC-Unique: qYR9QcJuNJajTNEY-t6vMA-1
Received: by mail-wr1-f70.google.com with SMTP id s8-20020adf9788000000b0020adb01dc25so864738wrb.20
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 07:05:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=auigtvJ39UZ3RGxjn70hyOBkPz9Npiberg9KFWHx8Ck=;
        b=vY6IHWOW3zAIMCR99qDtRFdOFCB2skUyndFpu5WiIYJrQsh7BSuO/zF7yjNgn9mdK4
         ZMq9TIveHsPtjC7Ak0igeO5lbAvXueREPJjuxP2+23ybXgnyf0oIDgfzF9gTemOHTSk9
         OBeRc1sypJHFVzPAy1USn6jMx2VwiN8ViN4LNEMGrw3gXE1g3/VARZ6wnKNhK1FR1Q7p
         xYGvhzG62bKQQ2OurgWydYSQVMOJRge/XUnDewMIhlRbDMCBJ2+OHxcs9jI27vDtcR7X
         1w3xi01X2h/1Wvzq1bcowc2rd1Fvc7yxYcW21vj7RS46nXJivEFU1TtDkE52dX4xNP1v
         RzIw==
X-Gm-Message-State: AOAM532IoIxWPSFQT+0cOV3/7O3LPM4bn6p82n1oZZR8Bw77w6llg0OC
        fE01unXLaPdok+ftOryy01hJuk+1cTCslVTfmeG+/IGgvYP1SJC0DsZj1KUSY2DdYGm+UMI/Ky+
        xR8dry8C9DY6jKCTatMpfAwXs
X-Received: by 2002:adf:d0d2:0:b0:20a:d81e:cb23 with SMTP id z18-20020adfd0d2000000b0020ad81ecb23mr6437480wrh.656.1650895500266;
        Mon, 25 Apr 2022 07:05:00 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxCz6CuikbFY26Mxyu8mBeQpSoKK4hfaQ9gqfvZaQNnpB1KRqoz4PAURcjtNTMbj2rWbOH+jw==
X-Received: by 2002:adf:d0d2:0:b0:20a:d81e:cb23 with SMTP id z18-20020adfd0d2000000b0020ad81ecb23mr6437447wrh.656.1650895500002;
        Mon, 25 Apr 2022 07:05:00 -0700 (PDT)
Received: from redhat.com ([2.53.22.137])
        by smtp.gmail.com with ESMTPSA id k63-20020a1ca142000000b0038ff2c38e85sm8886223wme.39.2022.04.25.07.04.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Apr 2022 07:04:59 -0700 (PDT)
Date:   Mon, 25 Apr 2022 10:04:55 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Cornelia Huck <cohuck@redhat.com>
Cc:     Jason Wang <jasowang@redhat.com>, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, sgarzare@redhat.com,
        eperezma@redhat.com, lulu@redhat.com, tglx@linutronix.de,
        peterz@infradead.org, paulmck@kernel.org, maz@kernel.org,
        pasic@linux.ibm.com
Subject: Re: [PATCH V3 7/9] virtio: allow to unbreak virtqueue
Message-ID: <20220425100349-mutt-send-email-mst@kernel.org>
References: <20220425024418.8415-1-jasowang@redhat.com>
 <20220425024418.8415-8-jasowang@redhat.com>
 <87v8ux72p5.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87v8ux72p5.fsf@redhat.com>
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 25, 2022 at 02:44:06PM +0200, Cornelia Huck wrote:
> On Mon, Apr 25 2022, Jason Wang <jasowang@redhat.com> wrote:
> 
> > This patch allows the virtio_break_device() to accept a boolean value
> > then we can unbreak the virtqueue.
> >
> > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > ---
> >  drivers/char/virtio_console.c              | 2 +-
> >  drivers/crypto/virtio/virtio_crypto_core.c | 2 +-
> >  drivers/s390/virtio/virtio_ccw.c           | 4 ++--
> >  drivers/virtio/virtio_pci_common.c         | 2 +-
> >  drivers/virtio/virtio_ring.c               | 4 ++--
> >  include/linux/virtio.h                     | 2 +-
> >  6 files changed, 8 insertions(+), 8 deletions(-)
> >
> > diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
> > index e3c430539a17..afede977f7b3 100644
> > --- a/drivers/char/virtio_console.c
> > +++ b/drivers/char/virtio_console.c
> > @@ -1958,7 +1958,7 @@ static void virtcons_remove(struct virtio_device *vdev)
> >  	spin_unlock_irq(&pdrvdata_lock);
> >  
> >  	/* Device is going away, exit any polling for buffers */
> > -	virtio_break_device(vdev);
> > +	virtio_break_device(vdev, true);
> >  	if (use_multiport(portdev))
> >  		flush_work(&portdev->control_work);
> >  	else
> > diff --git a/drivers/crypto/virtio/virtio_crypto_core.c b/drivers/crypto/virtio/virtio_crypto_core.c
> > index c6f482db0bc0..fd17f3f2e958 100644
> > --- a/drivers/crypto/virtio/virtio_crypto_core.c
> > +++ b/drivers/crypto/virtio/virtio_crypto_core.c
> > @@ -215,7 +215,7 @@ static int virtcrypto_update_status(struct virtio_crypto *vcrypto)
> >  		dev_warn(&vcrypto->vdev->dev,
> >  				"Unknown status bits: 0x%x\n", status);
> >  
> > -		virtio_break_device(vcrypto->vdev);
> > +		virtio_break_device(vcrypto->vdev, true);
> >  		return -EPERM;
> >  	}
> >  
> > diff --git a/drivers/s390/virtio/virtio_ccw.c b/drivers/s390/virtio/virtio_ccw.c
> > index c19f07a82d62..9a963f5af5b5 100644
> > --- a/drivers/s390/virtio/virtio_ccw.c
> > +++ b/drivers/s390/virtio/virtio_ccw.c
> > @@ -1211,7 +1211,7 @@ static void virtio_ccw_remove(struct ccw_device *cdev)
> >  
> >  	if (vcdev && cdev->online) {
> >  		if (vcdev->device_lost)
> > -			virtio_break_device(&vcdev->vdev);
> > +			virtio_break_device(&vcdev->vdev, true);
> >  		unregister_virtio_device(&vcdev->vdev);
> >  		spin_lock_irqsave(get_ccwdev_lock(cdev), flags);
> >  		dev_set_drvdata(&cdev->dev, NULL);
> > @@ -1228,7 +1228,7 @@ static int virtio_ccw_offline(struct ccw_device *cdev)
> >  	if (!vcdev)
> >  		return 0;
> >  	if (vcdev->device_lost)
> > -		virtio_break_device(&vcdev->vdev);
> > +		virtio_break_device(&vcdev->vdev, true);
> >  	unregister_virtio_device(&vcdev->vdev);
> >  	spin_lock_irqsave(get_ccwdev_lock(cdev), flags);
> >  	dev_set_drvdata(&cdev->dev, NULL);
> > diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_pci_common.c
> > index d724f676608b..39a711ddff30 100644
> > --- a/drivers/virtio/virtio_pci_common.c
> > +++ b/drivers/virtio/virtio_pci_common.c
> > @@ -583,7 +583,7 @@ static void virtio_pci_remove(struct pci_dev *pci_dev)
> >  	 * layers can abort any ongoing operation.
> >  	 */
> >  	if (!pci_device_is_present(pci_dev))
> > -		virtio_break_device(&vp_dev->vdev);
> > +		virtio_break_device(&vp_dev->vdev, true);
> >  
> >  	pci_disable_sriov(pci_dev);
> >  
> > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> > index cfb028ca238e..6da13495a70c 100644
> > --- a/drivers/virtio/virtio_ring.c
> > +++ b/drivers/virtio/virtio_ring.c
> > @@ -2382,7 +2382,7 @@ EXPORT_SYMBOL_GPL(virtqueue_is_broken);
> >   * This should prevent the device from being used, allowing drivers to
> >   * recover.  You may need to grab appropriate locks to flush.
> >   */
> > -void virtio_break_device(struct virtio_device *dev)
> > +void virtio_break_device(struct virtio_device *dev, bool broken)
> 
> I think we need to be careful to say when it is safe to unset 'broken'.
> 
> The current callers set all queues to broken in case of surprise removal
> (ccw, pci), removal (console), or the device behaving badly
> (crypto). There's also code setting individual queues to broken. We do
> not want to undo any of these, unless the device has gone through a
> reset in the meanwhile. Maybe add:
> 
> "It is only safe to call this function to *remove* the broken flag for a
> device that is (re)transitioning to becoming usable; calling it that way
> during normal usage may have unpredictable consequences."
> 
> (Not sure how to word this; especially if we consider future usage of
> queue reset.)


Right. I would prefer __virtio_unbreak_device or something similar
with a bit comment explaining it's only safe to call during probe.

-- 
MST

