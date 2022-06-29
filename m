Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4819560477
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 17:25:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234017AbiF2PZM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 11:25:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234012AbiF2PZJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 11:25:09 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D97C2C666
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 08:25:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656516306; x=1688052306;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=rsBh3CN3RczFl/69t4y09dWTzrbPC6lSkMbr3jV9Ed4=;
  b=TK5Yz/BtZ9PTas/tq697Bt7lEjD9VOJKmEyOzN1tykdgwVtQxXUSleqW
   DwaPQGwW+pfBf2DGjFJD4lt2czYvdbZHFgBcowB6n9Fbxj6GSx5apMR0I
   k3wVGk0HOQMuDZgh0FKvvl7zSvjgc/sq04rs7MME7YJWsD7i1XX6xB+to
   KSFbHEeJk466/fTgp4Rz9MaIa+ZH1MI58UcOToa0YPLtOPra5SnJdJkJT
   s4ySPtn24USGsi98PlW+Apc4T3RamyksmwPK8f6wJOXk2foP3V1pgKNBz
   jkzNLNL7JrYHMxkkK5wuhtRoPpB2E8NRP915iHqcyvIRNmbPkE55izE5q
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10392"; a="283153185"
X-IronPort-AV: E=Sophos;i="5.92,231,1650956400"; 
   d="scan'208";a="283153185"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2022 08:25:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,231,1650956400"; 
   d="scan'208";a="837164289"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 29 Jun 2022 08:25:03 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o6ZYs-000BKQ-Vw;
        Wed, 29 Jun 2022 15:25:02 +0000
Date:   Wed, 29 Jun 2022 23:24:21 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jianglei Nie <niejianglei2021@163.com>, dan.j.williams@intel.com,
        vishal.l.verma@intel.com, dave.jiang@intel.com,
        fenghua.yu@intel.com, ravi.v.shankar@intel.com
Cc:     kbuild-all@lists.01.org, nvdimm@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Jianglei Nie <niejianglei2021@163.com>
Subject: Re: [PATCH] =?utf-8?B?77u/ZGF4?= =?utf-8?Q?=3A?= Fix potential uaf
 in __dax_pmem_probe()
Message-ID: <202206292354.BFJgFb0C-lkp@intel.com>
References: <20220629072259.2150978-1-niejianglei2021@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220629072259.2150978-1-niejianglei2021@163.com>
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jianglei,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on linus/master]
[also build test ERROR on v5.19-rc4 next-20220629]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Jianglei-Nie/dax-Fix-potential-uaf-in-__dax_pmem_probe/20220629-152544
base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 941e3e7912696b9fbe3586083a7c2e102cee7a87
config: x86_64-rhel-8.3 (https://download.01.org/0day-ci/archive/20220629/202206292354.BFJgFb0C-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/3b977a761f194fc61bdd0f6e97e1863ff32a04c5
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Jianglei-Nie/dax-Fix-potential-uaf-in-__dax_pmem_probe/20220629-152544
        git checkout 3b977a761f194fc61bdd0f6e97e1863ff32a04c5
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/dax/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All error/warnings (new ones prefixed by >>):

   drivers/dax/pmem.c: In function '__dax_pmem_probe':
>> drivers/dax/pmem.c:70:41: error: expected ')' before ';' token
      70 |                 return ERR_PTR((dev_dax);
         |                               ~         ^
         |                                         )
>> drivers/dax/pmem.c:70:32: warning: passing argument 1 of 'ERR_PTR' makes integer from pointer without a cast [-Wint-conversion]
      70 |                 return ERR_PTR((dev_dax);
         |                                ^~~~~~~~~
         |                                |
         |                                struct dev_dax *
   In file included from include/linux/container_of.h:6,
                    from include/linux/list.h:5,
                    from include/linux/preempt.h:11,
                    from include/linux/spinlock.h:55,
                    from include/linux/mmzone.h:8,
                    from include/linux/gfp.h:6,
                    from include/linux/mm.h:7,
                    from include/linux/memremap.h:5,
                    from drivers/dax/pmem.c:3:
   include/linux/err.h:24:48: note: expected 'long int' but argument is of type 'struct dev_dax *'
      24 | static inline void * __must_check ERR_PTR(long error)
         |                                           ~~~~~^~~~~
>> drivers/dax/pmem.c:75:24: error: expected ';' before '}' token
      75 |         return dev_dax;
         |                        ^
         |                        ;
      76 | }
         | ~                       
   drivers/dax/pmem.c:76:1: error: control reaches end of non-void function [-Werror=return-type]
      76 | }
         | ^
   cc1: some warnings being treated as errors


vim +70 drivers/dax/pmem.c

     9	
    10	static struct dev_dax *__dax_pmem_probe(struct device *dev)
    11	{
    12		struct range range;
    13		int rc, id, region_id;
    14		resource_size_t offset;
    15		struct nd_pfn_sb *pfn_sb;
    16		struct dev_dax *dev_dax;
    17		struct dev_dax_data data;
    18		struct nd_namespace_io *nsio;
    19		struct dax_region *dax_region;
    20		struct dev_pagemap pgmap = { };
    21		struct nd_namespace_common *ndns;
    22		struct nd_dax *nd_dax = to_nd_dax(dev);
    23		struct nd_pfn *nd_pfn = &nd_dax->nd_pfn;
    24		struct nd_region *nd_region = to_nd_region(dev->parent);
    25	
    26		ndns = nvdimm_namespace_common_probe(dev);
    27		if (IS_ERR(ndns))
    28			return ERR_CAST(ndns);
    29	
    30		/* parse the 'pfn' info block via ->rw_bytes */
    31		rc = devm_namespace_enable(dev, ndns, nd_info_block_reserve());
    32		if (rc)
    33			return ERR_PTR(rc);
    34		rc = nvdimm_setup_pfn(nd_pfn, &pgmap);
    35		if (rc)
    36			return ERR_PTR(rc);
    37		devm_namespace_disable(dev, ndns);
    38	
    39		/* reserve the metadata area, device-dax will reserve the data */
    40		pfn_sb = nd_pfn->pfn_sb;
    41		offset = le64_to_cpu(pfn_sb->dataoff);
    42		nsio = to_nd_namespace_io(&ndns->dev);
    43		if (!devm_request_mem_region(dev, nsio->res.start, offset,
    44					dev_name(&ndns->dev))) {
    45			dev_warn(dev, "could not reserve metadata\n");
    46			return ERR_PTR(-EBUSY);
    47		}
    48	
    49		rc = sscanf(dev_name(&ndns->dev), "namespace%d.%d", &region_id, &id);
    50		if (rc != 2)
    51			return ERR_PTR(-EINVAL);
    52	
    53		/* adjust the dax_region range to the start of data */
    54		range = pgmap.range;
    55		range.start += offset;
    56		dax_region = alloc_dax_region(dev, region_id, &range,
    57				nd_region->target_node, le32_to_cpu(pfn_sb->align),
    58				IORESOURCE_DAX_STATIC);
    59		if (!dax_region)
    60			return ERR_PTR(-ENOMEM);
    61	
    62		data = (struct dev_dax_data) {
    63			.dax_region = dax_region,
    64			.id = id,
    65			.pgmap = &pgmap,
    66			.size = range_len(&range),
    67		};
    68		dev_dax = devm_create_dev_dax(&data);
    69		if (IS_ERR(dev_dax))
  > 70			return ERR_PTR((dev_dax);
    71	
    72		/* child dev_dax instances now own the lifetime of the dax_region */
    73		dax_region_put(dax_region);
    74	
  > 75		return dev_dax;
    76	}
    77	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
