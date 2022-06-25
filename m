Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BFFA55A9A8
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Jun 2022 14:14:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232849AbiFYMJM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Jun 2022 08:09:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232170AbiFYMJL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jun 2022 08:09:11 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 152D82DA9E;
        Sat, 25 Jun 2022 05:09:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656158949; x=1687694949;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=U+MKyW42cm90TH4qiG7D9bq9ws49EylDg1LcDEnyUDI=;
  b=AJYvdMGI1Fm5zvasoQiYL0ThZVr/YEAdCy75ZMfNUfxq6Ym2WMMhgHYP
   g4LAByUJLouAjJrPnqwuuJvf0JZiXUks8AlyjdvYSP3EMammp16RWEyK7
   1Eq7pq53VAo8+iAeLji63bVHxf78VisjSu/UfAnl3rPl5iY5xE1X3JmO3
   sf8GelyzygKgYZTLf7u8a6LQq9V61PJTlk9Nk/lhqkavdFIpYUJBnpUkR
   65dNsaKtL2WW9pd+qPxLBLin6XrovzCk6y5Ou3gCk9uYUb6LIYqT1sV7d
   p/leIp2I4Ftsv9Htf6mz1Sz+t6YBHiH4NSJ/ceQ6ks3AndpJsXGY4dmqW
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10388"; a="281222299"
X-IronPort-AV: E=Sophos;i="5.92,222,1650956400"; 
   d="scan'208";a="281222299"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2022 05:09:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,222,1650956400"; 
   d="scan'208";a="691898744"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 25 Jun 2022 05:09:06 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o54b3-0005jD-WA;
        Sat, 25 Jun 2022 12:09:05 +0000
Date:   Sat, 25 Jun 2022 20:08:43 +0800
From:   kernel test robot <lkp@intel.com>
To:     Marcus Folkesson <marcus.folkesson@gmail.com>,
        Kent Gustavsson <kent@minoris.se>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 10/10] iio: adc: mcp3911: add support to set PGA
Message-ID: <202206252046.W7EVOoVr-lkp@intel.com>
References: <20220625103853.2470346-10-marcus.folkesson@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220625103853.2470346-10-marcus.folkesson@gmail.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcus,

I love your patch! Perhaps something to improve:

[auto build test WARNING on jic23-iio/togreg]
[also build test WARNING on linus/master v5.19-rc3 next-20220624]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Marcus-Folkesson/iio-adc-mcp3911-correct-microchip-device-addr-property/20220625-184118
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git togreg
config: i386-randconfig-a001
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/def017eb4efc80ab515495d6eb7d59d142c0276d
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Marcus-Folkesson/iio-adc-mcp3911-correct-microchip-device-addr-property/20220625-184118
        git checkout def017eb4efc80ab515495d6eb7d59d142c0276d
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash drivers/iio/adc/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/iio/adc/mcp3911.c: In function 'mcp3911_calc_scale_table':
>> drivers/iio/adc/mcp3911.c:305:13: warning: variable 'tmp0' set but not used [-Wunused-but-set-variable]
     305 |         int tmp0, tmp1;
         |             ^~~~
   drivers/iio/adc/mcp3911.c: At top level:
   drivers/iio/adc/mcp3911.c:366:22: warning: initialized field overwritten [-Woverride-init]
     366 |         MCP3911_CHAN(0),
         |                      ^
   drivers/iio/adc/mcp3911.c:347:31: note: in definition of macro 'MCP3911_CHAN'
     347 |                 .scan_index = idx,                              \
         |                               ^~~
   drivers/iio/adc/mcp3911.c:366:22: note: (near initialization for 'mcp3911_channels[0].scan_index')
     366 |         MCP3911_CHAN(0),
         |                      ^
   drivers/iio/adc/mcp3911.c:347:31: note: in definition of macro 'MCP3911_CHAN'
     347 |                 .scan_index = idx,                              \
         |                               ^~~
   drivers/iio/adc/mcp3911.c:367:22: warning: initialized field overwritten [-Woverride-init]
     367 |         MCP3911_CHAN(1),
         |                      ^
   drivers/iio/adc/mcp3911.c:347:31: note: in definition of macro 'MCP3911_CHAN'
     347 |                 .scan_index = idx,                              \
         |                               ^~~
   drivers/iio/adc/mcp3911.c:367:22: note: (near initialization for 'mcp3911_channels[1].scan_index')
     367 |         MCP3911_CHAN(1),
         |                      ^
   drivers/iio/adc/mcp3911.c:347:31: note: in definition of macro 'MCP3911_CHAN'
     347 |                 .scan_index = idx,                              \
         |                               ^~~


vim +/tmp0 +305 drivers/iio/adc/mcp3911.c

   299	
   300	static int mcp3911_calc_scale_table(struct mcp3911 *adc)
   301	{
   302		u32 ref = MCP3911_INT_VREF_MV;
   303		u32 div;
   304		int ret;
 > 305		int tmp0, tmp1;
   306		s64 tmp2;
   307	
   308		if (adc->vref) {
   309			ret = regulator_get_voltage(adc->vref);
   310			if (ret < 0) {
   311				dev_err(&adc->spi->dev,
   312					"failed to get vref voltage: %d\n",
   313				       ret);
   314				return ret;
   315			}
   316	
   317			ref = ret / 1000;
   318		}
   319	
   320		/*
   321		 * For 24bit Conversion
   322		 * Raw = ((Voltage)/(Vref) * 2^23 * Gain * 1.5
   323		 * Voltage = Raw * (Vref)/(2^23 * Gain * 1.5)
   324		 */
   325	
   326		/* ref = Reference voltage
   327		 * div = (2^23 * 1.5 * gain) = 12582912 * gain
   328		 */
   329		for (int i = 0; i < MCP3911_NUM_SCALES; i++) {
   330			div = 12582912 * BIT(i);
   331			tmp2 = div_s64((s64)ref * 1000000000LL, div);
   332			tmp1 = div;
   333			tmp0 = (int)div_s64_rem(tmp2, 1000000000, &tmp1);
   334	
   335			mcp3911_scale_table[i][0] = 0;
   336			mcp3911_scale_table[i][1] = tmp1;
   337		}
   338	
   339		return 0;
   340	}
   341	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
