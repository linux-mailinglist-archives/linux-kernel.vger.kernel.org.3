Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA95F59C08B
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 15:29:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235192AbiHVN27 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 09:28:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235082AbiHVN2r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 09:28:47 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8050EBE08
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 06:28:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661174914; x=1692710914;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=bJv3Rix0qca35VvL9gbE9j/pE1ygxguoqVCxFvNhtp4=;
  b=T2n2XLqyWkZGFybC5ov9yOCI0SIl+0y0DU8DuIU8ma2iSV5OPhseh0tl
   R4B7Txm/CFbxs1TUTh8ChlvVFXptbcWTDU7UfZs+J127N8G99KJcw8VK1
   O60GLFvPDoqfKve/QCOxpi2Ev80dmsmQrwgJMxvcSYUOMVZe5pbWsZa5g
   Zq9F596rDB4W+bWgJsjrf1wbRZg04JwELbeO+gZIt3kJr2MUWUhnmppMK
   ZHpHTQ1/tQXpF6WAsNdRrCJQmLuMzQp0p07mINoHbkmsnCelj8CkZIoR/
   6ru1T2FCsBHuwJBP/HvFeBAKacV5+pq8y265lQsnbuPeathl7BavB3C39
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10447"; a="280383078"
X-IronPort-AV: E=Sophos;i="5.93,254,1654585200"; 
   d="scan'208";a="280383078"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2022 06:28:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,254,1654585200"; 
   d="scan'208";a="698285546"
Received: from linux.intel.com ([10.54.29.200])
  by FMSMGA003.fm.intel.com with ESMTP; 22 Aug 2022 06:28:33 -0700
Received: from [10.252.212.31] (kliang2-mobl1.ccr.corp.intel.com [10.252.212.31])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 94E625806C8;
        Mon, 22 Aug 2022 06:28:32 -0700 (PDT)
Message-ID: <80eea4f7-bb1e-ebb9-37db-9317b8d9c28f@linux.intel.com>
Date:   Mon, 22 Aug 2022 09:28:31 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [RESEND PATCH] perf/x86/intel: Fix unchecked MSR access error for
 Alder Lake N
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     acme@redhat.com, linux-kernel@vger.kernel.org,
        alexander.shishkin@linux.intel.com, ak@linux.intel.com,
        Jianfeng Gao <jianfeng.gao@intel.com>
References: <20220818181530.2355034-1-kan.liang@linux.intel.com>
 <Yv+ggf6PRjL8Eio1@worktop.programming.kicks-ass.net>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <Yv+ggf6PRjL8Eio1@worktop.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022-08-19 10:38 a.m., Peter Zijlstra wrote:
> On Thu, Aug 18, 2022 at 11:15:30AM -0700, kan.liang@linux.intel.com wrote:
>> From: Kan Liang <kan.liang@linux.intel.com>
>>
>> For some Alder Lake N machine, the below unchecked MSR access error may be
>> triggered.
>>
>> [ 0.088017] rcu: Hierarchical SRCU implementation.
>> [ 0.088017] unchecked MSR access error: WRMSR to 0x38f (tried to write
>> 0x0001000f0000003f) at rIP: 0xffffffffb5684de8 (native_write_msr+0x8/0x30)
>> [ 0.088017] Call Trace:
>> [ 0.088017] <TASK>
>> [ 0.088017] __intel_pmu_enable_all.constprop.46+0x4a/0xa0
> 
> FWIW, I seem to get the same error when booting KVM on my ADL. I'm
> fairly sure the whole CPUID vs vCPU thing is a trainwreck.

We will enhance the CPUID to address the issues. Hopefully, we can have
them supported in the next generation.


Thanks,
Kan
