Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA11155C200
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 14:45:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238625AbiF0PeC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 11:34:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238518AbiF0Pdp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 11:33:45 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26DAD1A802;
        Mon, 27 Jun 2022 08:33:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656344015; x=1687880015;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5z4e8YkrpJuqMo/WrMKsbmJ8jjBxVMfE5QCMZ7wIgIg=;
  b=mPJOHnt745DZdI3rkMUvSMGfIZh9jLdC4zWC2q7ESV1JrEI1X98SCCsU
   1fnP2nnrIsJxg8uDwcvNgA1rgPRSj19gGzg20myCmZ2LywnQAPo7MJ5e9
   tOt6UX7XGX6YdRU1xPHBIytHz4TSCCd8lX+7EjC8a7nVuu4lPlICZmLL0
   1wTrM48eCAm09zKqbevyPWSmHyh8FDN7loPf7vOaThEJg7N2xhCt73Pcq
   cVy5/gdwod/sLRzL2n0rzHLXcpZWSmjEJRp7BraEmqbQk1TJzgFsyXgfB
   duFA4ELX3SLx4MuRPLoyyY1frTnVxSSMZpsBNjZDqBvoQi7PZXBM829Jg
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10391"; a="343161289"
X-IronPort-AV: E=Sophos;i="5.92,226,1650956400"; 
   d="scan'208";a="343161289"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2022 08:33:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,226,1650956400"; 
   d="scan'208";a="616819892"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 27 Jun 2022 08:33:30 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o5qjx-0008hv-V9;
        Mon, 27 Jun 2022 15:33:29 +0000
Date:   Mon, 27 Jun 2022 23:33:29 +0800
From:   kernel test robot <lkp@intel.com>
To:     Stefan Binding <sbinding@opensource.cirrus.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-acpi@vger.kernel.org,
        alsa-devel@alsa-project.org,
        Stefan Binding <sbinding@opensource.cirrus.com>,
        linux-kernel@vger.kernel.org, patches@opensource.cirrus.com
Subject: Re: [PATCH v2 1/2] ACPI: utils: Add api to read _SUB from ACPI
Message-ID: <202206272354.ESTdiIXg-lkp@intel.com>
References: <20220627141148.804319-2-sbinding@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220627141148.804319-2-sbinding@opensource.cirrus.com>
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stefan,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on rafael-pm/linux-next]
[also build test ERROR on broonie-sound/for-next linus/master v5.19-rc4 next-20220627]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Stefan-Binding/Read-_SUB-from-ACPI-to-be-able-to-identify-firmware/20220627-221508
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next
config: um-x86_64_defconfig (https://download.01.org/0day-ci/archive/20220627/202206272354.ESTdiIXg-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/93ba13d4b3636b5cf2ff4d9185aa73f059cc7b2a
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Stefan-Binding/Read-_SUB-from-ACPI-to-be-able-to-identify-firmware/20220627-221508
        git checkout 93ba13d4b3636b5cf2ff4d9185aa73f059cc7b2a
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=um SUBARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from init/main.c:30:
>> include/linux/acpi.h:1028:1: error: expected identifier or '(' before '{' token
    1028 | {
         | ^
   init/main.c:769:20: warning: no previous prototype for 'arch_post_acpi_subsys_init' [-Wmissing-prototypes]
     769 | void __init __weak arch_post_acpi_subsys_init(void) { }
         |                    ^~~~~~~~~~~~~~~~~~~~~~~~~~
   init/main.c:781:20: warning: no previous prototype for 'mem_encrypt_init' [-Wmissing-prototypes]
     781 | void __init __weak mem_encrypt_init(void) { }
         |                    ^~~~~~~~~~~~~~~~
   init/main.c:783:20: warning: no previous prototype for 'poking_init' [-Wmissing-prototypes]
     783 | void __init __weak poking_init(void) { }
         |                    ^~~~~~~~~~~
   In file included from init/main.c:30:
   include/linux/acpi.h:1027:27: warning: 'acpi_get_subsystem_id' declared 'static' but never defined [-Wunused-function]
    1027 | static inline const char *acpi_get_subsystem_id(acpi_handle handle);
         |                           ^~~~~~~~~~~~~~~~~~~~~
--
   In file included from kernel/sysctl.c:55:
>> include/linux/acpi.h:1028:1: error: expected identifier or '(' before '{' token
    1028 | {
         | ^
   include/linux/acpi.h:1027:27: warning: 'acpi_get_subsystem_id' declared 'static' but never defined [-Wunused-function]
    1027 | static inline const char *acpi_get_subsystem_id(acpi_handle handle);
         |                           ^~~~~~~~~~~~~~~~~~~~~
--
   In file included from include/linux/i2c.h:13,
                    from drivers/input/mouse/synaptics.c:30:
>> include/linux/acpi.h:1028:1: error: expected identifier or '(' before '{' token
    1028 | {
         | ^
   include/linux/acpi.h:1027:27: warning: 'acpi_get_subsystem_id' declared 'static' but never defined [-Wunused-function]
    1027 | static inline const char *acpi_get_subsystem_id(acpi_handle handle);
         |                           ^~~~~~~~~~~~~~~~~~~~~
   drivers/input/mouse/synaptics.c:164:27: warning: 'smbus_pnp_ids' defined but not used [-Wunused-const-variable=]
     164 | static const char * const smbus_pnp_ids[] = {
         |                           ^~~~~~~~~~~~~


vim +1028 include/linux/acpi.h

  1026	
  1027	static inline const char *acpi_get_subsystem_id(acpi_handle handle);
> 1028	{
  1029		return ERR_PTR(-ENODEV);
  1030	}
  1031	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
