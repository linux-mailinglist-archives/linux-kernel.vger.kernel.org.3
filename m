Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35AF046AFF9
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 02:43:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235169AbhLGBq6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 20:46:58 -0500
Received: from mga04.intel.com ([192.55.52.120]:42782 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234761AbhLGBq5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 20:46:57 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10190"; a="236190974"
X-IronPort-AV: E=Sophos;i="5.87,293,1631602800"; 
   d="scan'208";a="236190974"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2021 17:43:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,293,1631602800"; 
   d="scan'208";a="461060818"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 06 Dec 2021 17:43:25 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1muPVs-000LyS-Tw; Tue, 07 Dec 2021 01:43:24 +0000
Date:   Tue, 7 Dec 2021 09:42:46 +0800
From:   kernel test robot <lkp@intel.com>
To:     Yauhen Kharuzhy <jekhor@gmail.com>
Cc:     kbuild-all@lists.01.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: [pdx86-platform-drivers-x86:review-hans 41/44]
 drivers/platform/x86/lenovo-yogabook-wmi.c:278:20: warning: no previous
 prototype for 'yogabook_wmi_suspend'
Message-ID: <202112070945.X05c2wgI-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git review-hans
head:   cb01df9ef827442739051c6457962a5c6bc85d99
commit: 4709e8b835ec25e8627844e9927804f814b64fd4 [41/44] platform/x86: lenovo-yogabook-wmi: Add driver for Lenovo Yoga Book
config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20211207/202112070945.X05c2wgI-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/commit/?id=4709e8b835ec25e8627844e9927804f814b64fd4
        git remote add pdx86-platform-drivers-x86 https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git
        git fetch --no-tags pdx86-platform-drivers-x86 review-hans
        git checkout 4709e8b835ec25e8627844e9927804f814b64fd4
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/platform/x86/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/platform/x86/lenovo-yogabook-wmi.c:278:20: warning: no previous prototype for 'yogabook_wmi_suspend' [-Wmissing-prototypes]
     278 | __maybe_unused int yogabook_wmi_suspend(struct device *dev)
         |                    ^~~~~~~~~~~~~~~~~~~~
>> drivers/platform/x86/lenovo-yogabook-wmi.c:294:20: warning: no previous prototype for 'yogabook_wmi_resume' [-Wmissing-prototypes]
     294 | __maybe_unused int yogabook_wmi_resume(struct device *dev)
         |                    ^~~~~~~~~~~~~~~~~~~


vim +/yogabook_wmi_suspend +278 drivers/platform/x86/lenovo-yogabook-wmi.c

   277	
 > 278	__maybe_unused int yogabook_wmi_suspend(struct device *dev)
   279	{
   280		struct wmi_device *wdev = container_of(dev, struct wmi_device, dev);
   281		struct yogabook_wmi *data = dev_get_drvdata(dev);
   282	
   283		set_bit(YB_SUSPENDED, &data->flags);
   284	
   285		flush_work(&data->work);
   286	
   287		/* Turn off the pen button at sleep */
   288		if (test_bit(YB_DIGITIZER_IS_ON, &data->flags))
   289			yogabook_wmi_do_action(wdev, YB_PAD_DISABLE);
   290	
   291		return 0;
   292	}
   293	
 > 294	__maybe_unused int yogabook_wmi_resume(struct device *dev)
   295	{
   296		struct wmi_device *wdev = container_of(dev, struct wmi_device, dev);
   297		struct yogabook_wmi *data = dev_get_drvdata(dev);
   298	
   299		if (test_bit(YB_KBD_IS_ON, &data->flags)) {
   300			/* Ensure keyboard touchpad is on before we call KBLC() */
   301			acpi_device_set_power(data->kbd_adev, ACPI_STATE_D0);
   302			yogabook_wmi_set_kbd_backlight(wdev, data->brightness);
   303		}
   304	
   305		if (test_bit(YB_DIGITIZER_IS_ON, &data->flags))
   306			yogabook_wmi_do_action(wdev, YB_PAD_ENABLE);
   307	
   308		clear_bit(YB_SUSPENDED, &data->flags);
   309	
   310		return 0;
   311	}
   312	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
