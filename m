Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 619474FAC9B
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Apr 2022 09:51:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234499AbiDJHx0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Apr 2022 03:53:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231350AbiDJHxY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Apr 2022 03:53:24 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C83B06D1AD
        for <linux-kernel@vger.kernel.org>; Sun, 10 Apr 2022 00:51:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649577072;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CEGpPcEbQpA7grhoTpCsc4+FcBngn29MUORJJ4U+NYw=;
        b=eNbxZE16HfP1GC3hyvsw7U7FS+fd8CC79H72BFzFd2Xnp8QQKGgiksJe1KTxiY5oT7a5Zo
        eNJOwvLLuU3E+5YMbhx5grtEDTP3CZ43rLsLWSiCLsxT1Wwu20t4jgB+u9UutYxLg1l6Qp
        5yZSnBb9LvfFfpbn7JaP2GoK9ED7+ZA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-500-QXdTzccSOSCvTbwGi1Co7g-1; Sun, 10 Apr 2022 03:51:11 -0400
X-MC-Unique: QXdTzccSOSCvTbwGi1Co7g-1
Received: by mail-wm1-f69.google.com with SMTP id q6-20020a1cf306000000b0038c5726365aso6906656wmq.3
        for <linux-kernel@vger.kernel.org>; Sun, 10 Apr 2022 00:51:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CEGpPcEbQpA7grhoTpCsc4+FcBngn29MUORJJ4U+NYw=;
        b=Yut2LCSeMfBDY6fEh4CanSCU+cEzSA55eTuwSEp1SIouXAMZkfybwmjw7ES9XNEff5
         WH+vgFqjqjrZCPBOVfN4umiNYzAi5ygez7TfLXSyVldMWpNOCbseHDgmU5uwxN/aB0Sv
         2vYZ0nDUJQRjIEbjpaVRiAczFldC8gqZ/x7aJ/Hzhx9OqRiv1lN92ZXcgyZGR1DeKtGK
         x8dv402HNvxAvLmHSBgRzroojHdYbkD7aThnrI4pAEZhdvKzil/PblZuudtixvulTaaz
         kcRPCKN+dUkl1MIMDKY6FNxCwrQrKDfubHNenarVYhx2LUlLJ5MAIfsz1za82eB9cfiY
         HLBg==
X-Gm-Message-State: AOAM531wOiTPo1BN2vp+WwKnmz+OjC0P7rAU+ZgwqO9KMVB0EQ3oCi1c
        Q6HSiAVPCgKQfthAD7A0MSfrsmtajBLQPufLBZChaTZbLRLTn4NQ1pisiuJqkUEDeZXqFyurdkM
        PjHVcg//6NE5fxrUTpuuYlD9K
X-Received: by 2002:a05:6000:38e:b0:204:101a:b2bf with SMTP id u14-20020a056000038e00b00204101ab2bfmr21144995wrf.308.1649577069987;
        Sun, 10 Apr 2022 00:51:09 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyvYZyBQ0r+Gt7hwuX3pBsyKj4i4o0hapZQla4rsV4724KDz9tVyJjJ9jxgUH/qez7K6v9+rw==
X-Received: by 2002:a05:6000:38e:b0:204:101a:b2bf with SMTP id u14-20020a056000038e00b00204101ab2bfmr21144987wrf.308.1649577069755;
        Sun, 10 Apr 2022 00:51:09 -0700 (PDT)
Received: from redhat.com ([2.53.10.84])
        by smtp.gmail.com with ESMTPSA id u7-20020a05600c19c700b0038cc9aac1a3sm16055019wmq.23.2022.04.10.00.51.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Apr 2022 00:51:08 -0700 (PDT)
Date:   Sun, 10 Apr 2022 03:51:04 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Halil Pasic <pasic@linux.ibm.com>
Cc:     Cornelia Huck <cohuck@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, peterz@infradead.org,
        maz@kernel.org, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, tglx@linutronix.de
Subject: Re: [PATCH V2 4/5] virtio-pci: implement synchronize_vqs()
Message-ID: <20220410034556-mutt-send-email-mst@kernel.org>
References: <20220406083538.16274-1-jasowang@redhat.com>
 <20220406083538.16274-5-jasowang@redhat.com>
 <20220406075952-mutt-send-email-mst@kernel.org>
 <87wng2e527.fsf@redhat.com>
 <20220408150307.24b6b99f.pasic@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220408150307.24b6b99f.pasic@linux.ibm.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 08, 2022 at 03:03:07PM +0200, Halil Pasic wrote:
> On Wed, 06 Apr 2022 15:04:32 +0200
> Cornelia Huck <cohuck@redhat.com> wrote:
> 
> > On Wed, Apr 06 2022, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > 
> > > On Wed, Apr 06, 2022 at 04:35:37PM +0800, Jason Wang wrote:  
> > >> This patch implements PCI version of synchronize_vqs().
> > >> 
> > >> Cc: Thomas Gleixner <tglx@linutronix.de>
> > >> Cc: Peter Zijlstra <peterz@infradead.org>
> > >> Cc: "Paul E. McKenney" <paulmck@kernel.org>
> > >> Cc: Marc Zyngier <maz@kernel.org>
> > >> Signed-off-by: Jason Wang <jasowang@redhat.com>  
> > >
> > > Please add implementations at least for ccw and mmio.  
> > 
> > I'm not sure what (if anything) can/should be done for ccw...
> 
> If nothing needs to be done I would like to have at least a comment in
> the code that explains why. So that somebody who reads the code
> doesn't wonder: why is virtio-ccw not implementing that callback.

Right.

I am currently thinking instead of making this optional in the
core we should make it mandatory, and have transports which do not
need to sync have an empty stub with documentation explaining why.

Also, do we want to document this sync is explicitly for irq enable/disable?
synchronize_irq_enable_disable?


> > 
> > >  
> > >> ---
> > >>  drivers/virtio/virtio_pci_common.c | 14 ++++++++++++++
> > >>  drivers/virtio/virtio_pci_common.h |  2 ++
> > >>  drivers/virtio/virtio_pci_legacy.c |  1 +
> > >>  drivers/virtio/virtio_pci_modern.c |  2 ++
> > >>  4 files changed, 19 insertions(+)
> > >> 
> > >> diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_pci_common.c
> > >> index d724f676608b..b78c8bc93a97 100644
> > >> --- a/drivers/virtio/virtio_pci_common.c
> > >> +++ b/drivers/virtio/virtio_pci_common.c
> > >> @@ -37,6 +37,20 @@ void vp_synchronize_vectors(struct virtio_device *vdev)
> > >>  		synchronize_irq(pci_irq_vector(vp_dev->pci_dev, i));
> > >>  }
> > >>  
> > >> +void vp_synchronize_vqs(struct virtio_device *vdev)
> > >> +{
> > >> +	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
> > >> +	int i;
> > >> +
> > >> +	if (vp_dev->intx_enabled) {
> > >> +		synchronize_irq(vp_dev->pci_dev->irq);
> > >> +		return;
> > >> +	}
> > >> +
> > >> +	for (i = 0; i < vp_dev->msix_vectors; ++i)
> > >> +		synchronize_irq(pci_irq_vector(vp_dev->pci_dev, i));
> > >> +}
> > >> +  
> > 
> > ...given that this seems to synchronize threaded interrupt handlers?
> > Halil, do you think ccw needs to do anything? (AFAICS, we only have one
> > 'irq' for channel devices anyway, and the handler just calls the
> > relevant callbacks directly.)
> 
> Sorry I don't understand enough yet. A more verbose documentation on
> "virtio_synchronize_vqs - synchronize with virtqueue callbacks" would
> surely benefit me. It may be more than enough for a back-belt but it
> ain't enough for me to tell what is the callback supposed to accomplish.
> 
> I will have to study this discussion and the code more thoroughly.
> Tentatively I side with Jason and Michael in a sense, that I don't
> believe virtio-ccw is safe against rough interrupts.
> 
> Sorry for the late response. I intend to revisit this on Monday. If
> I don't please feel encouraged to ping.
> 
> Regards,
> Halil

