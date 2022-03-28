Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D28D24EA11B
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 22:05:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245585AbiC1UGs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 16:06:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234908AbiC1UGq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 16:06:46 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 225AA5F25E
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 13:05:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648497905; x=1680033905;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=OUTmVVVo1aCKjqpp8wDTKE6HxZlWRgDq9Nx1tYzfHTc=;
  b=I0wY73Hltj/jCkpeyyW39U6vDmpIAkUaxE6Wafh1qoaY/n/v6rMAtRgM
   0bnfMEqSQ+6Qb6B5XTtjHzops8o1Gc08ak53q9rbXXmE973M56k1rO3TR
   h6JAML+0aiGm7kVKo68gZ3PH5uk5Jvb96NgTM8L3/VfTb7BoY2BtZFD3i
   CQ6rByZEVIKDxjpDR6R13dwle+Ae+uCBxRpPvriTjXiLrqkud52nGCrG/
   v/DvikFuUj46TPEALpvRJ7Rv8augT025geBWVjaAfB1hcP7P25yKGVkNC
   tw8dqqM5nXy75pC3augfO5w8vV4RRKp8gc9ca1fCb6iiLVf9HEfvDnQDC
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10300"; a="246582202"
X-IronPort-AV: E=Sophos;i="5.90,218,1643702400"; 
   d="scan'208";a="246582202"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2022 13:03:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,218,1643702400"; 
   d="scan'208";a="502640853"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 28 Mar 2022 13:03:56 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nYval-0002HX-H0; Mon, 28 Mar 2022 20:03:55 +0000
Date:   Tue, 29 Mar 2022 04:03:31 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kirill Tkhai <kirill.tkhai@openvz.org>, agk@redhat.com,
        snitzer@redhat.com, dm-devel@redhat.com, song@kernel.org,
        linux-kernel@vger.kernel.org, khorenko@virtuozzo.com
Cc:     kbuild-all@lists.01.org
Subject: Re: [PATCH 3/4] dm-qcow2: Introduce driver to create block devices
 over QCOW2 files
Message-ID: <202203290340.HdsYxZJQ-lkp@intel.com>
References: <164846631540.251310.2398727490395218229.stgit@pro>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <164846631540.251310.2398727490395218229.stgit@pro>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kirill,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on device-mapper-dm/for-next]
[also build test ERROR on song-md/md-next linus/master v5.17 next-20220328]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Kirill-Tkhai/dm-Introduce-dm-qcow2-driver-to-attach-QCOW2-files-as-block-device/20220328-192031
base:   https://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git for-next
config: mips-allyesconfig (https://download.01.org/0day-ci/archive/20220329/202203290340.HdsYxZJQ-lkp@intel.com/config)
compiler: mips-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/c41a15c11909af3588885a88f6622c36dcc9ca35
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Kirill-Tkhai/dm-Introduce-dm-qcow2-driver-to-attach-QCOW2-files-as-block-device/20220328-192031
        git checkout c41a15c11909af3588885a88f6622c36dcc9ca35
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=mips SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All error/warnings (new ones prefixed by >>):

>> drivers/md/dm-qcow2-target.c:428:6: warning: no previous prototype for 'ploop_enospc_timer' [-Wmissing-prototypes]
     428 | void ploop_enospc_timer(struct timer_list *timer)
         |      ^~~~~~~~~~~~~~~~~~
--
   drivers/md/dm-qcow2-map.c: In function 'process_cow_indexes_write':
>> drivers/md/dm-qcow2-map.c:3861:28: warning: variable 'qvec' set but not used [-Wunused-but-set-variable]
    3861 |         struct qcow2_bvec *qvec;
         |                            ^~~~
   drivers/md/dm-qcow2-map.c: At top level:
>> drivers/md/dm-qcow2-map.c:4136:6: warning: no previous prototype for 'submit_embedded_qio' [-Wmissing-prototypes]
    4136 | void submit_embedded_qio(struct qcow2_target *tgt, struct qio *qio)
         |      ^~~~~~~~~~~~~~~~~~~
--
   arch/mips/kernel/head.o: in function `kernel_entry':
   (.ref.text+0xac): relocation truncated to fit: R_MIPS_26 against `start_kernel'
   init/main.o: in function `set_reset_devices':
   main.c:(.init.text+0x20): relocation truncated to fit: R_MIPS_26 against `_mcount'
   main.c:(.init.text+0x30): relocation truncated to fit: R_MIPS_26 against `__sanitizer_cov_trace_pc'
   init/main.o: in function `debug_kernel':
   main.c:(.init.text+0xa4): relocation truncated to fit: R_MIPS_26 against `_mcount'
   main.c:(.init.text+0xb4): relocation truncated to fit: R_MIPS_26 against `__sanitizer_cov_trace_pc'
   init/main.o: in function `quiet_kernel':
   main.c:(.init.text+0x128): relocation truncated to fit: R_MIPS_26 against `_mcount'
   main.c:(.init.text+0x138): relocation truncated to fit: R_MIPS_26 against `__sanitizer_cov_trace_pc'
   init/main.o: in function `warn_bootconfig':
   main.c:(.init.text+0x1ac): relocation truncated to fit: R_MIPS_26 against `_mcount'
   main.c:(.init.text+0x1bc): relocation truncated to fit: R_MIPS_26 against `__sanitizer_cov_trace_pc'
   init/main.o: in function `init_setup':
   main.c:(.init.text+0x238): relocation truncated to fit: R_MIPS_26 against `_mcount'
   main.c:(.init.text+0x258): additional relocation overflows omitted from the output
   mips-linux-ld: drivers/md/dm-qcow2-target.o: in function `calc_cached_parameters':
>> dm-qcow2-target.c:(.text.calc_cached_parameters+0x194): undefined reference to `__divdi3'
>> mips-linux-ld: dm-qcow2-target.c:(.text.calc_cached_parameters+0x264): undefined reference to `__divdi3'
   mips-linux-ld: drivers/md/dm-qcow2-map.o: in function `qio_subclu_indexes':
>> dm-qcow2-map.c:(.text.qio_subclu_indexes+0x21c): undefined reference to `__udivdi3'
>> mips-linux-ld: dm-qcow2-map.c:(.text.qio_subclu_indexes+0x298): undefined reference to `__udivdi3'
   mips-linux-ld: drivers/md/dm-qcow2-map.o: in function `calc_refcounters_map':
>> dm-qcow2-map.c:(.text.calc_refcounters_map+0x118): undefined reference to `__divdi3'
>> mips-linux-ld: dm-qcow2-map.c:(.text.calc_refcounters_map+0x184): undefined reference to `__moddi3'
>> mips-linux-ld: dm-qcow2-map.c:(.text.calc_refcounters_map+0x23c): undefined reference to `__divdi3'
   mips-linux-ld: dm-qcow2-map.c:(.text.calc_refcounters_map+0x46c): undefined reference to `__moddi3'
   mips-linux-ld: dm-qcow2-map.c:(.text.calc_refcounters_map+0x4a8): undefined reference to `__divdi3'
   mips-linux-ld: dm-qcow2-map.c:(.text.calc_refcounters_map+0x4f0): undefined reference to `__moddi3'
   mips-linux-ld: dm-qcow2-map.c:(.text.calc_refcounters_map+0x574): undefined reference to `__divdi3'
   mips-linux-ld: dm-qcow2-map.c:(.text.calc_refcounters_map+0x598): undefined reference to `__moddi3'
   mips-linux-ld: drivers/md/dm-qcow2-map.o: in function `calc_cluster_map':
>> dm-qcow2-map.c:(.text.calc_cluster_map+0x178): undefined reference to `__divdi3'
>> mips-linux-ld: dm-qcow2-map.c:(.text.calc_cluster_map+0x198): undefined reference to `__divdi3'
   mips-linux-ld: dm-qcow2-map.c:(.text.calc_cluster_map+0x3d8): undefined reference to `__divdi3'
>> mips-linux-ld: dm-qcow2-map.c:(.text.calc_cluster_map+0x5a8): undefined reference to `__moddi3'
   mips-linux-ld: dm-qcow2-map.c:(.text.calc_cluster_map+0x5d0): undefined reference to `__moddi3'
   mips-linux-ld: dm-qcow2-map.c:(.text.calc_cluster_map+0x650): undefined reference to `__moddi3'
   mips-linux-ld: dm-qcow2-map.c:(.text.calc_cluster_map+0x6bc): undefined reference to `__moddi3'
   mips-linux-ld: drivers/md/dm-qcow2-map.o: in function `split_qio_to_list':
>> dm-qcow2-map.c:(.text.split_qio_to_list+0x228): undefined reference to `__divdi3'
>> mips-linux-ld: dm-qcow2-map.c:(.text.split_qio_to_list+0x244): undefined reference to `__divdi3'
   mips-linux-ld: drivers/md/dm-qcow2-map.o: in function `relocate_refcount_table':
>> dm-qcow2-map.c:(.text.relocate_refcount_table+0x5c8): undefined reference to `__udivdi3'

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
