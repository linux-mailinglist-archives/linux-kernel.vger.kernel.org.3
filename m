Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D9EF590FD9
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 12:58:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238230AbiHLK6t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 06:58:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233391AbiHLK6p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 06:58:45 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88E15ABD5A
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 03:58:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660301923; x=1691837923;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=pjsECAg9GYqPKW7dPlVYry6RTRxn5cZygQq1l/idkQc=;
  b=XHmbEpNooSGU1S4m2whw4ewLl7L2pRshMeH1yBl3RYmvVqtQKPO/yZhG
   esfX87suJrDudvvlanfuuc8YKJYeW9wzAKdvMSA88Bpeaz4Emz5DwP3xm
   B0vjD7TFVAnOmRl5s91PP98/Rp+01cgTn/BNb6NhSytcg1IBGj/KoW7My
   ehbIHQHJGYRtNMscuT0VOU/ZZG9cFMrXTCXIZI0vde3UK1brgBxb5G7xK
   xM8W4PCNPFUlVtQ9d9G45RDJJ+F7p6nZWCX7qlGIkh22EiYHaESXkXeLw
   l3FuBXLyhukbHRLLm7JpLROde9kgn5qjCSBk0IkJ3ydhOIi7hdaW8JqBt
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10436"; a="317542476"
X-IronPort-AV: E=Sophos;i="5.93,231,1654585200"; 
   d="scan'208";a="317542476"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2022 03:58:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,231,1654585200"; 
   d="scan'208";a="665781756"
Received: from lkp-server02.sh.intel.com (HELO 8745164cafc7) ([10.239.97.151])
  by fmsmga008.fm.intel.com with ESMTP; 12 Aug 2022 03:58:40 -0700
Received: from kbuild by 8745164cafc7 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oMSND-0000SG-1i;
        Fri, 12 Aug 2022 10:58:39 +0000
Date:   Fri, 12 Aug 2022 18:58:07 +0800
From:   kernel test robot <lkp@intel.com>
To:     Sathvika Vasireddy <sv@linux.ibm.com>,
        linuxppc-dev@lists.ozlabs.org
Cc:     kbuild-all@lists.01.org, jpoimboe@redhat.com, peterz@infradead.org,
        linux-kernel@vger.kernel.org, aik@ozlabs.ru, mpe@ellerman.id.au,
        mingo@redhat.com, christophe.leroy@csgroup.eu, rostedt@goodmis.org,
        mbenes@suse.cz, npiggin@gmail.com, chenzhongjin@huawei.com,
        linux-arm-kernel@lists.infradead.org,
        naveen.n.rao@linux.vnet.ibm.com, sv@linux.ibm.com
Subject: Re: [PATCH 14/16] objtool: Add arch specific function
 arch_ftrace_match()
Message-ID: <202208121847.XuEAqabf-lkp@intel.com>
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
config: x86_64-defconfig (https://download.01.org/0day-ci/archive/20220812/202208121847.XuEAqabf-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/2b03c8be7104e834933d2f5928e69828190e935c
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Sathvika-Vasireddy/objtool-Enable-and-implement-mcount-option-on-powerpc/20220808-200702
        git checkout 2b03c8be7104e834933d2f5928e69828190e935c
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 prepare

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   arch/x86/decode.c: In function 'arch_ftrace_match':
>> arch/x86/decode.c:28:21: error: 'func' undeclared (first use in this function)
      28 |         if (!strcmp(func->name, "__fentry__"))
         |                     ^~~~
   arch/x86/decode.c:28:21: note: each undeclared identifier is reported only once for each function it appears in
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
