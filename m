Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBE85586270
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 04:15:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237864AbiHACP3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jul 2022 22:15:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233450AbiHACP1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jul 2022 22:15:27 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C1806333
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jul 2022 19:15:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659320126; x=1690856126;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=0dkdwZhWtVX2hh1joNPi9o16J5ddF58YnogdpW4lxAM=;
  b=mmsW25Foaxgtt/QzFhEnD9JCxB0smqnLxtNi2qM84NN/xEE9yRLYG+g0
   /LMJTUEQawhAOpocH36FiWdRw/Bo8hPbtusHe+SdYg2YmPPogabIN+uQ4
   TGDKwNe0bSV5lL4SeAnDrOrQv9hx5QxuptjxsdUoaV9eeMJthUZeHdtgP
   53DMcOoBmX9JRJkgU5TWmRFhBaj1jrzvn+4Io7oqgHKQNT7AUT+thJeha
   0ygY6z4sDbL9TpDIEVbyOAyJn+/b0c162zCp8zUs6a7nwbGdiJkDk1onP
   Hc4PoALpZV51sjNQ0eLfbOWx7UCjV6+/8spEOSopc8q6vfjqykNBVMLGc
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10425"; a="286605396"
X-IronPort-AV: E=Sophos;i="5.93,206,1654585200"; 
   d="scan'208";a="286605396"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2022 19:15:25 -0700
X-IronPort-AV: E=Sophos;i="5.93,206,1654585200"; 
   d="scan'208";a="577617016"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2022 19:15:21 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org,
        Wei Xu <weixugc@google.com>, Yang Shi <shy828301@gmail.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Tim C Chen <tim.c.chen@intel.com>,
        Michal Hocko <mhocko@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Hesham Almatary <hesham.almatary@huawei.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Alistair Popple <apopple@nvidia.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Johannes Weiner <hannes@cmpxchg.org>, jvgediya.oss@gmail.com
Subject: Re: [PATCH v11 5/8] mm/demotion: Build demotion targets based on
 explicit memory tiers
References: <20220728190436.858458-1-aneesh.kumar@linux.ibm.com>
        <20220728190436.858458-6-aneesh.kumar@linux.ibm.com>
        <87wnbwl92w.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <878rocs7ru.fsf@linux.ibm.com>
Date:   Mon, 01 Aug 2022 10:15:17 +0800
In-Reply-To: <878rocs7ru.fsf@linux.ibm.com> (Aneesh Kumar K. V.'s message of
        "Fri, 29 Jul 2022 12:52:13 +0530")
Message-ID: <87fsiglney.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com> writes:

> "Huang, Ying" <ying.huang@intel.com> writes:
>
>> "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com> writes:
>> + */
>
> ....
>
>>> +int next_demotion_node(int node)
>>> +{
>>> +	struct demotion_nodes *nd;
>>> +	int target;
>>> +
>>> +	if (!node_demotion)
>>> +		return NUMA_NO_NODE;
>>> +
>>> +	nd = &node_demotion[node];
>>> +
>>> +	/*
>>> +	 * node_demotion[] is updated without excluding this
>>> +	 * function from running.
>>> +	 *
>>> +	 * Make sure to use RCU over entire code blocks if
>>> +	 * node_demotion[] reads need to be consistent.
>>> +	 */
>>> +	rcu_read_lock();
>>> +	/*
>>> +	 * If there are multiple target nodes, just select one
>>> +	 * target node randomly.
>>> +	 *
>>> +	 * In addition, we can also use round-robin to select
>>> +	 * target node, but we should introduce another variable
>>> +	 * for node_demotion[] to record last selected target node,
>>> +	 * that may cause cache ping-pong due to the changing of
>>> +	 * last target node. Or introducing per-cpu data to avoid
>>> +	 * caching issue, which seems more complicated. So selecting
>>> +	 * target node randomly seems better until now.
>>> +	 */
>>> +	target = node_random(&nd->preferred);
>>
>> Don't find code to optimize node_random() for weight == 1 case, forget
>> to do that?
>
> I guess you suggested to do that as the patch for node_random or did I
> got the review feedback wrong?

Yes.

> https://lore.kernel.org/linux-mm/87y1wdn30p.fsf@yhuang6-desk2.ccr.corp.intel.com
>
> The change for node_random will be patch outside this series.

I think we can include it in this series.  Because the series provide
more information about why we need the change.

Best Regards,
Huang, Ying

