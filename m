Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B29244EAF63
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 16:38:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236587AbiC2Oju (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 10:39:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233612AbiC2Ojq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 10:39:46 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0E67222F3FC
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 07:38:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1648564682;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=phRSkDpN4Oul95zrD2pvhXv5WfnDRoZp6xYqZyAQWOU=;
        b=gRo1ISOuPOV5EeXS7oQ31PT4RttW8uuRkiE1AuY4gY7V2ktPQN550kOg1s3BNe7DPOHL9g
        EBCkdhO52mLS57Dt1n4e+Wn/CmQisZo7ZNWHJDcJmx+AFxkkPOXPuT0WfKC6ZxtijGHkD+
        3EgfkSWi28VX1h0PkoK8jVEh+2vabkU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-477-3NYwaVlYMnqORkdNeASr1g-1; Tue, 29 Mar 2022 10:38:00 -0400
X-MC-Unique: 3NYwaVlYMnqORkdNeASr1g-1
Received: by mail-wm1-f72.google.com with SMTP id i6-20020a1c5406000000b0038c97ed0db5so6896390wmb.7
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 07:37:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=phRSkDpN4Oul95zrD2pvhXv5WfnDRoZp6xYqZyAQWOU=;
        b=68wGoVg27UeHKXlnDYqOybkyY/ZPXmeHPDD5CK0YUAlHUa2dFlkp2ruIn+NkHUiI4U
         EV+5C17j2T2NyjSFTMLF3JofjJXOdw31FavUhfyT205mGPdJe4LKvwd7mMSaL9kYJT3y
         Hd+8IxQ4SbgDdc7p5KTV9sF81fkEDUwhogGXmeIhzp7cXrPQhNwreBtl448SsKZV2VA6
         zsWKDIe2UpWt4N7tZyMM8c2xAmLoayZIFvawpKtsHfbgXFvB9IrV9P7qGLfAfC14a89C
         qDT4FFQM56xT+uZonsHovARTu13Jw/K0NVocUiGKs819L0jWJT5/ilTre3tIBiyis4KN
         Ljnw==
X-Gm-Message-State: AOAM532aCP8nCCrP+W+h9zmrumCoNd+CnskfuzXylLE9ihUPJnI5uBGh
        T+YqzMU744LoB4AfBs2M1p9ytYMbgoNNwLFOHONd1wEau7kmzz0dlAUnmURpIFNIea6StHxmzT/
        e99EcX9PWXrKIYnY30ufSbSDi
X-Received: by 2002:a1c:f413:0:b0:37b:d1de:5762 with SMTP id z19-20020a1cf413000000b0037bd1de5762mr7472943wma.108.1648564678948;
        Tue, 29 Mar 2022 07:37:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwHdbEkKXOoWfvK6LYBI3WT4Tuyh2gv+TYwixKz1bLZ9mvPfp452vVOpd5o/3N7r+dWpmKawA==
X-Received: by 2002:a1c:f413:0:b0:37b:d1de:5762 with SMTP id z19-20020a1cf413000000b0037bd1de5762mr7472914wma.108.1648564678647;
        Tue, 29 Mar 2022 07:37:58 -0700 (PDT)
Received: from redhat.com ([2.52.9.207])
        by smtp.gmail.com with ESMTPSA id 14-20020a056000154e00b00203f8adde0csm19010792wry.32.2022.03.29.07.37.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Mar 2022 07:37:57 -0700 (PDT)
Date:   Tue, 29 Mar 2022 10:37:53 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Jason Wang <jasowang@redhat.com>,
        virtualization <virtualization@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Stefano Garzarella <sgarzare@redhat.com>,
        Keir Fraser <keirf@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: Re:
Message-ID: <20220329100859-mutt-send-email-mst@kernel.org>
References: <Yj1hkpyUqJE9sQ2p@redhat.com>
 <CACGkMEunsuWhn+aB2dM7noU257M9JV6jDjkQXLyOA+GjEoz_iw@mail.gmail.com>
 <20220325050947-mutt-send-email-mst@kernel.org>
 <CACGkMEvioAVMmB+ab2xXB2YPECtwi1J55u8mRRk9-JAjFSZ8vg@mail.gmail.com>
 <20220325060659-mutt-send-email-mst@kernel.org>
 <CACGkMEu4mRfNbJXJtAFzhyd55fD7phUDKnVtYW0aqRnQmT_bYw@mail.gmail.com>
 <20220328015757-mutt-send-email-mst@kernel.org>
 <CACGkMEu+fax6YYwhfbc1yoSxv6o1FTQyrOheVTmUfqGvmbAEfA@mail.gmail.com>
 <20220328062452-mutt-send-email-mst@kernel.org>
 <87fsn1f96e.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87fsn1f96e.ffs@tglx>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 29, 2022 at 10:35:21AM +0200, Thomas Gleixner wrote:
> On Mon, Mar 28 2022 at 06:40, Michael S. Tsirkin wrote:
> > On Mon, Mar 28, 2022 at 02:18:22PM +0800, Jason Wang wrote:
> >> > > So I think we might talk different issues:
> >> > >
> >> > > 1) Whether request_irq() commits the previous setups, I think the
> >> > > answer is yes, since the spin_unlock of desc->lock (release) can
> >> > > guarantee this though there seems no documentation around
> >> > > request_irq() to say this.
> >> > >
> >> > > And I can see at least drivers/video/fbdev/omap2/omapfb/dss/dispc.c is
> >> > > using smp_wmb() before the request_irq().
> 
> That's a complete bogus example especially as there is not a single
> smp_rmb() which pairs with the smp_wmb().
> 
> >> > > And even if write is ordered we still need read to be ordered to be
> >> > > paired with that.
> >
> > IMO it synchronizes with the CPU to which irq is
> > delivered. Otherwise basically all drivers would be broken,
> > wouldn't they be?
> > I don't know whether it's correct on all platforms, but if not
> > we need to fix request_irq.
> 
> There is nothing to fix:
> 
> request_irq()
>    raw_spin_lock_irq(desc->lock);       // ACQUIRE
>    ....
>    raw_spin_unlock_irq(desc->lock);     // RELEASE
> 
> interrupt()
>    raw_spin_lock(desc->lock);           // ACQUIRE
>    set status to IN_PROGRESS
>    raw_spin_unlock(desc->lock);         // RELEASE
>    invoke handler()
> 
> So anything which the driver set up _before_ request_irq() is visible to
> the interrupt handler. No?
> >> What happens if an interrupt is raised in the middle like:
> >> 
> >> smp_store_release(dev->irq_soft_enabled, true)
> >> IRQ handler
> >> synchornize_irq()
> 
> This is bogus. The obvious order of things is:
> 
>     dev->ok = false;
>     request_irq();
> 
>     moar_setup();
>     synchronize_irq();  // ACQUIRE + RELEASE
>     dev->ok = true;
> 
> The reverse operation on teardown:
> 
>     dev->ok = false;
>     synchronize_irq();  // ACQUIRE + RELEASE
> 
>     teardown();
> 
> So in both cases a simple check in the handler is sufficient:
> 
> handler()
>     if (!dev->ok)
>     	return;


Thanks a lot for the analysis Thomas. This is more or less what I was
thinking.

> 
> I'm not understanding what you folks are trying to "fix" here.

We are trying to fix the driver since at the moment it does not
have the dev->ok flag at all.


And I suspect virtio is not alone in that.
So it would have been nice if there was a standard flag
replacing the driver-specific dev->ok above, and ideally
would also handle the case of an interrupt triggering
too early by deferring the interrupt until the flag is set.

And in fact, it does kind of exist: IRQF_NO_AUTOEN, and you would call
enable_irq instead of dev->ok = true, except
- it doesn't work with affinity managed IRQs
- it does not work with shared IRQs

So using dev->ok as you propose above seems better at this point.

> If any
> driver does this in the wrong order, then the driver is broken.

I agree, however:
$ git grep synchronize_irq `git grep -l request_irq drivers/net/`|wc -l
113
$ git grep -l request_irq drivers/net/|wc -l
397

I suspect there are more drivers which in theory need the
synchronize_irq dance but in practice do not execute it.


> Sure, you can do the same with:
> 
>     dev->ok = false;
>     request_irq();
>     moar_setup();
>     smp_wmb();
>     dev->ok = true;
> 
> for the price of a smp_rmb() in the interrupt handler:
> 
> handler()
>     if (!dev->ok)
>     	return;
>     smp_rmb();
> 
> but that's only working for the setup case correctly and not for
> teardown.
> 
> Thanks,
> 
>         tglx

