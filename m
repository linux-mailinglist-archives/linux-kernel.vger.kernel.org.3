Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A89894A5344
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 00:32:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229596AbiAaXcG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 18:32:06 -0500
Received: from mga05.intel.com ([192.55.52.43]:20760 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229584AbiAaXcF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 18:32:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643671925; x=1675207925;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=s4qd5/3eVmC0zxoBFfHu2I1L/M6RmoRcjQxyASVjkfo=;
  b=So4zsVcqnLyA8lFoQShkBZIiD7439TkRwF4XyAbo/XX010aTjNE9Lird
   zEycTfPSJOaav3kLYVupqEywObsOKLWupKMqcwUa0mOeJKAOsbb/6WvfO
   i08aoQgylRcpxqy+o6SDpgNkXVOfGmDhqpaLszpWutsHWBSP7jcREjrkz
   jM9dKlXV4OtFZoHQ+p3XND+ZYZScpbaxtfpGCWO1TTuppRkrzG6POO0hG
   /sNtohPn7CIKyBoLA0lt2MzCpKTFmsV7nO6GoQK5YH+cA7Urw27ySH8FX
   iIP/ZIkT5ysR33EVHjMZt21FWPSfLFdPTZp5Pa4rDqNhnpyS5GrUOvJwT
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10244"; a="333931316"
X-IronPort-AV: E=Sophos;i="5.88,332,1635231600"; 
   d="scan'208";a="333931316"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2022 15:32:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,332,1635231600"; 
   d="scan'208";a="619554614"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 31 Jan 2022 15:31:54 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nEg9K-000SSc-AF; Mon, 31 Jan 2022 23:31:54 +0000
Date:   Tue, 1 Feb 2022 07:31:43 +0800
From:   kernel test robot <lkp@intel.com>
To:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        DRI Development <dri-devel@lists.freedesktop.org>
Cc:     kbuild-all@lists.01.org, linux-fbdev@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Du Cheng <ducheng2@gmail.com>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [Intel-gfx] [PATCH 13/21] fbcon: move more common code into
 fb_open()
Message-ID: <202202010613.HT19HztX-lkp@intel.com>
References: <20220131210552.482606-14-daniel.vetter@ffwll.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220131210552.482606-14-daniel.vetter@ffwll.ch>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

I love your patch! Perhaps something to improve:

[auto build test WARNING on tegra-drm/drm/tegra/for-next]
[also build test WARNING on drm/drm-next linus/master v5.17-rc2 next-20220131]
[cannot apply to airlied/drm-next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Daniel-Vetter/some-fbcon-patches-mostly-locking/20220201-050907
base:   git://anongit.freedesktop.org/tegra/linux.git drm/tegra/for-next
config: mips-allyesconfig (https://download.01.org/0day-ci/archive/20220201/202202010613.HT19HztX-lkp@intel.com/config)
compiler: mips-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/7a27c0ce71acfa8b67787d298de9836376fcc323
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Daniel-Vetter/some-fbcon-patches-mostly-locking/20220201-050907
        git checkout 7a27c0ce71acfa8b67787d298de9836376fcc323
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=mips SHELL=/bin/bash drivers/video/fbdev/core/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/video/fbdev/core/fbcon.c: In function 'con2fb_acquire_newinfo':
>> drivers/video/fbdev/core/fbcon.c:721:27: warning: variable 'ops' set but not used [-Wunused-but-set-variable]
     721 |         struct fbcon_ops *ops = NULL;
         |                           ^~~


vim +/ops +721 drivers/video/fbdev/core/fbcon.c

^1da177e4c3f415 drivers/video/console/fbcon.c    Linus Torvalds     2005-04-16  717  
^1da177e4c3f415 drivers/video/console/fbcon.c    Linus Torvalds     2005-04-16  718  static int con2fb_acquire_newinfo(struct vc_data *vc, struct fb_info *info,
7a27c0ce71acfa8 drivers/video/fbdev/core/fbcon.c Daniel Vetter      2022-01-31  719  				  int unit)
^1da177e4c3f415 drivers/video/console/fbcon.c    Linus Torvalds     2005-04-16  720  {
^1da177e4c3f415 drivers/video/console/fbcon.c    Linus Torvalds     2005-04-16 @721  	struct fbcon_ops *ops = NULL;
ba35a78b17408b6 drivers/video/fbdev/core/fbcon.c Daniel Vetter      2022-01-31  722  	int err;
^1da177e4c3f415 drivers/video/console/fbcon.c    Linus Torvalds     2005-04-16  723  
ba35a78b17408b6 drivers/video/fbdev/core/fbcon.c Daniel Vetter      2022-01-31  724  	err = fbcon_open(info);
ba35a78b17408b6 drivers/video/fbdev/core/fbcon.c Daniel Vetter      2022-01-31  725  	if (err)
ba35a78b17408b6 drivers/video/fbdev/core/fbcon.c Daniel Vetter      2022-01-31  726  		return err;
^1da177e4c3f415 drivers/video/console/fbcon.c    Linus Torvalds     2005-04-16  727  
7a27c0ce71acfa8 drivers/video/fbdev/core/fbcon.c Daniel Vetter      2022-01-31  728  	ops = info->fbcon_par;
d1baa4ffa677bf6 drivers/video/console/fbcon.c    Antonino A. Daplas 2007-07-17  729  
d1baa4ffa677bf6 drivers/video/console/fbcon.c    Antonino A. Daplas 2007-07-17  730  	if (vc)
b73deed32d08740 drivers/video/console/fbcon.c    Antonino A. Daplas 2006-01-09  731  		set_blitting_type(vc, info);
^1da177e4c3f415 drivers/video/console/fbcon.c    Linus Torvalds     2005-04-16  732  
^1da177e4c3f415 drivers/video/console/fbcon.c    Linus Torvalds     2005-04-16  733  	return err;
^1da177e4c3f415 drivers/video/console/fbcon.c    Linus Torvalds     2005-04-16  734  }
^1da177e4c3f415 drivers/video/console/fbcon.c    Linus Torvalds     2005-04-16  735  

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
