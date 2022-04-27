Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A874D51170A
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 14:46:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233803AbiD0MVo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 08:21:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233707AbiD0MVj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 08:21:39 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BE291209B
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 05:18:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651061908; x=1682597908;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=U1KrAkavk/Tr6dLOtxSQIS3x9A2FmpeLGm4giGjTM2o=;
  b=KImogeBbkLowRxNGCRpO25N1A/QVVEAvVTUuCsO9R+lWdEjPv5bupzjx
   l9Ua8XtUOICctcTYJ/km2o8PBFbwhuyZiVdW6HDex0SXF9cVS2Qf83hNO
   Tel1PAaGeOnHAcmHg3x0FfN+L1BWnEUZA0Tg1elZ0ImO+PxlV6IKnRa/B
   QT5IcmG9fBbSKfaUGhCv1g7FqrEmELM/y3km5W9MjrTXPraJbgJ/XdPWz
   jsNVB2BN5jmzy6YhQ7wIkowVY8zMx0kPXwfVRG2wV/0LHFUsD+JNwQ2+9
   SMoCQKbteNDSuh6qWs8vMu6IHCaXyaNSruD26FHgZzCl6wNzjpprk1fuS
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10329"; a="246471823"
X-IronPort-AV: E=Sophos;i="5.90,292,1643702400"; 
   d="scan'208";a="246471823"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2022 05:18:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,292,1643702400"; 
   d="scan'208";a="876392050"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 27 Apr 2022 05:18:24 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1njgci-0004eE-9P;
        Wed, 27 Apr 2022 12:18:24 +0000
Date:   Wed, 27 Apr 2022 20:18:16 +0800
From:   kernel test robot <lkp@intel.com>
To:     cgel.zte@gmail.com, glider@google.com, elver@google.com,
        akpm@linux-foundation.org
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org, dvyukov@google.com,
        kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, xu xin <xu.xin16@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: Re: [PATCH] mm/kfence: fix a potential NULL pointer dereference
Message-ID: <202204272015.3JRd9BKR-lkp@intel.com>
References: <20220427071100.3844081-1-xu.xin16@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220427071100.3844081-1-xu.xin16@zte.com.cn>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on hnaz-mm/master]

url:    https://github.com/intel-lab-lkp/linux/commits/cgel-zte-gmail-com/mm-kfence-fix-a-potential-NULL-pointer-dereference/20220427-151258
base:   https://github.com/hnaz/linux-mm master
config: x86_64-randconfig-a014 (https://download.01.org/0day-ci/archive/20220427/202204272015.3JRd9BKR-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 1cddcfdc3c683b393df1a5c9063252eb60e52818)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/920e9e639493bc72bee803c763f09760e3acd063
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review cgel-zte-gmail-com/mm-kfence-fix-a-potential-NULL-pointer-dereference/20220427-151258
        git checkout 920e9e639493bc72bee803c763f09760e3acd063
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> mm/kfence/core.c:1067:23: error: use of undeclared identifier 'addr'
                   kfence_guarded_free(addr, meta, false);
                                       ^
   mm/kfence/core.c:1075:23: warning: incompatible pointer to integer conversion passing 'void *' to parameter of type 'unsigned long' [-Wint-conversion]
                   kfence_report_error(addr, false, NULL, NULL, KFENCE_ERROR_INVALID);
                                       ^~~~
   mm/kfence/kfence.h:129:40: note: passing argument to parameter 'address' here
   void kfence_report_error(unsigned long address, bool is_write, struct pt_regs *regs,
                                          ^
   1 warning and 1 error generated.


vim +/addr +1067 mm/kfence/core.c

0ce20dd840897b1 Alexander Potapenko 2021-02-25  1050  
0ce20dd840897b1 Alexander Potapenko 2021-02-25  1051  
920e9e639493bc7 xu xin              2022-04-27  1052  /* Require: meta is not NULL*/
920e9e639493bc7 xu xin              2022-04-27  1053  static __always_inline void __try_free_kfence_meta(struct kfence_metadata *meta)
920e9e639493bc7 xu xin              2022-04-27  1054  {
8f0b36497303487 Muchun Song         2022-04-01  1055  #ifdef CONFIG_MEMCG
8f0b36497303487 Muchun Song         2022-04-01  1056  	KFENCE_WARN_ON(meta->objcg);
8f0b36497303487 Muchun Song         2022-04-01  1057  #endif
0ce20dd840897b1 Alexander Potapenko 2021-02-25  1058  	/*
0ce20dd840897b1 Alexander Potapenko 2021-02-25  1059  	 * If the objects of the cache are SLAB_TYPESAFE_BY_RCU, defer freeing
0ce20dd840897b1 Alexander Potapenko 2021-02-25  1060  	 * the object, as the object page may be recycled for other-typed
0ce20dd840897b1 Alexander Potapenko 2021-02-25  1061  	 * objects once it has been freed. meta->cache may be NULL if the cache
0ce20dd840897b1 Alexander Potapenko 2021-02-25  1062  	 * was destroyed.
0ce20dd840897b1 Alexander Potapenko 2021-02-25  1063  	 */
0ce20dd840897b1 Alexander Potapenko 2021-02-25  1064  	if (unlikely(meta->cache && (meta->cache->flags & SLAB_TYPESAFE_BY_RCU)))
0ce20dd840897b1 Alexander Potapenko 2021-02-25  1065  		call_rcu(&meta->rcu_head, rcu_guarded_free);
0ce20dd840897b1 Alexander Potapenko 2021-02-25  1066  	else
0ce20dd840897b1 Alexander Potapenko 2021-02-25 @1067  		kfence_guarded_free(addr, meta, false);
0ce20dd840897b1 Alexander Potapenko 2021-02-25  1068  }
0ce20dd840897b1 Alexander Potapenko 2021-02-25  1069  

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
