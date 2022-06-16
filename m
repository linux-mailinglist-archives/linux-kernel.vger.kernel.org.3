Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 371D354E555
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 16:49:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377148AbiFPOtO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 10:49:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233699AbiFPOtH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 10:49:07 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 923905F66
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 07:49:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655390945; x=1686926945;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8GRTdOKhgZUTyAOwSLAdCbYHI0wnSiuMdd9R7+rwbdI=;
  b=LwsrVwtFYTN6CMG9O6+mVFAt8q6EIjvro6+l7TxpgODnAPQBHH8hpBus
   +QPZV+f35RCBc+4WQcoZuYCWNSRGin7wsiMIL5q7oohrLYSxXg1KiJE22
   9fRGr/dazW/QVJDglxjPRUecd7u8DfNBEbhdgsP4qwrNU2rhR340ijvpc
   S35aHXOx2ekjClnb869xijGSACqNry29ZXz/EAFso25HiPNgdWsIoVP3T
   0pcLsNZklR0V8YXKkYARv49xJLm3DFmF6OI9hvX49dwKvooP8zgdVi6qC
   UIgQiJrFzpieMSD2uQDn4nDVEKmbb6LrNc7zguunJvq8gimOz7FkPBbj1
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10379"; a="304707872"
X-IronPort-AV: E=Sophos;i="5.92,305,1650956400"; 
   d="scan'208";a="304707872"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2022 07:49:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,305,1650956400"; 
   d="scan'208";a="831590928"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 16 Jun 2022 07:49:03 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o1qnu-000OTA-Lw;
        Thu, 16 Jun 2022 14:49:02 +0000
Date:   Thu, 16 Jun 2022 22:48:58 +0800
From:   kernel test robot <lkp@intel.com>
To:     Liam Howlett <liam.howlett@oracle.com>,
        "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Qian Cai <quic_qiancai@quicinc.com>
Cc:     kbuild-all@lists.01.org, Yu Zhao <yuzhao@google.com>
Subject: Re: [PATCH v2 Fix 2/3] maple_tree: Change spanning store to work on
 larger trees
Message-ID: <202206162211.tEs2TZjY-lkp@intel.com>
References: <20220616011739.802669-3-Liam.Howlett@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220616011739.802669-3-Liam.Howlett@oracle.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Liam,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on akpm-mm/mm-everything]
[cannot apply to linus/master v5.19-rc2 next-20220616]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Liam-Howlett/Maple-tree-spanning-fixes/20220616-091945
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
config: openrisc-randconfig-s032-20220616 (https://download.01.org/0day-ci/archive/20220616/202206162211.tEs2TZjY-lkp@intel.com/config)
compiler: or1k-linux-gcc (GCC) 11.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-30-g92122700-dirty
        # https://github.com/intel-lab-lkp/linux/commit/ebc93d5486b6fed251043d034790c95faac9394d
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Liam-Howlett/Maple-tree-spanning-fixes/20220616-091945
        git checkout ebc93d5486b6fed251043d034790c95faac9394d
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=openrisc SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> lib/maple_tree.c:5506:69: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct maple_enode const *entry @@     got void [noderef] __rcu * @@
   lib/maple_tree.c:5506:69: sparse:     expected struct maple_enode const *entry
   lib/maple_tree.c:5506:69: sparse:     got void [noderef] __rcu *
   lib/maple_tree.c:5507:38: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct maple_enode const *entry @@     got void [noderef] __rcu * @@
   lib/maple_tree.c:5507:38: sparse:     expected struct maple_enode const *entry
   lib/maple_tree.c:5507:38: sparse:     got void [noderef] __rcu *
>> lib/maple_tree.c:2322:17: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void **l_slots @@     got void [noderef] __rcu ** @@
   lib/maple_tree.c:2322:17: sparse:     expected void **l_slots
   lib/maple_tree.c:2322:17: sparse:     got void [noderef] __rcu **
>> lib/maple_tree.c:2325:17: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void **r_slots @@     got void [noderef] __rcu ** @@
   lib/maple_tree.c:2325:17: sparse:     expected void **r_slots
   lib/maple_tree.c:2325:17: sparse:     got void [noderef] __rcu **
>> lib/maple_tree.c:2329:57: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __rcu **slots @@     got void **l_slots @@
   lib/maple_tree.c:2329:57: sparse:     expected void [noderef] __rcu **slots
   lib/maple_tree.c:2329:57: sparse:     got void **l_slots
>> lib/maple_tree.c:2333:57: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __rcu **slots @@     got void **r_slots @@
   lib/maple_tree.c:2333:57: sparse:     expected void [noderef] __rcu **slots
   lib/maple_tree.c:2333:57: sparse:     got void **r_slots
   lib/maple_tree.c:2351:57: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __rcu **slots @@     got void **l_slots @@
   lib/maple_tree.c:2351:57: sparse:     expected void [noderef] __rcu **slots
   lib/maple_tree.c:2351:57: sparse:     got void **l_slots
   lib/maple_tree.c:2358:57: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __rcu **slots @@     got void **r_slots @@
   lib/maple_tree.c:2358:57: sparse:     expected void [noderef] __rcu **slots
   lib/maple_tree.c:2358:57: sparse:     got void **r_slots
>> lib/maple_tree.c:2322:17: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void **l_slots @@     got void [noderef] __rcu ** @@
   lib/maple_tree.c:2322:17: sparse:     expected void **l_slots
   lib/maple_tree.c:2322:17: sparse:     got void [noderef] __rcu **
>> lib/maple_tree.c:2325:17: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void **r_slots @@     got void [noderef] __rcu ** @@
   lib/maple_tree.c:2325:17: sparse:     expected void **r_slots
   lib/maple_tree.c:2325:17: sparse:     got void [noderef] __rcu **
>> lib/maple_tree.c:2329:57: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __rcu **slots @@     got void **l_slots @@
   lib/maple_tree.c:2329:57: sparse:     expected void [noderef] __rcu **slots
   lib/maple_tree.c:2329:57: sparse:     got void **l_slots
>> lib/maple_tree.c:2333:57: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __rcu **slots @@     got void **r_slots @@
   lib/maple_tree.c:2333:57: sparse:     expected void [noderef] __rcu **slots
   lib/maple_tree.c:2333:57: sparse:     got void **r_slots
   lib/maple_tree.c:2351:57: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __rcu **slots @@     got void **l_slots @@
   lib/maple_tree.c:2351:57: sparse:     expected void [noderef] __rcu **slots
   lib/maple_tree.c:2351:57: sparse:     got void **l_slots
   lib/maple_tree.c:2358:57: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __rcu **slots @@     got void **r_slots @@
   lib/maple_tree.c:2358:57: sparse:     expected void [noderef] __rcu **slots
   lib/maple_tree.c:2358:57: sparse:     got void **r_slots
   lib/maple_tree.c:5444:9: sparse: sparse: context imbalance in 'mt_free_walk' - different lock contexts for basic block

vim +5506 lib/maple_tree.c

  5472	
  5473	static void mt_destroy_walk(struct maple_enode *enode, unsigned char ma_flags,
  5474				    bool free)
  5475	{
  5476		void __rcu **slots;
  5477		struct maple_node *node = mte_to_node(enode);
  5478		struct maple_enode *start;
  5479		struct maple_tree mt;
  5480	
  5481		MA_STATE(mas, &mt, 0, 0);
  5482	
  5483		if (mte_is_leaf(enode))
  5484			goto free_leaf;
  5485	
  5486		mt_init_flags(&mt, ma_flags);
  5487		mas_lock(&mas);
  5488	
  5489		mas.node = start = enode;
  5490		slots = mas_destroy_descend(&mas, start, 0);
  5491		node = mas_mn(&mas);
  5492		do {
  5493			enum maple_type type;
  5494			unsigned char offset;
  5495	
  5496			node->slot_len = mas_dead_leaves(&mas, slots);
  5497			if (free)
  5498				mt_free_bulk(node->slot_len, slots);
  5499			offset = node->parent_slot + 1;
  5500			mas.node = node->piv_parent;
  5501			if (mas_mn(&mas) == node)
  5502				goto start_slots_free;
  5503	
  5504			type = mte_node_type(mas.node);
  5505			slots = ma_slots(mte_to_node(mas.node), type);
> 5506			if ((offset < mt_slots[type]) && mte_node_type(slots[offset]) &&
  5507			    mte_to_node(slots[offset])) {
  5508				struct maple_enode *parent = mas.node;
  5509	
  5510				mas.node = mas_slot_locked(&mas, slots, offset);
  5511				slots = mas_destroy_descend(&mas, parent, offset);
  5512			}
  5513			node = mas_mn(&mas);
  5514		} while (start != mas.node);
  5515	
  5516		node = mas_mn(&mas);
  5517		node->slot_len = mas_dead_leaves(&mas, slots);
  5518		if (free)
  5519			mt_free_bulk(node->slot_len, slots);
  5520	
  5521	start_slots_free:
  5522		mas_unlock(&mas);
  5523	
  5524	free_leaf:
  5525		if (free)
  5526			mt_free_rcu(&node->rcu);
  5527	}
  5528	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
