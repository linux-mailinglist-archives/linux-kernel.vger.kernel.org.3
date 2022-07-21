Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0890E57C3A9
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 07:07:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229749AbiGUFGk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 01:06:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiGUFGi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 01:06:38 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9E72774A8
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 22:06:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658379997; x=1689915997;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=YNolKkyK+U7u0xDQApTS59Z6cXU/e6kPR9y7JDD9VfI=;
  b=ELbxSZBQCpc2pouszWmyL6dNAYcBCd69/4PZsvXd++VqTXktjS++q9Cl
   sSSBAoQkhRVHtZ3EU/oG1zcBJEwDRZSa8ek7zuH8zQiq9J9Wpf18leJxB
   uP7EYgnO26okFG/cSe89FZn0A8bGeWb0QSXTJLpzfTuiPJ04gbBbdZ+dR
   RiIZL681EUA5myFI7JcB/QWRheiY/Xyjw2OnAiwZdZKA9e1seQSKl0EhS
   it2Llcj7pFyXlZdDTrIvHGVASpj5BcXH4OqZ1wGRwpWcsgRfzlVr0blyx
   yb7fcz9fss5W26ItE+2ihpDsiMCbax3mGgfkkTNABZa2myxogJgowbK1L
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10414"; a="269981699"
X-IronPort-AV: E=Sophos;i="5.92,288,1650956400"; 
   d="scan'208";a="269981699"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2022 22:06:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,288,1650956400"; 
   d="scan'208";a="595478665"
Received: from lkp-server01.sh.intel.com (HELO 7dfbdc7c7900) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 20 Jul 2022 22:06:35 -0700
Received: from kbuild by 7dfbdc7c7900 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1oEOOR-0001UH-8H;
        Thu, 21 Jul 2022 05:06:35 +0000
Date:   Thu, 21 Jul 2022 13:06:33 +0800
From:   kernel test robot <lkp@intel.com>
To:     Yu-Jen Chang <arthurchang09@gmail.com>, andy@kernel.org,
        akinobu.mita@gmail.com
Cc:     kbuild-all@lists.01.org, jserv@ccns.ncku.edu.tw,
        linux-kernel@vger.kernel.org,
        Yu-Jen Chang <arthurchang09@gmail.com>
Subject: Re: [PATCH 2/2] lib/string.c: Optimize memchr()
Message-ID: <202207211216.wsqhuMcj-lkp@intel.com>
References: <20220710142822.52539-3-arthurchang09@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220710142822.52539-3-arthurchang09@gmail.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yu-Jen,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on linus/master]
[also build test ERROR on v5.19-rc7 next-20220720]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Yu-Jen-Chang/Optimize-memchr/20220710-223118
base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git b1c428b6c3684ee8ddf4137d68b3e8d51d2a700f
config: arc-buildonly-randconfig-r005-20220719 (https://download.01.org/0day-ci/archive/20220721/202207211216.wsqhuMcj-lkp@intel.com/config)
compiler: arceb-elf-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/307ee542c2bd8378b2225910f3f9b982df7a7669
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Yu-Jen-Chang/Optimize-memchr/20220710-223118
        git checkout 307ee542c2bd8378b2225910f3f9b982df7a7669
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arc SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> lib/string.c:902:7: error: conflicting types for 'memchr'; have 'void *(const void *, int,  long unsigned int)'
     902 | void *memchr(const void *p, int c, unsigned long length)
         |       ^~~~~~
   In file included from lib/string.c:19:
   include/linux/string.h:162:15: note: previous declaration of 'memchr' with type 'void *(const void *, int,  __kernel_size_t)' {aka 'void *(const void *, int,  unsigned int)'}
     162 | extern void * memchr(const void *,int,__kernel_size_t);
         |               ^~~~~~


vim +902 lib/string.c

   891	
   892	#ifndef __HAVE_ARCH_MEMCHR
   893	/**
   894	 * memchr - Find a character in an area of memory.
   895	 * @p: The memory area
   896	 * @c: The byte to search for
   897	 * @length: The size of the area.
   898	 *
   899	 * returns the address of the first occurrence of @c, or %NULL
   900	 * if @c is not found
   901	 */
 > 902	void *memchr(const void *p, int c, unsigned long length)
   903	{
   904		u64 mask, val;
   905		const void *end = p + length;
   906	
   907		c &= 0xff;
   908		if (p <= end - 8) {
   909			mask = c;
   910			MEMCHR_MASK_GEN(mask);
   911	
   912			for (; p <= end - 8; p += 8) {
   913				val = *(u64 *)p ^ mask;
   914				if ((val + 0xfefefefefefefeffu) &
   915				    (~val & 0x8080808080808080u))
   916					break;
   917			}
   918		}
   919	
   920		for (; p < end; p++)
   921			if (*(unsigned char *)p == c)
   922				return (void *)p;
   923	
   924		return NULL;
   925	}
   926	EXPORT_SYMBOL(memchr);
   927	#endif
   928	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
