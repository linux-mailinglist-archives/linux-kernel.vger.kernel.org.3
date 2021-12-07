Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CF2B46C2F6
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 19:35:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240583AbhLGSjY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 13:39:24 -0500
Received: from mga03.intel.com ([134.134.136.65]:12289 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236023AbhLGSjW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 13:39:22 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10190"; a="237598846"
X-IronPort-AV: E=Sophos;i="5.87,295,1631602800"; 
   d="scan'208";a="237598846"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2021 10:23:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,295,1631602800"; 
   d="scan'208";a="542902061"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 07 Dec 2021 10:23:11 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1muf7O-000Mqn-Ef; Tue, 07 Dec 2021 18:23:10 +0000
Date:   Wed, 8 Dec 2021 02:22:56 +0800
From:   kernel test robot <lkp@intel.com>
To:     Michael Straube <straube.linux@gmail.com>,
        gregkh@linuxfoundation.org
Cc:     kbuild-all@lists.01.org, Larry.Finger@lwfinger.net,
        phil@philpotter.co.uk, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: Re: [PATCH v2] staging: r8188eu: convert type of HalData in struct
 adapter
Message-ID: <202112080251.yDzenEtM-lkp@intel.com>
References: <20211207140405.8673-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211207140405.8673-1-straube.linux@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michael,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on staging/staging-testing]

url:    https://github.com/0day-ci/linux/commits/Michael-Straube/staging-r8188eu-convert-type-of-HalData-in-struct-adapter/20211207-220628
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git c601ab0eb478f66ca30efd2534a818f3d1b91a25
config: nios2-allyesconfig (https://download.01.org/0day-ci/archive/20211208/202112080251.yDzenEtM-lkp@intel.com/config)
compiler: nios2-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/056bebd5149575caa282e91f6bab60f936c06484
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Michael-Straube/staging-r8188eu-convert-type-of-HalData-in-struct-adapter/20211207-220628
        git checkout 056bebd5149575caa282e91f6bab60f936c06484
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=nios2 SHELL=/bin/bash drivers/staging/r8188eu/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All error/warnings (new ones prefixed by >>):

   drivers/staging/r8188eu/hal/rtl8188eu_led.c: In function 'SwLedOff':
>> drivers/staging/r8188eu/hal/rtl8188eu_led.c:39:45: error: implicit declaration of function 'GET_HAL_DATA' [-Werror=implicit-function-declaration]
      39 |         struct hal_data_8188e   *pHalData = GET_HAL_DATA(padapter);
         |                                             ^~~~~~~~~~~~
>> drivers/staging/r8188eu/hal/rtl8188eu_led.c:39:45: warning: initialization of 'struct hal_data_8188e *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
   cc1: some warnings being treated as errors
--
   drivers/staging/r8188eu/hal/usb_halinit.c: In function '_ReadLEDSetting':
>> drivers/staging/r8188eu/hal/usb_halinit.c:946:44: error: implicit declaration of function 'GET_HAL_DATA' [-Werror=implicit-function-declaration]
     946 |         struct hal_data_8188e   *haldata = GET_HAL_DATA(Adapter);
         |                                            ^~~~~~~~~~~~
>> drivers/staging/r8188eu/hal/usb_halinit.c:946:44: warning: initialization of 'struct hal_data_8188e *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
   cc1: some warnings being treated as errors


vim +/GET_HAL_DATA +39 drivers/staging/r8188eu/hal/rtl8188eu_led.c

8cd574e6af5463 Phillip Potter 2021-07-28  33  
8cd574e6af5463 Phillip Potter 2021-07-28  34  /*	Description: */
8cd574e6af5463 Phillip Potter 2021-07-28  35  /*		Turn off LED according to LedPin specified. */
8cd574e6af5463 Phillip Potter 2021-07-28  36  void SwLedOff(struct adapter *padapter, struct LED_871x *pLed)
8cd574e6af5463 Phillip Potter 2021-07-28  37  {
8cd574e6af5463 Phillip Potter 2021-07-28  38  	u8	LedCfg;
8cd574e6af5463 Phillip Potter 2021-07-28 @39  	struct hal_data_8188e	*pHalData = GET_HAL_DATA(padapter);
8cd574e6af5463 Phillip Potter 2021-07-28  40  
8cd574e6af5463 Phillip Potter 2021-07-28  41  	if (padapter->bSurpriseRemoved || padapter->bDriverStopped)
8cd574e6af5463 Phillip Potter 2021-07-28  42  		goto exit;
8cd574e6af5463 Phillip Potter 2021-07-28  43  
8cd574e6af5463 Phillip Potter 2021-07-28  44  	LedCfg = rtw_read8(padapter, REG_LEDCFG2);/* 0x4E */
8cd574e6af5463 Phillip Potter 2021-07-28  45  
8cd574e6af5463 Phillip Potter 2021-07-28  46  	switch (pLed->LedPin) {
8cd574e6af5463 Phillip Potter 2021-07-28  47  	case LED_PIN_LED0:
8cd574e6af5463 Phillip Potter 2021-07-28  48  		if (pHalData->bLedOpenDrain) {
8cd574e6af5463 Phillip Potter 2021-07-28  49  			/*  Open-drain arrangement for controlling the LED) */
8cd574e6af5463 Phillip Potter 2021-07-28  50  			LedCfg &= 0x90; /*  Set to software control. */
dcda94c9412a07 Larry Finger   2021-08-10  51  			rtw_write8(padapter, REG_LEDCFG2, (LedCfg | BIT(3)));
8cd574e6af5463 Phillip Potter 2021-07-28  52  			LedCfg = rtw_read8(padapter, REG_MAC_PINMUX_CFG);
8cd574e6af5463 Phillip Potter 2021-07-28  53  			LedCfg &= 0xFE;
8cd574e6af5463 Phillip Potter 2021-07-28  54  			rtw_write8(padapter, REG_MAC_PINMUX_CFG, LedCfg);
8cd574e6af5463 Phillip Potter 2021-07-28  55  		} else {
dcda94c9412a07 Larry Finger   2021-08-10  56  			rtw_write8(padapter, REG_LEDCFG2, (LedCfg | BIT(3) | BIT(5) | BIT(6)));
8cd574e6af5463 Phillip Potter 2021-07-28  57  		}
8cd574e6af5463 Phillip Potter 2021-07-28  58  		break;
8cd574e6af5463 Phillip Potter 2021-07-28  59  	case LED_PIN_LED1:
8cd574e6af5463 Phillip Potter 2021-07-28  60  		LedCfg &= 0x0f; /*  Set to software control. */
dcda94c9412a07 Larry Finger   2021-08-10  61  		rtw_write8(padapter, REG_LEDCFG2, (LedCfg | BIT(3)));
8cd574e6af5463 Phillip Potter 2021-07-28  62  		break;
8cd574e6af5463 Phillip Potter 2021-07-28  63  	default:
8cd574e6af5463 Phillip Potter 2021-07-28  64  		break;
8cd574e6af5463 Phillip Potter 2021-07-28  65  	}
8cd574e6af5463 Phillip Potter 2021-07-28  66  exit:
8cd574e6af5463 Phillip Potter 2021-07-28  67  	pLed->bLedOn = false;
8cd574e6af5463 Phillip Potter 2021-07-28  68  }
8cd574e6af5463 Phillip Potter 2021-07-28  69  

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
