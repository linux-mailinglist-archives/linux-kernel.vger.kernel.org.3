Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33B184ED0C2
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 02:15:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345174AbiCaARE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 20:17:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbiCaARB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 20:17:01 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3D1DE38
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 17:15:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648685714; x=1680221714;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6sTWKjK3HZDhhjYP5GjlhZRnGY31f0fAoCQWWzN3SAE=;
  b=gTrvsMIH8hFBGbkBBnhJbF6UuhzknJ7VxOTsAmiHRRCLVlo5/cdQIbrC
   GMANFT3xB1ylKW9uo0B+CnZMwZbW8wvX/XbQrEwyruDQV9YO+Sv8Z6xRI
   wdQFy2gnHKyQ9nN2xznsoDSJ2RBIaePBWlYf43vtthww0loaNUZlU2EY+
   W8YhOOL4XfnsyoH8ukqgqO8LDJuUlyuw182QfNb1h4Jy1ATqcPBx7zSQU
   Fu/J6TXyyjU1w0a6UsofXH4GutFfcMCdCgouvhsF++8+OPmq0V4WXX33C
   MRwsXinkbL5FR+c7pY2Qi6FHqgGQlK1T8kqGNeq/8zfCL1j4ZQCwYlqM7
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10302"; a="247176557"
X-IronPort-AV: E=Sophos;i="5.90,223,1643702400"; 
   d="scan'208";a="247176557"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2022 17:15:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,223,1643702400"; 
   d="scan'208";a="605734246"
Received: from lkp-server02.sh.intel.com (HELO 56431612eabd) ([10.239.97.151])
  by fmsmga008.fm.intel.com with ESMTP; 30 Mar 2022 17:15:11 -0700
Received: from kbuild by 56431612eabd with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nZiT1-0000gi-60;
        Thu, 31 Mar 2022 00:15:11 +0000
Date:   Thu, 31 Mar 2022 08:14:53 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jean-Marc Eurin <jmeurin@google.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jean-Marc Eurin <jmeurin@google.com>
Subject: Re: [PATCH v2 2/2] mtd: mtdoops: Create a header structure for the
 saved mtdoops.
Message-ID: <202203310819.kOiVSg8W-lkp@intel.com>
References: <20220330182816.1177341-4-jmeurin@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220330182816.1177341-4-jmeurin@google.com>
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

Hi Jean-Marc,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on mtd/mtd/next]
[also build test WARNING on mtd/mtd/fixes linux/master linus/master v5.17 next-20220330]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Jean-Marc-Eurin/mtd-mtdoops-Structure-the-header-of-the-dumped-oops/20220331-023808
base:   https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git mtd/next
config: x86_64-randconfig-a014 (https://download.01.org/0day-ci/archive/20220331/202203310819.kOiVSg8W-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 0f6d9501cf49ce02937099350d08f20c4af86f3d)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/0d39801219fd826554caf69402424346799810d5
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Jean-Marc-Eurin/mtd-mtdoops-Structure-the-header-of-the-dumped-oops/20220331-023808
        git checkout 0d39801219fd826554caf69402424346799810d5
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/mtd/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/mtd/mtdoops.c:244:39: warning: format specifies type 'int' but the argument has type 'unsigned long' [-Wformat]
                                  page * record_size, retlen, sizeof(hdr), ret);
                                                              ^~~~~~~~~~~
   include/linux/printk.h:446:60: note: expanded from macro 'printk'
   #define printk(fmt, ...) printk_index_wrap(_printk, fmt, ##__VA_ARGS__)
                                                       ~~~    ^~~~~~~~~~~
   include/linux/printk.h:418:19: note: expanded from macro 'printk_index_wrap'
                   _p_func(_fmt, ##__VA_ARGS__);                           \
                           ~~~~    ^~~~~~~~~~~
   1 warning generated.


vim +244 drivers/mtd/mtdoops.c

   225	
   226	static void find_next_position(struct mtdoops_context *cxt)
   227	{
   228		struct mtd_info *mtd = cxt->mtd;
   229		struct mtdoops_hdr hdr;
   230		int ret, page, maxpos = 0;
   231		u32 maxcount = 0xffffffff;
   232		size_t retlen;
   233	
   234		for (page = 0; page < cxt->oops_pages; page++) {
   235			if (mtd_block_isbad(mtd, page * record_size))
   236				continue;
   237			/* Assume the page is used */
   238			mark_page_used(cxt, page);
   239			ret = mtd_read(mtd, page * record_size, sizeof(hdr),
   240				       &retlen, (u_char *)&hdr);
   241			if (retlen != sizeof(hdr) ||
   242					(ret < 0 && !mtd_is_bitflip(ret))) {
   243				printk(KERN_ERR "mtdoops: read failure at %ld (%td of %d read), err %d\n",
 > 244				       page * record_size, retlen, sizeof(hdr), ret);
   245				continue;
   246			}
   247	
   248			if (hdr.seq == 0xffffffff && hdr.magic == 0xffffffff)
   249				mark_page_unused(cxt, page);
   250			if (hdr.seq == 0xffffffff || hdr.magic != MTDOOPS_KERNMSG_MAGIC)
   251				continue;
   252			if (maxcount == 0xffffffff) {
   253				maxcount = hdr.seq;
   254				maxpos = page;
   255			} else if (hdr.seq < 0x40000000 && maxcount > 0xc0000000) {
   256				maxcount = hdr.seq;
   257				maxpos = page;
   258			} else if (hdr.seq > maxcount && hdr.seq < 0xc0000000) {
   259				maxcount = hdr.seq;
   260				maxpos = page;
   261			} else if (hdr.seq > maxcount && hdr.seq > 0xc0000000
   262						&& maxcount > 0x80000000) {
   263				maxcount = hdr.seq;
   264				maxpos = page;
   265			}
   266		}
   267		if (maxcount == 0xffffffff) {
   268			cxt->nextpage = cxt->oops_pages - 1;
   269			cxt->nextcount = 0;
   270		}
   271		else {
   272			cxt->nextpage = maxpos;
   273			cxt->nextcount = maxcount;
   274		}
   275	
   276		mtdoops_inc_counter(cxt);
   277	}
   278	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
