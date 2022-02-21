Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAF244BD83D
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 09:41:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346145AbiBUIJf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 03:09:35 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235981AbiBUIJd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 03:09:33 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D3D5FDC
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 00:09:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645430950; x=1676966950;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=qbUaYu2MpCSrxstJ/MFa37WzkHJTalEGy6R1APK8nEM=;
  b=UYwjrAthKdXoRVv0KSE2NN8j1RSIa3L2YIx6QCaQq/OOa/wPeZjxVF2w
   brhMgpSnpQ94YZtmdpC8HIuK14dQOo+lJJSZnkgCXAe8IGeGpKEIIWXQM
   dPZd/bqsc/0ebYBhMahnPbn9SCvMfdgm8b52o8+bcCqGcuaS2Bk1J6bOs
   3zJKSHRAKfZUDdeEwtlL8q0phtA+ryiqwQYCRCmBbmu9lfFTaEqx378el
   lNk9cdaXN7oAfGvXZ1oBbUj8NTBVAI2qJG0V7SjpFj2lIUNb6AD52SM/d
   Ic1pHax1pfHBZXx9UzjQ3VDUER6pwwvX2ezxxPnGEQP2hg7nuylJwgmSB
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10264"; a="314723137"
X-IronPort-AV: E=Sophos;i="5.88,385,1635231600"; 
   d="scan'208";a="314723137"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2022 00:09:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,385,1635231600"; 
   d="scan'208";a="778624281"
Received: from lkp-server01.sh.intel.com (HELO da3212ac2f54) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 21 Feb 2022 00:09:08 -0800
Received: from kbuild by da3212ac2f54 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nM3kq-0001Ox-2m; Mon, 21 Feb 2022 08:09:08 +0000
Date:   Mon, 21 Feb 2022 16:09:00 +0800
From:   kernel test robot <lkp@intel.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org
Subject: [ammarfaizi2-block:axboe/linux-block/m1/2022-02-19 399/552]
 net/netfilter/nf_conntrack_bpf.c:251:5: warning: no previous prototype for
 'register_nf_conntrack_bpf'
Message-ID: <202202211633.v1f4ksHj-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

First bad commit (maybe != root cause):

tree:   https://github.com/ammarfaizi2/linux-block axboe/linux-block/m1/2022-02-19
head:   b781e0ccdc0c9a931571d15db09d45b7258b9905
commit: 479e353d1823d7efddab1262e4333417d88a3b32 [399/552] Merge branch 'akpm-current/current'
config: arm-buildonly-randconfig-r003-20220221 (https://download.01.org/0day-ci/archive/20220221/202202211633.v1f4ksHj-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/ammarfaizi2/linux-block/commit/479e353d1823d7efddab1262e4333417d88a3b32
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block axboe/linux-block/m1/2022-02-19
        git checkout 479e353d1823d7efddab1262e4333417d88a3b32
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arm SHELL=/bin/bash net/netfilter/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> net/netfilter/nf_conntrack_bpf.c:251:5: warning: no previous prototype for 'register_nf_conntrack_bpf' [-Wmissing-prototypes]
     251 | int register_nf_conntrack_bpf(void)
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~


vim +/register_nf_conntrack_bpf +251 net/netfilter/nf_conntrack_bpf.c

b4c2b9593a1c4c Kumar Kartikeya Dwivedi 2022-01-14  250  
b4c2b9593a1c4c Kumar Kartikeya Dwivedi 2022-01-14 @251  int register_nf_conntrack_bpf(void)

:::::: The code at line 251 was first introduced by commit
:::::: b4c2b9593a1c4c3a718370e34af28e817fd5e5c6 net/netfilter: Add unstable CT lookup helpers for XDP and TC-BPF

:::::: TO: Kumar Kartikeya Dwivedi <memxor@gmail.com>
:::::: CC: Alexei Starovoitov <ast@kernel.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
