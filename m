Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25C8B4D2ECF
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 13:13:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232675AbiCIMOb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 07:14:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230109AbiCIMO3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 07:14:29 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C79DD2FFCA
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 04:13:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646828010;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vYQs2E+XcAAe9MfZ30EbAKw9lxEpvFskNr2YmmYsy1E=;
        b=MjXOJeW/tP+u0hEnzuWiBCJAKb5UDA57B4ObwXmm0IMA73ZBhqdLcxjV+1jOhgFCqZ5eqg
        /RE6KdV28C+CzknJH8Xz31Fu664M55aqRqshnIjgI0cpQeYvxQXB6yqZHehfmBHVfur7Dt
        41mP0gZqRlsmEv6M3niXUay0N7XgWSo=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-503-YPxLm1aMP5an9gKuEosq8w-1; Wed, 09 Mar 2022 07:13:28 -0500
X-MC-Unique: YPxLm1aMP5an9gKuEosq8w-1
Received: by mail-wm1-f72.google.com with SMTP id f24-20020a1c6a18000000b00388874b17a8so900428wmc.3
        for <linux-kernel@vger.kernel.org>; Wed, 09 Mar 2022 04:13:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vYQs2E+XcAAe9MfZ30EbAKw9lxEpvFskNr2YmmYsy1E=;
        b=DEl90X5Af6cJkCE+31695TYhHUyOecOaKWEKPlfbpyNSlwGKYm5EY3EuX1wQ+YsUUo
         cngp9PdC73L9F5LRVQDYEh+fAAF8/H0bTGMqp5HFh2tGPXL88ODbELoTGIROV9eRsDa/
         Atkdio3Uw63FyBlFcx241+H1SZjLtvScQZqNRE/Je28IGVipMPcEO/ir7jKIzGhKyByO
         KZFgWrdxBhvROr017k6JA3xx5qPtV/WnpRo/XX5KXxCYRCFe2El1xYai+uiRXvHylrAI
         GD0njAtUSUMIJyIC8FxNRp7EEQ8ZR7BKCqyzc357pJgvWsWYnBQo45uoTgscXj2XZHko
         YljQ==
X-Gm-Message-State: AOAM5313JQOlXZmcXgw5StCwybvxsInhfExb+dXS7JLXAggzhF83Uqqh
        3CRF2zWJnMN4qXcwW2jHwnysQ68xwZovkWz9rd1lx9cBmipfkynEVOi5oayGCMTBzZItzg6i28j
        9qdYTxPAOI6MQQps8Hfd/Z/iX
X-Received: by 2002:a5d:6790:0:b0:1f1:dabd:9134 with SMTP id v16-20020a5d6790000000b001f1dabd9134mr15627388wru.447.1646828007663;
        Wed, 09 Mar 2022 04:13:27 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwzdQHXpowEqr6kV6Jv3GkrqllFI6rdvJV7jvHEQewGubXCqEpVxjNhomCEvuh03DqQSTkaaA==
X-Received: by 2002:a5d:6790:0:b0:1f1:dabd:9134 with SMTP id v16-20020a5d6790000000b001f1dabd9134mr15627357wru.447.1646828007390;
        Wed, 09 Mar 2022 04:13:27 -0800 (PST)
Received: from redhat.com ([2.55.24.184])
        by smtp.gmail.com with ESMTPSA id a14-20020a05600c348e00b00389ab74c033sm1498201wmq.4.2022.03.09.04.13.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Mar 2022 04:13:26 -0800 (PST)
Date:   Wed, 9 Mar 2022 07:13:21 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Marc Zyngier <maz@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, f.hetzelt@tu-berlin.de,
        david.kaplan@amd.com, konrad.wilk@oracle.com,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E . McKenney" <paulmck@kernel.org>, keirf@google.com
Subject: Re: [PATCH V3 04/10] virtio_pci: harden MSI-X interrupts
Message-ID: <20220309062833-mutt-send-email-mst@kernel.org>
References: <20211019070152.8236-1-jasowang@redhat.com>
 <20211019070152.8236-5-jasowang@redhat.com>
 <87y21kzd3f.wl-maz@kernel.org>
 <20220308113119-mutt-send-email-mst@kernel.org>
 <87v8wnz8li.wl-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87v8wnz8li.wl-maz@kernel.org>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 09, 2022 at 11:08:41AM +0000, Marc Zyngier wrote:
> On Tue, 08 Mar 2022 16:35:52 +0000,
> "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > 
> > On Tue, Mar 08, 2022 at 03:19:16PM +0000, Marc Zyngier wrote:
> > > On Tue, 19 Oct 2021 08:01:46 +0100,
> > > Jason Wang <jasowang@redhat.com> wrote:
> > > > 
> > > > We used to synchronize pending MSI-X irq handlers via
> > > > synchronize_irq(), this may not work for the untrusted device which
> > > > may keep sending interrupts after reset which may lead unexpected
> > > > results. Similarly, we should not enable MSI-X interrupt until the
> > > > device is ready. So this patch fixes those two issues by:
> > > > 
> > > > 1) switching to use disable_irq() to prevent the virtio interrupt
> > > >    handlers to be called after the device is reset.
> > > > 2) using IRQF_NO_AUTOEN and enable the MSI-X irq during .ready()
> > > > 
> > > > This can make sure the virtio interrupt handler won't be called before
> > > > virtio_device_ready() and after reset.
> > > > 
> > > > Cc: Thomas Gleixner <tglx@linutronix.de>
> > > > Cc: Peter Zijlstra <peterz@infradead.org>
> > > > Cc: Paul E. McKenney <paulmck@kernel.org>
> > > > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > > > ---
> > > >  drivers/virtio/virtio_pci_common.c | 27 +++++++++++++++++++++------
> > > >  drivers/virtio/virtio_pci_common.h |  6 ++++--
> > > >  drivers/virtio/virtio_pci_legacy.c |  5 +++--
> > > >  drivers/virtio/virtio_pci_modern.c |  6 ++++--
> > > >  4 files changed, 32 insertions(+), 12 deletions(-)
> > > > 
> > > > diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_pci_common.c
> > > > index b35bb2d57f62..8d8f83aca721 100644
> > > > --- a/drivers/virtio/virtio_pci_common.c
> > > > +++ b/drivers/virtio/virtio_pci_common.c
> > > > @@ -24,8 +24,8 @@ MODULE_PARM_DESC(force_legacy,
> > > >  		 "Force legacy mode for transitional virtio 1 devices");
> > > >  #endif
> > > >  
> > > > -/* wait for pending irq handlers */
> > > > -void vp_synchronize_vectors(struct virtio_device *vdev)
> > > > +/* disable irq handlers */
> > > > +void vp_disable_cbs(struct virtio_device *vdev)
> > > >  {
> > > >  	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
> > > >  	int i;
> > > > @@ -34,7 +34,20 @@ void vp_synchronize_vectors(struct virtio_device *vdev)
> > > >  		synchronize_irq(vp_dev->pci_dev->irq);
> > > >  
> > > >  	for (i = 0; i < vp_dev->msix_vectors; ++i)
> > > > -		synchronize_irq(pci_irq_vector(vp_dev->pci_dev, i));
> > > > +		disable_irq(pci_irq_vector(vp_dev->pci_dev, i));
> > > > +}
> > > > +
> > > > +/* enable irq handlers */
> > > > +void vp_enable_cbs(struct virtio_device *vdev)
> > > > +{
> > > > +	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
> > > > +	int i;
> > > > +
> > > > +	if (vp_dev->intx_enabled)
> > > > +		return;
> > > > +
> > > > +	for (i = 0; i < vp_dev->msix_vectors; ++i)
> > > > +		enable_irq(pci_irq_vector(vp_dev->pci_dev, i));
> > > 
> > > This results in a splat at boot time if you set maxcpus=<whatever>,
> > > see below. Enabling interrupts that are affinity managed is *bad*. You
> > > don't even know whether the CPU which is supposed to handle this is
> > > online or not.
> > > 
> > > The core kernel notices it, shouts and keeps the interrupt disabled,
> > > but this should be fixed. The whole point of managed interrupts is to
> > > let them be dealt with outside of the drivers, and tied into the CPUs
> > > being brought up and down. If virtio needs (for one reason or another)
> > > to manage interrupts on its own, so be it. But this patch isn't the
> > > way to do it, I'm afraid.
> > > 
> > > 	M.
> > 
> > Thanks for reporting this!
> > 
> > What virtio is doing here isn't unique however.
> 
> Then it is even worse than I though. Can you point me to the other
> drivers doing such thing?


What are you asking? Whether any drivers that set PCI_IRQ_AFFINITY also
set IRQF_NO_AUTOEN? I could not find any other drivers doing that, no.
When I said "isn't unique" I rather meant that other drivers need
something like this, and they likely do it in a driver specific, complex
fashion.

just poking around at random I found
drivers/scsi/mpi3mr/mpi3mr_fw.c

which does this last thing during initialization:

void mpi3mr_ioc_enable_intr(struct mpi3mr_ioc *mrioc)
{
        mrioc->intr_enabled = 1;
}

and the interrupt handler does:

static irqreturn_t mpi3mr_isr_primary(int irq, void *privdata)
{
        struct mpi3mr_intr_info *intr_info = privdata;
        struct mpi3mr_ioc *mrioc;
        u16 midx;
        u32 num_admin_replies = 0, num_op_reply = 0;

        if (!intr_info)
                return IRQ_NONE;

        mrioc = intr_info->mrioc;

        if (!mrioc->intr_enabled)
                return IRQ_NONE;


which seems to be trying to accomplish exactly the same thing and might
or might not actually need WRITE_ONCE or some barriers if it were to be
made 100% foolproof.



> > If device driver is to be hardened against device sending interrupts
> > while driver is initializing/cleaning up, it needs kernel to provide
> > capability to disable these.
> >
> > If we then declare that that is impossible for managed interrupts
> > then that will mean most devices can't use managed interrupts
> > because ideally we'd have all drivers hardened.
> 
> What I find odd is that you want to do the interrupt hardening in the
> individual endpoint drivers. This makes everything complicated, and
> just doesn't scale.
> The natural place for this sort of checks would be in the interrupt
> controller driver, which has all the state as its disposal, and is
> guaranteed to be able to take the right course of action if it sees
> something that contradicts its internal state tracking (affinity,
> masking, interrupt life cycle in general).

Exactly.  So here's what we are trying to do: driver is initializing
both itself and the device. As part of that, it assigns some IRQs. Once that
happens, device can trigger the IRQ callback by sending the interrupt.
If this happens too soon driver is not yet fully initialized and might
access uninitialized memory (and generally get confused because the
state is inconsistent).

Getting the IRQ in a disabled state and only enabling when we are
ready sounds like a very reasonable way to go about it just from
API perspective.





> 
> Because even if you were allowed to mess with the enable state, this
> doesn't give you any guarantee that the interrupt is delivered on the
> correct CPU either.

For virtio affinity is mostly an optimization, I don't think this
affects correctness.

> > Thomas I think you were the one who suggested enabling/disabling
> > interrupts originally - thoughts?
> > 
> > Feedback appreciated.
> 
> Feedback given.
> 
> Thanks,
> 
> 	M.
> 
> -- 
> Without deviation from the norm, progress is not possible.

