Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30CA24E2B75
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 16:06:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349796AbiCUPHj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 11:07:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238929AbiCUPHd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 11:07:33 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC02D35A8B
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 08:06:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647875164; x=1679411164;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=sF3Jyab+zqmGMPGVvvgzz0D1IVzwyPy158oTAeffMB4=;
  b=UrSKDLRVTX8YXvglHAn1iBs6wWUpXlzqOyaGKZVzaakYX2OjzNJYr7nS
   SMcc7zR7zwushpEefwTNUBvyuhrmNjHKZ0GSIugMGL0KNDdH41hLfqEYD
   dRGJb1QBKiI988Nj2Lh4/8778Ypdy58XJnVmTjUufr2J/KPvp9BfxDaad
   43F6Dl0nR9/Wb46AOgI9T62YDDrja09ss2JILLqfPMEWuguTBAK7mojrM
   19NHtV5SwKHY79ybOhiWA4k9mmBOehgZqmqcdav/b+yrBjL9TufVCcxiI
   n/9I+9igVKoY2iQDeOEuD3LgtJOmDIkmdG96tATRysXZazJYwpzmoXWYS
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10292"; a="257522117"
X-IronPort-AV: E=Sophos;i="5.90,198,1643702400"; 
   d="scan'208";a="257522117"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2022 08:06:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,198,1643702400"; 
   d="scan'208";a="518469344"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 21 Mar 2022 08:06:02 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nWJbd-000HvL-NB; Mon, 21 Mar 2022 15:06:01 +0000
Date:   Mon, 21 Mar 2022 23:05:23 +0800
From:   kernel test robot <lkp@intel.com>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Miguel Ojeda <ojeda@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: mm/damon/core.c:469 __damon_stop() warn: if();
Message-ID: <202203212359.HWkV7SP9-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   f443e374ae131c168a065ea1748feac6b2e76613
commit: e1edc277e6f6dfb372216522dfc57f9381c39e35 linux/container_of.h: switch to static_assert
date:   4 months ago
config: nds32-randconfig-m031-20220320 (https://download.01.org/0day-ci/archive/20220321/202203212359.HWkV7SP9-lkp@intel.com/config)
compiler: nds32le-linux-gcc (GCC) 11.2.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

smatch warnings:
mm/damon/core.c:469 __damon_stop() warn: if();

vim +469 mm/damon/core.c

2224d8485492e49 SeongJae Park 2021-09-07  456  
2224d8485492e49 SeongJae Park 2021-09-07  457  /*
2224d8485492e49 SeongJae Park 2021-09-07  458   * __damon_stop() - Stops monitoring of given context.
2224d8485492e49 SeongJae Park 2021-09-07  459   * @ctx:	monitoring context
2224d8485492e49 SeongJae Park 2021-09-07  460   *
2224d8485492e49 SeongJae Park 2021-09-07  461   * Return: 0 on success, negative error code otherwise.
2224d8485492e49 SeongJae Park 2021-09-07  462   */
2224d8485492e49 SeongJae Park 2021-09-07  463  static int __damon_stop(struct damon_ctx *ctx)
2224d8485492e49 SeongJae Park 2021-09-07  464  {
0f91d13366a4024 Changbin Du   2021-11-05  465  	struct task_struct *tsk;
0f91d13366a4024 Changbin Du   2021-11-05  466  
2224d8485492e49 SeongJae Park 2021-09-07  467  	mutex_lock(&ctx->kdamond_lock);
0f91d13366a4024 Changbin Du   2021-11-05  468  	tsk = ctx->kdamond;
0f91d13366a4024 Changbin Du   2021-11-05 @469  	if (tsk) {
0f91d13366a4024 Changbin Du   2021-11-05  470  		get_task_struct(tsk);
2224d8485492e49 SeongJae Park 2021-09-07  471  		mutex_unlock(&ctx->kdamond_lock);
0f91d13366a4024 Changbin Du   2021-11-05  472  		kthread_stop(tsk);
0f91d13366a4024 Changbin Du   2021-11-05  473  		put_task_struct(tsk);
2224d8485492e49 SeongJae Park 2021-09-07  474  		return 0;
2224d8485492e49 SeongJae Park 2021-09-07  475  	}
2224d8485492e49 SeongJae Park 2021-09-07  476  	mutex_unlock(&ctx->kdamond_lock);
2224d8485492e49 SeongJae Park 2021-09-07  477  
2224d8485492e49 SeongJae Park 2021-09-07  478  	return -EPERM;
2224d8485492e49 SeongJae Park 2021-09-07  479  }
2224d8485492e49 SeongJae Park 2021-09-07  480  

:::::: The code at line 469 was first introduced by commit
:::::: 0f91d13366a402420bf98eaaf393db03946c13e0 mm/damon: simplify stop mechanism

:::::: TO: Changbin Du <changbin.du@gmail.com>
:::::: CC: Linus Torvalds <torvalds@linux-foundation.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
