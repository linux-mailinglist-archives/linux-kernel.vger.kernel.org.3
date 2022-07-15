Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 242FF5758A5
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 02:34:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232302AbiGOAeA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 20:34:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbiGOAd4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 20:33:56 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD5AF2A25B;
        Thu, 14 Jul 2022 17:33:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657845235; x=1689381235;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=LmHXyKnAKMH9F3nbUsgv39wMlBgdj3qLzQZyWOGkDDQ=;
  b=ROyMxVnt20NI0QmWJp+IJc9+xQ2F+Te9AsGEfWivYeqIsFkYXpQDYwGB
   KmW0XYmpZODqPOCoM/KFD7madDBwBGpm74gZrvqtNrDC4ofRY5BpUUMbA
   DfAhA6mm07jUV7jVpfVYsLKyZz4g0FvJYGhNLXtd1Wo1MEe2hdvfrETWD
   il56kUDQ3lCJbK807CPbalF1KuE2TpkAixfN2oKc0opBE3Xtr+veSdyQV
   3fibeCxDbiFspQUjLt90NFETmH+Hg/254yE1sqkeGdLBkp4MDNG6dE/Qn
   3k6gA3kvJRue4VtBOZU/G3CCrRlH1sQk9kFXmtLkhu5H2c+FqoGJFMCEr
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10408"; a="311326656"
X-IronPort-AV: E=Sophos;i="5.92,272,1650956400"; 
   d="scan'208";a="311326656"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2022 17:33:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,272,1650956400"; 
   d="scan'208";a="546470039"
Received: from lkp-server01.sh.intel.com (HELO fd2c14d642b4) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 14 Jul 2022 17:33:52 -0700
Received: from kbuild by fd2c14d642b4 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1oC9HE-0001JL-2q;
        Fri, 15 Jul 2022 00:33:52 +0000
Date:   Fri, 15 Jul 2022 08:33:14 +0800
From:   kernel test robot <lkp@intel.com>
To:     Benjamin Bara <bbara93@gmail.com>, dmitry.torokhov@gmail.com
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Benjamin Bara <benjamin.bara@skidata.com>,
        Richard Leitner <richard.leitner@skidata.com>
Subject: Re: [PATCH] Input: tsc2007 - enable GPIO chips that can sleep
Message-ID: <202207150807.PrPXLs2u-lkp@intel.com>
References: <20220713084247.3090353-1-bbara93@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220713084247.3090353-1-bbara93@gmail.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Benjamin,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on dtor-input/next]
[also build test WARNING on hid/for-next linus/master v5.19-rc6 next-20220714]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Benjamin-Bara/Input-tsc2007-enable-GPIO-chips-that-can-sleep/20220713-164521
base:   https://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git next
config: riscv-randconfig-r003-20220714 (https://download.01.org/0day-ci/archive/20220715/202207150807.PrPXLs2u-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 5e61b9c556267086ef9b743a0b57df302eef831b)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install riscv cross compiling tool for clang build
        # apt-get install binutils-riscv64-linux-gnu
        # https://github.com/intel-lab-lkp/linux/commit/13455f523263c4e90b5cc8c587ef2be97008ff5f
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Benjamin-Bara/Input-tsc2007-enable-GPIO-chips-that-can-sleep/20220713-164521
        git checkout 13455f523263c4e90b5cc8c587ef2be97008ff5f
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash drivers/gpu/drm/amd/display/amdgpu_dm/ drivers/input/touchscreen/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/input/touchscreen/tsc2007_core.c:112:6: warning: no previous prototype for function 'tsc2007_is_pen_down_cansleep' [-Wmissing-prototypes]
   bool tsc2007_is_pen_down_cansleep(struct tsc2007 *ts)
        ^
   drivers/input/touchscreen/tsc2007_core.c:112:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   bool tsc2007_is_pen_down_cansleep(struct tsc2007 *ts)
   ^
   static 
   1 warning generated.


vim +/tsc2007_is_pen_down_cansleep +112 drivers/input/touchscreen/tsc2007_core.c

   111	
 > 112	bool tsc2007_is_pen_down_cansleep(struct tsc2007 *ts)
   113	{
   114		if (!ts->get_pendown_state_cansleep)
   115			return true;
   116	
   117		return ts->get_pendown_state_cansleep(&ts->client->dev);
   118	}
   119	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
