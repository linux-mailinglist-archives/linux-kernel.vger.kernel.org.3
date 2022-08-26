Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D57295A1DAF
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 02:26:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233208AbiHZA0D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 20:26:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233230AbiHZAZ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 20:25:59 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 843C25303A
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 17:25:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661473558; x=1693009558;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=XLkLlYDs/lYdRBUE65t1WNh/ERtN5czrzdjpPe9X9h0=;
  b=dXanCYwrogHHy6dAdXfL+DcpPRzlmc9NTDbnJKkB5DUB/WjZcKHRr1c6
   gJmXAFK5pUmor4ia1JfyYV7diArWV3F2oKrqV9/HjNsAzVrvfpaI8/J4V
   Tu6neG8xkJgqgdk4/8qu+KdOM+FGE0h/8mFuM9wMU1okeMhEe+IQMdTNu
   X90Z0ooOMmUEbqKpmmbgbEAyOYsuTGgDarSUZ4qvNo+iPXdWib8pqTD07
   wXJlbXcWxCu1uwQQRrusLX6NtmqfDS6yidXz0yjBUNKGgZr/qVci5cbWz
   sDXKx7dSFqDnMewl4wCfIAVEgT82CkqtULS19RKfJnn2O4mm8GQyqrwZE
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10450"; a="358357082"
X-IronPort-AV: E=Sophos;i="5.93,264,1654585200"; 
   d="scan'208";a="358357082"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2022 17:25:57 -0700
X-IronPort-AV: E=Sophos;i="5.93,264,1654585200"; 
   d="scan'208";a="587100037"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2022 17:25:53 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Aneesh Kumar K V <aneesh.kumar@linux.ibm.com>
Cc:     David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
        akpm@linux-foundation.org, Wei Xu <weixugc@google.com>,
        Yang Shi <shy828301@gmail.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Tim C Chen <tim.c.chen@intel.com>,
        Michal Hocko <mhocko@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Hesham Almatary <hesham.almatary@huawei.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Alistair Popple <apopple@nvidia.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Johannes Weiner <hannes@cmpxchg.org>, jvgediya.oss@gmail.com,
        Bharata B Rao <bharata@amd.com>
Subject: Re: [PATCH] mm/demotion: Fix kernel error with memory hotplug
References: <20220825092019.379069-1-aneesh.kumar@linux.ibm.com>
        <0602b3b4-214f-94b1-61fe-2b2528ff529b@redhat.com>
        <5b0d911b-4cc2-f1ae-b33b-79aca6e3124c@linux.ibm.com>
Date:   Fri, 26 Aug 2022 08:25:42 +0800
In-Reply-To: <5b0d911b-4cc2-f1ae-b33b-79aca6e3124c@linux.ibm.com> (Aneesh
        Kumar K. V.'s message of "Thu, 25 Aug 2022 18:23:59 +0530")
Message-ID: <87k06v3l6h.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Aneesh Kumar K V <aneesh.kumar@linux.ibm.com> writes:

> On 8/25/22 5:46 PM, David Hildenbrand wrote:
>> On 25.08.22 11:20, Aneesh Kumar K.V wrote:
>>> On memory hot unplug, the kernel removes the node memory type
>>> from the associated memory tier. Use list_del_init instead of
>>> list del such that the same memory type can be added back
>>> to a memory tier on hotplug.
>>>
>>> Without this, we get the below warning and return error on
>>> adding memory type to a new memory tier.
>>>
>>> [   33.596095] ------------[ cut here ]------------
>>> [   33.596099] WARNING: CPU: 3 PID: 667 at mm/memory-tiers.c:115 set_node_memory_tier+0xd6/0x2e0
>>> [   33.596109] Modules linked in: kmem
>>>
>>> ...
>>>
>>> [   33.596126] RIP: 0010:set_node_memory_tier+0xd6/0x2e0
>>>
>>> ....
>>> [   33.596196]  memtier_hotplug_callback+0x48/0x68
>>> [   33.596204]  blocking_notifier_call_chain+0x80/0xc0
>>> [   33.596211]  online_pages+0x25e/0x280
>>> [   33.596218]  memory_block_change_state+0x176/0x1f0
>>> [   33.596225]  memory_subsys_online+0x37/0x40
>>> [   33.596230]  online_store+0x9b/0x130
>>> [   33.596236]  kernfs_fop_write_iter+0x128/0x1b0
>>> [   33.596242]  vfs_write+0x24b/0x2c0
>>> [   33.596249]  ksys_write+0x74/0xe0
>>> [   33.596254]  do_syscall_64+0x43/0x90
>>> [   33.596259]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
>>>
>>> Fixes: mm/demotion: Add hotplug callbacks to handle new numa node onlined
>> 
>> Do we have a proper 12-digit commit id as well?
>> 
>> Do we have to cc stable?
>> 
>
> That patch is not yet merged upstream. It is in mm-unstable. I guess Andrew can fold the change
> into the original patch?

I think it may better to reply the original patch and name this patch as
fix, for example,

  mm/demotion: Add hotplug callbacks to handle new numa node onlined fix

I found Andrew uses this kind of name before for fixing.

Best Regards,
Huang, Ying
