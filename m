Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 889CF4FB5EB
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 10:22:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343747AbiDKIY4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 04:24:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343739AbiDKIYv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 04:24:51 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 848503E5DE
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 01:22:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649665353;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cPyaIl319ztvqKoCtkHuGci2rqOpStJtnRV8yytfiK0=;
        b=X3z0ARNfoCmeYlswDEKLQ/i/UOqFvG4Cwvd9DORS+CibwbS6fbJMGFVKIQX1ZfHD5D9WXr
        1mem3+NljZAw2Wm/9/+tSMmoUkKjRLMzKY1pw1IXvJbL+GMWtQvTo0pzWlwhycwbLG+ZtV
        EgH0Yk7u+L+RJ77+3UudHGPyyWOqeuE=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-646-alki2byfOiearncrwEdQ8Q-1; Mon, 11 Apr 2022 04:22:32 -0400
X-MC-Unique: alki2byfOiearncrwEdQ8Q-1
Received: by mail-lj1-f199.google.com with SMTP id o17-20020a05651c051100b0024b519d68e6so3095770ljp.6
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 01:22:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cPyaIl319ztvqKoCtkHuGci2rqOpStJtnRV8yytfiK0=;
        b=sG/FwEwp+qHBlTv2l+ijaxLEmCA1dsyw8TfalPsqmgtBhqmaXpaxJ3xJ6q+bOvA9oS
         NtN+jizK6Z1bh6Lhs6cfmXkCmpYjPhqqgaMZ/ksAsEBwfGqo9QIKZDnC2UsexhkxyRaS
         jg0L3Op7q1bJeRychRCtFHB+oD8fm2p6BjU9fP3CZfQCSTceVRwcepl/szBxFyPpu8Lk
         VXD/BSzoPaXcPpAYfgg63N4HR6ym4uE7sKWYDXLqcq0LETgISFkVEdXu42oJtEKgfJOf
         r/8khaho6ZtaFcBFqate+S6VUIHlecH2S0m+ODkTNnvVM6eJpSYcXjoYwCB9Oviocws5
         yFYQ==
X-Gm-Message-State: AOAM5339bk5V+v2X22Sm97Vn8Ql3qIp4N+R8pQTPjnCZHWN3/v+axFbP
        kWreVseFEacYgs7OuPJ6Q7weKYeG/bK0nxjTir0UG1FD89i+8JbTSSpVuSejlvxS141JpiEYPNC
        LG74RwYub2hOkvQWabE7To2mKVMwKOcIx627oZxdY
X-Received: by 2002:a05:6512:b81:b0:448:b342:513c with SMTP id b1-20020a0565120b8100b00448b342513cmr20774692lfv.257.1649665350803;
        Mon, 11 Apr 2022 01:22:30 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy36T1IkIh/LBxNUKNUU+NDYgK6XmC1TUtECkJuaLTLruMjPfiHtpO/zql/yb2VBluB9HiXpVgbuKV8j2NoQ7w=
X-Received: by 2002:a05:6512:b81:b0:448:b342:513c with SMTP id
 b1-20020a0565120b8100b00448b342513cmr20774672lfv.257.1649665350470; Mon, 11
 Apr 2022 01:22:30 -0700 (PDT)
MIME-Version: 1.0
References: <20220406083538.16274-1-jasowang@redhat.com> <20220406083538.16274-5-jasowang@redhat.com>
 <20220406075952-mutt-send-email-mst@kernel.org> <87wng2e527.fsf@redhat.com>
 <20220408150307.24b6b99f.pasic@linux.ibm.com> <20220410034556-mutt-send-email-mst@kernel.org>
In-Reply-To: <20220410034556-mutt-send-email-mst@kernel.org>
From:   Jason Wang <jasowang@redhat.com>
Date:   Mon, 11 Apr 2022 16:22:19 +0800
Message-ID: <CACGkMEtarZb6g3ij5=+As17+d9jtdAqNa1EzSuTXc7Pq_som0Q@mail.gmail.com>
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
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 10, 2022 at 3:51 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Fri, Apr 08, 2022 at 03:03:07PM +0200, Halil Pasic wrote:
> > On Wed, 06 Apr 2022 15:04:32 +0200
> > Cornelia Huck <cohuck@redhat.com> wrote:
> >
> > > On Wed, Apr 06 2022, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > >
> > > > On Wed, Apr 06, 2022 at 04:35:37PM +0800, Jason Wang wrote:
> > > >> This patch implements PCI version of synchronize_vqs().
> > > >>
> > > >> Cc: Thomas Gleixner <tglx@linutronix.de>
> > > >> Cc: Peter Zijlstra <peterz@infradead.org>
> > > >> Cc: "Paul E. McKenney" <paulmck@kernel.org>
> > > >> Cc: Marc Zyngier <maz@kernel.org>
> > > >> Signed-off-by: Jason Wang <jasowang@redhat.com>
> > > >
> > > > Please add implementations at least for ccw and mmio.
> > >
> > > I'm not sure what (if anything) can/should be done for ccw...
> >
> > If nothing needs to be done I would like to have at least a comment in
> > the code that explains why. So that somebody who reads the code
> > doesn't wonder: why is virtio-ccw not implementing that callback.
>
> Right.
>
> I am currently thinking instead of making this optional in the
> core we should make it mandatory, and have transports which do not
> need to sync have an empty stub with documentation explaining why.
>
> Also, do we want to document this sync is explicitly for irq enable/disable?
> synchronize_irq_enable_disable?

I would not since the transport is not guaranteed to use an interrupt
for callbacks.

>
>
> > >
> > > >
> > > >> ---
> > > >>  drivers/virtio/virtio_pci_common.c | 14 ++++++++++++++
> > > >>  drivers/virtio/virtio_pci_common.h |  2 ++
> > > >>  drivers/virtio/virtio_pci_legacy.c |  1 +
> > > >>  drivers/virtio/virtio_pci_modern.c |  2 ++
> > > >>  4 files changed, 19 insertions(+)
> > > >>
> > > >> diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_pci_common.c
> > > >> index d724f676608b..b78c8bc93a97 100644
> > > >> --- a/drivers/virtio/virtio_pci_common.c
> > > >> +++ b/drivers/virtio/virtio_pci_common.c
> > > >> @@ -37,6 +37,20 @@ void vp_synchronize_vectors(struct virtio_device *vdev)
> > > >>                  synchronize_irq(pci_irq_vector(vp_dev->pci_dev, i));
> > > >>  }
> > > >>
> > > >> +void vp_synchronize_vqs(struct virtio_device *vdev)
> > > >> +{
> > > >> +        struct virtio_pci_device *vp_dev = to_vp_device(vdev);
> > > >> +        int i;
> > > >> +
> > > >> +        if (vp_dev->intx_enabled) {
> > > >> +                synchronize_irq(vp_dev->pci_dev->irq);
> > > >> +                return;
> > > >> +        }
> > > >> +
> > > >> +        for (i = 0; i < vp_dev->msix_vectors; ++i)
> > > >> +                synchronize_irq(pci_irq_vector(vp_dev->pci_dev, i));
> > > >> +}
> > > >> +
> > >
> > > ...given that this seems to synchronize threaded interrupt handlers?
> > > Halil, do you think ccw needs to do anything? (AFAICS, we only have one
> > > 'irq' for channel devices anyway, and the handler just calls the
> > > relevant callbacks directly.)
> >
> > Sorry I don't understand enough yet. A more verbose documentation on
> > "virtio_synchronize_vqs - synchronize with virtqueue callbacks" would
> > surely benefit me. It may be more than enough for a back-belt but it
> > ain't enough for me to tell what is the callback supposed to accomplish.
> >
> > I will have to study this discussion and the code more thoroughly.
> > Tentatively I side with Jason and Michael in a sense, that I don't
> > believe virtio-ccw is safe against rough interrupts.

That's my feeling as well.

Thanks

> >
> > Sorry for the late response. I intend to revisit this on Monday. If
> > I don't please feel encouraged to ping.
> >
> > Regards,
> > Halil
>

