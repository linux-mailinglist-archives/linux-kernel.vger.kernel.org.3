Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 457D14FBF12
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 16:27:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347020AbiDKOaF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 10:30:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234393AbiDKOaC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 10:30:02 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C88543AA41
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 07:27:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649687266;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=poochtT5KCNLtLMccfGFFZ6+lU1Fq36QTZuOmgK85Qk=;
        b=avH0sVRZrFkrO456qdN71yyHBRLtjBFk03Cgas7/FF0xEqvu9K51IGu76kPyoNLaafyNcF
        DOS4Pl+ptfQQebM/OafBwIVrTdGqAXrzVzR5qNPgYmGlcBYuSzoxQrsCxaB7GgAcYAm/1p
        aa1kMPALha5gvroAEv7M1544PD9G0gk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-471-mQVmn2w7M2SjT4sjSk58iw-1; Mon, 11 Apr 2022 10:27:43 -0400
X-MC-Unique: mQVmn2w7M2SjT4sjSk58iw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E8EDF85A5A8;
        Mon, 11 Apr 2022 14:27:42 +0000 (UTC)
Received: from localhost (unknown [10.39.193.127])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 74CCA48FB19;
        Mon, 11 Apr 2022 14:27:42 +0000 (UTC)
From:   Cornelia Huck <cohuck@redhat.com>
To:     Jason Wang <jasowang@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Halil Pasic <pasic@linux.ibm.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Marc Zyngier <maz@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        virtualization <virtualization@lists.linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH V2 4/5] virtio-pci: implement synchronize_vqs()
In-Reply-To: <CACGkMEtarZb6g3ij5=+As17+d9jtdAqNa1EzSuTXc7Pq_som0Q@mail.gmail.com>
Organization: Red Hat GmbH
References: <20220406083538.16274-1-jasowang@redhat.com>
 <20220406083538.16274-5-jasowang@redhat.com>
 <20220406075952-mutt-send-email-mst@kernel.org>
 <87wng2e527.fsf@redhat.com> <20220408150307.24b6b99f.pasic@linux.ibm.com>
 <20220410034556-mutt-send-email-mst@kernel.org>
 <CACGkMEtarZb6g3ij5=+As17+d9jtdAqNa1EzSuTXc7Pq_som0Q@mail.gmail.com>
User-Agent: Notmuch/0.34 (https://notmuchmail.org)
Date:   Mon, 11 Apr 2022 16:27:41 +0200
Message-ID: <877d7vbspu.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.9
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 11 2022, Jason Wang <jasowang@redhat.com> wrote:

> On Sun, Apr 10, 2022 at 3:51 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>>
>> On Fri, Apr 08, 2022 at 03:03:07PM +0200, Halil Pasic wrote:
>> > On Wed, 06 Apr 2022 15:04:32 +0200
>> > Cornelia Huck <cohuck@redhat.com> wrote:
>> >
>> > > On Wed, Apr 06 2022, "Michael S. Tsirkin" <mst@redhat.com> wrote:
>> > >
>> > > > On Wed, Apr 06, 2022 at 04:35:37PM +0800, Jason Wang wrote:
>> > > >> This patch implements PCI version of synchronize_vqs().
>> > > >>
>> > > >> Cc: Thomas Gleixner <tglx@linutronix.de>
>> > > >> Cc: Peter Zijlstra <peterz@infradead.org>
>> > > >> Cc: "Paul E. McKenney" <paulmck@kernel.org>
>> > > >> Cc: Marc Zyngier <maz@kernel.org>
>> > > >> Signed-off-by: Jason Wang <jasowang@redhat.com>
>> > > >
>> > > > Please add implementations at least for ccw and mmio.
>> > >
>> > > I'm not sure what (if anything) can/should be done for ccw...
>> >
>> > If nothing needs to be done I would like to have at least a comment in
>> > the code that explains why. So that somebody who reads the code
>> > doesn't wonder: why is virtio-ccw not implementing that callback.
>>
>> Right.
>>
>> I am currently thinking instead of making this optional in the
>> core we should make it mandatory, and have transports which do not
>> need to sync have an empty stub with documentation explaining why.

Yes, that makes sense to me. If we can explain why we don't need to do
anything, we should keep that explanation easily accessible.

>>
>> Also, do we want to document this sync is explicitly for irq enable/disable?
>> synchronize_irq_enable_disable?
>
> I would not since the transport is not guaranteed to use an interrupt
> for callbacks.
>
>>
>>
>> > >
>> > > >
>> > > >> ---
>> > > >>  drivers/virtio/virtio_pci_common.c | 14 ++++++++++++++
>> > > >>  drivers/virtio/virtio_pci_common.h |  2 ++
>> > > >>  drivers/virtio/virtio_pci_legacy.c |  1 +
>> > > >>  drivers/virtio/virtio_pci_modern.c |  2 ++
>> > > >>  4 files changed, 19 insertions(+)
>> > > >>
>> > > >> diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_pci_common.c
>> > > >> index d724f676608b..b78c8bc93a97 100644
>> > > >> --- a/drivers/virtio/virtio_pci_common.c
>> > > >> +++ b/drivers/virtio/virtio_pci_common.c
>> > > >> @@ -37,6 +37,20 @@ void vp_synchronize_vectors(struct virtio_device *vdev)
>> > > >>                  synchronize_irq(pci_irq_vector(vp_dev->pci_dev, i));
>> > > >>  }
>> > > >>
>> > > >> +void vp_synchronize_vqs(struct virtio_device *vdev)
>> > > >> +{
>> > > >> +        struct virtio_pci_device *vp_dev = to_vp_device(vdev);
>> > > >> +        int i;
>> > > >> +
>> > > >> +        if (vp_dev->intx_enabled) {
>> > > >> +                synchronize_irq(vp_dev->pci_dev->irq);
>> > > >> +                return;
>> > > >> +        }
>> > > >> +
>> > > >> +        for (i = 0; i < vp_dev->msix_vectors; ++i)
>> > > >> +                synchronize_irq(pci_irq_vector(vp_dev->pci_dev, i));
>> > > >> +}
>> > > >> +
>> > >
>> > > ...given that this seems to synchronize threaded interrupt handlers?
>> > > Halil, do you think ccw needs to do anything? (AFAICS, we only have one
>> > > 'irq' for channel devices anyway, and the handler just calls the
>> > > relevant callbacks directly.)
>> >
>> > Sorry I don't understand enough yet. A more verbose documentation on
>> > "virtio_synchronize_vqs - synchronize with virtqueue callbacks" would
>> > surely benefit me. It may be more than enough for a back-belt but it
>> > ain't enough for me to tell what is the callback supposed to accomplish.

+1 for more explanations.

>> >
>> > I will have to study this discussion and the code more thoroughly.
>> > Tentatively I side with Jason and Michael in a sense, that I don't
>> > believe virtio-ccw is safe against rough interrupts.
>
> That's my feeling as well.

I'd say ccw is safe against "notification interrupts before indicators
have been registered". For the reverse case, maybe we should always
invalidate the indicators in the reset case? More information regarding
the attack vector would help here :)

My main concern is that we would need to synchronize against a single
interrupt that covers all kinds of I/O interrupts, not just a single
device...

