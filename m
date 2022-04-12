Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 627E54FE5F5
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 18:36:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353487AbiDLQiv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 12:38:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351032AbiDLQis (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 12:38:48 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C12718B14
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 09:36:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649781390; x=1681317390;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8zmapAeyFTtKr42ftB7igvZstrLdaQa5K0dOWyaPelI=;
  b=YM1mZUqE8lHoUjx6D2LgEdz24BbamrH1L7GuInh7Tpmz0xQA9AbV7GEr
   MUpqJTgW96TChZJezH1kdJtRz9JRDm/AX+CU3KXqnYbBw03vGYYybxDEN
   aIYytz7i3tmYWCIFkpytycL5gTi/lR9pnX/YzpHRkO5+RXygBj3rLGmDj
   0l8J1Fc5K8bE7jsjPr/hCU1MpWmMiJxvohj7UMDEOpuDv9FpT+HhZPhoe
   W5c6qHkDVZ4dqHWIJBh4hoT/eXbn0/dY1DUbfw12WYqLvJbBs1kRs0Izd
   QoCLJ7ef6FH0CoLkSSPjKJsgkvHfbWI8KV5Opg3eqxy5bKSEMHrMZWpam
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10315"; a="244314849"
X-IronPort-AV: E=Sophos;i="5.90,254,1643702400"; 
   d="scan'208";a="244314849"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2022 09:29:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,254,1643702400"; 
   d="scan'208";a="590393310"
Received: from lkp-server02.sh.intel.com (HELO d3fc50ef50de) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 12 Apr 2022 09:29:27 -0700
Received: from kbuild by d3fc50ef50de with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1neJOQ-0002zk-UN;
        Tue, 12 Apr 2022 16:29:26 +0000
Date:   Wed, 13 Apr 2022 00:28:42 +0800
From:   kernel test robot <lkp@intel.com>
To:     Eli Cohen <elic@nvidia.com>, mst@redhat.com, jasowang@redhat.com
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, si-wei.liu@oracle.com,
        Eli Cohen <elic@nvidia.com>
Subject: Re: [PATCH v2 1/2] vdpa: Add support for querying vendor statistics
Message-ID: <202204130003.fROyiuxA-lkp@intel.com>
References: <20220412130402.46945-2-elic@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220412130402.46945-2-elic@nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Eli,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on linus/master]
[also build test WARNING on v5.18-rc2 next-20220412]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Eli-Cohen/Show-statistics-for-a-vdpa-device/20220412-212129
base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git ce522ba9ef7e2d9fb22a39eb3371c0c64e2a433e
config: i386-randconfig-a004-20220411 (https://download.01.org/0day-ci/archive/20220413/202204130003.fROyiuxA-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project fe2478d44e4f7f191c43fef629ac7a23d0251e72)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/813a1bf827634a8d7e148b133e2849fac37819cd
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Eli-Cohen/Show-statistics-for-a-vdpa-device/20220412-212129
        git checkout 813a1bf827634a8d7e148b133e2849fac37819cd
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash drivers/usb/typec/ drivers/vdpa/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/vdpa/vdpa.c:1122:61: warning: implicit conversion from 'int' to 's16' (aka 'short') changes value from 65535 to -1 [-Wconstant-conversion]
           [VDPA_ATTR_DEV_QUEUE_INDEX] = NLA_POLICY_RANGE(NLA_U32, 0, 65535),
                                         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~
   include/net/netlink.h:396:9: note: expanded from macro 'NLA_POLICY_RANGE'
           .max = _max                                     \
                  ^~~~
   1 warning generated.


vim +1122 drivers/vdpa/vdpa.c

  1114	
  1115	static const struct nla_policy vdpa_nl_policy[VDPA_ATTR_MAX + 1] = {
  1116		[VDPA_ATTR_MGMTDEV_BUS_NAME] = { .type = NLA_NUL_STRING },
  1117		[VDPA_ATTR_MGMTDEV_DEV_NAME] = { .type = NLA_STRING },
  1118		[VDPA_ATTR_DEV_NAME] = { .type = NLA_STRING },
  1119		[VDPA_ATTR_DEV_NET_CFG_MACADDR] = NLA_POLICY_ETH_ADDR,
  1120		/* virtio spec 1.1 section 5.1.4.1 for valid MTU range */
  1121		[VDPA_ATTR_DEV_NET_CFG_MTU] = NLA_POLICY_MIN(NLA_U16, 68),
> 1122		[VDPA_ATTR_DEV_QUEUE_INDEX] = NLA_POLICY_RANGE(NLA_U32, 0, 65535),
  1123	};
  1124	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
