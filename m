Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D1044ADE61
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 17:32:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383442AbiBHQcn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 11:32:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383420AbiBHQcm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 11:32:42 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4B434C061576
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 08:32:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644337960;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BtkJvAo+N9u8Ul05NhvoL9QDcGnWfbGW9BYYZdFX1lY=;
        b=IbdOnHsp8rHImQLEuhPnpb1Jl5WRprTEMYOUrokXzG1CxbuDbVY/eAVYw/fe2MzI4Ag7N/
        RgY/xvguoH/rqU2Wh5pm6TtMUxYXOFbnPftT6rdSQ6MeDQ8MDk4Sq6QrMwDnx/4HqI55vH
        6ykdwcOiyARWt4MjODgtuCshXDQ+y1g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-325-Yz1WSJKINhyj0X1oRqdZwg-1; Tue, 08 Feb 2022 11:32:37 -0500
X-MC-Unique: Yz1WSJKINhyj0X1oRqdZwg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 189D48519E0;
        Tue,  8 Feb 2022 16:32:35 +0000 (UTC)
Received: from fuller.cnet (ovpn-112-4.gru2.redhat.com [10.97.112.4])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6E8B42A174;
        Tue,  8 Feb 2022 16:32:34 +0000 (UTC)
Received: by fuller.cnet (Postfix, from userid 1000)
        id 5BB70416D5DD; Tue,  8 Feb 2022 12:47:10 -0300 (-03)
Date:   Tue, 8 Feb 2022 12:47:10 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     Nicolas Saenz Julienne <nsaenzju@redhat.com>
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, frederic@kernel.org, tglx@linutronix.de,
        mgorman@suse.de, linux-rt-users@vger.kernel.org, vbabka@suse.cz,
        cl@linux.com, paulmck@kernel.org, willy@infradead.org
Subject: Re: [PATCH 2/2] mm/page_alloc: Add remote draining support to
 per-cpu lists
Message-ID: <YgKQfsznPUDN34un@fuller.cnet>
References: <20220208100750.1189808-1-nsaenzju@redhat.com>
 <20220208100750.1189808-3-nsaenzju@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220208100750.1189808-3-nsaenzju@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 08, 2022 at 11:07:50AM +0100, Nicolas Saenz Julienne wrote:
> The page allocator's per-cpu page lists (pcplists) are currently
> protected using local_locks. While performance savvy, this doesn't allow
> for remote access to these structures. CPUs requiring system-wide
> changes to the per-cpu lists get around this by scheduling
> workers on each CPU. That said, some setups like NOHZ_FULL CPUs,
> aren't well suited to this since they can't handle interruptions
> of any sort.
> 
> To mitigate this, replace the current draining mechanism with one that
> allows remotely draining the lists:
> 
>  - Each CPU now has two pcplists pointers: one that points to a pcplists
>    instance that is in-use, 'pcp->lp', another that points to an idle
>    and empty instance, 'pcp->drain'. CPUs access their local pcplists
>    through 'pcp->lp' and the pointer is dereferenced atomically.
> 
>  - When a CPU decides it needs to empty some remote pcplists, it'll
>    atomically exchange the remote CPU's 'pcp->lp' and 'pcp->drain'
>    pointers. A remote CPU racing with this will either have:
> 
>      - An old 'pcp->lp' reference, it'll soon be emptied by the drain
>        process, we just have to wait for it to finish using it.
> 
>      - The new 'pcp->lp' reference, that is, an empty pcplists instance.
>        rcu_replace_pointer()'s release semantics ensures any prior
>        changes will be visible by the remote CPU, for example: changes
>        to 'pcp->high' and 'pcp->batch' when disabling the pcplists.
> 
>  - The CPU that started the drain can now wait for an RCU grace period
>    to make sure the remote CPU is done using the old pcplists.
>    synchronize_rcu() counts as a full memory barrier, so any changes the
>    local CPU makes to the soon to be drained pcplists will be visible to
>    the draining CPU once it returns.
> 
>  - Then the CPU can safely free the old pcplists. Nobody else holds a
>    reference to it. Note that concurrent access to the remote pcplists
>    drain is protected by the 'pcpu_drain_mutex'.
> 
> >From an RCU perspective, we're only protecting access to the pcplists
> pointer, the drain operation is the writer and the local_lock critical
> sections are the readers. RCU guarantees atomicity both while
> dereferencing the pcplists pointer and replacing it. It also checks for
> RCU critical section/locking correctness, as all readers have to hold
> their per-cpu pagesets local_lock, which also counts as a critical
> section from RCU's perspective.
> 
> >From a performance perspective, on production configurations, the patch
> adds an extra dereference to all hot paths (under such circumstances
> rcu_dereference() will simplify to READ_ONCE()). Extensive measurements
> have been performed on different architectures to ascertain the
> performance impact is minimal. Most platforms don't see any difference
> and the worst-case scenario shows a 1-3% degradation on a page
> allocation micro-benchmark. See cover letter for in-depth results.
> 
> Accesses to the pcplists like the ones in mm/vmstat.c don't require RCU
> supervision since they can handle outdated data, but they do use
> rcu_access_pointer() to avoid compiler weirdness make sparse happy.
> 
> Note that special care has been taken to verify there are no races with
> the memory hotplug code paths. Notably with calls to zone_pcp_reset().
> As Mel Gorman explains in a previous patch[1]: "The existing hotplug
> paths guarantees the pcplists cannot be used after zone_pcp_enable()
> [the one in offline_pages()]. That should be the case already because
> all the pages have been freed and there is no page to put on the PCP
> lists."
> 
> All in all, this technique allows for remote draining on all setups with
> an acceptable performance impact. It benefits all sorts of use cases:
> low-latency, real-time, HPC, idle systems, KVM guests.
> 
> [1] 8ca559132a2d ("mm/memory_hotplug: remove broken locking of zone PCP
>     structures during hot remove")
> 
> Signed-off-by: Nicolas Saenz Julienne <nsaenzju@redhat.com>
> ---
> 
> Changes since RFC:
>  - Avoid unnecessary spin_lock_irqsave/restore() in free_pcppages_bulk()
>  - Add more detail to commit and code comments.
>  - Use synchronize_rcu() instead of synchronize_rcu_expedited(), the RCU
>    documentation says to avoid it unless really justified. I don't think
>    it's justified here, if we can schedule and join works, waiting for
>    an RCU grace period is OK.

https://patchwork.ozlabs.org/project/netdev/patch/1306228052.3026.16.camel@edumazet-laptop/

Adding 100ms to direct reclaim path might be problematic. It will also
slowdown kcompactd (note it'll call drain_all_pages for each zone).

>  - Avoid sparse warnings by using rcu_access_pointer() and
>    rcu_dereference_protected().
> 
>  include/linux/mmzone.h |  22 +++++-
>  mm/page_alloc.c        | 155 ++++++++++++++++++++++++++---------------
>  mm/vmstat.c            |   6 +-
>  3 files changed, 120 insertions(+), 63 deletions(-)
> 
> diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
> index b4cb85d9c6e8..b0b593fd8e48 100644
> --- a/include/linux/mmzone.h
> +++ b/include/linux/mmzone.h
> @@ -388,13 +388,31 @@ struct per_cpu_pages {
>  	short expire;		/* When 0, remote pagesets are drained */
>  #endif
>  
> -	struct pcplists *lp;
> +	/*
> +	 * As a rule of thumb, any access to struct per_cpu_pages's 'lp' has
> +	 * happen with the pagesets local_lock held and using
> +	 * rcu_dereference_check(). If there is a need to modify both
> +	 * 'lp->count' and 'lp->lists' in the same critical section 'pcp->lp'
> +	 * can only be derefrenced once. See for example:

Typo.

