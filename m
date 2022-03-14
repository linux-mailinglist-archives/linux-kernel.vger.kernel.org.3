Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B265E4D790A
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 02:04:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229568AbiCNBFP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Mar 2022 21:05:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229831AbiCNBFN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Mar 2022 21:05:13 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5481D46659
        for <linux-kernel@vger.kernel.org>; Sun, 13 Mar 2022 18:04:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647219844; x=1678755844;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=ySgDxotKJSJVAy+FBzbr2z38YaeYDTtZKQwAu4elqtM=;
  b=gxJRtZN0thWYqoh+nt9gxQ8BhWhSczQYxmFxekB+c2nxIpfvwiUn4lQa
   0r8lEg9e+DxXTB8MbHpGPsj0cZXKEQmLq9u8DYpsVJvZlUc8wIP1FYoE/
   cXETyGV6pu07HOqI98PG24xkb//e9k3V6mM+uYb+Gv4p8rx5hBSQ8kr+m
   BMQplBHUgTTf/i5xFT8eskRvyPEPnyVh1NmVglkPHGsrjSyoVCdEuls0K
   J9OGTYD4fDFAqFq0K0UzkwMXs9doKFpJIXH8CwcV0Uxramn+6z2DlpU7+
   AVWj7xiy6WvcjkmJVOWpW5LLT5jK8TXkSqPsqgPuMO9ruWC4EPALZRX2s
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10285"; a="235859180"
X-IronPort-AV: E=Sophos;i="5.90,179,1643702400"; 
   d="scan'208";a="235859180"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2022 18:04:04 -0700
X-IronPort-AV: E=Sophos;i="5.90,179,1643702400"; 
   d="scan'208";a="556160523"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.239.13.94])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2022 18:04:01 -0700
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
        <87mthxb514.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <YisK2PEkKAqtZPfp@localhost.localdomain>
Date:   Mon, 14 Mar 2022 09:03:59 +0800
In-Reply-To: <YisK2PEkKAqtZPfp@localhost.localdomain> (Oscar Salvador's
        message of "Fri, 11 Mar 2022 09:39:52 +0100")
Message-ID: <87czip73b4.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Oscar Salvador <osalvador@suse.de> writes:

> On Fri, Mar 11, 2022 at 10:24:07AM +0800, Huang, Ying wrote:
>> It may be unnecessary to be fixed in this patch.  But I think we need to
>> cleanup the kernel config dependencies of the demotion code at some time.
>
> I am glad you brought this up because it is something I have been
> thinking about.
> I already added it in my to-do list, but I would do it in a separate
> patch if you do not mind.

Thanks!

> Now, let us try to untangle this mess:
>
>> 1. Even if !defined(CONFIG_HOTPLUG_CPU) &&
>>    !defined(CONFIG_MEMORY_HOTPLUG), we still need to allocate
>>    "node_demotion" and call set_migration_target_nodes() during boot time.
>> 
>> 2. If !defined(CONFIG_MEMORY_HOTPLUG), we don't need
>>    migrate_on_reclaim_callback().
>> 
>> 3. We need defined(CONFIG_NUMA) && defined(CONFIG_MIGRATION) for all
>>    these code.
>
> Back in the early versions [1] I asked whether we could have some
> scenario where this feature could be used when !CONFIG_MEMORY_HOTPLUG
> [2].
> The reason I was given is that in order to bind the expose PMEM memory
> as RAM (add_memory_driver_managed()), we need MEMORY_HOTPLUG.
>
> Now, as I said back then, I am not sure whether PMEM memory can be
> exposed as RAM by other means, but as it was pointed out back then,
> it really looks like we, at least, need CONFIG_MEMORY_HOTPLUG.
>
> Ok, so we have our first dependency: CONFIG_MEMORY_HOTPLUG.

On host machine, PMEM is always exposed via memory hotplug.  But later
on, we found that for guest system it's possible for PMEM to be exposed
as normal memory.

Best Regards,
Huang, Ying

> Now, about CONFIG_HOTPLUG_CPU, it seems that that is not a strong dependency,
> as we do not need cpu-hotplug in order to use the feature.
>
> We definitely need CONFIG_MIGRATION and CONFIG_NUMA though.
>
> So, we have something like:
>
> - Depends:
>   * CONFIG_NUMA           (obvius)
>   * CONFIG_MIGRATION      (to migrate between nodes)
>   * CONFIG_MEMORY_HOTPLUG (to expose PMEM as RAM)
>
> Sounds about right?
>
> [1] https://patchwork.kernel.org/project/linux-mm/patch/20210401183221.977831DE@viggo.jf.intel.com/#24099405
> [2] https://patchwork.kernel.org/project/linux-mm/patch/20210401183221.977831DE@viggo.jf.intel.com/#24103467
