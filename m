Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8896480721
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Dec 2021 08:54:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235448AbhL1Hx7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Dec 2021 02:53:59 -0500
Received: from mga11.intel.com ([192.55.52.93]:37395 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235425AbhL1Hx6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Dec 2021 02:53:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640678038; x=1672214038;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=UxcA8j3rYSenTgfQcP67Ebal40ladU1yoHzj3kmyLoo=;
  b=nuLbR8aRhAPPw1BRGkyTs6DhO0+txaIWlSiomJReeA3n7hKOXG/MGq6r
   XJrYCyyDc8wGkfpyWKw7Dt6POaJ9NU9xC/HVQdMVV0zujgstbQmoogXAk
   HiZhnpJJxaUn1ZVNO4HHtmEbY403gKBV53j5rwSyRDFFNAcEVc6k6XCvg
   X2dVKR/itp/mQYp2hgZ5dsQLUhQA3saw3xXL+gF4d3sV53nR8uI54a9MF
   hEUFxq4/RvjXJMeWxjyCvd5IxXEG162gh1ExoMviUgL945gwLrTiKvjxO
   HmG+JxqdcqgVboNR24nH08kDpTKzaVfl5oS96xMIw6ebflwu1saaKtG1E
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10210"; a="238872524"
X-IronPort-AV: E=Sophos;i="5.88,241,1635231600"; 
   d="scan'208";a="238872524"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Dec 2021 23:53:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,241,1635231600"; 
   d="scan'208";a="618680234"
Received: from lkp-server01.sh.intel.com (HELO e357b3ef1427) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 27 Dec 2021 23:53:57 -0800
Received: from kbuild by e357b3ef1427 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n27Iy-0007OE-B8; Tue, 28 Dec 2021 07:53:56 +0000
Date:   Tue, 28 Dec 2021 15:53:22 +0800
From:   kernel test robot <lkp@intel.com>
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [sbates130272-p2pmem:p2pdma_user_cmb_v5 21/23]
 drivers/pci/p2pdma.c:108:38: sparse: sparse: dereference of noderef
 expression
Message-ID: <202112281530.kK94gKnk-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/sbates130272/linux-p2pmem.git p2pdma_user_cmb_v5
head:   407e0b007d670af84abbb624d9bbd4057b31a7d9
commit: 987aec4824931d2be618b29001359e633aa96988 [21/23] mm: use custom page_free for P2PDMA pages
config: x86_64-randconfig-s021-20211228 (https://download.01.org/0day-ci/archive/20211228/202112281530.kK94gKnk-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://github.com/sbates130272/linux-p2pmem/commit/987aec4824931d2be618b29001359e633aa96988
        git remote add sbates130272-p2pmem https://github.com/sbates130272/linux-p2pmem.git
        git fetch --no-tags sbates130272-p2pmem p2pdma_user_cmb_v5
        git checkout 987aec4824931d2be618b29001359e633aa96988
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/pci/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> drivers/pci/p2pdma.c:108:38: sparse: sparse: dereference of noderef expression
>> drivers/pci/p2pdma.c:108:38: sparse: sparse: dereference of noderef expression

vim +108 drivers/pci/p2pdma.c

   103	
   104	static void p2pdma_page_free(struct page *page)
   105	{
   106		struct pci_p2pdma_pagemap *pgmap = to_p2p_pgmap(page->pgmap);
   107	
 > 108		gen_pool_free(pgmap->provider->p2pdma->pool,
   109			      (uintptr_t)page_to_virt(page), PAGE_SIZE);
   110	}
   111	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
