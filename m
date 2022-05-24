Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BA0E532113
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 04:41:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232838AbiEXClN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 22:41:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233382AbiEXClG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 22:41:06 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F341FB46;
        Mon, 23 May 2022 19:41:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653360063; x=1684896063;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=lTs7Zyfz3kf22iAirsP5H5EozMNgDf/N+TMetMeGLo0=;
  b=mkQcv3U6vi6UJWMyrA4IqlKlBiWrvpMiki3UKKJBIuw/3vD+1HaVw+/e
   Zm+mJjkb6GaXRdry4ar9xw0imYxSrExfX3s/rh6Emd5NxOxexrp/4oQIS
   f1S4JXUruPZ4zijZlkPRNJI24I977tj/PpyDXqi9hpzm3TMXAkL3DAu5u
   H9RW6sQzIN4mN42Sni5aPyTCCQMxkU0sOdavwqWLtGEH8XCOhCPSFQmkS
   i4tEnJ6T4QsWZkah+GEFQnByWf/EPMJhlFNd4c6HMpkA0L4c0bieD35ag
   14A44gMCen0A8jVclK05XKwLP6LJeUxzJT26L3fEoDm3q+Ptw7HsucoaO
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10356"; a="336467709"
X-IronPort-AV: E=Sophos;i="5.91,247,1647327600"; 
   d="scan'208";a="336467709"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2022 19:41:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,247,1647327600"; 
   d="scan'208";a="629681386"
Received: from lkp-server01.sh.intel.com (HELO db63a1be7222) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 23 May 2022 19:40:59 -0700
Received: from kbuild by db63a1be7222 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1ntKTi-0001eu-Jk;
        Tue, 24 May 2022 02:40:58 +0000
Date:   Tue, 24 May 2022 10:40:50 +0800
From:   kernel test robot <lkp@intel.com>
To:     Pankaj Raghav <p.raghav@samsung.com>, axboe@kernel.dk, hch@lst.de,
        snitzer@redhat.com, damien.lemoal@opensource.wdc.com, hare@suse.de,
        Johannes.Thumshirn@wdc.com
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-nvme@lists.infradead.org, dm-devel@redhat.com,
        dsterba@suse.com, jiangbo.365@bytedance.com,
        linux-kernel@vger.kernel.org, gost.dev@samsung.com,
        linux-block@vger.kernel.org, jaegeuk@kernel.org,
        Pankaj Raghav <p.raghav@samsung.com>,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: Re: [PATCH v5 5/7] null_blk: allow non power of 2 zoned devices
Message-ID: <202205241034.izkLMTcH-lkp@intel.com>
References: <20220523161601.58078-6-p.raghav@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220523161601.58078-6-p.raghav@samsung.com>
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pankaj,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on axboe-block/for-next]
[also build test ERROR on device-mapper-dm/for-next linus/master hch-configfs/for-next v5.18 next-20220523]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Pankaj-Raghav/block-make-blkdev_nr_zones-and-blk_queue_zone_no-generic-for-npo2-zsze/20220524-011616
base:   https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git for-next
config: hexagon-randconfig-r045-20220523 (https://download.01.org/0day-ci/archive/20220524/202205241034.izkLMTcH-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 10c9ecce9f6096e18222a331c5e7d085bd813f75)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/3d3c81da0adbd40eb0d2125327b7e227582b2a37
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Pankaj-Raghav/block-make-blkdev_nr_zones-and-blk_queue_zone_no-generic-for-npo2-zsze/20220524-011616
        git checkout 3d3c81da0adbd40eb0d2125327b7e227582b2a37
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: "__hexagon_umoddi3" [drivers/block/null_blk/null_blk.ko] undefined!

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
