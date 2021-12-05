Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D471468924
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Dec 2021 05:27:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231543AbhLEEas (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Dec 2021 23:30:48 -0500
Received: from mga11.intel.com ([192.55.52.93]:23795 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231518AbhLEEas (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Dec 2021 23:30:48 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10188"; a="234673924"
X-IronPort-AV: E=Sophos;i="5.87,288,1631602800"; 
   d="scan'208";a="234673924"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2021 20:27:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,288,1631602800"; 
   d="scan'208";a="578903534"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 04 Dec 2021 20:27:19 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mtj7O-000JnV-V3; Sun, 05 Dec 2021 04:27:18 +0000
Date:   Sun, 5 Dec 2021 12:26:26 +0800
From:   kernel test robot <lkp@intel.com>
To:     zhangyue <zhangyue1@kylinos.cn>, naveen.n.rao@linux.ibm.com,
        anil.s.keshavamurthy@intel.com, davem@davemloft.net,
        mhiramat@kernel.org
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kprobes: fix out-of-bounds in register_kretprobe
Message-ID: <202112051255.NQeIOpp8-lkp@intel.com>
References: <20211201054855.5449-1-zhangyue1@kylinos.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211201054855.5449-1-zhangyue1@kylinos.cn>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi zhangyue,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on rostedt-trace/for-next]
[also build test WARNING on v5.16-rc3 next-20211203]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/zhangyue/kprobes-fix-out-of-bounds-in-register_kretprobe/20211201-135046
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git for-next
config: i386-randconfig-m021-20211203 (https://download.01.org/0day-ci/archive/20211205/202112051255.NQeIOpp8-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

smatch warnings:
kernel/kprobes.c:2107 register_kretprobe() warn: always true condition '(rp->data_size >= 0) => (0-u32max >= 0)'

vim +2107 kernel/kprobes.c

  2062	
  2063	int register_kretprobe(struct kretprobe *rp)
  2064	{
  2065		int ret;
  2066		struct kretprobe_instance *inst = NULL;
  2067		int i;
  2068		void *addr;
  2069	
  2070		ret = kprobe_on_func_entry(rp->kp.addr, rp->kp.symbol_name, rp->kp.offset);
  2071		if (ret)
  2072			return ret;
  2073	
  2074		/* If only 'rp->kp.addr' is specified, check reregistering kprobes */
  2075		if (rp->kp.addr && warn_kprobe_rereg(&rp->kp))
  2076			return -EINVAL;
  2077	
  2078		if (kretprobe_blacklist_size) {
  2079			addr = kprobe_addr(&rp->kp);
  2080			if (IS_ERR(addr))
  2081				return PTR_ERR(addr);
  2082	
  2083			for (i = 0; kretprobe_blacklist[i].name != NULL; i++) {
  2084				if (kretprobe_blacklist[i].addr == addr)
  2085					return -EINVAL;
  2086			}
  2087		}
  2088	
  2089		rp->kp.pre_handler = pre_handler_kretprobe;
  2090		rp->kp.post_handler = NULL;
  2091	
  2092		/* Pre-allocate memory for max kretprobe instances */
  2093		if (rp->maxactive <= 0) {
  2094	#ifdef CONFIG_PREEMPTION
  2095			rp->maxactive = max_t(unsigned int, 10, 2*num_possible_cpus());
  2096	#else
  2097			rp->maxactive = num_possible_cpus();
  2098	#endif
  2099		}
  2100		rp->freelist.head = NULL;
  2101		rp->rph = kzalloc(sizeof(struct kretprobe_holder), GFP_KERNEL);
  2102		if (!rp->rph)
  2103			return -ENOMEM;
  2104	
  2105		rp->rph->rp = rp;
  2106		for (i = 0; i < rp->maxactive; i++) {
> 2107			if (rp->data_size >= 0)
  2108				inst = kzalloc(sizeof(struct kretprobe_instance) +
  2109				       rp->data_size, GFP_KERNEL);
  2110			if (inst == NULL) {
  2111				refcount_set(&rp->rph->ref, i);
  2112				free_rp_inst(rp);
  2113				return -ENOMEM;
  2114			}
  2115			inst->rph = rp->rph;
  2116			freelist_add(&inst->freelist, &rp->freelist);
  2117		}
  2118		refcount_set(&rp->rph->ref, i);
  2119	
  2120		rp->nmissed = 0;
  2121		/* Establish function entry probe point */
  2122		ret = register_kprobe(&rp->kp);
  2123		if (ret != 0)
  2124			free_rp_inst(rp);
  2125		return ret;
  2126	}
  2127	EXPORT_SYMBOL_GPL(register_kretprobe);
  2128	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
