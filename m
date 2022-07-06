Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8D1B568E0D
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 17:51:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233205AbiGFPsA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 11:48:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233773AbiGFPrR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 11:47:17 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC60D338AE
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 08:40:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657122012; x=1688658012;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=AKh4mr1uPByPYABv1mpl6RRugd2DcaAFD/hiBVNUfF4=;
  b=AWlB9E7GnHZfYgnh/F8cBOh3rVNw/XsdZpLw0BIq2lZusLQ0HyiG5Vzi
   i1Xh5o499+uMIEDTE1fZSWh0p8KThCoy5N74NpYQa0piv5oi/wd8KHvEk
   qciS31L7aOJGI0jGWESfTnN1zptg6leKBIVVxIr5xf9HiWtPoqxJxR7az
   rqnyOIOoE4WlkpP+9mu+J/SSSrsRcJ8FgJ1bwcs6GM1Ru7nJPzE8H/At0
   Xmu8NwWmM0YZePn5zwu/wHIf4z/eFy8xDdhDfuN6+iRVtgcmnoGHnC7Xm
   DhQHN3+XC/pz4Ra7HrPl/33//FI2O4Qs8ulX10tzjFU+wpT7FcosQnZON
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10400"; a="370096840"
X-IronPort-AV: E=Sophos;i="5.92,250,1650956400"; 
   d="scan'208";a="370096840"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2022 08:40:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,250,1650956400"; 
   d="scan'208";a="661012580"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 06 Jul 2022 08:40:11 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o978M-000KkH-J0;
        Wed, 06 Jul 2022 15:40:10 +0000
Date:   Wed, 6 Jul 2022 23:39:37 +0800
From:   kernel test robot <lkp@intel.com>
To:     Martin Habets <habetsm.xilinx@gmail.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>
Subject: drivers/net/ethernet/sfc/siena/selftest.c:46:15: warning: field ip
 within 'struct efx_loopback_payload' is less aligned than 'struct iphdr' and
 is usually due to 'struct efx_loopback_payload' being packed, which can lead
 to unaligned accesses
Message-ID: <202207062332.BG1QJUUo-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Martin,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   e35e5b6f695d241ffb1d223207da58a1fbcdff4b
commit: c5a13c319e10e795850b61bc7e3447b08024be2e sfc: Add a basic Siena module
date:   8 weeks ago
config: arm-randconfig-r004-20220706 (https://download.01.org/0day-ci/archive/20220706/202207062332.BG1QJUUo-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project f553287b588916de09c66e3e32bf75e5060f967f)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm cross compiling tool for clang build
        # apt-get install binutils-arm-linux-gnueabi
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=c5a13c319e10e795850b61bc7e3447b08024be2e
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout c5a13c319e10e795850b61bc7e3447b08024be2e
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash drivers/net/ethernet/sfc/siena/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/net/ethernet/sfc/siena/selftest.c:46:15: warning: field ip within 'struct efx_loopback_payload' is less aligned than 'struct iphdr' and is usually due to 'struct efx_loopback_payload' being packed, which can lead to unaligned accesses [-Wunaligned-access]
           struct iphdr ip;
                        ^
   1 warning generated.


vim +46 drivers/net/ethernet/sfc/siena/selftest.c

d48523cb88e0703 Martin Habets 2022-05-09  37  
d48523cb88e0703 Martin Habets 2022-05-09  38  /*
d48523cb88e0703 Martin Habets 2022-05-09  39   * Loopback test packet structure
d48523cb88e0703 Martin Habets 2022-05-09  40   *
d48523cb88e0703 Martin Habets 2022-05-09  41   * The self-test should stress every RSS vector, and unfortunately
d48523cb88e0703 Martin Habets 2022-05-09  42   * Falcon only performs RSS on TCP/UDP packets.
d48523cb88e0703 Martin Habets 2022-05-09  43   */
d48523cb88e0703 Martin Habets 2022-05-09  44  struct efx_loopback_payload {
d48523cb88e0703 Martin Habets 2022-05-09  45  	struct ethhdr header;
d48523cb88e0703 Martin Habets 2022-05-09 @46  	struct iphdr ip;
d48523cb88e0703 Martin Habets 2022-05-09  47  	struct udphdr udp;
d48523cb88e0703 Martin Habets 2022-05-09  48  	__be16 iteration;
d48523cb88e0703 Martin Habets 2022-05-09  49  	char msg[64];
d48523cb88e0703 Martin Habets 2022-05-09  50  } __packed;
d48523cb88e0703 Martin Habets 2022-05-09  51  

:::::: The code at line 46 was first introduced by commit
:::::: d48523cb88e0703055c1b33e61eb644a7976f92b sfc: Copy shared files needed for Siena (part 2)

:::::: TO: Martin Habets <martinh@xilinx.com>
:::::: CC: Jakub Kicinski <kuba@kernel.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
