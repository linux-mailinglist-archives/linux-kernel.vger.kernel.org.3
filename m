Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9099462EE2
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 09:50:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236053AbhK3IyJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 03:54:09 -0500
Received: from mga09.intel.com ([134.134.136.24]:9896 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232024AbhK3IyH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 03:54:07 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10183"; a="235997724"
X-IronPort-AV: E=Sophos;i="5.87,275,1631602800"; 
   d="scan'208";a="235997724"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2021 00:50:48 -0800
X-IronPort-AV: E=Sophos;i="5.87,275,1631602800"; 
   d="scan'208";a="540341256"
Received: from smile.fi.intel.com ([10.237.72.184])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2021 00:50:46 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1mrypZ-000OgP-Ju;
        Tue, 30 Nov 2021 10:49:41 +0200
Date:   Tue, 30 Nov 2021 10:49:41 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     kbuild@lists.01.org, lianzhi chang <changlianzhi@uniontech.com>,
        linux-kernel@vger.kernel.org, lkp@intel.com,
        kbuild-all@lists.01.org, dmitry.torokhov@gmail.com,
        gregkh@linuxfoundation.org, jirislaby@kernel.org, 282827961@qq.com
Subject: Re: [PATCH v18] tty: Fix the keyboard led light display problem
Message-ID: <YaXlpQdOHT2LEpPR@smile.fi.intel.com>
References: <20211129040445.24134-1-changlianzhi@uniontech.com>
 <202111291912.gGbp6mtv-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202111291912.gGbp6mtv-lkp@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 30, 2021 at 10:53:37AM +0300, Dan Carpenter wrote:
> Hi lianzhi,
> 
> url:    https://github.com/0day-ci/linux/commits/lianzhi-chang/tty-Fix-the-keyboard-led-light-display-problem/20211129-120853
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-testing
> config: i386-randconfig-m021-20211128 (https://download.01.org/0day-ci/archive/20211129/202111291912.gGbp6mtv-lkp@intel.com/config)
> compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> 
> New smatch warnings:
> drivers/tty/vt/keyboard.c:425 vt_set_leds_compute_shiftstate() warn: was && intended here instead of ||?

Indeed, how this had been tested?

> 560757cc1f5e54 drivers/tty/vt/keyboard.c lianzhi chang  2021-11-29 @425  	if (kb->kbdmode != VC_RAW ||
> 560757cc1f5e54 drivers/tty/vt/keyboard.c lianzhi chang  2021-11-29  426  		 kb->kbdmode != VC_MEDIUMRAW ||
> 560757cc1f5e54 drivers/tty/vt/keyboard.c lianzhi chang  2021-11-29  427  		 kb->kbdmode != VC_OFF) {
> 
> && was intended instead of ||.
> 
> 560757cc1f5e54 drivers/tty/vt/keyboard.c lianzhi chang  2021-11-29  428  		vt_switch = true;
> 63f24a7fafd448 drivers/tty/vt/keyboard.c Jiri Slaby     2021-01-05  429  		set_leds();
> 560757cc1f5e54 drivers/tty/vt/keyboard.c lianzhi chang  2021-11-29  430  	}

-- 
With Best Regards,
Andy Shevchenko


