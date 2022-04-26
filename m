Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D59F1510227
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 17:47:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352514AbiDZPuf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 11:50:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348810AbiDZPuc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 11:50:32 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 261EEDAFC6
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 08:47:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650988043;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xQyfBAK470BkIe91eWxfV625DXXdxAqPEYmtJsl5GSo=;
        b=a4GxUQx5eU2ubxGuSchFVXEBZ8e8U4uPY9J5ZcPJduLMoYclsOaZzYi8jR/Ox0xmYfjJ7G
        2wfu6MKagYCAfx1vGufPsPwFbcTpTL00sgBFVP0RS5VQb7nUFgDdt0lOZJjG5uWtGmqecB
        G9UBXSpWaCt25slbXdinC8jXXa0kguo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-45-UrofruDkPvq1p7pf4e_o-Q-1; Tue, 26 Apr 2022 11:47:19 -0400
X-MC-Unique: UrofruDkPvq1p7pf4e_o-Q-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5AD258001EA;
        Tue, 26 Apr 2022 15:47:19 +0000 (UTC)
Received: from localhost (unknown [10.39.192.48])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0FD6B54F8A1;
        Tue, 26 Apr 2022 15:47:18 +0000 (UTC)
From:   Cornelia Huck <cohuck@redhat.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>
Cc:     Halil Pasic <pasic@linux.ibm.com>, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, sgarzare@redhat.com,
        eperezma@redhat.com, lulu@redhat.com, tglx@linutronix.de,
        peterz@infradead.org, paulmck@kernel.org, maz@kernel.org
Subject: Re: [PATCH V3 6/9] virtio-ccw: implement synchronize_cbs()
In-Reply-To: <20220425235415-mutt-send-email-mst@kernel.org>
Organization: Red Hat GmbH
References: <20220425024418.8415-1-jasowang@redhat.com>
 <20220425024418.8415-7-jasowang@redhat.com>
 <20220425040512-mutt-send-email-mst@kernel.org>
 <87a6c98rwf.fsf@redhat.com>
 <20220425095742-mutt-send-email-mst@kernel.org>
 <20220426042911.544477f9.pasic@linux.ibm.com>
 <20220425233434-mutt-send-email-mst@kernel.org>
 <20220425233604-mutt-send-email-mst@kernel.org>
 <ba0c3977-c471-3275-2327-c5910cdd506a@redhat.com>
 <20220425235134-mutt-send-email-mst@kernel.org>
 <20220425235415-mutt-send-email-mst@kernel.org>
User-Agent: Notmuch/0.34 (https://notmuchmail.org)
Date:   Tue, 26 Apr 2022 17:47:17 +0200
Message-ID: <87o80n7soq.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.9
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 25 2022, "Michael S. Tsirkin" <mst@redhat.com> wrote:

> On Mon, Apr 25, 2022 at 11:53:24PM -0400, Michael S. Tsirkin wrote:
>> On Tue, Apr 26, 2022 at 11:42:45AM +0800, Jason Wang wrote:
>> >=20
>> > =E5=9C=A8 2022/4/26 11:38, Michael S. Tsirkin =E5=86=99=E9=81=93:
>> > > On Mon, Apr 25, 2022 at 11:35:41PM -0400, Michael S. Tsirkin wrote:
>> > > > On Tue, Apr 26, 2022 at 04:29:11AM +0200, Halil Pasic wrote:
>> > > > > On Mon, 25 Apr 2022 09:59:55 -0400
>> > > > > "Michael S. Tsirkin" <mst@redhat.com> wrote:
>> > > > >=20
>> > > > > > On Mon, Apr 25, 2022 at 10:54:24AM +0200, Cornelia Huck wrote:
>> > > > > > > On Mon, Apr 25 2022, "Michael S. Tsirkin" <mst@redhat.com> w=
rote:
>> > > > > > > > On Mon, Apr 25, 2022 at 10:44:15AM +0800, Jason Wang wrote:
>> > > > > > > > > This patch tries to implement the synchronize_cbs() for =
ccw. For the
>> > > > > > > > > vring_interrupt() that is called via virtio_airq_handler=
(), the
>> > > > > > > > > synchronization is simply done via the airq_info's lock.=
 For the
>> > > > > > > > > vring_interrupt() that is called via virtio_ccw_int_hand=
ler(), a per
>> > > > > > > > > device spinlock for irq is introduced ans used in the sy=
nchronization
>> > > > > > > > > method.
>> > > > > > > > >=20
>> > > > > > > > > Cc: Thomas Gleixner <tglx@linutronix.de>
>> > > > > > > > > Cc: Peter Zijlstra <peterz@infradead.org>
>> > > > > > > > > Cc: "Paul E. McKenney" <paulmck@kernel.org>
>> > > > > > > > > Cc: Marc Zyngier <maz@kernel.org>
>> > > > > > > > > Cc: Halil Pasic <pasic@linux.ibm.com>
>> > > > > > > > > Cc: Cornelia Huck <cohuck@redhat.com>
>> > > > > > > > > Signed-off-by: Jason Wang <jasowang@redhat.com>
>> > > > > > > >=20
>> > > > > > > > This is the only one that is giving me pause. Halil, Corne=
lia,
>> > > > > > > > should we be concerned about the performance impact here?
>> > > > > > > > Any chance it can be tested?
>> > > > > > > We can have a bunch of devices using the same airq structure=
, and the
>> > > > > > > sync cb creates a choke point, same as registering/unregiste=
ring.
>> > > > > > BTW can callbacks for multiple VQs run on multiple CPUs at the=
 moment?
>> > > > > I'm not sure I understand the question.
>> > > > >=20
>> > > > > I do think we can have multiple CPUs that are executing some por=
tion of
>> > > > > virtio_ccw_int_handler(). So I guess the answer is yes. Connie w=
hat do you think?
>> > > > >=20
>> > > > > On the other hand we could also end up serializing synchronize_c=
bs()
>> > > > > calls for different devices if they happen to use the same airq_=
info. But
>> > > > > this probably was not your question
>> > > >=20
>> > > > I am less concerned about  synchronize_cbs being slow and more abo=
ut
>> > > > the slowdown in interrupt processing itself.
>> > > >=20
>> > > > > > this patch serializes them on a spinlock.
>> > > > > >=20
>> > > > > Those could then pile up on the newly introduced spinlock.

How bad would that be in practice? IIUC, we hit on the spinlock when
- doing synchronize_cbs (should be rare)
- processing queue interrupts for devices using per-device indicators
  (which is the non-preferred path, which I would basically only expect
  when running on an ancient or non-standard hypervisor)
- configuration change interrupts (should be rare)
- during setup, reset, etc. (should not be a concern)

>> > > > >=20
>> > > > > Regards,
>> > > > > Halil
>> > > > Hmm yea ... not good.
>> > > Is there any other way to synchronize with all callbacks?
>> >=20
>> >=20
>> > Maybe using rwlock as airq handler?
>> >=20
>> > Thanks
>> >=20
>>=20
>> rwlock is still a shared cacheline bouncing between CPUs and
>> a bunch of ordering instructions.
>> Maybe something per-cpu + some IPIs to run things on all CPUs instead?
>
> ... and I think classic and device interrupts are different enough
> here ...

You mean classic (per-device) and adapter interrupts, right?

