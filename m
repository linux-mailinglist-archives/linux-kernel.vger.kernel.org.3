Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BEDC512075
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 20:39:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239567AbiD0PTb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 11:19:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239712AbiD0PS6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 11:18:58 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D51533A5DA
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 08:15:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651072543;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XWOAdhImrq2/TYQ+L3686e0RCpgtyiJg1rlmg+GyPGc=;
        b=c/M/YfWWi/Z19b3Rx6FbQkMLsqxiq1e3kus5CMdijGZT7uAFShWEQya667Fgy8X+ZCt577
        B/CPUee5Uj/pi/eyY1vDxowbdd6azsUrsij8Ij35Pyxa2rV+qFhbCJ9eMqBc5/QZFmMFvw
        eg+4p18VG24NbtD+CsHvnCCIAqSSnoM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-61-EnTZz21LO02aNnV-nJJGFw-1; Wed, 27 Apr 2022 11:15:41 -0400
X-MC-Unique: EnTZz21LO02aNnV-nJJGFw-1
Received: by mail-wm1-f72.google.com with SMTP id az19-20020a05600c601300b003914ac8efb8so689764wmb.2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 08:15:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=XWOAdhImrq2/TYQ+L3686e0RCpgtyiJg1rlmg+GyPGc=;
        b=3YGujOYhklVI+48UNksolZBfbQuldH/ElYgao/ijNE7pPb1pvinsGH9AHlRBCJj2JF
         kOwg+SCXE1jlaQkZ9UQrtpahq+zH6pSkSBgcjbfOsSyIazPIYW/Eq6ibD15C0pjm9WCi
         /HqhklSJBXiAwGDf4VMD97TGoq3PeXWHm3bIKTSmC13ymMDndh9V4HbxOjFtBxScZpOL
         AVXnHLxHDJdGMNDphBmZeaD1CJCi/Ehdpkh0nz4GQ26Ph5tB/du5leBi/2fP+0Xe/Ba1
         VOuffjmGAOJ+YRfq01Zr3P6ViOHll7queoXD2GNTtiVeGvEarCCpaAkAyWpBZkv7zoK4
         UAVw==
X-Gm-Message-State: AOAM530Ko233E5WGRSS19h23Bs96XvCwZXgvlRJdyg58jyJkCEVptpbT
        7RI8mcIaCjbmTp8APnaIBC9z56RWSoSmMo5Io+4xSiGkC4L9fBdmtXrp7yFIOKbR432oNpLAiy2
        Vfwb00bzfnOKUIGQdcYEDUeLf
X-Received: by 2002:a05:6000:1a8b:b0:20a:aaf7:75e8 with SMTP id f11-20020a0560001a8b00b0020aaaf775e8mr22115522wry.66.1651072540653;
        Wed, 27 Apr 2022 08:15:40 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwE2AlpbHYOLX4zY56a2kJT8noUAH/+2Yr1v5MnPXpsBur3d6mwrrg1tCJ6Nr9H5Fv/c4lYyw==
X-Received: by 2002:a05:6000:1a8b:b0:20a:aaf7:75e8 with SMTP id f11-20020a0560001a8b00b0020aaaf775e8mr22115488wry.66.1651072540308;
        Wed, 27 Apr 2022 08:15:40 -0700 (PDT)
Received: from redhat.com ([191.96.168.103])
        by smtp.gmail.com with ESMTPSA id o26-20020adfa11a000000b0020ade8b8fc5sm7088993wro.107.2022.04.27.08.15.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Apr 2022 08:15:39 -0700 (PDT)
Date:   Wed, 27 Apr 2022 11:15:33 -0400
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
Message-ID: <20220427111228-mutt-send-email-mst@kernel.org>
References: <20220425233434-mutt-send-email-mst@kernel.org>
 <20220425233604-mutt-send-email-mst@kernel.org>
 <ba0c3977-c471-3275-2327-c5910cdd506a@redhat.com>
 <20220425235134-mutt-send-email-mst@kernel.org>
 <20220425235415-mutt-send-email-mst@kernel.org>
 <CACGkMEve+3ugK-Kgao3_2wbjb=fbF7AO2uEuArGjKgEAQcGdiQ@mail.gmail.com>
 <20220426022420-mutt-send-email-mst@kernel.org>
 <CACGkMEtt8irvYVx482Zc4vkjtDANXFvUYHGFoCh=C-Xf3C2JUg@mail.gmail.com>
 <20220427022907-mutt-send-email-mst@kernel.org>
 <CACGkMEvfWA9vzVWU6yVdGNwueAAR9MhW8sFAAnGaRB7T+3GYeQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACGkMEvfWA9vzVWU6yVdGNwueAAR9MhW8sFAAnGaRB7T+3GYeQ@mail.gmail.com>
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 27, 2022 at 03:57:57PM +0800, Jason Wang wrote:
> On Wed, Apr 27, 2022 at 2:30 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Wed, Apr 27, 2022 at 11:53:25AM +0800, Jason Wang wrote:
> > > On Tue, Apr 26, 2022 at 2:30 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > >
> > > > On Tue, Apr 26, 2022 at 12:07:39PM +0800, Jason Wang wrote:
> > > > > On Tue, Apr 26, 2022 at 11:55 AM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > > > >
> > > > > > On Mon, Apr 25, 2022 at 11:53:24PM -0400, Michael S. Tsirkin wrote:
> > > > > > > On Tue, Apr 26, 2022 at 11:42:45AM +0800, Jason Wang wrote:
> > > > > > > >
> > > > > > > > 在 2022/4/26 11:38, Michael S. Tsirkin 写道:
> > > > > > > > > On Mon, Apr 25, 2022 at 11:35:41PM -0400, Michael S. Tsirkin wrote:
> > > > > > > > > > On Tue, Apr 26, 2022 at 04:29:11AM +0200, Halil Pasic wrote:
> > > > > > > > > > > On Mon, 25 Apr 2022 09:59:55 -0400
> > > > > > > > > > > "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > > > > > > > > > >
> > > > > > > > > > > > On Mon, Apr 25, 2022 at 10:54:24AM +0200, Cornelia Huck wrote:
> > > > > > > > > > > > > On Mon, Apr 25 2022, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > > > > > > > > > > > > > On Mon, Apr 25, 2022 at 10:44:15AM +0800, Jason Wang wrote:
> > > > > > > > > > > > > > > This patch tries to implement the synchronize_cbs() for ccw. For the
> > > > > > > > > > > > > > > vring_interrupt() that is called via virtio_airq_handler(), the
> > > > > > > > > > > > > > > synchronization is simply done via the airq_info's lock. For the
> > > > > > > > > > > > > > > vring_interrupt() that is called via virtio_ccw_int_handler(), a per
> > > > > > > > > > > > > > > device spinlock for irq is introduced ans used in the synchronization
> > > > > > > > > > > > > > > method.
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > Cc: Thomas Gleixner <tglx@linutronix.de>
> > > > > > > > > > > > > > > Cc: Peter Zijlstra <peterz@infradead.org>
> > > > > > > > > > > > > > > Cc: "Paul E. McKenney" <paulmck@kernel.org>
> > > > > > > > > > > > > > > Cc: Marc Zyngier <maz@kernel.org>
> > > > > > > > > > > > > > > Cc: Halil Pasic <pasic@linux.ibm.com>
> > > > > > > > > > > > > > > Cc: Cornelia Huck <cohuck@redhat.com>
> > > > > > > > > > > > > > > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > This is the only one that is giving me pause. Halil, Cornelia,
> > > > > > > > > > > > > > should we be concerned about the performance impact here?
> > > > > > > > > > > > > > Any chance it can be tested?
> > > > > > > > > > > > > We can have a bunch of devices using the same airq structure, and the
> > > > > > > > > > > > > sync cb creates a choke point, same as registering/unregistering.
> > > > > > > > > > > > BTW can callbacks for multiple VQs run on multiple CPUs at the moment?
> > > > > > > > > > > I'm not sure I understand the question.
> > > > > > > > > > >
> > > > > > > > > > > I do think we can have multiple CPUs that are executing some portion of
> > > > > > > > > > > virtio_ccw_int_handler(). So I guess the answer is yes. Connie what do you think?
> > > > > > > > > > >
> > > > > > > > > > > On the other hand we could also end up serializing synchronize_cbs()
> > > > > > > > > > > calls for different devices if they happen to use the same airq_info. But
> > > > > > > > > > > this probably was not your question
> > > > > > > > > >
> > > > > > > > > > I am less concerned about  synchronize_cbs being slow and more about
> > > > > > > > > > the slowdown in interrupt processing itself.
> > > > > > > > > >
> > > > > > > > > > > > this patch serializes them on a spinlock.
> > > > > > > > > > > >
> > > > > > > > > > > Those could then pile up on the newly introduced spinlock.
> > > > > > > > > > >
> > > > > > > > > > > Regards,
> > > > > > > > > > > Halil
> > > > > > > > > > Hmm yea ... not good.
> > > > > > > > > Is there any other way to synchronize with all callbacks?
> > > > > > > >
> > > > > > > >
> > > > > > > > Maybe using rwlock as airq handler?
> > > > > > > >
> > > > > > > > Thanks
> > > > > > > >
> > > > > > >
> > > > > > > rwlock is still a shared cacheline bouncing between CPUs and
> > > > > > > a bunch of ordering instructions.
> > > > >
> > > > > Yes, but it should be faster than spinlocks anyhow.
> > > > >
> > > > > > > Maybe something per-cpu + some IPIs to run things on all CPUs instead?
> > > > >
> > > > > Is this something like a customized version of synchronzie_rcu_expedited()?
> > > >
> > > > With interrupts running in an RCU read size critical section?
> > >
> > > For vring_interrupt(), yes.
> > >
> > >
> > > > Quite possibly that is also an option.
> > > > This will need a bunch of documentation since this is not
> > > > a standard use of RCU,
> > >
> > > According to Documentation/RCU/requirements.rst, it looks like a legal case:
> > >
> > > "
> > > The Linux kernel has interrupts, and RCU read-side critical sections are
> > > legal within interrupt handlers and within interrupt-disabled regions of
> > > code, as are invocations of call_rcu().
> > > "
> >
> > My problem is it is not clear what data is protected by rcu here.
> > Nothing is tagged with __rcu or uses rcu_dereference.
> 
> It should be the vq->broken here. We can rcuify it.


I don't exactly exactly see how - rcu_dereference works on pointers.
Feel free to send a patch.


> 
> > We need at least an ack from rcu maintainers that this is
> > a valid use of rcu and not an undocumented side effect.
> 
> Yes.
> 
> Thanks
> 
> 
> >
> > > And as discussed, synchronize_rcu_expedited() is not friendly to real
> > > time workload. I think we can simply
> > >
> > > 1) protect vring_interrupt() with rcu_read_lock()
> > > 2) use synchronize_rcu() in synchronize_cbs for ccw
> > >
> > > And if we care about the long delay we can use per device srcu to reduce that?
> > >
> > > Thanks
> > >
> > > > and probably get a confirmation
> > > > from RCU maintainers that whatever assumptions we make
> > > > are guaranteed to hold down the road.
> > > >
> > > > > >
> > > > > > ... and I think classic and device interrupts are different enough
> > > > > > here ...
> > > > >
> > > > > Yes.
> > > > >
> > > > > Thanks
> > > > >
> > > > > >
> > > > > > > > >
> > > > > > > > > > --
> > > > > > > > > > MST
> > > > > >
> > > >
> >

