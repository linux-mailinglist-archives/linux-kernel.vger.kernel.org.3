Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 532B658E856
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 10:01:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231410AbiHJIBs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 04:01:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbiHJIBq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 04:01:46 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C49B174CFB
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 01:01:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660118505; x=1691654505;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=mokVBZqJW1Yse8OYP1CTvEf/PPQJIyLVT1Zlj3li4EM=;
  b=R/3ZkFev5Pr1/tL7forcPlGeZ0dkOnVEMzAC5tOsUfTHgpJ/eRASBO0X
   W71f7htgTPuU20phKVdkwQsg4/4hg8UedmnoCW0mZT5pqcRXPXePZpLJ6
   4tG2ETvMAJ0HfLoeiJASKkxwxOEyUpZVHsBzaDz0n3zTBHNGXtEnw98zp
   EEIfr8GuBqt3R0synzVZrnWXey5tvxXy2pR/HshTdhC1WJ+JVtSGMdJ2X
   FjbUtZiHob4NBieHx/Fn/EEFdgOn9pvo3bRKNqFA9tdEpBM/zeXRWu+W+
   HfdZjQzwr1iZu5iaMkCuuKqWrRVTCDAPRpoxD6TlQ6W7IJPMLmW8+uQur
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10434"; a="352758195"
X-IronPort-AV: E=Sophos;i="5.93,226,1654585200"; 
   d="scan'208";a="352758195"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2022 01:01:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,226,1654585200"; 
   d="scan'208";a="633673969"
Received: from lkp-server02.sh.intel.com (HELO 5d6b42aa80b8) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 10 Aug 2022 01:01:43 -0700
Received: from kbuild by 5d6b42aa80b8 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oLget-00003n-0M;
        Wed, 10 Aug 2022 08:01:43 +0000
Date:   Wed, 10 Aug 2022 16:01:32 +0800
From:   kernel test robot <lkp@intel.com>
To:     David Howells <dhowells@redhat.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Simo Sorce <simo@redhat.com>,
        Herbert Xu <herbert@gondor.apana.org.au>
Subject: ERROR: modpost: "pkcs7_supply_detached_data"
 [crypto/asymmetric_keys/x509_key_parser.ko] undefined!
Message-ID: <202208101504.vAW2fZNR-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   d4252071b97d2027d246f6a82cbee4d52f618b47
commit: 3cde3174eb910513d32a9ec8a9b95ea59be833df certs: Add FIPS selftests
date:   7 weeks ago
config: s390-randconfig-r026-20220808 (https://download.01.org/0day-ci/archive/20220810/202208101504.vAW2fZNR-lkp@intel.com/config)
compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project 5f1c7e2cc5a3c07cbc2412e851a7283c1841f520)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install s390 cross compiling tool for clang build
        # apt-get install binutils-s390x-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=3cde3174eb910513d32a9ec8a9b95ea59be833df
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 3cde3174eb910513d32a9ec8a9b95ea59be833df
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=s390 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: "pkcs7_supply_detached_data" [crypto/asymmetric_keys/x509_key_parser.ko] undefined!
ERROR: modpost: "devm_ioremap_resource" [drivers/dma/qcom/hdma.ko] undefined!
ERROR: modpost: "devm_ioremap_resource" [drivers/dma/idma64.ko] undefined!
ERROR: modpost: "iounmap" [drivers/pcmcia/pcmcia.ko] undefined!
ERROR: modpost: "ioremap" [drivers/pcmcia/pcmcia.ko] undefined!

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
