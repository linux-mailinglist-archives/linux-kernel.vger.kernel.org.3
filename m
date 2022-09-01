Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55D855A9738
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 14:48:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232813AbiIAMrx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 08:47:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233392AbiIAMrr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 08:47:47 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D631040574
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 05:47:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662036465; x=1693572465;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=q4Cyh13x8a2bCh5bEoP/0fHyyQE8vjW8odvE/wd4Qs0=;
  b=FxevapEyk+Dv0GNkpjWeP3COAAAT5gkO/3oxNCq+iIS2SarpEJSVaU5y
   2BFHJDQuQw4ntp4KFSGWOYLYTComntGI1Gr8D/ZK/5CHixVL77vvCgUsW
   9o/tTNO1zIDrGL16JvWjlgJeudeZWhy7aJCFxczyUi5ooMH1PmbygnX7x
   sgNYuAChzMtnrpW+lC0/9BnR6lNNHvSHW8AbGri4ig5Sfsp2KYBQ39tdw
   J+EZJoVsIcVn+qqODEb0IpBUFtxbahrFBy6eNEmZWJyDD1H2H2rlKxINl
   cJCgUq7SxuB67g1SOctHXXN1Qrp2eIVGt/gaeDtJPiixCgFbID9vPG5Z2
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10457"; a="295711792"
X-IronPort-AV: E=Sophos;i="5.93,280,1654585200"; 
   d="scan'208";a="295711792"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2022 05:47:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,280,1654585200"; 
   d="scan'208";a="612478663"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga002.jf.intel.com with ESMTP; 01 Sep 2022 05:47:37 -0700
Received: from [10.252.213.4] (kliang2-mobl1.ccr.corp.intel.com [10.252.213.4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 5CB5D580AA7;
        Thu,  1 Sep 2022 05:47:36 -0700 (PDT)
Message-ID: <a751a7ea-78b6-d278-4cbb-eef17294fcf3@linux.intel.com>
Date:   Thu, 1 Sep 2022 08:47:35 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH 0/6] Add sample_flags to improve the perf_sample_data
 struct
Content-Language: en-US
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     peterz@infradead.org, acme@kernel.org, mingo@redhat.com,
        eranian@google.com, mpe@ellerman.id.au,
        linux-kernel@vger.kernel.org, ak@linux.intel.com,
        andreas.kogler.0x@gmail.com, atrajeev@linux.vnet.ibm.com,
        ravi.bangoria@amd.com
References: <20220831145514.190514-1-kan.liang@linux.intel.com>
 <Yw/j8rXIRwAnXhy3@google.com>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <Yw/j8rXIRwAnXhy3@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022-08-31 6:42 p.m., Namhyung Kim wrote:
> (Adding Ravi to CC)
> 
> On Wed, Aug 31, 2022 at 07:55:08AM -0700, kan.liang@linux.intel.com wrote:
>> From: Kan Liang <kan.liang@linux.intel.com>
>>
>> The patch series is to fix PEBS timestamps overwritten and improve the
>> perf_sample_data struct. The detailed discussion can be found at
>> https://lore.kernel.org/lkml/YwXvGe4%2FQdgGYOKJ@worktop.programming.kicks-ass.net/
>>
>> The patch series has two changes compared with the suggestions in the
>> above discussion.
>> - Only clear the sample flags for the perf_prepare_sample().
>>   The __perf_event_header__init_id is shared between perf_prepare_sample()
>>   (used by PERF_RECORD_SAMPLE) and perf_event_header__init_id() (used by
>>   other PERF_RECORD_* event type). The sample data is only available
>>   for the PERF_RECORD_SAMPLE.
>> - The CALLCHAIN_EARLY hack is still required for the BPF, especially
>>   perf_event_set_bpf_handler(). The sample data is not available when
>>   the function is invoked.
> 
> In general, looks good!  I'd like to work on the BPF side so that it can
> get the sample data for filtering. 

Thanks Namhyung. I will send out the V2 shortly. I think the BPF work
can be on top of it.

Thanks,
Kan
> The previous discussion was at
> 
>   https://lore.kernel.org/all/CAM9d7cjj0X90=NsvdwaLMGCDVkMJBLAGF_q-+Eqj6b44OAnzoQ@mail.gmail.com/
> 
> Thanks,
> Namhyung
> 
>>
>> Kan Liang (6):
>>   perf: Add sample_flags to indicate the PMU-filled sample data
>>   perf/x86/intel/pebs: Fix PEBS timestamps overwritten
>>   perf: Use sample_flags for branch stack
>>   perf: Use sample_flags for weight
>>   perf: Use sample_flags for data_src
>>   perf: Use sample_flags for txn
>>
>>  arch/powerpc/perf/core-book3s.c | 10 ++++++---
>>  arch/x86/events/core.c          |  4 +++-
>>  arch/x86/events/intel/core.c    |  4 +++-
>>  arch/x86/events/intel/ds.c      | 39 ++++++++++++++++++++++++---------
>>  include/linux/perf_event.h      | 15 ++++++-------
>>  kernel/events/core.c            | 33 +++++++++++++++++++---------
>>  6 files changed, 72 insertions(+), 33 deletions(-)
>>
>> -- 
>> 2.35.1
>>
>>
