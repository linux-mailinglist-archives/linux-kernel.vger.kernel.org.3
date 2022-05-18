Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9B7E52B57F
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 11:01:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233709AbiERI6z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 04:58:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233688AbiERI6x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 04:58:53 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9025D13CA3B;
        Wed, 18 May 2022 01:58:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652864327; x=1684400327;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xR5ju/m+J7LrQ2NG96ZPR+tRwF+afBBK3BjNI5wn7n4=;
  b=keH05FyVsuyBYS/g6Lkp6aZWjz8B0/3do5lA8Ha86hH7s0YZIYyU9u0A
   LyjXqRwwzsz6/NVxB9ftqmwzB8egsIXGGfKY2czvH3u7p7E/z7A9aRu5J
   FSsr3SKX9Qj4lHscOnAidR+SrC+pu6Pe7Or0TEXTS4sDpjnjs9msXos2T
   EabAnVZ8ppm2rvzZVcqwfBlY7Sf7Onejazh3bJloGh5vq9VPZEZKgVpHY
   KMOkKjtXOc9BXJkadKOskHg7deWL6tHkF8luGlZ2wK2UqgJegoIFFrhDc
   xFK7IYuch6ZnqBxpEeyOoCoXSW4PiMGx6B7vBknqxcQYC9w+PLtOvBIOE
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10350"; a="334615033"
X-IronPort-AV: E=Sophos;i="5.91,234,1647327600"; 
   d="scan'208";a="334615033"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2022 01:58:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,234,1647327600"; 
   d="scan'208";a="605789798"
Received: from lkp-server02.sh.intel.com (HELO 242b25809ac7) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 18 May 2022 01:58:25 -0700
Received: from kbuild by 242b25809ac7 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nrFVh-0001zV-1B;
        Wed, 18 May 2022 08:58:25 +0000
Date:   Wed, 18 May 2022 16:58:06 +0800
From:   kernel test robot <lkp@intel.com>
To:     Matthias Kaehlcke <mka@chromium.org>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>
Cc:     kbuild-all@lists.01.org, linux-security-module@vger.kernel.org,
        dm-devel@redhat.com, linux-kernel@vger.kernel.org,
        linux-raid@vger.kernel.org, Song Liu <song@kernel.org>,
        Douglas Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>
Subject: Re: [PATCH v4 2/3] LoadPin: Enable loading from trusted dm-verity
 devices
Message-ID: <202205181616.3eTP2DaC-lkp@intel.com>
References: <20220517163437.v4.2.I01c67af41d2f6525c6d023101671d7339a9bc8b5@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220517163437.v4.2.I01c67af41d2f6525c6d023101671d7339a9bc8b5@changeid>
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matthias,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on device-mapper-dm/for-next]
[also build test WARNING on song-md/md-next kees/for-next/pstore linus/master v5.18-rc7 next-20220517]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Matthias-Kaehlcke/LoadPin-Enable-loading-from-trusted-dm-verity-devices/20220518-073635
base:   https://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git for-next
config: m68k-allmodconfig (https://download.01.org/0day-ci/archive/20220518/202205181616.3eTP2DaC-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/755e5d82e4d054b2b58a54c94681080cc8cb4582
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Matthias-Kaehlcke/LoadPin-Enable-loading-from-trusted-dm-verity-devices/20220518-073635
        git checkout 755e5d82e4d054b2b58a54c94681080cc8cb4582
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=m68k SHELL=/bin/bash security/loadpin/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from security/loadpin/loadpin.c:21:
   include/linux/dm-verity-loadpin.h:22:1: error: expected identifier or '(' before '{' token
      22 | {
         | ^
>> include/linux/dm-verity-loadpin.h:21:20: warning: 'dm_verity_loadpin_is_sb_trusted' used but never defined
      21 | static inline bool dm_verity_loadpin_is_sb_trusted(struct super_block *sb);
         |                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +/dm_verity_loadpin_is_sb_trusted +21 include/linux/dm-verity-loadpin.h

afd03270f57b8c Matthias Kaehlcke 2022-05-17  17  
afd03270f57b8c Matthias Kaehlcke 2022-05-17  18  #if IS_ENABLED(CONFIG_SECURITY_LOADPIN) && IS_BUILTIN(CONFIG_DM_VERITY)
afd03270f57b8c Matthias Kaehlcke 2022-05-17  19  bool dm_verity_loadpin_is_sb_trusted(struct super_block *sb);
afd03270f57b8c Matthias Kaehlcke 2022-05-17  20  #else
afd03270f57b8c Matthias Kaehlcke 2022-05-17 @21  static inline bool dm_verity_loadpin_is_sb_trusted(struct super_block *sb);
afd03270f57b8c Matthias Kaehlcke 2022-05-17 @22  {
afd03270f57b8c Matthias Kaehlcke 2022-05-17  23  	return false;
afd03270f57b8c Matthias Kaehlcke 2022-05-17  24  }
afd03270f57b8c Matthias Kaehlcke 2022-05-17  25  #endif
afd03270f57b8c Matthias Kaehlcke 2022-05-17  26  

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
