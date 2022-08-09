Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D21E458E3C1
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 01:32:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229586AbiHIXcK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 19:32:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiHIXcI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 19:32:08 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D065E78207
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 16:32:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660087927; x=1691623927;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=GnyjgHSWMN0s1QRaGr/yenGO/uA3yDht7mg4g98kpS4=;
  b=YjAzeN5uINft2xzwn8sMzcXp8omc3Ct2CBhIdgFDWEJHxyypbnXHejCA
   9JnOkmjV+AGzpBhofcE6+I0FnEQoP1OdNrYy/Z+LImhXl7lUaXRbBJZqS
   BfS/qd/zqFJ5vGfpQBBFioFsalXKUTLRNoGfb1fvXqFXF8a/xO/aPhLPa
   eRfeNiLhAmmWKE8ewtpR+NzDjfq+WqASQNzK/NLWRW5g2YwZ/V3TwV5ie
   jXHUeAD/0uUgckTqG86Dd3B6mrW9MtEBWNO4s3vKsmDBiT7Z8vp/SkwGH
   ieBxxQuM0jvHh/hhYR2Okgs9lWelaEJbJVGAzYfLV6gNneR9Wgru0z1DD
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10434"; a="288522281"
X-IronPort-AV: E=Sophos;i="5.93,225,1654585200"; 
   d="scan'208";a="288522281"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2022 16:32:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,225,1654585200"; 
   d="scan'208";a="781038055"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 09 Aug 2022 16:32:03 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oLYhe-000NLx-1n;
        Tue, 09 Aug 2022 23:32:02 +0000
Date:   Wed, 10 Aug 2022 07:31:34 +0800
From:   kernel test robot <lkp@intel.com>
To:     Sathvika Vasireddy <sv@linux.ibm.com>,
        linuxppc-dev@lists.ozlabs.org
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org, jpoimboe@redhat.com,
        peterz@infradead.org, linux-kernel@vger.kernel.org, aik@ozlabs.ru,
        mpe@ellerman.id.au, mingo@redhat.com, christophe.leroy@csgroup.eu,
        rostedt@goodmis.org, mbenes@suse.cz, npiggin@gmail.com,
        chenzhongjin@huawei.com, linux-arm-kernel@lists.infradead.org,
        naveen.n.rao@linux.vnet.ibm.com, sv@linux.ibm.com
Subject: Re: [PATCH 06/16] powerpc: Fix objtool unannotated intra-function
 call warnings on PPC32
Message-ID: <202208100751.LiiKZjrx-lkp@intel.com>
References: <20220808114908.240813-7-sv@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220808114908.240813-7-sv@linux.ibm.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sathvika,

I love your patch! Yet something to improve:

[auto build test ERROR on linus/master]
[also build test ERROR on v5.19 next-20220809]
[cannot apply to powerpc/next powerpc/topic/ppc-kvm masahiroy-kbuild/for-next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Sathvika-Vasireddy/objtool-Enable-and-implement-mcount-option-on-powerpc/20220808-200702
base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 4e23eeebb2e57f5a28b36221aa776b5a1122dde5
config: powerpc-randconfig-r024-20220808 (https://download.01.org/0day-ci/archive/20220810/202208100751.LiiKZjrx-lkp@intel.com/config)
compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project 5f1c7e2cc5a3c07cbc2412e851a7283c1841f520)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install powerpc cross compiling tool for clang build
        # apt-get install binutils-powerpc-linux-gnu
        # https://github.com/intel-lab-lkp/linux/commit/bcefd9c9f24358413a1b210aa591c8758f58b3a9
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Sathvika-Vasireddy/objtool-Enable-and-implement-mcount-option-on-powerpc/20220808-200702
        git checkout bcefd9c9f24358413a1b210aa591c8758f58b3a9
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=powerpc SHELL=/bin/bash arch/powerpc/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> <unknown>:0: error: symbol '__kuep_lock' is already defined

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
