Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D2634CF0D4
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 06:14:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235251AbiCGFPI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 00:15:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230215AbiCGFPG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 00:15:06 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F30D1387A4
        for <linux-kernel@vger.kernel.org>; Sun,  6 Mar 2022 21:14:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646630052; x=1678166052;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=T9LRO1EA9aNE6ZHnL/DaWq8Qv6KP6Ww4LEmcqSgmFVM=;
  b=HxfE/PhrINYnqn7O8Sv3yTvXTHOSDcDBlrQfMfKbkqEq9vvvzVlNpgcD
   ULtRrKxE5vMiTxhKXELWD1AAdfQnj8vQ8QV8Mw4H19nDL2Dyck2DWigyt
   GeKQlhdyuBr0WVQSATxbpd5tEXZeuN04E8yBme4oey6HWO6J2MXf7vOrg
   Sp3uqSvhAbI3fvDnZqFjAdNEJHjdx7MfS9hKXbR8LcNVNlVviutz/RXYm
   ZsxwF20Ji6l/8OsZt60q68gqddyPYjaJ3/g2e7/WoiO9Cv9X+3qutTgPY
   ODzgBBAFMTwMJwoXf+ZcMc4thODbuW5PceqoJB8GOMLIPszOiDHPTAEr+
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10278"; a="234255950"
X-IronPort-AV: E=Sophos;i="5.90,160,1643702400"; 
   d="scan'208";a="234255950"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2022 21:14:12 -0800
X-IronPort-AV: E=Sophos;i="5.90,160,1643702400"; 
   d="scan'208";a="552998917"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.239.13.94])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2022 21:14:07 -0800
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Baolin Wang <baolin.wang@linux.alibaba.com>
Cc:     Miaohe Lin <linmiaohe@huawei.com>, <akpm@linux-foundation.org>,
        <mike.kravetz@oracle.com>, <shy828301@gmail.com>,
        <willy@infradead.org>, <ziy@nvidia.com>, <minchan@kernel.org>,
        <apopple@nvidia.com>, <ave.hansen@linux.intel.com>,
        <o451686892@gmail.com>, <almasrymina@google.com>,
        <jhubbard@nvidia.com>, <rcampbell@nvidia.com>, <peterx@redhat.com>,
        <naoya.horiguchi@nec.com>, <mhocko@suse.com>, <riel@redhat.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 14/16] mm/migration: fix potential invalid node access
 for reclaim-based migration
References: <20220304093409.25829-1-linmiaohe@huawei.com>
        <20220304093409.25829-15-linmiaohe@huawei.com>
        <aa367733-a1e7-10c7-6355-5ed9e502e4c9@linux.alibaba.com>
Date:   Mon, 07 Mar 2022 13:14:05 +0800
In-Reply-To: <aa367733-a1e7-10c7-6355-5ed9e502e4c9@linux.alibaba.com> (Baolin
        Wang's message of "Mon, 7 Mar 2022 10:25:03 +0800")
Message-ID: <87ee3e5opu.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Baolin Wang <baolin.wang@linux.alibaba.com> writes:

> On 3/4/2022 5:34 PM, Miaohe Lin wrote:
>> If we failed to setup hotplug state callbacks for mm/demotion:online in
>> some corner cases, node_demotion will be left uninitialized. Invalid node
>> might be returned from the next_demotion_node() when doing reclaim-based
>> migration. Use kcalloc to allocate node_demotion to fix the issue.
>> Fixes: ac16ec835314 ("mm: migrate: support multiple target nodes
>> demotion")
>> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
>> ---
>>   mm/migrate.c | 6 +++---
>>   1 file changed, 3 insertions(+), 3 deletions(-)
>> diff --git a/mm/migrate.c b/mm/migrate.c
>> index 279940c0c064..7b1c0b988234 100644
>> --- a/mm/migrate.c
>> +++ b/mm/migrate.c
>> @@ -2516,9 +2516,9 @@ static int __init migrate_on_reclaim_init(void)
>>   {
>>   	int ret;
>>   -	node_demotion = kmalloc_array(nr_node_ids,
>> -				      sizeof(struct demotion_nodes),
>> -				      GFP_KERNEL);
>> +	node_demotion = kcalloc(nr_node_ids,
>> +				sizeof(struct demotion_nodes),
>> +				GFP_KERNEL);
>
> Nit: not sure if this is worthy of this rare corner case, but I think
> the target demotion nodes' default value should be NUMA_NO_NODE
> instead of 0.

The "nr" field of "struct demotion_nodes" should be initialized as 0.  I
think that is checked before "nodes[]" field.

Best Regards,
Huang, Ying
