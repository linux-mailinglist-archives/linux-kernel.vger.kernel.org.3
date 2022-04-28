Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2FD6512A53
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 06:13:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242603AbiD1EQX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 00:16:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232239AbiD1EQW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 00:16:22 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EBA7D237E7
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 21:13:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651119188;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZVZ9sUaSJWjUHSw9f04r5KVucc3jL3AUKVcKmJ3NAL4=;
        b=M3SmHLJo8gLt5UBqQjP4CHnq7WaZNSUuAVT47NjS0kxBQ9UZ9CBNn8bA0vxMBHTeCJVi7N
        Uongrmj2+rwPSEBgSnrVGpxOJk+IKRgPhCrHP1p5ju781x5auAOYVv53DWoogLqDtpwZGU
        FNtUGdtwLOYx6DaJPMH/8+sPzKcGp+k=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-503-XZT5Sd9VNYiQNhJWuzdDew-1; Thu, 28 Apr 2022 00:13:05 -0400
X-MC-Unique: XZT5Sd9VNYiQNhJWuzdDew-1
Received: by mail-wr1-f69.google.com with SMTP id e21-20020adfa455000000b0020ae075cf35so1427463wra.11
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 21:13:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=ZVZ9sUaSJWjUHSw9f04r5KVucc3jL3AUKVcKmJ3NAL4=;
        b=P/7g/JU8R8E/AZVyYinlcfdWxSW4JNVwe0ilSqzKwrztXIS4T3pfoOnYo2XZpqMFxx
         Y1wl5faHP74PRVsjf9lf6zd3ct2Z7qzxtT23q3GgJG1tYOKOaIcJKT1fpHPtSsgZ+etm
         hvvHONsYN6Zo/yEytltNJLCGOAgrJ+IxelgbuuJYWP1rAVmlkLocNytbHabjs8ErXazk
         KR/eB/1rq+Kbgih4yitKfeV13ew1uVgyKH/Wh4o66f4Etfv9PbxLbcocjKyRmHVzfBjC
         /8mgZEBNp9UovhkoUVVBInD3SHowQIbO55HC93M4nINpIeObwqA0MIL3f0+gCpnwB5jR
         UVmA==
X-Gm-Message-State: AOAM533+zjaTOtT1vL43Z1NuKOxlupxNDl0m5AOhkLAsp6gnJOKtlVDJ
        XCSsmHNNVVZc5DA+1mDh4F+62VnvSTbgBkxBneB65KzNRsiELBZyvCHS6Hg9+qerZciA17s8h9J
        tkhkfmheS5npqWbJlIpzLGODs
X-Received: by 2002:adf:ed05:0:b0:20a:f2ce:d751 with SMTP id a5-20020adfed05000000b0020af2ced751mr3382055wro.515.1651119184116;
        Wed, 27 Apr 2022 21:13:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx916KYb7PiWtad59cylkJTg5tmthcpImGSNLGfOqocrPqE+hsRsFMdJbnz0W3wzYtGgvFY3A==
X-Received: by 2002:adf:ed05:0:b0:20a:f2ce:d751 with SMTP id a5-20020adfed05000000b0020af2ced751mr3382047wro.515.1651119183898;
        Wed, 27 Apr 2022 21:13:03 -0700 (PDT)
Received: from redhat.com ([2.53.18.16])
        by smtp.gmail.com with ESMTPSA id j8-20020a05600c190800b00393e80a7970sm3029021wmq.7.2022.04.27.21.12.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Apr 2022 21:12:59 -0700 (PDT)
Date:   Thu, 28 Apr 2022 00:12:54 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Halil Pasic <pasic@linux.ibm.com>
Cc:     Cornelia Huck <cohuck@redhat.com>,
        Jason Wang <jasowang@redhat.com>, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, sgarzare@redhat.com,
        eperezma@redhat.com, lulu@redhat.com, tglx@linutronix.de,
        peterz@infradead.org, paulmck@kernel.org, maz@kernel.org
Subject: Re: [PATCH V3 6/9] virtio-ccw: implement synchronize_cbs()
Message-ID: <20220428001142-mutt-send-email-mst@kernel.org>
References: <20220426042911.544477f9.pasic@linux.ibm.com>
 <20220425233434-mutt-send-email-mst@kernel.org>
 <20220425233604-mutt-send-email-mst@kernel.org>
 <ba0c3977-c471-3275-2327-c5910cdd506a@redhat.com>
 <20220425235134-mutt-send-email-mst@kernel.org>
 <20220425235415-mutt-send-email-mst@kernel.org>
 <87o80n7soq.fsf@redhat.com>
 <20220426124243-mutt-send-email-mst@kernel.org>
 <87ilqu7u6w.fsf@redhat.com>
 <20220428044315.3945e660.pasic@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220428044315.3945e660.pasic@linux.ibm.com>
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 28, 2022 at 04:43:15AM +0200, Halil Pasic wrote:
> On Wed, 27 Apr 2022 11:27:03 +0200
> Cornelia Huck <cohuck@redhat.com> wrote:
> 
> > On Tue, Apr 26 2022, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > 
> > > On Tue, Apr 26, 2022 at 05:47:17PM +0200, Cornelia Huck wrote:  
> > >> On Mon, Apr 25 2022, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > >>   
> > >> > On Mon, Apr 25, 2022 at 11:53:24PM -0400, Michael S. Tsirkin wrote:  
> > >> >> On Tue, Apr 26, 2022 at 11:42:45AM +0800, Jason Wang wrote:  
> > >> >> > 
> > >> >> > 在 2022/4/26 11:38, Michael S. Tsirkin 写道:  
> > >> >> > > On Mon, Apr 25, 2022 at 11:35:41PM -0400, Michael S. Tsirkin wrote:  
> > >> >> > > > On Tue, Apr 26, 2022 at 04:29:11AM +0200, Halil Pasic wrote:  
> > >> >> > > > > On Mon, 25 Apr 2022 09:59:55 -0400
> > >> >> > > > > "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > >> >> > > > >   
> > >> >> > > > > > On Mon, Apr 25, 2022 at 10:54:24AM +0200, Cornelia Huck wrote:  
> > >> >> > > > > > > On Mon, Apr 25 2022, "Michael S. Tsirkin" <mst@redhat.com> wrote:  
> > >> >> > > > > > > > On Mon, Apr 25, 2022 at 10:44:15AM +0800, Jason Wang wrote:  
> > >> >> > > > > > > > > This patch tries to implement the synchronize_cbs() for ccw. For the
> > >> >> > > > > > > > > vring_interrupt() that is called via virtio_airq_handler(), the
> > >> >> > > > > > > > > synchronization is simply done via the airq_info's lock. For the
> > >> >> > > > > > > > > vring_interrupt() that is called via virtio_ccw_int_handler(), a per
> > >> >> > > > > > > > > device spinlock for irq is introduced ans used in the synchronization
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
> > >> >> > > > > > > > This is the only one that is giving me pause. Halil, Cornelia,
> > >> >> > > > > > > > should we be concerned about the performance impact here?
> > >> >> > > > > > > > Any chance it can be tested?  
> > >> >> > > > > > > We can have a bunch of devices using the same airq structure, and the
> > >> >> > > > > > > sync cb creates a choke point, same as registering/unregistering.  
> > >> >> > > > > > BTW can callbacks for multiple VQs run on multiple CPUs at the moment?  
> > >> >> > > > > I'm not sure I understand the question.
> > >> >> > > > > 
> > >> >> > > > > I do think we can have multiple CPUs that are executing some portion of
> > >> >> > > > > virtio_ccw_int_handler(). So I guess the answer is yes. Connie what do you think?
> > >> >> > > > > 
> > >> >> > > > > On the other hand we could also end up serializing synchronize_cbs()
> > >> >> > > > > calls for different devices if they happen to use the same airq_info. But
> > >> >> > > > > this probably was not your question  
> > >> >> > > > 
> > >> >> > > > I am less concerned about  synchronize_cbs being slow and more about
> > >> >> > > > the slowdown in interrupt processing itself.
> > >> >> > > >   
> > >> >> > > > > > this patch serializes them on a spinlock.
> > >> >> > > > > >   
> > >> >> > > > > Those could then pile up on the newly introduced spinlock.  
> > >> 
> > >> How bad would that be in practice? IIUC, we hit on the spinlock when
> > >> - doing synchronize_cbs (should be rare)
> > >> - processing queue interrupts for devices using per-device indicators
> > >>   (which is the non-preferred path, which I would basically only expect
> > >>   when running on an ancient or non-standard hypervisor)  
> > >
> > > this one is my concern. I am worried serializing everything on a single lock
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
> > certainly should explore any simple solutions, but I don't think we need
> > to twist ourselves into pretzels to solve it.
> > 
> 
> Frankly, I would be fine with an rwlock based solution as proposed by
> Jason. My rationale is: we recommend two stage indicators, and the two
> stage indicators are already encumbered by an rwlock on the interrupt
> path.

Which lock is it? Can we take that lock to synchronize?

> Yes, the coalescence of adapter interrupts is architecturally
> different, and so it is with GISA (without GISA, I'm not even sure), so
> this rwlock end up being worse than the one for 2 stage. But my feeling
> is, that it should be fine. On the other hand, I don't feel comfortable
> with plain spinlock, and I am curious about a more advanced solution.
> But my guess is that rwlock + some testing for the legacy indicator case
> just to double check if there is a heavy regression despite of our
> expectations to see none should do the trick.
> 
> Regards,
> Halil

Makes sense.

> > >
> > >  
> > >> - configuration change interrupts (should be rare)
> > >> - during setup, reset, etc. (should not be a concern)  
> > 

