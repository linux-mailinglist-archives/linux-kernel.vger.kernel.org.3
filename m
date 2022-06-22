Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CDDA5555A9
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 23:01:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245369AbiFVVBJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 17:01:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229710AbiFVVBH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 17:01:07 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7319C3F8A8;
        Wed, 22 Jun 2022 14:01:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655931666; x=1687467666;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=un9jTk5iM1Wb08b7+qHwbT4yCWwVDbKuquwCBKzWxiI=;
  b=h8TKGwU5FWHwaa7NRhe/CyT+WD0LYToQ+PQDR9QzmCzDHZ0TqyD0qN3G
   U7g93zmS1DSNgiDEydcg5JbxJ8FAuyUepYz2R1grEn3DqPufoRYJnHcK0
   QkGT67SH9lNMdSpN8ZoI2yLF2D8NS56fMV+/SZ15x2cFmhPV5ePZ4MuUL
   DwFlcWdRcLdbRngaAjYLCFDXVDKgg/QUQl63KmxQN2N3ShVW4iosOQCU8
   tY/tSDFfwTmjvVdmANVmFLbnw86HRCK4R6SaGUjxRaByn/kDzwqyT0UT5
   WXWyg7CoihTTm9AUOLzxxPeuW/Wfm3gVa1asvZhNMeu5scSOLcPMzHvKg
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10386"; a="342229300"
X-IronPort-AV: E=Sophos;i="5.92,212,1650956400"; 
   d="scan'208";a="342229300"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2022 14:01:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,212,1650956400"; 
   d="scan'208";a="588355614"
Received: from lkp-server02.sh.intel.com (HELO a67cc04a5eeb) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 22 Jun 2022 14:01:02 -0700
Received: from kbuild by a67cc04a5eeb with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o47TB-0001gX-Ac;
        Wed, 22 Jun 2022 21:01:01 +0000
Date:   Thu, 23 Jun 2022 05:00:22 +0800
From:   kernel test robot <lkp@intel.com>
To:     Stefan Binding <sbinding@opensource.cirrus.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-acpi@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, patches@opensource.cirrus.com,
        Stefan Binding <sbinding@opensource.cirrus.com>
Subject: Re: [PATCH v1 1/2] ACPI: utils: Add api to read _SUB from ACPI
Message-ID: <202206230433.0LyjOI85-lkp@intel.com>
References: <20220622130730.1573747-2-sbinding@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220622130730.1573747-2-sbinding@opensource.cirrus.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
[also build test ERROR on broonie-sound/for-next linus/master v5.19-rc3 next-20220622]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Stefan-Binding/Read-_SUB-from-ACPI-to-be-able-to-identify-firmware/20220622-211004
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next
config: powerpc-buildonly-randconfig-r002-20220622 (https://download.01.org/0day-ci/archive/20220623/202206230433.0LyjOI85-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 8b8d126598ce7bd5243da7f94f69fa1104288bee)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install powerpc cross compiling tool for clang build
        # apt-get install binutils-powerpc-linux-gnu
        # https://github.com/intel-lab-lkp/linux/commit/97b928a895ce3105296f0036393bb9ee04f11ae4
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Stefan-Binding/Read-_SUB-from-ACPI-to-be-able-to-identify-firmware/20220622-211004
        git checkout 97b928a895ce3105296f0036393bb9ee04f11ae4
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=powerpc SHELL=/bin/bash arch/powerpc/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from arch/powerpc/kernel/traps.c:32:
   In file included from include/linux/backlight.h:13:
   In file included from include/linux/fb.h:7:
   In file included from include/uapi/linux/fb.h:6:
   In file included from include/linux/i2c.h:13:
>> include/linux/acpi.h:1029:12: error: unused function 'acpi_get_sub' [-Werror,-Wunused-function]
   static int acpi_get_sub(acpi_handle handle, char *sub, size_t size)
              ^
   1 error generated.


vim +/acpi_get_sub +1029 include/linux/acpi.h

  1028	
> 1029	static int acpi_get_sub(acpi_handle handle, char *sub, size_t size)
  1030	{
  1031		return -ENODEV;
  1032	}
  1033	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
