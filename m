Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11CD9538AB7
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 06:50:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243886AbiEaErE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 00:47:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238541AbiEaErB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 00:47:01 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E79F10FF2
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 21:46:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653972419; x=1685508419;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Qn+cuAzxBVUymorN0NpF3cWBtZUAaq3foyRv2NhaqB8=;
  b=mYNs1FjECJ41ju4wCd5x02pFUrPfT68m5jL2DUpBR+yQQiwFm+RAupE3
   s8nrZbA2fJo9nq2MeMiQ7uY2+HG1QGI+20/jS2abdbxDuULiGgzWDZ+EE
   UbfjkzcOwDGyC3NXyBzbtQHc+NVVrK51NUVfpcLqixq5QCkXn6gdOEXts
   VHc5mDJIy5BZuW86QYq6lyhfJ+qLSL/HeUnZOgagT1OPVyAWZrFuRrr9l
   3wDcCC1qHHYg08/lWafuCjleGtoRPr2z3Tj45lWHy0AXdkjWs2WDOZ10i
   jKhmfp/1On6MiEiGNOwBMuM3QHaLqht98jps1RPey1OMo9ggZIOi8e0jb
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10363"; a="274860511"
X-IronPort-AV: E=Sophos;i="5.91,264,1647327600"; 
   d="scan'208";a="274860511"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2022 21:46:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,264,1647327600"; 
   d="scan'208";a="679399930"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 30 May 2022 21:46:56 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nvtmR-0002Kc-H9;
        Tue, 31 May 2022 04:46:55 +0000
Date:   Tue, 31 May 2022 12:46:39 +0800
From:   kernel test robot <lkp@intel.com>
To:     Raghu Bankapur <quic_rbankapu@quicinc.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        Krishna Jha <quic_kkishorj@quicinc.com>
Subject: Re: [PATCH V0 1/1] asoc: msm: use hashtable to check kcontrol
Message-ID: <202205311233.abvVh5rg-lkp@intel.com>
References: <ad55bbd41cc253acb9af6ac068c15dd1545ecd81.1653813866.git.quic_rbankapu@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ad55bbd41cc253acb9af6ac068c15dd1545ecd81.1653813866.git.quic_rbankapu@quicinc.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
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
config: arm64-randconfig-r036-20220531 (https://download.01.org/0day-ci/archive/20220531/202205311233.abvVh5rg-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project c825abd6b0198fb088d9752f556a70705bc99dfd)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm64 cross compiling tool for clang build
        # apt-get install binutils-aarch64-linux-gnu
        # https://github.com/intel-lab-lkp/linux/commit/244d3a3d274761ea83000880d73cc9b0a01b2a4a
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Raghu-Bankapur/asoc-msm-use-hashtable-to-check-kcontrol/20220529-165246
        git checkout 244d3a3d274761ea83000880d73cc9b0a01b2a4a
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash drivers/clk/mediatek/ sound/core/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> sound/core/control.c:375:14: warning: no previous prototype for function 'snd_ctl_strtoint' [-Wmissing-prototypes]
   unsigned int snd_ctl_strtoint(const char *s)
                ^
   sound/core/control.c:375:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   unsigned int snd_ctl_strtoint(const char *s)
   ^
   static 
   1 warning generated.


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
