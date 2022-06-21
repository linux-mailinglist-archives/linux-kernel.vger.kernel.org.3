Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A1B9552976
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 04:40:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344484AbiFUCjg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 22:39:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244545AbiFUCje (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 22:39:34 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19EE8CE35
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 19:39:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655779174; x=1687315174;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xCEmjp76i6Brb9eB2mFQBJ51i6/s+EEMAFzhf6ZmxSo=;
  b=Y0TYyZIYg0bAG44tCvFJI0aDk1p+EHrU7R9sQpX9un6kUnjKy4O1djb7
   JNWgt5mvb0xBqdIwvMkCTf+KHlqz7R6F2/Z7d0gV98vUmjCjb8bgaZldf
   8jjD08B6FJMVj7e1awGD8P+I7RXEhGVWc//MS+XswvdquEev+AI+vcC9P
   45HREGxxNmCjsNmYjHeIjNxJLFSKbPaxSp4X32fraNjNaIkg/ByStiQ+2
   t1GVKSBCrLtfKh+6QBVBQUz1rqDwXhfVEKZHvq2RxjJSuVzHyMXbuAFdL
   D/x+TXkf2Ucm55VEZBD/sd+H6kqwpvTnDHiW4nVWmI0hwqDEcM5vqFB+F
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10384"; a="344003550"
X-IronPort-AV: E=Sophos;i="5.92,207,1650956400"; 
   d="scan'208";a="344003550"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2022 19:39:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,207,1650956400"; 
   d="scan'208";a="764296831"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 20 Jun 2022 19:39:32 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o3Tna-000Xuv-CG;
        Tue, 21 Jun 2022 02:39:26 +0000
Date:   Tue, 21 Jun 2022 10:38:48 +0800
From:   kernel test robot <lkp@intel.com>
To:     Edward Wu <edwardwu@realtek.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Cc:     kbuild-all@lists.01.org,
        Linux Memory Management List <linux-mm@kvack.org>,
        surenb@google.com, minchan@google.com, edwardwu@realtek.com
Subject: Re: [PATCH] mm: cma: sync everything after EBUSY
Message-ID: <202206211055.X7Tcbmrt-lkp@intel.com>
References: <20220615021504.23358-1-edwardwu@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220615021504.23358-1-edwardwu@realtek.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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
config: x86_64-randconfig-s022 (https://download.01.org/0day-ci/archive/20220621/202206211055.X7Tcbmrt-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.4-30-g92122700-dirty
        # https://github.com/intel-lab-lkp/linux/commit/ef04552ed13eb371365fcc55c7ae1e5c3c211168
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Edward-Wu/mm-cma-sync-everything-after-EBUSY/20220615-101716
        git checkout ef04552ed13eb371365fcc55c7ae1e5c3c211168
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> mm/cma.c:415:6: sparse: sparse: symbol 'cma_sync_work' was not declared. Should it be static?
>> mm/cma.c:422:6: sparse: sparse: symbol 'cma_ebusy_sync_pinned_pages' was not declared. Should it be static?

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
