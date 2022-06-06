Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BB8F53DFC2
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 04:42:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352203AbiFFCmQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Jun 2022 22:42:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348097AbiFFCmH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jun 2022 22:42:07 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C71263F1;
        Sun,  5 Jun 2022 19:42:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654483327; x=1686019327;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=cYXhc1jT7ezmOoNdV3xqBIghhscJRNwdK2ONb4gnirw=;
  b=B0naBc+6ZbMqviL5/yrc3L692umRmeN5LxBuv8E9ZgpUjp0rKpvxsRyr
   5/1dj61OjfuX9rs0/eDY5UHwBK9b2i5BaNNKNkDWipc35MDUFdoA9t9vm
   +8ea8NmyOJOz9UgBSOICulmh1XwgMxKSWQtLEuwTDgOXrnpxgW8ebgMtz
   V9wWn7nVCsHFMjJRonKdp2FtovJej9u8+PcRmhytbsKh7yQ+XZSd16A+G
   eKvHb1pqtVlnDYPECZL3TnWObqHHqNGbsbQGsZn+7mC2R8MUuqqkUpJO0
   rrtKOBVja96hs/l+89/KVWcHqle7YRE6YSzjmUZQB573239SQjDspWfeH
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10369"; a="276653896"
X-IronPort-AV: E=Sophos;i="5.91,280,1647327600"; 
   d="scan'208";a="276653896"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2022 19:42:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,280,1647327600"; 
   d="scan'208";a="669265976"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 05 Jun 2022 19:42:04 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1ny2gt-000CQa-PU;
        Mon, 06 Jun 2022 02:42:03 +0000
Date:   Mon, 6 Jun 2022 10:41:24 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jean-Jacques Hiblot <jjhiblot@traphandler.com>, pavel@ucw.cz,
        krzk+dt@kernel.org
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org, robh+dt@kernel.org,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jean-Jacques Hiblot <jjhiblot@traphandler.com>
Subject: Re: [PATCH v2 2/3] leds: Add driver for the TLC5925 LED controller
Message-ID: <202206060923.vYFzGndu-lkp@intel.com>
References: <20220603155332.112272-3-jjhiblot@traphandler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220603155332.112272-3-jjhiblot@traphandler.com>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jean-Jacques,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on pavel-leds/for-next]
[also build test WARNING on v5.18 next-20220603]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Jean-Jacques-Hiblot/Add-support-for-the-TLC5925/20220605-235250
base:   git://git.kernel.org/pub/scm/linux/kernel/git/pavel/linux-leds.git for-next
config: arm64-allyesconfig (https://download.01.org/0day-ci/archive/20220606/202206060923.vYFzGndu-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 416a5080d89066029f9889dc23f94de47c2fa895)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm64 cross compiling tool for clang build
        # apt-get install binutils-aarch64-linux-gnu
        # https://github.com/intel-lab-lkp/linux/commit/e8ae916efd705311a0bdeb2a8f9a1649174867be
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Jean-Jacques-Hiblot/Add-support-for-the-TLC5925/20220605-235250
        git checkout e8ae916efd705311a0bdeb2a8f9a1649174867be
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash drivers/leds/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/leds/leds-tlc5925.c:144:35: warning: unused variable 'tlc5925_id' [-Wunused-const-variable]
   static const struct spi_device_id tlc5925_id[] = {
                                     ^
   1 warning generated.


vim +/tlc5925_id +144 drivers/leds/leds-tlc5925.c

   143	
 > 144	static const struct spi_device_id tlc5925_id[] = {
   145		{"tlc5925", 0},
   146		{}
   147	};
   148	MODULE_DEVICE_TABLE(spi, tlc5925_id);
   149	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
