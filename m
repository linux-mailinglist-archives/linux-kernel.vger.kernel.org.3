Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EA3354D408
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 23:58:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349070AbiFOV6k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 17:58:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347212AbiFOV62 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 17:58:28 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50FE353C76
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 14:58:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655330307; x=1686866307;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=hgkr/ZTCRLZtyk/w+gY4NYjlB2I3vWlZZUc0EetIQxM=;
  b=aYv47tYzBiKONN0Nk71KLtpeO/DilzV0VeGW6Xtz6x/5hOfYyFG1Bter
   QdqdXv3w3IdsVI/CWx5GQ07AjYdlHf90Jf85XNjMC3D68BNAlbjc4WB1r
   R5uzELgAGcThP/xi+2MbJOhkqlN36zGt3i9UPsY1EpwSOlrsfpXlh1Vdm
   IT19EPGUta1xbFvZR/uEVJw7OzD7UkLcXr5Eug4d163pY2jb/AOoEpdDa
   eCGTyeOyumxaUPXJ3nZXuIPWZCEeoPc+4DPof16FNvuCdSSM+BRJ4mguk
   2Xha1FXwey1rihfQhn3I6vnBAg3DoxEDrUcLmNsxozovnGqab5KHGhEVu
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10379"; a="340765057"
X-IronPort-AV: E=Sophos;i="5.91,302,1647327600"; 
   d="scan'208";a="340765057"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2022 14:58:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,302,1647327600"; 
   d="scan'208";a="618656331"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 15 Jun 2022 14:58:25 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o1b1s-000NPd-K7;
        Wed, 15 Jun 2022 21:58:24 +0000
Date:   Thu, 16 Jun 2022 05:58:05 +0800
From:   kernel test robot <lkp@intel.com>
To:     Liang He <windhl@126.com>, palmer@dabbelt.com,
        paul.walmsley@sifive.com, aou@eecs.berkeley.edu
Cc:     kbuild-all@lists.01.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, windhl@126.com
Subject: Re: [PATCH] drivers: soc: sifive: Add missing of_node_put() in
 sifive_l2_cache.c
Message-ID: <202206160559.fVKJx0ST-lkp@intel.com>
References: <20220615122315.3965435-1-windhl@126.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220615122315.3965435-1-windhl@126.com>
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Liang,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on linus/master]
[also build test ERROR on v5.19-rc2 next-20220615]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Liang-He/drivers-soc-sifive-Add-missing-of_node_put-in-sifive_l2_cache-c/20220615-202528
base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 018ab4fabddd94f1c96f3b59e180691b9e88d5d8
config: riscv-allyesconfig (https://download.01.org/0day-ci/archive/20220616/202206160559.fVKJx0ST-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/49c4086768b5aff410a4a19ca740f8ae8e211844
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Liang-He/drivers-soc-sifive-Add-missing-of_node_put-in-sifive_l2_cache-c/20220615-202528
        git checkout 49c4086768b5aff410a4a19ca740f8ae8e211844
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash drivers/soc/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/soc/sifive/sifive_l2_cache.c: In function 'sifive_l2_init':
>> drivers/soc/sifive/sifive_l2_cache.c:224:17: error: expected ';' before 'goto'
     224 |                 goto out_put;
         |                 ^~~~


vim +224 drivers/soc/sifive/sifive_l2_cache.c

   194	
   195	static int __init sifive_l2_init(void)
   196	{
   197		struct device_node *np;
   198		struct resource res;
   199		int i, rc, intr_num;
   200	
   201		int ret;
   202	
   203		np = of_find_matching_node(NULL, sifive_l2_ids);
   204		if (!np)
   205			return -ENODEV;
   206	
   207		if (of_address_to_resource(np, 0, &res))
   208		{
   209			ret = -ENODEV;
   210			goto out_put;
   211		}
   212	
   213		l2_base = ioremap(res.start, resource_size(&res));
   214		if (!l2_base)
   215		{
   216			ret = -ENOMEM;
   217			goto out_put;
   218		}
   219	
   220		intr_num = of_property_count_u32_elems(np, "interrupts");
   221		if (!intr_num) {		
   222			pr_err("L2CACHE: no interrupts property\n");
   223			ret = -ENODEV
 > 224			goto out_put;
   225		}
   226	
   227		for (i = 0; i < intr_num; i++) {
   228			g_irq[i] = irq_of_parse_and_map(np, i);
   229			rc = request_irq(g_irq[i], l2_int_handler, 0, "l2_ecc", NULL);
   230			
   231			if (rc) {
   232				
   233				pr_err("L2CACHE: Could not request IRQ %d\n", g_irq[i]);
   234				ret = rc;
   235				goto out_put;
   236			}
   237		}
   238	
   239		l2_config_read();
   240	
   241		l2_cache_ops.get_priv_group = l2_get_priv_group;
   242		riscv_set_cacheinfo_ops(&l2_cache_ops);
   243	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
