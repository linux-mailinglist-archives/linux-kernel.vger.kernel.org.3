Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5B5F4FB68D
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 10:56:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240236AbiDKI67 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 04:58:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242675AbiDKI6z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 04:58:55 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 749DC22BE0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 01:56:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649667400;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=k/8SRRAANzvkchv/qA5xGsv21EcrCPMWC+psYPj5Pk4=;
        b=GYG8FLolAE5R4cnLk/5RDynre+14c4+gGYzhzpXLYNYKpdy6qsOW9ndJ7X2+YidF/cWWuG
        a1rotW+48YO0QEttmbMIIW8an4hxwDNrNbwPLKRLaCFOrVFK/wfFe01yRz4Xlu2QTZ6bGC
        6ANG+b2Choip+NIRo/uHeU4fZ48h/OQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-580-LTcTJFYxNJSUHFc9H6FUUQ-1; Mon, 11 Apr 2022 04:56:39 -0400
X-MC-Unique: LTcTJFYxNJSUHFc9H6FUUQ-1
Received: by mail-wm1-f71.google.com with SMTP id 130-20020a1c0288000000b0038ec265155fso52559wmc.6
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 01:56:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=k/8SRRAANzvkchv/qA5xGsv21EcrCPMWC+psYPj5Pk4=;
        b=wpux3ExS2WBRuvC4Oupl5rBEZk1jITaGIDchEtr5T9BZCNgAZS9YbRq+NMThH+r/q6
         StadVzZmIJDXsKNSLM10T/Rj5wPzetZxIaSg+0nlQUzaaj7J9c0XNM0c5Bua9mAfkV9k
         DyMW7XBW9dEWurwjlKbcFt0IcjiJLHJQyg76odTG2jOB+cGD02ALRzoJMmGFEv3blaMB
         WZZXYid0XpDnUMa859Xkr2OfAhioOtyTJWqbTzDyOnDTlIdeRMJa/H3/h+D5hzHIxrkF
         IB0RI5VsUyNZWQd3B9HOmFm7sEHvgvWEkdJyK2D4mrQb1C4fNMjH8iBDv/uejmK1sInf
         lYmw==
X-Gm-Message-State: AOAM532JDEQuxACdvUdTJkF4WIygwbtV3snq0KhqNKcJdoK8P9A/mVzg
        SGTZepE5B2kxCCoLeXukqszHGKgETcsGOLTa0prQSFGSk/T0sBoUWaoUegjcKh32lgKAWpUcyW4
        tQMZn53pZT45gPvE3ZozVp2ID
X-Received: by 2002:a5d:6d8a:0:b0:204:8aa:309f with SMTP id l10-20020a5d6d8a000000b0020408aa309fmr23696635wrs.38.1649667398031;
        Mon, 11 Apr 2022 01:56:38 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzbuWEZKovLlvZ9rE66XCQpJJwVUoRQzhWiB2WoGPCiZ1WI17PylwzUv/x5oI7UDfQLPpTKHQ==
X-Received: by 2002:a5d:6d8a:0:b0:204:8aa:309f with SMTP id l10-20020a5d6d8a000000b0020408aa309fmr23696617wrs.38.1649667397814;
        Mon, 11 Apr 2022 01:56:37 -0700 (PDT)
Received: from redhat.com ([2.52.1.156])
        by smtp.gmail.com with ESMTPSA id u11-20020a056000038b00b00203e5c9aa09sm36522327wrf.27.2022.04.11.01.56.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Apr 2022 01:56:36 -0700 (PDT)
Date:   Mon, 11 Apr 2022 04:56:33 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     Halil Pasic <pasic@linux.ibm.com>,
        Cornelia Huck <cohuck@redhat.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Marc Zyngier <maz@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        virtualization <virtualization@lists.linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH V2 4/5] virtio-pci: implement synchronize_vqs()
Message-ID: <20220411045011-mutt-send-email-mst@kernel.org>
References: <20220406083538.16274-1-jasowang@redhat.com>
 <20220406083538.16274-5-jasowang@redhat.com>
 <20220406075952-mutt-send-email-mst@kernel.org>
 <87wng2e527.fsf@redhat.com>
 <20220408150307.24b6b99f.pasic@linux.ibm.com>
 <20220410034556-mutt-send-email-mst@kernel.org>
 <CACGkMEtarZb6g3ij5=+As17+d9jtdAqNa1EzSuTXc7Pq_som0Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACGkMEtarZb6g3ij5=+As17+d9jtdAqNa1EzSuTXc7Pq_som0Q@mail.gmail.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 11, 2022 at 04:22:19PM +0800, Jason Wang wrote:
> On Sun, Apr 10, 2022 at 3:51 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Fri, Apr 08, 2022 at 03:03:07PM +0200, Halil Pasic wrote:
> > > On Wed, 06 Apr 2022 15:04:32 +0200
> > > Cornelia Huck <cohuck@redhat.com> wrote:
> > >
> > > > On Wed, Apr 06 2022, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > > >
> > > > > On Wed, Apr 06, 2022 at 04:35:37PM +0800, Jason Wang wrote:
> > > > >> This patch implements PCI version of synchronize_vqs().
> > > > >>
> > > > >> Cc: Thomas Gleixner <tglx@linutronix.de>
> > > > >> Cc: Peter Zijlstra <peterz@infradead.org>
> > > > >> Cc: "Paul E. McKenney" <paulmck@kernel.org>
> > > > >> Cc: Marc Zyngier <maz@kernel.org>
> > > > >> Signed-off-by: Jason Wang <jasowang@redhat.com>
> > > > >
> > > > > Please add implementations at least for ccw and mmio.
> > > >
> > > > I'm not sure what (if anything) can/should be done for ccw...
> > >
> > > If nothing needs to be done I would like to have at least a comment in
> > > the code that explains why. So that somebody who reads the code
> > > doesn't wonder: why is virtio-ccw not implementing that callback.
> >
> > Right.
> >
> > I am currently thinking instead of making this optional in the
> > core we should make it mandatory, and have transports which do not
> > need to sync have an empty stub with documentation explaining why.
> >
> > Also, do we want to document this sync is explicitly for irq enable/disable?
> > synchronize_irq_enable_disable?
> 
> I would not since the transport is not guaranteed to use an interrupt
> for callbacks.

OK but let's then document this in more detail.
More readers will wonder about what is the callback
trying to accomplish, and Halil requested that as well.

For example, let's document why is sync required on enable.

> >
> >
> > > >
> > > > >
> > > > >> ---
> > > > >>  drivers/virtio/virtio_pci_common.c | 14 ++++++++++++++
> > > > >>  drivers/virtio/virtio_pci_common.h |  2 ++
> > > > >>  drivers/virtio/virtio_pci_legacy.c |  1 +
> > > > >>  drivers/virtio/virtio_pci_modern.c |  2 ++
> > > > >>  4 files changed, 19 insertions(+)
> > > > >>
> > > > >> diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_pci_common.c
> > > > >> index d724f676608b..b78c8bc93a97 100644
> > > > >> --- a/drivers/virtio/virtio_pci_common.c
> > > > >> +++ b/drivers/virtio/virtio_pci_common.c
> > > > >> @@ -37,6 +37,20 @@ void vp_synchronize_vectors(struct virtio_device *vdev)
> > > > >>                  synchronize_irq(pci_irq_vector(vp_dev->pci_dev, i));
> > > > >>  }
> > > > >>
> > > > >> +void vp_synchronize_vqs(struct virtio_device *vdev)
> > > > >> +{
> > > > >> +        struct virtio_pci_device *vp_dev = to_vp_device(vdev);
> > > > >> +        int i;
> > > > >> +
> > > > >> +        if (vp_dev->intx_enabled) {
> > > > >> +                synchronize_irq(vp_dev->pci_dev->irq);
> > > > >> +                return;
> > > > >> +        }
> > > > >> +
> > > > >> +        for (i = 0; i < vp_dev->msix_vectors; ++i)
> > > > >> +                synchronize_irq(pci_irq_vector(vp_dev->pci_dev, i));
> > > > >> +}
> > > > >> +
> > > >
> > > > ...given that this seems to synchronize threaded interrupt handlers?
> > > > Halil, do you think ccw needs to do anything? (AFAICS, we only have one
> > > > 'irq' for channel devices anyway, and the handler just calls the
> > > > relevant callbacks directly.)
> > >
> > > Sorry I don't understand enough yet. A more verbose documentation on
> > > "virtio_synchronize_vqs - synchronize with virtqueue callbacks" would
> > > surely benefit me. It may be more than enough for a back-belt but it
> > > ain't enough for me to tell what is the callback supposed to accomplish.
> > >
> > > I will have to study this discussion and the code more thoroughly.
> > > Tentatively I side with Jason and Michael in a sense, that I don't
> > > believe virtio-ccw is safe against rough interrupts.
> 
> That's my feeling as well.
> 
> Thanks
> 
> > >
> > > Sorry for the late response. I intend to revisit this on Monday. If
> > > I don't please feel encouraged to ping.
> > >
> > > Regards,
> > > Halil
> >

