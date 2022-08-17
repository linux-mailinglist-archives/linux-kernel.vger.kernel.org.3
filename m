Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F359E596683
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 03:05:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238012AbiHQBFA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 21:05:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237509AbiHQBE6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 21:04:58 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A1DD7C1AE
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 18:04:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660698298; x=1692234298;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=mfUla04m6g9OuMl10lBVITDIZq8OhojlyKzQdm/DDNg=;
  b=HgxK5ToIH3gbqf2GFZSTc2V2BwvZV9KFooBlyj1UL9DUwPKuivW9kgLP
   8777qFF7WL88HIl/rZchxyNxnurPIhgY2kRP7sSnzEdvKggsVAK3LjRbC
   ns5mGLDUXInkCmon9IXWAGzegiNOR6FkTZwSnx7HBjuDcVy3JQ+euvg/y
   zw0MOgz7wmCblW/VKkVLu6NQtJY5GTjl7fQ4fxLfrjBiGdD7YwmYtOsc7
   lbVpkRHnxbmRUEPx0FTefbCyVO6xzfqIoXLH2jJeiuCsZA0M1AkdrQoZF
   mnEgWN/+tesclCmu/HeVamQ9H0Ix69tg53As2L9RQ+K6ChHRI/DLlm/OF
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10441"; a="378660378"
X-IronPort-AV: E=Sophos;i="5.93,242,1654585200"; 
   d="scan'208";a="378660378"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2022 18:02:18 -0700
X-IronPort-AV: E=Sophos;i="5.93,242,1654585200"; 
   d="scan'208";a="696581283"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2022 18:02:14 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Bharata B Rao <bharata@amd.com>
Cc:     huang ying <huang.ying.caritas@gmail.com>,
        Aneesh Kumar K V <aneesh.kumar@linux.ibm.com>,
        <linux-mm@kvack.org>, <akpm@linux-foundation.org>,
        Wei Xu <weixugc@google.com>, Yang Shi <shy828301@gmail.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Tim C Chen <tim.c.chen@intel.com>,
        Michal Hocko <mhocko@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Hesham Almatary <hesham.almatary@huawei.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Alistair Popple <apopple@nvidia.com>,
        "Dan Williams" <dan.j.williams@intel.com>,
        Johannes Weiner <hannes@cmpxchg.org>, <jvgediya.oss@gmail.com>
Subject: Re: [PATCH v14 04/10] mm/demotion/dax/kmem: Set node's abstract
 distance to MEMTIER_DEFAULT_DAX_ADISTANCE
In-Reply-To: <57a091a5-a78f-7977-3413-11260501f8c0@amd.com> (Bharata B. Rao's
        message of "Tue, 16 Aug 2022 20:15:55 +0530")
References: <20220812055710.357820-1-aneesh.kumar@linux.ibm.com>
        <20220812055710.357820-5-aneesh.kumar@linux.ibm.com>
        <87wnbacjsh.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <cd1c13ee-6fc3-bde8-96f9-8c3c93441275@linux.ibm.com>
        <CAC=cRTMZZ9bqyC7pnxD1zUWqfBiQ9U7im+8EYa_8GVK8iA7HXQ@mail.gmail.com>
        <e5fbaf30-1f97-63de-a9a5-2ae5359120ff@amd.com>
        <CAC=cRTO=+zdKGHRMLpzg2PfJ2rPSQL+xoqA5sAkafaaTYHPr+w@mail.gmail.com>
        <57a091a5-a78f-7977-3413-11260501f8c0@amd.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
Date:   Wed, 17 Aug 2022 09:02:04 +0800
Message-ID: <877d37d6nn.fsf@yhuang6-desk2.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bharata B Rao <bharata@amd.com> writes:

> On 8/16/2022 1:56 PM, huang ying wrote:
> <snip>
>>>>
>>>> If my understanding were correct, you are suggesting to use a kind of
>>>> logarithmic mapping from latency to abstract distance?  That is,
>>>>
>>>>   abstract_distance = log2(latency)
>>>>
>>>> While I am suggesting to use a kind of linear mapping from latency to
>>>> abstract distance.  That is,
>>>>
>>>>   abstract_distance = C * latency
>>>>
>>>> I think that linear mapping is easy to understand.
>>>>
>>>> Are there some good reasons to use logarithmic mapping?
>>>
>>> Also, what is the recommendation for using bandwidth measure which
>>> may be available from HMAT for CXL memory? How is bandwidth going
>>> to influence the abstract distance?
>> 
>> This is a good question.
>> 
>> Per my understanding, latency stands for idle latency by default.  But
>> in practice, the latency under some reasonable memory accessing
>> throughput is the "real" latency.  So the memory with lower bandwidth
>> should have a larger abstract distance than the memory with higher
>> bandwidth even if the idle latency is the same.  But I don't have a
>> perfect formula to combine idle latency and bandwidth into abstract
>> distance.  One possibility is to increase abstract distance if the
>> bandwidth of the memory is much lower than that of DRAM.
>
> So if the firmware/platforms differ in their definition of latency and
> bandwidth (like idle vs real value etc) in the firmware tables
> (like HMAT), then the low level drivers (like ACPI) would have to be
> aware of these and handle the conversion from latency and bw to
> abstract distance correctly?

One possible way to make this a little easier is that we plan to add a
knob (as user space interface via sysfs) for each memory type, so that
the default abstract distance can be offset.  If so, at least we have
way to deal with difference in firmware/platforms.

Best Regards,
Huang, Ying
