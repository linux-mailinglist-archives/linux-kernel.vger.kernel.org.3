Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97F50511129
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 08:29:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358122AbiD0GcY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 02:32:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235637AbiD0GcS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 02:32:18 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 982ACDE93E
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 23:29:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651040947;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZxvLlCVIbPp4swwXiDKmSMELQTP9l85QUsuRNDye7qY=;
        b=ixgaqSHzslEcPRHzYrQOtyVOZ5TTCh5rs/AHR/dIC9BfJkr2ZxZPhOhNkZrXlIF++d1tlD
        oea9XAX/GuY8hY7Z6oXKKbPe5tvXOVCHINxUMf5h+rgKfalYa+YEZZ9wE+jwVheoidee7R
        VoyVK2qOwOoObOcFZqhwdSoYZudZy2U=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-618-LhIXkYrHMi63fuq4Rr1uwA-1; Wed, 27 Apr 2022 02:29:06 -0400
X-MC-Unique: LhIXkYrHMi63fuq4Rr1uwA-1
Received: by mail-wr1-f71.google.com with SMTP id e21-20020adfa455000000b0020ae075cf35so344194wra.11
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 23:29:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=ZxvLlCVIbPp4swwXiDKmSMELQTP9l85QUsuRNDye7qY=;
        b=Pd2k3hvCmL+AWzK8l12NKA2j0r8ezg9gj92qOaXctft8vD7F72FmaWmLgKLW8PLtHe
         kV5WmDAW9USj3NPV+AaM5KHSK6HAMOncqQYTMN/rxpBzKOYbXCLaMpnXqUZ2OiChyaYY
         S29ZJMLqXS2os+20bp/ntugMQMhIGZNv313CPAxwWGVfznd2kyz4jGVPuNjMJzpn5CR5
         mTuapToM0vtBs9sl9ol2iDScOg2qDOSx+g9nNxz80SPQrNuGCYUxrU0DSZRo8mX5kpM6
         klkkr/wnI8m0D2pMZEHIZBYVOt+XepMOzAlo6BF803R67cyC9TeaZDaDu16B1/gsjqdz
         c3zA==
X-Gm-Message-State: AOAM531PxLjSbaB/99EJlPNuvYMd9Yx8q5hnOSfcaqX+Zqx5IRaLkiUz
        v4tG1Xzy1kesmQBayN4AbMMwwHiHuBMy8udUVMt6aI4CGOVR64pYKIfIjVFWYfMQhBBc7GjgGwy
        EBsutPgJurUi6a5OXWYpmtDEv
X-Received: by 2002:a05:6000:1acf:b0:20a:9c20:c769 with SMTP id i15-20020a0560001acf00b0020a9c20c769mr22279950wry.467.1651040945171;
        Tue, 26 Apr 2022 23:29:05 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxyIvazlULlqCBEf77oMMwcbw3dwk01MwREF6SF13p4XynswDJqRkL5C38HxCm1OcYfiqs1DQ==
X-Received: by 2002:a05:6000:1acf:b0:20a:9c20:c769 with SMTP id i15-20020a0560001acf00b0020a9c20c769mr22279929wry.467.1651040944951;
        Tue, 26 Apr 2022 23:29:04 -0700 (PDT)
Received: from redhat.com ([2.53.18.16])
        by smtp.gmail.com with ESMTPSA id m41-20020a05600c3b2900b00393e6f6c130sm850563wms.42.2022.04.26.23.29.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Apr 2022 23:29:03 -0700 (PDT)
Date:   Wed, 27 Apr 2022 02:28:59 -0400
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
Message-ID: <20220427022634-mutt-send-email-mst@kernel.org>
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
> 
> And as discussed, synchronize_rcu_expedited() is not friendly to real
> time workload.

I am not sure hotplug removal is relevant for realtime anyway though.

> I think we can simply
> 
> 1) protect vring_interrupt() with rcu_read_lock()
> 2) use synchronize_rcu() in synchronize_cbs for ccw
> 
> And if we care about the long delay we can use per device srcu to reduce that?
> 
> Thanks

Maybe ...

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

