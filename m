Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73B5147C946
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 23:37:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237998AbhLUWhh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 17:37:37 -0500
Received: from mga18.intel.com ([134.134.136.126]:21593 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237387AbhLUWhg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 17:37:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640126256; x=1671662256;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=p/Vl9wCw1ZI3a9nwksfebCZpk0SdstlowEWaFCNjn2M=;
  b=L1uBKmD+MwjWk1J+7CZZTJ0p2sPd8nKKh43Tr3j+QqVVKrKSyccxNUuc
   EnqFNMIQ0rhqVNK2GA28jKd/oFjWXVCIJ+gMS7q7wQYBzH6GeLjf14IqS
   0vTla3ZUO5j70MOrTevOpWPnPxnDhmnD0PC7BAWqhtVBnPq0tHuMq2wWC
   mCZ/H7JMpWHOQx6jvfo21bxMDFpRvDK2V5y8kPY25Wm7vUJ/wAVSEWZQb
   GvCtaDYE4KX9GNyDEFELeM9BcD69xHt58dKS4TZ/zlj+KeHIKyV0qRStn
   7hEEEwevXaj06K0gs5UXeLQ/0OnNjU/a+CLxixpG31JwZb5LEtdD2WO2C
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10205"; a="227354209"
X-IronPort-AV: E=Sophos;i="5.88,224,1635231600"; 
   d="scan'208";a="227354209"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2021 14:37:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,224,1635231600"; 
   d="scan'208";a="484563726"
Received: from lkp-server02.sh.intel.com (HELO 9f38c0981d9f) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 21 Dec 2021 14:37:19 -0800
Received: from kbuild by 9f38c0981d9f with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mznl1-0009cF-0I; Tue, 21 Dec 2021 22:37:19 +0000
Date:   Wed, 22 Dec 2021 06:36:48 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        linux-kernel@vger.kernel.org, tytso@mit.edu,
        gregkh@linuxfoundation.org
Cc:     kbuild-all@lists.01.org, "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Jean-Philippe Aumasson <jeanphilippe.aumasson@gmail.com>
Subject: Re: [PATCH] random: use BLAKE2s instead of SHA1 in extraction
Message-ID: <202112220650.fYJyuWCt-lkp@intel.com>
References: <20211221175047.341782-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211221175047.341782-1-Jason@zx2c4.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi "Jason,

I love your patch! Yet something to improve:

[auto build test ERROR on linux/master]
[also build test ERROR on char-misc/char-misc-testing herbert-cryptodev-2.6/master herbert-crypto-2.6/master linus/master v5.16-rc6 next-20211221]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Jason-A-Donenfeld/random-use-BLAKE2s-instead-of-SHA1-in-extraction/20211222-021452
base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 136057256686de39cc3a07c2e39ef6bc43003ff6
config: nds32-allnoconfig (https://download.01.org/0day-ci/archive/20211222/202112220650.fYJyuWCt-lkp@intel.com/config)
compiler: nds32le-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/79f40c8f3c427b4f4819dca21ea159bc3c0350f0
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Jason-A-Donenfeld/random-use-BLAKE2s-instead-of-SHA1-in-extraction/20211222-021452
        git checkout 79f40c8f3c427b4f4819dca21ea159bc3c0350f0
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=nds32 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   nds32le-linux-ld: lib/crypto/blake2s.o: in function `blake2s_mod_init':
   blake2s.c:(.init.text+0x4): undefined reference to `blake2s_selftest'
>> nds32le-linux-ld: blake2s.c:(.init.text+0x8): undefined reference to `blake2s_selftest'

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
