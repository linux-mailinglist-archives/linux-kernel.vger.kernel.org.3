Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E86185758B0
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 02:44:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232988AbiGOAoB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 20:44:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbiGOAn6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 20:43:58 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFB96275CA;
        Thu, 14 Jul 2022 17:43:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657845836; x=1689381836;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jJ2QO/k1ABVMsRZgKGsv6X/yHVjuDNgI50HCJWC87kE=;
  b=FLEYVYHHDneuXJtub/WbPsR8yLXUv0HJPPWiUBxP6SbSq8qJUjfG4RVw
   7eMsXEXPM+RDclkSscqJUm5uPuzMg5N+C1iSj6NBYRWNn6J/eICxYDu3f
   77NmtcUQnhCmH4UYPob/W47EfSI1bXKA3qjHniDfDylYaRrrcOfMJILQU
   koAhnpHJ0k6XRAxEidGYC/s9CB2l6Gvh6O39zClEZ6nHaeRJZItLERBrt
   st8oQDr8vrEzD9m+tsptZIxOSbkMw/+nW6bzN9b6o/8bl/tGS991Lzxys
   ycDEeni07+KzqeHnlPljSUU3vbGQR7DRBhHRYcxtUIoa6PZucrhStxPf0
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10408"; a="265457957"
X-IronPort-AV: E=Sophos;i="5.92,272,1650956400"; 
   d="scan'208";a="265457957"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2022 17:43:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,272,1650956400"; 
   d="scan'208";a="923304559"
Received: from lkp-server01.sh.intel.com (HELO fd2c14d642b4) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 14 Jul 2022 17:43:52 -0700
Received: from kbuild by fd2c14d642b4 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1oC9Qu-0001Jm-9b;
        Fri, 15 Jul 2022 00:43:52 +0000
Date:   Fri, 15 Jul 2022 08:43:31 +0800
From:   kernel test robot <lkp@intel.com>
To:     Michal Suchanek <msuchanek@suse.de>, linux-sunxi@lists.linux.dev
Cc:     kbuild-all@lists.01.org, Michal Suchanek <msuchanek@suse.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Michael Walle <michael@walle.cc>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org
Subject: Re: [PATCH 1/2] mtd: spi-nor: When a flash memory is missing do not
 report an error
Message-ID: <202207150854.H5k2mIIu-lkp@intel.com>
References: <701967b0c418db333c66b48d225df60aa9d03ead.1657826188.git.msuchanek@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <701967b0c418db333c66b48d225df60aa9d03ead.1657826188.git.msuchanek@suse.de>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michal,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on mtd/spi-nor/next]
[also build test WARNING on sunxi/sunxi/for-next krzk/for-next krzk-dt/for-next krzk-mem-ctrl/for-next linus/master v5.19-rc6 next-20220714]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Michal-Suchanek/mtd-spi-nor-When-a-flash-memory-is-missing-do-not-report-an-error/20220715-032336
base:   https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git spi-nor/next
config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20220715/202207150854.H5k2mIIu-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/d747dae258dd8d5220d38fae5fd09be703b0391b
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Michal-Suchanek/mtd-spi-nor-When-a-flash-memory-is-missing-do-not-report-an-error/20220715-032336
        git checkout d747dae258dd8d5220d38fae5fd09be703b0391b
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/mtd/spi-nor/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/mtd/spi-nor/core.c:1655:8: warning: type qualifiers ignored on function return type [-Wignored-qualifiers]
    1655 | static const bool buffer_uniform(const u8 *buffer, size_t length)
         |        ^~~~~


vim +1655 drivers/mtd/spi-nor/core.c

  1654	
> 1655	static const bool buffer_uniform(const u8 *buffer, size_t length)
  1656	{
  1657		bool all0;
  1658		size_t i;
  1659	
  1660		for (all0 = true, i = 0; i < length; i++)
  1661			if (buffer[i] != 0) {
  1662				all0 = false;
  1663				break;
  1664			}
  1665		if (all0)
  1666			return true;
  1667		for (i = 0; i < length; i++)
  1668			if (buffer[i] != 0xff)
  1669				return false;
  1670		return true;
  1671	}
  1672	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
