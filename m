Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1D645129C5
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 05:05:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241801AbiD1DIO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 23:08:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240958AbiD1DIK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 23:08:10 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 08939255A9
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 20:04:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651115096;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OgA3nNFGu0ZJlClNUFtGsmDCNPSPF05lYQrtZKmYE0Q=;
        b=d4P73TqPPzDtbjDdkUz0tCIfnHXlEC8Y+WREoR237kFz6PiwvLJI1Iij4w2GroCUyFzfFE
        a0YuZcEEO+LqTKM6qByc7mPfAHwF7qvM+G6/w0e8MrglMdKgIaKBhNBxZ6GLfcV5jfV2eb
        YvD6EcOcrMB3E9ga0b7xZWwqbj6fCHk=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-471-VtATe6wYNGeDFMNTAqVESg-1; Wed, 27 Apr 2022 23:04:54 -0400
X-MC-Unique: VtATe6wYNGeDFMNTAqVESg-1
Received: by mail-lj1-f200.google.com with SMTP id v1-20020a2e2f01000000b0024da499933dso1370068ljv.19
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 20:04:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=OgA3nNFGu0ZJlClNUFtGsmDCNPSPF05lYQrtZKmYE0Q=;
        b=RRAM2xzV/3Hag5WC0l7hhOFYZxGCqQim4KPBZasJPkG7oNtV1fwhm/i2n7OFn6vt+9
         bWL/gL4HgiAHR1eoKBJ9ng/fQT4PdEDP8/sYoaDBI6m/ZHseu53aWtoXPxpJScF2fx1I
         1YSmhxN0m67JyQU4NNmy3nswhZZUXng9cJEUrSZ7alA+eulXVublVFA/ps8AqE16zkhv
         Cfj08UwzL6gNMDAV/Y1R+k30hUm6odU7kTk+S3gaFbgplfKhCq+XapZL9LIbA1NyC2SJ
         j5J6CyOhD2QYbWpNbsmbPNnLw0VcQFMIdqVXv50ncA7dgIdhrxYIgwLCYWtnW7YW+tOc
         LjdQ==
X-Gm-Message-State: AOAM533hcxb1ueX2bqlCoqBlCRsqdB+xLN5lE8re93IYsg+MRlay7P9K
        0HNIkfsnZxcUQv8uUYxb8qJ5r2oElZch2r0m0kuC46LXBmG4pA50Hxvf9+6eIzRzPFjGBGvaUYB
        zcQOTZgK+6X5q1lcHvUxHMBvWDtDybxVj25/fQZfz
X-Received: by 2002:a05:6512:a8f:b0:471:948b:9b6b with SMTP id m15-20020a0565120a8f00b00471948b9b6bmr22939934lfu.471.1651115092948;
        Wed, 27 Apr 2022 20:04:52 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxv318AyjnLP/y/hcTzOsn3aF+A+3WOw3SOPem9I7/1/ocqp0MGXggZvWaraT4bzvOsaKf2zYT8nNekp2BCIew=
X-Received: by 2002:a05:6512:a8f:b0:471:948b:9b6b with SMTP id
 m15-20020a0565120a8f00b00471948b9b6bmr22939923lfu.471.1651115092770; Wed, 27
 Apr 2022 20:04:52 -0700 (PDT)
MIME-Version: 1.0
References: <20220425040512-mutt-send-email-mst@kernel.org>
 <87a6c98rwf.fsf@redhat.com> <20220425095742-mutt-send-email-mst@kernel.org>
 <20220426042911.544477f9.pasic@linux.ibm.com> <20220425233434-mutt-send-email-mst@kernel.org>
 <20220425233604-mutt-send-email-mst@kernel.org> <ba0c3977-c471-3275-2327-c5910cdd506a@redhat.com>
 <20220425235134-mutt-send-email-mst@kernel.org> <20220425235415-mutt-send-email-mst@kernel.org>
 <87o80n7soq.fsf@redhat.com> <20220426124243-mutt-send-email-mst@kernel.org>
 <87ilqu7u6w.fsf@redhat.com> <20220428044315.3945e660.pasic@linux.ibm.com>
In-Reply-To: <20220428044315.3945e660.pasic@linux.ibm.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Thu, 28 Apr 2022 11:04:41 +0800
Message-ID: <CACGkMEudDf=XXhV2tV+xZ586AnDyrQEotGAiSQZ4k1CTAWHZJQ@mail.gmail.com>
Subject: Re: [PATCH V3 6/9] virtio-ccw: implement synchronize_cbs()
To:     Halil Pasic <pasic@linux.ibm.com>
Cc:     Cornelia Huck <cohuck@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        virtualization <virtualization@lists.linux-foundation.org>,
        Stefano Garzarella <sgarzare@redhat.com>,
        eperezma <eperezma@redhat.com>, Cindy Lu <lulu@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Marc Zyngier <maz@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 28, 2022 at 10:43 AM Halil Pasic <pasic@linux.ibm.com> wrote:
>
> On Wed, 27 Apr 2022 11:27:03 +0200
> Cornelia Huck <cohuck@redhat.com> wrote:
>
> > On Tue, Apr 26 2022, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> >
> > > On Tue, Apr 26, 2022 at 05:47:17PM +0200, Cornelia Huck wrote:
> > >> On Mon, Apr 25 2022, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > >>
> > >> > On Mon, Apr 25, 2022 at 11:53:24PM -0400, Michael S. Tsirkin wrote=
:
> > >> >> On Tue, Apr 26, 2022 at 11:42:45AM +0800, Jason Wang wrote:
> > >> >> >
> > >> >> > =E5=9C=A8 2022/4/26 11:38, Michael S. Tsirkin =E5=86=99=E9=81=
=93:
> > >> >> > > On Mon, Apr 25, 2022 at 11:35:41PM -0400, Michael S. Tsirkin =
wrote:
> > >> >> > > > On Tue, Apr 26, 2022 at 04:29:11AM +0200, Halil Pasic wrote=
:
> > >> >> > > > > On Mon, 25 Apr 2022 09:59:55 -0400
> > >> >> > > > > "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > >> >> > > > >
> > >> >> > > > > > On Mon, Apr 25, 2022 at 10:54:24AM +0200, Cornelia Huck=
 wrote:
> > >> >> > > > > > > On Mon, Apr 25 2022, "Michael S. Tsirkin" <mst@redhat=
.com> wrote:
> > >> >> > > > > > > > On Mon, Apr 25, 2022 at 10:44:15AM +0800, Jason Wan=
g wrote:
> > >> >> > > > > > > > > This patch tries to implement the synchronize_cbs=
() for ccw. For the
> > >> >> > > > > > > > > vring_interrupt() that is called via virtio_airq_=
handler(), the
> > >> >> > > > > > > > > synchronization is simply done via the airq_info'=
s lock. For the
> > >> >> > > > > > > > > vring_interrupt() that is called via virtio_ccw_i=
nt_handler(), a per
> > >> >> > > > > > > > > device spinlock for irq is introduced ans used in=
 the synchronization
> > >> >> > > > > > > > > method.
> > >> >> > > > > > > > >
> > >> >> > > > > > > > > Cc: Thomas Gleixner <tglx@linutronix.de>
> > >> >> > > > > > > > > Cc: Peter Zijlstra <peterz@infradead.org>
> > >> >> > > > > > > > > Cc: "Paul E. McKenney" <paulmck@kernel.org>
> > >> >> > > > > > > > > Cc: Marc Zyngier <maz@kernel.org>
> > >> >> > > > > > > > > Cc: Halil Pasic <pasic@linux.ibm.com>
> > >> >> > > > > > > > > Cc: Cornelia Huck <cohuck@redhat.com>
> > >> >> > > > > > > > > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > >> >> > > > > > > >
> > >> >> > > > > > > > This is the only one that is giving me pause. Halil=
, Cornelia,
> > >> >> > > > > > > > should we be concerned about the performance impact=
 here?
> > >> >> > > > > > > > Any chance it can be tested?
> > >> >> > > > > > > We can have a bunch of devices using the same airq st=
ructure, and the
> > >> >> > > > > > > sync cb creates a choke point, same as registering/un=
registering.
> > >> >> > > > > > BTW can callbacks for multiple VQs run on multiple CPUs=
 at the moment?
> > >> >> > > > > I'm not sure I understand the question.
> > >> >> > > > >
> > >> >> > > > > I do think we can have multiple CPUs that are executing s=
ome portion of
> > >> >> > > > > virtio_ccw_int_handler(). So I guess the answer is yes. C=
onnie what do you think?
> > >> >> > > > >
> > >> >> > > > > On the other hand we could also end up serializing synchr=
onize_cbs()
> > >> >> > > > > calls for different devices if they happen to use the sam=
e airq_info. But
> > >> >> > > > > this probably was not your question
> > >> >> > > >
> > >> >> > > > I am less concerned about  synchronize_cbs being slow and m=
ore about
> > >> >> > > > the slowdown in interrupt processing itself.
> > >> >> > > >
> > >> >> > > > > > this patch serializes them on a spinlock.
> > >> >> > > > > >
> > >> >> > > > > Those could then pile up on the newly introduced spinlock=
.
> > >>
> > >> How bad would that be in practice? IIUC, we hit on the spinlock when
> > >> - doing synchronize_cbs (should be rare)
> > >> - processing queue interrupts for devices using per-device indicator=
s
> > >>   (which is the non-preferred path, which I would basically only exp=
ect
> > >>   when running on an ancient or non-standard hypervisor)
> > >
> > > this one is my concern. I am worried serializing everything on a sing=
le lock
> > > will drastically regress performance here.
> >
> > Yeah, that case could get much worse. OTOH, how likely is it that any
> > setup that runs a recent kernel will actually end up with devices using
> > per-device indicators? Anything running under a QEMU released in the
> > last couple of years is unlikely to not use airqs, I think. Halil, do
> > you think that the classic indicator setup would be more common on any
> > non-QEMU hypervisors?
> >
>
> I really don't know. My opinion is that, two stages indicators are kind
> of recommended for anybody who cares about notifications performance.
>
> > IOW, how much effort is it worth spending on optimizing this case? We
> > certainly should explore any simple solutions, but I don't think we nee=
d
> > to twist ourselves into pretzels to solve it.
> >
>
> Frankly, I would be fine with an rwlock based solution as proposed by
> Jason. My rationale is: we recommend two stage indicators, and the two
> stage indicators are already encumbered by an rwlock on the interrupt
> path. Yes, the coalescence of adapter interrupts is architecturally
> different, and so it is with GISA (without GISA, I'm not even sure), so
> this rwlock end up being worse than the one for 2 stage. But my feeling
> is, that it should be fine. On the other hand, I don't feel comfortable
> with plain spinlock, and I am curious about a more advanced solution.

Yes, I'm trying to use (S)RCU, let's see if it works.

> But my guess is that rwlock + some testing for the legacy indicator case
> just to double check if there is a heavy regression despite of our
> expectations to see none should do the trick.

I suggest this, rwlock (for not airq) seems better than spinlock, but
at worst case it will cause cache line bouncing. But I wonder if it's
noticeable (anyhow it has been used for airq).

Thanks

>
> Regards,
> Halil
>
> > >
> > >
> > >> - configuration change interrupts (should be rare)
> > >> - during setup, reset, etc. (should not be a concern)
> >
>

