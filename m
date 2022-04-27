Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72061511581
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 13:33:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231997AbiD0LCI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 07:02:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231977AbiD0LBo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 07:01:44 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8AF853E1901
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 03:40:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651056002;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5qGWMCBS7P4p9HHcQpZOrDgCGlZCMIEG3/HVfnBnSLI=;
        b=gqfmbRLDUiVwqusoVkWEMt9P1P6/eDF+wp8rqaiJz1fmwtH+ER6mJZTJVRLtQ6RlIL3Vnz
        wE2SbPm55aZWmJcvMReaBMCuDV1vSw5k460vxlQTsSQcY5HFo+RVQFfKCEJ91OO4Ql7oyw
        KOPsBAHYVM0tSMqA0G5dlj+1JEqNsv8=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-606-T24G6uPfO7OewlqHwZ9_pA-1; Wed, 27 Apr 2022 05:27:05 -0400
X-MC-Unique: T24G6uPfO7OewlqHwZ9_pA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EC1722999B53;
        Wed, 27 Apr 2022 09:27:04 +0000 (UTC)
Received: from localhost (dhcp-192-194.str.redhat.com [10.33.192.194])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id AD406C44AE9;
        Wed, 27 Apr 2022 09:27:04 +0000 (UTC)
From:   Cornelia Huck <cohuck@redhat.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Jason Wang <jasowang@redhat.com>,
        Halil Pasic <pasic@linux.ibm.com>,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, sgarzare@redhat.com,
        eperezma@redhat.com, lulu@redhat.com, tglx@linutronix.de,
        peterz@infradead.org, paulmck@kernel.org, maz@kernel.org
Subject: Re: [PATCH V3 6/9] virtio-ccw: implement synchronize_cbs()
In-Reply-To: <20220426124243-mutt-send-email-mst@kernel.org>
Organization: Red Hat GmbH
References: <20220425040512-mutt-send-email-mst@kernel.org>
 <87a6c98rwf.fsf@redhat.com>
 <20220425095742-mutt-send-email-mst@kernel.org>
 <20220426042911.544477f9.pasic@linux.ibm.com>
 <20220425233434-mutt-send-email-mst@kernel.org>
 <20220425233604-mutt-send-email-mst@kernel.org>
 <ba0c3977-c471-3275-2327-c5910cdd506a@redhat.com>
 <20220425235134-mutt-send-email-mst@kernel.org>
 <20220425235415-mutt-send-email-mst@kernel.org>
 <87o80n7soq.fsf@redhat.com>
 <20220426124243-mutt-send-email-mst@kernel.org>
User-Agent: Notmuch/0.34 (https://notmuchmail.org)
Date:   Wed, 27 Apr 2022 11:27:03 +0200
Message-ID: <87ilqu7u6w.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.8
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 26 2022, "Michael S. Tsirkin" <mst@redhat.com> wrote:

> On Tue, Apr 26, 2022 at 05:47:17PM +0200, Cornelia Huck wrote:
>> On Mon, Apr 25 2022, "Michael S. Tsirkin" <mst@redhat.com> wrote:
>>=20
>> > On Mon, Apr 25, 2022 at 11:53:24PM -0400, Michael S. Tsirkin wrote:
>> >> On Tue, Apr 26, 2022 at 11:42:45AM +0800, Jason Wang wrote:
>> >> >=20
>> >> > =E5=9C=A8 2022/4/26 11:38, Michael S. Tsirkin =E5=86=99=E9=81=93:
>> >> > > On Mon, Apr 25, 2022 at 11:35:41PM -0400, Michael S. Tsirkin wrot=
e:
>> >> > > > On Tue, Apr 26, 2022 at 04:29:11AM +0200, Halil Pasic wrote:
>> >> > > > > On Mon, 25 Apr 2022 09:59:55 -0400
>> >> > > > > "Michael S. Tsirkin" <mst@redhat.com> wrote:
>> >> > > > >=20
>> >> > > > > > On Mon, Apr 25, 2022 at 10:54:24AM +0200, Cornelia Huck wro=
te:
>> >> > > > > > > On Mon, Apr 25 2022, "Michael S. Tsirkin" <mst@redhat.com=
> wrote:
>> >> > > > > > > > On Mon, Apr 25, 2022 at 10:44:15AM +0800, Jason Wang wr=
ote:
>> >> > > > > > > > > This patch tries to implement the synchronize_cbs() f=
or ccw. For the
>> >> > > > > > > > > vring_interrupt() that is called via virtio_airq_hand=
ler(), the
>> >> > > > > > > > > synchronization is simply done via the airq_info's lo=
ck. For the
>> >> > > > > > > > > vring_interrupt() that is called via virtio_ccw_int_h=
andler(), a per
>> >> > > > > > > > > device spinlock for irq is introduced ans used in the=
 synchronization
>> >> > > > > > > > > method.
>> >> > > > > > > > >=20
>> >> > > > > > > > > Cc: Thomas Gleixner <tglx@linutronix.de>
>> >> > > > > > > > > Cc: Peter Zijlstra <peterz@infradead.org>
>> >> > > > > > > > > Cc: "Paul E. McKenney" <paulmck@kernel.org>
>> >> > > > > > > > > Cc: Marc Zyngier <maz@kernel.org>
>> >> > > > > > > > > Cc: Halil Pasic <pasic@linux.ibm.com>
>> >> > > > > > > > > Cc: Cornelia Huck <cohuck@redhat.com>
>> >> > > > > > > > > Signed-off-by: Jason Wang <jasowang@redhat.com>
>> >> > > > > > > >=20
>> >> > > > > > > > This is the only one that is giving me pause. Halil, Co=
rnelia,
>> >> > > > > > > > should we be concerned about the performance impact her=
e?
>> >> > > > > > > > Any chance it can be tested?
>> >> > > > > > > We can have a bunch of devices using the same airq struct=
ure, and the
>> >> > > > > > > sync cb creates a choke point, same as registering/unregi=
stering.
>> >> > > > > > BTW can callbacks for multiple VQs run on multiple CPUs at =
the moment?
>> >> > > > > I'm not sure I understand the question.
>> >> > > > >=20
>> >> > > > > I do think we can have multiple CPUs that are executing some =
portion of
>> >> > > > > virtio_ccw_int_handler(). So I guess the answer is yes. Conni=
e what do you think?
>> >> > > > >=20
>> >> > > > > On the other hand we could also end up serializing synchroniz=
e_cbs()
>> >> > > > > calls for different devices if they happen to use the same ai=
rq_info. But
>> >> > > > > this probably was not your question
>> >> > > >=20
>> >> > > > I am less concerned about  synchronize_cbs being slow and more =
about
>> >> > > > the slowdown in interrupt processing itself.
>> >> > > >=20
>> >> > > > > > this patch serializes them on a spinlock.
>> >> > > > > >=20
>> >> > > > > Those could then pile up on the newly introduced spinlock.
>>=20
>> How bad would that be in practice? IIUC, we hit on the spinlock when
>> - doing synchronize_cbs (should be rare)
>> - processing queue interrupts for devices using per-device indicators
>>   (which is the non-preferred path, which I would basically only expect
>>   when running on an ancient or non-standard hypervisor)
>
> this one is my concern. I am worried serializing everything on a single l=
ock
> will drastically regress performance here.

Yeah, that case could get much worse. OTOH, how likely is it that any
setup that runs a recent kernel will actually end up with devices using
per-device indicators? Anything running under a QEMU released in the
last couple of years is unlikely to not use airqs, I think. Halil, do
you think that the classic indicator setup would be more common on any
non-QEMU hypervisors?

IOW, how much effort is it worth spending on optimizing this case? We
certainly should explore any simple solutions, but I don't think we need
to twist ourselves into pretzels to solve it.

>
>
>> - configuration change interrupts (should be rare)
>> - during setup, reset, etc. (should not be a concern)

