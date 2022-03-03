Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8AAD4CB96E
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 09:43:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231375AbiCCIoL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 03:44:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229741AbiCCIoK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 03:44:10 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 440144476F
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 00:43:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646297005; x=1677833005;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=SHdyf+PKhNOcM/g/UzBGMpH6cSN4pJToBy0ZwbC6omc=;
  b=Z4mgowcgDSTcEYZ9goxNuhRUBjU90TJiLhTzARI2uFinQVRXCmCXWZrq
   ohMEsrF/P//ninyzMAqpR+b20QeHdK0Wqd1LmM7nlS6gDbVrtTVYF2VTt
   8gDsHLfZR5jiCCib59qbwpBNJMeaeilgK2wI9wwK/SWCLdIGbvB9Oistj
   nFWUGZfUjj1Bl7syTAgGgG2lfyrY2XmmdvmEE0+qEMjaLkWK/U1LS1tah
   B2BBhizvICX+JpDdZYh8VMywGJMciMVurERS8IRVvH6pXL4T+SIsxt995
   K9UU5ZGodo3xX3xlOsNkBAFlrXb/OAxfFulwNmNLvTA69NJTRKDXHUdKz
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10274"; a="316836438"
X-IronPort-AV: E=Sophos;i="5.90,151,1643702400"; 
   d="scan'208";a="316836438"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2022 00:43:24 -0800
X-IronPort-AV: E=Sophos;i="5.90,151,1643702400"; 
   d="scan'208";a="535739738"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.239.13.11])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2022 00:43:22 -0800
From:   "Huang, Ying" <ying.huang@intel.com>
To:     kernel test robot <oliver.sang@intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
        <lkp@lists.01.org>, <lkp@intel.com>, <feng.tang@intel.com>,
        <zhengjun.xing@linux.intel.com>, <fengwei.yin@intel.com>,
        <aubrey.li@linux.intel.com>, <yu.c.chen@intel.com>
Subject: Re: [sched/numa]  0fb3978b0a:  stress-ng.fstat.ops_per_sec -18.9%
 regression
References: <20220302140220.GA32817@xsang-OptiPlex-9020>
Date:   Thu, 03 Mar 2022 16:43:20 +0800
In-Reply-To: <20220302140220.GA32817@xsang-OptiPlex-9020> (kernel test robot's
        message of "Wed, 2 Mar 2022 22:02:21 +0800")
Message-ID: <87mti7s9xz.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Oliver,

Thanks for report.

I still cannot connect the regression with the patch yet.  To double
check, I have run test again with "sched_verbose" kernel command line,
and verified that the sched_domain isn't changed at all with the patch.

kernel test robot <oliver.sang@intel.com> writes:
>       0.11   6%      +0.1        0.16   4%  perf-profile.self.cycles-pp.update_rq_clock
>       0.00            +0.1        0.06   6%  perf-profile.self.cycles-pp.memset_erms
>       0.00            +0.1        0.07   5%  perf-profile.self.cycles-pp.get_pid_task
>       0.06   7%      +0.1        0.17   6%  perf-profile.self.cycles-pp.select_task_rq_fair
>       0.54   5%      +0.1        0.68        perf-profile.self.cycles-pp.lockref_put_return
>       4.26            +1.1        5.33        perf-profile.self.cycles-pp.common_perm_cond
>      15.45            +4.9       20.37        perf-profile.self.cycles-pp.lockref_put_or_lock
>      20.12            +6.7       26.82        perf-profile.self.cycles-pp.lockref_get_not_dead

From the perf-profile above, the most visible change is more cycles in
lockref_get_not_dead(), which will loop with cmpxchg on
dentry->d_lockref.  So this appears to be related to the memory layout.
I will try to debug that.

Because stress-ng is a weird "benchmark" although it's a very good
functionality test, and I cannot connect the patch with the test case
and performance metrics collected.  I think this regression should be a
low priority one which shouldn't prevent the merging etc.  But I will
continue to investigate the regression to try to root cause it.

Best Regards,
Huang, Ying
