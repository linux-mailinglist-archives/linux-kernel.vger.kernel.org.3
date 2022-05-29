Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C79253708C
	for <lists+linux-kernel@lfdr.de>; Sun, 29 May 2022 12:41:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229863AbiE2Klb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 May 2022 06:41:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbiE2Kl1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 May 2022 06:41:27 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 975B0D5D
        for <linux-kernel@vger.kernel.org>; Sun, 29 May 2022 03:41:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653820886; x=1685356886;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=RhzFy5pg/tIuJp3q1yzkgGHs/t6BR0DQa5KiWBHW3Do=;
  b=k6IK9HzqrfKewReEuRp80pgUPKhhxcom8uX85X/+meID7zX8yU5/G4ZM
   hkP1ITV/fEXfrEcEpOWxQwf/N5dtPnrSe3XUqSdjGTNJRkVHNFV7sqJIO
   1iJiAWZnmGffNf7Jjos1XDghI7bxxEBXqY8OkvsIaQHNrVQsQZMh2boWc
   tLHeFuZGxQjdQmeqqC8g3KEtU1IoPZHWgUpBv1hoRBdLjFn8ZNwvThs5M
   yxLhqGGUu8EqRqr+tuT1WkFVXiqQcJ+0bBzwMB5er9eboSCTilcVSxN0e
   9K02PSDzPO07Ui5vVTMNboBWmNC/LipTj4CnW3FBeG0PghWH3eKODXNAu
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10361"; a="300131487"
X-IronPort-AV: E=Sophos;i="5.91,260,1647327600"; 
   d="scan'208";a="300131487"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2022 03:41:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,260,1647327600"; 
   d="scan'208";a="903164420"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 29 May 2022 03:41:23 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nvGMM-0000xP-Nk;
        Sun, 29 May 2022 10:41:22 +0000
Date:   Sun, 29 May 2022 18:40:31 +0800
From:   kernel test robot <lkp@intel.com>
To:     Raghu Bankapur <quic_rbankapu@quicinc.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Cc:     kbuild-all@lists.01.org, Krishna Jha <quic_kkishorj@quicinc.com>
Subject: Re: [PATCH V0 1/1] asoc: msm: use hashtable to check kcontrol
Message-ID: <202205291859.r117Eo4k-lkp@intel.com>
References: <ad55bbd41cc253acb9af6ac068c15dd1545ecd81.1653813866.git.quic_rbankapu@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ad55bbd41cc253acb9af6ac068c15dd1545ecd81.1653813866.git.quic_rbankapu@quicinc.com>
X-Spam-Status: No, score=-7.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Raghu,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on tiwai-sound/for-next]
[also build test WARNING on broonie-sound/for-next v5.18 next-20220527]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Raghu-Bankapur/asoc-msm-use-hashtable-to-check-kcontrol/20220529-165246
base:   https://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git for-next
config: m68k-allyesconfig (https://download.01.org/0day-ci/archive/20220529/202205291859.r117Eo4k-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/244d3a3d274761ea83000880d73cc9b0a01b2a4a
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Raghu-Bankapur/asoc-msm-use-hashtable-to-check-kcontrol/20220529-165246
        git checkout 244d3a3d274761ea83000880d73cc9b0a01b2a4a
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=m68k SHELL=/bin/bash sound/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> sound/core/control.c:375:14: warning: no previous prototype for 'snd_ctl_strtoint' [-Wmissing-prototypes]
     375 | unsigned int snd_ctl_strtoint(const char *s)
         |              ^~~~~~~~~~~~~~~~


vim +/snd_ctl_strtoint +375 sound/core/control.c

   373	
   374	/* Used to convert the string into int value -- BKDRHash */
 > 375	unsigned int snd_ctl_strtoint(const char *s)
   376	{
   377		unsigned int res = 0;
   378	
   379		while (*s)
   380			res = (res << 5) - res + (*s++);
   381	
   382		return (res & 0x7FFFFFFF);
   383	}
   384	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
