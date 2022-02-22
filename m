Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9A3E4BFE1F
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 17:08:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233909AbiBVQJA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 11:09:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233912AbiBVQI5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 11:08:57 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AA39D165C07
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 08:08:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645546108;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ayZQO14IuVvLb4KFAu15b92K05gesQyRdVPfr8lUqdY=;
        b=MWhD7hl05/eINDT3h9XfiwjwYkHnbd7z8CYR9xvh5RN+O5jyMq+P2tBqWh/24EdZeV4X62
        IFFtY8sGKy2R8q8OpQhz7huSFDini/JdH95HBGnpeZNZ+LUQm5e4EXs+JcYq3O64bd3dAG
        VURwAEqNZZN4L/XOIJMO0dH8FT264T4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-517-MG6RiG2uMxy0URq4p3XVmw-1; Tue, 22 Feb 2022 11:08:25 -0500
X-MC-Unique: MG6RiG2uMxy0URq4p3XVmw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0987A188E3C2;
        Tue, 22 Feb 2022 16:08:24 +0000 (UTC)
Received: from fuller.cnet (ovpn-112-2.gru2.redhat.com [10.97.112.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3DD4282765;
        Tue, 22 Feb 2022 16:08:00 +0000 (UTC)
Received: by fuller.cnet (Postfix, from userid 1000)
        id D5215416D862; Tue, 22 Feb 2022 12:51:51 -0300 (-03)
Date:   Tue, 22 Feb 2022 12:51:51 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     Nicolas Saenz Julienne <nsaenzju@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Minchan Kim <minchan@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Juri Lelli <juril@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: Re: [patch 1/2] mm: protect local lock sections with rcu_read_lock
 (on RT)
Message-ID: <YhUGl2F6gZxaNA7v@fuller.cnet>
References: <20220222144706.937848439@redhat.com>
 <20220222144907.023121407@redhat.com>
 <5f96c7e306546af4604cfaddb895a089811cb99b.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5f96c7e306546af4604cfaddb895a089811cb99b.camel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 22, 2022 at 04:21:26PM +0100, Nicolas Saenz Julienne wrote:
> On Tue, 2022-02-22 at 11:47 -0300, Marcelo Tosatti wrote:
> > For the per-CPU LRU page vectors, augment the local lock protected
> > code sections with rcu_read_lock.
> > 
> > This makes it possible to replace the queueing of work items on all 
> > CPUs by synchronize_rcu (which is necessary to run FIFO:1 applications
> > uninterrupted on isolated CPUs).
> 
> I don't think this is needed. In RT local_locks use a spinlock. See
> kernel/locking/spinlock_rt.c:
> 
> "The RT [spinlock] substitutions explicitly disable migration and take
> rcu_read_lock() across the lock held section."

Nice! Then the migrate_disable from __local_lock and friends seems unnecessary as
well

#define __local_lock(__lock)                                    \
        do {                                                    \
                migrate_disable();                              \
                spin_lock(this_cpu_ptr((__lock)));              \
        } while (0)

Since:

static __always_inline void __rt_spin_lock(spinlock_t *lock)
{
        rtlock_might_resched();
        rtlock_lock(&lock->lock); 
        rcu_read_lock();
        migrate_disable();
}

Will resend -v2.


