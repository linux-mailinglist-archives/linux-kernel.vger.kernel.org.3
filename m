Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D690A58B008
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 20:50:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241184AbiHESuk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 14:50:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240890AbiHESud (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 14:50:33 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C3951EACA;
        Fri,  5 Aug 2022 11:50:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659725432; x=1691261432;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ENJPNo+mS2vVgVFpAyn8Gp1tJVNvhEDTmG7q+6S3Ib8=;
  b=cHoZ7rPgMCeZbqUfDxNOfwUIsp8AAGRH2ZbDyz/KTluLlAwWV1bsZ+c0
   xT+amQz/FyhM/OGzQH72Di6OGUnMtY1R5zN7xFRfQ+luUTDVd9Wj3N68e
   sOtDtvb2JFt6NF2165O5XzgKG8CZCyJiATgU9WbPPg7TVs2J8UAvVKOm/
   oQ6U18POaTZWEB1sm4+eTfawvAasMisMTbReZSpbJAfirHQefZq/pNYw4
   1zRTWOE/3FimLkmPr0BlKKSIb94XClT559FGviMvgqBIArt8Jx5W42bO/
   h3hBz8JggExr0WpHZS3YQXTUsx1OKZIPPHYr2WWzZrBwSczhmLZ3pukyp
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10430"; a="289024199"
X-IronPort-AV: E=Sophos;i="5.93,216,1654585200"; 
   d="scan'208";a="289024199"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2022 11:50:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,216,1654585200"; 
   d="scan'208";a="579596290"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 05 Aug 2022 11:50:29 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oK2Oz-000JeB-0v;
        Fri, 05 Aug 2022 18:50:29 +0000
Date:   Sat, 6 Aug 2022 02:50:01 +0800
From:   kernel test robot <lkp@intel.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>, rafael@kernel.org
Cc:     kbuild-all@lists.01.org, rui.zhang@intel.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Amit Kucheria <amitk@kernel.org>
Subject: Re: [PATCH v1 26/26] thermal/drivers/intel: Use generic
 thermal_zone_get_trip() function
Message-ID: <202208060216.XOxVJyCy-lkp@intel.com>
References: <20220805145729.2491611-27-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220805145729.2491611-27-daniel.lezcano@linaro.org>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

I love your patch! Yet something to improve:

[auto build test ERROR on next-20220804]
[cannot apply to rafael-pm/thermal tegra/for-next linus/master v5.19 v5.19-rc8 v5.19-rc7 v5.19]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Daniel-Lezcano/Rework-the-trip-points-creation/20220805-230055
base:    899926f2ccb4453c51943f6738a71b2c5ad98b71
config: i386-defconfig (https://download.01.org/0day-ci/archive/20220806/202208060216.XOxVJyCy-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/134d3142f385a8d7212933db3eae29466faf5cab
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Daniel-Lezcano/Rework-the-trip-points-creation/20220805-230055
        git checkout 134d3142f385a8d7212933db3eae29466faf5cab
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: "thermal_zone_device_register_with_trips" [drivers/thermal/intel/x86_pkg_temp_thermal.ko] undefined!

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
