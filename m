Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17DBA574D67
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 14:24:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239147AbiGNMYh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 08:24:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239236AbiGNMYb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 08:24:31 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8AF443E48
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 05:24:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657801457; x=1689337457;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=sAe1wCd/UYxw7PT5ONqv5nf508hnCMq35g3ketoUO+k=;
  b=OqGo1qykOCscbFQcn3/ahFqQnDMYkQwzSJF+1OczGDggkFSk5QVpSKYY
   zlFKM89z6NBVFMUvJcUK3Ya8ybRzoMjwI2J+O8hm7DVB+Id9nNFWY1B3k
   kFEsBnEv7JwkPi+BmHE+r6wZpu3li/iOFF0AgcFOVbEHzKE/dTjG1SYx8
   ZvAN5IuT/LpbqJ6shAXxQquIIPi6oANzEKdxLtp4ACnZM+QD/MbrdigqN
   uLjdlq5Ne+D1MC/9X2xUo5U+Un3lcsh0azJgCNaJ9jkGwCPJFZY1MrgeR
   XHZn/zcDzpBppY0g5kA+xUe+pE9rxxOrAO3Psmx7jJzui50m0tvg5c2fq
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10407"; a="285519540"
X-IronPort-AV: E=Sophos;i="5.92,271,1650956400"; 
   d="scan'208";a="285519540"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2022 05:24:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,271,1650956400"; 
   d="scan'208";a="722705013"
Received: from lkp-server01.sh.intel.com (HELO fd2c14d642b4) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 14 Jul 2022 05:24:15 -0700
Received: from kbuild by fd2c14d642b4 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1oBxt8-0000bG-SE;
        Thu, 14 Jul 2022 12:24:14 +0000
Date:   Thu, 14 Jul 2022 20:23:57 +0800
From:   kernel test robot <lkp@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [tglx-devel:depthtracking 23/38] arch/x86/kernel/callthunks.c:368:7:
 warning: variable 'ret' is used uninitialized whenever 'if' condition is
 true
Message-ID: <202207142034.ALIoUjYZ-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git depthtracking
head:   81d2c1b17a61bfeca4b92a5d6e1fb6f5ff464826
commit: 02b09aaafc9a439ca50cc049e98f7cc945e5b294 [23/38] x86/callthunks: Add call patching for call depth tracking
config: x86_64-randconfig-a014 (https://download.01.org/0day-ci/archive/20220714/202207142034.ALIoUjYZ-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 5e61b9c556267086ef9b743a0b57df302eef831b)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git/commit/?id=02b09aaafc9a439ca50cc049e98f7cc945e5b294
        git remote add tglx-devel https://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git
        git fetch --no-tags tglx-devel depthtracking
        git checkout 02b09aaafc9a439ca50cc049e98f7cc945e5b294
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash arch/x86/kernel/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> arch/x86/kernel/callthunks.c:368:7: warning: variable 'ret' is used uninitialized whenever 'if' condition is true [-Wsometimes-uninitialized]
                   if (!vbuf)
                       ^~~~~
   arch/x86/kernel/callthunks.c:428:9: note: uninitialized use occurs here
           return ret;
                  ^~~
   arch/x86/kernel/callthunks.c:368:3: note: remove the 'if' if its condition is always false
                   if (!vbuf)
                   ^~~~~~~~~~
   arch/x86/kernel/callthunks.c:332:9: note: initialize the variable 'ret' to silence this warning
           int ret, text_size, size;
                  ^
                   = 0
   1 warning generated.


vim +368 arch/x86/kernel/callthunks.c

   324	
   325	static __init_or_module int callthunks_setup(struct callthunk_sites *cs,
   326						     struct module_layout *layout)
   327	{
   328		u8 *tp, *thunk, *buffer, *vbuf = NULL;
   329		struct paravirt_patch_site *pv;
   330		unsigned int nthunks, bitpos;
   331		struct thunk_mem_area *area;
   332		int ret, text_size, size;
   333		s32 *s;
   334	
   335		lockdep_assert_held(&text_mutex);
   336	
   337		prdbg("Setup %s\n", layout_getname(layout));
   338		/* Calculate the number of thunks required */
   339		nthunks = cs->syms_end - cs->syms_start;
   340		nthunks += cs->pv_end - cs->pv_start;
   341	
   342		/*
   343		 * thunk_size can be 0 when there are no intra module calls,
   344		 * but there might be still sites to patch.
   345		 */
   346		if (!nthunks)
   347			goto patch;
   348	
   349		area = callthunks_alloc(nthunks);
   350		if (!area)
   351			return -ENOMEM;
   352	
   353		bitpos = area->start;
   354		thunk = area->tmem->base + bitpos * callthunk_desc.thunk_size;
   355		tp = thunk;
   356	
   357		prdbg("Thunk %px\n", tp);
   358		/*
   359		 * If the memory area is already RX, use a temporary
   360		 * buffer. Otherwise just copy into the unused area
   361		 */
   362		if (!area->tmem->is_rx) {
   363			prdbg("Using thunk direct\n");
   364			buffer = thunk;
   365		} else {
   366			size = nthunks * callthunk_desc.thunk_size;
   367			vbuf = vmalloc(size);
 > 368			if (!vbuf)
   369				goto fail;
   370			memset(vbuf, INT3_INSN_OPCODE, size);
   371			buffer = vbuf;
   372			prdbg("Using thunk vbuf %px\n", vbuf);
   373		}
   374	
   375		for (s = cs->syms_start; s < cs->syms_end; s++, bitpos++) {
   376			void *dest = (void *)s + *s;
   377	
   378			ret = callthunk_setup_one(dest, tp, buffer, layout);
   379			if (ret)
   380				goto fail;
   381			buffer += callthunk_desc.thunk_size;
   382			tp += callthunk_desc.thunk_size;
   383			bitmap_set(area->tmem->map, bitpos, 1);
   384			area->nthunks++;
   385		}
   386	
   387		for (pv = cs->pv_start; pv < cs->pv_end; pv++, bitpos++) {
   388			ret = callthunk_setup_one(pv->instr, tp, buffer, layout);
   389			if (ret)
   390				goto fail;
   391			buffer += callthunk_desc.thunk_size;
   392			tp += callthunk_desc.thunk_size;
   393			bitmap_set(area->tmem->map, bitpos, 1);
   394			area->nthunks++;
   395		}
   396	
   397		text_size = tp - thunk;
   398		prdbg("Thunk %px .. %px 0x%x\n", thunk, tp, text_size);
   399	
   400		/*
   401		 * If thunk memory is already RX, poke the buffer into it.
   402		 * Otherwise make the memory RX.
   403		 */
   404		if (vbuf)
   405			text_poke_copy_locked(thunk, vbuf, text_size);
   406		else
   407			callthunk_area_set_rx(area);
   408		sync_core();
   409	
   410		layout->base = thunk;
   411		layout->size = text_size;
   412		layout->text_size = text_size;
   413		layout->arch_data = area;
   414	
   415		vfree(vbuf);
   416	
   417	patch:
   418		prdbg("Patching call sites %s\n", layout_getname(layout));
   419		patch_call_sites(cs->call_start, cs->call_end, layout);
   420		patch_paravirt_call_sites(cs->pv_start, cs->pv_end, layout);
   421		prdbg("Patching call sites done%s\n", layout_getname(layout));
   422		return 0;
   423	
   424	fail:
   425		WARN_ON_ONCE(ret);
   426		callthunk_free(area, false);
   427		vfree(vbuf);
   428		return ret;
   429	}
   430	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
