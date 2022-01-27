Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F21E49DFE4
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 11:57:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239748AbiA0K5H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 05:57:07 -0500
Received: from mga05.intel.com ([192.55.52.43]:52180 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235320AbiA0K5G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 05:57:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643281026; x=1674817026;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Ql7BSUDrj1rmSw+KHzQ6hK0pZiggLrzLlE0Fbpo3FP4=;
  b=BW7n8ZKXbhpWmdhbBWdgA6hz6fslSauho2wtMzu6bvT4NKFQiVdU1D6l
   GxAIf9DDCU1Af0sD5/WrpUakFs5rt7aDLecuSnAo1XSbdsViKLNTz3ebe
   GFUV3XgJMOLsSqvD0poXW7PA5QlJb5GHg77FUZgY4fBHc9rdtijGxSf5k
   Pqz/2izUghlXmUGQdMFWasFC3M03govP+C/qgvv6Lk7FAEbS89zAVzis8
   5GV4c9qPvXJXInkdufJZLaZHsLh8VDO3iYdAWZRxajuJWd57CtzcWuBiH
   WPCXOssIcqZqXbvdLjzoSBoR0LYr5wo9/31tJmt+MSBrvjeyWCU708L7H
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10239"; a="333172060"
X-IronPort-AV: E=Sophos;i="5.88,320,1635231600"; 
   d="scan'208";a="333172060"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2022 02:56:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,320,1635231600"; 
   d="scan'208";a="521183098"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 27 Jan 2022 02:56:53 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nD2ST-000MVm-7u; Thu, 27 Jan 2022 10:56:53 +0000
Date:   Thu, 27 Jan 2022 18:56:26 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ben Widawsky <ben.widawsky@intel.com>
Cc:     kbuild-all@lists.01.org,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-kernel@vger.kernel.org
Subject: [cxl:preview 60/60] drivers/cxl/region.c:734: undefined reference to
 `nvdimm_pmem_region_create'
Message-ID: <202201271831.cqd50BdJ-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git preview
head:   41c2d219a2c8e14de644f4e953e0c57402c3e884
commit: 41c2d219a2c8e14de644f4e953e0c57402c3e884 [60/60] cxl/region: Create an nd_region
config: x86_64-randconfig-a001-20220124 (https://download.01.org/0day-ci/archive/20220127/202201271831.cqd50BdJ-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git/commit/?id=41c2d219a2c8e14de644f4e953e0c57402c3e884
        git remote add cxl https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git
        git fetch --no-tags cxl preview
        git checkout 41c2d219a2c8e14de644f4e953e0c57402c3e884
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   ld: drivers/cxl/region.o: in function `connect_to_libnvdimm':
>> drivers/cxl/region.c:734: undefined reference to `nvdimm_pmem_region_create'


vim +734 drivers/cxl/region.c

   693	
   694	static int connect_to_libnvdimm(struct cxl_region *region)
   695	{
   696		struct nd_region_desc ndr_desc;
   697		struct cxl_nvdimm_bridge *nvb;
   698		struct nd_region *ndr;
   699		int rc = 0;
   700	
   701		nvb = cxl_find_nvdimm_bridge(&region->config.targets[0]->dev);
   702		if (!nvb) {
   703			dev_dbg(&region->dev, "Couldn't find nvdimm bridge\n");
   704			return -ENODEV;
   705		}
   706	
   707		device_lock(&nvb->dev);
   708		if (!nvb->nvdimm_bus) {
   709			dev_dbg(&nvb->dev, "Couldn't find nvdimm bridge's bus\n");
   710			rc = -ENXIO;
   711			goto out;
   712		}
   713	
   714		memset(&ndr_desc, 0, sizeof(ndr_desc));
   715	
   716		ndr_desc.res = region->res;
   717	
   718		ndr_desc.numa_node = memory_add_physaddr_to_nid(region->res->start);
   719		ndr_desc.target_node = phys_to_target_node(region->res->start);
   720		if (ndr_desc.numa_node == NUMA_NO_NODE) {
   721			ndr_desc.numa_node =
   722				memory_add_physaddr_to_nid(region->res->start);
   723			dev_info(&region->dev,
   724				 "changing numa node from %d to %d for CXL region %pR",
   725				 NUMA_NO_NODE, ndr_desc.numa_node, region->res);
   726		}
   727		if (ndr_desc.target_node == NUMA_NO_NODE) {
   728			ndr_desc.target_node = ndr_desc.numa_node;
   729			dev_info(&region->dev,
   730				 "changing target node from %d to %d for CXL region %pR",
   731				 NUMA_NO_NODE, ndr_desc.target_node, region->res);
   732		}
   733	
 > 734		ndr = nvdimm_pmem_region_create(nvb->nvdimm_bus, &ndr_desc);
   735		if (IS_ERR(ndr))
   736			rc = PTR_ERR(ndr);
   737		else
   738			dev_set_drvdata(&region->dev, ndr);
   739	
   740	out:
   741		device_unlock(&nvb->dev);
   742		put_device(&nvb->dev);
   743		return rc;
   744	}
   745	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
