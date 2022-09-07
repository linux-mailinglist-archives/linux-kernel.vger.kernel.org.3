Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 529805B00B2
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 11:40:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229914AbiIGJj6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 05:39:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbiIGJj4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 05:39:56 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B883C22BD9
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 02:39:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662543594; x=1694079594;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=L9mAPti4dY/5Rd9k0BChHr2no1/RvmenIKFeJ7EdNQo=;
  b=Z32nobi8mG7ldJoPEptiJnIi1Nred9ngW76vdO0XrkLDIXWoxPao75GL
   KEee65Dh/+wsowAvOyFeXyVid5FVlqkjHg4eOSB1LeLXRbY0SglhaR+IB
   NgaP9KcdE2sLXkbtMAH75EPzT+Vc1CZo9snMGKIVSiXoHCOcpIWDDvR9i
   XEeQeNIgjPxXIu0bDjbv6mkh90GYg3t8t9QI1stORIqlPB3NGiE89dS+Y
   EHhUoNXN/DQjAjUjcOXYAyeXQ7AtttIv8PpvbbNy8igVxsreKcZNnUzxq
   vSOJX3xY2OAR5eBu3eeap9WyFJq2zFCZ8wOCTui5aSRHvW1kNhiBXQ7mT
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10462"; a="294412571"
X-IronPort-AV: E=Sophos;i="5.93,296,1654585200"; 
   d="scan'208";a="294412571"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2022 02:39:54 -0700
X-IronPort-AV: E=Sophos;i="5.93,296,1654585200"; 
   d="scan'208";a="591621518"
Received: from jiebinsu-mobl.ccr.corp.intel.com (HELO [10.238.0.228]) ([10.238.0.228])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2022 02:39:49 -0700
Message-ID: <a4d10f9e-ab8f-ffad-5eea-48316c436f41@intel.com>
Date:   Wed, 7 Sep 2022 17:39:47 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [PATCH] ipc/msg.c: mitigate the lock contention with percpu
 counter
Content-Language: en-US
To:     Tim Chen <tim.c.chen@linux.intel.com>,
        Shakeel Butt <shakeelb@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, vasily.averin@linux.dev,
        Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Alexey Gladkov <legion@kernel.org>,
        Manfred Spraul <manfred@colorfullife.com>,
        alexander.mikhalitsyn@virtuozzo.com, Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Chen, Tim C" <tim.c.chen@intel.com>,
        Feng Tang <feng.tang@intel.com>,
        Huang Ying <ying.huang@intel.com>, tianyou.li@intel.com,
        wangyang.guo@intel.com, jiebin.sun@intel.com
References: <20220902152243.479592-1-jiebin.sun@intel.com>
 <CALvZod44uUFnwfF4StC24t+d1s_XE10hkmSCgb04FjtTATo6xQ@mail.gmail.com>
 <048517e7f95aa8460cd47a169f3dfbd8e9b70d5c.camel@linux.intel.com>
From:   "Sun, Jiebin" <jiebin.sun@intel.com>
In-Reply-To: <048517e7f95aa8460cd47a169f3dfbd8e9b70d5c.camel@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-11.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 9/7/2022 2:44 AM, Tim Chen wrote:
> On Fri, 2022-09-02 at 09:27 -0700, Shakeel Butt wrote:
>> On Fri, Sep 2, 2022 at 12:04 AM Jiebin Sun <jiebin.sun@intel.com> wrote:
>>> The msg_bytes and msg_hdrs atomic counters are frequently
>>> updated when IPC msg queue is in heavy use, causing heavy
>>> cache bounce and overhead. Change them to percpu_counters
>>> greatly improve the performance. Since there is one unique
>>> ipc namespace, additional memory cost is minimal. Reading
>>> of the count done in msgctl call, which is infrequent. So
>>> the need to sum up the counts in each CPU is infrequent.
>>>
>>> Apply the patch and test the pts/stress-ng-1.4.0
>>> -- system v message passing (160 threads).
>>>
>>> Score gain: 3.38x
>>>
>>> CPU: ICX 8380 x 2 sockets
>>> Core number: 40 x 2 physical cores
>>> Benchmark: pts/stress-ng-1.4.0
>>> -- system v message passing (160 threads)
>>>
>>> Signed-off-by: Jiebin Sun <jiebin.sun@intel.com>
>> [...]
>>> +void percpu_counter_add_local(struct percpu_counter *fbc, s64 amount)
>>> +{
>>> +       this_cpu_add(*fbc->counters, amount);
>>> +}
>>> +EXPORT_SYMBOL(percpu_counter_add_local);
>> Why not percpu_counter_add()? This may drift the fbc->count more than
>> batch*nr_cpus. I am assuming that is not the issue for you as you
>> always do an expensive sum in the slow path. As Andrew asked, this
>> should be a separate patch.
> In the IPC case, the read is always done with the accurate read using
> percpu_counter_sum() gathering all the counts and
> never with percpu_counter_read() that only read global count.
> So Jiebin was not worry about accuracy.
>
> However, the counter is s64 and the local per cpu counter is S32.
> So the counter size has shrunk if we only keep the count in local per
> cpu counter, which can overflow a lot sooner and is not okay.
>
> Jiebin, can you try to use percpu_counter_add_batch, but using a large
> batch size.  That should achieve what you want without needing
> to create a percpu_counter_add_local() function, and also the overflow
> problem.
>
> Tim
>
I have sent out the patch v4 which use percpu_counter_add_batch. If we use
a tuned large batch size (1024), the performance gain is 3.17x (patch v4)
vs 3.38x (patch v3) previously in stress-ng -- message. It still has
significant performance improvement and also good balance between
performance gain and overflow issue.

Jiebin

>
