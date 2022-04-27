Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BA6B510FB0
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 05:53:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357593AbiD0D4y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 23:56:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357587AbiD0D4w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 23:56:52 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 04229443D1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 20:53:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651031620;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WWn4QcTkQHPFNmV74dP0SQTZ8wKjKrW6mTFA+kq3cd4=;
        b=FzI+lASx4b/mPrT6qX+EKEccoKjCN0bAbjO5Dr3mLqk0gzQ2y7pAXujwx7dijZxPPgBuhQ
        X+svU0arY/B1XyFmMdEJ5UeEJKDAEnqPwDcD9WiadZUwi0HVy65UT0zdtOvjNNmdtv3s/i
        sjYgdxfnQqKVIlaHKNTo3eUQ3EH6suw=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-195-wQqnTXj2O4WTqt07fQt3-g-1; Tue, 26 Apr 2022 23:53:38 -0400
X-MC-Unique: wQqnTXj2O4WTqt07fQt3-g-1
Received: by mail-lf1-f72.google.com with SMTP id j2-20020a056512398200b00471fe56db2cso257764lfu.11
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 20:53:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=WWn4QcTkQHPFNmV74dP0SQTZ8wKjKrW6mTFA+kq3cd4=;
        b=s0J+PYjqTwM4C/6w4D812FwYA9hYQQoghGlezou0IgixiVXZCwOgxCZXBLTL0s3GLA
         tAn3jRvIRRsDLA4GShybiGzbi0vwIlV+UYG4CDs8Ouu2In7m8AYL9yNSmXMZv73TrUG1
         lD5Lc6Q1/acn9Hcg7KrK9dc1MTTrTDf+pSR8iefNzqds5AUkW3UkluS0ihD5RN80aspB
         0Ak6Cejaqljue7rIbQSVuhRBSmqrBvUo2jnFVVLJqMsQQ24DpuyRbXRfsvd/DInN5RUX
         m2Any7AnwHZoCNCwqMpkMEHFdPAdo6zPeW2ngbEU/uaJ/qMkwwPIYJfTofYb8ODqYFAl
         SfjA==
X-Gm-Message-State: AOAM530RblX9AUHTyDDjAhpaMGb8H211IsQrSsTyBW38dj9twaSzbERb
        sjyaTSvGFHFos9QFg6GJkjl3jLjVIlWS8sZ69M//d21i6yRiCxahv42kZxvxNOAY0y0itoEYmZ2
        7zblsV7/zCtSmu5V6yhTpAg4PJx1z8yvJCEvDOlTB
X-Received: by 2002:a2e:bc05:0:b0:24b:212d:7521 with SMTP id b5-20020a2ebc05000000b0024b212d7521mr16611048ljf.243.1651031617253;
        Tue, 26 Apr 2022 20:53:37 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxUCsW1tzgdyZ/4HEecNYbfI0VWNOBTAmhDHWJbGXXlLTJNKIv7AA9FCGpHA8BouSZJiRdxUqIa59/fOUQl6Jw=
X-Received: by 2002:a2e:bc05:0:b0:24b:212d:7521 with SMTP id
 b5-20020a2ebc05000000b0024b212d7521mr16611037ljf.243.1651031617102; Tue, 26
 Apr 2022 20:53:37 -0700 (PDT)
MIME-Version: 1.0
References: <20220425040512-mutt-send-email-mst@kernel.org>
 <87a6c98rwf.fsf@redhat.com> <20220425095742-mutt-send-email-mst@kernel.org>
 <20220426042911.544477f9.pasic@linux.ibm.com> <20220425233434-mutt-send-email-mst@kernel.org>
 <20220425233604-mutt-send-email-mst@kernel.org> <ba0c3977-c471-3275-2327-c5910cdd506a@redhat.com>
 <20220425235134-mutt-send-email-mst@kernel.org> <20220425235415-mutt-send-email-mst@kernel.org>
 <CACGkMEve+3ugK-Kgao3_2wbjb=fbF7AO2uEuArGjKgEAQcGdiQ@mail.gmail.com> <20220426022420-mutt-send-email-mst@kernel.org>
In-Reply-To: <20220426022420-mutt-send-email-mst@kernel.org>
From:   Jason Wang <jasowang@redhat.com>
Date:   Wed, 27 Apr 2022 11:53:25 +0800
Message-ID: <CACGkMEtt8irvYVx482Zc4vkjtDANXFvUYHGFoCh=C-Xf3C2JUg@mail.gmail.com>
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

On Tue, Apr 26, 2022 at 2:30 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Tue, Apr 26, 2022 at 12:07:39PM +0800, Jason Wang wrote:
> > On Tue, Apr 26, 2022 at 11:55 AM Michael S. Tsirkin <mst@redhat.com> wr=
ote:
> > >
> > > On Mon, Apr 25, 2022 at 11:53:24PM -0400, Michael S. Tsirkin wrote:
> > > > On Tue, Apr 26, 2022 at 11:42:45AM +0800, Jason Wang wrote:
> > > > >
> > > > > =E5=9C=A8 2022/4/26 11:38, Michael S. Tsirkin =E5=86=99=E9=81=93:
> > > > > > On Mon, Apr 25, 2022 at 11:35:41PM -0400, Michael S. Tsirkin wr=
ote:
> > > > > > > On Tue, Apr 26, 2022 at 04:29:11AM +0200, Halil Pasic wrote:
> > > > > > > > On Mon, 25 Apr 2022 09:59:55 -0400
> > > > > > > > "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > > > > > > >
> > > > > > > > > On Mon, Apr 25, 2022 at 10:54:24AM +0200, Cornelia Huck w=
rote:
> > > > > > > > > > On Mon, Apr 25 2022, "Michael S. Tsirkin" <mst@redhat.c=
om> wrote:
> > > > > > > > > > > On Mon, Apr 25, 2022 at 10:44:15AM +0800, Jason Wang =
wrote:
> > > > > > > > > > > > This patch tries to implement the synchronize_cbs()=
 for ccw. For the
> > > > > > > > > > > > vring_interrupt() that is called via virtio_airq_ha=
ndler(), the
> > > > > > > > > > > > synchronization is simply done via the airq_info's =
lock. For the
> > > > > > > > > > > > vring_interrupt() that is called via virtio_ccw_int=
_handler(), a per
> > > > > > > > > > > > device spinlock for irq is introduced ans used in t=
he synchronization
> > > > > > > > > > > > method.
> > > > > > > > > > > >
> > > > > > > > > > > > Cc: Thomas Gleixner <tglx@linutronix.de>
> > > > > > > > > > > > Cc: Peter Zijlstra <peterz@infradead.org>
> > > > > > > > > > > > Cc: "Paul E. McKenney" <paulmck@kernel.org>
> > > > > > > > > > > > Cc: Marc Zyngier <maz@kernel.org>
> > > > > > > > > > > > Cc: Halil Pasic <pasic@linux.ibm.com>
> > > > > > > > > > > > Cc: Cornelia Huck <cohuck@redhat.com>
> > > > > > > > > > > > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > > > > > > > > > >
> > > > > > > > > > > This is the only one that is giving me pause. Halil, =
Cornelia,
> > > > > > > > > > > should we be concerned about the performance impact h=
ere?
> > > > > > > > > > > Any chance it can be tested?
> > > > > > > > > > We can have a bunch of devices using the same airq stru=
cture, and the
> > > > > > > > > > sync cb creates a choke point, same as registering/unre=
gistering.
> > > > > > > > > BTW can callbacks for multiple VQs run on multiple CPUs a=
t the moment?
> > > > > > > > I'm not sure I understand the question.
> > > > > > > >
> > > > > > > > I do think we can have multiple CPUs that are executing som=
e portion of
> > > > > > > > virtio_ccw_int_handler(). So I guess the answer is yes. Con=
nie what do you think?
> > > > > > > >
> > > > > > > > On the other hand we could also end up serializing synchron=
ize_cbs()
> > > > > > > > calls for different devices if they happen to use the same =
airq_info. But
> > > > > > > > this probably was not your question
> > > > > > >
> > > > > > > I am less concerned about  synchronize_cbs being slow and mor=
e about
> > > > > > > the slowdown in interrupt processing itself.
> > > > > > >
> > > > > > > > > this patch serializes them on a spinlock.
> > > > > > > > >
> > > > > > > > Those could then pile up on the newly introduced spinlock.
> > > > > > > >
> > > > > > > > Regards,
> > > > > > > > Halil
> > > > > > > Hmm yea ... not good.
> > > > > > Is there any other way to synchronize with all callbacks?
> > > > >
> > > > >
> > > > > Maybe using rwlock as airq handler?
> > > > >
> > > > > Thanks
> > > > >
> > > >
> > > > rwlock is still a shared cacheline bouncing between CPUs and
> > > > a bunch of ordering instructions.
> >
> > Yes, but it should be faster than spinlocks anyhow.
> >
> > > > Maybe something per-cpu + some IPIs to run things on all CPUs inste=
ad?
> >
> > Is this something like a customized version of synchronzie_rcu_expedite=
d()?
>
> With interrupts running in an RCU read size critical section?

For vring_interrupt(), yes.


> Quite possibly that is also an option.
> This will need a bunch of documentation since this is not
> a standard use of RCU,

According to Documentation/RCU/requirements.rst, it looks like a legal case=
:

"
The Linux kernel has interrupts, and RCU read-side critical sections are
legal within interrupt handlers and within interrupt-disabled regions of
code, as are invocations of call_rcu().
"

And as discussed, synchronize_rcu_expedited() is not friendly to real
time workload. I think we can simply

1) protect vring_interrupt() with rcu_read_lock()
2) use synchronize_rcu() in synchronize_cbs for ccw

And if we care about the long delay we can use per device srcu to reduce th=
at?

Thanks

> and probably get a confirmation
> from RCU maintainers that whatever assumptions we make
> are guaranteed to hold down the road.
>
> > >
> > > ... and I think classic and device interrupts are different enough
> > > here ...
> >
> > Yes.
> >
> > Thanks
> >
> > >
> > > > > >
> > > > > > > --
> > > > > > > MST
> > >
>

