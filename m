Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F40E51112F
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 08:30:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358126AbiD0Gdg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 02:33:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358134AbiD0Gda (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 02:33:30 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A29AB270B
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 23:30:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651041017;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OWTpStIg9YYlyUersONgn/p6P5UJuTT9JNf7BrwmOj8=;
        b=NVJXFZzH7lpZbbo/tJKBJmIbIa7Eo2R4BCAGDz9Z22Oy6tW2QoLOUNf/wq8/XW7DEILsJ4
        vBfEAtOi93MhmqmqfOX4OehJ9W7nzopCJDTCjHBgC0hjSafrQpV87sNsN5Yf0yzpObyR54
        ufYn1Xwn3bxOEsfYMSXrsVB+Bpj9EPM=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-175-A56UYCGpMTKsTXAnbQEAtw-1; Wed, 27 Apr 2022 02:30:16 -0400
X-MC-Unique: A56UYCGpMTKsTXAnbQEAtw-1
Received: by mail-wr1-f70.google.com with SMTP id l7-20020adfa387000000b0020acc61dbaeso348729wrb.7
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 23:30:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=OWTpStIg9YYlyUersONgn/p6P5UJuTT9JNf7BrwmOj8=;
        b=Phctg6GgVeAuPlshh0xJnSJ2dIAGd9eYjRkDTv9aaiVnKuY4wfcEOxB51v0/mYpjBo
         +HAMgts3LzXdK+IgtmlLhr9V8vPzzOGB73Oo3KPgf0qUbFygYwjxJu3GExJapDSkPJjy
         r+lbo+LazW9yBI5zw617s521eITrfH1rjC2Eq9NrLrQwvVbyBDmBgo5y25zK0SrR6af6
         dKGh78BqEKozKUNxKSqLIGcLpwwkrSORgYEvlSVPnMB3K0zp80VQt2cWhy3fQIgRa+Iu
         KelhPawgWGH6UY7d2w+nURJ7TPXhxvQeTX+VWXRVZ2n26fTuFoSOkBlbox5HxI+yoivz
         CLpg==
X-Gm-Message-State: AOAM531e6G5dUswPh8ryV1VcnAUIheBdEhRN08pGxDq07dX37S7mO3nL
        R1Zbnz5Go++cf10wS9Yp+AV5GMtLKmaxlXLYjgIZxUxQgvr+5FELvUL7toa74Fc+KXtf6bDoX9H
        Fi9SVNmuhvfWzUOPQctQJxpoe
X-Received: by 2002:a05:600c:1547:b0:394:98:6acd with SMTP id f7-20020a05600c154700b0039400986acdmr1957331wmg.13.1651041015093;
        Tue, 26 Apr 2022 23:30:15 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwFx8wW8BzEOAFiHPjl6k6cXG+coX6lROa403FOUzSsKifrBoiYll7hha1zEvdg69ofrkhNZA==
X-Received: by 2002:a05:600c:1547:b0:394:98:6acd with SMTP id f7-20020a05600c154700b0039400986acdmr1957296wmg.13.1651041014823;
        Tue, 26 Apr 2022 23:30:14 -0700 (PDT)
Received: from redhat.com ([2.53.18.16])
        by smtp.gmail.com with ESMTPSA id r14-20020adfa14e000000b0020aeab110b8sm1843322wrr.74.2022.04.26.23.30.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Apr 2022 23:30:14 -0700 (PDT)
Date:   Wed, 27 Apr 2022 02:30:10 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
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
Subject: Re: [PATCH V3 6/9] virtio-ccw: implement synchronize_cbs()
Message-ID: <20220427022907-mutt-send-email-mst@kernel.org>
References: <20220425095742-mutt-send-email-mst@kernel.org>
 <20220426042911.544477f9.pasic@linux.ibm.com>
 <20220425233434-mutt-send-email-mst@kernel.org>
 <20220425233604-mutt-send-email-mst@kernel.org>
 <ba0c3977-c471-3275-2327-c5910cdd506a@redhat.com>
 <20220425235134-mutt-send-email-mst@kernel.org>
 <20220425235415-mutt-send-email-mst@kernel.org>
 <CACGkMEve+3ugK-Kgao3_2wbjb=fbF7AO2uEuArGjKgEAQcGdiQ@mail.gmail.com>
 <20220426022420-mutt-send-email-mst@kernel.org>
 <CACGkMEtt8irvYVx482Zc4vkjtDANXFvUYHGFoCh=C-Xf3C2JUg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACGkMEtt8irvYVx482Zc4vkjtDANXFvUYHGFoCh=C-Xf3C2JUg@mail.gmail.com>
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 27, 2022 at 11:53:25AM +0800, Jason Wang wrote:
> On Tue, Apr 26, 2022 at 2:30 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Tue, Apr 26, 2022 at 12:07:39PM +0800, Jason Wang wrote:
> > > On Tue, Apr 26, 2022 at 11:55 AM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > >
> > > > On Mon, Apr 25, 2022 at 11:53:24PM -0400, Michael S. Tsirkin wrote:
> > > > > On Tue, Apr 26, 2022 at 11:42:45AM +0800, Jason Wang wrote:
> > > > > >
> > > > > > 在 2022/4/26 11:38, Michael S. Tsirkin 写道:
> > > > > > > On Mon, Apr 25, 2022 at 11:35:41PM -0400, Michael S. Tsirkin wrote:
> > > > > > > > On Tue, Apr 26, 2022 at 04:29:11AM +0200, Halil Pasic wrote:
> > > > > > > > > On Mon, 25 Apr 2022 09:59:55 -0400
> > > > > > > > > "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > > > > > > > >
> > > > > > > > > > On Mon, Apr 25, 2022 at 10:54:24AM +0200, Cornelia Huck wrote:
> > > > > > > > > > > On Mon, Apr 25 2022, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > > > > > > > > > > > On Mon, Apr 25, 2022 at 10:44:15AM +0800, Jason Wang wrote:
> > > > > > > > > > > > > This patch tries to implement the synchronize_cbs() for ccw. For the
> > > > > > > > > > > > > vring_interrupt() that is called via virtio_airq_handler(), the
> > > > > > > > > > > > > synchronization is simply done via the airq_info's lock. For the
> > > > > > > > > > > > > vring_interrupt() that is called via virtio_ccw_int_handler(), a per
> > > > > > > > > > > > > device spinlock for irq is introduced ans used in the synchronization
> > > > > > > > > > > > > method.
> > > > > > > > > > > > >
> > > > > > > > > > > > > Cc: Thomas Gleixner <tglx@linutronix.de>
> > > > > > > > > > > > > Cc: Peter Zijlstra <peterz@infradead.org>
> > > > > > > > > > > > > Cc: "Paul E. McKenney" <paulmck@kernel.org>
> > > > > > > > > > > > > Cc: Marc Zyngier <maz@kernel.org>
> > > > > > > > > > > > > Cc: Halil Pasic <pasic@linux.ibm.com>
> > > > > > > > > > > > > Cc: Cornelia Huck <cohuck@redhat.com>
> > > > > > > > > > > > > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > > > > > > > > > > >
> > > > > > > > > > > > This is the only one that is giving me pause. Halil, Cornelia,
> > > > > > > > > > > > should we be concerned about the performance impact here?
> > > > > > > > > > > > Any chance it can be tested?
> > > > > > > > > > > We can have a bunch of devices using the same airq structure, and the
> > > > > > > > > > > sync cb creates a choke point, same as registering/unregistering.
> > > > > > > > > > BTW can callbacks for multiple VQs run on multiple CPUs at the moment?
> > > > > > > > > I'm not sure I understand the question.
> > > > > > > > >
> > > > > > > > > I do think we can have multiple CPUs that are executing some portion of
> > > > > > > > > virtio_ccw_int_handler(). So I guess the answer is yes. Connie what do you think?
> > > > > > > > >
> > > > > > > > > On the other hand we could also end up serializing synchronize_cbs()
> > > > > > > > > calls for different devices if they happen to use the same airq_info. But
> > > > > > > > > this probably was not your question
> > > > > > > >
> > > > > > > > I am less concerned about  synchronize_cbs being slow and more about
> > > > > > > > the slowdown in interrupt processing itself.
> > > > > > > >
> > > > > > > > > > this patch serializes them on a spinlock.
> > > > > > > > > >
> > > > > > > > > Those could then pile up on the newly introduced spinlock.
> > > > > > > > >
> > > > > > > > > Regards,
> > > > > > > > > Halil
> > > > > > > > Hmm yea ... not good.
> > > > > > > Is there any other way to synchronize with all callbacks?
> > > > > >
> > > > > >
> > > > > > Maybe using rwlock as airq handler?
> > > > > >
> > > > > > Thanks
> > > > > >
> > > > >
> > > > > rwlock is still a shared cacheline bouncing between CPUs and
> > > > > a bunch of ordering instructions.
> > >
> > > Yes, but it should be faster than spinlocks anyhow.
> > >
> > > > > Maybe something per-cpu + some IPIs to run things on all CPUs instead?
> > >
> > > Is this something like a customized version of synchronzie_rcu_expedited()?
> >
> > With interrupts running in an RCU read size critical section?
> 
> For vring_interrupt(), yes.
> 
> 
> > Quite possibly that is also an option.
> > This will need a bunch of documentation since this is not
> > a standard use of RCU,
> 
> According to Documentation/RCU/requirements.rst, it looks like a legal case:
> 
> "
> The Linux kernel has interrupts, and RCU read-side critical sections are
> legal within interrupt handlers and within interrupt-disabled regions of
> code, as are invocations of call_rcu().
> "

My problem is it is not clear what data is protected by rcu here.
Nothing is tagged with __rcu or uses rcu_dereference.
We need at least an ack from rcu maintainers that this is
a valid use of rcu and not an undocumented side effect.

> And as discussed, synchronize_rcu_expedited() is not friendly to real
> time workload. I think we can simply
> 
> 1) protect vring_interrupt() with rcu_read_lock()
> 2) use synchronize_rcu() in synchronize_cbs for ccw
> 
> And if we care about the long delay we can use per device srcu to reduce that?
> 
> Thanks
> 
> > and probably get a confirmation
> > from RCU maintainers that whatever assumptions we make
> > are guaranteed to hold down the road.
> >
> > > >
> > > > ... and I think classic and device interrupts are different enough
> > > > here ...
> > >
> > > Yes.
> > >
> > > Thanks
> > >
> > > >
> > > > > > >
> > > > > > > > --
> > > > > > > > MST
> > > >
> >

