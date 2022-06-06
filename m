Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 006B253EF65
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 22:16:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229861AbiFFUQ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 16:16:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233391AbiFFUQk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 16:16:40 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4556B13AF36
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 13:16:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654546592; x=1686082592;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jtrT9xol1zz8x3wq/vAV4b2zS4KUY7UQ5TB0I2JKtBk=;
  b=keDBCFGSKiBK7UWUdfWZc++mJd1knIiTVh/tfgti6HQTe8fY9O6jU25W
   fbCcvEV7P2v6LbBZHWxFs5YrY6HwqIaF7YiJes/WfZMxzUNU8aZpLtIb4
   KTkUjh9F8bCyRitNNjlDFSabjco39+DNK/euycxe5S45Hs9PyPYEV6Kaq
   0ZMJ5891/3Z4qS1B3nAPChkOvrH6VuqpaK3q9gnhGgjn/cjEtMGSvaQ9m
   xLbH+sZ7D3P1sacQTUyEgvBma0aDcivnrntVlSzS/EZo5waF+eRN2kN3F
   rnldSrT6+6f2jAtscc9Gh0563Z1nvmAu0caQ3v2rPL63sqFA1m6OQfbtP
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10370"; a="340144337"
X-IronPort-AV: E=Sophos;i="5.91,280,1647327600"; 
   d="scan'208";a="340144337"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2022 13:16:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,280,1647327600"; 
   d="scan'208";a="669651235"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 06 Jun 2022 13:16:28 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nyJ9H-000D1x-SJ;
        Mon, 06 Jun 2022 20:16:27 +0000
Date:   Tue, 7 Jun 2022 04:16:14 +0800
From:   kernel test robot <lkp@intel.com>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Masahiro Yamada <masahiroy@kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH] kbuild: fix build failure by scripts/check-local-export
Message-ID: <202206070434.3wvNWfJZ-lkp@intel.com>
References: <ce0b0a88-f8cb-ba9c-8a0e-1a818f8c50e0@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ce0b0a88-f8cb-ba9c-8a0e-1a818f8c50e0@I-love.SAKURA.ne.jp>
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tetsuo,

I love your patch! Yet something to improve:

[auto build test ERROR on masahiroy-kbuild/for-next]
[also build test ERROR on linus/master v5.19-rc1 next-20220606]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Tetsuo-Handa/kbuild-fix-build-failure-by-scripts-check-local-export/20220606-234446
base:   https://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git for-next
config: arm-mxs_defconfig (https://download.01.org/0day-ci/archive/20220607/202206070434.3wvNWfJZ-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project b92436efcb7813fc481b30f2593a4907568d917a)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm cross compiling tool for clang build
        # apt-get install binutils-arm-linux-gnueabi
        # https://github.com/intel-lab-lkp/linux/commit/7047234a52a99a58113ebe0502e1c227af2b6c61
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Tetsuo-Handa/kbuild-fix-build-failure-by-scripts-check-local-export/20220606-234446
        git checkout 7047234a52a99a58113ebe0502e1c227af2b6c61
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm prepare

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   scripts/genksyms/parse.y: warning: 9 shift/reduce conflicts [-Wconflicts-sr]
   scripts/genksyms/parse.y: warning: 5 reduce/reduce conflicts [-Wconflicts-rr]
   scripts/genksyms/parse.y: note: rerun with option '-Wcounterexamples' to generate conflict counterexamples
>> llvm-nm: error: : unknown argument '--'
   make[2]: *** [scripts/Makefile.build:249: scripts/mod/empty.o] Error 1
   make[2]: *** Deleting file 'scripts/mod/empty.o'
   make[2]: Target '__build' not remade because of errors.
   make[1]: *** [Makefile:1195: prepare0] Error 2
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:219: __sub-make] Error 2
   make: Target 'prepare' not remade because of errors.

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
