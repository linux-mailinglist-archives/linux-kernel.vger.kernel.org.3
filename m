Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87ECA511317
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 09:58:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359198AbiD0IB0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 04:01:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350586AbiD0IBX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 04:01:23 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B27F4517CC
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 00:58:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651046291;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pk9gD8PZ85VjavB1ddaChX0OVjboNSKEVKwwirKTwi0=;
        b=ES43e6Y2cWrfe61s6Id20MSFtlhLrTNJ6nAaqd0wKFKCVjLGTkkFvUM73jLt1h96UaB31h
        gP9g+Pj/Om/zAPYsMcuZf8ctzUGqBbPoNjqJLnia0GjkIYWms0r4efm35AiAxHQQ0G8qQ+
        x3XPT3P42ka4aLTY4S/bgYxACzwbzEI=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-378-aVyQzItpPFKwu5ZtNa85og-1; Wed, 27 Apr 2022 03:58:10 -0400
X-MC-Unique: aVyQzItpPFKwu5ZtNa85og-1
Received: by mail-lf1-f69.google.com with SMTP id w34-20020a0565120b2200b0044adfdd1570so415927lfu.23
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 00:58:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=pk9gD8PZ85VjavB1ddaChX0OVjboNSKEVKwwirKTwi0=;
        b=DwXgNUb+bDqtGJspSoKuSUG5c6DBTk8loXvGlwr35iNQ9tfBP8k0b5eKlQghn60hET
         IO74knRpH75r2apmaLcVNXpYPvNSuPWq1CmtQsy0aT5yskevliZ2hyz3qNftx1NaMnsq
         mWuNHQx147h5BhYTXwYZePpoelLHptrvqgTE6269pERRhIlTnC4mz0vuvqiyZBxAAhCd
         Bskl6qt5xqHuoUasKG5CkAHpOj8MArYCCz8INVyr8C8yWyiwTelQ3dX3n6jZ2tJlcDbS
         vTNJhwbm7WrMYiGNrpIzFk/nZSgbzEqVh2tdbr49hnaX87QEfknJOryYC5yMvX+SyDi4
         a7Iw==
X-Gm-Message-State: AOAM533T9MnkZODrVGtwhgMJQlScNETF2ewV3CUMZyHZcmjR6i6goQli
        qIjXojA4gGsb4GP/2ifzVgBNf+4GmwHTb+h8KC5E2P5AMJOuKbjjPoAVyUwnd11rtafZyzT08j+
        7ffAPs/3GKh2BWieYlsputzojTWavMtjC0uXVV3rm
X-Received: by 2002:a05:6512:b81:b0:448:b342:513c with SMTP id b1-20020a0565120b8100b00448b342513cmr19379435lfv.257.1651046288743;
        Wed, 27 Apr 2022 00:58:08 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz1d9rI5MFqiDCBdBB2YPxrGZfeR11FcSpb6qkKUtLOApLnox6HDwvgiJyKtlnFTFL9fFMYko/DJtz/W9NvU6A=
X-Received: by 2002:a05:6512:b81:b0:448:b342:513c with SMTP id
 b1-20020a0565120b8100b00448b342513cmr19379423lfv.257.1651046288552; Wed, 27
 Apr 2022 00:58:08 -0700 (PDT)
MIME-Version: 1.0
References: <20220425095742-mutt-send-email-mst@kernel.org>
 <20220426042911.544477f9.pasic@linux.ibm.com> <20220425233434-mutt-send-email-mst@kernel.org>
 <20220425233604-mutt-send-email-mst@kernel.org> <ba0c3977-c471-3275-2327-c5910cdd506a@redhat.com>
 <20220425235134-mutt-send-email-mst@kernel.org> <20220425235415-mutt-send-email-mst@kernel.org>
 <CACGkMEve+3ugK-Kgao3_2wbjb=fbF7AO2uEuArGjKgEAQcGdiQ@mail.gmail.com>
 <20220426022420-mutt-send-email-mst@kernel.org> <CACGkMEtt8irvYVx482Zc4vkjtDANXFvUYHGFoCh=C-Xf3C2JUg@mail.gmail.com>
 <20220427022907-mutt-send-email-mst@kernel.org>
In-Reply-To: <20220427022907-mutt-send-email-mst@kernel.org>
From:   Jason Wang <jasowang@redhat.com>
Date:   Wed, 27 Apr 2022 15:57:57 +0800
Message-ID: <CACGkMEvfWA9vzVWU6yVdGNwueAAR9MhW8sFAAnGaRB7T+3GYeQ@mail.gmail.com>
Subject: Re: [PATCH V3 6/9] virtio-ccw: implement synchronize_cbs()
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Halil Pasic <pasic@linux.ibm.com>,
        Cornelia Huck <cohuck@redhat.com>,
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

On Wed, Apr 27, 2022 at 2:30 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Wed, Apr 27, 2022 at 11:53:25AM +0800, Jason Wang wrote:
> > On Tue, Apr 26, 2022 at 2:30 PM Michael S. Tsirkin <mst@redhat.com> wro=
te:
> > >
> > > On Tue, Apr 26, 2022 at 12:07:39PM +0800, Jason Wang wrote:
> > > > On Tue, Apr 26, 2022 at 11:55 AM Michael S. Tsirkin <mst@redhat.com=
> wrote:
> > > > >
> > > > > On Mon, Apr 25, 2022 at 11:53:24PM -0400, Michael S. Tsirkin wrot=
e:
> > > > > > On Tue, Apr 26, 2022 at 11:42:45AM +0800, Jason Wang wrote:
> > > > > > >
> > > > > > > =E5=9C=A8 2022/4/26 11:38, Michael S. Tsirkin =E5=86=99=E9=81=
=93:
> > > > > > > > On Mon, Apr 25, 2022 at 11:35:41PM -0400, Michael S. Tsirki=
n wrote:
> > > > > > > > > On Tue, Apr 26, 2022 at 04:29:11AM +0200, Halil Pasic wro=
te:
> > > > > > > > > > On Mon, 25 Apr 2022 09:59:55 -0400
> > > > > > > > > > "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > > > > > > > > >
> > > > > > > > > > > On Mon, Apr 25, 2022 at 10:54:24AM +0200, Cornelia Hu=
ck wrote:
> > > > > > > > > > > > On Mon, Apr 25 2022, "Michael S. Tsirkin" <mst@redh=
at.com> wrote:
> > > > > > > > > > > > > On Mon, Apr 25, 2022 at 10:44:15AM +0800, Jason W=
ang wrote:
> > > > > > > > > > > > > > This patch tries to implement the synchronize_c=
bs() for ccw. For the
> > > > > > > > > > > > > > vring_interrupt() that is called via virtio_air=
q_handler(), the
> > > > > > > > > > > > > > synchronization is simply done via the airq_inf=
o's lock. For the
> > > > > > > > > > > > > > vring_interrupt() that is called via virtio_ccw=
_int_handler(), a per
> > > > > > > > > > > > > > device spinlock for irq is introduced ans used =
in the synchronization
> > > > > > > > > > > > > > method.
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > Cc: Thomas Gleixner <tglx@linutronix.de>
> > > > > > > > > > > > > > Cc: Peter Zijlstra <peterz@infradead.org>
> > > > > > > > > > > > > > Cc: "Paul E. McKenney" <paulmck@kernel.org>
> > > > > > > > > > > > > > Cc: Marc Zyngier <maz@kernel.org>
> > > > > > > > > > > > > > Cc: Halil Pasic <pasic@linux.ibm.com>
> > > > > > > > > > > > > > Cc: Cornelia Huck <cohuck@redhat.com>
> > > > > > > > > > > > > > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > > > > > > > > > > > >
> > > > > > > > > > > > > This is the only one that is giving me pause. Hal=
il, Cornelia,
> > > > > > > > > > > > > should we be concerned about the performance impa=
ct here?
> > > > > > > > > > > > > Any chance it can be tested?
> > > > > > > > > > > > We can have a bunch of devices using the same airq =
structure, and the
> > > > > > > > > > > > sync cb creates a choke point, same as registering/=
unregistering.
> > > > > > > > > > > BTW can callbacks for multiple VQs run on multiple CP=
Us at the moment?
> > > > > > > > > > I'm not sure I understand the question.
> > > > > > > > > >
> > > > > > > > > > I do think we can have multiple CPUs that are executing=
 some portion of
> > > > > > > > > > virtio_ccw_int_handler(). So I guess the answer is yes.=
 Connie what do you think?
> > > > > > > > > >
> > > > > > > > > > On the other hand we could also end up serializing sync=
hronize_cbs()
> > > > > > > > > > calls for different devices if they happen to use the s=
ame airq_info. But
> > > > > > > > > > this probably was not your question
> > > > > > > > >
> > > > > > > > > I am less concerned about  synchronize_cbs being slow and=
 more about
> > > > > > > > > the slowdown in interrupt processing itself.
> > > > > > > > >
> > > > > > > > > > > this patch serializes them on a spinlock.
> > > > > > > > > > >
> > > > > > > > > > Those could then pile up on the newly introduced spinlo=
ck.
> > > > > > > > > >
> > > > > > > > > > Regards,
> > > > > > > > > > Halil
> > > > > > > > > Hmm yea ... not good.
> > > > > > > > Is there any other way to synchronize with all callbacks?
> > > > > > >
> > > > > > >
> > > > > > > Maybe using rwlock as airq handler?
> > > > > > >
> > > > > > > Thanks
> > > > > > >
> > > > > >
> > > > > > rwlock is still a shared cacheline bouncing between CPUs and
> > > > > > a bunch of ordering instructions.
> > > >
> > > > Yes, but it should be faster than spinlocks anyhow.
> > > >
> > > > > > Maybe something per-cpu + some IPIs to run things on all CPUs i=
nstead?
> > > >
> > > > Is this something like a customized version of synchronzie_rcu_expe=
dited()?
> > >
> > > With interrupts running in an RCU read size critical section?
> >
> > For vring_interrupt(), yes.
> >
> >
> > > Quite possibly that is also an option.
> > > This will need a bunch of documentation since this is not
> > > a standard use of RCU,
> >
> > According to Documentation/RCU/requirements.rst, it looks like a legal =
case:
> >
> > "
> > The Linux kernel has interrupts, and RCU read-side critical sections ar=
e
> > legal within interrupt handlers and within interrupt-disabled regions o=
f
> > code, as are invocations of call_rcu().
> > "
>
> My problem is it is not clear what data is protected by rcu here.
> Nothing is tagged with __rcu or uses rcu_dereference.

It should be the vq->broken here. We can rcuify it.


> We need at least an ack from rcu maintainers that this is
> a valid use of rcu and not an undocumented side effect.

Yes.

Thanks


>
> > And as discussed, synchronize_rcu_expedited() is not friendly to real
> > time workload. I think we can simply
> >
> > 1) protect vring_interrupt() with rcu_read_lock()
> > 2) use synchronize_rcu() in synchronize_cbs for ccw
> >
> > And if we care about the long delay we can use per device srcu to reduc=
e that?
> >
> > Thanks
> >
> > > and probably get a confirmation
> > > from RCU maintainers that whatever assumptions we make
> > > are guaranteed to hold down the road.
> > >
> > > > >
> > > > > ... and I think classic and device interrupts are different enoug=
h
> > > > > here ...
> > > >
> > > > Yes.
> > > >
> > > > Thanks
> > > >
> > > > >
> > > > > > > >
> > > > > > > > > --
> > > > > > > > > MST
> > > > >
> > >
>

