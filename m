Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 268F24FD7FB
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 12:34:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357332AbiDLHkA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 03:40:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353056AbiDLHOr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 03:14:47 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 838B532982
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 23:56:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649746559;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GN5vkjRmgkPNx751McI5DU0rpDoKJKayXCERhKWgOHo=;
        b=Y7YT1DqfvmfsKxlCPnDCj4Jv4U/0jM0yGkirC9SYD61x6cWreACj+kd4oSkKEMsVXV70x4
        +8jwls1qmUrG68HaLs8KQJy8Ks9QpuM/GMwt9x761h72pOuFAwWO/h9RWScpvMuv66+oJo
        ud1qMMq9WmBr+EcsYniR+LoI/J0lwdk=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-151-Dnhq3bfwPeyKLYXdsrYgtA-1; Tue, 12 Apr 2022 02:55:58 -0400
X-MC-Unique: Dnhq3bfwPeyKLYXdsrYgtA-1
Received: by mail-ed1-f69.google.com with SMTP id cn27-20020a0564020cbb00b0041b5b91adb5so10356403edb.15
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 23:55:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=GN5vkjRmgkPNx751McI5DU0rpDoKJKayXCERhKWgOHo=;
        b=TpO4wx8bhGQp3PPyZ2zu9RXehHBvKRRq11s0bTXvr66YqCiIDEdxH4fj9fU1UecUCa
         I/cUE1hj9C+2qisBL4TOWheHL9uA5iLea5pR2PX4a+cRCCSy48yJvXdzxPeY/Fc5gx9N
         rcrkrB17djSjumTIyfaH4ssQrhX/QQySa12xONl8JeZKj/SlE2uVoFRbWWGTnijL9FkE
         i+9lVATh3kbMjrbu7p5E18B/Oe152TL6TrkMnOIzd5zdwkrCiRKsxRjHRn2WgYmXGADn
         UGtnXuSObWsHq03e5fetjiP5jh6T5ms3tifAuA3QmD+ez0nUYOwF4wnzH96xiySi8thE
         P5jg==
X-Gm-Message-State: AOAM530vzyvkl9MStOxEzWs7n4xPSo28n+yHjYxIaH6CDlwSRgRcikgX
        FzBErBQfBTh2yNQQ1aV3MPH5Zqdf/ebWMEyoXn/kSMY/yw8qEauSiceW0Mr3VjdCfQqq1mtMSQv
        WpC6dYVqoyXbg01CjK/6MbjiF
X-Received: by 2002:aa7:cc96:0:b0:410:b9ac:241 with SMTP id p22-20020aa7cc96000000b00410b9ac0241mr37641963edt.246.1649746557016;
        Mon, 11 Apr 2022 23:55:57 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxGPxug4QSaPb0hUaH35LBenThin66afliFP6NyNmncmrZUcM1TJgpijjoRwtDcypb/fdXkvA==
X-Received: by 2002:aa7:cc96:0:b0:410:b9ac:241 with SMTP id p22-20020aa7cc96000000b00410b9ac0241mr37641949edt.246.1649746556825;
        Mon, 11 Apr 2022 23:55:56 -0700 (PDT)
Received: from redhat.com ([2.52.1.156])
        by smtp.gmail.com with ESMTPSA id c4-20020a170906340400b006d077e850b5sm12693341ejb.23.2022.04.11.23.55.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Apr 2022 23:55:56 -0700 (PDT)
Date:   Tue, 12 Apr 2022 02:55:52 -0400
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
Message-ID: <20220412025405-mutt-send-email-mst@kernel.org>
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
> 
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

Does this need to be if (!READ_ONCE(dev->ok)) ?



> I'm not understanding what you folks are trying to "fix" here. If any
> driver does this in the wrong order, then the driver is broken.
> 
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

