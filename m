Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3FCF5AE361
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 10:48:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233201AbiIFIqo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 04:46:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239506AbiIFIqT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 04:46:19 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B93FA7A770
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 01:42:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662453743; x=1693989743;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=8Y/bjET5zZ30la5m327NqJfIsBDroX957IXK6TjR0Kk=;
  b=M91Vzvm865fGtZaP3ymDvEuVp2jKc74pXUqh81O0xAxd8qc71fixbcZD
   dl9iggEfQAkUxwKMYYE5gIj4cf5lPzzKUqlCyuGQIKh/RMjxqDHL9fQdV
   9lHBuWInTk51JgLHf5ybzaajz/svX6cF1byEOptaFsq14MdEXEMbnG5ty
   /G3hpVuuAMmLLA5NFEOa/8+rolUOvF2mLavEz/Ls3O90efdxwg+R1BFMN
   Rkj2RISt0M+0xk1e6r4RCCga0MAr10vpHtVyYFM0amNXIsF82ihcBxb9h
   ithQfHHBa+A5/UA6iR6DWWuW1edv9v+yJKfTwxOmIHN/2iSba0NVfZlF6
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10461"; a="295274617"
X-IronPort-AV: E=Sophos;i="5.93,293,1654585200"; 
   d="scan'208";a="295274617"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2022 01:42:01 -0700
X-IronPort-AV: E=Sophos;i="5.93,293,1654585200"; 
   d="scan'208";a="644077988"
Received: from jiebinsu-mobl.ccr.corp.intel.com (HELO [10.238.0.228]) ([10.238.0.228])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2022 01:41:57 -0700
Message-ID: <4a6937b9-08b1-0f52-18db-13e17e344786@intel.com>
Date:   Tue, 6 Sep 2022 16:41:55 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.1
Subject: Re: [PATCH v2 1/2] percpu: Add percpu_counter_add_local
Content-Language: en-US
To:     Shakeel Butt <shakeelb@google.com>
Cc:     akpm@linux-foundation.org, vasily.averin@linux.dev,
        dennis@kernel.org, tj@kernel.org, cl@linux.com,
        ebiederm@xmission.com, legion@kernel.org, manfred@colorfullife.com,
        alexander.mikhalitsyn@virtuozzo.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, tim.c.chen@intel.com,
        feng.tang@intel.com, ying.huang@intel.com, tianyou.li@intel.com,
        wangyang.guo@intel.com, jiebin.sun@intel.com
References: <20220902152243.479592-1-jiebin.sun@intel.com>
 <20220905193516.846647-1-jiebin.sun@intel.com>
 <20220905193516.846647-3-jiebin.sun@intel.com>
 <20220905193159.eeu2xmqj6743kzxv@google.com>
From:   "Sun, Jiebin" <jiebin.sun@intel.com>
In-Reply-To: <20220905193159.eeu2xmqj6743kzxv@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 9/6/2022 3:31 AM, Shakeel Butt wrote:
> On Tue, Sep 06, 2022 at 03:35:16AM +0800, Jiebin Sun wrote:
>> Add percpu_counter_add_local for only updating local counter
>> without aggregating to global counter.
> Please add why do we need this. Who should use this and who shouldn't.

Thanks. I have added the code comment and change log in patch v3 and 
provided

the info who should use it and who shouldn't.

>
>> Signed-off-by: Jiebin Sun <jiebin.sun@intel.com>
> [...]
>
>> diff --git a/lib/percpu_counter.c b/lib/percpu_counter.c
>> index ed610b75dc32..d33cb750962a 100644
>> --- a/lib/percpu_counter.c
>> +++ b/lib/percpu_counter.c
>> @@ -72,6 +72,12 @@ void percpu_counter_set(struct percpu_counter *fbc, s64 amount)
>>   }
>>   EXPORT_SYMBOL(percpu_counter_set);
>>
> Add a doc comment here on why someone want to use this?
>
>> +void percpu_counter_add_local(struct percpu_counter *fbc, s64 amount)
>> +{
>> +	this_cpu_add(*fbc->counters, amount);
>> +}
>> +EXPORT_SYMBOL(percpu_counter_add_local);
>> +
>>   /*
>>    * This function is both preempt and irq safe. The former is due to explicit
>>    * preemption disable. The latter is guaranteed by the fact that the slow path
>> -- 
>> 2.31.1
>>
