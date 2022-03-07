Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 595E84D08C5
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 21:48:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245262AbiCGUtP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 15:49:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234473AbiCGUtN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 15:49:13 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A16D31400D
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 12:48:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646686097;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KSMBnuH3EDTdQZsI9EhfLFxqdlWYA5qSa5KfVdxC0LQ=;
        b=bs3MJ3u4jgpmVbIA/Mgq8rBm3wR0gOfKsTLLpRlVknIyYj+XgPHQzijdh5qR8juuwHM6LF
        Q8Tis0uv2b6cM+dpdKmMniPn8++Oy4yJOZRPu7HfABquWJSjViVNKM4/yLh8E1LY6jdRW6
        bxXhvYL/QwmGpnNQoNkYaNLnX1fhb/0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-421-cykugfQEOw-AFfmo64uZaQ-1; Mon, 07 Mar 2022 15:48:14 -0500
X-MC-Unique: cykugfQEOw-AFfmo64uZaQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 55D551091DA0;
        Mon,  7 Mar 2022 20:48:12 +0000 (UTC)
Received: from fuller.cnet (ovpn-112-2.gru2.redhat.com [10.97.112.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9FCF15D9DE;
        Mon,  7 Mar 2022 20:48:06 +0000 (UTC)
Received: by fuller.cnet (Postfix, from userid 1000)
        id 2D5B2416CE5D; Mon,  7 Mar 2022 17:47:39 -0300 (-03)
Date:   Mon, 7 Mar 2022 17:47:39 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     Mel Gorman <mgorman@suse.de>
Cc:     Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, frederic@kernel.org, tglx@linutronix.de,
        linux-rt-users@vger.kernel.org, vbabka@suse.cz, cl@linux.com,
        paulmck@kernel.org, willy@infradead.org
Subject: Re: [PATCH 0/2] mm/page_alloc: Remote per-cpu lists drain support
Message-ID: <YiZva67/uV/Frdph@fuller.cnet>
References: <20220208100750.1189808-1-nsaenzju@redhat.com>
 <20220303114550.GE4363@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220303114550.GE4363@suse.de>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 03, 2022 at 11:45:50AM +0000, Mel Gorman wrote:
> On Tue, Feb 08, 2022 at 11:07:48AM +0100, Nicolas Saenz Julienne wrote:
> > This series replaces mm/page_alloc's per-cpu page lists drain mechanism with
> > one that allows accessing the lists remotely. Currently, only a local CPU is
> > permitted to change its per-cpu lists, and it's expected to do so, on-demand,
> > whenever a process demands it by means of queueing a drain task on the local
> > CPU. This causes problems for NOHZ_FULL CPUs and real-time systems that can't
> > take any sort of interruption and to some lesser extent inconveniences idle and
> > virtualised systems.
> > 
> 
> I know this has been sitting here for a long while. Last few weeks have
> not been fun.
> 
> > Note that this is not the first attempt at fixing this per-cpu page lists:
> >  - The first attempt[1] tried to conditionally change the pagesets locking
> >    scheme based the NOHZ_FULL config. It was deemed hard to maintain as the
> >    NOHZ_FULL code path would be rarely tested. Also, this only solves the issue
> >    for NOHZ_FULL setups, which isn't ideal.
> >  - The second[2] unanimously switched the local_locks to per-cpu spinlocks. The
> >    performance degradation was too big.
> > 
> 
> For unrelated reasons I looked at using llist to avoid locks entirely. It
> turns out it's not possible and needs a lock. We know "local_locks to
> per-cpu spinlocks" took a large penalty so I considered alternatives on
> how a lock could be used.  I found it's possible to both remote drain
> the lists and avoid the disable/enable of IRQs entirely as long as a
> preempting IRQ is willing to take the zone lock instead (should be very
> rare). The IRQ part is a bit hairy though as softirqs are also a problem
> and preempt-rt needs different rules and the llist has to sort PCP
> refills which might be a loss in total. However, the remote draining may
> still be interesting. The full series is at
> https://git.kernel.org/pub/scm/linux/kernel/git/mel/linux.git/ mm-pcpllist-v1r2
> 
> It's still waiting on tests to complete and not all the changelogs are
> complete which is why it's not posted.
> 
> This is a comparison of vanilla vs "local_locks to per-cpu spinlocks"
> versus the git series up to "mm/page_alloc: Remotely drain per-cpu lists"
> for the page faulting microbench I originally complained about.  The test
> machine is a 2-socket CascadeLake machine.
> 
> pft timings
>                                  5.17.0-rc5             5.17.0-rc5             5.17.0-rc5
>                                     vanilla    mm-remotedrain-v2r1       mm-pcpdrain-v1r1
> Amean     elapsed-1        32.54 (   0.00%)       33.08 *  -1.66%*       32.82 *  -0.86%*
> Amean     elapsed-4         8.66 (   0.00%)        9.24 *  -6.72%*        8.69 *  -0.38%*
> Amean     elapsed-7         5.02 (   0.00%)        5.43 *  -8.16%*        5.05 *  -0.55%*
> Amean     elapsed-12        3.07 (   0.00%)        3.38 * -10.00%*        3.09 *  -0.72%*
> Amean     elapsed-21        2.36 (   0.00%)        2.38 *  -0.89%*        2.19 *   7.39%*
> Amean     elapsed-30        1.75 (   0.00%)        1.87 *  -6.50%*        1.62 *   7.59%*
> Amean     elapsed-48        1.71 (   0.00%)        2.00 * -17.32%*        1.71 (  -0.08%)
> Amean     elapsed-79        1.56 (   0.00%)        1.62 *  -3.84%*        1.56 (  -0.02%)
> Amean     elapsed-80        1.57 (   0.00%)        1.65 *  -5.31%*        1.57 (  -0.04%)
> 
> Note the local_lock conversion took 1 1-17% penalty while the git tree
> takes a negligile penalty while still allowing remote drains. It might
> have some potential while being less complex than the RCU approach.

Nice!

Hopefully a spinlock can be added to "struct lru_pvecs" without
degradation in performance, similarly to what is done here.

