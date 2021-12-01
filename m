Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F20B464601
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 05:34:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346593AbhLAEh2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 23:37:28 -0500
Received: from mga17.intel.com ([192.55.52.151]:7226 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230301AbhLAEhZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 23:37:25 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10184"; a="217074614"
X-IronPort-AV: E=Sophos;i="5.87,277,1631602800"; 
   d="scan'208";a="217074614"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2021 20:34:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,277,1631602800"; 
   d="scan'208";a="477400349"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 30 Nov 2021 20:34:03 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1msHJi-000EFn-HA; Wed, 01 Dec 2021 04:34:02 +0000
Date:   Wed, 1 Dec 2021 12:33:23 +0800
From:   kernel test robot <lkp@intel.com>
To:     Eli Cohen <elic@nvidia.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        "Michael S. Tsirkin" <mst@redhat.com>
Subject: drivers/vhost/vringh.c:586:18: sparse: sparse: restricted __virtio16
 degrades to integer
Message-ID: <202112011211.B9QiemfX-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Eli,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   58e1100fdc5990b0cc0d4beaf2562a92e621ac7d
commit: 5262912ef3cfc5e518892c3d67fb36412cb813e2 vdpa/mlx5: Add support for control VQ and MAC setting
date:   3 months ago
config: riscv-randconfig-s031-20211201 (https://download.01.org/0day-ci/archive/20211201/202112011211.B9QiemfX-lkp@intel.com/config)
compiler: riscv32-linux-gcc (GCC) 11.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=5262912ef3cfc5e518892c3d67fb36412cb813e2
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 5262912ef3cfc5e518892c3d67fb36412cb813e2
        # save the config file to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=riscv SHELL=/bin/bash drivers/vhost/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> drivers/vhost/vringh.c:586:18: sparse: sparse: restricted __virtio16 degrades to integer
>> drivers/vhost/vringh.c:586:18: sparse: sparse: restricted __virtio16 degrades to integer
>> drivers/vhost/vringh.c:586:18: sparse: sparse: cast to restricted __virtio16
   drivers/vhost/vringh.c:594:16: sparse: sparse: restricted __virtio16 degrades to integer
   drivers/vhost/vringh.c:594:16: sparse: sparse: restricted __virtio16 degrades to integer
>> drivers/vhost/vringh.c:594:16: sparse: sparse: cast from restricted __virtio16

vim +586 drivers/vhost/vringh.c

f87d0fbb579818 Rusty Russell      2013-03-20  581  
f87d0fbb579818 Rusty Russell      2013-03-20  582  /* Userspace access helpers: in this case, addresses are really userspace. */
b9f7ac8c72894c Michael S. Tsirkin 2014-12-12  583  static inline int getu16_user(const struct vringh *vrh, u16 *val, const __virtio16 *p)
f87d0fbb579818 Rusty Russell      2013-03-20  584  {
b9f7ac8c72894c Michael S. Tsirkin 2014-12-12  585  	__virtio16 v = 0;
b9f7ac8c72894c Michael S. Tsirkin 2014-12-12 @586  	int rc = get_user(v, (__force __virtio16 __user *)p);
b9f7ac8c72894c Michael S. Tsirkin 2014-12-12  587  	*val = vringh16_to_cpu(vrh, v);
b9f7ac8c72894c Michael S. Tsirkin 2014-12-12  588  	return rc;
f87d0fbb579818 Rusty Russell      2013-03-20  589  }
f87d0fbb579818 Rusty Russell      2013-03-20  590  
b9f7ac8c72894c Michael S. Tsirkin 2014-12-12  591  static inline int putu16_user(const struct vringh *vrh, __virtio16 *p, u16 val)
f87d0fbb579818 Rusty Russell      2013-03-20  592  {
b9f7ac8c72894c Michael S. Tsirkin 2014-12-12  593  	__virtio16 v = cpu_to_vringh16(vrh, val);
b9f7ac8c72894c Michael S. Tsirkin 2014-12-12 @594  	return put_user(v, (__force __virtio16 __user *)p);
f87d0fbb579818 Rusty Russell      2013-03-20  595  }
f87d0fbb579818 Rusty Russell      2013-03-20  596  

:::::: The code at line 586 was first introduced by commit
:::::: b9f7ac8c72894c19bf258a54ecaa708df4ffbe80 vringh: update for virtio 1.0 APIs

:::::: TO: Michael S. Tsirkin <mst@redhat.com>
:::::: CC: Michael S. Tsirkin <mst@redhat.com>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
