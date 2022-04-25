Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B039A50E661
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 19:01:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243704AbiDYREv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 13:04:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243634AbiDYREu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 13:04:50 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83A8C1C113;
        Mon, 25 Apr 2022 10:01:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650906105; x=1682442105;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=dBjDeKCBG8dDb3+fTvZJG04zxqSAzT9opUo1LLEgCAE=;
  b=jXwFriTyHgwnkFMhzLTyB23yoA3pIh98TYKewEkz8ctgUffiAEjsdTVh
   kwiRcYOK82YKGXnaDQGnivHjy4+lMuaSkx3548giQm9640aGOE/dSwnxT
   CL/UrpFSz3YHgomTf6kdCWBHj052E9bhoPM1h51d6xK3W9rZ8OVwPFHVK
   n3azDazajNwMb0f/UWOf1AzIvQXwQnOODU75Fa+fFyr6IgH3jgauAH8NM
   lF0ld0eIY26BxCffww5+J8jgQ+YF5oVCWnl5o4RB0SzWigvRzko16CC0c
   Gz6BmUm6a9ExTs/6EOD3ChovIJhkDp3ky4chdIT2MjzbspeZnaBHLfGp7
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10328"; a="325795022"
X-IronPort-AV: E=Sophos;i="5.90,289,1643702400"; 
   d="scan'208";a="325795022"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2022 10:01:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,289,1643702400"; 
   d="scan'208";a="564169148"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga007.fm.intel.com with ESMTP; 25 Apr 2022 10:01:44 -0700
Received: from [10.209.9.159] (kliang2-MOBL.ccr.corp.intel.com [10.209.9.159])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id DEF1A5809EB;
        Mon, 25 Apr 2022 10:01:41 -0700 (PDT)
Message-ID: <b4aaf1ed-124d-1339-3e99-a120f6cc4d28@linux.intel.com>
Date:   Mon, 25 Apr 2022 13:01:40 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v5 2/5] perf: Add SNOOP_PEER flag to perf mem data struct
Content-Language: en-US
To:     Leo Yan <leo.yan@linaro.org>, Andi Kleen <ak@linux.intel.com>
Cc:     Ali Saidi <alisaidi@amazon.com>, Nick.Forrington@arm.com,
        acme@kernel.org, alexander.shishkin@linux.intel.com,
        andrew.kilroy@arm.com, benh@kernel.crashing.org,
        german.gomez@arm.com, james.clark@arm.com, john.garry@huawei.com,
        jolsa@kernel.org, kjain@linux.ibm.com, lihuafei1@huawei.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, mark.rutland@arm.com,
        mathieu.poirier@linaro.org, mingo@redhat.com, namhyung@kernel.org,
        peterz@infradead.org, will@kernel.org
References: <c17dedde-6ba8-db9b-4827-32477f039764@linux.intel.com>
 <20220422212249.22463-1-alisaidi@amazon.com>
 <20220423063805.GA559531@leoy-ThinkPad-X240s>
 <8e09af67-a416-4ead-b406-6c8b998de344@linux.intel.com>
 <20220424114302.GB978927@leoy-ThinkPad-X240s>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20220424114302.GB978927@leoy-ThinkPad-X240s>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/24/2022 7:43 AM, Leo Yan wrote:
> On Sat, Apr 23, 2022 at 05:53:28AM -0700, Andi Kleen wrote:
>>
>>> Except SNOOPX_FWD means a no modified cache snooping, it also means it's
>>> a cache conherency from *remote* socket.  This is quite different from we
>>> define SNOOPX_PEER, which only snoop from peer CPU or clusters.
>>>

The FWD doesn't have to be *remote*. The definition you quoted is just 
for the "L3 Miss", which is indeed a remote forward. But we still have 
cross-core FWD. See Table 19-101.

Actually, X86 uses the PERF_MEM_REMOTE_REMOTE + PERF_MEM_SNOOPX_FWD to 
indicate the remote FWD, not just SNOOPX_FWD.

>>> If no objection, I prefer we could keep the new snoop type SNOOPX_PEER,
>>> this would be easier for us to distinguish the semantics and support the
>>> statistics for SNOOPX_FWD and SNOOPX_PEER separately.
>>>
>>> I overlooked the flag SNOOPX_FWD, thanks a lot for Kan's reminding.
>>
>> Yes seems better to keep using a separate flag if they don't exactly match.
>>

Yes, I agree with Andi. If you still think the existing flag combination 
doesn't match your requirement, a new separate flag should be 
introduced. I'm not familiar with ARM. I think I will leave it to you 
and the maintainer to decide.

Thanks,
Kan
