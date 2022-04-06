Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D0344F6393
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 17:48:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236687AbiDFPtT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 11:49:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236856AbiDFPru (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 11:47:50 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 38BDF3919E7
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 06:05:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649250300;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WSZMUg62M/bE0Jpk+nJJkdqRfcMAUEwvNHLM7s1fLUM=;
        b=f/9Nn0/2k67CCKhL7IA/vTimDJUIowESzoDDXeRYgYWm65Ch3PHSmUcKwqmr2psLBBTJlA
        FaX2gfQgkWlPfGwTBXgzbgNfWBjgB5GJhshhWY677uP7W2fYx6KKm+eROL1/tY5QNj+3l9
        5mEq//DpY9pcbSu0Jt7+NFGITYMhWVU=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-546-DqkpcBGmNWm0dX4eUzXhdA-1; Wed, 06 Apr 2022 09:04:56 -0400
X-MC-Unique: DqkpcBGmNWm0dX4eUzXhdA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4C51F28092CC;
        Wed,  6 Apr 2022 13:04:56 +0000 (UTC)
Received: from localhost (dhcp-192-213.str.redhat.com [10.33.192.213])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0C373141513E;
        Wed,  6 Apr 2022 13:04:33 +0000 (UTC)
From:   Cornelia Huck <cohuck@redhat.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, peterz@infradead.org,
        maz@kernel.org, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, tglx@linutronix.de,
        Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [PATCH V2 4/5] virtio-pci: implement synchronize_vqs()
In-Reply-To: <20220406075952-mutt-send-email-mst@kernel.org>
Organization: Red Hat GmbH
References: <20220406083538.16274-1-jasowang@redhat.com>
 <20220406083538.16274-5-jasowang@redhat.com>
 <20220406075952-mutt-send-email-mst@kernel.org>
User-Agent: Notmuch/0.34 (https://notmuchmail.org)
Date:   Wed, 06 Apr 2022 15:04:32 +0200
Message-ID: <87wng2e527.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.7
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 06 2022, "Michael S. Tsirkin" <mst@redhat.com> wrote:

> On Wed, Apr 06, 2022 at 04:35:37PM +0800, Jason Wang wrote:
>> This patch implements PCI version of synchronize_vqs().
>> 
>> Cc: Thomas Gleixner <tglx@linutronix.de>
>> Cc: Peter Zijlstra <peterz@infradead.org>
>> Cc: "Paul E. McKenney" <paulmck@kernel.org>
>> Cc: Marc Zyngier <maz@kernel.org>
>> Signed-off-by: Jason Wang <jasowang@redhat.com>
>
> Please add implementations at least for ccw and mmio.

I'm not sure what (if anything) can/should be done for ccw...

>
>> ---
>>  drivers/virtio/virtio_pci_common.c | 14 ++++++++++++++
>>  drivers/virtio/virtio_pci_common.h |  2 ++
>>  drivers/virtio/virtio_pci_legacy.c |  1 +
>>  drivers/virtio/virtio_pci_modern.c |  2 ++
>>  4 files changed, 19 insertions(+)
>> 
>> diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_pci_common.c
>> index d724f676608b..b78c8bc93a97 100644
>> --- a/drivers/virtio/virtio_pci_common.c
>> +++ b/drivers/virtio/virtio_pci_common.c
>> @@ -37,6 +37,20 @@ void vp_synchronize_vectors(struct virtio_device *vdev)
>>  		synchronize_irq(pci_irq_vector(vp_dev->pci_dev, i));
>>  }
>>  
>> +void vp_synchronize_vqs(struct virtio_device *vdev)
>> +{
>> +	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
>> +	int i;
>> +
>> +	if (vp_dev->intx_enabled) {
>> +		synchronize_irq(vp_dev->pci_dev->irq);
>> +		return;
>> +	}
>> +
>> +	for (i = 0; i < vp_dev->msix_vectors; ++i)
>> +		synchronize_irq(pci_irq_vector(vp_dev->pci_dev, i));
>> +}
>> +

...given that this seems to synchronize threaded interrupt handlers?
Halil, do you think ccw needs to do anything? (AFAICS, we only have one
'irq' for channel devices anyway, and the handler just calls the
relevant callbacks directly.)

>>  /* the notify function used when creating a virt queue */
>>  bool vp_notify(struct virtqueue *vq)
>>  {

