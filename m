Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CC9B529AA3
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 09:17:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235882AbiEQHRU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 03:17:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230227AbiEQHRP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 03:17:15 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4076C3617F;
        Tue, 17 May 2022 00:17:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652771834; x=1684307834;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=1jTU5KHo259xMf0l/RnxXGGu/AAe/sE0TQK8+z7eBQc=;
  b=OiF2LfvUqDZvAEp6veTlqxRWapyysRPBGWw0FwA5gfOXo6MBCrgoCsvx
   kQRhyL1GfmIil3EwWPADuqU9kBuqbrvkctb8Aq3YTClfDKuj4p6x3yIpP
   cwL6dRLNGWwsWnqjdoidRUjgVk1Mgui7voWn9hOyXNhD3+VHT6AE7Y3rr
   N6BJBW3LKp6K0nmitHqOtT6R3zahc8xWsnbnPIHlxNdUelFkjW8q81QZd
   TVo9oDhlH+9P5HAw166xwuI+KKo00/TiZc/FbE2R6MZioiTM8Atq+eU0p
   +1Q4majp+/8JP31cVkp6l4V5NzXoDEGnex6vCzKwhBwO3m663ETjvYz27
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10349"; a="357502518"
X-IronPort-AV: E=Sophos;i="5.91,232,1647327600"; 
   d="scan'208";a="357502518"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2022 00:17:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,232,1647327600"; 
   d="scan'208";a="638621112"
Received: from lkp-server02.sh.intel.com (HELO 242b25809ac7) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 17 May 2022 00:17:11 -0700
Received: from kbuild by 242b25809ac7 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nqrSB-0000iV-8K;
        Tue, 17 May 2022 07:17:11 +0000
Date:   Tue, 17 May 2022 15:16:28 +0800
From:   kernel test robot <lkp@intel.com>
To:     =?iso-8859-1?Q?Jos=E9_Exp=F3sito?= <jose.exposito89@gmail.com>,
        jikos@kernel.org
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        benjamin.tissoires@redhat.com, spbnick@gmail.com,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        stefanberzl@gmail.com,
        =?iso-8859-1?Q?Jos=E9_Exp=F3sito?= <jose.exposito89@gmail.com>
Subject: Re: [PATCH for-5.19/uclogic 2/4] HID: uclogic: Add KUnit tests for
 uclogic_rdesc_template_apply()
Message-ID: <202205171527.RQ8sqqya-lkp@intel.com>
References: <20220516181323.59554-3-jose.exposito89@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220516181323.59554-3-jose.exposito89@gmail.com>
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi "José,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on f7d8e387d9aeff963e6691c0166269b8042b4ff9]

url:    https://github.com/intel-lab-lkp/linux/commits/Jos-Exp-sito/Add-support-for-XP-PEN-Deco-L/20220517-021641
base:   f7d8e387d9aeff963e6691c0166269b8042b4ff9
config: riscv-randconfig-r036-20220516 (https://download.01.org/0day-ci/archive/20220517/202205171527.RQ8sqqya-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 853fa8ee225edf2d0de94b0dcbd31bea916e825e)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install riscv cross compiling tool for clang build
        # apt-get install binutils-riscv64-linux-gnu
        # https://github.com/intel-lab-lkp/linux/commit/59e13d6c9ab96d326e1575bd6cd2f0ca0c98f561
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Jos-Exp-sito/Add-support-for-XP-PEN-Deco-L/20220517-021641
        git checkout 59e13d6c9ab96d326e1575bd6cd2f0ca0c98f561
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>, old ones prefixed by <<):

ERROR: modpost: missing MODULE_LICENSE() in drivers/hid/hid-uclogic-rdesc.o
ERROR: modpost: missing MODULE_LICENSE() in drivers/hid/hid-uclogic-rdesc-test.o
>> ERROR: modpost: "uclogic_rdesc_template_apply" [drivers/hid/hid-uclogic-rdesc-test.ko] undefined!

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
