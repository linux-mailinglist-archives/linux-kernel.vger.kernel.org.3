Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE24351BD95
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 12:59:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356319AbiEELCe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 07:02:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356687AbiEELC1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 07:02:27 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B064C53E34
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 03:58:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651748301; x=1683284301;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=KT3yvpmhOyvkbJzjKsPlMjHAaN9ntkeKdCV6ZerT2h4=;
  b=HE9VwrNB2BUaA8beFfDka4VxN8yUlq8nY/qJK1cpBAMimpwj/Y+zT3WZ
   gbp1IN+VxfKB7e6G/5+fLaLirUNmdmoa5gljvcoTJSb5FoqopOfRvFE6E
   TK/4WSX5JVjm+iao81IwNtSYhiqaKddit4i5gqZP7QDdD+wdZ1MjfzreE
   RWz0MfHj+xhRoGu7Y96g2biYD6g3Nw4s2fpZakO1OJm98hx4p/kWDMbZK
   invGJ0Y01tt9V731cEsknBMgf7i2vmy0AeWCSDFXihBD9epptq46+1gOd
   p72clt2VxslFtYiMIXxP7RGZW6CVmh3S6oJRrfeqvudCxLk1bpd0drZ1Y
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10337"; a="268223553"
X-IronPort-AV: E=Sophos;i="5.91,201,1647327600"; 
   d="scan'208";a="268223553"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2022 03:58:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,201,1647327600"; 
   d="scan'208";a="708893373"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 05 May 2022 03:58:19 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nmZBb-000CJm-1N;
        Thu, 05 May 2022 10:58:19 +0000
Date:   Thu, 5 May 2022 18:57:42 +0800
From:   kernel test robot <lkp@intel.com>
To:     Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     kbuild-all@lists.01.org,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-kernel@vger.kernel.org, Hyeonggon Yoo <42.hyeyoo@gmail.com>
Subject: Re: [PATCH] mm/kfence: reset PG_slab and memcg_data before freeing
 __kfence_pool
Message-ID: <202205051852.M26PcwNj-lkp@intel.com>
References: <20220505070105.1835745-1-42.hyeyoo@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220505070105.1835745-1-42.hyeyoo@gmail.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hyeonggon,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on hnaz-mm/master]

url:    https://github.com/intel-lab-lkp/linux/commits/Hyeonggon-Yoo/mm-kfence-reset-PG_slab-and-memcg_data-before-freeing-__kfence_pool/20220505-150237
base:   https://github.com/hnaz/linux-mm master
config: s390-randconfig-r044-20220505 (https://download.01.org/0day-ci/archive/20220505/202205051852.M26PcwNj-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/ad166fcbcd464ea0251165580e1ea0152531fe56
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Hyeonggon-Yoo/mm-kfence-reset-PG_slab-and-memcg_data-before-freeing-__kfence_pool/20220505-150237
        git checkout ad166fcbcd464ea0251165580e1ea0152531fe56
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=s390 SHELL=/bin/bash mm/kfence/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   mm/kfence/core.c: In function 'kfence_init_pool_early':
>> mm/kfence/core.c:634:21: error: 'struct page' has no member named 'memcg_data'
     634 |                 page->memcg_data = 0;
         |                     ^~


vim +634 mm/kfence/core.c

   610	
   611	static bool __init kfence_init_pool_early(void)
   612	{
   613		unsigned long addr;
   614	
   615		if (!__kfence_pool)
   616			return false;
   617	
   618		addr = kfence_init_pool();
   619	
   620		if (!addr)
   621			return true;
   622	
   623		/*
   624		 * Only release unprotected pages, and do not try to go back and change
   625		 * page attributes due to risk of failing to do so as well. If changing
   626		 * page attributes for some pages fails, it is very likely that it also
   627		 * fails for the first page, and therefore expect addr==__kfence_pool in
   628		 * most failure cases.
   629		 */
   630		for (char *p = (char *)addr; p < __kfence_pool + KFENCE_POOL_SIZE; p += PAGE_SIZE) {
   631			struct page *page;
   632	
   633			page = virt_to_page(p);
 > 634			page->memcg_data = 0;
   635			__ClearPageSlab(page);
   636		}
   637		memblock_free_late(__pa(addr), KFENCE_POOL_SIZE - (addr - (unsigned long)__kfence_pool));
   638		__kfence_pool = NULL;
   639		return false;
   640	}
   641	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
