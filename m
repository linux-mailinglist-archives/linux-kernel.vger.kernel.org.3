Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF43951293B
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 04:01:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239105AbiD1CED (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 22:04:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241036AbiD1CDm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 22:03:42 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B24A5F671;
        Wed, 27 Apr 2022 19:00:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651111229; x=1682647229;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=lulCbLibblcfe+Y3OjIlB++pgig6LUiF7oMjIIEhKF4=;
  b=FmpiIPBJoTVIG0xYRRNWBldZrGDec+XHZ8vlChWsBARfWagInldFghp8
   wSopWg9ZymML1Fn2P8GYaHSAYex5S8UpY8XwZLRFqEY+Gxxpn3QRmUBL0
   RkwLNmCJ4yKQheve+mR70eW9C8Cr/QLdGyCiWlZuxUVEgJPS6nWnPDptf
   tbkAGUbD2KMpJjV0dLMbFCf3pPFRGb1j4NxOOa9UuNX3XKn0P97Cf46zM
   ricpam942sSJgRwUdsA5OmRVJv2ooVy0Alr0bphU8giVZTgzy17vmMJXK
   bTX/SIdumwHfhFzJ/QP9oR1cE9jq8IZ6S7fpDuWOGbi0F12MlB1+ldFoJ
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10330"; a="291287363"
X-IronPort-AV: E=Sophos;i="5.90,294,1643702400"; 
   d="scan'208";a="291287363"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2022 19:00:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,294,1643702400"; 
   d="scan'208";a="617872486"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 27 Apr 2022 19:00:24 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1njtSB-0004xf-IA;
        Thu, 28 Apr 2022 02:00:23 +0000
Date:   Thu, 28 Apr 2022 09:59:41 +0800
From:   kernel test robot <lkp@intel.com>
To:     Matthias Kaehlcke <mka@chromium.org>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, dm-devel@redhat.com,
        linux-raid@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Song Liu <song@kernel.org>,
        Matthias Kaehlcke <mka@chromium.org>
Subject: Re: [PATCH v2 2/3] LoadPin: Enable loading from trusted dm-verity
 devices
Message-ID: <202204280323.OzDYYX55-lkp@intel.com>
References: <20220426143059.v2.2.I01c67af41d2f6525c6d023101671d7339a9bc8b5@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220426143059.v2.2.I01c67af41d2f6525c6d023101671d7339a9bc8b5@changeid>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matthias,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on device-mapper-dm/for-next]
[also build test ERROR on song-md/md-next kees/for-next/pstore v5.18-rc4 next-20220427]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Matthias-Kaehlcke/LoadPin-Enable-loading-from-trusted-dm-verity-devices/20220427-053314
base:   https://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git for-next
config: alpha-randconfig-r024-20220425 (https://download.01.org/0day-ci/archive/20220428/202204280323.OzDYYX55-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/f3a54909bcd78b9f7f006d7e78acd03987031fae
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Matthias-Kaehlcke/LoadPin-Enable-loading-from-trusted-dm-verity-devices/20220427-053314
        git checkout f3a54909bcd78b9f7f006d7e78acd03987031fae
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=alpha SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   security/loadpin/loadpin.c: In function 'loadpin_init':
   security/loadpin/loadpin.c:436:44: error: 'loadpin_sysctl_path' undeclared (first use in this function)
     436 |                 if (!register_sysctl_paths(loadpin_sysctl_path,
         |                                            ^~~~~~~~~~~~~~~~~~~
   security/loadpin/loadpin.c:436:44: note: each undeclared identifier is reported only once for each function it appears in
>> security/loadpin/loadpin.c:437:44: error: 'loadpin_sysctl_table_verity_digests' undeclared (first use in this function)
     437 |                                            loadpin_sysctl_table_verity_digests))
         |                                            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +/loadpin_sysctl_table_verity_digests +437 security/loadpin/loadpin.c

   427	
   428	static int __init loadpin_init(void)
   429	{
   430		pr_info("ready to pin (currently %senforcing)\n",
   431			enforce ? "" : "not ");
   432		parse_exclude();
   433		security_add_hooks(loadpin_hooks, ARRAY_SIZE(loadpin_hooks), "loadpin");
   434	
   435		if (IS_ENABLED(CONFIG_SECURITY_LOADPIN_VERITY)) {
   436			if (!register_sysctl_paths(loadpin_sysctl_path,
 > 437						   loadpin_sysctl_table_verity_digests))
   438				pr_notice("sysctl registration failed!\n");
   439		}
   440	
   441		return 0;
   442	}
   443	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
