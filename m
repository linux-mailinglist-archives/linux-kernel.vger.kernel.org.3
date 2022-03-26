Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A3C24E7E20
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Mar 2022 01:27:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229497AbiCZA3S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 20:29:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbiCZA3Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 20:29:16 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C3114133D
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 17:27:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648254462; x=1679790462;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=T9WKzF5uUODZK1coRF8zoA8Nl6WzVRin2ZfvLu8VrnM=;
  b=Y8sGy97Y83MEz5WSLVs/p9DtEaK3PrAVM+5o7jnu+vH0qdn/c8ljCmtP
   I91f5lB0ohHwhwTn4VWpZvqNo7X4x33PUnv00OOyhKSL5mSWZYyRBlipl
   gqlsMaPHmkUA24K+6s+WRmdHp1oZkSqIpNJt6H1nsEhaYdazY1g7SIS9V
   LNQqfIOkKIXmGA0rW6njY3tJv7VS58vMRRwv0oxXYQkw23ufY89PRH7Cw
   SMnPvS6tKPywgup9wNIgAsJO/KReZaT3m9mV53IKuisrv2TyZIMSrNLIx
   RMoh5f5vt+54BwZbDLvr/iGU6TuyORRtbCNXol++XAYvP5RK4BklFXCIl
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10297"; a="239341786"
X-IronPort-AV: E=Sophos;i="5.90,211,1643702400"; 
   d="scan'208";a="239341786"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2022 17:27:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,211,1643702400"; 
   d="scan'208";a="584632109"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 25 Mar 2022 17:27:38 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nXuHJ-000Mn3-E7; Sat, 26 Mar 2022 00:27:37 +0000
Date:   Sat, 26 Mar 2022 08:27:17 +0800
From:   kernel test robot <lkp@intel.com>
To:     Zhi Wang <zhi.wang.linux@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        intel-gfx@lists.freedesktop.org,
        intel-gvt-dev@lists.freedesktop.org
Cc:     kbuild-all@lists.01.org, Zhi Wang <zhi.a.wang@gmail.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Vivi Rodrigo <rodrigo.vivi@intel.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v7 1/3] i915/gvt: Separate the MMIO tracking table from
 GVT-g
Message-ID: <202203260844.V9HDSROY-lkp@intel.com>
References: <20220325175251.167164-1-zhi.a.wang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220325175251.167164-1-zhi.a.wang@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Zhi,

I love your patch! Perhaps something to improve:

[auto build test WARNING on drm-intel/for-linux-next]
[also build test WARNING on drm-tip/drm-tip drm/drm-next next-20220325]
[cannot apply to tegra-drm/drm/tegra/for-next airlied/drm-next v5.17]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Zhi-Wang/i915-gvt-Separate-the-MMIO-tracking-table-from-GVT-g/20220326-015627
base:   git://anongit.freedesktop.org/drm-intel for-linux-next
config: x86_64-randconfig-a011 (https://download.01.org/0day-ci/archive/20220326/202203260844.V9HDSROY-lkp@intel.com/config)
compiler: gcc-9 (Ubuntu 9.4.0-1ubuntu1~20.04.1) 9.4.0
reproduce (this is a W=1 build):
        # https://github.com/0day-ci/linux/commit/8203f91121efdcc910bde0bc4fe5ea678bdaaa5b
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Zhi-Wang/i915-gvt-Separate-the-MMIO-tracking-table-from-GVT-g/20220326-015627
        git checkout 8203f91121efdcc910bde0bc4fe5ea678bdaaa5b
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/gpu/drm/i915/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/gpu/drm/i915/gvt/handlers.c:74:6: warning: no previous prototype for 'intel_gvt_match_device' [-Wmissing-prototypes]
      74 | bool intel_gvt_match_device(struct intel_gvt *gvt,
         |      ^~~~~~~~~~~~~~~~~~~~~~


vim +/intel_gvt_match_device +74 drivers/gpu/drm/i915/gvt/handlers.c

12d14cc43b34706 Zhi Wang 2016-08-30  73  
12d14cc43b34706 Zhi Wang 2016-08-30 @74  bool intel_gvt_match_device(struct intel_gvt *gvt,
12d14cc43b34706 Zhi Wang 2016-08-30  75  		unsigned long device)
12d14cc43b34706 Zhi Wang 2016-08-30  76  {
12d14cc43b34706 Zhi Wang 2016-08-30  77  	return intel_gvt_get_device_type(gvt) & device;
12d14cc43b34706 Zhi Wang 2016-08-30  78  }
12d14cc43b34706 Zhi Wang 2016-08-30  79  

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
