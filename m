Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99C6A4AC2A7
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 16:12:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442874AbiBGPKL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 10:10:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442174AbiBGOrf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 09:47:35 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F2F6C03FEC8
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 06:47:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644245254; x=1675781254;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=NFLLMgHFBwJhXlvHAadZYGDnNUvR3br8H3+mEqUjtmU=;
  b=letVqL7r5qDZWN5FA2kSPQjtJ609ua40T6/6oSIeVldElGad1PyThpTd
   oin7uWk6HlLXO/aM5dKdP+EVk3txPdYIqAtLDaazJGjavAmsynO4w69Yv
   bFBFfHzXlnjvjWV82QDjwo4ihQeZ/jQH46OtAE7Xy5duegwkHAjEgEGQV
   du8IWPlc5kTKsLohMyZbgQCly2ylJQL4LQYY3Nx7lW84BI9eKciUDL5CN
   vCxebE8vcjAG5FSvribO9dA8G7BmgcI4J25PVGcXY+GYGUFV5cdBs/Zfc
   7B96qZ3K9Yqs+rmVpf5dcozyIbiPMh3BdsMCBwlFD1Dh+UcmnjJ0BsagG
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10250"; a="247564159"
X-IronPort-AV: E=Sophos;i="5.88,350,1635231600"; 
   d="scan'208";a="247564159"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2022 06:47:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,350,1635231600"; 
   d="scan'208";a="677776693"
Received: from lkp-server01.sh.intel.com (HELO 9dd77a123018) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 07 Feb 2022 06:47:32 -0800
Received: from kbuild by 9dd77a123018 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nH5Ih-0000d5-KG; Mon, 07 Feb 2022 14:47:31 +0000
Date:   Mon, 7 Feb 2022 22:47:25 +0800
From:   kernel test robot <lkp@intel.com>
To:     Zhi Wang <zhi.wang.linux@gmail.com>, hch@lst.de, jgg@nvidia.com,
        jani.nikula@linux.intel.com
Cc:     kbuild-all@lists.01.org, Zhi Wang <zhi.wang.linux@gmail.com>,
        intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        Terrence Xu <terrence.xu@intel.com>,
        intel-gvt-dev@lists.freedesktop.org
Subject: Re: [Intel-gfx] [PATCH 1/3] i915/gvt: Introduce the mmio_table.c to
 support VFIO new mdev API
Message-ID: <202202072226.kzm2Qm5q-lkp@intel.com>
References: <20220127120508.11330-1-zhi.a.wang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220127120508.11330-1-zhi.a.wang@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

[auto build test WARNING on drm-tip/drm-tip]
[also build test WARNING on next-20220207]
[cannot apply to drm-intel/for-linux-next hch-configfs/for-next v5.17-rc3]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Zhi-Wang/i915-gvt-Introduce-the-mmio_table-c-to-support-VFIO-new-mdev-API/20220127-200727
base:   git://anongit.freedesktop.org/drm/drm-tip drm-tip
config: x86_64-rhel-8.3-kselftests (https://download.01.org/0day-ci/archive/20220207/202202072226.kzm2Qm5q-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://github.com/0day-ci/linux/commit/533f92651a7a56481a053f1e04dc5a5ec024ffb9
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Zhi-Wang/i915-gvt-Introduce-the-mmio_table-c-to-support-VFIO-new-mdev-API/20220127-200727
        git checkout 533f92651a7a56481a053f1e04dc5a5ec024ffb9
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/gpu/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> drivers/gpu/drm/i915/gvt/handlers.c:45:6: sparse: sparse: symbol 'intel_gvt_match_device' was not declared. Should it be static?

vim +/intel_gvt_match_device +45 drivers/gpu/drm/i915/gvt/handlers.c

12d14cc43b3470 Zhi Wang 2016-08-30  44  
12d14cc43b3470 Zhi Wang 2016-08-30 @45  bool intel_gvt_match_device(struct intel_gvt *gvt,
12d14cc43b3470 Zhi Wang 2016-08-30  46  		unsigned long device)
12d14cc43b3470 Zhi Wang 2016-08-30  47  {
533f92651a7a56 Zhi Wang 2022-01-27  48  	return intel_gvt_get_device_type(gvt->gt->i915) & device;
12d14cc43b3470 Zhi Wang 2016-08-30  49  }
12d14cc43b3470 Zhi Wang 2016-08-30  50  

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
