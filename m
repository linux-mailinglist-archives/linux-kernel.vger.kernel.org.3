Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A997557226
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 06:58:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232853AbiFWEqr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 00:46:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245591AbiFWECR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 00:02:17 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A14B2D1F4;
        Wed, 22 Jun 2022 21:02:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655956936; x=1687492936;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=iAIaqF7rha3sZC6nzOYKWGpBVTJjKr5yx5Wg7Q0/sfA=;
  b=QSB1tx95/AqoiQTiK3p0kFOnZl/yAq3x2FEmLrUzjTbOPtFAcnKBPHVz
   fDX1m9t1kuBewDrDjioyic7H5bm4XSQbBuEK3ZeuUaQLkyHeE0W+KxQ2P
   ad/fmc4CgP+wKtcft5FqXRWQc5hro//Q0a+6F2Gc9JxLnWwm2O+WJ0OI0
   8IPhpMlJpEDxE3h1SQZ0LIED6uAVHfBNPx8YyCJIX4DptrXgqUJXA0k9v
   l85BFmo0J5+vFsbwf1PHZqrGZOdvkW6IIP0yUAGQuZ7/cz03WC+ZoaPVo
   QMbEDqhp57Cl/3thXmxAdHLHbL3Khffjvbi9+bqKh2vvbTkrc971AN+2M
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10386"; a="280664601"
X-IronPort-AV: E=Sophos;i="5.92,215,1650956400"; 
   d="scan'208";a="280664601"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2022 21:02:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,215,1650956400"; 
   d="scan'208";a="655991306"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 22 Jun 2022 21:02:13 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o4E2m-0000fn-QR;
        Thu, 23 Jun 2022 04:02:12 +0000
Date:   Thu, 23 Jun 2022 12:01:39 +0800
From:   kernel test robot <lkp@intel.com>
To:     Stefan Binding <sbinding@opensource.cirrus.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-acpi@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        patches@opensource.cirrus.com,
        Stefan Binding <sbinding@opensource.cirrus.com>
Subject: Re: [PATCH v1 2/2] ASoC: cs35l41: Read System Name from ACPI _SUB to
 identify firmware
Message-ID: <202206231108.xPflWTbR-lkp@intel.com>
References: <20220622130730.1573747-3-sbinding@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220622130730.1573747-3-sbinding@opensource.cirrus.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
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
config: sparc64-randconfig-r002-20220622 (https://download.01.org/0day-ci/archive/20220623/202206231108.xPflWTbR-lkp@intel.com/config)
compiler: sparc64-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/338eadc59e88d60759ea445011a6537222b233e3
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Stefan-Binding/Read-_SUB-from-ACPI-to-be-able-to-identify-firmware/20220622-211004
        git checkout 338eadc59e88d60759ea445011a6537222b233e3
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=sparc64 SHELL=/bin/bash sound/soc/codecs/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   sound/soc/codecs/cs35l41.c: In function 'cs35l41_probe_acpi':
>> sound/soc/codecs/cs35l41.c:1157:32: error: invalid use of undefined type 'struct acpi_device'
    1157 |         ret = acpi_get_sub(adev->handle, sub, sizeof(sub));
         |                                ^~


vim +1157 sound/soc/codecs/cs35l41.c

  1145	
  1146	static int cs35l41_probe_acpi(struct cs35l41_private *cs35l41)
  1147	{
  1148		struct acpi_device *adev;
  1149		int ret;
  1150		char sub[ACPI_MAX_SUB_BUF_SIZE];
  1151	
  1152		adev = ACPI_COMPANION(cs35l41->dev);
  1153		/* If there is no ACPI_COMPANION, there is no ACPI for this system, return 0 */
  1154		if (!adev)
  1155			return 0;
  1156	
> 1157		ret = acpi_get_sub(adev->handle, sub, sizeof(sub));
  1158		if (ret < 0)
  1159			return ret;
  1160	
  1161		cs35l41->dsp.system_name = devm_kstrdup(cs35l41->dev, sub, GFP_KERNEL);
  1162		if (!cs35l41->dsp.system_name)
  1163			return -ENOMEM;
  1164	
  1165		return 0;
  1166	}
  1167	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
