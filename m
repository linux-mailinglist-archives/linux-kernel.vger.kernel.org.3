Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC560552A55
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 06:39:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232725AbiFUEir (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 00:38:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233633AbiFUEij (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 00:38:39 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED4631C109
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 21:38:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655786315; x=1687322315;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=w52u60xyH32SPDjtHdPrjV/3isxQYl4S8lnKBTVLceM=;
  b=Cg50Pn4hkM5o6O6iRZUrMRZJihh4aVOKGVZ5i3Hrbu9UNqk0u4QE88A7
   XWSb965dGLJUZm5k3D+xJc1eq3ZQ3gkwWqDDiBLjrQXLewfwDtnKgsn4D
   iwWdjBWuunxYYFkaAw9EzHQJ1uSpgBeeOCJpY+K/oiifM6NCXi4qhEkB8
   4o0NNpDldikchS7iKqwWocVGU3IEkCcfjlHu6m735DYJ9k1inuAGMDHxd
   pKvEP1NO40tlpBD2yzCI1Q4DLFaJ2h6FsPNHFcKbRCXyVqmu34HdhwNON
   fu8Qz1S3VVaCtkfp9wmUcIGnaoAQJ1wPfbfLYR2ddSeh3gDPa9jOYfqRF
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10384"; a="259846555"
X-IronPort-AV: E=Sophos;i="5.92,207,1650956400"; 
   d="scan'208";a="259846555"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2022 21:38:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,207,1650956400"; 
   d="scan'208";a="689756979"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 20 Jun 2022 21:38:33 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o3Veq-000YII-Ss;
        Tue, 21 Jun 2022 04:38:32 +0000
Date:   Tue, 21 Jun 2022 12:37:52 +0800
From:   kernel test robot <lkp@intel.com>
To:     Cai Huoqing <cai.huoqing@linux.dev>
Cc:     kbuild-all@lists.01.org,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm: Make drm_buddy a part of drm module
Message-ID: <202206211209.5H0Eh2ff-lkp@intel.com>
References: <20220621015151.11129-1-cai.huoqing@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220621015151.11129-1-cai.huoqing@linux.dev>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Cai,

I love your patch! Yet something to improve:

[auto build test ERROR on drm/drm-next]
[also build test ERROR on linus/master v5.19-rc2 next-20220617]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Cai-Huoqing/drm-Make-drm_buddy-a-part-of-drm-module/20220621-095417
base:   git://anongit.freedesktop.org/drm/drm drm-next
config: x86_64-rhel-8.3-kunit (https://download.01.org/0day-ci/archive/20220621/202206211209.5H0Eh2ff-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/517d5f44c861a5173eaa9a06efebe2ce2a6601a1
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Cai-Huoqing/drm-Make-drm_buddy-a-part-of-drm-module/20220621-095417
        git checkout 517d5f44c861a5173eaa9a06efebe2ce2a6601a1
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   ld: drivers/gpu/drm/drm_buddy.o: in function `drm_buddy_print':
>> drivers/gpu/drm/drm_buddy.c:745: undefined reference to `drm_printf'
>> ld: drivers/gpu/drm/drm_buddy.c:757: undefined reference to `drm_printf'
   ld: drivers/gpu/drm/drm_buddy.c:763: undefined reference to `drm_printf'
   ld: drivers/gpu/drm/drm_buddy.c:765: undefined reference to `drm_printf'
   ld: drivers/gpu/drm/drm_buddy.c:761: undefined reference to `drm_printf'
   ld: drivers/gpu/drm/drm_buddy.o:drivers/gpu/drm/drm_buddy.c:757: more undefined references to `drm_printf' follow


vim +745 drivers/gpu/drm/drm_buddy.c

6387a3c4b0c45a Arunpravin 2022-01-18  734  
6387a3c4b0c45a Arunpravin 2022-01-18  735  /**
6387a3c4b0c45a Arunpravin 2022-01-18  736   * drm_buddy_print - print allocator state
6387a3c4b0c45a Arunpravin 2022-01-18  737   *
6387a3c4b0c45a Arunpravin 2022-01-18  738   * @mm: DRM buddy manager
6387a3c4b0c45a Arunpravin 2022-01-18  739   * @p: DRM printer to use
6387a3c4b0c45a Arunpravin 2022-01-18  740   */
6387a3c4b0c45a Arunpravin 2022-01-18  741  void drm_buddy_print(struct drm_buddy *mm, struct drm_printer *p)
6387a3c4b0c45a Arunpravin 2022-01-18  742  {
6387a3c4b0c45a Arunpravin 2022-01-18  743  	int order;
6387a3c4b0c45a Arunpravin 2022-01-18  744  
6387a3c4b0c45a Arunpravin 2022-01-18 @745  	drm_printf(p, "chunk_size: %lluKiB, total: %lluMiB, free: %lluMiB\n",
6387a3c4b0c45a Arunpravin 2022-01-18  746  		   mm->chunk_size >> 10, mm->size >> 20, mm->avail >> 20);
6387a3c4b0c45a Arunpravin 2022-01-18  747  
6387a3c4b0c45a Arunpravin 2022-01-18  748  	for (order = mm->max_order; order >= 0; order--) {
6387a3c4b0c45a Arunpravin 2022-01-18  749  		struct drm_buddy_block *block;
6387a3c4b0c45a Arunpravin 2022-01-18  750  		u64 count = 0, free;
6387a3c4b0c45a Arunpravin 2022-01-18  751  
6387a3c4b0c45a Arunpravin 2022-01-18  752  		list_for_each_entry(block, &mm->free_list[order], link) {
6387a3c4b0c45a Arunpravin 2022-01-18  753  			BUG_ON(!drm_buddy_block_is_free(block));
6387a3c4b0c45a Arunpravin 2022-01-18  754  			count++;
6387a3c4b0c45a Arunpravin 2022-01-18  755  		}
6387a3c4b0c45a Arunpravin 2022-01-18  756  
6387a3c4b0c45a Arunpravin 2022-01-18 @757  		drm_printf(p, "order-%d ", order);
6387a3c4b0c45a Arunpravin 2022-01-18  758  
6387a3c4b0c45a Arunpravin 2022-01-18  759  		free = count * (mm->chunk_size << order);
6387a3c4b0c45a Arunpravin 2022-01-18  760  		if (free < SZ_1M)
6387a3c4b0c45a Arunpravin 2022-01-18  761  			drm_printf(p, "free: %lluKiB", free >> 10);
6387a3c4b0c45a Arunpravin 2022-01-18  762  		else
6387a3c4b0c45a Arunpravin 2022-01-18  763  			drm_printf(p, "free: %lluMiB", free >> 20);
6387a3c4b0c45a Arunpravin 2022-01-18  764  
6387a3c4b0c45a Arunpravin 2022-01-18  765  		drm_printf(p, ", pages: %llu\n", count);
6387a3c4b0c45a Arunpravin 2022-01-18  766  	}
6387a3c4b0c45a Arunpravin 2022-01-18  767  }
6387a3c4b0c45a Arunpravin 2022-01-18  768  EXPORT_SYMBOL(drm_buddy_print);
6387a3c4b0c45a Arunpravin 2022-01-18  769  

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
