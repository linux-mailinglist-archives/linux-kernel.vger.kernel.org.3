Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8419A522E0E
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 10:17:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241540AbiEKIRe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 04:17:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbiEKIRc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 04:17:32 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 931EF3FBCB
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 01:17:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652257048;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0WhNG2BFNpm3DlKnvpsKok4cmCLeGV6XphB375cBO7U=;
        b=VGRPrHzB9zM1+Gsk9omPkYIV0xG2XTHx5n5kgEPAN+St1ULf8QdMbOLwsuDeuh1l0vsz2h
        aTHwDAvMnH3bD3yJTU58bY9pIQc51aQSfxvj6k/w0VXSY7zvzyBxQFlsgqclUy9C6tQt/M
        emBn3P9eFahkvss5q09OFiU9QC9plLc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-362-naHtCBJcPk6b1wVTF8gDJg-1; Wed, 11 May 2022 04:17:25 -0400
X-MC-Unique: naHtCBJcPk6b1wVTF8gDJg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 05E3D185A794;
        Wed, 11 May 2022 08:17:25 +0000 (UTC)
Received: from localhost (unknown [10.39.193.115])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 73F97145BF03;
        Wed, 11 May 2022 08:17:24 +0000 (UTC)
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
Subject: Re: [PATCH V4 6/9] virtio-ccw: implement synchronize_cbs()
In-Reply-To: <CACGkMEvWFyEqeeXYEmbU4TWtnj9Ku6J7jLK_7MueuFvpR7FiGg@mail.gmail.com>
Organization: Red Hat GmbH
References: <20220507071954.14455-1-jasowang@redhat.com>
 <20220507071954.14455-7-jasowang@redhat.com>
 <20220510072451-mutt-send-email-mst@kernel.org>
 <CACGkMEvWFyEqeeXYEmbU4TWtnj9Ku6J7jLK_7MueuFvpR7FiGg@mail.gmail.com>
User-Agent: Notmuch/0.34 (https://notmuchmail.org)
Date:   Wed, 11 May 2022 10:17:22 +0200
Message-ID: <87r150bi0d.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.7
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

> On Tue, May 10, 2022 at 7:28 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>>
>> On Sat, May 07, 2022 at 03:19:51PM +0800, Jason Wang wrote:
>> > @@ -1106,6 +1130,7 @@ static void virtio_ccw_int_handler(struct ccw_device *cdev,
>> >                       vcdev->err = -EIO;
>> >       }
>> >       virtio_ccw_check_activity(vcdev, activity);
>> > +     read_lock_irqsave(&vcdev->irq_lock, flags);
>> >       for_each_set_bit(i, indicators(vcdev),
>> >                        sizeof(*indicators(vcdev)) * BITS_PER_BYTE) {
>> >               /* The bit clear must happen before the vring kick. */
>>
>> Cornelia sent a lockdep trace on this.
>>
>> Basically I think this gets the irqsave/restore logic wrong.
>> It attempts to disable irqs in the handler (which is an interrupt
>> anyway).
>
> The reason I use irqsave/restore is that it can be called from process
> context (if I was not wrong), e.g from io_subchannel_quiesce().

io_subchannel_quiesce() should disable interrupts, though? Otherwise, it
would be a bug.

