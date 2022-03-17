Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5094A4DCE80
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 20:11:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237883AbiCQTMj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 15:12:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237878AbiCQTMe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 15:12:34 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 401AF208C23
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 12:11:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647544277; x=1679080277;
  h=message-id:date:mime-version:to:cc:references:from:
   subject:in-reply-to:content-transfer-encoding;
  bh=QtbZsZYj0hr0+LT60TV+H4KtAWp3GNm9B4MX5TPGWQk=;
  b=GUmy1ma1DosoGBcQ2Hy4tPidmyGAzHsqv8FsAP0CJPjwWUDOjfs3xHJk
   IlJVcZOA4igLz9A6eNPG8BLcq5TTSAmQrJaxCgXcvxmdkklBwpf91CHhs
   NYJxQOy/1+JbslfKE86ufTTgNwAosSe5ZEBiYTsCjH1bqWjO4rTQ2u14n
   w9dUZUSSNf7G7hjdSJvIlMLf9CzBhkCckPzpmWB0dw1coj18+IYrF53N7
   v5cr31n15CUtl++bNhSMBT89rdFCAHEeaPnmWEKAii/RRBlBPwmZDU0l3
   /EJ7ETOxJVXvfOy3Z1WcQCD34qawwUpsNxc6vp3qmd21RT5Fec0wfU3fe
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10289"; a="237574612"
X-IronPort-AV: E=Sophos;i="5.90,188,1643702400"; 
   d="scan'208";a="237574612"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2022 12:11:16 -0700
X-IronPort-AV: E=Sophos;i="5.90,188,1643702400"; 
   d="scan'208";a="581411403"
Received: from dstanfie-mobl2.amr.corp.intel.com (HELO [10.212.178.19]) ([10.212.178.19])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2022 12:11:16 -0700
Message-ID: <96f9b880-876f-bf4d-8eb0-9ae8bbc8df6d@intel.com>
Date:   Thu, 17 Mar 2022 12:11:08 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Content-Language: en-US
To:     Nadav Amit <namit@vmware.com>
Cc:     kernel test robot <oliver.sang@intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "lkp@lists.01.org" <lkp@lists.01.org>,
        "lkp@intel.com" <lkp@intel.com>,
        "ying.huang@intel.com" <ying.huang@intel.com>,
        "feng.tang@intel.com" <feng.tang@intel.com>,
        "zhengjun.xing@linux.intel.com" <zhengjun.xing@linux.intel.com>,
        "fengwei.yin@intel.com" <fengwei.yin@intel.com>
References: <20220317090415.GE735@xsang-OptiPlex-9020>
 <c85ae95a-6603-ca0d-a653-b3f2f7069e20@intel.com>
 <3B958B13-75F0-4B81-B8CF-99CD140436EB@vmware.com>
From:   Dave Hansen <dave.hansen@intel.com>
Subject: Re: [x86/mm/tlb] 6035152d8e: will-it-scale.per_thread_ops -13.2%
 regression
In-Reply-To: <3B958B13-75F0-4B81-B8CF-99CD140436EB@vmware.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/17/22 12:02, Nadav Amit wrote:
>> This new "early lazy check" behavior could theoretically work both ways.
>> If threads tended to be waking up from idle when TLB flushes were being
>> sent, this would tend to reduce the number of IPIs.  But, since they
>> tend to be going to sleep it increases the number of IPIs.
>>
>> Anybody have a better theory?  I think we should probably revert the commit.
> 
> Let’s get back to the motivation behind this patch.
> 
> Originally we had an indirect branch that on system which are
> vulnerable to Spectre v2 translates into a retpoline.
> 
> So I would not paraphrase this patch purpose as “early lazy check”
> but instead “more efficient lazy check”. There is very little code
> that was executed between the call to on_each_cpu_cond_mask() and
> the actual check of tlb_is_not_lazy(). So what it seems to happen
> in this test-case - according to what you say - is that *slower*
> checks of is-lazy allows to send fewer IPIs since some cores go
> into idle-state.
> 
> Was this test run with retpolines? If there is a difference in
> performance without retpoline - I am probably wrong.

Nope, no retpolines:

> /sys/devices/system/cpu/vulnerabilities/spectre_v2:Mitigation: Enhanced IBRS, IBPB: conditional, RSB filling

which is the same situation as the "Xeon Platinum 8358" which found this
in 0day.

Maybe the increased IPIs with this approach end up being a wash with the
reduced retpoline overhead.

Did you have any specific performance numbers that show the benefit on
retpoline systems?
