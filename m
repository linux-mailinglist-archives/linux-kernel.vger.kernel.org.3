Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA4C5563F41
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Jul 2022 11:35:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232001AbiGBJev (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Jul 2022 05:34:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiGBJeu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jul 2022 05:34:50 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C841F15A02;
        Sat,  2 Jul 2022 02:34:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656754489; x=1688290489;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=yMmA2W1SvyNpAttWj/B6jRcNsRBOC+CcZJ9+GyTMevI=;
  b=ElWAyDoA0lKJQnWOjVTP1AQDMGEOaqSQ2AFk9MdwA9HsnXSKcY0bZPLb
   4b9GCViTT9oWLWmbJfsWtEEKcqmBtzAEBwDfO3TYhFiSI5HSKZFmjk0uZ
   KCZIbHbMBB6TJ12cwIr3kDDnkpP89PALzxCocEcrJ+Foytc5o6olnzsUP
   DVURmcg8FsNTDltt2bMUDp28v+op8hEUnO8li6j+POxASB6gAWX1ihKfl
   F7v7LWY6nr74TSO8IV/ORFGFq9jNynVl3N4f4VQ0rH+JV2ARXzItdeNcb
   9cPuIqlHUybPrV9D2e4Zdx6gTHUee5bCd2K8zpE3bCZ2Q9Dx0Hu+B2e4H
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10395"; a="308342167"
X-IronPort-AV: E=Sophos;i="5.92,239,1650956400"; 
   d="scan'208";a="308342167"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2022 02:34:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,239,1650956400"; 
   d="scan'208";a="718877221"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 02 Jul 2022 02:34:47 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o7ZWY-000F6B-Dv;
        Sat, 02 Jul 2022 09:34:46 +0000
Date:   Sat, 2 Jul 2022 17:34:07 +0800
From:   kernel test robot <lkp@intel.com>
To:     Mario Limonciello <mario.limonciello@amd.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-pm@vger.kernel.org, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 04/10] ata: ahci: Use `pm_suspend_preferred_s2idle`
Message-ID: <202207021730.qxUxPlRq-lkp@intel.com>
References: <20220701023328.2783-4-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220701023328.2783-4-mario.limonciello@amd.com>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mario,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on rafael-pm/linux-next]
[also build test ERROR on drm-misc/drm-misc-next hid/for-next linus/master v5.19-rc4 next-20220701]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Mario-Limonciello/PM-suspend-Introduce-pm_suspend_preferred_s2idle/20220701-103534
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next
config: i386-randconfig-a011 (https://download.01.org/0day-ci/archive/20220702/202207021730.qxUxPlRq-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project bcd153485ebf07fe79e2b843ed5f1cb74997df1b)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/ceb90ecfef1f252424a29b31a547cfc80c8f5135
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Mario-Limonciello/PM-suspend-Introduce-pm_suspend_preferred_s2idle/20220701-103534
        git checkout ceb90ecfef1f252424a29b31a547cfc80c8f5135
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash drivers/ata/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/ata/ahci.c:1614:6: error: call to undeclared function 'pm_suspend_preferred_s2idle'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
               pm_suspend_preferred_s2idle()) {
               ^
   drivers/ata/ahci.c:1614:6: note: did you mean 'pm_suspend_default_s2idle'?
   include/linux/suspend.h:343:20: note: 'pm_suspend_default_s2idle' declared here
   static inline bool pm_suspend_default_s2idle(void) { return false; }
                      ^
   1 error generated.


vim +/pm_suspend_preferred_s2idle +1614 drivers/ata/ahci.c

  1595	
  1596	static void ahci_update_initial_lpm_policy(struct ata_port *ap,
  1597						   struct ahci_host_priv *hpriv)
  1598	{
  1599		int policy = CONFIG_SATA_MOBILE_LPM_POLICY;
  1600	
  1601	
  1602		/* Ignore processing for chipsets that don't use policy */
  1603		if (!(hpriv->flags & AHCI_HFLAG_USE_LPM_POLICY))
  1604			return;
  1605	
  1606		/* user modified policy via module param */
  1607		if (mobile_lpm_policy != -1) {
  1608			policy = mobile_lpm_policy;
  1609			goto update_policy;
  1610		}
  1611	
  1612	#ifdef CONFIG_ACPI
  1613		if (policy > ATA_LPM_MED_POWER &&
> 1614		    pm_suspend_preferred_s2idle()) {
  1615			if (hpriv->cap & HOST_CAP_PART)
  1616				policy = ATA_LPM_MIN_POWER_WITH_PARTIAL;
  1617			else if (hpriv->cap & HOST_CAP_SSC)
  1618				policy = ATA_LPM_MIN_POWER;
  1619		}
  1620	#endif
  1621	
  1622	update_policy:
  1623		if (policy >= ATA_LPM_UNKNOWN && policy <= ATA_LPM_MIN_POWER)
  1624			ap->target_lpm_policy = policy;
  1625	}
  1626	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
