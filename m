Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4528E4DCFAB
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 21:50:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229914AbiCQUvQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 16:51:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229886AbiCQUvO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 16:51:14 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A16F1F1D19
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 13:49:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647550197; x=1679086197;
  h=message-id:date:mime-version:to:cc:references:from:
   subject:in-reply-to:content-transfer-encoding;
  bh=OCmJYCFxkrfZnqc0HrsOziL96o+DxlHmBR8ARsJy1Tc=;
  b=QArZN4kstG1Tk9+DsfqeWeiMECEw8n7qrAwbz98ZywXAyLosaqi8pqJ4
   lP1SzyxTolR82m0YAu5ZPnS0jwsq2pMAVO/II1dPchxmoMMIysw3rgVfR
   YLdQCo6IhYP8fdWzc9y4im7xvffE0YRcBnKQKKbStV3S4emryik9ayEIN
   ZHfxKgRsaHQx1UOWcleFaMjYydRHw/n/Khbw8Dyaq+AJPf/wZE9FnYVCY
   ZE6HM3RYy9sAiuWqnOhNnA145wnQaGZTsFWcGpytbq/ishLMk1Dg4NyrT
   52QzT7xR1puMGW2Rb40yDtXn8T81Qxe/OsiAOB28W2FLCnAVdhrZ8FdMn
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10289"; a="236924706"
X-IronPort-AV: E=Sophos;i="5.90,190,1643702400"; 
   d="scan'208";a="236924706"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2022 13:49:56 -0700
X-IronPort-AV: E=Sophos;i="5.90,190,1643702400"; 
   d="scan'208";a="516919382"
Received: from dstanfie-mobl2.amr.corp.intel.com (HELO [10.212.178.19]) ([10.212.178.19])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2022 13:49:56 -0700
Message-ID: <285cf565-ebf7-8cf5-4e57-2245608e79fb@intel.com>
Date:   Thu, 17 Mar 2022 13:49:48 -0700
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
 <96f9b880-876f-bf4d-8eb0-9ae8bbc8df6d@intel.com>
 <DC37F01B-A80F-4839-B4FB-C21F64943E64@vmware.com>
From:   Dave Hansen <dave.hansen@intel.com>
Subject: Re: [x86/mm/tlb] 6035152d8e: will-it-scale.per_thread_ops -13.2%
 regression
In-Reply-To: <DC37F01B-A80F-4839-B4FB-C21F64943E64@vmware.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/17/22 13:32, Nadav Amit wrote:
> Can you please clarify how the bot works - did it notice a performance
> regression and then started bisecting, or did it just check one patch
> at a time?

Oliver can tell us for sure, but it usually finds things by bisecting.
It will pick an upstream commit and compare it to the latest baseline.
If it sees a delta it starts bisecting for the triggering commit.

It isn't a literal 'git bisect', but it's logically similar.

I did ask the 0day folks privately if they had any more performance data
on that commit: good, bad or neutral.

That commit didn't actually look to me like it was fundamental to
anything built after it.  It might not revert cleanly, but it doesn't
look like it would be hard to logically remove.  What other side-effects
are you worried about?

BTW, there's also a dirt simple hack to do the on_each_cpu_cond_mask()
without a retpoline:

	if ((cond_func == tlb_is_not_lazy) &&
            !tlb_is_not_lazy(...))
		continue;

You can't do that literally in arch-independent code, but you get the point.

I know folks have discussed ways of doing this kind of stuff for other
high-value indirect calls.  I need to see if there's anything around
that we could use.
