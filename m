Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7BDD4F783D
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 09:53:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242339AbiDGHze (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 03:55:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242301AbiDGHzd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 03:55:33 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F04691D7617
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 00:53:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649318013;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=V4oTU89iic44RnYmDXqYjpUYABah6cp5s63eYF96vUY=;
        b=eTiK/5Ci4TcFyEoto6OkdVzrXitJH0yOwi+xewpJ5ACXqoVpFCukvo3wIY0p+gqq9vkXbX
        U+WweFstJx7qSxinsmEyhRkW487yvBxDd93mL1GFw0z1u73+VYKJw3kKSFcVshazFyRjmm
        FrCAqjcRgt8oLHrZpiHnM1x8brIGwok=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-497-S4TBySX0NsuWn9mNFbRhJA-1; Thu, 07 Apr 2022 03:53:22 -0400
X-MC-Unique: S4TBySX0NsuWn9mNFbRhJA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 55D733C13948;
        Thu,  7 Apr 2022 07:53:16 +0000 (UTC)
Received: from localhost (unknown [10.39.193.222])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7D977C28111;
        Thu,  7 Apr 2022 07:53:02 +0000 (UTC)
From:   Cornelia Huck <cohuck@redhat.com>
To:     Jason Wang <jasowang@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, peterz@infradead.org,
        maz@kernel.org, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, tglx@linutronix.de,
        Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [PATCH V2 4/5] virtio-pci: implement synchronize_vqs()
In-Reply-To: <7e99abbf-f68d-4aa5-71b6-9d1d71b2d25b@redhat.com>
Organization: Red Hat GmbH
References: <20220406083538.16274-1-jasowang@redhat.com>
 <20220406083538.16274-5-jasowang@redhat.com>
 <20220406075952-mutt-send-email-mst@kernel.org>
 <87wng2e527.fsf@redhat.com>
 <20220406112858-mutt-send-email-mst@kernel.org>
 <7e99abbf-f68d-4aa5-71b6-9d1d71b2d25b@redhat.com>
User-Agent: Notmuch/0.34 (https://notmuchmail.org)
Date:   Thu, 07 Apr 2022 09:52:59 +0200
Message-ID: <87r169ba90.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.8
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 07 2022, Jason Wang <jasowang@redhat.com> wrote:

> =E5=9C=A8 2022/4/6 =E4=B8=8B=E5=8D=8811:31, Michael S. Tsirkin =E5=86=99=
=E9=81=93:
>> On Wed, Apr 06, 2022 at 03:04:32PM +0200, Cornelia Huck wrote:
>>> On Wed, Apr 06 2022, "Michael S. Tsirkin" <mst@redhat.com> wrote:
>>>
>>>> On Wed, Apr 06, 2022 at 04:35:37PM +0800, Jason Wang wrote:
>>>>> This patch implements PCI version of synchronize_vqs().
>>>>>
>>>>> Cc: Thomas Gleixner <tglx@linutronix.de>
>>>>> Cc: Peter Zijlstra <peterz@infradead.org>
>>>>> Cc: "Paul E. McKenney" <paulmck@kernel.org>
>>>>> Cc: Marc Zyngier <maz@kernel.org>
>>>>> Signed-off-by: Jason Wang <jasowang@redhat.com>
>>>> Please add implementations at least for ccw and mmio.
>>> I'm not sure what (if anything) can/should be done for ccw...
>>>
>>>>> ---
>>>>>   drivers/virtio/virtio_pci_common.c | 14 ++++++++++++++
>>>>>   drivers/virtio/virtio_pci_common.h |  2 ++
>>>>>   drivers/virtio/virtio_pci_legacy.c |  1 +
>>>>>   drivers/virtio/virtio_pci_modern.c |  2 ++
>>>>>   4 files changed, 19 insertions(+)
>>>>>
>>>>> diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virt=
io_pci_common.c
>>>>> index d724f676608b..b78c8bc93a97 100644
>>>>> --- a/drivers/virtio/virtio_pci_common.c
>>>>> +++ b/drivers/virtio/virtio_pci_common.c
>>>>> @@ -37,6 +37,20 @@ void vp_synchronize_vectors(struct virtio_device *=
vdev)
>>>>>   		synchronize_irq(pci_irq_vector(vp_dev->pci_dev, i));
>>>>>   }
>>>>>=20=20=20
>>>>> +void vp_synchronize_vqs(struct virtio_device *vdev)
>>>>> +{
>>>>> +	struct virtio_pci_device *vp_dev =3D to_vp_device(vdev);
>>>>> +	int i;
>>>>> +
>>>>> +	if (vp_dev->intx_enabled) {
>>>>> +		synchronize_irq(vp_dev->pci_dev->irq);
>>>>> +		return;
>>>>> +	}
>>>>> +
>>>>> +	for (i =3D 0; i < vp_dev->msix_vectors; ++i)
>>>>> +		synchronize_irq(pci_irq_vector(vp_dev->pci_dev, i));
>>>>> +}
>>>>> +
>>> ...given that this seems to synchronize threaded interrupt handlers?
>> No, any handlers at all. The point is to make sure any memory changes
>> made prior to this op are visible to callbacks.
>>
>> Jason, maybe add that to the documentation?
>
>
> Sure.
>
>
>>
>>> Halil, do you think ccw needs to do anything? (AFAICS, we only have one
>>> 'irq' for channel devices anyway, and the handler just calls the
>>> relevant callbacks directly.)
>> Then you need to synchronize with that.
>
>
> Have a quick glance at the codes, it looks to me we can synchronize with=
=20
> the IO_INTERRUPT. (Assuming all callbacks are triggered via=20
> ccw_device_irq()).

Not quite, adapter interrupts are device-independent, but they are
relevant for vring interrupts.

That would mean that we would need to synchronize _all_ channel I/O
interrupts, which looks like a huge hammer. But do we really need that
at all?

The last patch in this series seems to be concerned with the "no vring
interrupts if the device is not ready" case, so it needs to synchronize
vring interrupts with device reset and setting the device status to
ready. For virtio-ccw, both reset and setting the status are channel I/O
operations, i.e. starting a program and waiting for the final device
interrupt for it, so synchronization (on a device level) is already
happening in a way. So I'm not sure if any extra synchronization is
actually needed in this case, but maybe I'm misunderstanding.

Do you have further use cases in mind?

