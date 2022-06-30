Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB208562401
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 22:16:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237208AbiF3UQS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 16:16:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236609AbiF3UQQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 16:16:16 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D671443E9
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 13:16:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656620175; x=1688156175;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/P8Ef8gRoj8g19WoNvNl9Palb+vUkjurN5jxkAB5JZk=;
  b=B4jacKG+/xqGS+YCmsi0iulxJ1lLnJ1pVaOv/bXjXITKiPMJJku0nNcw
   w+9g5F7mAnC0FQPZ5xhhkEN2ICUFQVbR5js3tBnByPZxx33wYmQrRovSb
   twCn1zXJeHOku/wXUo8n7Q76S07EYfx0XvwKuG7/fp9fc95OdnCPBjmSf
   hrrcLEytBw7/XqDU8z8oD+xzTeZaS5K9lz4l8mqETD9TYpItWOsGNfusc
   kVx0JCcYjJ27e2hYvE0lizExwC2kWmXj+309lEtYpT02okqYEeZYXsF3z
   CvjJ//J0Ygk3NcH6rWqhz7NM4UFoq087uCOELRC2KzAqxjgWmpOqoeWZK
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10394"; a="262859321"
X-IronPort-AV: E=Sophos;i="5.92,235,1650956400"; 
   d="scan'208";a="262859321"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2022 13:16:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,235,1650956400"; 
   d="scan'208";a="718365569"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 30 Jun 2022 13:16:09 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o70a8-000D9s-Ky;
        Thu, 30 Jun 2022 20:16:08 +0000
Date:   Fri, 1 Jul 2022 04:15:13 +0800
From:   kernel test robot <lkp@intel.com>
To:     Guanghui Feng <guanghuifeng@linux.alibaba.com>,
        baolin.wang@linux.alibaba.com, catalin.marinas@arm.com,
        will@kernel.org, akpm@linux-foundation.org, david@redhat.com,
        jianyong.wu@arm.com, james.morse@arm.com, quic_qiancai@quicinc.com,
        christophe.leroy@csgroup.eu, jonathan@marek.ca,
        mark.rutland@arm.com, thunder.leizhen@huawei.com,
        anshuman.khandual@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, rppt@kernel.org,
        geert+renesas@glider.be, ardb@kernel.org, linux-mm@kvack.org,
        yaohongbo@linux.alibaba.com
Cc:     kbuild-all@lists.01.org, alikernel-developer@linux.alibaba.com
Subject: Re: [PATCH v2] arm64: mm: fix linear mapping mem access performance
 degradation
Message-ID: <202207010409.ajCVDXYO-lkp@intel.com>
References: <1656578288-11259-1-git-send-email-guanghuifeng@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1656578288-11259-1-git-send-email-guanghuifeng@linux.alibaba.com>
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Guanghui,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on v5.19-rc4]
[also build test WARNING on linus/master next-20220630]
[cannot apply to arm64/for-next/core]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Guanghui-Feng/arm64-mm-fix-linear-mapping-mem-access-performance-degradation/20220630-163924
base:    03c765b0e3b4cb5063276b086c76f7a612856a9a
config: arm64-allyesconfig (https://download.01.org/0day-ci/archive/20220701/202207010409.ajCVDXYO-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/168f0d56f0a26c4f7a9470d6f1c398b4e1c1b5b9
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Guanghui-Feng/arm64-mm-fix-linear-mapping-mem-access-performance-degradation/20220630-163924
        git checkout 168f0d56f0a26c4f7a9470d6f1c398b4e1c1b5b9
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash arch/arm64/mm/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   arch/arm64/mm/mmu.c: In function 'alloc_init_pud':
>> arch/arm64/mm/mmu.c:426:35: warning: suggest braces around empty body in an 'if' statement [-Wempty-body]
     426 |                 pud_clear_fixmap();
         |                                   ^


vim +/if +426 arch/arm64/mm/mmu.c

d27cfa1fc823d3 Ard Biesheuvel    2017-03-09  333  
20a004e7b017cc Will Deacon       2018-02-15  334  static void alloc_init_pud(pgd_t *pgdp, unsigned long addr, unsigned long end,
da141706aea52c Laura Abbott      2015-01-21  335  			   phys_addr_t phys, pgprot_t prot,
90292aca9854a2 Yu Zhao           2019-03-11  336  			   phys_addr_t (*pgtable_alloc)(int),
c0951366d4b7e0 Ard Biesheuvel    2017-03-09  337  			   int flags)
c1cc1552616d0f Catalin Marinas   2012-03-05  338  {
168f0d56f0a26c Guanghui Feng     2022-06-30  339  	phys_addr_t map_offset;
c1cc1552616d0f Catalin Marinas   2012-03-05  340  	unsigned long next;
168f0d56f0a26c Guanghui Feng     2022-06-30  341  	pudval_t pudval;
20a004e7b017cc Will Deacon       2018-02-15  342  	pud_t *pudp;
e9f6376858b979 Mike Rapoport     2020-06-04  343  	p4d_t *p4dp = p4d_offset(pgdp, addr);
e9f6376858b979 Mike Rapoport     2020-06-04  344  	p4d_t p4d = READ_ONCE(*p4dp);
c1cc1552616d0f Catalin Marinas   2012-03-05  345  
e9f6376858b979 Mike Rapoport     2020-06-04  346  	if (p4d_none(p4d)) {
87143f404f338d Ard Biesheuvel    2021-03-10  347  		p4dval_t p4dval = P4D_TYPE_TABLE | P4D_TABLE_UXN;
132233a759580f Laura Abbott      2016-02-05  348  		phys_addr_t pud_phys;
87143f404f338d Ard Biesheuvel    2021-03-10  349  
87143f404f338d Ard Biesheuvel    2021-03-10  350  		if (flags & NO_EXEC_MAPPINGS)
87143f404f338d Ard Biesheuvel    2021-03-10  351  			p4dval |= P4D_TABLE_PXN;
132233a759580f Laura Abbott      2016-02-05  352  		BUG_ON(!pgtable_alloc);
90292aca9854a2 Yu Zhao           2019-03-11  353  		pud_phys = pgtable_alloc(PUD_SHIFT);
87143f404f338d Ard Biesheuvel    2021-03-10  354  		__p4d_populate(p4dp, pud_phys, p4dval);
e9f6376858b979 Mike Rapoport     2020-06-04  355  		p4d = READ_ONCE(*p4dp);
c79b954bf6c006 Jungseok Lee      2014-05-12  356  	}
e9f6376858b979 Mike Rapoport     2020-06-04  357  	BUG_ON(p4d_bad(p4d));
c79b954bf6c006 Jungseok Lee      2014-05-12  358  
ee017ee353506f Jianyong Wu       2022-02-01  359  	/*
ee017ee353506f Jianyong Wu       2022-02-01  360  	 * No need for locking during early boot. And it doesn't work as
ee017ee353506f Jianyong Wu       2022-02-01  361  	 * expected with KASLR enabled.
ee017ee353506f Jianyong Wu       2022-02-01  362  	 */
ee017ee353506f Jianyong Wu       2022-02-01  363  	if (system_state != SYSTEM_BOOTING)
ee017ee353506f Jianyong Wu       2022-02-01  364  		mutex_lock(&fixmap_lock);
168f0d56f0a26c Guanghui Feng     2022-06-30  365  
168f0d56f0a26c Guanghui Feng     2022-06-30  366  	pudp = (flags & NO_SEC_REMAPPINGS) ? pud_offset(p4dp, addr) :
168f0d56f0a26c Guanghui Feng     2022-06-30  367  		pud_set_fixmap_offset(p4dp, addr);
c1cc1552616d0f Catalin Marinas   2012-03-05  368  	do {
20a004e7b017cc Will Deacon       2018-02-15  369  		pud_t old_pud = READ_ONCE(*pudp);
c1cc1552616d0f Catalin Marinas   2012-03-05  370  		next = pud_addr_end(addr, end);
206a2a73a62d37 Steve Capper      2014-05-06  371  
168f0d56f0a26c Guanghui Feng     2022-06-30  372  		if (flags & NO_SEC_REMAPPINGS) {
168f0d56f0a26c Guanghui Feng     2022-06-30  373  			if (!pud_none(*pudp) && pud_sect(*pudp)) {
168f0d56f0a26c Guanghui Feng     2022-06-30  374  				phys_addr_t pmd_phys = pgtable_alloc(PMD_SHIFT);
168f0d56f0a26c Guanghui Feng     2022-06-30  375  				pud_clear(pudp);
168f0d56f0a26c Guanghui Feng     2022-06-30  376  				pudval = PUD_TYPE_TABLE | PUD_TABLE_UXN;
168f0d56f0a26c Guanghui Feng     2022-06-30  377  				if (flags & NO_EXEC_MAPPINGS)
168f0d56f0a26c Guanghui Feng     2022-06-30  378  					pudval |= PUD_TABLE_PXN;
168f0d56f0a26c Guanghui Feng     2022-06-30  379  
168f0d56f0a26c Guanghui Feng     2022-06-30  380  				__pud_populate(pudp, pmd_phys, pudval);
168f0d56f0a26c Guanghui Feng     2022-06-30  381  				flush_tlb_kernel_range(addr, addr + PAGE_SIZE);
168f0d56f0a26c Guanghui Feng     2022-06-30  382  
168f0d56f0a26c Guanghui Feng     2022-06-30  383  				map_offset = addr - (addr & PUD_MASK);
168f0d56f0a26c Guanghui Feng     2022-06-30  384  				if (map_offset)
168f0d56f0a26c Guanghui Feng     2022-06-30  385  				    alloc_init_cont_pmd(pudp, addr & PUD_MASK,
168f0d56f0a26c Guanghui Feng     2022-06-30  386  							addr, phys - map_offset,
168f0d56f0a26c Guanghui Feng     2022-06-30  387  							prot, pgtable_alloc,
168f0d56f0a26c Guanghui Feng     2022-06-30  388  							flags &	(~NO_SEC_REMAPPINGS));
168f0d56f0a26c Guanghui Feng     2022-06-30  389  
168f0d56f0a26c Guanghui Feng     2022-06-30  390  				if (next < (addr & PUD_MASK) + PUD_SIZE)
168f0d56f0a26c Guanghui Feng     2022-06-30  391  				    alloc_init_cont_pmd(pudp, next,
168f0d56f0a26c Guanghui Feng     2022-06-30  392  						       (addr & PUD_MASK) +
168f0d56f0a26c Guanghui Feng     2022-06-30  393  							PUD_SIZE,
168f0d56f0a26c Guanghui Feng     2022-06-30  394  							next - addr + phys,
168f0d56f0a26c Guanghui Feng     2022-06-30  395  							prot, pgtable_alloc,
168f0d56f0a26c Guanghui Feng     2022-06-30  396  							flags & (~NO_SEC_REMAPPINGS));
168f0d56f0a26c Guanghui Feng     2022-06-30  397  			}
168f0d56f0a26c Guanghui Feng     2022-06-30  398  			alloc_init_cont_pmd(pudp, addr, next, phys, prot,
168f0d56f0a26c Guanghui Feng     2022-06-30  399  					    pgtable_alloc, flags);
168f0d56f0a26c Guanghui Feng     2022-06-30  400  		}
206a2a73a62d37 Steve Capper      2014-05-06  401  		/*
206a2a73a62d37 Steve Capper      2014-05-06  402  		 * For 4K granule only, attempt to put down a 1GB block
206a2a73a62d37 Steve Capper      2014-05-06  403  		 */
168f0d56f0a26c Guanghui Feng     2022-06-30  404  		else if (pud_sect_supported() &&
1310222c276b79 Anshuman Khandual 2022-02-16  405  			((addr | next | phys) & ~PUD_MASK) == 0 &&
c0951366d4b7e0 Ard Biesheuvel    2017-03-09  406  			(flags & NO_BLOCK_MAPPINGS) == 0) {
20a004e7b017cc Will Deacon       2018-02-15  407  			pud_set_huge(pudp, phys, prot);
206a2a73a62d37 Steve Capper      2014-05-06  408  
206a2a73a62d37 Steve Capper      2014-05-06  409  			/*
e98216b52176ba Ard Biesheuvel    2016-10-21  410  			 * After the PUD entry has been populated once, we
e98216b52176ba Ard Biesheuvel    2016-10-21  411  			 * only allow updates to the permission attributes.
206a2a73a62d37 Steve Capper      2014-05-06  412  			 */
e98216b52176ba Ard Biesheuvel    2016-10-21  413  			BUG_ON(!pgattr_change_is_safe(pud_val(old_pud),
20a004e7b017cc Will Deacon       2018-02-15  414  						      READ_ONCE(pud_val(*pudp))));
206a2a73a62d37 Steve Capper      2014-05-06  415  		} else {
20a004e7b017cc Will Deacon       2018-02-15  416  			alloc_init_cont_pmd(pudp, addr, next, phys, prot,
c0951366d4b7e0 Ard Biesheuvel    2017-03-09  417  					    pgtable_alloc, flags);
e98216b52176ba Ard Biesheuvel    2016-10-21  418  
e98216b52176ba Ard Biesheuvel    2016-10-21  419  			BUG_ON(pud_val(old_pud) != 0 &&
20a004e7b017cc Will Deacon       2018-02-15  420  			       pud_val(old_pud) != READ_ONCE(pud_val(*pudp)));
206a2a73a62d37 Steve Capper      2014-05-06  421  		}
c1cc1552616d0f Catalin Marinas   2012-03-05  422  		phys += next - addr;
20a004e7b017cc Will Deacon       2018-02-15  423  	} while (pudp++, addr = next, addr != end);
f4710445458c0a Mark Rutland      2016-01-25  424  
168f0d56f0a26c Guanghui Feng     2022-06-30  425  	if (!(flags & NO_SEC_REMAPPINGS))
f4710445458c0a Mark Rutland      2016-01-25 @426  		pud_clear_fixmap();
ee017ee353506f Jianyong Wu       2022-02-01  427  	if (system_state != SYSTEM_BOOTING)
ee017ee353506f Jianyong Wu       2022-02-01  428  		mutex_unlock(&fixmap_lock);
c1cc1552616d0f Catalin Marinas   2012-03-05  429  }
c1cc1552616d0f Catalin Marinas   2012-03-05  430  

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
