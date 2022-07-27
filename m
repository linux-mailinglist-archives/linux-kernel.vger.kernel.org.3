Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C437581CF9
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 03:16:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240122AbiG0BQZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 21:16:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230412AbiG0BQW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 21:16:22 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 481CA2A261
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 18:16:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658884582; x=1690420582;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=iPdXmQ179/RmymAUmqn4R6JR+2WpZ7duivhKTTYWM9A=;
  b=nMlqwcGXWscMaHmeJmokxyWYjx7WEbPBxG0GikuDB0Aflispen5gf5TZ
   ebuC0kqt/GXyKqfL8ekssAT+Fn6d9nGrA5U0FDvx1FgFYi6ts5R8wnIqN
   wc5wytpk16Oc24e079djixZ2O0F+Y6/ChELU4sQgxvkgsunQcTjIflNWh
   WCEwPfofsvgq6HTyRlDo6W1uFkBl5sRbgmH2mjcIAcKdaQiopilf7ZNTZ
   2Q49sTnWasB3LzGsbOE0FZ0MUCX6W7Na/NQz9xTbdqYQ2hEoaWhpdiD8Z
   UqNTfCmJbWXILyA+og07qrz3FbRXCV8IkN7Emz2QRKQ7k+GfkKoB6tUsq
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10420"; a="267883154"
X-IronPort-AV: E=Sophos;i="5.93,194,1654585200"; 
   d="scan'208";a="267883154"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2022 18:16:21 -0700
X-IronPort-AV: E=Sophos;i="5.93,194,1654585200"; 
   d="scan'208";a="575754964"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.239.13.94])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2022 18:16:17 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Aneesh Kumar K V <aneesh.kumar@linux.ibm.com>,
        Wei Xu <weixugc@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org,
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
        jvgediya.oss@gmail.com, Jagdish Gediya <jvgediya@linux.ibm.com>
Subject: Re: [PATCH v10 1/8] mm/demotion: Add support for explicit memory tiers
References: <20220720025920.1373558-1-aneesh.kumar@linux.ibm.com>
        <20220720025920.1373558-2-aneesh.kumar@linux.ibm.com>
        <87k080wmvb.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <9e9ba2e4-3a87-3a79-e336-8849dad4856a@linux.ibm.com>
Date:   Wed, 27 Jul 2022 09:16:08 +0800
In-Reply-To: <9e9ba2e4-3a87-3a79-e336-8849dad4856a@linux.ibm.com> (Aneesh
        Kumar K. V.'s message of "Tue, 26 Jul 2022 17:29:56 +0530")
Message-ID: <87lesfuzhj.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Aneesh Kumar K V <aneesh.kumar@linux.ibm.com> writes:

>>> diff --git a/include/linux/node.h b/include/linux/node.h
>>> index 40d641a8bfb0..a2a16d4104fd 100644
>>> --- a/include/linux/node.h
>>> +++ b/include/linux/node.h
>>> @@ -92,6 +92,12 @@ struct node {
>>>  	struct list_head cache_attrs;
>>>  	struct device *cache_dev;
>>>  #endif
>>> +	/*
>>> +	 * For memory devices, perf_level describes
>>> +	 * the device performance and how it should be used
>>> +	 * while building a memory hierarchy.
>>> +	 */
>>> +	int perf_level;
>> 
>> Think again, I found that "perf_level" may be not the best abstraction
>> of the performance of memory devices.  In concept, it's an abstraction of the memory
>> bandwidth.  But it will not reflect the memory latency.
>> 
>> Instead, the previous proposed "abstract_distance" is an abstraction of
>> the memory latency.  Per my understanding, the memory latency has more
>> direct influence on system performance.  And because the latency of the
>> memory device will increase if the memory accessing throughput nears its
>> max bandwidth, so the memory bandwidth can be reflected in the "abstract
>> distance" too.  That is, the "abstract distance" is an abstraction of
>> the memory latency under the expected memory accessing throughput.  The
>> "offset" to the default "abstract distance" reflects the different
>> expected memory accessing throughput.
>> 
>> So, I think we need some kind of abstraction of the memory latency
>> instead of memory bandwidth, e.g., "abstract distance".
>> 
>
> I am reworking other parts of the patch set based on your feedback.

Thanks!

> This part I guess we need to reach some consensus.

Yes.  Let's do that.

> IMHO perf_level (performance level) can indicate a combination of both latency
> and bandwidth.

"abstract distance" is based on latency, and bandwidth is reflected via
"latency under the expected memory accessing throughput".

How does perf_level indicate the combination?  Per my understanding,
it's bandwidth based.

> It is an abstract concept that indicates the performance of the
> device. As we learn more about which device attribute makes more impact in
> defining hierarchy, performance level will give more weightage to that specific
> attribute. It could be write latency or bandwidth. For me, distance has a direct
> linkage to latency because that is how we define numa distance now. Adding
> abstract to the name is not making it more abstract than perf_level. 
>
> I am open to suggestions from others.  Wei Xu has also suggested perf_level name.
> I can rename this to abstract_distance if that indicates the goal better.

I'm open to naming.  But I think that it's good to define it at some
degree instead of completely opaque stuff.  If it's latency based, then
low value corresponds to high performance.  If it's bandwidth based,
then low value corresponds to low performance.

Hi, Wei and Johannes,

What do you think about this?

Best Regards,
Huang, Ying
