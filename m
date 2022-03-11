Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2899C4D5E37
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 10:18:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344505AbiCKJTG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 04:19:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241266AbiCKJTF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 04:19:05 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42B1EEBBB6
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 01:17:59 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 01D0C210FD;
        Fri, 11 Mar 2022 09:17:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1646990278; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZIwsGY7IaLaNCuNB/GMYgm4WxxYBqrvPiFnud/lWki0=;
        b=f/sCKAvo5qXKZODL6GbBGBDvcUCL3nXHUbKdTcYGfVRQiq6unrzoTN+0YJZn3tzlHrzWA1
        TgGwch7hpJJZLuScVo67qQKeqLS3pGHaHPVLVg6+h495l/IM113evs06rsNSoyVT8rAU5F
        /npCO5w2x3Fpm+UtAlT099P1JhwJOM4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1646990278;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZIwsGY7IaLaNCuNB/GMYgm4WxxYBqrvPiFnud/lWki0=;
        b=yB38EpcKFDNBggeC7Yn6rmhywJODN8CN1mF+WDUNgV3Phw6bAiu8I6KWIuoZiPIqToypm4
        zBcyPVXVs5j6R0Dg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8275813A82;
        Fri, 11 Mar 2022 09:17:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id l04kG8UTK2LKUQAAMHmgww
        (envelope-from <osalvador@suse.de>); Fri, 11 Mar 2022 09:17:57 +0000
Date:   Fri, 11 Mar 2022 10:17:55 +0100
From:   Oscar Salvador <osalvador@suse.de>
To:     "Huang, Ying" <ying.huang@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Abhishek Goel <huntbag@linux.vnet.ibm.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm: Only re-generate demotion targets when a numa
 node changes its N_CPU state
Message-ID: <YisTwzumn3tgL9H4@localhost.localdomain>
References: <20220310120749.23077-1-osalvador@suse.de>
 <87a6dxaxil.fsf@yhuang6-desk2.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87a6dxaxil.fsf@yhuang6-desk2.ccr.corp.intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 11, 2022 at 01:06:26PM +0800, Huang, Ying wrote:
> Oscar Salvador <osalvador@suse.de> writes:
> > -static int __init migrate_on_reclaim_init(void)
> > -{
> > -	int ret;
> > -
> >  	node_demotion = kmalloc_array(nr_node_ids,
> >  				      sizeof(struct demotion_nodes),
> >  				      GFP_KERNEL);
> >  	WARN_ON(!node_demotion);
> >  
> > -	ret = cpuhp_setup_state_nocalls(CPUHP_MM_DEMOTION_DEAD, "mm/demotion:offline",
> > -					NULL, migration_offline_cpu);
> >  	/*
> > -	 * In the unlikely case that this fails, the automatic
> > -	 * migration targets may become suboptimal for nodes
> > -	 * where N_CPU changes.  With such a small impact in a
> > -	 * rare case, do not bother trying to do anything special.
> > +	 * At this point, all numa nodes with memory/CPus have their state
> > +	 * properly set, so we can build the demotion order now.
> >  	 */
> > -	WARN_ON(ret < 0);
> > -	ret = cpuhp_setup_state(CPUHP_AP_MM_DEMOTION_ONLINE, "mm/demotion:online",
> > -				migration_online_cpu, NULL);
> > -	WARN_ON(ret < 0);
> > -
> > +	set_migration_target_nodes();
> 
> If my understanding were correct, we should enclose
> set_migration_target_nodes() here with cpus_read_lock().  And add some
> comment before set_migration_target_nodes() for this.  I don't know
> whether the locking order is right.

Oh, I see that cpuhp_setup_state() holds the cpu-hotplug lock while
calling in, so yeah, we might want to hold in there.

The thing is, not long ago we found out that we could have ACPI events
like memory-hotplug operations at boot stage [1], so I guess it is
safe to assume we could also have cpu-hotplug operations at that stage
as well, and so we want to hold cpus_read_lock() just to be on the safe
side.

But, unless I am missing something, that does not apply to
set_migration_target_nodes() being called from a callback,
as the callback (somewhere up the chain) already holds that lock.
e.g: (_cpu_up takes cpus_write_lock()) and the same for the down
operation.

So, to sum it up, we only need the cpus_read_lock() in
migrate_on_reclaim_init().

> >  	hotplug_memory_notifier(migrate_on_reclaim_callback, 100);
> 
> And we should register the notifier before calling set_migration_target_nodes()?

I cannot made my mind here.
The primary reason I placed the call before registering the notifier is
because the original code called set_migration_target_nodes() before
doing so:

<--
ret = cpuhp_setup_state(CPUHP_AP_MM_DEMOTION_ONLINE, "mm/demotion:online",
			migration_online_cpu, NULL);
WARN_ON(ret < 0);

hotplug_memory_notifier(migrate_on_reclaim_callback, 100);
-->

I thought about following the same line. Why do you think it should be
called afterwards?

I am not really sure whether it has a different impact depending on the
order.
Note that memory-hotplug acpi events can happen at boot time, so by the
time we register the memory_hotplug notifier, we can have some hotplug
memory coming in, and so we call set_migration_target_nodes().

But that is fine, and I cannot see a difference shufling the order
of them. 
Do you see a problem in there?

[1] https://patchwork.kernel.org/project/linux-mm/patch/20200915094143.79181-3-ldufour@linux.ibm.com/


-- 
Oscar Salvador
SUSE Labs
