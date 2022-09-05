Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 379BC5AD20A
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 14:04:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237142AbiIEMDC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 08:03:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236832AbiIEMC6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 08:02:58 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5B4B57E03
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 05:02:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662379377; x=1693915377;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=mr0Ged+XZKBkgCFReoHkcWU+1en7SbbyEMTFhTOQiPE=;
  b=CdP995TLZNtJGS5YZU0/g5PTq+zsaWfA4sycG0TK+fVkOv70s0u2iV92
   wbeS6oSvxMLyxsrhn0dd5OTbfreFS+m12vG9TzsuwNwh/dC3+FuwqGCPu
   OtIM0DzW5egT2VKJlpX1S/60/p+eRlfUxd1/0ixXYUQ/rlgtZXvd6zhLI
   cccVOFZ9UK9SqYja4bhqsobgjrlx9xusjBsVu/DruMIUCf7sd8MpNT2x9
   v1uPYdYeP1rudQydYFsZZrZmVWa9sORmtEBXTPoFnNRULF5kh1o5GeOPk
   2kgsTzMzq2OrujKVUB3bmu1WnMQEMbBieXmbFX+y9svJ0cg+TZvNXfsV7
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10460"; a="276769124"
X-IronPort-AV: E=Sophos;i="5.93,291,1654585200"; 
   d="scan'208";a="276769124"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2022 05:02:40 -0700
X-IronPort-AV: E=Sophos;i="5.93,291,1654585200"; 
   d="scan'208";a="643785985"
Received: from jiebinsu-mobl.ccr.corp.intel.com (HELO [10.238.0.228]) ([10.238.0.228])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2022 05:02:36 -0700
Message-ID: <0dacdaac-a530-3499-b2ed-ee210c41ea1e@intel.com>
Date:   Mon, 5 Sep 2022 20:02:34 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.1
Subject: Re: [PATCH] ipc/msg.c: mitigate the lock contention with percpu
 counter
Content-Language: en-US
To:     Shakeel Butt <shakeelb@google.com>
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
From:   "Sun, Jiebin" <jiebin.sun@intel.com>
In-Reply-To: <CALvZod44uUFnwfF4StC24t+d1s_XE10hkmSCgb04FjtTATo6xQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 9/3/2022 12:27 AM, Shakeel Butt wrote:
> On Fri, Sep 2, 2022 at 12:04 AM Jiebin Sun <jiebin.sun@intel.com> wrote:
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
>>
>> CPU: ICX 8380 x 2 sockets
>> Core number: 40 x 2 physical cores
>> Benchmark: pts/stress-ng-1.4.0
>> -- system v message passing (160 threads)
>>
>> Signed-off-by: Jiebin Sun <jiebin.sun@intel.com>
> [...]
>> +void percpu_counter_add_local(struct percpu_counter *fbc, s64 amount)
>> +{
>> +       this_cpu_add(*fbc->counters, amount);
>> +}
>> +EXPORT_SYMBOL(percpu_counter_add_local);
> Why not percpu_counter_add()? This may drift the fbc->count more than
> batch*nr_cpus. I am assuming that is not the issue for you as you
> always do an expensive sum in the slow path. As Andrew asked, this
> should be a separate patch.

Yes. It will always do sum in msgctl_info. So there is no need to
do global updating in percpu_counter_add when the percpu counter
reaches the batch size. We add percpu_counter_add_local in this
case. The sum in slow path is infrequent. So the additional cost
is much less compared to the atomic updating in do_msgsnd and
do_msgrcv every time. I have separate the original patch into two
patches.

Thanks.

