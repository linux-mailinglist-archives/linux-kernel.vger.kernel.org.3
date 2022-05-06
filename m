Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B83D51DFDB
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 21:57:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351635AbiEFUBP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 16:01:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1392202AbiEFUBD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 16:01:03 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B3185F270
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 12:57:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651867039; x=1683403039;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=fYx0jVPAY26QYp8frW2LMbGHUaazdt9/1xBg56xLgF0=;
  b=fJjHb77yU9eKpLBR6sNiWGKcnt80j/UXUh33fy6Ul+h+FLFZKldKOlFM
   qRM/Q3ZFy1xA57BkykRyR96IKBwgP1Y0VxYUq9lYETpytDzO5Qqj/ZEdc
   GMGL5r0u/FO4+kwZM6+Iu2z8mL3wE/jSsj492dOklgfqJ+ZLKCBiTUxQW
   xzmIL77lb8cpE0ltmfZoaTErlvJxAl7SvVzyWsiyKj3tyenhE7os/6gvh
   Ev6L3odUTVHqUbAc5CKQQTUr2eS4ixvlZ1fC9Xeabd9TETniByzG+rEzA
   nV4OH2zqboEkGBze6hHQIOnVXJH7IB47azBfpPWbnEfw4mztyBMiABhuB
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10339"; a="293773285"
X-IronPort-AV: E=Sophos;i="5.91,205,1647327600"; 
   d="scan'208";a="293773285"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2022 12:57:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,205,1647327600"; 
   d="scan'208";a="518204464"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 06 May 2022 12:57:15 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nn44g-000DpX-VR;
        Fri, 06 May 2022 19:57:14 +0000
Date:   Sat, 7 May 2022 03:56:51 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jagdish Gediya <jvgediya@linux.ibm.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        rafael@kernel.org, akpm@linux-foundation.org
Cc:     kbuild-all@lists.01.org, keescook@chromium.org,
        andriy.shevchenko@linux.intel.com, geert@linux-m68k.org,
        linux@roeck-us.net, adobriyan@gmail.com,
        Jagdish Gediya <jvgediya@linux.ibm.com>
Subject: Re: [PATCH] kobject: Refactor kobject_set_name_vargs()
Message-ID: <202205070311.4T8ZKSWq-lkp@intel.com>
References: <20220506133309.36794-1-jvgediya@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220506133309.36794-1-jvgediya@linux.ibm.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jagdish,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on driver-core/driver-core-testing]
[also build test WARNING on hnaz-mm/master linux/master linus/master v5.18-rc5 next-20220506]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Jagdish-Gediya/kobject-Refactor-kobject_set_name_vargs/20220506-213448
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git bc443c31def574e3bfaed50cb493b8305ad79435
config: um-i386_defconfig (https://download.01.org/0day-ci/archive/20220507/202205070311.4T8ZKSWq-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.2.0-20) 11.2.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/4aac95bc8a052e61d5013a25a2099ed711e88fde
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Jagdish-Gediya/kobject-Refactor-kobject_set_name_vargs/20220506-213448
        git checkout 4aac95bc8a052e61d5013a25a2099ed711e88fde
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=um SUBARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   mm/util.c: In function 'set_name_vargs':
>> mm/util.c:128:9: warning: function 'set_name_vargs' might be a candidate for 'gnu_printf' format attribute [-Wsuggest-attribute=format]
     128 |         s = kvasprintf_const(GFP_KERNEL, fmt, vargs);
         |         ^


vim +128 mm/util.c

   114	
   115	/**
   116	 * set_name_vargs() - Set the name as per format
   117	 * @name: pointer to point to the name as per format
   118	 * @fmt: format string used to build the name
   119	 * @vargs: vargs to format the string.
   120	 */
   121	int set_name_vargs(const char **name, const char *fmt, va_list vargs)
   122	{
   123		const char *s;
   124	
   125		if (*name && !fmt)
   126			return 0;
   127	
 > 128		s = kvasprintf_const(GFP_KERNEL, fmt, vargs);
   129		if (!s)
   130			return -ENOMEM;
   131	
   132		/*
   133		 * ewww... some of these buggers have '/' in the name ... If
   134		 * that's the case, we need to make sure we have an actual
   135		 * allocated copy to modify, since kvasprintf_const may have
   136		 * returned something from .rodata.
   137		 */
   138		if (strchr(s, '/')) {
   139			char *t;
   140	
   141			t = kstrdup(s, GFP_KERNEL);
   142			kfree_const(s);
   143			if (!t)
   144				return -ENOMEM;
   145			strreplace(t, '/', '!');
   146			s = t;
   147		}
   148		kfree_const(*name);
   149		*name = s;
   150	
   151		return 0;
   152	}
   153	EXPORT_SYMBOL(set_name_vargs);
   154	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
