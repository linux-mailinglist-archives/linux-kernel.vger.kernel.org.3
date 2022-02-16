Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97B844B8696
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 12:24:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231463AbiBPLYu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 06:24:50 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230196AbiBPLYt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 06:24:49 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A60D12A94
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 03:24:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645010677; x=1676546677;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=WKeWYo3OrFlbW/B48YGMo66yFGWHV+Gg77NsB+U1VEI=;
  b=W2BATo8lMgbj3tdkADN+XgqfXtHDuKaUScF3vNRzF0wOmrnDucUswtvQ
   3JRtGmsZFe8U8102c3SAFaHTX9t431lOYdW0YaHAJbtf2ce0S+4qHcddv
   ItDKuZDT8BZXvnhKG4fEiYd/loFwVINnti629Un6Ui6v+0E3Zmg3lSgag
   EjvMmOT0l01GJoIxpQxn5cfmRTSD1T76Aa8hfnl64/2MWzEnsEXlsGhAJ
   FLBXrVAVvLXrB9kJOfaUZyyMWYwEURJMhX26ITzyUK1kmFowzvv2Uutre
   Knt81A8TND7pCc+jgKgHmmQGoxjEkoZIBpJxpj9FJIOUz2gU6tQP25ck1
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10259"; a="313855714"
X-IronPort-AV: E=Sophos;i="5.88,373,1635231600"; 
   d="scan'208";a="313855714"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2022 03:24:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,373,1635231600"; 
   d="scan'208";a="636444901"
Received: from lkp-server01.sh.intel.com (HELO d95dc2dabeb1) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 16 Feb 2022 03:24:35 -0800
Received: from kbuild by d95dc2dabeb1 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nKIQE-000Akk-UE; Wed, 16 Feb 2022 11:24:34 +0000
Date:   Wed, 16 Feb 2022 19:24:21 +0800
From:   kernel test robot <lkp@intel.com>
To:     Tong Zhang <ztong0001@gmail.com>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        linux-kernel@vger.kernel.org
Cc:     kbuild-all@lists.01.org, Tong Zhang <ztong0001@gmail.com>
Subject: Re: [PATCH] platform/chrome: cros_ec: honor acpi=off
Message-ID: <202202161903.6YHDLR8F-lkp@intel.com>
References: <20220216062601.779690-1-ztong0001@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220216062601.779690-1-ztong0001@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tong,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on chrome-platform/for-next]
[also build test WARNING on v5.17-rc4 next-20220216]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Tong-Zhang/platform-chrome-cros_ec-honor-acpi-off/20220216-142709
base:   https://git.kernel.org/pub/scm/linux/kernel/git/chrome-platform/linux.git for-next
config: i386-randconfig-a001 (https://download.01.org/0day-ci/archive/20220216/202202161903.6YHDLR8F-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://github.com/0day-ci/linux/commit/66345a4aecd6e4acba257476c6e44559fccca143
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Tong-Zhang/platform-chrome-cros_ec-honor-acpi-off/20220216-142709
        git checkout 66345a4aecd6e4acba257476c6e44559fccca143
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash drivers/platform/chrome/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/platform/chrome/cros_ec_lpc.c: In function 'cros_ec_lpc_init':
>> drivers/platform/chrome/cros_ec_lpc.c:553:6: warning: the address of 'acpi_disable' will always evaluate as 'true' [-Waddress]
     553 |  if (acpi_disable)
         |      ^~~~~~~~~~~~


vim +553 drivers/platform/chrome/cros_ec_lpc.c

   547	
   548	static int __init cros_ec_lpc_init(void)
   549	{
   550		int ret;
   551		acpi_status status;
   552	
 > 553		if (acpi_disable)
   554			return -ENODEV;
   555	
   556		status = acpi_get_devices(ACPI_DRV_NAME, cros_ec_lpc_parse_device,
   557					  &cros_ec_lpc_acpi_device_found, NULL);
   558		if (ACPI_FAILURE(status))
   559			pr_warn(DRV_NAME ": Looking for %s failed\n", ACPI_DRV_NAME);
   560	
   561		if (!cros_ec_lpc_acpi_device_found &&
   562		    !dmi_check_system(cros_ec_lpc_dmi_table)) {
   563			pr_err(DRV_NAME ": unsupported system.\n");
   564			return -ENODEV;
   565		}
   566	
   567		cros_ec_lpc_mec_init(EC_HOST_CMD_REGION0,
   568				     EC_LPC_ADDR_MEMMAP + EC_MEMMAP_SIZE);
   569	
   570		/* Register the driver */
   571		ret = platform_driver_register(&cros_ec_lpc_driver);
   572		if (ret) {
   573			pr_err(DRV_NAME ": can't register driver: %d\n", ret);
   574			cros_ec_lpc_mec_destroy();
   575			return ret;
   576		}
   577	
   578		if (!cros_ec_lpc_acpi_device_found) {
   579			/* Register the device, and it'll get hooked up automatically */
   580			ret = platform_device_register(&cros_ec_lpc_device);
   581			if (ret) {
   582				pr_err(DRV_NAME ": can't register device: %d\n", ret);
   583				platform_driver_unregister(&cros_ec_lpc_driver);
   584				cros_ec_lpc_mec_destroy();
   585			}
   586		}
   587	
   588		return ret;
   589	}
   590	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
