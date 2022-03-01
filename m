Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11E384C9496
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 20:42:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237238AbiCATnO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 14:43:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232112AbiCATnJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 14:43:09 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F09233204D;
        Tue,  1 Mar 2022 11:42:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646163747; x=1677699747;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0jEz/DJzpwaJIm6VwC7B5azcRqmPUDVe75s6sEfdqSk=;
  b=oHksIjmR2s5BTQbWYHdyuSCpFZhBvkY8fcllomR0s5Nr2yxEfxkDw4m+
   yLpMs+KO2EKpk1E4TqufnJSwKx+I4u1KD9zox0vF3IAZxlcOYAh5R+NOI
   HvkFEu9ecvl6NSiqrEli6CY3ueyl7FoOVCyblOaocVTgUNDT7yM8V8C49
   g+np/sirIiqQVJTPfn3xZOn53xYF1fGX0fJ6mJ+bs0TlwW6ZaskzMS3Da
   JV89CTirT1L+DIniF4+o9mCz/DhvUQ0g1fzWisv+OTXzKSDnFEFtoECkR
   r9SV2zUSRkg4Pq4R/04wDj+IlazMHPhy7K/wec0PZlSfNjcfVu3HVePBK
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10273"; a="252956430"
X-IronPort-AV: E=Sophos;i="5.90,146,1643702400"; 
   d="scan'208";a="252956430"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2022 11:42:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,146,1643702400"; 
   d="scan'208";a="493233881"
Received: from lkp-server01.sh.intel.com (HELO 2146afe809fb) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 01 Mar 2022 11:42:08 -0800
Received: from kbuild by 2146afe809fb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nP8Nr-0000wF-Cm; Tue, 01 Mar 2022 19:42:07 +0000
Date:   Wed, 2 Mar 2022 03:41:21 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jiaxin Yu <jiaxin.yu@mediatek.com>, broonie@kernel.org
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org, perex@perex.cz,
        matthias.bgg@gmail.com, trevor.wu@mediatek.com, tzungbi@google.com,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        Jiaxin Yu <jiaxin.yu@mediatek.com>
Subject: Re: [PATCH] ASoC: bt-sco: fix bt-sco-pcm-wb dai widget don't connect
 to the endpoint
Message-ID: <202203020332.YsOHk7De-lkp@intel.com>
References: <20220301171137.27442-1-jiaxin.yu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220301171137.27442-1-jiaxin.yu@mediatek.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jiaxin,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on broonie-sound/for-next]
[also build test ERROR on v5.17-rc6 next-20220301]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Jiaxin-Yu/ASoC-bt-sco-fix-bt-sco-pcm-wb-dai-widget-don-t-connect-to-the-endpoint/20220302-011344
base:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next
config: hexagon-randconfig-r045-20220301 (https://download.01.org/0day-ci/archive/20220302/202203020332.YsOHk7De-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project d271fc04d5b97b12e6b797c6067d3c96a8d7470e)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/de4d22036c32b5b4be162ace0b3ce74c193c43c0
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Jiaxin-Yu/ASoC-bt-sco-fix-bt-sco-pcm-wb-dai-widget-don-t-connect-to-the-endpoint/20220302-011344
        git checkout de4d22036c32b5b4be162ace0b3ce74c193c43c0
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash sound/soc/codecs/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> sound/soc/codecs/bt-sco.c:26:1: error: extraneous closing brace ('}')
   };
   ^
   1 error generated.


vim +26 sound/soc/codecs/bt-sco.c

5195ca4902fe0b Mark Brown 2013-08-19  21  
5195ca4902fe0b Mark Brown 2013-08-19  22  static const struct snd_soc_dapm_route bt_sco_routes[] = {
de4d22036c32b5 Jiaxin Yu  2022-03-02  23  	{ "BT_SCO_TX", NULL, "RX" },
de4d22036c32b5 Jiaxin Yu  2022-03-02  24  	{ "TX", NULL, "BT_SCO_RX" },
de4d22036c32b5 Jiaxin Yu  2022-03-02  25  };
5195ca4902fe0b Mark Brown 2013-08-19 @26  };
5195ca4902fe0b Mark Brown 2013-08-19  27  

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
