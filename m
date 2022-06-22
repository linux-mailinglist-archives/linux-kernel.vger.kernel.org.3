Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A8A6554FA0
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 17:42:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359419AbiFVPl5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 11:41:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359399AbiFVPl4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 11:41:56 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 211D12ED61;
        Wed, 22 Jun 2022 08:41:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655912515; x=1687448515;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=asHJVhWeV+R8cmVwvDLScqFgc1cDRCkZ63VeXkC61AY=;
  b=lWVmuwyk1OK8I5o7be5BqiEtqZnzqF15pbUG9er/qIlxem2f8/QDrcg7
   htrAQATXf0rovES/gR5QUBN32NfRIuQ5hqsf2+NuJdmA5EQR4xl5mZuld
   69N89ufq/vqjpkuiYpOQdsOMyHoALaTz/7h6SPLmbLarr5iGxbaRDrvZS
   8e2PFjLLMlTFsys8bdfCliSJCBrkUVIabKh5VzuMmxDi6uF54NVmkXfjj
   XXC4lEZa5PRD8amYXb5qZcrNYSzKE+SRKakMnqxhbtUpgkGwGjK2tfCMe
   marOxm7QOdvgSt5L2xvHzMUMWKcLAaPjuRLxKZc7wKT0/cT3O9/Lk+WJr
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10386"; a="260883148"
X-IronPort-AV: E=Sophos;i="5.92,212,1650956400"; 
   d="scan'208";a="260883148"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2022 08:34:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,212,1650956400"; 
   d="scan'208";a="538513263"
Received: from lkp-server02.sh.intel.com (HELO a67cc04a5eeb) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 22 Jun 2022 08:34:51 -0700
Received: from kbuild by a67cc04a5eeb with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o42NW-0001QG-QX;
        Wed, 22 Jun 2022 15:34:50 +0000
Date:   Wed, 22 Jun 2022 23:34:47 +0800
From:   kernel test robot <lkp@intel.com>
To:     Valentin Schneider <vschneid@redhat.com>,
        linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
        linux-rt-users@vger.kernel.org
Cc:     kbuild-all@lists.01.org, Eric Biederman <ebiederm@xmission.com>,
        Arnd Bergmann <arnd@arndb.de>, Petr Mladek <pmladek@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Juri Lelli <jlelli@redhat.com>,
        "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>
Subject: Re: [PATCH] panic, kexec: Don't mutex_trylock() in __crash_kexec()
Message-ID: <202206222322.WsTIFQGo-lkp@intel.com>
References: <20220616123709.347053-1-vschneid@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220616123709.347053-1-vschneid@redhat.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Valentin,

I love your patch! Yet something to improve:

[auto build test ERROR on soc/for-next]
[also build test ERROR on linus/master v5.19-rc3 next-20220622]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Valentin-Schneider/panic-kexec-Don-t-mutex_trylock-in-__crash_kexec/20220616-203915
base:   https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git for-next
config: riscv-randconfig-c024-20220622 (https://download.01.org/0day-ci/archive/20220622/202206222322.WsTIFQGo-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/d05873bf87d81eb3ddfa1fe20b3743cc4a1ab259
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Valentin-Schneider/panic-kexec-Don-t-mutex_trylock-in-__crash_kexec/20220616-203915
        git checkout d05873bf87d81eb3ddfa1fe20b3743cc4a1ab259
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   riscv64-linux-ld: kernel/kexec_core.o: in function `kimage_crash_copy_vmcoreinfo':
   kernel/kexec_core.c:502: undefined reference to `machine_kexec_cleanup'
   riscv64-linux-ld: kernel/kexec_core.o: in function `clear_bit':
>> arch/riscv/include/asm/bitops.h:129: undefined reference to `machine_crash_shutdown'
   riscv64-linux-ld: kernel/kexec_core.o: in function `kimage_free_pages':
   kernel/kexec_core.c:337: undefined reference to `machine_kexec'
   riscv64-linux-ld: kernel/kexec_core.o: in function `kimage_free':
   kernel/kexec_core.c:651: undefined reference to `riscv_crash_save_regs'
   riscv64-linux-ld: kernel/kexec_core.o: in function `__nr_to_section':
   include/linux/mmzone.h:1403: undefined reference to `machine_shutdown'
   riscv64-linux-ld: include/linux/mmzone.h:1403: undefined reference to `machine_kexec'
   riscv64-linux-ld: kernel/kexec_file.o: in function `__section_mem_map_addr':
   include/linux/mmzone.h:1434: undefined reference to `machine_kexec_prepare'


vim +129 arch/riscv/include/asm/bitops.h

fab957c11efe2f Palmer Dabbelt 2017-07-10  117  
fab957c11efe2f Palmer Dabbelt 2017-07-10  118  /**
fab957c11efe2f Palmer Dabbelt 2017-07-10  119   * clear_bit - Clears a bit in memory
fab957c11efe2f Palmer Dabbelt 2017-07-10  120   * @nr: Bit to clear
fab957c11efe2f Palmer Dabbelt 2017-07-10  121   * @addr: Address to start counting from
fab957c11efe2f Palmer Dabbelt 2017-07-10  122   *
fab957c11efe2f Palmer Dabbelt 2017-07-10  123   * Note: there are no guarantees that this function will not be reordered
fab957c11efe2f Palmer Dabbelt 2017-07-10  124   * on non x86 architectures, so if you are writing portable code,
fab957c11efe2f Palmer Dabbelt 2017-07-10  125   * make sure not to rely on its reordering guarantees.
fab957c11efe2f Palmer Dabbelt 2017-07-10  126   */
fab957c11efe2f Palmer Dabbelt 2017-07-10  127  static inline void clear_bit(int nr, volatile unsigned long *addr)
fab957c11efe2f Palmer Dabbelt 2017-07-10  128  {
fab957c11efe2f Palmer Dabbelt 2017-07-10 @129  	__op_bit(and, __NOT, nr, addr);
fab957c11efe2f Palmer Dabbelt 2017-07-10  130  }
fab957c11efe2f Palmer Dabbelt 2017-07-10  131  

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
