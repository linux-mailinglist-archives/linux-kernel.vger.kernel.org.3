Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C98C536D07
	for <lists+linux-kernel@lfdr.de>; Sat, 28 May 2022 14:58:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355011AbiE1M5p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 May 2022 08:57:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344012AbiE1M5n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 May 2022 08:57:43 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E619A1C93D
        for <linux-kernel@vger.kernel.org>; Sat, 28 May 2022 05:57:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653742661; x=1685278661;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=r9ui001kVXv8M7pW7pE1Jz+JNGPM/ArNM3O0+9pDUXk=;
  b=jrnkUsaovjVpld/gtOTLQi+/8dOhLBz4h3veumsPCGo0OWUp88K2neC+
   BUtEPl9cOXBmQ+GacFXqoFNoSYh0SG5Bwju5PRN/1MyOAoO9MVp6RCr0B
   7hCP/BS3wWni3cPeXRU/ayUXMPetlkx6ASqUYbKvx6K6LrHh+qVWzETQw
   rbnIRB0l+vNYZqVy9dQOpOe+WffdtlUZd7GJxU0vDI2r3THxvoolxDv3B
   twPegale0qgM3bDyry/zeomzF18OeigIepKS7DwCU1J1702NrFSSpprv1
   /xbH76QYQvx2rk5MtlFnLzD9LZHqQP2z0sCPDlOVrTPKVEHJwJa8ikcft
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10360"; a="262288833"
X-IronPort-AV: E=Sophos;i="5.91,258,1647327600"; 
   d="scan'208";a="262288833"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2022 05:57:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,258,1647327600"; 
   d="scan'208";a="719260375"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 28 May 2022 05:57:38 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nuw0f-0000DI-Dy;
        Sat, 28 May 2022 12:57:37 +0000
Date:   Sat, 28 May 2022 20:57:24 +0800
From:   kernel test robot <lkp@intel.com>
To:     Yue Zou <zouyue3@huawei.com>, sfr@canb.auug.org.au,
        akpm@linux-foundation.org, mhiramat@kernel.org,
        rostedt@goodmis.org, ahalaney@redhat.com, vbabka@suse.cz,
        Jason@zx2c4.com, mark-pk.tsai@mediatek.com,
        linux-kernel@vger.kernel.org
Cc:     kbuild-all@lists.01.org
Subject: Re: [PATCH -next] smp: Move stub from main.c into smp.h
Message-ID: <202205282043.QMZuMrL0-lkp@intel.com>
References: <20220528111122.1888581-1-zouyue3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220528111122.1888581-1-zouyue3@huawei.com>
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yue,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on next-20220527]

url:    https://github.com/intel-lab-lkp/linux/commits/Yue-Zou/smp-Move-stub-from-main-c-into-smp-h/20220528-185146
base:    d3fde8ff50ab265749704bd7fbcf70d35235421f
config: arc-randconfig-r043-20220526 (https://download.01.org/0day-ci/archive/20220528/202205282043.QMZuMrL0-lkp@intel.com/config)
compiler: arc-elf-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/2efe286bd89edfa5448d29a5be89fd54df424c46
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Yue-Zou/smp-Move-stub-from-main-c-into-smp-h/20220528-185146
        git checkout 2efe286bd89edfa5448d29a5be89fd54df424c46
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=arc SHELL=/bin/bash lib/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from include/linux/lockdep.h:14,
                    from include/linux/spinlock.h:62,
                    from include/linux/kref.h:16,
                    from include/linux/mm_types.h:8,
                    from include/linux/buildid.h:5,
                    from include/linux/module.h:14,
                    from lib/test_bitops.c:9:
>> include/linux/smp.h:186:27: error: 'setup_max_cpus' defined but not used [-Werror=unused-const-variable=]
     186 | static const unsigned int setup_max_cpus = NR_CPUS;
         |                           ^~~~~~~~~~~~~~
   cc1: all warnings being treated as errors


vim +/setup_max_cpus +186 include/linux/smp.h

   185	
 > 186	static const unsigned int setup_max_cpus = NR_CPUS;
   187	static inline void setup_nr_cpu_ids(void) { }
   188	static inline void smp_prepare_cpus(unsigned int maxcpus) { }
   189	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
