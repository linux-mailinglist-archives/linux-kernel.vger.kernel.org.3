Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9287351BCE4
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 12:12:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355095AbiEEKP5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 06:15:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354964AbiEEKPw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 06:15:52 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7947450E36
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 03:12:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651745533; x=1683281533;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=cRZWbElP4dFT+XNyGmAAV3ScG1Vp3t5AsXCPagsnMpA=;
  b=iruO502LKAiUcoPtHb7Iy5iYGGJjMfPY2X4rKHH4qsSW0bLeHvWK/d+2
   sxk4GQJ//8CfMoBjezihzI58QcJYu12TFB8+ozgCzp9Nvj7F6A1Wd92IB
   PtPwVo9YK58CN3AJYmfBGLr7ve9eQ9+TDiRdmOBzH2sr0W5mFy+IjK6N4
   nq03ilDkthSeoiJo7V9BCQi6NET7IKrSjzbQrkWQKBj/qA2O6HFVtl/e8
   sZMja2mKLhxb8HsxvfqQZ1JhaoMc5f4Hw7f1APyj1RamjMwl/UeKNSimv
   lQ9hX9Wq64bYLiS3d7vakCKgF9lH6nkMpD60jKJQ/poE58yhnKKbRvST1
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10337"; a="268213934"
X-IronPort-AV: E=Sophos;i="5.91,200,1647327600"; 
   d="scan'208";a="268213934"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2022 03:12:13 -0700
X-IronPort-AV: E=Sophos;i="5.91,201,1647327600"; 
   d="scan'208";a="549290986"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2022 03:12:10 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nmYSt-00CEmE-KK;
        Thu, 05 May 2022 13:12:07 +0300
Date:   Thu, 5 May 2022 13:12:07 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     kernel test robot <oliver.sang@intel.com>
Cc:     Emil Renner Berthing <kernel@esmil.dk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        lkp@lists.01.org, lkp@intel.com
Subject: Re: [serial]  4a218b277f: BUG:kernel_NULL_pointer_dereference,address
Message-ID: <YnOi9zD44PwSODeX@smile.fi.intel.com>
References: <20220505091843.GD10410@xsang-OptiPlex-9020>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220505091843.GD10410@xsang-OptiPlex-9020>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 05, 2022 at 05:18:43PM +0800, kernel test robot wrote:
> 
> 
> Greeting,
> 
> FYI, we noticed the following commit (built with gcc-11):
> 
> commit: 4a218b277fdba357d8e9022ae675c94e59d64b4e ("serial: 8250: dw: Create a generic platform data structure")
> https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master
> 
> in testcase: reaim
> version: reaim-x86_64-7.0.1.13-1_20220411
> with following parameters:
> 
> 	runtime: 300s
> 	nr_task: 100%
> 	test: shared
> 	cpufreq_governor: performance
> 	ucode: 0xec
> 
> test-description: REAIM is an updated and improved version of AIM 7 benchmark.
> test-url: https://sourceforge.net/projects/re-aim-7/
> 
> 
> on test machine: 16 threads 1 sockets Intel(R) Xeon(R) E-2278G CPU @ 3.40GHz with 32G memory
> 
> caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):
> 
> 
> +----------------+------------+------------+
> |                | d9666dfb31 | 4a218b277f |
> +----------------+------------+------------+
> | boot_successes | 6          | 6          |
> +----------------+------------+------------+
> 
> 
> If you fix the issue, kindly add following tag
> Reported-by: kernel test robot <oliver.sang@intel.com>

Isn't it what Heikki's patch should fix?

-- 
With Best Regards,
Andy Shevchenko


