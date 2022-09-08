Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 584DD5B16EC
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 10:26:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231464AbiIHI0P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 04:26:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229942AbiIHIZ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 04:25:59 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6CE7D741B
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 01:25:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662625554; x=1694161554;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=+wKxW6UyvtEGfEqoiIAp8ewCqvIukzr2poSjxykFMR8=;
  b=KYbyUvqCK5Kc76cIKfh4LLSZvU6fVzp+8PB21En6RddAjrbfw16U2SS7
   i0T+FKEVwq/JJZgcOhagZS5xIMtU/MLRAqBXz3TFX9JavKgl491JAA3Ty
   cBhdPgf/91dJoK0wktIuQvaEeom7AEO4TgYTLjtlepxOJ002+h+l5+IMd
   mneZMOq9NbwXFFzvceHYlNmxq82ubTClHlENgKNHGAoDgZq8gwLw+hyNH
   huhUNv9oWXrttpvk7L+rXJnMcxmn6suA09s6uheX4sCpQAWF7hNzjw2AN
   fWz0J3S2emdEzwIOu5PGOpJr9qtOjPOuU3Kivc8OKUGe48MREcqiGrs9H
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10463"; a="284126358"
X-IronPort-AV: E=Sophos;i="5.93,299,1654585200"; 
   d="scan'208";a="284126358"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2022 01:25:53 -0700
X-IronPort-AV: E=Sophos;i="5.93,299,1654585200"; 
   d="scan'208";a="676588504"
Received: from jiebinsu-mobl.ccr.corp.intel.com (HELO [10.238.0.228]) ([10.238.0.228])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2022 01:25:49 -0700
Message-ID: <c8e771c8-4b01-f2b4-5b54-e9931f556270@intel.com>
Date:   Thu, 8 Sep 2022 16:25:47 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [PATCH v4] ipc/msg: mitigate the lock contention with percpu
 counter
Content-Language: en-US
To:     Andrew Morton <akpm@linux-foundation.org>,
        Tim Chen <tim.c.chen@linux.intel.com>
Cc:     vasily.averin@linux.dev, shakeelb@google.com, dennis@kernel.org,
        tj@kernel.org, cl@linux.com, ebiederm@xmission.com,
        legion@kernel.org, manfred@colorfullife.com,
        alexander.mikhalitsyn@virtuozzo.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, tim.c.chen@intel.com,
        feng.tang@intel.com, ying.huang@intel.com, tianyou.li@intel.com,
        wangyang.guo@intel.com, jiebin.sun@intel.com
References: <CALvZod44uUFnwfF4StC24t+d1s_XE10hkmSCgb04FjtTATo6xQ@mail.gmail.com>
 <20220907172516.1210842-1-jiebin.sun@intel.com>
 <eb13cb3e5e1625afe1bb783810f4d6b52a66a2f6.camel@linux.intel.com>
 <20220907143427.0ce54bbf096943ffca197fee@linux-foundation.org>
From:   "Sun, Jiebin" <jiebin.sun@intel.com>
In-Reply-To: <20220907143427.0ce54bbf096943ffca197fee@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 9/8/2022 5:34 AM, Andrew Morton wrote:
> On Wed, 07 Sep 2022 09:01:53 -0700 Tim Chen <tim.c.chen@linux.intel.com> wrote:
>
>> On Thu, 2022-09-08 at 01:25 +0800, Jiebin Sun wrote:
>>> The msg_bytes and msg_hdrs atomic counters are frequently
>>> updated when IPC msg queue is in heavy use, causing heavy
>>> cache bounce and overhead. Change them to percpu_counter
>>> greatly improve the performance. Since there is one percpu
>>> struct per namespace, additional memory cost is minimal.
>>> Reading of the count done in msgctl call, which is infrequent.
>>> So the need to sum up the counts in each CPU is infrequent.
>>>
>>>
>>> Apply the patch and test the pts/stress-ng-1.4.0
>>> -- system v message passing (160 threads).
>>>
>>> Score gain: 3.17x
>>>
>>>
>> ...
>>>   
>>> +/* large batch size could reduce the times to sum up percpu counter */
>>> +#define MSG_PERCPU_COUNTER_BATCH 1024
>>> +
>> Jiebin,
>>
>> 1024 is a small size (1/4 page).
>> The local per cpu counter could overflow to the gloabal count quickly
>> if it is limited to this size, since our count tracks msg size.
>>    
>> I'll suggest something larger, say 8*1024*1024, about
>> 8MB to accommodate about 2 large page worth of data.  Maybe that
>> will further improve throughput on stress-ng by reducing contention
>> on adding to the global count.
>>
> I think this concept of a percpu_counter_add() which is massively
> biased to the write side and with very rare reading is a legitimate
> use-case.  Perhaps it should become an addition to the formal interface.
> Something like
>
> /*
>   * comment goes here
>   */
> static inline void percpu_counter_add_local(struct percpu_counter *fbc,
> 					    s64 amount)
> {
> 	percpu_counter_add_batch(fbc, amount, INT_MAX);
> }
>
> and percpu_counter_sub_local(), I guess.
>
> The only instance I can see is
> block/blk-cgroup-rwstat.h:blkg_rwstat_add() which is using INT_MAX/2
> because it always uses percpu_counter_sum_positive() on the read side.
>
> But that makes two!


Yes. Using INT_MAX or INT_MAX/2 could have a big improvement on the 
performance if heavy writing but rare reading. In our case, if the local 
percpu counter is near to INT_MAX and there comes a big msgsz, the 
overflow issue could happen. So I think INT_MAX/2, which is used in 
blkg_rwstat_add(), might be a better choice. /$ 
percpu_counter_add_batch(&ns->percpu_msg_bytes, msgsz, batch); /I will 
send the performance data and draft patch out for discussing.//Jiebin//

