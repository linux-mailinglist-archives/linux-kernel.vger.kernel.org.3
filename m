Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D0074C9731
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 21:43:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238362AbiCAUoR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 15:44:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238240AbiCAUoK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 15:44:10 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E668252E0B;
        Tue,  1 Mar 2022 12:43:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646167407; x=1677703407;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=j8hCtzK8/yGigjiI1ZMUVHJkmYhuD4SpFKIZnvhuUqs=;
  b=kN9LozVAB8jDAmy6o5h+sgrlqQV/LNje/m9yd3PntGkvcGKZO5g92Qg7
   3BbZyCwSjVXIEBtjQ8A4yZYVI6meQ2DnwqZDcMZpAu2cIR7qU7D6v8xwk
   z3vDdlpd/04uOTZ05hXeQgkYzByStJc8fAhaU3R82wB+j/oBUlgiCGSvq
   vMV4qfXxIdFcNQ1k1l9ERaPubIt+xK+r0c/DYIoM4/2J3gOUiJGe6UjiI
   EZ6Z0QJpCyc/aaaGxlQT6htVUrSf4m3EhA38eygXiYhJlzrl4E/Ev3NaN
   TgrUp6RpGIHFCa+gmxwGFxIh1cEd5GXS5SorhpLNgfnqDGXrF3OuENE8Z
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10273"; a="277909157"
X-IronPort-AV: E=Sophos;i="5.90,146,1643702400"; 
   d="scan'208";a="277909157"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2022 12:43:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,146,1643702400"; 
   d="scan'208";a="641414066"
Received: from lkp-server01.sh.intel.com (HELO 2146afe809fb) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 01 Mar 2022 12:43:24 -0800
Received: from kbuild by 2146afe809fb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nP9L9-0000zh-Bc; Tue, 01 Mar 2022 20:43:23 +0000
Date:   Wed, 2 Mar 2022 04:42:54 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jiaxin Yu <jiaxin.yu@mediatek.com>, broonie@kernel.org
Cc:     kbuild-all@lists.01.org, perex@perex.cz, matthias.bgg@gmail.com,
        trevor.wu@mediatek.com, tzungbi@google.com,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        Jiaxin Yu <jiaxin.yu@mediatek.com>
Subject: Re: [PATCH] ASoC: bt-sco: fix bt-sco-pcm-wb dai widget don't connect
 to the endpoint
Message-ID: <202203020422.oME8VbcM-lkp@intel.com>
References: <20220301171137.27442-1-jiaxin.yu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220301171137.27442-1-jiaxin.yu@mediatek.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
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
config: arm-randconfig-r014-20220301 (https://download.01.org/0day-ci/archive/20220302/202203020422.oME8VbcM-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/de4d22036c32b5b4be162ace0b3ce74c193c43c0
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Jiaxin-Yu/ASoC-bt-sco-fix-bt-sco-pcm-wb-dai-widget-don-t-connect-to-the-endpoint/20220302-011344
        git checkout de4d22036c32b5b4be162ace0b3ce74c193c43c0
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arm SHELL=/bin/bash sound/soc/codecs/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> sound/soc/codecs/bt-sco.c:26:1: error: expected identifier or '(' before '}' token
      26 | };
         | ^


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
