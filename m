Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F20A4FC3B3
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 19:53:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349019AbiDKRzt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 13:55:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348996AbiDKRzo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 13:55:44 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E798A35243
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 10:53:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649699609; x=1681235609;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ihSl53HmoW8V8tl9x2rDS+FtB+iBQEshKlFoJlDUI2o=;
  b=Vz1Q9BMofuPsLDPiXO1bYXYlHSfC1OE1ccWsoE59sw8ZVcl+VOFw05ju
   Uav/8b6+0JMhqI0d0+V9qcsXDQPf/FTps8QX3+F26/vSTdMYDX4w6hOYs
   qnMTKbfXU+qsJH/1GuPrifDLrXBdccEfAZ+gmwdZAHyImzTAMLugc77Jg
   ladC4em5q6IH1i0v/kVF7OXKaoUFW1DObEkNwi5VhTZ3hGgQlkYYTQ7uL
   GDRelN0Fen+mIQev77AHPs5uNqZhI6bJV3Qrkl3EvpIZxvTDX/rDE/LeL
   snJG5tV0eT/mHa9qkHWpjTEzY+27pFM5vl92T6XaPpb6ZAXHOgjBPgsJR
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10314"; a="249460409"
X-IronPort-AV: E=Sophos;i="5.90,252,1643702400"; 
   d="scan'208";a="249460409"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2022 10:53:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,252,1643702400"; 
   d="scan'208";a="525632417"
Received: from lkp-server02.sh.intel.com (HELO d3fc50ef50de) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 11 Apr 2022 10:53:26 -0700
Received: from kbuild by d3fc50ef50de with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1ndyEA-00022F-8o;
        Mon, 11 Apr 2022 17:53:26 +0000
Date:   Tue, 12 Apr 2022 01:53:02 +0800
From:   kernel test robot <lkp@intel.com>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Kees Cook <keescook@chromium.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     kbuild-all@lists.01.org,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] lkdtm/bugs: Don't expect thread termination without
 CONFIG_UBSAN_TRAP
Message-ID: <202204120139.6efSg72F-lkp@intel.com>
References: <7c2d2a48034223a95cf4346c5a2255a0b9b25670.1649688637.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7c2d2a48034223a95cf4346c5a2255a0b9b25670.1649688637.git.christophe.leroy@csgroup.eu>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christophe,

I love your patch! Yet something to improve:

[auto build test ERROR on char-misc/char-misc-testing]
[also build test ERROR on kees/for-next/pstore soc/for-next linus/master v5.18-rc2 next-20220411]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Christophe-Leroy/lkdtm-bugs-Don-t-expect-thread-termination-without-CONFIG_UBSAN_TRAP/20220411-225758
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git 3123109284176b1532874591f7c81f3837bbdc17
config: microblaze-buildonly-randconfig-r002-20220411 (https://download.01.org/0day-ci/archive/20220412/202204120139.6efSg72F-lkp@intel.com/config)
compiler: microblaze-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/50ed7d4c37c2080e281638b783a912193a02eed9
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Christophe-Leroy/lkdtm-bugs-Don-t-expect-thread-termination-without-CONFIG_UBSAN_TRAP/20220411-225758
        git checkout 50ed7d4c37c2080e281638b783a912193a02eed9
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=microblaze SHELL=/bin/bash drivers/misc/lkdtm/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/misc/lkdtm/bugs.c: In function 'lkdtm_ARRAY_BOUNDS':
>> drivers/misc/lkdtm/bugs.c:351:9: error: 'else' without a previous 'if'
     351 |         else
         |         ^~~~


vim +351 drivers/misc/lkdtm/bugs.c

   321	
   322	void lkdtm_ARRAY_BOUNDS(void)
   323	{
   324		struct array_bounds_flex_array *not_checked;
   325		struct array_bounds *checked;
   326		volatile int i;
   327	
   328		not_checked = kmalloc(sizeof(*not_checked) * 2, GFP_KERNEL);
   329		checked = kmalloc(sizeof(*checked) * 2, GFP_KERNEL);
   330	
   331		pr_info("Array access within bounds ...\n");
   332		/* For both, touch all bytes in the actual member size. */
   333		for (i = 0; i < sizeof(checked->data); i++)
   334			checked->data[i] = 'A';
   335		/*
   336		 * For the uninstrumented flex array member, also touch 1 byte
   337		 * beyond to verify it is correctly uninstrumented.
   338		 */
   339		for (i = 0; i < sizeof(not_checked->data) + 1; i++)
   340			not_checked->data[i] = 'A';
   341	
   342		pr_info("Array access beyond bounds ...\n");
   343		for (i = 0; i < sizeof(checked->data) + 1; i++)
   344			checked->data[i] = 'B';
   345	
   346		kfree(not_checked);
   347		kfree(checked);
   348		pr_err("FAIL: survived array bounds overflow!\n");
   349		if (IS_ENABLED(CONFIG_UBSAN_BOUNDS))
   350			pr_expected_config(CONFIG_UBSAN_TRAP);
 > 351		else
   352			pr_expected_config(CONFIG_UBSAN_BOUNDS);
   353	}
   354	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
