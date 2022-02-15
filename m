Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 272164B69B2
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 11:49:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236682AbiBOKtM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 05:49:12 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236021AbiBOKtI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 05:49:08 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E6EDCF391
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 02:48:57 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 386AF1F38A;
        Tue, 15 Feb 2022 10:48:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1644922136; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=m7XXWVLfP+1N3uj7TDnQ4HCyXl/MYTfBV62mk0GlDAw=;
        b=z8nPDh0MPFO6nXgUSaV3eC4F0EUO7NlCynZF56nbti6261fZw8VGpEqOczfROjNycq1ab3
        iSlVRxrBTnKU3F7YpE+gjWQ6Uzu4PPvPN+6ZNHAcXIIOexmgQF+D+pAvA1dZSWjL3LaY7j
        Xc8rNM6eEEim3VOHsIf4rXh51vL7y1E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1644922136;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=m7XXWVLfP+1N3uj7TDnQ4HCyXl/MYTfBV62mk0GlDAw=;
        b=3QLkWUR1PMVMmc09EU3ZnCMdppFBn4UJdgfO/X6pkDA2hhwMNi8LZHaq7rejvBF+pAzONB
        6kFc9ZEn7QmN5ZDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 96F0D13C51;
        Tue, 15 Feb 2022 10:48:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id LKyHIReFC2LPKQAAMHmgww
        (envelope-from <osalvador@suse.de>); Tue, 15 Feb 2022 10:48:55 +0000
Date:   Tue, 15 Feb 2022 11:48:53 +0100
From:   osalvador <osalvador@suse.de>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Rafael Parra <rparrazo@redhat.com>
Subject: Re: [PATCH v2 2/2] drivers/base/memory: determine and store zone for
 single-zone memory blocks
Message-ID: <YguFFRiNIktJhGnT@localhost.localdomain>
References: <20220210184359.235565-1-david@redhat.com>
 <20220210184359.235565-3-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220210184359.235565-3-david@redhat.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 10, 2022 at 07:43:59PM +0100, David Hildenbrand wrote:
> test_pages_in_a_zone() is just another nasty PFN walker that can easily
> stumble over ZONE_DEVICE memory ranges falling into the same memory block
> as ordinary system RAM: the memmap of parts of these ranges might possibly
> be uninitialized. In fact, we observed (on an older kernel) with UBSAN:
> 
> [ 7691.855626] UBSAN: Undefined behaviour in ./include/linux/mm.h:1133:50
> [ 7691.862155] index 7 is out of range for type 'zone [5]'
> [ 7691.867393] CPU: 121 PID: 35603 Comm: read_all Kdump: loaded Tainted: [...]
> [ 7691.879990] Hardware name: Dell Inc. PowerEdge R7425/08V001, BIOS 1.12.2 11/15/2019
> [ 7691.887643] Call Trace:
> [ 7691.890107]  dump_stack+0x9a/0xf0
> [ 7691.893438]  ubsan_epilogue+0x9/0x7a
> [ 7691.897025]  __ubsan_handle_out_of_bounds+0x13a/0x181
> [ 7691.902086]  ? __ubsan_handle_shift_out_of_bounds+0x289/0x289
> [ 7691.907841]  ? sched_clock_cpu+0x18/0x1e0
> [ 7691.911867]  ? __lock_acquire+0x610/0x38d0
> [ 7691.915979]  test_pages_in_a_zone+0x3c4/0x500
> [ 7691.920357]  show_valid_zones+0x1fa/0x380
> [ 7691.924375]  ? print_allowed_zone+0x80/0x80
> [ 7691.928571]  ? __lock_is_held+0xb4/0x140
> [ 7691.932509]  ? __lock_is_held+0xb4/0x140
> [ 7691.936447]  ? dev_attr_store+0x70/0x70
> [ 7691.940296]  dev_attr_show+0x43/0xb0
> [ 7691.943884]  ? memset+0x1f/0x40
> [ 7691.947042]  sysfs_kf_seq_show+0x1c5/0x440
> [ 7691.951153]  seq_read+0x49d/0x1190
> [ 7691.954574]  ? seq_escape+0x1f0/0x1f0
> [ 7691.958249]  ? fsnotify_first_mark+0x150/0x150
> [ 7691.962713]  vfs_read+0xff/0x300
> [ 7691.965952]  ksys_read+0xb8/0x170
> [ 7691.969279]  ? kernel_write+0x130/0x130
> [ 7691.973126]  ? entry_SYSCALL_64_after_hwframe+0x7a/0xdf
> [ 7691.978365]  ? do_syscall_64+0x22/0x4b0
> [ 7691.982212]  do_syscall_64+0xa5/0x4b0
> [ 7691.985887]  entry_SYSCALL_64_after_hwframe+0x6a/0xdf
> [ 7691.990947] RIP: 0033:0x7f01f4439b52
> 
> We seem to stumble over a memmap that contains a garbage zone id. While
> we could try inserting pfn_to_online_page() calls, it will just make
> memory offlining slower, because we use test_pages_in_a_zone() to make
> sure we're offlining pages that all belong to the same zone.
> 
> Let's just get rid of this PFN walker and determine the single zone
> of a memory block -- if any -- for early memory blocks during boot. For
> memory onlining, we know the single zone already. Let's avoid any
> additional memmap scanning and just rely on the zone information
> available during boot.
> 
> For memory hot(un)plug, we only really care about memory blocks that:
> * span a single zone (and, thereby, a single node)
> * are completely System RAM (IOW, no holes, no ZONE_DEVICE)
> If one of these conditions is not met, we reject memory offlining.
> Hotplugged memory blocks (starting out offline), always meet both
> conditions.
> 
> There are three scenarios to handle:
> 
> (1) Memory hot(un)plug
> 
> A memory block with zone == NULL cannot be offlined, corresponding to
> our previous test_pages_in_a_zone() check.
> 
> After successful memory onlining/offlining, we simply set the zone
> accordingly.
> * Memory onlining: set the zone we just used for onlining
> * Memory offlining: set zone = NULL
> 
> So a hotplugged memory block starts with zone = NULL. Once memory
> onlining is done, we set the proper zone.
> 
> (2) Boot memory with !CONFIG_NUMA
> 
> We know that there is just a single pgdat, so we simply scan all zones
> of that pgdat for an intersection with our memory block PFN range when
> adding the memory block. If more than one zone intersects (e.g., DMA and
> DMA32 on x86 for the first memory block) we set zone = NULL and
> consequently mimic what test_pages_in_a_zone() used to do.
> 
> (3) Boot memory with CONFIG_NUMA
> 
> At the point in time we create the memory block devices during boot, we
> don't know yet which nodes *actually* span a memory block. While we could
> scan all zones of all nodes for intersections, overlapping nodes complicate
> the situation and scanning all nodes is possibly expensive. But that
> problem has already been solved by the code that sets the node of a memory
> block and creates the link in the sysfs --
> do_register_memory_block_under_node().
> 
> So, we hook into the code that sets the node id for a memory block. If
> we already have a different node id set for the memory block, we know
> that multiple nodes *actually* have PFNs falling into our memory block:
> we set zone = NULL and consequently mimic what test_pages_in_a_zone() used
> to do. If there is no node id set, we do the same as (2) for the given
> node.
> 
> Note that the call order in driver_init() is:
> -> memory_dev_init(): create memory block devices
> -> node_dev_init(): link memory block devices to the node and set the
> 		    node id
> 
> So in summary, we detect if there is a single zone responsible for this
> memory block and we consequently store the zone in that case in the
> memory block, updating it during memory onlining/offlining.
> 
> Reported-by: Rafael Parra <rparrazo@redhat.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>

Hi David

Reviewed-by: Oscar Salvador <osalvador@suse.de>

One minor thing below: 

> @@ -663,6 +743,17 @@ static int init_memory_block(unsigned long block_id, unsigned long state,
>  	mem->nr_vmemmap_pages = nr_vmemmap_pages;
>  	INIT_LIST_HEAD(&mem->group_next);
>  
> +#ifndef CONFIG_NUMA
> +	if (state == MEM_ONLINE)
> +		/*
> +		 * MEM_ONLINE at this point implies early memory. With NUMA,
> +		 * we'll determine the zone when setting the node id via
> +		 * memory_block_add_nid(). Memory hotplug updated the zone
> +		 * manually when memory onlining/offlining succeeds.
> +		 */
> +		mem->zone = early_node_zone_for_memory_block(mem, NUMA_NO_NODE);

I took me a couple of minutes to figure out that MEM_ONLINE implies
early memory at this point because 1) of course early memory must be
online and 2) the only caller that passes MEM_ONLINE to
init_memory_block() is add_memory_block(), which only gets called at
boot time. (btw, add_memory_block() really should use __init, right?)

I guess what I am saying here is: I really like the comment, but I am not sure
whether other people with a drifting brain like mine will also wonder about
that.


--
Oscar Salvador
SUSE Labs
