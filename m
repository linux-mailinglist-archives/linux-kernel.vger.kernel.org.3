Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE2DD4C59F4
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Feb 2022 09:08:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230124AbiB0II5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Feb 2022 03:08:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229769AbiB0IIy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Feb 2022 03:08:54 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCAE01FCF9
        for <linux-kernel@vger.kernel.org>; Sun, 27 Feb 2022 00:08:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645949297; x=1677485297;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=iYYkwecdmiiQWNKWked1nOEeOcTZu4U9RJ0ovrzCVKU=;
  b=K6+c0MbOGiHnqaheEn+nUMX8oovXfJfAUthzmJOZCE6AxC/uW1o/Ff5j
   ys7jJurWS8TC/ehNKq8wiKJrkD4vMjyRQg0eTgHZbss5kpgWMWRar4aQd
   qr9qnYAEJZUOF4yCpT4PdQjPcIL8IbyMeEOAgLMIVDRp0H586SCDLQ6xB
   TMteM0t6JWJ67RzsWq3NLzJ2dRLd7kIfvLrReptfmQ8picZAtDBXik4i/
   fwOTr0F1RLCjRR8YAXXoh53SAmuxALrY5eq+35LRHf8FQQ6SAWvsdiDAV
   qW64JyozBZvu1n3rUstItrH3mCAVnJyuRs62LKXbVuXFk5UPeO+kcKFLJ
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10270"; a="277358582"
X-IronPort-AV: E=Sophos;i="5.90,140,1643702400"; 
   d="scan'208";a="277358582"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2022 00:08:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,140,1643702400"; 
   d="scan'208";a="534071864"
Received: from aubrey-app.sh.intel.com (HELO [10.239.53.25]) ([10.239.53.25])
  by orsmga007.jf.intel.com with ESMTP; 27 Feb 2022 00:08:13 -0800
Subject: Re: [RFC PATCH 1/5] sched/fair: record overloaded cpus
To:     "Gautham R. Shenoy" <gautham.shenoy@amd.com>,
        Abel Wu <wuyun.abel@bytedance.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        linux-kernel@vger.kernel.org, srikar@linux.vnet.ibm.com,
        aubrey.li@intel.com
References: <20220217154403.6497-1-wuyun.abel@bytedance.com>
 <20220217154403.6497-2-wuyun.abel@bytedance.com>
 <YhcvUV/jW7yr0Sn+@BLR-5CG11610CF.amd.com>
From:   Aubrey Li <aubrey.li@linux.intel.com>
Message-ID: <a87fbf3b-c488-73cc-470f-09b3e2f63bd3@linux.intel.com>
Date:   Sun, 27 Feb 2022 16:08:12 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YhcvUV/jW7yr0Sn+@BLR-5CG11610CF.amd.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,FROM_FMBLA_NEWDOM,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SCC_BODY_URI_ONLY,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/24/22 3:10 PM, Gautham R. Shenoy wrote:
> Hello Abel,
> 
> (+ Aubrey Li, Srikar)
> 
> On Thu, Feb 17, 2022 at 11:43:57PM +0800, Abel Wu wrote:
>> An CFS runqueue is considered overloaded when there are
>> more than one pullable non-idle tasks on it (since sched-
>> idle cpus are treated as idle cpus). And idle tasks are
>> counted towards rq->cfs.idle_h_nr_running, that is either
>> assigned SCHED_IDLE policy or placed under idle cgroups.
>>
>> The overloaded cfs rqs can cause performance issues to
>> both task types:
>>
>>   - for latency critical tasks like SCHED_NORMAL,
>>     time of waiting in the rq will increase and
>>     result in higher pct99 latency, and
>>
>>   - batch tasks may not be able to make full use
>>     of cpu capacity if sched-idle rq exists, thus
>>     presents poorer throughput.
>>
>> The mask of overloaded cpus is updated in periodic tick
>> and the idle path at the LLC domain basis. This cpumask
>> will also be used in SIS as a filter, improving idle cpu
>> searching.
> 
> This is an interesting approach to minimise the tail latencies by
> keeping track of the overloaded cpus in the LLC so that
> idle/sched-idle CPUs can pull from them. This approach contrasts with the
> following approaches that were previously tried :
> 
> 1. Maintain the idle cpumask at the LLC level by Aubrey Li
>    https://lore.kernel.org/all/1615872606-56087-1-git-send-email-aubrey.li@intel.com/
>    
> 2. Maintain the identity of the idle core itself at the LLC level, by Srikar :
>    https://lore.kernel.org/lkml/20210513074027.543926-3-srikar@linux.vnet.ibm.com/
> 
> There have been concerns in the past about having to update the shared
> mask/counter at regular intervals. Srikar, Aubrey any thoughts on this
> ?
> 
https://lkml.org/lkml/2022/2/7/1129
