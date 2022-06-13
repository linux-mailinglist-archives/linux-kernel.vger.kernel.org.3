Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A5CF548E57
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 18:18:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357274AbiFMM6i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 08:58:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357865AbiFMMyr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 08:54:47 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E28B3527D
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 04:13:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655118811; x=1686654811;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5tZQf9EAVDpCey4B5lB7oXuEVWHHk1ZjyHK7x16J6ZM=;
  b=ldU/JW6nK9bED6IkCxmfPElDCxn9qFpC3ExeZZblTEBLiRxk9qGqUW37
   xwOwkzz2ZzW9dseFFRPSwKWKopjRI2JGFrRH4P4tl+6NDbB8Zpz3pl/Bv
   gulnelfCQCOuG0Av2mM9XKfudCniVktjWyDhANDunpNcqaEjZnoTRVxkb
   C+y2pNojwxfI6jatEjhTdZLyLr4HyouwC14u6HGqGjNQHrl63BI4iYFX+
   2hZEi9e0awBop3La1QicQIF2Cv8FP8WVhI13SxmSFXZN+0+o9SlID0CyI
   YBW+DdLFVKlvwtuqKTRQTfUCK1y4El1tdtRsbht46VQU5Xq0SaMwTVLKb
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10376"; a="303644746"
X-IronPort-AV: E=Sophos;i="5.91,297,1647327600"; 
   d="scan'208";a="303644746"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2022 04:13:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,297,1647327600"; 
   d="scan'208";a="711970654"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 13 Jun 2022 04:13:29 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o0i0e-000Kl1-SQ;
        Mon, 13 Jun 2022 11:13:28 +0000
Date:   Mon, 13 Jun 2022 19:13:26 +0800
From:   kernel test robot <lkp@intel.com>
To:     Anshuman Khandual <anshuman.khandual@arm.com>, linux-mm@kvack.org
Cc:     kbuild-all@lists.01.org,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 2/2] mm/mmap: Drop generic protection_map[] array
Message-ID: <202206131931.ZJuanaBo-lkp@intel.com>
References: <20220613053354.553579-3-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220613053354.553579-3-anshuman.khandual@arm.com>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Anshuman,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on akpm-mm/mm-everything]

url:    https://github.com/intel-lab-lkp/linux/commits/Anshuman-Khandual/mm-mmap-Drop-__SXXX-__PXXX-macros-from-across-platforms/20220613-133456
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
config: powerpc64-randconfig-r016-20220613 (https://download.01.org/0day-ci/archive/20220613/202206131931.ZJuanaBo-lkp@intel.com/config)
compiler: powerpc64le-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/696f81b49f7b6316f652d795da4c0008efef4487
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Anshuman-Khandual/mm-mmap-Drop-__SXXX-__PXXX-macros-from-across-platforms/20220613-133456
        git checkout 696f81b49f7b6316f652d795da4c0008efef4487
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=powerpc SHELL=/bin/bash arch/powerpc/mm/book3s64/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from arch/powerpc/include/asm/page.h:306,
                    from arch/powerpc/include/asm/mmu.h:149,
                    from arch/powerpc/include/asm/lppaca.h:46,
                    from arch/powerpc/include/asm/paca.h:18,
                    from arch/powerpc/include/asm/current.h:13,
                    from include/linux/sched.h:12,
                    from arch/powerpc/mm/book3s64/pgtable.c:6:
   arch/powerpc/mm/book3s64/pgtable.c: In function 'vm_get_page_prot':
>> arch/powerpc/mm/book3s64/pgtable.c:557:41: error: 'protection_map' undeclared (first use in this function)
     557 |         unsigned long prot = pgprot_val(protection_map[vm_flags &
         |                                         ^~~~~~~~~~~~~~
   arch/powerpc/include/asm/pgtable-be-types.h:68:27: note: in definition of macro 'pgprot_val'
      68 | #define pgprot_val(x)   ((x).pgprot)
         |                           ^
   arch/powerpc/mm/book3s64/pgtable.c:557:41: note: each undeclared identifier is reported only once for each function it appears in
     557 |         unsigned long prot = pgprot_val(protection_map[vm_flags &
         |                                         ^~~~~~~~~~~~~~
   arch/powerpc/include/asm/pgtable-be-types.h:68:27: note: in definition of macro 'pgprot_val'
      68 | #define pgprot_val(x)   ((x).pgprot)
         |                           ^


vim +/protection_map +557 arch/powerpc/mm/book3s64/pgtable.c

634093c59a12fc Anshuman Khandual 2022-04-28  553  
847c271152e941 Anshuman Khandual 2022-06-13  554  /* Note due to the way vm flags are laid out, the bits are XWR */
634093c59a12fc Anshuman Khandual 2022-04-28  555  pgprot_t vm_get_page_prot(unsigned long vm_flags)
634093c59a12fc Anshuman Khandual 2022-04-28  556  {
634093c59a12fc Anshuman Khandual 2022-04-28 @557  	unsigned long prot = pgprot_val(protection_map[vm_flags &
634093c59a12fc Anshuman Khandual 2022-04-28  558  					(VM_READ|VM_WRITE|VM_EXEC|VM_SHARED)]);
634093c59a12fc Anshuman Khandual 2022-04-28  559  
634093c59a12fc Anshuman Khandual 2022-04-28  560  	if (vm_flags & VM_SAO)
634093c59a12fc Anshuman Khandual 2022-04-28  561  		prot |= _PAGE_SAO;
634093c59a12fc Anshuman Khandual 2022-04-28  562  

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
