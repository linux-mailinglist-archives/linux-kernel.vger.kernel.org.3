Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 493815AD22E
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 14:14:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236892AbiIEMMO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 08:12:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235207AbiIEMML (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 08:12:11 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 846281D30A
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 05:12:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662379930; x=1693915930;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=cESe8vq/hRJPKQcNPWYwY2QfT3DdGtul83c8mx+Y1T4=;
  b=hI++BISFGXx5FZbFebyA3uhJWCo+JD6xoG8JsX9I949YG4AVkFP7H0TC
   3j+i+CGaP/hVEYhmI2tc+U563vjXUgxHI3kExQl/4vE/t0fC1RW/YZse9
   GTKGQl4SNyAxAuLO36WQZhTKiUMr7u+C6aQmKYNu2K1L7d9Ix2sSLT/IT
   0pp5nZG76WZrZiWKILFjOwUlexa7/bS1zzhE+lvNBCwZ8ywbDlIe625Ce
   tK/O9I2dp5x+jT1MrfJgW2uczRygLPh63KXXDWWkb/pdqH19L4sAcqbI/
   c6XvJk9tU4KaVBw0zvSXCKGXzLHPlwh+sMBQvm91Ftgrv9fJYXdvYCD4V
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10460"; a="295115062"
X-IronPort-AV: E=Sophos;i="5.93,291,1654585200"; 
   d="scan'208";a="295115062"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2022 05:12:10 -0700
X-IronPort-AV: E=Sophos;i="5.93,291,1654585200"; 
   d="scan'208";a="643788389"
Received: from jiebinsu-mobl.ccr.corp.intel.com (HELO [10.238.0.228]) ([10.238.0.228])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2022 05:12:06 -0700
Message-ID: <f204eb92-d17d-9c6a-768c-5404f3363b5b@intel.com>
Date:   Mon, 5 Sep 2022 20:12:04 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.1
Subject: Re: [PATCH] ipc/msg.c: mitigate the lock contention with percpu
 counter
Content-Language: en-US
To:     Manfred Spraul <manfred@colorfullife.com>,
        akpm@linux-foundation.org, vasily.averin@linux.dev,
        shakeelb@google.com, dennis@kernel.org, tj@kernel.org,
        cl@linux.com, ebiederm@xmission.com, legion@kernel.org,
        alexander.mikhalitsyn@virtuozzo.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     tim.c.chen@intel.com, feng.tang@intel.com, ying.huang@intel.com,
        tianyou.li@intel.com, wangyang.guo@intel.com, jiebin.sun@intel.com
References: <20220902152243.479592-1-jiebin.sun@intel.com>
 <ffe3f49c-55d7-3c28-78a2-7998fa3ee914@colorfullife.com>
From:   "Sun, Jiebin" <jiebin.sun@intel.com>
In-Reply-To: <ffe3f49c-55d7-3c28-78a2-7998fa3ee914@colorfullife.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 9/4/2022 3:35 AM, Manfred Spraul wrote:
> Hi Jiebin,
>
> On 9/2/22 17:22, Jiebin Sun wrote:
>> The msg_bytes and msg_hdrs atomic counters are frequently
>> updated when IPC msg queue is in heavy use, causing heavy
>> cache bounce and overhead. Change them to percpu_counters
>> greatly improve the performance. Since there is one unique
>> ipc namespace, additional memory cost is minimal.
>
> With ipc namespaces, there is one struct per namespace, correct?
>
> The cost is probably still ok, but the change log should be correct.
>
Yes, that's what I want to summarize. The IPC msg namespace is unique

and there is only one percpu counter in IPC msg namespace.

Thanks.

>
>> @@ -1303,14 +1305,16 @@ void msg_init_ns(struct ipc_namespace *ns)
>>       ns->msg_ctlmnb = MSGMNB;
>>       ns->msg_ctlmni = MSGMNI;
>>   -    atomic_set(&ns->msg_bytes, 0);
>> -    atomic_set(&ns->msg_hdrs, 0);
>> +    percpu_counter_init(&ns->percpu_msg_bytes, 0, GFP_KERNEL);
>> +    percpu_counter_init(&ns->percpu_msg_hdrs, 0, GFP_KERNEL);
>>       ipc_init_ids(&ns->ids[IPC_MSG_IDS]);
>
> These calls can fail. You must add error handling.

I have add error handling for percpu_counter_init.

Thanks.

>
> -- 
>
>     Manfred
>
>
