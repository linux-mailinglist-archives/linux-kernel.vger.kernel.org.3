Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E95C651AE9B
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 22:00:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377877AbiEDUEG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 16:04:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377637AbiEDUEC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 16:04:02 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CB111CFFB;
        Wed,  4 May 2022 13:00:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651694425; x=1683230425;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jC2aMWUJhX29obrPq1HQfTtD2kGq5tdC3PTfWHFzxR8=;
  b=mEavUaXik74IqPdaDCPLCpDJdGv/FsCn/MjV7kGvYRelL1ojtbMWA0f7
   P4g0mx3u+AcfPGIo8nfSELNFBOwpHvrDAyySRK/+qTXnDOAhEN8W2zZBz
   CFMlC/RCuHmHYHawK4eiPvR4RTwEDMBKKgCfFd9IAkV53LW0uU33wmIQb
   RXkviN6N/ORJ01P1Vc0jqbLzYUfGyl5RAJeLpHpGXCTkVdA6CfjiA/PXX
   dRw7BDaE8hotWriJSdKK6uHwNQLYlKiHAb8xArqCXCjvqByo3PV+EVYjE
   V3yn2Qg2of35W75j/+NWAvVODUmdAmCGZiFemkOi+ksF6cJW9QyoyMNKd
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10337"; a="354320501"
X-IronPort-AV: E=Sophos;i="5.91,199,1647327600"; 
   d="scan'208";a="354320501"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2022 13:00:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,199,1647327600"; 
   d="scan'208";a="599683635"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 04 May 2022 13:00:22 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nmLAb-000Bk9-W3;
        Wed, 04 May 2022 20:00:21 +0000
Date:   Thu, 5 May 2022 04:00:00 +0800
From:   kernel test robot <lkp@intel.com>
To:     Corentin Labbe <clabbe@baylibre.com>, jdelvare@suse.com,
        linux@roeck-us.net
Cc:     kbuild-all@lists.01.org, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, Corentin Labbe <clabbe@baylibre.com>
Subject: Re: [PATCH v2 2/2] hwmon: acpi_power_meter: convert to
 hwmon_device_register_with_info
Message-ID: <202205050310.mXK9zxb3-lkp@intel.com>
References: <20220504103028.493155-3-clabbe@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220504103028.493155-3-clabbe@baylibre.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Corentin,

I love your patch! Yet something to improve:

[auto build test ERROR on groeck-staging/hwmon-next]
[also build test ERROR on v5.18-rc5 next-20220504]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Corentin-Labbe/hwmon-acpi_power_meter-convert-to-new-hwmon-API/20220504-183225
base:   https://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-next
config: i386-randconfig-a014 (https://download.01.org/0day-ci/archive/20220505/202205050310.mXK9zxb3-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.2.0-20) 11.2.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/0287ed3436a71556d5fb79429e9ca041a0c5fe5b
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Corentin-Labbe/hwmon-acpi_power_meter-convert-to-new-hwmon-API/20220504-183225
        git checkout 0287ed3436a71556d5fb79429e9ca041a0c5fe5b
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   ld: drivers/hwmon/acpi_power_meter.o: in function `acpi_power_read':
>> acpi_power_meter.c:(.text+0x83c): undefined reference to `__udivdi3'

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
