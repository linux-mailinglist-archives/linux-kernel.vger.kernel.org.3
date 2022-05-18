Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C976352BC86
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 16:16:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238513AbiERMrS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 08:47:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237191AbiERMpt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 08:45:49 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92065E02;
        Wed, 18 May 2022 05:42:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652877731; x=1684413731;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=g12NRS8alSxAMdjIZ7FyL80YifoKRkRmio1kwZZ1BfQ=;
  b=BfbxW1gcSO24QVRvo6ssEedhk1lu9c77zNq8gfdaTQaftojY2dtHhTg5
   IaqToqJnFaI/aQDUiEt8GqiWXx9zF8a86UN8P0+bY066Scx8rAAO11bIn
   Ql0EngWZneimo9rfH5MwestFV48oHE6ZbXmJLP9PfVFCX6LKDPfuESc4Z
   wNJnP3eaB9k5Qt5DQ6TlMmtccHFvztTs7ZLNAMgPzQwZKdzEIQcXTos2+
   RHPIR8s7ElhyoNuoeVldnab9W7OFaI7XbeOnvrysotcqJ2LUVCz1lpkca
   r5lkKcVsU4xgaNbr/UFj64e1RCQ6/aW93cLhu0iioE3hrC7BntSAaIe1D
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10350"; a="332270387"
X-IronPort-AV: E=Sophos;i="5.91,234,1647327600"; 
   d="scan'208";a="332270387"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2022 05:41:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,234,1647327600"; 
   d="scan'208";a="639243416"
Received: from lkp-server02.sh.intel.com (HELO 242b25809ac7) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 18 May 2022 05:41:33 -0700
Received: from kbuild by 242b25809ac7 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nrIzd-0002BR-4H;
        Wed, 18 May 2022 12:41:33 +0000
Date:   Wed, 18 May 2022 20:40:33 +0800
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
Message-ID: <202205182059.6QY3zspw-lkp@intel.com>
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

Thank you for the patch! Yet something to improve:

[auto build test ERROR on device-mapper-dm/for-next]
[also build test ERROR on song-md/md-next kees/for-next/pstore linus/master v5.18-rc7 next-20220517]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Matthias-Kaehlcke/LoadPin-Enable-loading-from-trusted-dm-verity-devices/20220518-073635
base:   https://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git for-next
config: m68k-allmodconfig (https://download.01.org/0day-ci/archive/20220518/202205182059.6QY3zspw-lkp@intel.com/config)
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
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=m68k SHELL=/bin/bash security/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from security/loadpin/loadpin.c:21:
>> include/linux/dm-verity-loadpin.h:22:1: error: expected identifier or '(' before '{' token
      22 | {
         | ^
   include/linux/dm-verity-loadpin.h:21:20: warning: 'dm_verity_loadpin_is_sb_trusted' used but never defined
      21 | static inline bool dm_verity_loadpin_is_sb_trusted(struct super_block *sb);
         |                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +22 include/linux/dm-verity-loadpin.h

afd03270f57b8c Matthias Kaehlcke 2022-05-17  17  
afd03270f57b8c Matthias Kaehlcke 2022-05-17  18  #if IS_ENABLED(CONFIG_SECURITY_LOADPIN) && IS_BUILTIN(CONFIG_DM_VERITY)
afd03270f57b8c Matthias Kaehlcke 2022-05-17  19  bool dm_verity_loadpin_is_sb_trusted(struct super_block *sb);
afd03270f57b8c Matthias Kaehlcke 2022-05-17  20  #else
afd03270f57b8c Matthias Kaehlcke 2022-05-17  21  static inline bool dm_verity_loadpin_is_sb_trusted(struct super_block *sb);
afd03270f57b8c Matthias Kaehlcke 2022-05-17 @22  {
afd03270f57b8c Matthias Kaehlcke 2022-05-17  23  	return false;
afd03270f57b8c Matthias Kaehlcke 2022-05-17  24  }
afd03270f57b8c Matthias Kaehlcke 2022-05-17  25  #endif
afd03270f57b8c Matthias Kaehlcke 2022-05-17  26  

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
