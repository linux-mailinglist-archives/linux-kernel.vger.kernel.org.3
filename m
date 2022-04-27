Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EACA5122C3
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 21:30:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233826AbiD0TdU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 15:33:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234440AbiD0Tcz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 15:32:55 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8C17CE;
        Wed, 27 Apr 2022 12:29:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651087776; x=1682623776;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=7DM3DwoVa43dxbl3zZEhqiJA/RQy10C5jWu7fExDLWg=;
  b=XePA+Zw0OIw1HmjPLJvRtDW2CifXTnA45AB1dyPJfFhERYISgPTBFB0O
   b+5krKVUln4iqpDsgnXaaiRjwdpeoQOIm7M1AdPmubRU4N1dRraxSK2jb
   92ELijKTYa7fwhR0KdXRoRvcem24oDi47DwDQPcjMP1xZpEIaddpIkl3y
   YRzVqAPcWTJOEhApsMeGZB9atY+csx1Q/mYAcc2RxM4BFxOp+7yLmfI3O
   eVaNx2AmPcA1A+Zu0q76umSKTNd4XNeXhj7bDRo0vkjM7L9wqm2Z8vzRd
   Qa54Svmz6ImWTxNXL3LojEbWLClqkmCTQk2xIS98wQp72unLKwpq1G0vo
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10330"; a="246607217"
X-IronPort-AV: E=Sophos;i="5.90,294,1643702400"; 
   d="scan'208";a="246607217"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2022 12:29:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,294,1643702400"; 
   d="scan'208";a="533389441"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga006.jf.intel.com with ESMTP; 27 Apr 2022 12:29:36 -0700
Received: from [10.212.137.53] (kliang2-MOBL.ccr.corp.intel.com [10.212.137.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 90C1C58096C;
        Wed, 27 Apr 2022 12:29:33 -0700 (PDT)
Message-ID: <9923422f-2dd3-9951-5814-ab3972e67758@linux.intel.com>
Date:   Wed, 27 Apr 2022 15:29:31 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v5 2/5] perf: Add SNOOP_PEER flag to perf mem data struct
Content-Language: en-US
To:     Leo Yan <leo.yan@linaro.org>
Cc:     Andi Kleen <ak@linux.intel.com>, Ali Saidi <alisaidi@amazon.com>,
        Nick.Forrington@arm.com, acme@kernel.org,
        alexander.shishkin@linux.intel.com, andrew.kilroy@arm.com,
        benh@kernel.crashing.org, german.gomez@arm.com,
        james.clark@arm.com, john.garry@huawei.com, jolsa@kernel.org,
        kjain@linux.ibm.com, lihuafei1@huawei.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, mark.rutland@arm.com,
        mathieu.poirier@linaro.org, mingo@redhat.com, namhyung@kernel.org,
        peterz@infradead.org, will@kernel.org
References: <c17dedde-6ba8-db9b-4827-32477f039764@linux.intel.com>
 <20220422212249.22463-1-alisaidi@amazon.com>
 <20220423063805.GA559531@leoy-ThinkPad-X240s>
 <8e09af67-a416-4ead-b406-6c8b998de344@linux.intel.com>
 <20220424114302.GB978927@leoy-ThinkPad-X240s>
 <b4aaf1ed-124d-1339-3e99-a120f6cc4d28@linux.intel.com>
 <20220427161908.GE562576@leoy-ThinkPad-X240s>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20220427161908.GE562576@leoy-ThinkPad-X240s>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/27/2022 12:19 PM, Leo Yan wrote:
> Hi Kan,
> 
> On Mon, Apr 25, 2022 at 01:01:40PM -0400, Liang, Kan wrote:
>>
>>
>> On 4/24/2022 7:43 AM, Leo Yan wrote:
>>> On Sat, Apr 23, 2022 at 05:53:28AM -0700, Andi Kleen wrote:
>>>>
>>>>> Except SNOOPX_FWD means a no modified cache snooping, it also means it's
>>>>> a cache conherency from *remote* socket.  This is quite different from we
>>>>> define SNOOPX_PEER, which only snoop from peer CPU or clusters.
>>>>>
>>
>> The FWD doesn't have to be *remote*. The definition you quoted is just for
>> the "L3 Miss", which is indeed a remote forward. But we still have
>> cross-core FWD. See Table 19-101.
>>
>> Actually, X86 uses the PERF_MEM_REMOTE_REMOTE + PERF_MEM_SNOOPX_FWD to
>> indicate the remote FWD, not just SNOOPX_FWD.
> 
> Thanks a lot for the info.
> 
>>>>> If no objection, I prefer we could keep the new snoop type SNOOPX_PEER,
>>>>> this would be easier for us to distinguish the semantics and support the
>>>>> statistics for SNOOPX_FWD and SNOOPX_PEER separately.
>>>>>
>>>>> I overlooked the flag SNOOPX_FWD, thanks a lot for Kan's reminding.
>>>>
>>>> Yes seems better to keep using a separate flag if they don't exactly match.
>>>>
>>
>> Yes, I agree with Andi. If you still think the existing flag combination
>> doesn't match your requirement, a new separate flag should be introduced.
>> I'm not familiar with ARM. I think I will leave it to you and the maintainer
>> to decide.
> 
> It's a bit difficult for me to make decision is because now SNOOPX_FWD
> is not used in the file util/mem-events.c, so I am not very sure if
> SNOOPX_FWD has the consistent usage across different arches.

No, it's used in the file util/mem-events.c
See perf_mem__snp_scnprintf().

> 
> On the other hand, I sent a patch for 'peer' flag statistics [1], you
> could review it and it only stats for L2 and L3 cache level for local
> node.

If it's for the local node, why don't you use the hop level which is 
introduced recently by Power? The below seems a good fit.

PERF_MEM_LVLNUM_ANY_CACHE | PERF_MEM_HOPS_0?

/* hop level */
#define PERF_MEM_HOPS_0		0x01 /* remote core, same node */
#define PERF_MEM_HOPS_1		0x02 /* remote node, same socket */
#define PERF_MEM_HOPS_2		0x03 /* remote socket, same board */
#define PERF_MEM_HOPS_3		0x04 /* remote board */
/* 5-7 available */
#define PERF_MEM_HOPS_SHIFT	43

Thanks,
Kan

> 
> The main purpose for my sending this email is if you think the FWD can
> be the consistent for both arches, and even the new added display mode
> is also useful for x86 arch (we can rename it as 'fwd' display mode),
> then I am very glad to unify the flag.
> 
> Thanks,
> Leo
> 
> [1] https://lore.kernel.org/lkml/20220427155013.1833222-5-leo.yan@linaro.org/



