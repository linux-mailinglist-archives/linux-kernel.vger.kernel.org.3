Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB29A4FCC6D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 04:24:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242323AbiDLC1J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 22:27:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238083AbiDLC1H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 22:27:07 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4934DBC83
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 19:24:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649730290;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=U91PiURNFV2fKxTIEP7GO5tX2GZNd7Bfp7ekztFiEcU=;
        b=HiOB0yGOniOKHBcsXmsQmYknMIF9hga060rCgwWOiLCCvVot8iz4r5W8LuHMkN3xB0sLmR
        feqsjc0EaQWsHsv6y4nJ56acaIJz7IPBy2nOey1H9xaQUahVBtKztYBDsIgx9cfmRqTOt7
        hqjo+n39u/MYWFvw1re3XW1Ophm+y68=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-272-McGLCUiePOmc6y9X3Qh3eQ-1; Mon, 11 Apr 2022 22:24:48 -0400
X-MC-Unique: McGLCUiePOmc6y9X3Qh3eQ-1
Received: by mail-lj1-f197.google.com with SMTP id p9-20020a2ea4c9000000b0024b62f1ddebso1582194ljm.23
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 19:24:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=U91PiURNFV2fKxTIEP7GO5tX2GZNd7Bfp7ekztFiEcU=;
        b=bSJxXqaraeWhw4R6cAz4gcFKCJFrNxr9Cml72S4Xyr/NCPahsZGh6EJD/PeJldXR68
         hF7fiDR6KveKwEHkwAjlsnhX2RKozTk7Cxqxy9wwsMM74dzBSBuCN/tMdyywhVMcyAsz
         /bTryyYLvT/3W6YJ/N1FGtSg8mT3MeoBvk8lUcSEaXq2KWVGWz4oD5cmaabW+KKr1guC
         CSDd2lMSOrmIRl75VgUj0prE18gSFccFThQHGf8LlUu3Qu6McaCtS044xbsP2j2nJ4Yv
         qeRhdhXI1o9e/HTlP1WBlZsfWY8XlXG2ZrHnlDV2/4t1hAxhcvQ1GzIYN6UvdoVXvZuc
         3csA==
X-Gm-Message-State: AOAM532FpaUVX9ogHAWAZmomuwCSZ5lql1x6yoAhTysqitQnGf3Wv921
        swTquAGDqd3MEstIKd6hSuWRRoUUIKWQ+7/xpvnnhKu9b/ijygPGf4NivBFqiXasQlB9S+JOa0r
        3AjHqBlYUz5sizX1N4GdJwIuWGPJCv0hyOUNJjfTp
X-Received: by 2002:a05:6512:b81:b0:448:b342:513c with SMTP id b1-20020a0565120b8100b00448b342513cmr23533665lfv.257.1649730287279;
        Mon, 11 Apr 2022 19:24:47 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyriilgsCa0fnjLvRc9+m4ztpQqX137F7IBRBNtJ2Ku+BVjGMKTZvwHHTDT7U+xGoryLTsKpDLdOUKsJnHhYd8=
X-Received: by 2002:a05:6512:b81:b0:448:b342:513c with SMTP id
 b1-20020a0565120b8100b00448b342513cmr23533653lfv.257.1649730287091; Mon, 11
 Apr 2022 19:24:47 -0700 (PDT)
MIME-Version: 1.0
References: <20220406083538.16274-1-jasowang@redhat.com> <20220406083538.16274-5-jasowang@redhat.com>
 <20220406075952-mutt-send-email-mst@kernel.org> <87wng2e527.fsf@redhat.com>
 <20220408150307.24b6b99f.pasic@linux.ibm.com> <20220410034556-mutt-send-email-mst@kernel.org>
 <CACGkMEtarZb6g3ij5=+As17+d9jtdAqNa1EzSuTXc7Pq_som0Q@mail.gmail.com>
 <877d7vbspu.fsf@redhat.com> <20220412020145.32e26e5a.pasic@linux.ibm.com>
In-Reply-To: <20220412020145.32e26e5a.pasic@linux.ibm.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Tue, 12 Apr 2022 10:24:35 +0800
Message-ID: <CACGkMEvDSv+sZwLYqqfP-jzDzonmon+CxeSXkvyd6F-CbfV3tQ@mail.gmail.com>
Subject: Re: [PATCH V2 4/5] virtio-pci: implement synchronize_vqs()
To:     Halil Pasic <pasic@linux.ibm.com>
Cc:     Cornelia Huck <cohuck@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Marc Zyngier <maz@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        virtualization <virtualization@lists.linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 12, 2022 at 8:02 AM Halil Pasic <pasic@linux.ibm.com> wrote:
>
> On Mon, 11 Apr 2022 16:27:41 +0200
> Cornelia Huck <cohuck@redhat.com> wrote:
>
> > On Mon, Apr 11 2022, Jason Wang <jasowang@redhat.com> wrote:
> >
> > > On Sun, Apr 10, 2022 at 3:51 PM Michael S. Tsirkin <mst@redhat.com> w=
rote:
> > >>
> > >> On Fri, Apr 08, 2022 at 03:03:07PM +0200, Halil Pasic wrote:
> > >> > On Wed, 06 Apr 2022 15:04:32 +0200
> > >> > Cornelia Huck <cohuck@redhat.com> wrote:
> > >> >
> > >> > > On Wed, Apr 06 2022, "Michael S. Tsirkin" <mst@redhat.com> wrote=
:
> > >> > >
> > >> > > > On Wed, Apr 06, 2022 at 04:35:37PM +0800, Jason Wang wrote:
> > >> > > >> This patch implements PCI version of synchronize_vqs().
> > >> > > >>
> > >> > > >> Cc: Thomas Gleixner <tglx@linutronix.de>
> > >> > > >> Cc: Peter Zijlstra <peterz@infradead.org>
> > >> > > >> Cc: "Paul E. McKenney" <paulmck@kernel.org>
> > >> > > >> Cc: Marc Zyngier <maz@kernel.org>
> > >> > > >> Signed-off-by: Jason Wang <jasowang@redhat.com>
> > >> > > >
> > >> > > > Please add implementations at least for ccw and mmio.
> > >> > >
> > >> > > I'm not sure what (if anything) can/should be done for ccw...
> > >> >
> > >> > If nothing needs to be done I would like to have at least a commen=
t in
> > >> > the code that explains why. So that somebody who reads the code
> > >> > doesn't wonder: why is virtio-ccw not implementing that callback.
> > >>
> > >> Right.
> > >>
> > >> I am currently thinking instead of making this optional in the
> > >> core we should make it mandatory, and have transports which do not
> > >> need to sync have an empty stub with documentation explaining why.
> >
> > Yes, that makes sense to me. If we can explain why we don't need to do
> > anything, we should keep that explanation easily accessible.
> >
> > >>
> > >> Also, do we want to document this sync is explicitly for irq enable/=
disable?
> > >> synchronize_irq_enable_disable?
> > >
> > > I would not since the transport is not guaranteed to use an interrupt
> > > for callbacks.
> > >
> > >>
> > >>
> > >> > >
> > >> > > >
> > >> > > >> ---
> > >> > > >>  drivers/virtio/virtio_pci_common.c | 14 ++++++++++++++
> > >> > > >>  drivers/virtio/virtio_pci_common.h |  2 ++
> > >> > > >>  drivers/virtio/virtio_pci_legacy.c |  1 +
> > >> > > >>  drivers/virtio/virtio_pci_modern.c |  2 ++
> > >> > > >>  4 files changed, 19 insertions(+)
> > >> > > >>
> > >> > > >> diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/vir=
tio/virtio_pci_common.c
> > >> > > >> index d724f676608b..b78c8bc93a97 100644
> > >> > > >> --- a/drivers/virtio/virtio_pci_common.c
> > >> > > >> +++ b/drivers/virtio/virtio_pci_common.c
> > >> > > >> @@ -37,6 +37,20 @@ void vp_synchronize_vectors(struct virtio_=
device *vdev)
> > >> > > >>                  synchronize_irq(pci_irq_vector(vp_dev->pci_d=
ev, i));
> > >> > > >>  }
> > >> > > >>
> > >> > > >> +void vp_synchronize_vqs(struct virtio_device *vdev)
> > >> > > >> +{
> > >> > > >> +        struct virtio_pci_device *vp_dev =3D to_vp_device(vd=
ev);
> > >> > > >> +        int i;
> > >> > > >> +
> > >> > > >> +        if (vp_dev->intx_enabled) {
> > >> > > >> +                synchronize_irq(vp_dev->pci_dev->irq);
> > >> > > >> +                return;
> > >> > > >> +        }
> > >> > > >> +
> > >> > > >> +        for (i =3D 0; i < vp_dev->msix_vectors; ++i)
> > >> > > >> +                synchronize_irq(pci_irq_vector(vp_dev->pci_d=
ev, i));
> > >> > > >> +}
> > >> > > >> +
> > >> > >
> > >> > > ...given that this seems to synchronize threaded interrupt handl=
ers?
> > >> > > Halil, do you think ccw needs to do anything? (AFAICS, we only h=
ave one
> > >> > > 'irq' for channel devices anyway, and the handler just calls the
> > >> > > relevant callbacks directly.)
> > >> >
> > >> > Sorry I don't understand enough yet. A more verbose documentation =
on
> > >> > "virtio_synchronize_vqs - synchronize with virtqueue callbacks" wo=
uld
> > >> > surely benefit me. It may be more than enough for a back-belt but =
it
> > >> > ain't enough for me to tell what is the callback supposed to accom=
plish.
> >
> > +1 for more explanations.
> >
> > >> >
> > >> > I will have to study this discussion and the code more thoroughly.
> > >> > Tentatively I side with Jason and Michael in a sense, that I don't
> > >> > believe virtio-ccw is safe against rough interrupts.
> > >
> > > That's my feeling as well.
> >
> > I'd say ccw is safe against "notification interrupts before indicators
> > have been registered".
>
> I believe Jason's scope is broader than that. Let me try to explain. A
> quote form the standard:
> """
> 3.1.1 Driver Requirements: Device Initialization
> The driver MUST follow this sequence to initialize a device:
>     1. Reset the device.
>     2. Set the ACKNOWLEDGE status bit: the guest OS has noticed the devic=
e.
>     3. Set the DRIVER status bit: the guest OS knows how to drive the dev=
ice.
>     4. Read device feature bits, and write the subset of feature bits und=
erstood by the OS and driver to the device. During this step the driver MAY=
 read (but MUST NOT write) the device-specific configuration fields to chec=
k that it can support the device before accepting it.
>     5. Set the FEATURES_OK status bit. The driver MUST NOT accept new fea=
ture bits after this step.
>     6. Re-read device status to ensure the FEATURES_OK bit is still set: =
otherwise, the device does not support our subset of features and the devic=
e is unusable.
>     7. Perform device-specific setup, including discovery of virtqueues f=
or the device, optional per-bus setup, reading and possibly writing the dev=
ice=E2=80=99s virtio configuration space, and population of virtqueues.
>     8. Set the DRIVER_OK status bit. At this point the device is =E2=80=
=9Clive=E2=80=9D.
> """
>
> That means stuff may happen between "discovery of virtqueues" and "DRIVER=
_OK". So it
> is not sufficient to be "safe against notifications before indicators
> have been registered", but we want to be also safe between "indicators ha=
ve
> been registered" and "DRIVER_OK status has been set".
>
> @Jason: can you confirm?

Exactly.

>
> Regarding the question "are we safe against notifications before
> indicators have been registered" I think we really need to think about
> something like Secure Execution. We don't have, and we are unlikely
> to have in hardware virtio-ccw implementations, and for a malicious hyper=
visor
> that has full access to the guest memory hardening makes no sense.

Does s390 have something like memory encryption? (I guess yes). In the
case of x86 VM encryption, the I/O buffers were now done via software
IOTLB, that's why hardening of the virtio driver is needed to prevent
the hypervisor to poke the swiotlb etc.

Thanks

>
> But if we assume that an attacker can inject adapter interrupts for an ar=
bitrary
> ISC, and can poke any shared memory (notifier bits are shared)... Things =
might
> become critical already when register_adapter_interrupt() does it's magic=
.
>
>
> > For the reverse case, maybe we should always
> > invalidate the indicators in the reset case? More information regarding
> > the attack vector would help here :)
> >
> > My main concern is that we would need to synchronize against a single
> > interrupt that covers all kinds of I/O interrupts, not just a single
> > device...
> >
>
> Could we synchronize on struct airq_info's lock member? If we were
> to grab all of these that might be involved...
>
> AFAIU for the synchronize implementation we need a lock or a set of locks
> that contain all the possible vring_interrupt() calls with the queuues
> that belong to the given device as a critical section. That way, one
> has the acquire's and release's in place so that the vrign_interrupt()
> either guaranteed to finish before the change of driver_ready is
> guaranteed to be complete, or it is guaranteed to see the change.
>
> In any case, I guess we should first get clear on the first part. I.e.
> when do we want to allow host->guest notifications.
>
> Regards,
> Halil
>

