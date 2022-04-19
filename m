Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7673D50634E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 06:35:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348269AbiDSEgN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 00:36:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347682AbiDSEgJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 00:36:09 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4017A2AC52;
        Mon, 18 Apr 2022 21:33:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650342808; x=1681878808;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=CmAcx2mBYxodDrmyuE8qbdUsmHTXfHUYcAr60iRLHG0=;
  b=djvAzRv81GYtm7LH4vcn9x5eLD0SX/250MKV48SLdrwVCU7XmB/cxWR3
   1NMMbVB47N8Ev8qDxeGiG7/t6/or1I/iHVuwsF1mwsBaggfjOHpxzpdJl
   3lN+0cSjBTCsJuYMPTnAYphQUgGE9DOHoR/Htij7IJYzzSRRI1ipSMW6i
   YGzMUX1k22XQyUkE/GGM4uqntJ/EKrFu/kvAkSqaUl26jQtgQfoEMlpJJ
   7yFjivMNOKRJ2+Sc5lVrdr01KwwPfPS+GXT2QlJOE3TNrYqstuGGoIgmT
   3xdXsrxycdOXl3tRACAsqMADxHhwxbQGjFWRCUtTi+LWxaSWAulIPJgHA
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10321"; a="288767659"
X-IronPort-AV: E=Sophos;i="5.90,271,1643702400"; 
   d="scan'208";a="288767659"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2022 21:33:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,271,1643702400"; 
   d="scan'208";a="575900487"
Received: from lkp-server01.sh.intel.com (HELO 3abc53900bec) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 18 Apr 2022 21:33:24 -0700
Received: from kbuild by 3abc53900bec with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1ngfYJ-0005LY-TX;
        Tue, 19 Apr 2022 04:33:23 +0000
Date:   Tue, 19 Apr 2022 12:32:43 +0800
From:   kernel test robot <lkp@intel.com>
To:     Matthias Kaehlcke <mka@chromium.org>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>
Cc:     kbuild-all@lists.01.org, linux-raid@vger.kernel.org,
        linux-kernel@vger.kernel.org, Song Liu <song@kernel.org>,
        linux-security-module@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>, dm-devel@redhat.com,
        Matthias Kaehlcke <mka@chromium.org>
Subject: Re: [PATCH 2/3] LoadPin: Enable loading from trusted dm-verity
 devices
Message-ID: <202204191222.n0HWtNe0-lkp@intel.com>
References: <20220418141545.2.I01c67af41d2f6525c6d023101671d7339a9bc8b5@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220418141545.2.I01c67af41d2f6525c6d023101671d7339a9bc8b5@changeid>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matthias,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on device-mapper-dm/for-next]
[also build test ERROR on song-md/md-next kees/for-next/pstore v5.18-rc3 next-20220414]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Matthias-Kaehlcke/LoadPin-Enable-loading-from-trusted-dm-verity-devices/20220419-051810
base:   https://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git for-next
config: powerpc-buildonly-randconfig-r002-20220417 (https://download.01.org/0day-ci/archive/20220419/202204191222.n0HWtNe0-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/5af892969b227a2602732e4be44a0c4a41967400
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Matthias-Kaehlcke/LoadPin-Enable-loading-from-trusted-dm-verity-devices/20220419-051810
        git checkout 5af892969b227a2602732e4be44a0c4a41967400
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=powerpc SHELL=/bin/bash security/loadpin/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   security/loadpin/loadpin.c: In function 'loadpin_init':
>> security/loadpin/loadpin.c:404:44: error: 'loadpin_sysctl_path' undeclared (first use in this function)
     404 |                 if (!register_sysctl_paths(loadpin_sysctl_path,
         |                                            ^~~~~~~~~~~~~~~~~~~
   security/loadpin/loadpin.c:404:44: note: each undeclared identifier is reported only once for each function it appears in
>> security/loadpin/loadpin.c:405:44: error: 'loadpin_sysctl_table_verity' undeclared (first use in this function)
     405 |                                            loadpin_sysctl_table_verity))
         |                                            ^~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +/loadpin_sysctl_path +404 security/loadpin/loadpin.c

   395	
   396	static int __init loadpin_init(void)
   397	{
   398		pr_info("ready to pin (currently %senforcing)\n",
   399			enforce ? "" : "not ");
   400		parse_exclude();
   401		security_add_hooks(loadpin_hooks, ARRAY_SIZE(loadpin_hooks), "loadpin");
   402	
   403		if (IS_ENABLED(CONFIG_SECURITY_LOADPIN_VERITY)) {
 > 404			if (!register_sysctl_paths(loadpin_sysctl_path,
 > 405						   loadpin_sysctl_table_verity))
   406				pr_notice("sysctl registration failed!\n");
   407		}
   408	
   409		return 0;
   410	}
   411	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
