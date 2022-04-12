Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC4034FDED0
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 13:58:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345321AbiDLL7j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 07:59:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345816AbiDLL44 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 07:56:56 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7764160CF6;
        Tue, 12 Apr 2022 03:42:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649760130; x=1681296130;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=zpueg+jyVnMsOFoZwW8zB/OcFNbXOpiTPlELbqYLlwc=;
  b=nW6qxJeyxnEknF1riWv3R253BFhnRrlq+239kG5dMahU2qu7UONHYzmy
   GSJ79WfPqKFJ6gZq8+nwNsNAf5WOIxVX58lZ5a2sSZkUyZ2PVITslZock
   mbiUmH7hFDScrJCKPEl6O4291+x9GRRiwkUvnKKoudpKIHvqGvEO8l/jL
   NmKCYtF52/PeMB01ynydkvljE/dTtPN9Jp6gb+iii1oFfMDadpkTZWbYy
   OkW+VLllaT8YUVI5B7GfoYXKDHPghnSaHwkNUUAJXELPIq2D7TstOY+RT
   za8xdZw6/HmjJe0oTuWQI6M8NGTc8dlveZBdeYtV3zdkxHxndlPOVa6cd
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10314"; a="261192960"
X-IronPort-AV: E=Sophos;i="5.90,253,1643702400"; 
   d="scan'208";a="261192960"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2022 03:42:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,253,1643702400"; 
   d="scan'208";a="660438063"
Received: from lkp-server02.sh.intel.com (HELO d3fc50ef50de) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 12 Apr 2022 03:42:07 -0700
Received: from kbuild by d3fc50ef50de with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1neDyJ-0002m8-8p;
        Tue, 12 Apr 2022 10:42:07 +0000
Date:   Tue, 12 Apr 2022 18:41:24 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jagath Jog J <jagathjog1996@gmail.com>, dan@dlrobertson.com,
        jic23@kernel.org, andy.shevchenko@gmail.com
Cc:     kbuild-all@lists.01.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 9/9] iio: accel: bma400: Add support for activity and
 inactivity events
Message-ID: <202204121837.e1RdwIqu-lkp@intel.com>
References: <20220411203133.19929-10-jagathjog1996@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220411203133.19929-10-jagathjog1996@gmail.com>
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

Hi Jagath,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on jic23-iio/togreg]
[also build test ERROR on v5.18-rc2 next-20220412]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Jagath-Jog-J/iio-accel-bma400-Add-buffer-step-and-activity-inactivity/20220412-043436
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git togreg
config: mips-allmodconfig (https://download.01.org/0day-ci/archive/20220412/202204121837.e1RdwIqu-lkp@intel.com/config)
compiler: mips-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/15ee6de45ed7a028569638c198e170bb98cef4ab
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Jagath-Jog-J/iio-accel-bma400-Add-buffer-step-and-activity-inactivity/20220412-043436
        git checkout 15ee6de45ed7a028569638c198e170bb98cef4ab
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=mips SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: "__cmpxchg_small" [drivers/iio/accel/bma400_core.ko] undefined!

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
