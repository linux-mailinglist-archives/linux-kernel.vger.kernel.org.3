Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BF60574D65
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 14:24:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239234AbiGNMYg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 08:24:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233255AbiGNMYa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 08:24:30 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BDD63FA15
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 05:24:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657801457; x=1689337457;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=HF32wfK8Jt0IfXyqG4u1CW61zAjej9oI11Uu8e7MLvI=;
  b=niqTQIx6jl508xj+31oYc15UiIoTFErvt2fv+OK5uzqOE0GJlI/m5oX7
   sHSYHiG26M48vrrZGHa/qsPJxNhiZsEE+AtxYnWg400oxGeI1nMobmQpz
   i+9uvmqW6L6rJ58Wh+/DjGd/JQOW4yBlHfmGnzH20tFwcsnlJFBxrJIOK
   T3qcTtGoYLhm4dQ+YVx0YBY7GbfX/3A2KFcYcKRMzYXx2fzh1AsrO6PFY
   vxlzbslVTuuP2NKFNJ1I4fWktJn229krarqLhvRsXbGIdTYvCnry6SsZv
   bFxNkeBMQFG4cgSSRd98svnSdMajUuuue/QBF6vEoFsckf9D084w+oYZ0
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10407"; a="311148469"
X-IronPort-AV: E=Sophos;i="5.92,271,1650956400"; 
   d="scan'208";a="311148469"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2022 05:24:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,271,1650956400"; 
   d="scan'208";a="663767847"
Received: from lkp-server01.sh.intel.com (HELO fd2c14d642b4) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 14 Jul 2022 05:24:15 -0700
Received: from kbuild by fd2c14d642b4 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1oBxt8-0000bB-Qa;
        Thu, 14 Jul 2022 12:24:14 +0000
Date:   Thu, 14 Jul 2022 20:23:59 +0800
From:   kernel test robot <lkp@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
Subject: [tglx-devel:depthtracking 35/38] arch/x86/kernel/callthunks.c:411:7:
 warning: variable 'ret' is used uninitialized whenever 'if' condition is
 true
Message-ID: <202207142029.dpdKYPLD-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git depthtracking
head:   81d2c1b17a61bfeca4b92a5d6e1fb6f5ff464826
commit: 57b6f2ca7edda679f0a9fe58087ecc9dd9f8dafb [35/38] kprobes: Add callthunk blacklisting
config: x86_64-randconfig-a005 (https://download.01.org/0day-ci/archive/20220714/202207142029.dpdKYPLD-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 5e61b9c556267086ef9b743a0b57df302eef831b)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git/commit/?id=57b6f2ca7edda679f0a9fe58087ecc9dd9f8dafb
        git remote add tglx-devel https://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git
        git fetch --no-tags tglx-devel depthtracking
        git checkout 57b6f2ca7edda679f0a9fe58087ecc9dd9f8dafb
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash arch/x86/kernel/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> arch/x86/kernel/callthunks.c:411:7: warning: variable 'ret' is used uninitialized whenever 'if' condition is true [-Wsometimes-uninitialized]
                   if (!vbuf)
                       ^~~~~
   arch/x86/kernel/callthunks.c:475:9: note: uninitialized use occurs here
           return ret;
                  ^~~
   arch/x86/kernel/callthunks.c:411:3: note: remove the 'if' if its condition is always false
                   if (!vbuf)
                   ^~~~~~~~~~
   arch/x86/kernel/callthunks.c:375:9: note: initialize the variable 'ret' to silence this warning
           int ret, text_size, size;
                  ^
                   = 0
   1 warning generated.


vim +411 arch/x86/kernel/callthunks.c

25cd68b763b44e Thomas Gleixner 2022-06-18  367  
02b09aaafc9a43 Thomas Gleixner 2022-06-18  368  static __init_or_module int callthunks_setup(struct callthunk_sites *cs,
02b09aaafc9a43 Thomas Gleixner 2022-06-18  369  					     struct module_layout *layout)
02b09aaafc9a43 Thomas Gleixner 2022-06-18  370  {
02b09aaafc9a43 Thomas Gleixner 2022-06-18  371  	u8 *tp, *thunk, *buffer, *vbuf = NULL;
02b09aaafc9a43 Thomas Gleixner 2022-06-18  372  	struct paravirt_patch_site *pv;
02b09aaafc9a43 Thomas Gleixner 2022-06-18  373  	unsigned int nthunks, bitpos;
02b09aaafc9a43 Thomas Gleixner 2022-06-18  374  	struct thunk_mem_area *area;
02b09aaafc9a43 Thomas Gleixner 2022-06-18  375  	int ret, text_size, size;
02b09aaafc9a43 Thomas Gleixner 2022-06-18  376  	s32 *s;
02b09aaafc9a43 Thomas Gleixner 2022-06-18  377  
02b09aaafc9a43 Thomas Gleixner 2022-06-18  378  	lockdep_assert_held(&text_mutex);
02b09aaafc9a43 Thomas Gleixner 2022-06-18  379  
02b09aaafc9a43 Thomas Gleixner 2022-06-18  380  	prdbg("Setup %s\n", layout_getname(layout));
02b09aaafc9a43 Thomas Gleixner 2022-06-18  381  	/* Calculate the number of thunks required */
02b09aaafc9a43 Thomas Gleixner 2022-06-18  382  	nthunks = cs->syms_end - cs->syms_start;
02b09aaafc9a43 Thomas Gleixner 2022-06-18  383  	nthunks += cs->pv_end - cs->pv_start;
02b09aaafc9a43 Thomas Gleixner 2022-06-18  384  
02b09aaafc9a43 Thomas Gleixner 2022-06-18  385  	/*
02b09aaafc9a43 Thomas Gleixner 2022-06-18  386  	 * thunk_size can be 0 when there are no intra module calls,
02b09aaafc9a43 Thomas Gleixner 2022-06-18  387  	 * but there might be still sites to patch.
02b09aaafc9a43 Thomas Gleixner 2022-06-18  388  	 */
02b09aaafc9a43 Thomas Gleixner 2022-06-18  389  	if (!nthunks)
02b09aaafc9a43 Thomas Gleixner 2022-06-18  390  		goto patch;
02b09aaafc9a43 Thomas Gleixner 2022-06-18  391  
02b09aaafc9a43 Thomas Gleixner 2022-06-18  392  	area = callthunks_alloc(nthunks);
02b09aaafc9a43 Thomas Gleixner 2022-06-18  393  	if (!area)
02b09aaafc9a43 Thomas Gleixner 2022-06-18  394  		return -ENOMEM;
02b09aaafc9a43 Thomas Gleixner 2022-06-18  395  
02b09aaafc9a43 Thomas Gleixner 2022-06-18  396  	bitpos = area->start;
02b09aaafc9a43 Thomas Gleixner 2022-06-18  397  	thunk = area->tmem->base + bitpos * callthunk_desc.thunk_size;
02b09aaafc9a43 Thomas Gleixner 2022-06-18  398  	tp = thunk;
02b09aaafc9a43 Thomas Gleixner 2022-06-18  399  
02b09aaafc9a43 Thomas Gleixner 2022-06-18  400  	prdbg("Thunk %px\n", tp);
02b09aaafc9a43 Thomas Gleixner 2022-06-18  401  	/*
02b09aaafc9a43 Thomas Gleixner 2022-06-18  402  	 * If the memory area is already RX, use a temporary
02b09aaafc9a43 Thomas Gleixner 2022-06-18  403  	 * buffer. Otherwise just copy into the unused area
02b09aaafc9a43 Thomas Gleixner 2022-06-18  404  	 */
02b09aaafc9a43 Thomas Gleixner 2022-06-18  405  	if (!area->tmem->is_rx) {
02b09aaafc9a43 Thomas Gleixner 2022-06-18  406  		prdbg("Using thunk direct\n");
02b09aaafc9a43 Thomas Gleixner 2022-06-18  407  		buffer = thunk;
02b09aaafc9a43 Thomas Gleixner 2022-06-18  408  	} else {
02b09aaafc9a43 Thomas Gleixner 2022-06-18  409  		size = nthunks * callthunk_desc.thunk_size;
02b09aaafc9a43 Thomas Gleixner 2022-06-18  410  		vbuf = vmalloc(size);
02b09aaafc9a43 Thomas Gleixner 2022-06-18 @411  		if (!vbuf)
02b09aaafc9a43 Thomas Gleixner 2022-06-18  412  			goto fail;
02b09aaafc9a43 Thomas Gleixner 2022-06-18  413  		memset(vbuf, INT3_INSN_OPCODE, size);
02b09aaafc9a43 Thomas Gleixner 2022-06-18  414  		buffer = vbuf;
02b09aaafc9a43 Thomas Gleixner 2022-06-18  415  		prdbg("Using thunk vbuf %px\n", vbuf);
02b09aaafc9a43 Thomas Gleixner 2022-06-18  416  	}
02b09aaafc9a43 Thomas Gleixner 2022-06-18  417  
02b09aaafc9a43 Thomas Gleixner 2022-06-18  418  	for (s = cs->syms_start; s < cs->syms_end; s++, bitpos++) {
02b09aaafc9a43 Thomas Gleixner 2022-06-18  419  		void *dest = (void *)s + *s;
02b09aaafc9a43 Thomas Gleixner 2022-06-18  420  
02b09aaafc9a43 Thomas Gleixner 2022-06-18  421  		ret = callthunk_setup_one(dest, tp, buffer, layout);
02b09aaafc9a43 Thomas Gleixner 2022-06-18  422  		if (ret)
02b09aaafc9a43 Thomas Gleixner 2022-06-18  423  			goto fail;
02b09aaafc9a43 Thomas Gleixner 2022-06-18  424  		buffer += callthunk_desc.thunk_size;
02b09aaafc9a43 Thomas Gleixner 2022-06-18  425  		tp += callthunk_desc.thunk_size;
02b09aaafc9a43 Thomas Gleixner 2022-06-18  426  		bitmap_set(area->tmem->map, bitpos, 1);
02b09aaafc9a43 Thomas Gleixner 2022-06-18  427  		area->nthunks++;
02b09aaafc9a43 Thomas Gleixner 2022-06-18  428  	}
02b09aaafc9a43 Thomas Gleixner 2022-06-18  429  
02b09aaafc9a43 Thomas Gleixner 2022-06-18  430  	for (pv = cs->pv_start; pv < cs->pv_end; pv++, bitpos++) {
02b09aaafc9a43 Thomas Gleixner 2022-06-18  431  		ret = callthunk_setup_one(pv->instr, tp, buffer, layout);
02b09aaafc9a43 Thomas Gleixner 2022-06-18  432  		if (ret)
02b09aaafc9a43 Thomas Gleixner 2022-06-18  433  			goto fail;
02b09aaafc9a43 Thomas Gleixner 2022-06-18  434  		buffer += callthunk_desc.thunk_size;
02b09aaafc9a43 Thomas Gleixner 2022-06-18  435  		tp += callthunk_desc.thunk_size;
02b09aaafc9a43 Thomas Gleixner 2022-06-18  436  		bitmap_set(area->tmem->map, bitpos, 1);
02b09aaafc9a43 Thomas Gleixner 2022-06-18  437  		area->nthunks++;
02b09aaafc9a43 Thomas Gleixner 2022-06-18  438  	}
02b09aaafc9a43 Thomas Gleixner 2022-06-18  439  
02b09aaafc9a43 Thomas Gleixner 2022-06-18  440  	text_size = tp - thunk;
02b09aaafc9a43 Thomas Gleixner 2022-06-18  441  	prdbg("Thunk %px .. %px 0x%x\n", thunk, tp, text_size);
02b09aaafc9a43 Thomas Gleixner 2022-06-18  442  
02b09aaafc9a43 Thomas Gleixner 2022-06-18  443  	/*
02b09aaafc9a43 Thomas Gleixner 2022-06-18  444  	 * If thunk memory is already RX, poke the buffer into it.
02b09aaafc9a43 Thomas Gleixner 2022-06-18  445  	 * Otherwise make the memory RX.
02b09aaafc9a43 Thomas Gleixner 2022-06-18  446  	 */
02b09aaafc9a43 Thomas Gleixner 2022-06-18  447  	if (vbuf)
02b09aaafc9a43 Thomas Gleixner 2022-06-18  448  		text_poke_copy_locked(thunk, vbuf, text_size);
02b09aaafc9a43 Thomas Gleixner 2022-06-18  449  	else
02b09aaafc9a43 Thomas Gleixner 2022-06-18  450  		callthunk_area_set_rx(area);
02b09aaafc9a43 Thomas Gleixner 2022-06-18  451  	sync_core();
02b09aaafc9a43 Thomas Gleixner 2022-06-18  452  
25cd68b763b44e Thomas Gleixner 2022-06-18  453  	ret = callthunk_set_modname(layout);
25cd68b763b44e Thomas Gleixner 2022-06-18  454  	if (ret)
25cd68b763b44e Thomas Gleixner 2022-06-18  455  		goto fail;
25cd68b763b44e Thomas Gleixner 2022-06-18  456  
02b09aaafc9a43 Thomas Gleixner 2022-06-18  457  	layout->base = thunk;
02b09aaafc9a43 Thomas Gleixner 2022-06-18  458  	layout->size = text_size;
02b09aaafc9a43 Thomas Gleixner 2022-06-18  459  	layout->text_size = text_size;
02b09aaafc9a43 Thomas Gleixner 2022-06-18  460  	layout->arch_data = area;
02b09aaafc9a43 Thomas Gleixner 2022-06-18  461  
02b09aaafc9a43 Thomas Gleixner 2022-06-18  462  	vfree(vbuf);
02b09aaafc9a43 Thomas Gleixner 2022-06-18  463  
02b09aaafc9a43 Thomas Gleixner 2022-06-18  464  patch:
02b09aaafc9a43 Thomas Gleixner 2022-06-18  465  	prdbg("Patching call sites %s\n", layout_getname(layout));
02b09aaafc9a43 Thomas Gleixner 2022-06-18  466  	patch_call_sites(cs->call_start, cs->call_end, layout);
02b09aaafc9a43 Thomas Gleixner 2022-06-18  467  	patch_paravirt_call_sites(cs->pv_start, cs->pv_end, layout);
02b09aaafc9a43 Thomas Gleixner 2022-06-18  468  	prdbg("Patching call sites done%s\n", layout_getname(layout));
02b09aaafc9a43 Thomas Gleixner 2022-06-18  469  	return 0;
02b09aaafc9a43 Thomas Gleixner 2022-06-18  470  
02b09aaafc9a43 Thomas Gleixner 2022-06-18  471  fail:
02b09aaafc9a43 Thomas Gleixner 2022-06-18  472  	WARN_ON_ONCE(ret);
02b09aaafc9a43 Thomas Gleixner 2022-06-18  473  	callthunk_free(area, false);
02b09aaafc9a43 Thomas Gleixner 2022-06-18  474  	vfree(vbuf);
02b09aaafc9a43 Thomas Gleixner 2022-06-18  475  	return ret;
02b09aaafc9a43 Thomas Gleixner 2022-06-18  476  }
02b09aaafc9a43 Thomas Gleixner 2022-06-18  477  

:::::: The code at line 411 was first introduced by commit
:::::: 02b09aaafc9a439ca50cc049e98f7cc945e5b294 x86/callthunks: Add call patching for call depth tracking

:::::: TO: Thomas Gleixner <tglx@linutronix.de>
:::::: CC: Thomas Gleixner <tglx@linutronix.de>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
