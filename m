Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFD365AD1DC
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 13:54:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230054AbiIELyr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 07:54:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236214AbiIELyo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 07:54:44 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1EC6DF2C
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 04:54:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662378881; x=1693914881;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=IJhTAgu2cxNzpV0h3DX4P61WCYhZ95uQuCPblFmdGpk=;
  b=SLvBXuURR9kPbtGVDvvNuBBJEnOinBPaGDVb048CqKFnS07tEbwBU34g
   jAJX3fE8LV+Jn4KxyluK6zpnMrOqoDiThOSqChE5iVlO1dPgVKkYo9yBh
   B0TkCVbOS7WtK9I1FtQGLnH0LGY8pqGTBJzThKoViO2nTyIKTvyvnXsVK
   +7HLVGFZN3gp6PfaydzCvIIDNHGfaa6bbEg7niN3oDNJelpuxyEGFkMNB
   9NWjd7aSNoEfGit/VSSZHBcTmc0vAtoxsFgNKB9hCU9rUSqL2Uv5NTrRY
   lsJzqZpwnf2wIdeHdoNbyU6Z4eYpVvOx9zMA9RKoEiUq1vFGCU3SqeKCE
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10460"; a="276115325"
X-IronPort-AV: E=Sophos;i="5.93,291,1654585200"; 
   d="scan'208";a="276115325"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2022 04:54:41 -0700
X-IronPort-AV: E=Sophos;i="5.93,291,1654585200"; 
   d="scan'208";a="643784115"
Received: from jiebinsu-mobl.ccr.corp.intel.com (HELO [10.238.0.228]) ([10.238.0.228])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2022 04:54:37 -0700
Message-ID: <da91f763-b74b-68d9-312b-1bc86179273f@intel.com>
Date:   Mon, 5 Sep 2022 19:54:35 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.1
Subject: Re: [PATCH] ipc/msg.c: mitigate the lock contention with percpu
 counter
Content-Language: en-US
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     vasily.averin@linux.dev, shakeelb@google.com, dennis@kernel.org,
        tj@kernel.org, cl@linux.com, ebiederm@xmission.com,
        legion@kernel.org, manfred@colorfullife.com,
        alexander.mikhalitsyn@virtuozzo.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, tim.c.chen@intel.com,
        feng.tang@intel.com, ying.huang@intel.com, tianyou.li@intel.com,
        wangyang.guo@intel.com
References: <20220902152243.479592-1-jiebin.sun@intel.com>
 <20220902090659.28829853543cac3f3f725df5@linux-foundation.org>
From:   "Sun, Jiebin" <jiebin.sun@intel.com>
In-Reply-To: <20220902090659.28829853543cac3f3f725df5@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 9/3/2022 12:06 AM, Andrew Morton wrote:
> On Fri,  2 Sep 2022 23:22:43 +0800 Jiebin Sun <jiebin.sun@intel.com> wrote:
>
>> The msg_bytes and msg_hdrs atomic counters are frequently
>> updated when IPC msg queue is in heavy use, causing heavy
>> cache bounce and overhead. Change them to percpu_counters
>> greatly improve the performance. Since there is one unique
>> ipc namespace, additional memory cost is minimal. Reading
>> of the count done in msgctl call, which is infrequent. So
>> the need to sum up the counts in each CPU is infrequent.
>>
>> Apply the patch and test the pts/stress-ng-1.4.0
>> -- system v message passing (160 threads).
>>
>> Score gain: 3.38x
> So this test became 3x faster?

Yes. It is from the phoronix test suite stress-ng-1.4.0 -- system v message
passing with dual sockets ICX servers. In this benchmark, there are 160
pairs of threads, which do msgsnd and msgrcv. The patch benefit more as the
threads of workload increase.

>
>> CPU: ICX 8380 x 2 sockets
>> Core number: 40 x 2 physical cores
>> Benchmark: pts/stress-ng-1.4.0
>> -- system v message passing (160 threads)
>>
>> ...
>>
>> @@ -138,6 +139,14 @@ percpu_counter_add(struct percpu_counter *fbc, s64 amount)
>>   	preempt_enable();
>>   }
>>   
>> +static inline void
>> +percpu_counter_add_local(struct percpu_counter *fbc, s64 amount)
>> +{
>> +	preempt_disable();
>> +	fbc->count += amount;
>> +	preempt_enable();
>> +}
> What's this and why is it added?
>
> It would be best to propose this as a separate preparatory patch.
> Fully changelogged and perhaps even with a code comment explaining why
> and when it should be used.
>
> Thanks.

As it will always do sum in msgctl_info, there is no need to use
percpu_counter_add_batch. It will do global updating when the counter reach
the batch size. So we add percpu_counter_add_local for smp and non_smp,
which will only do local adding to the percpu counter.
I have separate the original patch into two patches.

Thanks.

