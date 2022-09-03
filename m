Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E3D05ABB93
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Sep 2022 02:14:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230513AbiICANr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 20:13:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230114AbiICANm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 20:13:42 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2A35E7277
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 17:13:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662164018; x=1693700018;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=JfHBFL6qCUGLbB4tCJ0b923ezPAL9d6TPD4UzsWt4rw=;
  b=MOs961ROvBMaz0gD7guN5MJvWN5chhP/JqbnQNZgfjZ2/iStXmV8fhNq
   syjgLqLF+0dRLPfeljUdLyZ0vUneNDMqO2Ub8zYWeBrAIyVev30YaAUR5
   X73GSGl5FCBNBujUnD28dy8plBDJLkShhLv/cL2kc3+fImkg1mydjK+kf
   9XBjhgQ/PJt5Ao7HqDuDB/86h84lj90AL6Oimpc8kz1AK2u6b2B3taLKL
   O0Ld/cW63/sTlioHt4mwqdCLxTMgRw1wToMWI423K4THHgkQr6WjMjAiD
   Qt/Rjtlwf86mTm0IdeeJ0VrHPcIBGqJiJOtSKX0hgpUWmVVddCw40zSMo
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10458"; a="279126934"
X-IronPort-AV: E=Sophos;i="5.93,285,1654585200"; 
   d="scan'208";a="279126934"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2022 17:13:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,285,1654585200"; 
   d="scan'208";a="755426183"
Received: from lkp-server02.sh.intel.com (HELO 95dfd251caa2) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 02 Sep 2022 17:13:37 -0700
Received: from kbuild by 95dfd251caa2 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oUGmx-0000ll-1i;
        Sat, 03 Sep 2022 00:13:31 +0000
Date:   Sat, 3 Sep 2022 08:12:48 +0800
From:   kernel test robot <lkp@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [djbw-nvdimm:libnvdimm-pending 12/16] drivers/dax/mapping.c:345:15:
 warning: assignment to 'struct dev_pagemap *' from 'int' makes pointer from
 integer without a cast
Message-ID: <202209030805.hxvdDbvK-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dan,

FYI, the error/warning was bisected to this commit, please ignore it if it's irrelevant.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/djbw/nvdimm.git libnvdimm-pending
head:   ac9d6b3ba0a537b67bdc8e525308dc371da91e1b
commit: fd2e18c05d353b59283b4cb5508bafecd766b304 [12/16] devdax: Move address_space helpers to the DAX core
config: s390-allyesconfig (https://download.01.org/0day-ci/archive/20220903/202209030805.hxvdDbvK-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/djbw/nvdimm.git/commit/?id=fd2e18c05d353b59283b4cb5508bafecd766b304
        git remote add djbw-nvdimm https://git.kernel.org/pub/scm/linux/kernel/git/djbw/nvdimm.git
        git fetch --no-tags djbw-nvdimm libnvdimm-pending
        git checkout fd2e18c05d353b59283b4cb5508bafecd766b304
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=s390 SHELL=/bin/bash drivers/dax/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/dax/mapping.c: In function 'dax_associate_entry':
   drivers/dax/mapping.c:345:17: error: implicit declaration of function 'get_dev_pagemap_many'; did you mean 'put_dev_pagemap_many'? [-Werror=implicit-function-declaration]
     345 |         pgmap = get_dev_pagemap_many(pfn, NULL, PHYS_PFN(size));
         |                 ^~~~~~~~~~~~~~~~~~~~
         |                 put_dev_pagemap_many
>> drivers/dax/mapping.c:345:15: warning: assignment to 'struct dev_pagemap *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
     345 |         pgmap = get_dev_pagemap_many(pfn, NULL, PHYS_PFN(size));
         |               ^
   cc1: some warnings being treated as errors


vim +345 drivers/dax/mapping.c

   324	
   325	/*
   326	 * When it is called in dax_insert_entry(), the cow flag will indicate that
   327	 * whether this entry is shared by multiple files.  If so, set the page->mapping
   328	 * FS_DAX_MAPPING_COW, and use page->index as refcount.
   329	 */
   330	static vm_fault_t dax_associate_entry(void *entry,
   331					      struct address_space *mapping,
   332					      struct vm_fault *vmf, unsigned long flags)
   333	{
   334		unsigned long size = dax_entry_size(entry), pfn, index;
   335		struct dev_pagemap *pgmap;
   336		int i = 0;
   337	
   338		if (IS_ENABLED(CONFIG_FS_DAX_LIMITED))
   339			return 0;
   340	
   341		if (!size)
   342			return 0;
   343	
   344		pfn = dax_to_pfn(entry);
 > 345		pgmap = get_dev_pagemap_many(pfn, NULL, PHYS_PFN(size));
   346		if (!pgmap)
   347			return VM_FAULT_SIGBUS;
   348	
   349		index = linear_page_index(vmf->vma, ALIGN(vmf->address, size));
   350		for_each_mapped_pfn(entry, pfn) {
   351			struct page *page = pfn_to_page(pfn);
   352	
   353			if (flags & DAX_COW) {
   354				dax_mapping_set_cow(page);
   355			} else {
   356				WARN_ON_ONCE(page->mapping);
   357				page->mapping = mapping;
   358				page->index = index + i++;
   359			}
   360		}
   361	
   362		return 0;
   363	}
   364	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
