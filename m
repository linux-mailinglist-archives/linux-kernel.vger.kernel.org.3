Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 705E44AD316
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 09:21:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349251AbiBHIVA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 03:21:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349199AbiBHIUp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 03:20:45 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AF8CC03FEDC
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 00:19:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644308396; x=1675844396;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=tuIR9wF0k+6Vhg3ZZvw4XQ2JjoGwBZ5JjajcPWMoMh8=;
  b=bW4c3AMAWcSipm+vvG/WWWAfR5yTsqqmk3vEQF11fPLZKWSSEK5ZNmy0
   HfSUdkxsXFbsxXzuRQ2FFkkf0I5qImk6JqrHmBpnbG0XLRuHxNQA5Klrl
   0o1CT6CMmZJ9vTrZI75QzI/RUTCWAKJL/7HYiEJq8ku19e8YdfM+PdoL0
   nlMdEbUMEljdRVvEQ4bOABX+0lti3wv2JxOHhjJBp8AWo5AyNXYC8tJuZ
   N6jk+MupxNS6IrlJlVkFHpuJwazxnnV+d+hHTgOPdFqICPR6Wf0zcVkNw
   2ZROS7Mp1HjDlC9qlDzTt3gkmRR530hPviVy+TF5jYWmdgCCrzxeTru0f
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10251"; a="232466294"
X-IronPort-AV: E=Sophos;i="5.88,352,1635231600"; 
   d="scan'208";a="232466294"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2022 00:19:56 -0800
X-IronPort-AV: E=Sophos;i="5.88,352,1635231600"; 
   d="scan'208";a="525460508"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.239.13.11])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2022 00:19:54 -0800
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Mel Gorman <mgorman@suse.de>, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>, Rik van Riel <riel@surriel.com>
Subject: Re: [RFC PATCH 2/2] NUMA balancing: avoid to migrate task to
 CPU-less node
References: <20220128023842.1946583-1-ying.huang@intel.com>
        <20220128023842.1946583-2-ying.huang@intel.com>
        <20220128053341.GB618915@linux.vnet.ibm.com>
        <877dakti0n.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <20220201055904.GD618915@linux.vnet.ibm.com>
Date:   Tue, 08 Feb 2022 16:19:52 +0800
In-Reply-To: <20220201055904.GD618915@linux.vnet.ibm.com> (Srikar Dronamraju's
        message of "Tue, 1 Feb 2022 11:29:04 +0530")
Message-ID: <8735ktn51z.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Srikar Dronamraju <srikar@linux.vnet.ibm.com> writes:

> * Huang, Ying <ying.huang@intel.com> [2022-01-28 15:51:36]:
>
>> Srikar Dronamraju <srikar@linux.vnet.ibm.com> writes:
>> 
>> > * Huang Ying <ying.huang@intel.com> [2022-01-28 10:38:42]:
>> >
>> This sounds reasonable.  How about the following solution?  If a
>> CPU-less node is selected as migration target, we select a nearest node
>> with CPU instead?  That is, something like the below patch.
>> 
>> Best Regards,
>> Huang, Ying
>> 
>> ------------------------------8<---------------------------------
>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>> index 5146163bfabb..52d926d8cbdb 100644
>> --- a/kernel/sched/fair.c
>> +++ b/kernel/sched/fair.c
>> @@ -2401,6 +2401,23 @@ static void task_numa_placement(struct task_struct *p)
>>  		}
>>  	}
>> 
>> +	/* Cannot migrate task to CPU-less node */
>> +	if (!node_state(max_nid, N_CPU)) {
>> +		int near_nid = max_nid;
>> +		int distance, near_distance = INT_MAX;
>> +
>> +		for_each_online_node(nid) {
>> +			if (!node_state(nid, N_CPU))
>> +				continue;
>> +			distance = node_distance(max_nid, nid);
>> +			if (distance < near_distance) {
>> +				near_nid = nid;
>> +				near_distance = distance;
>> +			}
>> +		}
>> +		max_nid = near_nid;
>> +	}
>> +
>
>
> This looks good. but should we move this into preferred_group_nid()?

Yes.  We need to take care of preferred_group_nid() too.  Will do that
in the next version.

> i.e should we care for !ng case, since those would mean only private faults.

IMO we need to care for !ng case.  If the fault number of the CPU-less
node is the max, we need to migrate to the nearest node with CPU
instead.

Best Regards,
Huang, Ying

>>  	if (ng) {
>>  		numa_group_count_active_nodes(ng);
>>  		spin_unlock_irq(group_lock);
