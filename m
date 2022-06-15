Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D73054D1B1
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 21:35:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348030AbiFOTfh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 15:35:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348662AbiFOTfe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 15:35:34 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C051544F9
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 12:35:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655321730; x=1686857730;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0/C2T5/7z7iM43H25C9V8DQyg7z7scPmR21lboW0i50=;
  b=i+c/kD9hsQ59YpJBb34VY66DRTRbksRsZMw4AB3utIzFNHWwP6FzMAiA
   fZAvrnQrcoXm+EGkyjk+s86OuiMyvYnkKgWSgQ+NgxFiULG87b4ovh8o7
   6h2CnBxOzLLJEoMtV9jKlP0xulICGRgHcGyw7kvKzAbHOly4lVPIjh2ta
   vHlNsR5IjLuTFFvQHPeB8AvgCKBC3dSqsTpwrZLxTjOdKiE9FmdcaN9KY
   47nRnpvL6P+j98Go4/2/16s7zc6B4J9iytK9dPeTDu8uar79lE44MoG2G
   KAFawmeZgrThWwoHEkQtwiH8Pix8DDcM/RSX18lnS9+3AIIhNcuS1V/JL
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10379"; a="267774623"
X-IronPort-AV: E=Sophos;i="5.91,302,1647327600"; 
   d="scan'208";a="267774623"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2022 12:35:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,302,1647327600"; 
   d="scan'208";a="713091951"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 15 Jun 2022 12:35:28 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o1YnX-000N8X-CZ;
        Wed, 15 Jun 2022 19:35:27 +0000
Date:   Thu, 16 Jun 2022 03:34:46 +0800
From:   kernel test robot <lkp@intel.com>
To:     Edward Wu <edwardwu@realtek.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Cc:     kbuild-all@lists.01.org,
        Linux Memory Management List <linux-mm@kvack.org>,
        surenb@google.com, minchan@google.com, edwardwu@realtek.com
Subject: Re: [PATCH] mm: cma: sync everything after EBUSY
Message-ID: <202206160330.nZiFjZFG-lkp@intel.com>
References: <20220615021504.23358-1-edwardwu@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220615021504.23358-1-edwardwu@realtek.com>
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Edward,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on akpm-mm/mm-everything]

url:    https://github.com/intel-lab-lkp/linux/commits/Edward-Wu/mm-cma-sync-everything-after-EBUSY/20220615-101716
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
config: xtensa-allyesconfig (https://download.01.org/0day-ci/archive/20220616/202206160330.nZiFjZFG-lkp@intel.com/config)
compiler: xtensa-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/ef04552ed13eb371365fcc55c7ae1e5c3c211168
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Edward-Wu/mm-cma-sync-everything-after-EBUSY/20220615-101716
        git checkout ef04552ed13eb371365fcc55c7ae1e5c3c211168
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=xtensa SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> mm/cma.c:415:6: warning: no previous prototype for 'cma_sync_work' [-Wmissing-prototypes]
     415 | void cma_sync_work(struct work_struct *work)
         |      ^~~~~~~~~~~~~
>> mm/cma.c:422:6: warning: no previous prototype for 'cma_ebusy_sync_pinned_pages' [-Wmissing-prototypes]
     422 | void cma_ebusy_sync_pinned_pages(void)
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +/cma_sync_work +415 mm/cma.c

   414	
 > 415	void cma_sync_work(struct work_struct *work)
   416	{
   417		ksys_sync();
   418		kfree(work);
   419		pr_debug("%s(): EBUSY Sync complete\n", __func__);
   420	}
   421	
 > 422	void cma_ebusy_sync_pinned_pages(void)
   423	{
   424		struct work_struct *work;
   425	
   426		work = kmalloc(sizeof(*work), GFP_ATOMIC);
   427		if (work) {
   428			INIT_WORK(work, cma_sync_work);
   429			schedule_work(work);
   430		}
   431	}
   432	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
