Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B54BE4C74E4
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 18:48:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239005AbiB1RsA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 12:48:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239426AbiB1RoJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 12:44:09 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7044C9D4D5;
        Mon, 28 Feb 2022 09:36:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646069783; x=1677605783;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=wEVdV4yI1ombLoTQa0l//75zCHmFA3JiLoyrB63opNY=;
  b=Hc59TX80aF7eitg+wFxfxL36CHivYONwsIjmP5OeCID+dI8G2OeX/sYW
   ZKoD42yGvBOk2bgRj0C3qPZxcmMnNSSDOONVOkOr4NR8Rf1CCL1EL9+hn
   1IFuid/hMauT6NsWTiiGtZPCGB2FHLfZbkgdcCXTrojlUTXh9pQKTusw8
   pnsXYcVaH7XSVfOi3gGUU181nf93x8uclpcMLDYdGIAXQKu0+u/5ysCl0
   pGShXfbZHzW/h9ujaBGTtP8GGIoORBa7QApBfuDdslI8w4ElixjOniEiw
   hCCO3U1DM3lL4vaINrD0LwlQqnPTP1KqQQsrJOelEPc6WbzrUP+w3Qoji
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10272"; a="240349922"
X-IronPort-AV: E=Sophos;i="5.90,144,1643702400"; 
   d="scan'208";a="240349922"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2022 09:36:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,144,1643702400"; 
   d="scan'208";a="639062958"
Received: from lkp-server01.sh.intel.com (HELO 788b1cd46f0d) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 28 Feb 2022 09:36:15 -0800
Received: from kbuild by 788b1cd46f0d with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nOjwU-0007b1-EI; Mon, 28 Feb 2022 17:36:14 +0000
Date:   Tue, 1 Mar 2022 01:35:48 +0800
From:   kernel test robot <lkp@intel.com>
To:     Muchun Song <songmuchun@bytedance.com>, corbet@lwn.net,
        mike.kravetz@oracle.com, akpm@linux-foundation.org,
        mcgrof@kernel.org, keescook@chromium.org, yzaikin@google.com
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, duanxiongchun@bytedance.com,
        Muchun Song <songmuchun@bytedance.com>
Subject: Re: [PATCH 3/3] mm: hugetlb: add hugetlb_free_vmemmap sysctl
Message-ID: <202202282100.zrlKlzBR-lkp@intel.com>
References: <20220228071022.26143-4-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220228071022.26143-4-songmuchun@bytedance.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Muchun,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on hnaz-mm/master]
[also build test ERROR on next-20220225]
[cannot apply to mcgrof/sysctl-next linus/master v5.17-rc6]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Muchun-Song/add-hugetlb_free_vmemmap-sysctl/20220228-151303
base:   https://github.com/hnaz/linux-mm master
config: x86_64-randconfig-a001 (https://download.01.org/0day-ci/archive/20220228/202202282100.zrlKlzBR-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project d271fc04d5b97b12e6b797c6067d3c96a8d7470e)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/a2a3193fd949ff24ed0c138ef495e67373839483
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Muchun-Song/add-hugetlb_free_vmemmap-sysctl/20220228-151303
        git checkout a2a3193fd949ff24ed0c138ef495e67373839483
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> mm/hugetlb_vmemmap.c:156:55: error: use of undeclared identifier 'memmap_on_memory'
           if (write && (!is_power_of_2(sizeof(struct page)) || memmap_on_memory))
                                                                ^
   1 error generated.


vim +/memmap_on_memory +156 mm/hugetlb_vmemmap.c

   148	
   149	int hugetlb_vmemmap_sysctl_handler(struct ctl_table *table, int write,
   150					   void *buffer, size_t *length, loff_t *ppos)
   151	{
   152		/*
   153		 * The vmemmap pages cannot be optimized if a "struct page" crosses page
   154		 * boundaries or memory_hotplug.memmap_on_memory is enabled.
   155		 */
 > 156		if (write && (!is_power_of_2(sizeof(struct page)) || memmap_on_memory))

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
