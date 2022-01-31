Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 099764A408C
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 11:56:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239533AbiAaK4Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 05:56:24 -0500
Received: from mga04.intel.com ([192.55.52.120]:2925 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239344AbiAaK4X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 05:56:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643626583; x=1675162583;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=OuO1IfCUQIyBRQpisujqsE19OD9uCQ6nnnGF+2ZPWvc=;
  b=kJLj/JFZoBuNapXXAhscC6qMeouzCIhRxSYYL29DDmO2Z6OQBp/F2cv7
   iSt/o1MYFHGnNgyFf9MwmPdhyfYF9TxmHNrDu9ef0oNaV898VvqZLO35p
   a9dGbXHbdtxfqMDhFBH1VLMHrAp0W8QX8+jwXbv7yB9lknqftjy9DVZYP
   J72EOAyWk670Bj9855XUX/mffMHxkFwdsJcy+y4vqI1WMvSX9lxz2DC59
   vsi7ZmiObGj7dYeDmOg4wOp5/ot5+PINVJj6ik5rs7kQ/NUJ2jTO6oSw2
   kio41ovwfqt+yBpEgXM30PBYle0+9I8buL744aSz8sF4S4oBUliQR9KrX
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10243"; a="246271982"
X-IronPort-AV: E=Sophos;i="5.88,330,1635231600"; 
   d="scan'208";a="246271982"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2022 02:56:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,330,1635231600"; 
   d="scan'208";a="675691815"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 31 Jan 2022 02:56:20 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nEUM7-000Rnz-MA; Mon, 31 Jan 2022 10:56:19 +0000
Date:   Mon, 31 Jan 2022 18:55:39 +0800
From:   kernel test robot <lkp@intel.com>
To:     Yizhuo Zhai <yzhai003@ucr.edu>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-fbdev@vger.kernel.org, Xiyu Yang <xiyuyang19@fudan.edu.cn>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Helge Deller <deller@gmx.de>, Zheyu Ma <zheyuma97@gmail.com>,
        linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
        Yizhuo Zhai <yzhai003@ucr.edu>, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] fbdev: fbmem: Fix the implicit type casting
Message-ID: <202201311810.zlRDWfNU-lkp@intel.com>
References: <20220131065719.1552958-1-yzhai003@ucr.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220131065719.1552958-1-yzhai003@ucr.edu>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yizhuo,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on linus/master]
[also build test ERROR on v5.17-rc2 next-20220131]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Yizhuo-Zhai/fbdev-fbmem-Fix-the-implicit-type-casting/20220131-150528
base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 26291c54e111ff6ba87a164d85d4a4e134b7315c
config: x86_64-randconfig-a013-20220131 (https://download.01.org/0day-ci/archive/20220131/202201311810.zlRDWfNU-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 2cdbaca3943a4d6259119f185656328bd3805b68)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/b8f540468e70290c8278fc2611adc2f9b38f821f
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Yizhuo-Zhai/fbdev-fbmem-Fix-the-implicit-type-casting/20220131-150528
        git checkout b8f540468e70290c8278fc2611adc2f9b38f821f
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/video/fbdev/core/fbmem.c:1067:1: error: conflicting types for 'fb_blank'
   fb_blank(struct fb_info *info, unsigned long blank)
   ^
   include/linux/fb.h:591:12: note: previous declaration is here
   extern int fb_blank(struct fb_info *info, int blank);
              ^
   1 error generated.


vim +/fb_blank +1067 drivers/video/fbdev/core/fbmem.c

  1065	
  1066	int
> 1067	fb_blank(struct fb_info *info, unsigned long blank)
  1068	{
  1069		struct fb_event event;
  1070		int ret = -EINVAL;
  1071	
  1072		if (blank > FB_BLANK_POWERDOWN)
  1073			blank = FB_BLANK_POWERDOWN;
  1074	
  1075		event.info = info;
  1076		event.data = &blank;
  1077	
  1078		if (info->fbops->fb_blank)
  1079			ret = info->fbops->fb_blank(blank, info);
  1080	
  1081		if (!ret)
  1082			fb_notifier_call_chain(FB_EVENT_BLANK, &event);
  1083	
  1084		return ret;
  1085	}
  1086	EXPORT_SYMBOL(fb_blank);
  1087	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
