Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97F114FF005
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 08:42:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231419AbiDMGoF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 02:44:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231899AbiDMGoD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 02:44:03 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8B8B72B27D
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 23:41:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649832102;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=f/G4+V/2r9lJkom+e8pScX/b0FmMM9Qy+8u3OkZBVmQ=;
        b=JXOocOchT3ls61xRiUkwFIt45KauvA1S+famIbxU/vCAT1/qmtSWI3cikUKJPS/NdYMUFG
        zOgJadzgo7/RDYslG8aTI3hjyCx3c2kabxEo/4T5GIU9Y2uCtnal8xh2VX3i5MGCmCo2zt
        aViVbvNBO0rLN09yMqQm/sx8YUMaHss=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-551-6cM1yx9tMj6dMc1NTxRJhg-1; Wed, 13 Apr 2022 02:41:41 -0400
X-MC-Unique: 6cM1yx9tMj6dMc1NTxRJhg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DCC3385A5BE;
        Wed, 13 Apr 2022 06:41:40 +0000 (UTC)
Received: from localhost (dhcp-192-194.str.redhat.com [10.33.192.194])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 902112166B4F;
        Wed, 13 Apr 2022 06:41:26 +0000 (UTC)
From:   Cornelia Huck <cohuck@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     Halil Pasic <pasic@linux.ibm.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Marc Zyngier <maz@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        virtualization <virtualization@lists.linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH V2 4/5] virtio-pci: implement synchronize_vqs()
In-Reply-To: <CACGkMEuUXAUK-8GnBWgij5TOSN0ct_gmxnDQEcovRmTLK6bv4w@mail.gmail.com>
Organization: Red Hat GmbH
References: <20220406083538.16274-1-jasowang@redhat.com>
 <20220406083538.16274-5-jasowang@redhat.com>
 <20220406075952-mutt-send-email-mst@kernel.org>
 <87wng2e527.fsf@redhat.com> <20220408150307.24b6b99f.pasic@linux.ibm.com>
 <20220410034556-mutt-send-email-mst@kernel.org>
 <CACGkMEtarZb6g3ij5=+As17+d9jtdAqNa1EzSuTXc7Pq_som0Q@mail.gmail.com>
 <877d7vbspu.fsf@redhat.com> <20220412020145.32e26e5a.pasic@linux.ibm.com>
 <87r1629rio.fsf@redhat.com>
 <CACGkMEuUXAUK-8GnBWgij5TOSN0ct_gmxnDQEcovRmTLK6bv4w@mail.gmail.com>
User-Agent: Notmuch/0.34 (https://notmuchmail.org)
Date:   Wed, 13 Apr 2022 08:41:25 +0200
Message-ID: <87o815a3je.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 13 2022, Jason Wang <jasowang@redhat.com> wrote:

> On Wed, Apr 13, 2022 at 12:49 AM Cornelia Huck <cohuck@redhat.com> wrote:
>>
>> On Tue, Apr 12 2022, Halil Pasic <pasic@linux.ibm.com> wrote:
>>
>> > On Mon, 11 Apr 2022 16:27:41 +0200
>> > Cornelia Huck <cohuck@redhat.com> wrote:
>>
>> >> My main concern is that we would need to synchronize against a single
>> >> interrupt that covers all kinds of I/O interrupts, not just a single
>> >> device...
>> >>
>> >
>> > Could we synchronize on struct airq_info's lock member? If we were
>> > to grab all of these that might be involved...
>>
>> Hm, that could possibly narrow the sync down to a subset, which seems
>> better. For devices still using classic interrupts, per-device sync
>> would be easy.
>>
>> >
>> > AFAIU for the synchronize implementation we need a lock or a set of locks
>> > that contain all the possible vring_interrupt() calls with the queuues
>> > that belong to the given device as a critical section. That way, one
>> > has the acquire's and release's in place so that the vrign_interrupt()
>> > either guaranteed to finish before the change of driver_ready is
>> > guaranteed to be complete, or it is guaranteed to see the change.
>> >
>> > In any case, I guess we should first get clear on the first part. I.e.
>> > when do we want to allow host->guest notifications.
>>
>> Also, whether we just care about vring interrupts, or general device
>> interrupts (not sure if a config change interrupt may also trigger
>> things we do not want to trigger?)
>
> I think only vring interrupts, since the config interrupt hardening is
> done via 22b7050a024d7 ("virtio: defer config changed notifications")

Ah thanks, I even reviewed that one back then :)

