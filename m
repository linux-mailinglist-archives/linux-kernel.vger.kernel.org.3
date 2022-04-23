Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB36550C813
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 09:43:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234008AbiDWHnt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Apr 2022 03:43:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230242AbiDWHnr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Apr 2022 03:43:47 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DC1F1ED407
        for <linux-kernel@vger.kernel.org>; Sat, 23 Apr 2022 00:40:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650699651; x=1682235651;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=ucuoSk12DQfsHOdwbBkyhJAs3pTgRSOksYR0POnApX8=;
  b=KR+3og/0XOcqI4YXLR5DyXjxCWUNpyhtIvI799atMgqiD05MDdBHayWG
   UnlcAfhdHl+04VWNfA2BmF5mVQHaLIJ4x/8wRm2JUEBZ5dWHNyQyfkdlg
   bF6dBFeto3KY62gpGoF92G2b06l/q11sQpc1aNv5Y2FN1bLKu5wcrmZm6
   7jtCmAoX9NaMDdbcQyZ5QEqzlMPZe+Waw8EHetrwxlzI+PQHntGu/NAc7
   n3LwnkigdpAvQUcX9kb+a/runYOCw4tqxsEFwNzYq/gs2GtsL/LyA/GuV
   RhNO5uoQr8qBvcBUMYWgSBkhNqTpGk5aqIX0KFDbazT2vAsq940PyAedJ
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10324"; a="264641886"
X-IronPort-AV: E=Sophos;i="5.90,284,1643702400"; 
   d="scan'208";a="264641886"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2022 00:40:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,284,1643702400"; 
   d="scan'208";a="728861838"
Received: from lkp-server01.sh.intel.com (HELO dd58949a6e39) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 23 Apr 2022 00:40:48 -0700
Received: from kbuild by dd58949a6e39 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1niANs-000024-1z;
        Sat, 23 Apr 2022 07:40:48 +0000
Date:   Sat, 23 Apr 2022 15:40:27 +0800
From:   kernel test robot <lkp@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: drivers/nvdimm/namespace_devs.c:915:20: warning: Local variable
 'res' shadows outer variable [shadowVariable]
Message-ID: <202204231545.HgpB1iQL-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   c00c5e1d157bec0ef0b0b59aa5482eb8dc7e8e49
commit: b4366a827f6cf6e58c93e076e335d9ee9ee0480f libnvdimm/labels: Introduce getters for namespace label fields
date:   8 months ago
compiler: arc-elf-gcc (GCC) 11.2.0
reproduce (cppcheck warning):
        # apt-get install cppcheck
        git checkout b4366a827f6cf6e58c93e076e335d9ee9ee0480f
        cppcheck --quiet --enable=style,performance,portability --template=gcc FILE

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


cppcheck warnings: (new ones prefixed by >>)
>> drivers/nvdimm/namespace_devs.c:915:20: warning: Local variable 'res' shadows outer variable [shadowVariable]
     struct resource *res;
                      ^
   drivers/nvdimm/namespace_devs.c:903:19: note: Shadowed declaration
    struct resource *res = &nspm->nsio.res;
                     ^
   drivers/nvdimm/namespace_devs.c:915:20: note: Shadow variable
     struct resource *res;
                      ^
>> drivers/nvdimm/namespace_devs.c:2030:26: warning: Local variable 'ndd' shadows outer variable [shadowVariable]
     struct nvdimm_drvdata *ndd;
                            ^
   drivers/nvdimm/namespace_devs.c:1953:25: note: Shadowed declaration
    struct nvdimm_drvdata *ndd = to_ndd(nd_mapping);
                           ^
   drivers/nvdimm/namespace_devs.c:2030:26: note: Shadow variable
     struct nvdimm_drvdata *ndd;
                            ^
   drivers/nvdimm/namespace_devs.c:2440:26: warning: Local variable 'e' shadows outer variable [shadowVariable]
      struct list_head *l, *e;
                            ^
   drivers/nvdimm/namespace_devs.c:2347:35: note: Shadowed declaration
    struct nd_label_ent *label_ent, *e;
                                     ^
   drivers/nvdimm/namespace_devs.c:2440:26: note: Shadow variable
      struct list_head *l, *e;
                            ^

cppcheck possible warnings: (new ones prefixed by >>, may not real problems)

>> drivers/nvdimm/namespace_devs.c:1235:9: warning: Uninitialized variable: nd_label [uninitvar]
      if (!nd_label)
           ^
   drivers/nvdimm/namespace_devs.c:1232:51: note: Assignment 'nd_label=label_ent->label', assigned value is <Uninit>
      struct nd_namespace_label *nd_label = label_ent->label;
                                                     ^
   drivers/nvdimm/namespace_devs.c:1235:9: note: Uninitialized variable: nd_label
      if (!nd_label)
           ^
   drivers/nvdimm/namespace_devs.c:1852:9: warning: Uninitialized variable: nd_label [uninitvar]
      if (!nd_label)
           ^
   drivers/nvdimm/namespace_devs.c:1848:51: note: Assignment 'nd_label=label_ent->label', assigned value is <Uninit>
      struct nd_namespace_label *nd_label = label_ent->label;
                                                     ^
   drivers/nvdimm/namespace_devs.c:1852:9: note: Uninitialized variable: nd_label
      if (!nd_label)
           ^
   drivers/nvdimm/namespace_devs.c:1908:9: warning: Uninitialized variable: nd_label [uninitvar]
      if (!nd_label)
           ^
   drivers/nvdimm/namespace_devs.c:1907:24: note: Assignment 'nd_label=label_ent->label', assigned value is <Uninit>
      nd_label = label_ent->label;
                          ^
   drivers/nvdimm/namespace_devs.c:1908:9: note: Uninitialized variable: nd_label
      if (!nd_label)
           ^
   drivers/nvdimm/namespace_devs.c:2358:8: warning: Uninitialized variable: nd_label [uninitvar]
     if (!nd_label)
          ^
   drivers/nvdimm/namespace_devs.c:2354:50: note: Assignment 'nd_label=label_ent->label', assigned value is <Uninit>
     struct nd_namespace_label *nd_label = label_ent->label;
                                                    ^
   drivers/nvdimm/namespace_devs.c:2358:8: note: Uninitialized variable: nd_label
     if (!nd_label)
          ^

vim +/res +915 drivers/nvdimm/namespace_devs.c

bf9bccc14c05dae Dan Williams 2015-06-17  899  
0e3b0d123c8fd5c Dan Williams 2016-10-06  900  static void nd_namespace_pmem_set_resource(struct nd_region *nd_region,
bf9bccc14c05dae Dan Williams 2015-06-17  901  		struct nd_namespace_pmem *nspm, resource_size_t size)
bf9bccc14c05dae Dan Williams 2015-06-17  902  {
bf9bccc14c05dae Dan Williams 2015-06-17  903  	struct resource *res = &nspm->nsio.res;
0e3b0d123c8fd5c Dan Williams 2016-10-06  904  	resource_size_t offset = 0;
bf9bccc14c05dae Dan Williams 2015-06-17  905  
0e3b0d123c8fd5c Dan Williams 2016-10-06  906  	if (size && !nspm->uuid) {
0e3b0d123c8fd5c Dan Williams 2016-10-06  907  		WARN_ON_ONCE(1);
0e3b0d123c8fd5c Dan Williams 2016-10-06  908  		size = 0;
0e3b0d123c8fd5c Dan Williams 2016-10-06  909  	}
0e3b0d123c8fd5c Dan Williams 2016-10-06  910  
0e3b0d123c8fd5c Dan Williams 2016-10-06  911  	if (size && nspm->uuid) {
0e3b0d123c8fd5c Dan Williams 2016-10-06  912  		struct nd_mapping *nd_mapping = &nd_region->mapping[0];
0e3b0d123c8fd5c Dan Williams 2016-10-06  913  		struct nvdimm_drvdata *ndd = to_ndd(nd_mapping);
0e3b0d123c8fd5c Dan Williams 2016-10-06  914  		struct nd_label_id label_id;
0e3b0d123c8fd5c Dan Williams 2016-10-06 @915  		struct resource *res;
0e3b0d123c8fd5c Dan Williams 2016-10-06  916  
0e3b0d123c8fd5c Dan Williams 2016-10-06  917  		if (!ndd) {
0e3b0d123c8fd5c Dan Williams 2016-10-06  918  			size = 0;
0e3b0d123c8fd5c Dan Williams 2016-10-06  919  			goto out;
0e3b0d123c8fd5c Dan Williams 2016-10-06  920  		}
0e3b0d123c8fd5c Dan Williams 2016-10-06  921  
0e3b0d123c8fd5c Dan Williams 2016-10-06  922  		nd_label_gen_id(&label_id, nspm->uuid, 0);
0e3b0d123c8fd5c Dan Williams 2016-10-06  923  
0e3b0d123c8fd5c Dan Williams 2016-10-06  924  		/* calculate a spa offset from the dpa allocation offset */
0e3b0d123c8fd5c Dan Williams 2016-10-06  925  		for_each_dpa_resource(ndd, res)
0e3b0d123c8fd5c Dan Williams 2016-10-06  926  			if (strcmp(res->name, label_id.id) == 0) {
0e3b0d123c8fd5c Dan Williams 2016-10-06  927  				offset = (res->start - nd_mapping->start)
0e3b0d123c8fd5c Dan Williams 2016-10-06  928  					* nd_region->ndr_mappings;
0e3b0d123c8fd5c Dan Williams 2016-10-06  929  				goto out;
0e3b0d123c8fd5c Dan Williams 2016-10-06  930  			}
0e3b0d123c8fd5c Dan Williams 2016-10-06  931  
0e3b0d123c8fd5c Dan Williams 2016-10-06  932  		WARN_ON_ONCE(1);
0e3b0d123c8fd5c Dan Williams 2016-10-06  933  		size = 0;
0e3b0d123c8fd5c Dan Williams 2016-10-06  934  	}
0e3b0d123c8fd5c Dan Williams 2016-10-06  935  
0e3b0d123c8fd5c Dan Williams 2016-10-06  936   out:
0e3b0d123c8fd5c Dan Williams 2016-10-06  937  	res->start = nd_region->ndr_start + offset;
0e3b0d123c8fd5c Dan Williams 2016-10-06  938  	res->end = res->start + size - 1;
bf9bccc14c05dae Dan Williams 2015-06-17  939  }
bf9bccc14c05dae Dan Williams 2015-06-17  940  

:::::: The code at line 915 was first introduced by commit
:::::: 0e3b0d123c8fd5c42f364aea3ab663b1f18dad39 libnvdimm, namespace: allow multiple pmem-namespaces per region at scan time

:::::: TO: Dan Williams <dan.j.williams@intel.com>
:::::: CC: Dan Williams <dan.j.williams@intel.com>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
