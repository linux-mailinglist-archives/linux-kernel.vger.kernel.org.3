Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B8AB5103D5
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 18:44:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353106AbiDZQrC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 12:47:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235613AbiDZQqy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 12:46:54 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 09C7747058
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 09:43:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650991425;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AmBHiCcZSCU3IlknPjgefbwYr8sHQGYFZPAAiy3Pw/w=;
        b=CO39FZ+riuJ7CdsmMSHizVyCgpAFYmiYBr9ZoENaZ9K5IYuc144d39GNsmUkzYHeL9mfp2
        ysOguD+sOEku0jW1UiGhIsHNniu/tyVkByJnsvrvwTVu8G3dtd2cQmjiRhT7pz7qTKGbLy
        RtUiSeL5ZO39BFrJz6BYBIFZadqEfkQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-593-nVqbNw8bOQOqMf_rBX8FTQ-1; Tue, 26 Apr 2022 12:43:43 -0400
X-MC-Unique: nVqbNw8bOQOqMf_rBX8FTQ-1
Received: by mail-wm1-f69.google.com with SMTP id g9-20020a1c4e09000000b0038f20d94f01so1477076wmh.8
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 09:43:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=AmBHiCcZSCU3IlknPjgefbwYr8sHQGYFZPAAiy3Pw/w=;
        b=UU0pTSTk1Ncs4mEYE55RWuo+Og6q92u2VIoWiZgNrAQkZ7hcwb95lv1s3+AI1jgpy5
         PQlUbpdcToJDSOpy1mHDC6eDNvAZnZ1tU483oLjNkdslDe+bH/cXBC+U9zitPFL9XURg
         SWNKAAaId0SK+sZYXEjNrvLRrYhVuItq+O6zCdvUtofI//DhpDk3/wZxmS+9fMg7I2cO
         VPT4jUuMJtMaenY2frHfCQfp3iJA8+9boDQ70kKBzhz8mNQeuVmZOa2JRoneD/g+yeZR
         myPp0R2LFWxJMtsphzNfaq/jYGp972t2ry9BnaKtkAGWU8R6ce8TvI4cpxHWDryZzr3e
         rOYA==
X-Gm-Message-State: AOAM532F2+uT23mnJBKTJKtD2joHl6omHNeYYkf5msrWR5PCPWtzTMga
        OkO1DX5Vmnx+nTg5nr64QeZQndDiXfz1Pt8pUvuByb87YgoJnBrM9T/s+6AcObh6dL++umo8WlF
        J+Ol/k3UhuMtHp0HhIayBaUiL
X-Received: by 2002:a05:6000:1789:b0:20a:9f94:1620 with SMTP id e9-20020a056000178900b0020a9f941620mr19657174wrg.640.1650991422037;
        Tue, 26 Apr 2022 09:43:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyfz8Pkmw51eFwJVdP+dK0w5CxNhoIuOiCngJvaJLdcwbMbc4dFPtCwPPtxxnWRU6Y78qqrvw==
X-Received: by 2002:a05:6000:1789:b0:20a:9f94:1620 with SMTP id e9-20020a056000178900b0020a9f941620mr19657161wrg.640.1650991421834;
        Tue, 26 Apr 2022 09:43:41 -0700 (PDT)
Received: from redhat.com ([2.53.22.137])
        by smtp.gmail.com with ESMTPSA id z6-20020a05600c0a0600b00393d831bf15sm10346194wmp.46.2022.04.26.09.43.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Apr 2022 09:43:41 -0700 (PDT)
Date:   Tue, 26 Apr 2022 12:43:36 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Cornelia Huck <cohuck@redhat.com>
Cc:     Jason Wang <jasowang@redhat.com>,
        Halil Pasic <pasic@linux.ibm.com>,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, sgarzare@redhat.com,
        eperezma@redhat.com, lulu@redhat.com, tglx@linutronix.de,
        peterz@infradead.org, paulmck@kernel.org, maz@kernel.org
Subject: Re: [PATCH V3 6/9] virtio-ccw: implement synchronize_cbs()
Message-ID: <20220426124243-mutt-send-email-mst@kernel.org>
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
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87o80n7soq.fsf@redhat.com>
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 26, 2022 at 05:47:17PM +0200, Cornelia Huck wrote:
> On Mon, Apr 25 2022, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> 
> > On Mon, Apr 25, 2022 at 11:53:24PM -0400, Michael S. Tsirkin wrote:
> >> On Tue, Apr 26, 2022 at 11:42:45AM +0800, Jason Wang wrote:
> >> > 
> >> > 在 2022/4/26 11:38, Michael S. Tsirkin 写道:
> >> > > On Mon, Apr 25, 2022 at 11:35:41PM -0400, Michael S. Tsirkin wrote:
> >> > > > On Tue, Apr 26, 2022 at 04:29:11AM +0200, Halil Pasic wrote:
> >> > > > > On Mon, 25 Apr 2022 09:59:55 -0400
> >> > > > > "Michael S. Tsirkin" <mst@redhat.com> wrote:
> >> > > > > 
> >> > > > > > On Mon, Apr 25, 2022 at 10:54:24AM +0200, Cornelia Huck wrote:
> >> > > > > > > On Mon, Apr 25 2022, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> >> > > > > > > > On Mon, Apr 25, 2022 at 10:44:15AM +0800, Jason Wang wrote:
> >> > > > > > > > > This patch tries to implement the synchronize_cbs() for ccw. For the
> >> > > > > > > > > vring_interrupt() that is called via virtio_airq_handler(), the
> >> > > > > > > > > synchronization is simply done via the airq_info's lock. For the
> >> > > > > > > > > vring_interrupt() that is called via virtio_ccw_int_handler(), a per
> >> > > > > > > > > device spinlock for irq is introduced ans used in the synchronization
> >> > > > > > > > > method.
> >> > > > > > > > > 
> >> > > > > > > > > Cc: Thomas Gleixner <tglx@linutronix.de>
> >> > > > > > > > > Cc: Peter Zijlstra <peterz@infradead.org>
> >> > > > > > > > > Cc: "Paul E. McKenney" <paulmck@kernel.org>
> >> > > > > > > > > Cc: Marc Zyngier <maz@kernel.org>
> >> > > > > > > > > Cc: Halil Pasic <pasic@linux.ibm.com>
> >> > > > > > > > > Cc: Cornelia Huck <cohuck@redhat.com>
> >> > > > > > > > > Signed-off-by: Jason Wang <jasowang@redhat.com>
> >> > > > > > > > 
> >> > > > > > > > This is the only one that is giving me pause. Halil, Cornelia,
> >> > > > > > > > should we be concerned about the performance impact here?
> >> > > > > > > > Any chance it can be tested?
> >> > > > > > > We can have a bunch of devices using the same airq structure, and the
> >> > > > > > > sync cb creates a choke point, same as registering/unregistering.
> >> > > > > > BTW can callbacks for multiple VQs run on multiple CPUs at the moment?
> >> > > > > I'm not sure I understand the question.
> >> > > > > 
> >> > > > > I do think we can have multiple CPUs that are executing some portion of
> >> > > > > virtio_ccw_int_handler(). So I guess the answer is yes. Connie what do you think?
> >> > > > > 
> >> > > > > On the other hand we could also end up serializing synchronize_cbs()
> >> > > > > calls for different devices if they happen to use the same airq_info. But
> >> > > > > this probably was not your question
> >> > > > 
> >> > > > I am less concerned about  synchronize_cbs being slow and more about
> >> > > > the slowdown in interrupt processing itself.
> >> > > > 
> >> > > > > > this patch serializes them on a spinlock.
> >> > > > > > 
> >> > > > > Those could then pile up on the newly introduced spinlock.
> 
> How bad would that be in practice? IIUC, we hit on the spinlock when
> - doing synchronize_cbs (should be rare)
> - processing queue interrupts for devices using per-device indicators
>   (which is the non-preferred path, which I would basically only expect
>   when running on an ancient or non-standard hypervisor)

this one is my concern. I am worried serializing everything on a single lock
will drastically regress performance here.


> - configuration change interrupts (should be rare)
> - during setup, reset, etc. (should not be a concern)
> 
> >> > > > > 
> >> > > > > Regards,
> >> > > > > Halil
> >> > > > Hmm yea ... not good.
> >> > > Is there any other way to synchronize with all callbacks?
> >> > 
> >> > 
> >> > Maybe using rwlock as airq handler?
> >> > 
> >> > Thanks
> >> > 
> >> 
> >> rwlock is still a shared cacheline bouncing between CPUs and
> >> a bunch of ordering instructions.
> >> Maybe something per-cpu + some IPIs to run things on all CPUs instead?
> >
> > ... and I think classic and device interrupts are different enough
> > here ...
> 
> You mean classic (per-device) and adapter interrupts, right?

