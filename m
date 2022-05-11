Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 412D1522EA5
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 10:44:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243851AbiEKIom (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 04:44:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243938AbiEKIog (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 04:44:36 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A7B6D200F7D
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 01:44:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652258670;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6XAsQFnhrZpWvc7RJwu2raTQ/L5Wv/W+iz3iayoq1a0=;
        b=REf+YWLnEYGIUST6v3wPpiAawhX0i6ZLI0l9KpTQc9tVDcd7A/hGiBq8Qy0ZoKupbNQK3/
        9ajiu84pRVB1gkO3xGY1Ai9ppbQknGfOmfAstM3UYZ1gl+awqdzzpGPGNGrpWLzBNL6464
        WtLD+o7TvDDRLudT4p2oY/f4MzTht90=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-669-NMVowrerMIai6WqcNK0bPA-1; Wed, 11 May 2022 04:44:27 -0400
X-MC-Unique: NMVowrerMIai6WqcNK0bPA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B2059801210;
        Wed, 11 May 2022 08:44:26 +0000 (UTC)
Received: from localhost (unknown [10.39.193.115])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1A9827AD9;
        Wed, 11 May 2022 08:44:15 +0000 (UTC)
From:   Cornelia Huck <cohuck@redhat.com>
To:     Jason Wang <jasowang@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>
Cc:     virtualization <virtualization@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        Halil Pasic <pasic@linux.ibm.com>,
        eperezma <eperezma@redhat.com>, Cindy Lu <lulu@redhat.com>,
        Stefano Garzarella <sgarzare@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH V4 8/9] virtio: harden vring IRQ
In-Reply-To: <CACGkMEtBfdhx-9CMKD0F4+536e5ewf6NQJGPTEBX00uby-C8+w@mail.gmail.com>
Organization: Red Hat GmbH
References: <20220507071954.14455-1-jasowang@redhat.com>
 <20220507071954.14455-9-jasowang@redhat.com>
 <20220510072833-mutt-send-email-mst@kernel.org>
 <CACGkMEtBfdhx-9CMKD0F4+536e5ewf6NQJGPTEBX00uby-C8+w@mail.gmail.com>
User-Agent: Notmuch/0.34 (https://notmuchmail.org)
Date:   Wed, 11 May 2022 10:44:14 +0200
Message-ID: <87o804bgrl.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 11 2022, Jason Wang <jasowang@redhat.com> wrote:

> On Tue, May 10, 2022 at 7:32 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>>
>> On Sat, May 07, 2022 at 03:19:53PM +0800, Jason Wang wrote:
>> > diff --git a/include/linux/virtio_config.h b/include/linux/virtio_config.h
>> > index d8a2340f928e..23f1694cdbd5 100644
>> > --- a/include/linux/virtio_config.h
>> > +++ b/include/linux/virtio_config.h
>> > @@ -256,6 +256,18 @@ void virtio_device_ready(struct virtio_device *dev)
>> >       unsigned status = dev->config->get_status(dev);
>> >
>> >       BUG_ON(status & VIRTIO_CONFIG_S_DRIVER_OK);
>> > +
>> > +     /*
>> > +      * The virtio_synchronize_cbs() makes sure vring_interrupt()
>> > +      * will see the driver specific setup if it sees vq->broken
>> > +      * as false.
>> > +      */
>> > +     virtio_synchronize_cbs(dev);
>>
>> since you mention vq->broken above, maybe add
>>         "set vq->broken to false"
>
> Ok.
>
>>
>> > +     __virtio_unbreak_device(dev);
>> > +     /*
>> > +      * The transport is expected ensure the visibility of
>>
>> to ensure
>
> Will fix.
>
>>
>> > +      * vq->broken
>>
>> let's add: "visibility by vq callbacks"
>
> Sure.
>
>>
>> > before setting VIRTIO_CONFIG_S_DRIVER_OK.
>> > +      */
>>
>>
>> Can I see some analysis of existing transports showing
>> this is actually the case for them?
>
> Yes.
>
>> And maybe add a comment near set_status to document the
>> requirement.
>
> For PCI and MMIO, we can quote the memory-barriers.txt or explain that
> wmb() is not needed before the MMIO writel().
> For CCW, it looks not obvious, it looks to me the IO was submitted via
> __ssch() which has an inline assembly.  Cornelia and Hali, could you
> help me to understand if and how did virtio_ccw_set_status() can
> ensure the visibility of the previous driver setup and vq->broken
> here?

I'm not sure I completely understand the question here, but let me try:

virtio_ccw_set_status() uses a channel command to set the status, with
the interesting stuff done inside ccw_io_helper(). That function
- takes the subchannel lock, disabling interrupts
- does the ssch; this instruction will fail if there's already another
  I/O in progress, or an interrupt is pending for the subchannel; on
  success, it is guaranteed that we'll get an interrupt eventually
- unlock the subchannel, and wait for the interupt handler to eventually
  process the interrupt, so I guess it should see the vq->broken value?

If the I/O fails, virtio_ccw_set_status() will revert its internal
status to the old value.


>
> Thanks
>
>>
>> >       dev->config->set_status(dev, status | VIRTIO_CONFIG_S_DRIVER_OK);
>> >  }

