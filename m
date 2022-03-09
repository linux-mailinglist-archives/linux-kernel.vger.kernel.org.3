Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0493A4D2DF0
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 12:28:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231936AbiCIL2w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 06:28:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231309AbiCIL2t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 06:28:49 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9718A14996F
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 03:27:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646825269;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=r1dry0lyUeg8BL93lixPa+Zflu8wHHVu2YISeXmZ4Ik=;
        b=UIEfPahw7xJOMy1XR1kUC0YA89f2PigTh5trA63pLyWHhG4hxT/IZDndPJexIRWI0Q/Fug
        3fREAZfdiQ/gctj3YE2NVh0GKGRT61SatU1fZJAq7E5nQAQgBov4RVhFCfQ3s1q4ohpYdH
        WnA1Rx1DFAcP3Nl+7T8VNd1kBrKPqbM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-552-QApWEfY4P0W0OBu_U7vyJQ-1; Wed, 09 Mar 2022 06:27:48 -0500
X-MC-Unique: QApWEfY4P0W0OBu_U7vyJQ-1
Received: by mail-wm1-f69.google.com with SMTP id c19-20020a05600c0ad300b00385bb3db625so2473180wmr.4
        for <linux-kernel@vger.kernel.org>; Wed, 09 Mar 2022 03:27:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=r1dry0lyUeg8BL93lixPa+Zflu8wHHVu2YISeXmZ4Ik=;
        b=lQ0uXdAYq/0Y3fS/y5xlN4GIt/JAMpbPHmgQyXASDOYYrei0SagQ7XqjYmCh//OnBL
         JspdjOPiOgd2x9aVf3P7czNoim5eBwnAHSF/wMQycmFGiRKz55clrfdQF+Qcqc5+dfOr
         LeC7fHIg39iy4kebrsPiLA/mSIVWKJ8tQ+v7v4cYA7EFLVQfuNoiCXdWF9pCkDVplTOR
         ckafOcCpYJHAooGdI5f3EHy/7zAe/Jkh8cWEiXA5+JAHnPx4oOnM/8yezM+BjSmjNKre
         z7j2Bv6bqWQfWIwmFVuah9VziScLPzcxtHKqEca3AiKMQb6kOFPxFHEqdtZqN8s0dYnj
         uS7Q==
X-Gm-Message-State: AOAM5334mPS/UIL9MKn2IdE0SWlmC4n7f4m7WDogpz3jM6gT7S50DtmC
        M4r9x7gS0F7V38zjYR95hDHlmURn03PTk6U7Qfr8fi36TSrndz5sgPtfhp8KRlF8CTOOAdt8L80
        Cs2QAlDFamrZy4yqtWJ1Aj93s
X-Received: by 2002:a5d:5850:0:b0:1f0:2d5b:dc35 with SMTP id i16-20020a5d5850000000b001f02d5bdc35mr15385677wrf.344.1646825267358;
        Wed, 09 Mar 2022 03:27:47 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx5EnTxMjHseQJzsLJ5Wu/dTwFF7Brw8lDvcPJ3itJlIDDt9Pu0F10asMB1wyA3mLuGf/VXjA==
X-Received: by 2002:a5d:5850:0:b0:1f0:2d5b:dc35 with SMTP id i16-20020a5d5850000000b001f02d5bdc35mr15385660wrf.344.1646825267128;
        Wed, 09 Mar 2022 03:27:47 -0800 (PST)
Received: from redhat.com ([2.55.24.184])
        by smtp.gmail.com with ESMTPSA id q11-20020adfcd8b000000b001e320028660sm1387682wrj.92.2022.03.09.03.27.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Mar 2022 03:27:46 -0800 (PST)
Date:   Wed, 9 Mar 2022 06:27:42 -0500
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
Message-ID: <20220309060703-mutt-send-email-mst@kernel.org>
References: <20211019070152.8236-1-jasowang@redhat.com>
 <20211019070152.8236-6-jasowang@redhat.com>
 <87wnh3z9nm.wl-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87wnh3z9nm.wl-maz@kernel.org>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 09, 2022 at 10:45:49AM +0000, Marc Zyngier wrote:
> [Adding Will to check on my understanding of the interactions between
>  spinlocks and WRITE_ONCE()]
> 
> On Tue, 19 Oct 2021 08:01:47 +0100,
> Jason Wang <jasowang@redhat.com> wrote:
> > 
> > This patch tries to make sure the virtio interrupt handler for INTX
> > won't be called after a reset and before virtio_device_ready(). We
> > can't use IRQF_NO_AUTOEN since we're using shared interrupt
> > (IRQF_SHARED). So this patch tracks the INTX enabling status in a new
> > intx_soft_enabled variable and toggle it during in
> > vp_disable/enable_vectors(). The INTX interrupt handler will check
> > intx_soft_enabled before processing the actual interrupt.
> > 
> > Cc: Boqun Feng <boqun.feng@gmail.com>
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: Paul E. McKenney <paulmck@kernel.org>
> > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > ---
> >  drivers/virtio/virtio_pci_common.c | 23 +++++++++++++++++++++--
> >  drivers/virtio/virtio_pci_common.h |  1 +
> >  2 files changed, 22 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_pci_common.c
> > index 8d8f83aca721..1bce254a462a 100644
> > --- a/drivers/virtio/virtio_pci_common.c
> > +++ b/drivers/virtio/virtio_pci_common.c
> > @@ -30,8 +30,16 @@ void vp_disable_cbs(struct virtio_device *vdev)
> >  	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
> >  	int i;
> >  
> > -	if (vp_dev->intx_enabled)
> > +	if (vp_dev->intx_enabled) {
> > +		/*
> > +		 * The below synchronize() guarantees that any
> > +		 * interrupt for this line arriving after
> > +		 * synchronize_irq() has completed is guaranteed to see
> > +		 * intx_soft_enabled == false.
> > +		 */
> > +		WRITE_ONCE(vp_dev->intx_soft_enabled, false);
> >  		synchronize_irq(vp_dev->pci_dev->irq);
> > +	}
> >  
> >  	for (i = 0; i < vp_dev->msix_vectors; ++i)
> >  		disable_irq(pci_irq_vector(vp_dev->pci_dev, i));
> > @@ -43,8 +51,16 @@ void vp_enable_cbs(struct virtio_device *vdev)
> >  	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
> >  	int i;
> >  
> > -	if (vp_dev->intx_enabled)
> > +	if (vp_dev->intx_enabled) {
> > +		disable_irq(vp_dev->pci_dev->irq);
> > +		/*
> > +		 * The above disable_irq() provides TSO ordering and
> > +		 * as such promotes the below store to store-release.
> > +		 */
> > +		WRITE_ONCE(vp_dev->intx_soft_enabled, true);
> 
> What do you mean by TSO here? AFAICT, the CPU is allowed hoist this
> write up into the lock used by disable_irq(), as the unlock only has
> release semantics. Is that what you are relying on? I don't see how
> this upgrades WRITE_ONCE() to have release semantics.
> 
> > +		enable_irq(vp_dev->pci_dev->irq);
> 
> Same thing does here: my understanding is that the write can be pushed
> down into the lock, which has acquire semantics only.
> 
> Thanks,
> 
> 	M.

Overall I feel what we are doing here is very standard and should be
pretty common for a driver that wants to be protected against a
malicious device:


1- get IRQ
2- initialize device with IRQ
3- enable IRQ

Doing it in the core kernel helps make sure interrupts are
not lost if they trigger during 2.

Without core kernel support one has to refactor the driver along the lines of:

a- initialize driver
b- get IRQ
c- initialize device with IRQ

and this is often tricky especially if one wants to do things like
discover device configuration and reconfigure the driver accordingly.


> -- 
> Without deviation from the norm, progress is not possible.

