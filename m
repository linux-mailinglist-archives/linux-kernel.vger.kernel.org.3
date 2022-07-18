Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91E655787CC
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 18:50:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234145AbiGRQup (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 12:50:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234053AbiGRQuh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 12:50:37 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE03C2B24A
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 09:50:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658163033; x=1689699033;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=aDYDoczxu1m1tRoXPPkFOqlqcyRfDMtpX4LWYu0EDbE=;
  b=fpRNRACFNK1ds3jc/XEP1sDC4jdI5HdAYTjWmrFcTahTASn+Dc3Mdj/P
   BXPrWWVSm3WESNO1zK3ntlbFL7gJUctvNTGF2uu8Adfcq4NLn/KX3YxVe
   nXGHTviK9RDZwJ32nhHMM5HQX74UaA6jyRAZiiQ7p4YkaIg2kUGI3g+Ur
   5Emrfg+fE5G10h/W6rLvVkCT4S6zppICaaTsXGq3zAdrtJrqeJcf227Sr
   RS1cSxdDsCN1jfuAz11nOiMpFoXirdXfldXc2yICmBPGSJQ7fozd6DMJ9
   4axIE2z3HTE/IkBcJW4kTdDoYdfb07SM84VZz1rZe76GWXGLAVP4uyfzj
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10412"; a="285025939"
X-IronPort-AV: E=Sophos;i="5.92,281,1650956400"; 
   d="scan'208";a="285025939"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2022 09:50:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,281,1650956400"; 
   d="scan'208";a="665086008"
Received: from lkp-server02.sh.intel.com (HELO ff137eb26ff1) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 18 Jul 2022 09:50:31 -0700
Received: from kbuild by ff137eb26ff1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1oDTx0-0004Zy-MN;
        Mon, 18 Jul 2022 16:50:30 +0000
Date:   Tue, 19 Jul 2022 00:50:23 +0800
From:   kernel test robot <lkp@intel.com>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        Arnd Bergmann <arnd@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        Ard Biesheuval <ardb@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Gary Guo <gary@garyguo.net>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm: lib: implement aeabi_uldivmod via div64_u64_rem
Message-ID: <202207190057.1gn0emAr-lkp@intel.com>
References: <20220716001616.4052225-1-ndesaulniers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220716001616.4052225-1-ndesaulniers@google.com>
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nick,

I love your patch! Perhaps something to improve:

[auto build test WARNING on soc/for-next]
[also build test WARNING on arm/for-next linus/master v5.19-rc7 next-20220718]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Nick-Desaulniers/arm-lib-implement-aeabi_uldivmod-via-div64_u64_rem/20220716-231205
base:   https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git for-next
config: arm-ixp4xx_defconfig (https://download.01.org/0day-ci/archive/20220719/202207190057.1gn0emAr-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project d74b88c69dc2644bd0dc5d64e2d7413a0d4040e5)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm cross compiling tool for clang build
        # apt-get install binutils-arm-linux-gnueabi
        # https://github.com/intel-lab-lkp/linux/commit/f0441d7a00899e433705accb0da58c94f4ff8808
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Nick-Desaulniers/arm-lib-implement-aeabi_uldivmod-via-div64_u64_rem/20220716-231205
        git checkout f0441d7a00899e433705accb0da58c94f4ff8808
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> arch/arm/lib/aeabi_uldivmod.c:17:15: warning: no previous prototype for function '__aeabi_uldivmod' [-Wmissing-prototypes]
   struct result __aeabi_uldivmod(u64 numerator, u64 denominator)
                 ^
   arch/arm/lib/aeabi_uldivmod.c:17:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   struct result __aeabi_uldivmod(u64 numerator, u64 denominator)
   ^
   static 
   1 warning generated.


vim +/__aeabi_uldivmod +17 arch/arm/lib/aeabi_uldivmod.c

    16	
  > 17	struct result __aeabi_uldivmod(u64 numerator, u64 denominator)

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
