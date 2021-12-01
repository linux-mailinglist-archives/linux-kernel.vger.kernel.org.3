Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D08524644EF
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 03:36:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346152AbhLACjX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 21:39:23 -0500
Received: from mga18.intel.com ([134.134.136.126]:33512 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241235AbhLACjV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 21:39:21 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10184"; a="223248659"
X-IronPort-AV: E=Sophos;i="5.87,277,1631602800"; 
   d="scan'208";a="223248659"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2021 18:36:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,277,1631602800"; 
   d="scan'208";a="609369643"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 30 Nov 2021 18:35:59 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1msFTS-000E5E-W3; Wed, 01 Dec 2021 02:35:58 +0000
Date:   Wed, 1 Dec 2021 10:35:32 +0800
From:   kernel test robot <lkp@intel.com>
To:     Helge Deller <deller@gmx.de>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [deller-parisc:for-next-maybe 1/1] mm/usercopy.c:135:3: error:
 expected ')'
Message-ID: <202112011052.dPaqoNLr-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git for-next-maybe
head:   4d7b3620412d727e09bf0eef942be42da363260d
commit: 4d7b3620412d727e09bf0eef942be42da363260d [1/1] usercopy: Do not fail if memory is from the init section
config: hexagon-randconfig-r045-20211128 (https://download.01.org/0day-ci/archive/20211201/202112011052.dPaqoNLr-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 25eb7fa01d7ebbe67648ea03841cda55b4239ab2)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git/commit/?id=4d7b3620412d727e09bf0eef942be42da363260d
        git remote add deller-parisc https://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git
        git fetch --no-tags deller-parisc for-next-maybe
        git checkout 4d7b3620412d727e09bf0eef942be42da363260d
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> mm/usercopy.c:135:3: error: expected ')'
                   return;
                   ^
   mm/usercopy.c:134:5: note: to match this '('
           if (inside_init_area(ptr, n, __init_begin, __init_end)
              ^
   mm/usercopy.c:137:3: error: expected ')'
                   return;
                   ^
   mm/usercopy.c:136:5: note: to match this '('
           if (inside_init_area(ptr, n, _sinittext, _einittext)
              ^
   2 errors generated.


vim +135 mm/usercopy.c

   124	
   125	/* Is this address range in the kernel text area? */
   126	static inline void check_kernel_text_object(const unsigned long ptr,
   127						    unsigned long n, bool to_user)
   128	{
   129		unsigned long textlow = (unsigned long)_stext;
   130		unsigned long texthigh = (unsigned long)_etext;
   131		unsigned long textlow_linear, texthigh_linear;
   132	
   133		/* Ok if inside the former init sections */
   134		if (inside_init_area(ptr, n, __init_begin, __init_end)
 > 135			return;
   136		if (inside_init_area(ptr, n, _sinittext, _einittext)
   137			return;
   138	
   139		if (overlaps(ptr, n, textlow, texthigh))
   140			usercopy_abort("kernel text", NULL, to_user, ptr - textlow, n);
   141	
   142		/*
   143		 * Some architectures have virtual memory mappings with a secondary
   144		 * mapping of the kernel text, i.e. there is more than one virtual
   145		 * kernel address that points to the kernel image. It is usually
   146		 * when there is a separate linear physical memory mapping, in that
   147		 * __pa() is not just the reverse of __va(). This can be detected
   148		 * and checked:
   149		 */
   150		textlow_linear = (unsigned long)lm_alias(textlow);
   151		/* No different mapping: we're done. */
   152		if (textlow_linear == textlow)
   153			return;
   154	
   155		/* Check the secondary mapping... */
   156		texthigh_linear = (unsigned long)lm_alias(texthigh);
   157		if (overlaps(ptr, n, textlow_linear, texthigh_linear))
   158			usercopy_abort("linear kernel text", NULL, to_user,
   159				       ptr - textlow_linear, n);
   160	}
   161	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
