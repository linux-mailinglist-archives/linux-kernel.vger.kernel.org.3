Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB3234D2F0D
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 13:30:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232738AbiCIMbo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 07:31:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230296AbiCIMbm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 07:31:42 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0C9C213D576
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 04:30:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646829043;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rWD9XGlU43T/hPebWYiaS1wUvBoZOFcW/XaMqLKoWQI=;
        b=CUFODuCcdiA7avhUpyr7sPIhEKsIAUdSPtvjoayeEZ3AhnW9hS/agH/Jx988hxz+IhQFYG
        c30zBNKxjmzTyHlcreopbbznuYirgXr/9Jbg80HzAr+YxvYHntgjhRoF4QkDpOihNWGLPU
        H8lJ0z1PeXDJcfTSTFWR/ZznKclsrVk=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-288-2H59eRViMmepIHDEZYdRLg-1; Wed, 09 Mar 2022 07:30:42 -0500
X-MC-Unique: 2H59eRViMmepIHDEZYdRLg-1
Received: by mail-wm1-f72.google.com with SMTP id h206-20020a1c21d7000000b003552c13626cso2537082wmh.3
        for <linux-kernel@vger.kernel.org>; Wed, 09 Mar 2022 04:30:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rWD9XGlU43T/hPebWYiaS1wUvBoZOFcW/XaMqLKoWQI=;
        b=20Ws7Jfc/UBRInTOxOnQjzI30ljpakzNEGoxBic0qIkRqIWm2Z2ZHBuFuWOo1YEuux
         rGVICbGWTvLIKj9gKRZRwOzySqfgnPZdgu2hl603g50op3j4Dkwi94zVW9k2fe5lMzmk
         rckHoQPB1AZj+J99Ogj4PmiZ0QngpMCN3D6ybAdKLRnjT6Y6tZ2HeExUkGW9+ScSVErS
         H8Iu6dTddi1fmaVQJ7MwVk8qqT7RdJ52b6fBo12jsj42mxKcvqvtXko61hPk2XHV1Ppi
         lIQZgte8dQZ/rr0BIwI9WUqAR7qXTjssAs3e3qme8pmOee7gPmIz6wdLiOQcgLtwZm8e
         DzIg==
X-Gm-Message-State: AOAM531Ag7jPZCJVTELzdtfYf2yxJ/RWTBt/9y6GvPr4jsF8DyTxxSzw
        qD8I2tn/76le9jO8aFq1fP+DgaGsrb+ciM2oicTLLAdVL9+TU80oINqzQi88PgA1PNdpRTztJsy
        0M7C3iksKLC6WP0lLNc720ENb
X-Received: by 2002:a05:600c:2c49:b0:384:7202:358e with SMTP id r9-20020a05600c2c4900b003847202358emr7429089wmg.108.1646829040672;
        Wed, 09 Mar 2022 04:30:40 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwyqRzrqdmt6mSw8F1TISW3RDhJuVWNHY3lY/ou1l4KKPFruQUAGgW3P4b4WhUkqDohG+UKOA==
X-Received: by 2002:a05:600c:2c49:b0:384:7202:358e with SMTP id r9-20020a05600c2c4900b003847202358emr7429060wmg.108.1646829040356;
        Wed, 09 Mar 2022 04:30:40 -0800 (PST)
Received: from redhat.com ([2.55.24.184])
        by smtp.gmail.com with ESMTPSA id m18-20020a05600c3b1200b003899d242c3asm5123290wms.44.2022.03.09.04.30.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Mar 2022 04:30:39 -0800 (PST)
Date:   Wed, 9 Mar 2022 07:30:34 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Marc Zyngier <maz@kernel.org>
Cc:     Jason Wang <jasowang@redhat.com>, Will Deacon <will@kernel.org>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, f.hetzelt@tu-berlin.de,
        david.kaplan@amd.com, konrad.wilk@oracle.com,
        Boqun Feng <boqun.feng@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E . McKenney" <paulmck@kernel.org>, keirf@google.com
Subject: Re: [PATCH V3 05/10] virtio-pci: harden INTX interrupts
Message-ID: <20220309071710-mutt-send-email-mst@kernel.org>
References: <20211019070152.8236-1-jasowang@redhat.com>
 <20211019070152.8236-6-jasowang@redhat.com>
 <87wnh3z9nm.wl-maz@kernel.org>
 <20220309060703-mutt-send-email-mst@kernel.org>
 <87tuc7z5k9.wl-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87tuc7z5k9.wl-maz@kernel.org>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 09, 2022 at 12:14:14PM +0000, Marc Zyngier wrote:
> On Wed, 09 Mar 2022 11:27:42 +0000,
> "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > 
> > On Wed, Mar 09, 2022 at 10:45:49AM +0000, Marc Zyngier wrote:
> > > [Adding Will to check on my understanding of the interactions between
> > >  spinlocks and WRITE_ONCE()]
> > > 
> > > On Tue, 19 Oct 2021 08:01:47 +0100,
> > > Jason Wang <jasowang@redhat.com> wrote:
> > > > 
> > > > This patch tries to make sure the virtio interrupt handler for INTX
> > > > won't be called after a reset and before virtio_device_ready(). We
> > > > can't use IRQF_NO_AUTOEN since we're using shared interrupt
> > > > (IRQF_SHARED). So this patch tracks the INTX enabling status in a new
> > > > intx_soft_enabled variable and toggle it during in
> > > > vp_disable/enable_vectors(). The INTX interrupt handler will check
> > > > intx_soft_enabled before processing the actual interrupt.
> > > > 
> > > > Cc: Boqun Feng <boqun.feng@gmail.com>
> > > > Cc: Thomas Gleixner <tglx@linutronix.de>
> > > > Cc: Peter Zijlstra <peterz@infradead.org>
> > > > Cc: Paul E. McKenney <paulmck@kernel.org>
> > > > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > > > ---
> > > >  drivers/virtio/virtio_pci_common.c | 23 +++++++++++++++++++++--
> > > >  drivers/virtio/virtio_pci_common.h |  1 +
> > > >  2 files changed, 22 insertions(+), 2 deletions(-)
> > > > 
> > > > diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_pci_common.c
> > > > index 8d8f83aca721..1bce254a462a 100644
> > > > --- a/drivers/virtio/virtio_pci_common.c
> > > > +++ b/drivers/virtio/virtio_pci_common.c
> > > > @@ -30,8 +30,16 @@ void vp_disable_cbs(struct virtio_device *vdev)
> > > >  	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
> > > >  	int i;
> > > >  
> > > > -	if (vp_dev->intx_enabled)
> > > > +	if (vp_dev->intx_enabled) {
> > > > +		/*
> > > > +		 * The below synchronize() guarantees that any
> > > > +		 * interrupt for this line arriving after
> > > > +		 * synchronize_irq() has completed is guaranteed to see
> > > > +		 * intx_soft_enabled == false.
> > > > +		 */
> > > > +		WRITE_ONCE(vp_dev->intx_soft_enabled, false);
> > > >  		synchronize_irq(vp_dev->pci_dev->irq);
> > > > +	}
> > > >  
> > > >  	for (i = 0; i < vp_dev->msix_vectors; ++i)
> > > >  		disable_irq(pci_irq_vector(vp_dev->pci_dev, i));
> > > > @@ -43,8 +51,16 @@ void vp_enable_cbs(struct virtio_device *vdev)
> > > >  	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
> > > >  	int i;
> > > >  
> > > > -	if (vp_dev->intx_enabled)
> > > > +	if (vp_dev->intx_enabled) {
> > > > +		disable_irq(vp_dev->pci_dev->irq);
> > > > +		/*
> > > > +		 * The above disable_irq() provides TSO ordering and
> > > > +		 * as such promotes the below store to store-release.
> > > > +		 */
> > > > +		WRITE_ONCE(vp_dev->intx_soft_enabled, true);
> > > 
> > > What do you mean by TSO here? AFAICT, the CPU is allowed hoist this
> > > write up into the lock used by disable_irq(), as the unlock only has
> > > release semantics. Is that what you are relying on? I don't see how
> > > this upgrades WRITE_ONCE() to have release semantics.
> > > 
> > > > +		enable_irq(vp_dev->pci_dev->irq);
> > > 
> > > Same thing does here: my understanding is that the write can be pushed
> > > down into the lock, which has acquire semantics only.
> > > 
> > > Thanks,
> > > 
> > > 	M.
> > 
> > Overall I feel what we are doing here is very standard and should be
> > pretty common for a driver that wants to be protected against a
> > malicious device:
> > 
> > 
> > 1- get IRQ
> > 2- initialize device with IRQ
> > 3- enable IRQ
> > 
> > Doing it in the core kernel helps make sure interrupts are
> > not lost if they trigger during 2.
> 
> But this isn't the core kernel. You're doing that in some random
> driver (and even more, only for the PCI version of that driver).


Oh, I'm answering on the INTX patch. I was referring to the MSIX
path actually. Yes INTX can not currently start in disabled state
because it's shared.


> > 
> > Without core kernel support one has to refactor the driver along the lines of:
> > 
> > a- initialize driver
> > b- get IRQ
> > c- initialize device with IRQ
> > 
> > and this is often tricky especially if one wants to do things like
> > discover device configuration and reconfigure the driver accordingly.
> 
> But this isn't what this patch is about, is it? You are just tracking
> whether interrupts are enabled or not. To which my reply to you on the
> previous patch still applies (this is the wrong place to track such
> state).

It's not that we care. What we need is to make sure that interrupts sent
before driver is ready to accept them do not cause a callback.
If there was a way to tell kernel "I'm ready to accept callbacks now"
problem would be solved.



> You also haven't answered my question: what are your ordering
> expectations wrt the WRITE_ONCE() above? The comment says 'TSO', and I
> don't really understand how this is enforced.
> 
> Thanks,
> 
> 	M.

It's based on Peter's suggestion:
https://lore.kernel.org/r/YUCBZjjk77q8JS4f%40hirez.programming.kicks-ass.net


> -- 
> Without deviation from the norm, progress is not possible.

