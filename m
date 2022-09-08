Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45B065B1EAF
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 15:24:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231694AbiIHNYY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 09:24:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232257AbiIHNYS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 09:24:18 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 781B081B00
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 06:24:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662643457; x=1694179457;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=JI0iC3v/vlHxorGrC7sMLc0TK32WCXsVHt6/1in4PCk=;
  b=bWdG+qXXSPQGCg6gfA7416K0wQVHC2R954PYRSV3T+FOvTKKz5lzKqbL
   ra7593r72sSsCV9Qa0ogAp5QFpnkVc3ZnYkvfEaIkkcSV+DFZgvxyHnhg
   JHTYq0ujOgbF22s1hXwrdkjmRIjsRM2weqXB+0b5OIgEmuHrpk3VWf6Xy
   tfoEYL5gbh8LAq+j556K/zGOtm90zK4g4fNHdXSpnoN2nBjY6eToSDVTW
   wIQaPpUU4W9m7NRdU+hdXYhgB93sRa5BXWMId+TGX9FkqBj0sGjBWPwju
   o0pr3BLnzlB/TwrYu3X8iJbpwu9MfjMR9x/8LlNw7PYcIB9hMEnvuU1vs
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10463"; a="276900042"
X-IronPort-AV: E=Sophos;i="5.93,300,1654585200"; 
   d="scan'208";a="276900042"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2022 06:24:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,300,1654585200"; 
   d="scan'208";a="683231457"
Received: from lkp-server02.sh.intel.com (HELO 95dfd251caa2) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 08 Sep 2022 06:24:15 -0700
Received: from kbuild by 95dfd251caa2 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oWHVp-0007n3-2A;
        Thu, 08 Sep 2022 13:24:09 +0000
Date:   Thu, 8 Sep 2022 21:23:57 +0800
From:   kernel test robot <lkp@intel.com>
To:     Hangyu Hua <hbh25y@gmail.com>, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, changlianzhi@uniontech.com,
        dmitry.torokhov@gmail.com
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Hangyu Hua <hbh25y@gmail.com>
Subject: Re: [PATCH] tty: vt: add a bounds checking in vt_do_kdgkb_ioctl()
Message-ID: <202209082101.rCth0nPs-lkp@intel.com>
References: <20220908075403.27930-1-hbh25y@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220908075403.27930-1-hbh25y@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hangyu,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on tty/tty-testing]
[also build test WARNING on linus/master v6.0-rc4 next-20220908]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Hangyu-Hua/tty-vt-add-a-bounds-checking-in-vt_do_kdgkb_ioctl/20220908-155511
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-testing
config: x86_64-randconfig-a005 (https://download.01.org/0day-ci/archive/20220908/202209082101.rCth0nPs-lkp@intel.com/config)
compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project f28c006a5895fc0e329fe15fead81e37457cb1d1)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/9878c90ddacf7a81079f77b10502496c4d6cd0cb
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Hangyu-Hua/tty-vt-add-a-bounds-checking-in-vt_do_kdgkb_ioctl/20220908-155511
        git checkout 9878c90ddacf7a81079f77b10502496c4d6cd0cb
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/tty/vt/ fs/ext4/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/tty/vt/keyboard.c:2070:14: warning: result of comparison of constant 256 with expression of type 'unsigned char' is always false [-Wtautological-constant-out-of-range-compare]
           if (kb_func >= MAX_NR_FUNC)
               ~~~~~~~ ^  ~~~~~~~~~~~
   1 warning generated.


vim +2070 drivers/tty/vt/keyboard.c

  2059	
  2060	int vt_do_kdgkb_ioctl(int cmd, struct kbsentry __user *user_kdgkb, int perm)
  2061	{
  2062		unsigned char kb_func;
  2063		unsigned long flags;
  2064		char *kbs;
  2065		int ret;
  2066	
  2067		if (get_user(kb_func, &user_kdgkb->kb_func))
  2068			return -EFAULT;
  2069	
> 2070		if (kb_func >= MAX_NR_FUNC)
  2071			return -EFAULT;
  2072	
  2073		kb_func = array_index_nospec(kb_func, MAX_NR_FUNC);
  2074	
  2075		switch (cmd) {
  2076		case KDGKBSENT: {
  2077			/* size should have been a struct member */
  2078			ssize_t len = sizeof(user_kdgkb->kb_string);
  2079	
  2080			kbs = kmalloc(len, GFP_KERNEL);
  2081			if (!kbs)
  2082				return -ENOMEM;
  2083	
  2084			spin_lock_irqsave(&func_buf_lock, flags);
  2085			len = strlcpy(kbs, func_table[kb_func] ? : "", len);
  2086			spin_unlock_irqrestore(&func_buf_lock, flags);
  2087	
  2088			ret = copy_to_user(user_kdgkb->kb_string, kbs, len + 1) ?
  2089				-EFAULT : 0;
  2090	
  2091			break;
  2092		}
  2093		case KDSKBSENT:
  2094			if (!perm || !capable(CAP_SYS_TTY_CONFIG))
  2095				return -EPERM;
  2096	
  2097			kbs = strndup_user(user_kdgkb->kb_string,
  2098					sizeof(user_kdgkb->kb_string));
  2099			if (IS_ERR(kbs))
  2100				return PTR_ERR(kbs);
  2101	
  2102			spin_lock_irqsave(&func_buf_lock, flags);
  2103			kbs = vt_kdskbsent(kbs, kb_func);
  2104			spin_unlock_irqrestore(&func_buf_lock, flags);
  2105	
  2106			ret = 0;
  2107			break;
  2108		}
  2109	
  2110		kfree(kbs);
  2111	
  2112		return ret;
  2113	}
  2114	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
