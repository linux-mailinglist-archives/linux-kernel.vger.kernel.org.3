Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33EC94F468D
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 01:13:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353298AbiDEUfa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 16:35:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1455108AbiDEP7h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 11:59:37 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EDFE1ED06E
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 08:10:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649171406; x=1680707406;
  h=message-id:date:mime-version:to:cc:references:from:
   subject:in-reply-to:content-transfer-encoding;
  bh=/45Z/WQFK49fcRPdO9Lci/uCd9R237Qw3oA4Y1Yi1pY=;
  b=V9lc2tWhUrt3btom40TFhdcL9KaUHhlD6gDmsIGXnT4fiEMMtIbUqdgc
   7SFp5QldGn+Q5doEXrSKRlKj+BUHlixe9/CJ2u3riDw+5GXBCtZAPPdc9
   Y6QBMV0CZpec8gn0CUEABNc28xXdLiVZaOGXoY7Kf6ay4bq3m4d6dniUd
   27PqZSu078bjeHkBTYOaDcrCBNcVLPmskJRSsYzrozr5wDwYHuc8OELNI
   Yhb2MbCUzI98F6nkniZeUTeGc9D8ufLP4eBkiMpVsYk9J+hMTntj4st1E
   ifzmJEUTvoIAmF9KvLJfL7nzVf26s0gHl7op/0oj2nnmjof3S31hTmtWX
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10307"; a="258355540"
X-IronPort-AV: E=Sophos;i="5.90,236,1643702400"; 
   d="scan'208";a="258355540"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2022 08:10:03 -0700
X-IronPort-AV: E=Sophos;i="5.90,236,1643702400"; 
   d="scan'208";a="549089860"
Received: from nldesimo-desk1.amr.corp.intel.com (HELO [10.212.148.3]) ([10.212.148.3])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2022 08:10:03 -0700
Message-ID: <7cdc2103-c6d4-e1b6-9804-6739112eee4d@intel.com>
Date:   Tue, 5 Apr 2022 08:10:05 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>,
        Wyes Karny <wyes.karny@amd.com>
Cc:     linux-kernel@vger.kernel.org, Lewis.Carroll@amd.com,
        Mario.Limonciello@amd.com, gautham.shenoy@amd.com,
        Ananth.Narayan@amd.com, bharata@amd.com, len.brown@intel.com,
        x86@kernel.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com,
        chang.seok.bae@intel.com, keescook@chromium.org, metze@samba.org,
        zhengqi.arch@bytedance.com, mark.rutland@arm.com
References: <20220405130021.557880-1-wyes.karny@amd.com>
 <YkxNFyXqC12nXyfM@hirez.programming.kicks-ass.net>
From:   Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCH] x86: Prefer MWAIT over HALT on AMD processors
In-Reply-To: <YkxNFyXqC12nXyfM@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/5/22 07:07, Peter Zijlstra wrote:
> On Tue, Apr 05, 2022 at 06:30:21PM +0530, Wyes Karny wrote:
>> +static inline bool early_mwait_supported(const struct cpuinfo_x86 *c)
>> +{
>> +	if (c->x86_vendor == X86_VENDOR_INTEL)
>> +		return true;
>> +
>> +	if (c->x86_vendor == X86_VENDOR_AMD && cpu_has(c, X86_FEATURE_ZEN))
> What about Hygon? For some reason you guys don't co-ordinate and we end
> up getting endless 'make-same' patches, sometimes separated by years :/

Believe it or not Hygon seems to work OK with this because:

> static void init_hygon(struct cpuinfo_x86 *c)
> {
...
>         set_cpu_cap(c, X86_FEATURE_ZEN);

I do worry a bit though that using X86_FEATURE_ZEN is going to bite us
long-term.  It currently claims to be set for "family 0x17 or above":

> #define X86_FEATURE_ZEN                 ( 7*32+28) /* "" CPU is AMD family 0x17 or above (Zen) */

But then it goes and gets used in side-channel defense:

>         if (!static_cpu_has(X86_FEATURE_ZEN)) {
>                 msr |= ssbd_tif_to_amd_ls_cfg(tifn);
>                 wrmsrl(MSR_AMD64_LS_CFG, msr);
>                 return;
>         }

This seem _bit_ at odds with the commit message (and the AMD SSBD
whitepaper):

>     Add the necessary synchronization logic for AMD family 17H. 

So, is X86_FEATURE_ZEN for family==0x17, or family>=0x17?
