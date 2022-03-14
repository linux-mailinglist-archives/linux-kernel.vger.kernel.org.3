Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6ADA14D7990
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 04:09:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236038AbiCNDK7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Mar 2022 23:10:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbiCNDK5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Mar 2022 23:10:57 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACCA23EABD
        for <linux-kernel@vger.kernel.org>; Sun, 13 Mar 2022 20:09:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647227388; x=1678763388;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=1oLdrFBl+WtRXo+l9dtBMSr3UK63CaXWCwzjWkONaG4=;
  b=PVpPCG2xs3exFh00O5MobHHLmz+VENvaoeEX6hbQI4SA5ncAuNFGw7Ew
   fd1kLYuWkxzj2TTuUO2m0rWRzhB2T0BwJAtmcFwcQ4N6ijy5lxk84zoRB
   cbGriuVdUZYUyqLp9PpmgoPtuz+xs7pSEsqggWQSKVMD4XirWLXAjVJJE
   VkCgzUCQEH48ZBnFU/tT7ANgkQvobRTJ/N92XXNpGwb2JZr9vvaQvydcH
   Va1n8LgRKWVzZPtqWe4xLYhCAvNKAkBXCDcXTuNIA9QRX2dprZkTLfl27
   +ef5ImdscO33qnciek0A7QstqXHaIiTVixwizISt915IjTgn1zzLuay6d
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10285"; a="255654289"
X-IronPort-AV: E=Sophos;i="5.90,179,1643702400"; 
   d="scan'208";a="255654289"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2022 20:09:48 -0700
X-IronPort-AV: E=Sophos;i="5.90,179,1643702400"; 
   d="scan'208";a="556190613"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.239.13.94])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2022 20:09:46 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Oscar Salvador <osalvador@suse.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Abhishek Goel <huntbag@linux.vnet.ibm.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm: Only re-generate demotion targets when a numa
 node changes its N_CPU state
References: <20220310120749.23077-1-osalvador@suse.de>
        <87a6dxaxil.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <YisTwzumn3tgL9H4@localhost.localdomain>
Date:   Mon, 14 Mar 2022 11:09:44 +0800
In-Reply-To: <YisTwzumn3tgL9H4@localhost.localdomain> (Oscar Salvador's
        message of "Fri, 11 Mar 2022 10:17:55 +0100")
Message-ID: <878rtd6xhj.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Oscar Salvador <osalvador@suse.de> writes:

> On Fri, Mar 11, 2022 at 01:06:26PM +0800, Huang, Ying wrote:
>> Oscar Salvador <osalvador@suse.de> writes:
>> > -static int __init migrate_on_reclaim_init(void)
>> > -{
>> > -	int ret;
>> > -
>> >  	node_demotion = kmalloc_array(nr_node_ids,
>> >  				      sizeof(struct demotion_nodes),
>> >  				      GFP_KERNEL);
>> >  	WARN_ON(!node_demotion);
>> >  
>> > -	ret = cpuhp_setup_state_nocalls(CPUHP_MM_DEMOTION_DEAD, "mm/demotion:offline",
>> > -					NULL, migration_offline_cpu);
>> >  	/*
>> > -	 * In the unlikely case that this fails, the automatic
>> > -	 * migration targets may become suboptimal for nodes
>> > -	 * where N_CPU changes.  With such a small impact in a
>> > -	 * rare case, do not bother trying to do anything special.
>> > +	 * At this point, all numa nodes with memory/CPus have their state
>> > +	 * properly set, so we can build the demotion order now.
>> >  	 */
>> > -	WARN_ON(ret < 0);
>> > -	ret = cpuhp_setup_state(CPUHP_AP_MM_DEMOTION_ONLINE, "mm/demotion:online",
>> > -				migration_online_cpu, NULL);
>> > -	WARN_ON(ret < 0);
>> > -
>> > +	set_migration_target_nodes();
>> 
>> If my understanding were correct, we should enclose
>> set_migration_target_nodes() here with cpus_read_lock().  And add some
>> comment before set_migration_target_nodes() for this.  I don't know
>> whether the locking order is right.
>
> Oh, I see that cpuhp_setup_state() holds the cpu-hotplug lock while
> calling in, so yeah, we might want to hold in there.
>
> The thing is, not long ago we found out that we could have ACPI events
> like memory-hotplug operations at boot stage [1], so I guess it is
> safe to assume we could also have cpu-hotplug operations at that stage
> as well, and so we want to hold cpus_read_lock() just to be on the safe
> side.
>
> But, unless I am missing something, that does not apply to
> set_migration_target_nodes() being called from a callback,
> as the callback (somewhere up the chain) already holds that lock.
> e.g: (_cpu_up takes cpus_write_lock()) and the same for the down
> operation.
>
> So, to sum it up, we only need the cpus_read_lock() in
> migrate_on_reclaim_init().

Yes.  That is what I want to say.  Sorry for confusing.

>> >  	hotplug_memory_notifier(migrate_on_reclaim_callback, 100);
>> 
>> And we should register the notifier before calling set_migration_target_nodes()?
>
> I cannot made my mind here.
> The primary reason I placed the call before registering the notifier is
> because the original code called set_migration_target_nodes() before
> doing so:
>
> <--
> ret = cpuhp_setup_state(CPUHP_AP_MM_DEMOTION_ONLINE, "mm/demotion:online",
> 			migration_online_cpu, NULL);
> WARN_ON(ret < 0);
>
> hotplug_memory_notifier(migrate_on_reclaim_callback, 100);
> -->
>
> I thought about following the same line. Why do you think it should be
> called afterwards?
>
> I am not really sure whether it has a different impact depending on the
> order.
> Note that memory-hotplug acpi events can happen at boot time, so by the
> time we register the memory_hotplug notifier, we can have some hotplug
> memory coming in, and so we call set_migration_target_nodes().
>
> But that is fine, and I cannot see a difference shufling the order
> of them. 
> Do you see a problem in there?

Per my understanding, the race condition as follows may be possible in
theory,

CPU1                                CPU2
----                                ----
set_migration_target_nodes()
                                <-- // a new node is hotplugged, and missed
hotplug_memory_notifier()

During boot, this may be impossible in practice.  But I still think it's
good to make the order correct in general.  And it's not hard to do that.

Best Regards,
Huang, Ying

> [1] https://patchwork.kernel.org/project/linux-mm/patch/20200915094143.79181-3-ldufour@linux.ibm.com/
