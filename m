Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E332F4FCC52
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 04:24:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232599AbiDLCY1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 22:24:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229921AbiDLCYZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 22:24:25 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C26DC2E6A8
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 19:22:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649730128;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kgaL+lS7AJKt0L5x7qfD+kQMcLLSooLLA8RJRkvK0AM=;
        b=Oq+qSkOUByxh/msgHZDeSXghT11D7WtLDsRyGtZ41rV9NrkknOu3JPjr+QSryTFdX0egak
        Of0VAN6LtT4KnqWfjL6qQ6SJDw92Jcjuph60uXDp6CwFyKSTwe8WiF9TrCPpgbVbA9MVgM
        M81AvoRgSaJFPrji2Kz5mQBzdXbu0/I=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-148-JNH7RR-sMDyNvyM0xqw5tw-1; Mon, 11 Apr 2022 22:22:07 -0400
X-MC-Unique: JNH7RR-sMDyNvyM0xqw5tw-1
Received: by mail-lf1-f72.google.com with SMTP id t17-20020a056512069100b0046bb606d8efso670037lfe.12
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 19:22:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kgaL+lS7AJKt0L5x7qfD+kQMcLLSooLLA8RJRkvK0AM=;
        b=xi+gMQf2V7KnRYl81cAI0SxWWmHT4nfZrWIQ5f9ozRPhOO4zwo0mTsIS1OQKR5v2bI
         EsCKiZydE2OoLLCt3w1FjQ5J1BaGfJS/Cuqs1XN4xA4R0Y9VHMGkMDZAAekqclC14KFD
         h9VBvjzr1QAzVFodnYlsUxInJrATFUi55a30KGhJ17RWZzai9IJEEkwIFWRcT8BfzkzQ
         c9rD8dyBx66kICUhp8dWcxoCsG2y8phOS89/QMI82qV0saYe5tO17A9QTF8G4FAsBkTJ
         SZMW0JNDSkV4NQDCFz0Ocx3Tbo59+5V/+0vJYwNI/WeABGzuc7mhjLUfc+bhNlbCqHvU
         fwjw==
X-Gm-Message-State: AOAM5300GxLYk4mn8uL857UUuwlfn6nP5rt4EsojKP+qkM9fOGGUE42z
        wvYV9XYUcAlAxn8PEjUw8tR1HYyDecgQ8lV9zIuwLPjkVoMId9QoXNdGN62h6eq5esxlW2XJ6zZ
        1xb/3ldcsQNF7zTXFRf2tGryDRnpDwS7C9bqQ7LFt
X-Received: by 2002:a05:6512:3093:b0:46b:814c:3a69 with SMTP id z19-20020a056512309300b0046b814c3a69mr13913200lfd.376.1649730125669;
        Mon, 11 Apr 2022 19:22:05 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyj81bElhbWdbHaCw3liipX3LewYs9Ob5vG1YGcd586nyUHN+apJ6xXyev/cxx4QUdrcqnamFGnFTrKbUAmXBw=
X-Received: by 2002:a05:6512:3093:b0:46b:814c:3a69 with SMTP id
 z19-20020a056512309300b0046b814c3a69mr13913187lfd.376.1649730125467; Mon, 11
 Apr 2022 19:22:05 -0700 (PDT)
MIME-Version: 1.0
References: <20220406083538.16274-1-jasowang@redhat.com> <20220406083538.16274-5-jasowang@redhat.com>
 <20220406075952-mutt-send-email-mst@kernel.org> <87wng2e527.fsf@redhat.com>
 <20220408150307.24b6b99f.pasic@linux.ibm.com> <20220410034556-mutt-send-email-mst@kernel.org>
 <CACGkMEtarZb6g3ij5=+As17+d9jtdAqNa1EzSuTXc7Pq_som0Q@mail.gmail.com> <20220411045011-mutt-send-email-mst@kernel.org>
In-Reply-To: <20220411045011-mutt-send-email-mst@kernel.org>
From:   Jason Wang <jasowang@redhat.com>
Date:   Tue, 12 Apr 2022 10:21:54 +0800
Message-ID: <CACGkMEs6vnE8pcDEn2smvTPNnE015kgzk=+qsopg_Zh2GZMOwA@mail.gmail.com>
Subject: Re: [PATCH V2 4/5] virtio-pci: implement synchronize_vqs()
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Halil Pasic <pasic@linux.ibm.com>,
        Cornelia Huck <cohuck@redhat.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Marc Zyngier <maz@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        virtualization <virtualization@lists.linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 11, 2022 at 4:56 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Mon, Apr 11, 2022 at 04:22:19PM +0800, Jason Wang wrote:
> > On Sun, Apr 10, 2022 at 3:51 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > >
> > > On Fri, Apr 08, 2022 at 03:03:07PM +0200, Halil Pasic wrote:
> > > > On Wed, 06 Apr 2022 15:04:32 +0200
> > > > Cornelia Huck <cohuck@redhat.com> wrote:
> > > >
> > > > > On Wed, Apr 06 2022, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > > > >
> > > > > > On Wed, Apr 06, 2022 at 04:35:37PM +0800, Jason Wang wrote:
> > > > > >> This patch implements PCI version of synchronize_vqs().
> > > > > >>
> > > > > >> Cc: Thomas Gleixner <tglx@linutronix.de>
> > > > > >> Cc: Peter Zijlstra <peterz@infradead.org>
> > > > > >> Cc: "Paul E. McKenney" <paulmck@kernel.org>
> > > > > >> Cc: Marc Zyngier <maz@kernel.org>
> > > > > >> Signed-off-by: Jason Wang <jasowang@redhat.com>
> > > > > >
> > > > > > Please add implementations at least for ccw and mmio.
> > > > >
> > > > > I'm not sure what (if anything) can/should be done for ccw...
> > > >
> > > > If nothing needs to be done I would like to have at least a comment in
> > > > the code that explains why. So that somebody who reads the code
> > > > doesn't wonder: why is virtio-ccw not implementing that callback.
> > >
> > > Right.
> > >
> > > I am currently thinking instead of making this optional in the
> > > core we should make it mandatory, and have transports which do not
> > > need to sync have an empty stub with documentation explaining why.
> > >
> > > Also, do we want to document this sync is explicitly for irq enable/disable?
> > > synchronize_irq_enable_disable?
> >
> > I would not since the transport is not guaranteed to use an interrupt
> > for callbacks.
>
> OK but let's then document this in more detail.
> More readers will wonder about what is the callback
> trying to accomplish, and Halil requested that as well.
>
> For example, let's document why is sync required on enable.

Ok.

Thanks

>
> > >
> > >
> > > > >
> > > > > >
> > > > > >> ---
> > > > > >>  drivers/virtio/virtio_pci_common.c | 14 ++++++++++++++
> > > > > >>  drivers/virtio/virtio_pci_common.h |  2 ++
> > > > > >>  drivers/virtio/virtio_pci_legacy.c |  1 +
> > > > > >>  drivers/virtio/virtio_pci_modern.c |  2 ++
> > > > > >>  4 files changed, 19 insertions(+)
> > > > > >>
> > > > > >> diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_pci_common.c
> > > > > >> index d724f676608b..b78c8bc93a97 100644
> > > > > >> --- a/drivers/virtio/virtio_pci_common.c
> > > > > >> +++ b/drivers/virtio/virtio_pci_common.c
> > > > > >> @@ -37,6 +37,20 @@ void vp_synchronize_vectors(struct virtio_device *vdev)
> > > > > >>                  synchronize_irq(pci_irq_vector(vp_dev->pci_dev, i));
> > > > > >>  }
> > > > > >>
> > > > > >> +void vp_synchronize_vqs(struct virtio_device *vdev)
> > > > > >> +{
> > > > > >> +        struct virtio_pci_device *vp_dev = to_vp_device(vdev);
> > > > > >> +        int i;
> > > > > >> +
> > > > > >> +        if (vp_dev->intx_enabled) {
> > > > > >> +                synchronize_irq(vp_dev->pci_dev->irq);
> > > > > >> +                return;
> > > > > >> +        }
> > > > > >> +
> > > > > >> +        for (i = 0; i < vp_dev->msix_vectors; ++i)
> > > > > >> +                synchronize_irq(pci_irq_vector(vp_dev->pci_dev, i));
> > > > > >> +}
> > > > > >> +
> > > > >
> > > > > ...given that this seems to synchronize threaded interrupt handlers?
> > > > > Halil, do you think ccw needs to do anything? (AFAICS, we only have one
> > > > > 'irq' for channel devices anyway, and the handler just calls the
> > > > > relevant callbacks directly.)
> > > >
> > > > Sorry I don't understand enough yet. A more verbose documentation on
> > > > "virtio_synchronize_vqs - synchronize with virtqueue callbacks" would
> > > > surely benefit me. It may be more than enough for a back-belt but it
> > > > ain't enough for me to tell what is the callback supposed to accomplish.
> > > >
> > > > I will have to study this discussion and the code more thoroughly.
> > > > Tentatively I side with Jason and Michael in a sense, that I don't
> > > > believe virtio-ccw is safe against rough interrupts.
> >
> > That's my feeling as well.
> >
> > Thanks
> >
> > > >
> > > > Sorry for the late response. I intend to revisit this on Monday. If
> > > > I don't please feel encouraged to ping.
> > > >
> > > > Regards,
> > > > Halil
> > >
>

