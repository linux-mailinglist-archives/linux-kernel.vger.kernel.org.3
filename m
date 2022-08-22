Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AC4459C2A8
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 17:27:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236361AbiHVP0A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 11:26:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236526AbiHVPYa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 11:24:30 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E6ACF54
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 08:20:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661181609; x=1692717609;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=PxH1XESOn3k/TaEO+M/yHzwrNdK4vC1UrGySGCfqGZI=;
  b=OStXxSH0ylWCfCKLDuyUgSvzfL2JRSZrKYOWI/EBavTeOi/JsDTtg0lI
   j4UsGn9Ux75/WH+tZ2SZzutgUGZTtdMkadAOdBgKn3BZ1jyqgHf4awmcg
   cxOdiKOwqdyF8PMur+UrujqMpVHbVTwJeDm5XGyJ8JRLVcZRdjprPbmUz
   gdBAjhYGvZI9v4d/Mrz0Q+PC8X4HxBD1qRE2Ski9Uf8g9tvCRnMxOHHZ2
   rouaGBWwSaDaa1srYSvy5GLCqqNECeypVyIlObMa/q7vBQgHjmU6nvG8G
   oTe869NqOU4uufnjwvalqw+9mzmOaacSR8oCFq5hrBDv5VQnGAyhAspdV
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10447"; a="355172261"
X-IronPort-AV: E=Sophos;i="5.93,255,1654585200"; 
   d="scan'208";a="355172261"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2022 08:20:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,255,1654585200"; 
   d="scan'208";a="612080496"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga007.fm.intel.com with ESMTP; 22 Aug 2022 08:20:08 -0700
Received: from [10.252.212.31] (kliang2-mobl1.ccr.corp.intel.com [10.252.212.31])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 269AF5806C8;
        Mon, 22 Aug 2022 08:20:07 -0700 (PDT)
Message-ID: <feb6f311-1379-7482-21e3-94cf7e797495@linux.intel.com>
Date:   Mon, 22 Aug 2022 11:20:05 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [RESEND PATCH] perf/x86/intel: Fix unchecked MSR access error for
 Alder Lake N
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     acme@redhat.com, linux-kernel@vger.kernel.org,
        alexander.shishkin@linux.intel.com, ak@linux.intel.com,
        Jianfeng Gao <jianfeng.gao@intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>
References: <20220818181530.2355034-1-kan.liang@linux.intel.com>
 <Yv9EVP6O9r867om4@worktop.programming.kicks-ass.net>
 <Yv9Kw21Wl/f6KJTk@worktop.programming.kicks-ass.net>
 <b54cd275-4fa6-9b5c-fdc2-858d2f7c1b46@linux.intel.com>
 <YwOKyBL7lNmyaFqs@worktop.programming.kicks-ass.net>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <YwOKyBL7lNmyaFqs@worktop.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022-08-22 9:55 a.m., Peter Zijlstra wrote:
> On Mon, Aug 22, 2022 at 09:24:57AM -0400, Liang, Kan wrote:
>> I think the only issue should be the PMU name. The non-hybrid PMU name
>> is "cpu". The hybrid PMU name is "cpu_$coretype". If we move the
>> ALDERLAKE_N to the non-hybrid PMU, the PMU name will be changed from
>> "cpu_atom" to "cpu". It will be different from the rest of
>> {ALDER,RAPTOP}LAKE.
>>
>> Also, I think we have to update the perf tool for the events because of
>> the PMU name change.
>>
>> But I guess it should be OK, since the ALDERLAKE_N was just added and we
>> know its an Atom-only system.
> 
> cpu/caps/pmu_name should be 'Gracemont', which is exactly like all the
> other !hybrid setups. Surely perf-tools already knows about this
> pattern.
> 
> IOW, if you need to change perf-tools for this, someone did something
> wrong somewhere.

The event list for ADL and RPL is different from the non-hybrid
platforms. We combine the events from big core and small core into a
single file and use the PMU name to distinguish from them. The PMU name
is either cpu_core or cpu_atom.

If we change the ADL-N to non-hybrid, the simplest way is to create a
dedicate gracemont event list. Or we have to specially handle the ADL-N
in the parsing codes. We have to update the tool for either way.

> 
> (also, I just noticed, 'Tremont' is the *only* PMU that has a
> capitalized name, perhaps we don't want Gracemont to follow but instead
> fix tremont if that is still possible)

I don't think the tool rely on the name under cpu/caps/pmu_name.
The event list rely on the CPU model number.
It should be OK to fix the tremont name.


Thanks,
Kan
