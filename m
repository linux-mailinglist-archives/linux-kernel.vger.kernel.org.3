Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D218753DF6E
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 03:42:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349000AbiFFBmK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Jun 2022 21:42:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233230AbiFFBmI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jun 2022 21:42:08 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C157A5F48
        for <linux-kernel@vger.kernel.org>; Sun,  5 Jun 2022 18:42:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654479726; x=1686015726;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=89fRXrMCu5gUf0qTnTDqrSzw14ZMCulzmcEHQKRg2Kw=;
  b=LogTohUioNfSPeBygvltFYaCVVvQ5Ri/YikjaFY3kR0Jv4gvvMnOrCHw
   tGTCEMkuqZ6nfeSNk9gZ3zHfiCqzbKGZodY71C5R3VMXdBmkpoXb8jjuE
   Wvzk9wiVBhDNhTjR5Qd8g68sJp4UcUbo0IbmiW+cDgc6oeI1PBVIUkHca
   sYupe0d68YFSQkI44Is9QepUR8O5Sibaof6oMkoParLNdMpEc1pyaGi9x
   OUXvHoCJyKE2c4gcsTC6TTzgkqItcv88Teb6YZD7AGPdDvqeAYAqG3cB1
   zqGy/zmKrpKjV2A+j73Hp4Rn0hiiQjEVttBwaihxBUH5sgGMZw/wlSeGN
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10369"; a="275389005"
X-IronPort-AV: E=Sophos;i="5.91,280,1647327600"; 
   d="scan'208";a="275389005"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2022 18:42:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,280,1647327600"; 
   d="scan'208";a="564665634"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 05 Jun 2022 18:42:03 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1ny1ko-000COk-QU;
        Mon, 06 Jun 2022 01:42:02 +0000
Date:   Mon, 6 Jun 2022 09:41:56 +0800
From:   kernel test robot <lkp@intel.com>
To:     Laurent Dufour <ldufour@linux.ibm.com>, mpe@ellerman.id.au,
        benh@kernel.crashing.org, paulus@samba.org, nathanl@linux.ibm.com,
        haren@linux.vnet.ibm.com, npiggin@gmail.com
Cc:     kbuild-all@lists.01.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] powerpc/mobility: disabling hard lockup watchdog
 during LPM
Message-ID: <202206060910.rYNTFqdI-lkp@intel.com>
References: <20220601155315.35109-3-ldufour@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220601155315.35109-3-ldufour@linux.ibm.com>
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Laurent,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on powerpc/next]
[also build test ERROR on v5.18 next-20220603]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Laurent-Dufour/Disabling-NMI-watchdog-during-LPM-s-memory-transfer/20220601-235741
base:   https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git next
config: powerpc64-randconfig-r002-20220605 (https://download.01.org/0day-ci/archive/20220606/202206060910.rYNTFqdI-lkp@intel.com/config)
compiler: powerpc64-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/d409d8549db37257e33691523100679a23cfd887
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Laurent-Dufour/Disabling-NMI-watchdog-during-LPM-s-memory-transfer/20220601-235741
        git checkout d409d8549db37257e33691523100679a23cfd887
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=powerpc SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   powerpc64-linux-ld: warning: discarding dynamic section .glink
   powerpc64-linux-ld: warning: discarding dynamic section .plt
   powerpc64-linux-ld: linkage table error against `watchdog_nmi_stop'
   powerpc64-linux-ld: stubs don't match calculated size
   powerpc64-linux-ld: can not build stubs: bad value
   powerpc64-linux-ld: arch/powerpc/platforms/pseries/mobility.o: in function `.pseries_migrate_partition':
>> arch/powerpc/platforms/pseries/mobility.c:705: undefined reference to `.watchdog_nmi_stop'
>> powerpc64-linux-ld: arch/powerpc/platforms/pseries/mobility.c:715: undefined reference to `.watchdog_nmi_start'


vim +705 arch/powerpc/platforms/pseries/mobility.c

   693	
   694	static int pseries_migrate_partition(u64 handle)
   695	{
   696		int ret;
   697	
   698		ret = wait_for_vasi_session_suspending(handle);
   699		if (ret)
   700			return ret;
   701	
   702		vas_migration_handler(VAS_SUSPEND);
   703	
   704		pr_debug("Disabling the NMI watchdog\n");
 > 705		watchdog_nmi_stop();
   706	
   707		ret = pseries_suspend(handle);
   708		if (ret == 0) {
   709			post_mobility_fixup();
   710			wait_for_vasi_session_completed(handle);
   711		} else
   712			pseries_cancel_migration(handle, ret);
   713	
   714		pr_debug("Enabling the NMI watchdog again\n");
 > 715		watchdog_nmi_start();
   716	
   717		vas_migration_handler(VAS_RESUME);
   718	
   719		return ret;
   720	}
   721	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
