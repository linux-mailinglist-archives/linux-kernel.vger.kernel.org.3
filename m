Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8341C4F6744
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 19:39:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238912AbiDFR31 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 13:29:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239051AbiDFR2o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 13:28:44 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3AFB42487BB
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 08:31:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649259086;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SXqsmr5lOmq1DC0O01EgBHNJ75YfihYQ9afQo8lccGQ=;
        b=TZq4ajl5Qj9CFq1SOFgMmgLLV2hlFvybOXtVkgh+q4r0y+xruxvNgNy+5zQhyzexPyT8iu
        3WFlZnjdw6zHGhYBKVsVpMVFVYbSTlaLOCHhknhca6iiDD9P7PjKkfyAt56D86KZujEXnV
        1I/megxU+RCHn3q4MOt4pTqV+qz40NI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-379-xBqnpCVCO7uZ7-6CbIkFvA-1; Wed, 06 Apr 2022 11:31:25 -0400
X-MC-Unique: xBqnpCVCO7uZ7-6CbIkFvA-1
Received: by mail-wm1-f72.google.com with SMTP id j6-20020a05600c1c0600b0038e7d07ebcaso766314wms.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Apr 2022 08:31:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=SXqsmr5lOmq1DC0O01EgBHNJ75YfihYQ9afQo8lccGQ=;
        b=pJ6SuWNH0FYm1GNE1MUeNUVhrU/Mb1u3zWGsyMjFGaw4/Z3BswgfW0IX1o4nOzjTY8
         g9iFvVjyfVh4tXViaH6qZG2p1fjjGmfKcezIlt+Yp3tLd6XlOsOH5gzZqKiqBEBAMODG
         yzjBnowjPp3e31zrp9errGm3AgCaWi+JKqrm++H6NULYr1Z5oROlhRiwdG71wCHvRoTg
         l25xqG8mG3pUCU//IgIY3lu4a9n+OlCykIPypOqZ6Q/2GWbKOF6jjwjfjgI0yVKi2r7V
         c79FtptrnDKChQemfj9bvqF185tOZ/gQA+rxEr8JliOuabNAIxSo8ymR0H//ECij3slR
         pQiA==
X-Gm-Message-State: AOAM531XIEhf5Wn3bkR0sEGvhhtjaOTWuk98JZlI7VeWtNgbJl2ui5DI
        pbyqzF99uz2xVC6ufNtDAMe1hmeR1IXs4QC5ClgJGKO+9VN1WEJOfefPpf3HOc3ULunKk4GkdpW
        9BQVkm5f1obAJ6rLKt8gT2OLb
X-Received: by 2002:a05:600c:3511:b0:38c:d035:cddb with SMTP id h17-20020a05600c351100b0038cd035cddbmr8039413wmq.74.1649259084176;
        Wed, 06 Apr 2022 08:31:24 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzMJUIuOfCAWCV1KjhYntMj29VSsQUoSZ2t6duktlX1OxSHrnPzc0hHgltLl0oDc5ne7fB2BQ==
X-Received: by 2002:a05:600c:3511:b0:38c:d035:cddb with SMTP id h17-20020a05600c351100b0038cd035cddbmr8039392wmq.74.1649259083924;
        Wed, 06 Apr 2022 08:31:23 -0700 (PDT)
Received: from redhat.com ([2.55.156.253])
        by smtp.gmail.com with ESMTPSA id 14-20020a056000154e00b00203f8adde0csm18525600wry.32.2022.04.06.08.31.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Apr 2022 08:31:22 -0700 (PDT)
Date:   Wed, 6 Apr 2022 11:31:19 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Cornelia Huck <cohuck@redhat.com>
Cc:     Jason Wang <jasowang@redhat.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, peterz@infradead.org,
        maz@kernel.org, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, tglx@linutronix.de,
        Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [PATCH V2 4/5] virtio-pci: implement synchronize_vqs()
Message-ID: <20220406112858-mutt-send-email-mst@kernel.org>
References: <20220406083538.16274-1-jasowang@redhat.com>
 <20220406083538.16274-5-jasowang@redhat.com>
 <20220406075952-mutt-send-email-mst@kernel.org>
 <87wng2e527.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87wng2e527.fsf@redhat.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 06, 2022 at 03:04:32PM +0200, Cornelia Huck wrote:
> On Wed, Apr 06 2022, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> 
> > On Wed, Apr 06, 2022 at 04:35:37PM +0800, Jason Wang wrote:
> >> This patch implements PCI version of synchronize_vqs().
> >> 
> >> Cc: Thomas Gleixner <tglx@linutronix.de>
> >> Cc: Peter Zijlstra <peterz@infradead.org>
> >> Cc: "Paul E. McKenney" <paulmck@kernel.org>
> >> Cc: Marc Zyngier <maz@kernel.org>
> >> Signed-off-by: Jason Wang <jasowang@redhat.com>
> >
> > Please add implementations at least for ccw and mmio.
> 
> I'm not sure what (if anything) can/should be done for ccw...
> 
> >
> >> ---
> >>  drivers/virtio/virtio_pci_common.c | 14 ++++++++++++++
> >>  drivers/virtio/virtio_pci_common.h |  2 ++
> >>  drivers/virtio/virtio_pci_legacy.c |  1 +
> >>  drivers/virtio/virtio_pci_modern.c |  2 ++
> >>  4 files changed, 19 insertions(+)
> >> 
> >> diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_pci_common.c
> >> index d724f676608b..b78c8bc93a97 100644
> >> --- a/drivers/virtio/virtio_pci_common.c
> >> +++ b/drivers/virtio/virtio_pci_common.c
> >> @@ -37,6 +37,20 @@ void vp_synchronize_vectors(struct virtio_device *vdev)
> >>  		synchronize_irq(pci_irq_vector(vp_dev->pci_dev, i));
> >>  }
> >>  
> >> +void vp_synchronize_vqs(struct virtio_device *vdev)
> >> +{
> >> +	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
> >> +	int i;
> >> +
> >> +	if (vp_dev->intx_enabled) {
> >> +		synchronize_irq(vp_dev->pci_dev->irq);
> >> +		return;
> >> +	}
> >> +
> >> +	for (i = 0; i < vp_dev->msix_vectors; ++i)
> >> +		synchronize_irq(pci_irq_vector(vp_dev->pci_dev, i));
> >> +}
> >> +
> 
> ...given that this seems to synchronize threaded interrupt handlers?

No, any handlers at all. The point is to make sure any memory changes
made prior to this op are visible to callbacks.

Jason, maybe add that to the documentation?

> Halil, do you think ccw needs to do anything? (AFAICS, we only have one
> 'irq' for channel devices anyway, and the handler just calls the
> relevant callbacks directly.)

Then you need to synchronize with that.

> >>  /* the notify function used when creating a virt queue */
> >>  bool vp_notify(struct virtqueue *vq)
> >>  {

