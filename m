Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89AF357717F
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jul 2022 23:07:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232151AbiGPVHn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jul 2022 17:07:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbiGPVHm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jul 2022 17:07:42 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1920517073;
        Sat, 16 Jul 2022 14:07:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658005661; x=1689541661;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5DwnM/iJM+O7it4IR8HPbw0em/nh8SdUF1KmWmnb4T4=;
  b=LMz34OcM6tjYcLXxBChcECkpek8ITC6YCB0PxOvI8ApgzbV6QEM2WaLX
   KptTDzrdeA/ZbxMkNCKzPSmeX/cZlxhgRLlJ/9MnU5+eWmQSPkREZDqSq
   2jTrnOojUradZBz4vvsIf+JUFitnzYqDqceNe+mw7vGGPqF0NwLdZPnRf
   6Zu4GEAZ7sLLkbRG80leeFAR/h2SaVaEcpa6WKLgkPZSNoCIUkUcjbZ9j
   ufPd7876jhcL8YC9tfWSImbBTfK+BazqPtOjJ9mc/GjUqtrgteGheetKV
   oULmDdY4p9D4eW5DacbI9gJEGD8UBGqOPAFvLtW6mI1foS5/96hAGacRn
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10410"; a="287150022"
X-IronPort-AV: E=Sophos;i="5.92,277,1650956400"; 
   d="scan'208";a="287150022"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2022 14:07:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,277,1650956400"; 
   d="scan'208";a="654778692"
Received: from lkp-server02.sh.intel.com (HELO ff137eb26ff1) ([10.239.97.151])
  by fmsmga008.fm.intel.com with ESMTP; 16 Jul 2022 14:07:37 -0700
Received: from kbuild by ff137eb26ff1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1oCp0i-00029O-QP;
        Sat, 16 Jul 2022 21:07:36 +0000
Date:   Sun, 17 Jul 2022 05:07:02 +0800
From:   kernel test robot <lkp@intel.com>
To:     Alexey Klimov <klimov.linux@gmail.com>,
        linux-watchdog@vger.kernel.org
Cc:     kbuild-all@lists.01.org, wim@linux-watchdog.org,
        linux@roeck-us.net, oneukum@suse.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, atishp@rivosinc.com,
        atishp@atishpatra.org, yury.norov@gmail.com, aklimov@redhat.com,
        atomlin@redhat.com, klimov.linux@gmail.com
Subject: Re: [PATCH v4] watchdog: add driver for StreamLabs USB watchdog
 device
Message-ID: <202207170459.ZyslrGcE-lkp@intel.com>
References: <20220715234442.3910204-1-klimov.linux@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220715234442.3910204-1-klimov.linux@gmail.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alexey,

I love your patch! Perhaps something to improve:

[auto build test WARNING on groeck-staging/hwmon-next]
[also build test WARNING on linus/master v5.19-rc6 next-20220715]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Alexey-Klimov/watchdog-add-driver-for-StreamLabs-USB-watchdog-device/20220717-000621
base:   https://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-next
config: arc-randconfig-s032-20220717 (https://download.01.org/0day-ci/archive/20220717/202207170459.ZyslrGcE-lkp@intel.com/config)
compiler: arceb-elf-gcc (GCC) 12.1.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://github.com/intel-lab-lkp/linux/commit/897fbad1d3a4917a703454a9f79728c6af44d0a4
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Alexey-Klimov/watchdog-add-driver-for-StreamLabs-USB-watchdog-device/20220717-000621
        git checkout 897fbad1d3a4917a703454a9f79728c6af44d0a4
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=arc SHELL=/bin/bash drivers/watchdog/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> drivers/watchdog/streamlabs_wdt.c:70:23: sparse: sparse: restricted __le16 degrades to integer
>> drivers/watchdog/streamlabs_wdt.c:96:16: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short [usertype] @@     got restricted __le16 [usertype] @@
   drivers/watchdog/streamlabs_wdt.c:96:16: sparse:     expected unsigned short [usertype]
   drivers/watchdog/streamlabs_wdt.c:96:16: sparse:     got restricted __le16 [usertype]
   drivers/watchdog/streamlabs_wdt.c:97:16: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short [usertype] @@     got restricted __le16 [usertype] @@
   drivers/watchdog/streamlabs_wdt.c:97:16: sparse:     expected unsigned short [usertype]
   drivers/watchdog/streamlabs_wdt.c:97:16: sparse:     got restricted __le16 [usertype]
   drivers/watchdog/streamlabs_wdt.c:98:16: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short [usertype] @@     got restricted __le16 [usertype] @@
   drivers/watchdog/streamlabs_wdt.c:98:16: sparse:     expected unsigned short [usertype]
   drivers/watchdog/streamlabs_wdt.c:98:16: sparse:     got restricted __le16 [usertype]

vim +70 drivers/watchdog/streamlabs_wdt.c

    57	
    58	static bool nowayout = WATCHDOG_NOWAYOUT;
    59	module_param(nowayout, bool, 0);
    60	MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started (default="
    61				__MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
    62	
    63	/*
    64	 * This function is used to check if watchdog actually changed
    65	 * its state to disabled that is reported in first two bytes of response
    66	 * message.
    67	 */
    68	static int usb_streamlabs_wdt_check_stop(u16 *buf)
    69	{
  > 70		if (buf[0] != cpu_to_le16(STREAMLABS_CMD_STOP))
    71			return -EINVAL;
    72	
    73		return 0;
    74	}
    75	
    76	static int usb_streamlabs_wdt_validate_response(u8 *buf)
    77	{
    78		/*
    79		 * If watchdog device understood the command it will acknowledge
    80		 * with values 1,2,3,4 at indexes 10, 11, 12, 13 in response message
    81		 * when response treated as 8bit message.
    82		 */
    83		if (buf[10] != 1 || buf[11] != 2 || buf[12] != 3 || buf[13] != 4)
    84			return -EPROTO;
    85	
    86		return 0;
    87	}
    88	
    89	static void usb_streamlabs_wdt_prepare_buf(u16 *buf, u16 cmd,
    90							unsigned long timeout_msec)
    91	{
    92		/*
    93		 * remaining elements expected to be zero everytime during
    94		 * communication
    95		 */
  > 96		buf[0] = cpu_to_le16(cmd);
    97		buf[1] = cpu_to_le16(0x8000);
    98		buf[3] = cpu_to_le16(timeout_msec);
    99		buf[5] = 0x0;
   100		buf[6] = 0x0;
   101	}
   102	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
