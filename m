Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 415FA5A40E6
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 04:11:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229509AbiH2CLQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Aug 2022 22:11:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbiH2CLP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Aug 2022 22:11:15 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C2C82BB32;
        Sun, 28 Aug 2022 19:11:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661739074; x=1693275074;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=wKDcFe66lT4ug9hfNULlB7hplFGh+Yopi+wGiirwzZQ=;
  b=fqQ4hmSV4jvizWjjV6HFwFTDFsa0KF78Y1dc9da7/MVilfrKWMqmZZx5
   GuMB0ed8nQYo5fxBMiDDcX9k32DWmeF6CwKHbJK9Z+ms7rkS2zDmSNN7I
   dAWTrEN4p2AXj0DEvXfCnIo9Iltn7RSc+NdTVy55H1bC1Jzi8JpSeq5Pz
   mPWs1TpzRpFBbxrGpMlydpGGaGPse9CB7DbX5NaBsfLobUEa24GixnnwL
   GIb7zY9VQgjK0Z3yq5+7DAdzP0tZq/V6DX2A8RLsRfQeenaHu9TXJUlOR
   wq5PDM3kGxBNU2lsZO/6QsMEzOgVM4fCJTCP17NdMdlGXE3wZ+GPhTNDH
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10453"; a="295567564"
X-IronPort-AV: E=Sophos;i="5.93,271,1654585200"; 
   d="scan'208";a="295567564"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2022 19:11:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,271,1654585200"; 
   d="scan'208";a="587985382"
Received: from lkp-server01.sh.intel.com (HELO b2bbdd52f619) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 28 Aug 2022 19:11:10 -0700
Received: from kbuild by b2bbdd52f619 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oSUF4-00003H-0z;
        Mon, 29 Aug 2022 02:11:10 +0000
Date:   Mon, 29 Aug 2022 10:10:40 +0800
From:   kernel test robot <lkp@intel.com>
To:     Mario Limonciello <mario.limonciello@amd.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, Pavel Machek <pavel@ucw.cz>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org, hdegoede@redhat.com,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH 1/4] ACPI: s2idle: Add a new ->enter() callback for
 platform_s2idle_ops
Message-ID: <202208291045.mtIt51vk-lkp@intel.com>
References: <20220828222121.4951-2-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220828222121.4951-2-mario.limonciello@amd.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mario,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on rafael-pm/linux-next]
[also build test WARNING on linus/master v6.0-rc3 next-20220826]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Mario-Limonciello/Add-some-extra-debugging-mechanisms-for-s0i3/20220829-062334
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next
config: x86_64-randconfig-a011-20220829 (https://download.01.org/0day-ci/archive/20220829/202208291045.mtIt51vk-lkp@intel.com/config)
compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project f28c006a5895fc0e329fe15fead81e37457cb1d1)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/af6400b51370a2bc04906697aeec5a938e6ee446
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Mario-Limonciello/Add-some-extra-debugging-mechanisms-for-s0i3/20220829-062334
        git checkout af6400b51370a2bc04906697aeec5a938e6ee446
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/acpi/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/acpi/x86/s2idle.c:489:6: warning: no previous prototype for function 'acpi_s2idle_enter' [-Wmissing-prototypes]
   void acpi_s2idle_enter(void)
        ^
   drivers/acpi/x86/s2idle.c:489:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void acpi_s2idle_enter(void)
   ^
   static 
   1 warning generated.


vim +/acpi_s2idle_enter +489 drivers/acpi/x86/s2idle.c

   488	
 > 489	void acpi_s2idle_enter(void)
   490	{
   491		struct acpi_s2idle_dev_ops *handler;
   492	
   493		if (!lps0_device_handle || sleep_no_lps0)
   494			return;
   495	
   496		list_for_each_entry(handler, &lps0_s2idle_devops_head, list_node) {
   497			if (handler->enter)
   498				handler->enter();
   499		}
   500	}
   501	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
