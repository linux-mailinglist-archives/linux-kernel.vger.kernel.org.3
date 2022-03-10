Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7E694D4F56
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 17:33:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243486AbiCJQdC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 11:33:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238790AbiCJQdA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 11:33:00 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6229E190C16;
        Thu, 10 Mar 2022 08:31:59 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 160D821106;
        Thu, 10 Mar 2022 16:31:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1646929918; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ckgh/54VKAw6Qnxgd+jgb5k0txhbSVaOhP9+nLif3j4=;
        b=B3uvBSn76znSqOZimKCNoKHULtUje9t1w9TAl/MSQRejuXE1ujCmyUAb0+LeXbhBB8ZLAC
        jQvtBHO0vrmBIncL8JER8VU/uLNHZPu/t9jVMTRHtnwTuX1LZF3GjcaIMWgO56ZDo+Xrav
        t/e/+LHEKDA+xGlu0wgJ/eVEMF2lcJA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1646929918;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ckgh/54VKAw6Qnxgd+jgb5k0txhbSVaOhP9+nLif3j4=;
        b=V4kt/xeRGn5rhiPYx2cBdKqA7CcmeVGg3Ft6k1W5KRrfwKerbMwoXI+4ri5Jj7tf/YP1BV
        iSdYXYNInQEdwaAw==
Received: from suse.de (unknown [10.163.32.246])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 17676A3B83;
        Thu, 10 Mar 2022 16:31:56 +0000 (UTC)
Date:   Thu, 10 Mar 2022 16:31:54 +0000
From:   Mel Gorman <mgorman@suse.de>
To:     Nicolas Saenz Julienne <nsaenzju@redhat.com>
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, frederic@kernel.org, tglx@linutronix.de,
        mtosatti@redhat.com, linux-rt-users@vger.kernel.org,
        vbabka@suse.cz, cl@linux.com, paulmck@kernel.org,
        willy@infradead.org
Subject: Re: [PATCH 0/2] mm/page_alloc: Remote per-cpu lists drain support
Message-ID: <20220310163154.GF4363@suse.de>
References: <20220208100750.1189808-1-nsaenzju@redhat.com>
 <20220303114550.GE4363@suse.de>
 <fcdaacf58296dfd826bfdbbd5ef3a06b6e05a456.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <fcdaacf58296dfd826bfdbbd5ef3a06b6e05a456.camel@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 07, 2022 at 02:57:47PM +0100, Nicolas Saenz Julienne wrote:
> > > Note that this is not the first attempt at fixing this per-cpu page lists:
> > >  - The first attempt[1] tried to conditionally change the pagesets locking
> > >    scheme based the NOHZ_FULL config. It was deemed hard to maintain as the
> > >    NOHZ_FULL code path would be rarely tested. Also, this only solves the issue
> > >    for NOHZ_FULL setups, which isn't ideal.
> > >  - The second[2] unanimously switched the local_locks to per-cpu spinlocks. The
> > >    performance degradation was too big.
> > > 
> > 
> > For unrelated reasons I looked at using llist to avoid locks entirely. It
> > turns out it's not possible and needs a lock. We know "local_locks to
> > per-cpu spinlocks" took a large penalty so I considered alternatives on
> > how a lock could be used.  I found it's possible to both remote drain
> > the lists and avoid the disable/enable of IRQs entirely as long as a
> > preempting IRQ is willing to take the zone lock instead (should be very
> > rare). The IRQ part is a bit hairy though as softirqs are also a problem
> > and preempt-rt needs different rules and the llist has to sort PCP
> > refills which might be a loss in total. However, the remote draining may
> > still be interesting. The full series is at
> > https://git.kernel.org/pub/scm/linux/kernel/git/mel/linux.git/ mm-pcpllist-v1r2
> 
> I'll have a proper look at it soon.
> 

Thanks. I'm still delayed actually finishing the series as most of my
time is dedicated to a separate issue. However, there is at least one
bug in there at patch "mm/page_alloc: Remotely drain per-cpu lists"
that causes a lockup under severe memory pressure. The fix is

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index c9a6f2b5548e..11b54f383d04 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -3065,10 +3065,8 @@ static int rmqueue_bulk(struct zone *zone, unsigned int order,
  */
 void drain_zone_pages(struct zone *zone, struct per_cpu_pages *pcp)
 {
-	unsigned long flags;
 	int to_drain, batch;
 
-	pcp_local_lock(&pagesets.lock, flags);
 	batch = READ_ONCE(pcp->batch);
 	to_drain = min(pcp->count, batch);
 	if (to_drain > 0) {
@@ -3076,7 +3074,6 @@ void drain_zone_pages(struct zone *zone, struct per_cpu_pages *pcp)
 		free_pcppages_bulk(zone, to_drain, pcp, 0);
 		spin_unlock(&pcp->lock);
 	}
-	pcp_local_unlock(&pagesets.lock, flags);
 }
 #endif
 
@@ -3088,16 +3085,12 @@ static void drain_pages_zone(unsigned int cpu, struct zone *zone)
 	unsigned long flags;
 	struct per_cpu_pages *pcp;
 
-	pcp_local_lock(&pagesets.lock, flags);
-
 	pcp = per_cpu_ptr(zone->per_cpu_pageset, cpu);
 	if (pcp->count) {
 		spin_lock(&pcp->lock);
 		free_pcppages_bulk(zone, pcp->count, pcp, 0);
 		spin_unlock(&pcp->lock);
 	}
-
-	pcp_local_unlock(&pagesets.lock, flags);
 }
 
 /*
