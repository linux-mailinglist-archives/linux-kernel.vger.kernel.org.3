Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B47224F5159
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 04:34:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1845937AbiDFCCD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 22:02:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1457461AbiDEQDP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 12:03:15 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B7A7A6E2A
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 08:47:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649173639; x=1680709639;
  h=message-id:date:mime-version:to:cc:references:from:
   subject:in-reply-to:content-transfer-encoding;
  bh=A+rkSrQ9YlVDO5qD3GUl3Wuak+sW+zKmsgvd5IM6ge8=;
  b=NYB3pXXTDZK/WpSPr6wEqyRaJrN+RExEawEAxS50vvT3g9++v++SCfb4
   RSh+WZtL1oL1yCqkMV6aDPNd+QKvrbkxWsDUl378stQbFgBCCwWMgj0Jp
   CBtwtF6k0y2I8G68WbtfvGRZLg0d1Ta4qODgYMrbdfCEmJgUQ7tgVNnEV
   C4yQ8Pd3ETB5PqRnv2fzkZXqRD6zCf4EywhAJCUUoJTO/+ROWBfHlRfLY
   D+ohX+B+Mbi/PBUbjcLOIeuwnJECxCDUF6UgyDBCcLg1lQfzhKKA4NXJn
   2G0ygZEKtjds1Hd9G1cJ3lKrL+X4qvQKBxkfhOb1chlpP9MnM5kyDBZNg
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10308"; a="240718958"
X-IronPort-AV: E=Sophos;i="5.90,236,1643702400"; 
   d="scan'208";a="240718958"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2022 08:47:18 -0700
X-IronPort-AV: E=Sophos;i="5.90,236,1643702400"; 
   d="scan'208";a="549107626"
Received: from nldesimo-desk1.amr.corp.intel.com (HELO [10.212.148.3]) ([10.212.148.3])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2022 08:47:17 -0700
Message-ID: <5873a444-bb32-f0d5-27f1-173f469baf21@intel.com>
Date:   Tue, 5 Apr 2022 08:47:20 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Content-Language: en-US
To:     "Limonciello, Mario" <Mario.Limonciello@amd.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Karny, Wyes" <Wyes.Karny@amd.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Carroll, Lewis" <Lewis.Carroll@amd.com>,
        "Shenoy, Gautham Ranjal" <gautham.shenoy@amd.com>,
        "Narayan, Ananth" <Ananth.Narayan@amd.com>,
        "Rao, Bharata Bhasker" <bharata@amd.com>,
        "len.brown@intel.com" <len.brown@intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "chang.seok.bae@intel.com" <chang.seok.bae@intel.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "metze@samba.org" <metze@samba.org>,
        "zhengqi.arch@bytedance.com" <zhengqi.arch@bytedance.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>
References: <20220405130021.557880-1-wyes.karny@amd.com>
 <YkxNFyXqC12nXyfM@hirez.programming.kicks-ass.net>
 <7cdc2103-c6d4-e1b6-9804-6739112eee4d@intel.com>
 <BL1PR12MB515745615F4C92627033CD5BE2E49@BL1PR12MB5157.namprd12.prod.outlook.com>
From:   Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCH] x86: Prefer MWAIT over HALT on AMD processors
In-Reply-To: <BL1PR12MB515745615F4C92627033CD5BE2E49@BL1PR12MB5157.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/5/22 08:34, Limonciello, Mario wrote:
>>>         if (!static_cpu_has(X86_FEATURE_ZEN)) {
>>>                 msr |= ssbd_tif_to_amd_ls_cfg(tifn);
>>>                 wrmsrl(MSR_AMD64_LS_CFG, msr);
>>>                 return;
>>>         }
>> This seem _bit_ at odds with the commit message (and the AMD SSBD
>> whitepaper):
>>
>>>     Add the necessary synchronization logic for AMD family 17H.
>> So, is X86_FEATURE_ZEN for family==0x17, or family>=0x17?
> There are Zen family CPUs and APUs from family 0x19.  Perhaps at the
> time of the whitepaper there weren't yet though.

Is this a gap in the documentation, then?  Is there some documentation
of the availability of SSBD mitigations on family 0x19?

Anyway, back to MWAIT...  It would be really great to include the
assumptions about what X86_FEATURE_ZEN means in the context of this
patch.  Does this patch *really* mean "Zen microarchitecture" only?
