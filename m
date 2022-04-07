Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE5904F7920
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 10:09:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242837AbiDGIHP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 04:07:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242846AbiDGIG7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 04:06:59 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AB8ED18A3C6
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 01:04:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649318680;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=C2jSiAWc9glJJIwE5hD1mRnDPKRSEruFK/e4YesNwp0=;
        b=JdNvsZTJ4VleMBwPZ/UayiJ1PygKTuQK3bAAIaeZ94ndN0qbW9AYqpfGRogJ/oX/Kg1JYr
        wfnUbArcG4cORXvxUEagFUyj9uDdRNai1vkI1xfeaY5CK7aOjBQdDWZ6opbH6QsPpMRNQb
        2A/lMOYc7ah6XGZ97FKkTDgfl4+ruUk=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-342-LkM_WNG1MfWM84JYeNxi_w-1; Thu, 07 Apr 2022 04:04:31 -0400
X-MC-Unique: LkM_WNG1MfWM84JYeNxi_w-1
Received: by mail-lf1-f70.google.com with SMTP id z27-20020a0565120c1b00b0045dda312b96so1575655lfu.7
        for <linux-kernel@vger.kernel.org>; Thu, 07 Apr 2022 01:04:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=C2jSiAWc9glJJIwE5hD1mRnDPKRSEruFK/e4YesNwp0=;
        b=m1hrugyorN6mz5e0LRT6dE0I+mMhbDyi/WcSJ+buYsVkXzSQUfBQigLnmDdpbToUAs
         znrNpqZPSduyyM49rIREW7UpiTFQXml53ZqRUNl5u9T5LwXOaP+FvKYl9r6D1hw2MaMA
         fy0wtovsRXRbwYRSSNXI+TNOdv7r6NlhdxHHkl73Xy3iv43ILXjl1LgabTNBWvVOYU1p
         7Je08pxLlruqM+k2wbp2zE/5ENKvTkn76E3+E5Gcue8y+L33UAlnBPnVzR7Vu702frLo
         2da760Nes3zNF/MgYg+gHugcPT3MFBiN/f9P3MtnMGlEC7kzfyhYA4Nkr8iwAEQN+GgU
         ZEBQ==
X-Gm-Message-State: AOAM532qKnZE8pZVpkV450tvfNE46lU1gB1iFqhwQ5omclapb31r/92O
        EoOkknrEWNcvvHXkJnmpmkG6WRu/X557/4enOMtfXmtXls3iGMidHFFCJRNyChdcoaAW6AIQYAl
        DOct3SZcw8PFrNOBFYDlINEpoDvC2rBjtk9LXup5q
X-Received: by 2002:ac2:4477:0:b0:44a:55c6:155d with SMTP id y23-20020ac24477000000b0044a55c6155dmr8329558lfl.376.1649318669901;
        Thu, 07 Apr 2022 01:04:29 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx3HDJ+Ox/XqE+9zxT6Qp0nlecVIsvWwfNMMU25624Ob33IZJs6lQrttXYmKoYwsOidOhAVV6AoKVtr7eF/+ec=
X-Received: by 2002:ac2:4477:0:b0:44a:55c6:155d with SMTP id
 y23-20020ac24477000000b0044a55c6155dmr8329542lfl.376.1649318669682; Thu, 07
 Apr 2022 01:04:29 -0700 (PDT)
MIME-Version: 1.0
References: <20220406083538.16274-1-jasowang@redhat.com> <20220406083538.16274-5-jasowang@redhat.com>
 <20220406075952-mutt-send-email-mst@kernel.org> <87wng2e527.fsf@redhat.com>
 <20220406112858-mutt-send-email-mst@kernel.org> <7e99abbf-f68d-4aa5-71b6-9d1d71b2d25b@redhat.com>
 <87r169ba90.fsf@redhat.com>
In-Reply-To: <87r169ba90.fsf@redhat.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Thu, 7 Apr 2022 16:04:18 +0800
Message-ID: <CACGkMEu-V3NwSmzJciwa1z_P94McirZaxbm26gNgM-8A9J2emg@mail.gmail.com>
Subject: Re: [PATCH V2 4/5] virtio-pci: implement synchronize_vqs()
To:     Cornelia Huck <cohuck@redhat.com>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Marc Zyngier <maz@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        virtualization <virtualization@lists.linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Halil Pasic <pasic@linux.ibm.com>
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

On Thu, Apr 7, 2022 at 3:53 PM Cornelia Huck <cohuck@redhat.com> wrote:
>
> On Thu, Apr 07 2022, Jason Wang <jasowang@redhat.com> wrote:
>
> > =E5=9C=A8 2022/4/6 =E4=B8=8B=E5=8D=8811:31, Michael S. Tsirkin =E5=86=
=99=E9=81=93:
> >> On Wed, Apr 06, 2022 at 03:04:32PM +0200, Cornelia Huck wrote:
> >>> On Wed, Apr 06 2022, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> >>>
> >>>> On Wed, Apr 06, 2022 at 04:35:37PM +0800, Jason Wang wrote:
> >>>>> This patch implements PCI version of synchronize_vqs().
> >>>>>
> >>>>> Cc: Thomas Gleixner <tglx@linutronix.de>
> >>>>> Cc: Peter Zijlstra <peterz@infradead.org>
> >>>>> Cc: "Paul E. McKenney" <paulmck@kernel.org>
> >>>>> Cc: Marc Zyngier <maz@kernel.org>
> >>>>> Signed-off-by: Jason Wang <jasowang@redhat.com>
> >>>> Please add implementations at least for ccw and mmio.
> >>> I'm not sure what (if anything) can/should be done for ccw...
> >>>
> >>>>> ---
> >>>>>   drivers/virtio/virtio_pci_common.c | 14 ++++++++++++++
> >>>>>   drivers/virtio/virtio_pci_common.h |  2 ++
> >>>>>   drivers/virtio/virtio_pci_legacy.c |  1 +
> >>>>>   drivers/virtio/virtio_pci_modern.c |  2 ++
> >>>>>   4 files changed, 19 insertions(+)
> >>>>>
> >>>>> diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/vi=
rtio_pci_common.c
> >>>>> index d724f676608b..b78c8bc93a97 100644
> >>>>> --- a/drivers/virtio/virtio_pci_common.c
> >>>>> +++ b/drivers/virtio/virtio_pci_common.c
> >>>>> @@ -37,6 +37,20 @@ void vp_synchronize_vectors(struct virtio_device=
 *vdev)
> >>>>>                   synchronize_irq(pci_irq_vector(vp_dev->pci_dev, i=
));
> >>>>>   }
> >>>>>
> >>>>> +void vp_synchronize_vqs(struct virtio_device *vdev)
> >>>>> +{
> >>>>> + struct virtio_pci_device *vp_dev =3D to_vp_device(vdev);
> >>>>> + int i;
> >>>>> +
> >>>>> + if (vp_dev->intx_enabled) {
> >>>>> +         synchronize_irq(vp_dev->pci_dev->irq);
> >>>>> +         return;
> >>>>> + }
> >>>>> +
> >>>>> + for (i =3D 0; i < vp_dev->msix_vectors; ++i)
> >>>>> +         synchronize_irq(pci_irq_vector(vp_dev->pci_dev, i));
> >>>>> +}
> >>>>> +
> >>> ...given that this seems to synchronize threaded interrupt handlers?
> >> No, any handlers at all. The point is to make sure any memory changes
> >> made prior to this op are visible to callbacks.
> >>
> >> Jason, maybe add that to the documentation?
> >
> >
> > Sure.
> >
> >
> >>
> >>> Halil, do you think ccw needs to do anything? (AFAICS, we only have o=
ne
> >>> 'irq' for channel devices anyway, and the handler just calls the
> >>> relevant callbacks directly.)
> >> Then you need to synchronize with that.
> >
> >
> > Have a quick glance at the codes, it looks to me we can synchronize wit=
h
> > the IO_INTERRUPT. (Assuming all callbacks are triggered via
> > ccw_device_irq()).
>
> Not quite, adapter interrupts are device-independent, but they are
> relevant for vring interrupts.
>
> That would mean that we would need to synchronize _all_ channel I/O
> interrupts, which looks like a huge hammer. But do we really need that
> at all?

We don't, we only need to synchronize with the vring callbacks, to make sur=
e:

1) the memory changes that is done before this op is visible to the
callbacks that came after this op
2) the memory changes that is done after this op is not visible to
callbacks that came before this op

>
> The last patch in this series seems to be concerned with the "no vring
> interrupts if the device is not ready" case, so it needs to synchronize
> vring interrupts with device reset and setting the device status to
> ready. For virtio-ccw, both reset and setting the status are channel I/O
> operations, i.e. starting a program and waiting for the final device
> interrupt for it, so synchronization (on a device level) is already
> happening in a way. So I'm not sure if any extra synchronization is
> actually needed in this case, but maybe I'm misunderstanding.
>
> Do you have further use cases in mind?

Its goal is to prevent the buggy or malicus device/host from attacking
the driver/guest. One use case is the confidential computing where
guest memory is encrypted and the guest doesn't trust the hypervisor.

In that case, the device can try to raise the interrupt after
request_irq but before DRIVER_OK, which tries to trigger the vq
callbacks when the device is not fully initialized:

request_irq()
virtio_specific_setup() // vq callbacks to be triggered in the middle
virtio_device_ready()

Thanks

>

