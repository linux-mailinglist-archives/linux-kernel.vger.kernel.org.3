Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7EAA591AC4
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Aug 2022 15:48:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239557AbiHMNs2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Aug 2022 09:48:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238887AbiHMNsZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Aug 2022 09:48:25 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A5A1E00B
        for <linux-kernel@vger.kernel.org>; Sat, 13 Aug 2022 06:48:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660398504; x=1691934504;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=IaNOV5ULcqrPGIPFKhOxGOt/yH1/fsN9Oo9GiVQq6HQ=;
  b=Cv/RkRyIJvK66FkPsTmHe/aHSrR5Jmr+AYL9u8ENaz0CDKIN2p595g9Y
   2J2kdkzdD8LY9bozcSs9D0ZA1WEDxoWwZrkiyceQrOxTBLNYfAfaNF9Dy
   1qS0al6uSKJnjCOaMsobZKnG/VJqs/PXvw7RqfSg1ebAAPCPNE+x0sRhs
   cG1P0oe3RtSl69GlRy/JhfcF20qvOCkMTJVbvMCtZxbfv9+aXtsQmy+At
   u0gyufNcoSYlNIWU5UdcoE4Gn0dn9LoY7PGocurNcfozX+UMJ7FtZQshy
   DKTOkFo2VWwFNpZoVWEQLy5Hxjr7FY3aJMCvVmrVm3zkBGPKREWcXhLkY
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10437"; a="317730701"
X-IronPort-AV: E=Sophos;i="5.93,235,1654585200"; 
   d="scan'208";a="317730701"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2022 06:48:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,235,1654585200"; 
   d="scan'208";a="634974321"
Received: from lkp-server02.sh.intel.com (HELO 8745164cafc7) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 13 Aug 2022 06:48:19 -0700
Received: from kbuild by 8745164cafc7 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oMrUx-0001j4-0B;
        Sat, 13 Aug 2022 13:48:19 +0000
Date:   Sat, 13 Aug 2022 21:48:17 +0800
From:   kernel test robot <lkp@intel.com>
To:     Sathvika Vasireddy <sv@linux.ibm.com>,
        linuxppc-dev@lists.ozlabs.org
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org, jpoimboe@redhat.com,
        peterz@infradead.org, linux-kernel@vger.kernel.org, aik@ozlabs.ru,
        mpe@ellerman.id.au, mingo@redhat.com, christophe.leroy@csgroup.eu,
        rostedt@goodmis.org, mbenes@suse.cz, npiggin@gmail.com,
        chenzhongjin@huawei.com, linux-arm-kernel@lists.infradead.org,
        naveen.n.rao@linux.vnet.ibm.com, sv@linux.ibm.com
Subject: Re: [PATCH 14/16] objtool: Add arch specific function
 arch_ftrace_match()
Message-ID: <202208132139.WhghhLpC-lkp@intel.com>
References: <20220808114908.240813-15-sv@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220808114908.240813-15-sv@linux.ibm.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sathvika,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on linus/master]
[also build test ERROR on v5.19 next-20220812]
[cannot apply to powerpc/next powerpc/topic/ppc-kvm masahiroy-kbuild/for-next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Sathvika-Vasireddy/objtool-Enable-and-implement-mcount-option-on-powerpc/20220808-200702
base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 4e23eeebb2e57f5a28b36221aa776b5a1122dde5
config: x86_64-randconfig-a005 (https://download.01.org/0day-ci/archive/20220813/202208132139.WhghhLpC-lkp@intel.com/config)
compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project 5f1c7e2cc5a3c07cbc2412e851a7283c1841f520)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/2b03c8be7104e834933d2f5928e69828190e935c
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Sathvika-Vasireddy/objtool-Enable-and-implement-mcount-option-on-powerpc/20220808-200702
        git checkout 2b03c8be7104e834933d2f5928e69828190e935c
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 prepare

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   error: write on a pipe with no reader
   error: write on a pipe with no reader
   error: write on a pipe with no reader
>> arch/x86/decode.c:28:14: error: use of undeclared identifier 'func'
           if (!strcmp(func->name, "__fentry__"))
                       ^
   1 error generated.
   make[5]: *** [tools/build/Makefile.build:96: tools/objtool/arch/x86/decode.o] Error 1
   make[4]: *** [tools/build/Makefile.build:139: arch/x86] Error 2
   make[4]: *** Waiting for unfinished jobs....
   make[3]: *** [Makefile:54: tools/objtool/objtool-in.o] Error 2
   make[2]: *** [Makefile:73: objtool] Error 2
   make[1]: *** [Makefile:1347: tools/objtool] Error 2
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:219: __sub-make] Error 2
   make: Target 'prepare' not remade because of errors.

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
