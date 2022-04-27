Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B624F5113D6
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 10:51:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350218AbiD0Iy5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 04:54:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232311AbiD0Iyt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 04:54:49 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 203E8F69B4
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 01:51:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651049499; x=1682585499;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=cVH9YL+ouYJr/1XgoYPp1CM6c1MoJ+5usEhlyy5+ads=;
  b=TWpG2MJnAJJ9n0wTmpct5gpE/FGMrMenyxSJ2yN3Tm9ZAUnLPPIPPUsx
   lxNgYltxHcnwQv+yN6jK/fn3e98JRueYyStKiEcLu+sGmG9NHM4qmBROV
   fiaFoLYUO9a0L0gberxmvbmCsrFMw033pA4Zy+Frmgeb+llKt6BKLweyy
   MbQ+5S7u7Ian/YKD/+Pm6iaFO+GjoVqlVbU5K4SSKSMKK9El8RsM7PMi+
   iCWAnf/P/KM5Fh4djrwFqocyUhFoRseA5jALk45Vih/CavcgeToJKD1mm
   k5xXam3mWEanZlhz9uGi4IdC1vcS6Z41GaUFW8hoAqoAa3TTe/o8pR9h9
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10329"; a="246429605"
X-IronPort-AV: E=Sophos;i="5.90,292,1643702400"; 
   d="scan'208";a="246429605"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2022 01:51:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,292,1643702400"; 
   d="scan'208";a="539736231"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 27 Apr 2022 01:51:34 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1njdOX-0004WY-HH;
        Wed, 27 Apr 2022 08:51:33 +0000
Date:   Wed, 27 Apr 2022 16:51:32 +0800
From:   kernel test robot <lkp@intel.com>
To:     cgel.zte@gmail.com, glider@google.com, elver@google.com,
        akpm@linux-foundation.org
Cc:     kbuild-all@lists.01.org, dvyukov@google.com,
        kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, xu xin <xu.xin16@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: Re: [PATCH] mm/kfence: fix a potential NULL pointer dereference
Message-ID: <202204271645.QTJoeela-lkp@intel.com>
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

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on hnaz-mm/master]

url:    https://github.com/intel-lab-lkp/linux/commits/cgel-zte-gmail-com/mm-kfence-fix-a-potential-NULL-pointer-dereference/20220427-151258
base:   https://github.com/hnaz/linux-mm master
config: parisc-allyesconfig (https://download.01.org/0day-ci/archive/20220427/202204271645.QTJoeela-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/920e9e639493bc72bee803c763f09760e3acd063
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review cgel-zte-gmail-com/mm-kfence-fix-a-potential-NULL-pointer-dereference/20220427-151258
        git checkout 920e9e639493bc72bee803c763f09760e3acd063
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=parisc SHELL=/bin/bash mm/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   mm/kfence/core.c: In function '__try_free_kfence_meta':
   mm/kfence/core.c:1067:37: error: 'addr' undeclared (first use in this function)
    1067 |                 kfence_guarded_free(addr, meta, false);
         |                                     ^~~~
   mm/kfence/core.c:1067:37: note: each undeclared identifier is reported only once for each function it appears in
   mm/kfence/core.c: In function '__kfence_free':
>> mm/kfence/core.c:1075:37: warning: passing argument 1 of 'kfence_report_error' makes integer from pointer without a cast [-Wint-conversion]
    1075 |                 kfence_report_error(addr, false, NULL, NULL, KFENCE_ERROR_INVALID);
         |                                     ^~~~
         |                                     |
         |                                     void *
   In file included from mm/kfence/core.c:37:
   mm/kfence/kfence.h:129:40: note: expected 'long unsigned int' but argument is of type 'void *'
     129 | void kfence_report_error(unsigned long address, bool is_write, struct pt_regs *regs,
         |                          ~~~~~~~~~~~~~~^~~~~~~


vim +/kfence_report_error +1075 mm/kfence/core.c

  1069	
  1070	void __kfence_free(void *addr)
  1071	{
  1072		struct kfence_metadata *meta = addr_to_metadata((unsigned long)addr);
  1073	
  1074		if (!meta) {
> 1075			kfence_report_error(addr, false, NULL, NULL, KFENCE_ERROR_INVALID);
  1076			return;
  1077		}
  1078	
  1079		__try_free_kfence_meta(meta);
  1080	}
  1081	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
