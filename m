Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B7555B0D85
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 21:53:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229949AbiIGTxh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 15:53:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229884AbiIGTxd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 15:53:33 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A736EA223B;
        Wed,  7 Sep 2022 12:53:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662580412; x=1694116412;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/MI/RJuZ0sD3riUI6YGQ3T4oFUBUNCRNrhNMnbIuoG0=;
  b=iPAq+AeXSiQsdxyzZSHNRTlAhzo0D8XmeEmfgEirA+oGOqFDlt2aJNiM
   xYdk9VvdIdrmRIw3M9y/TjKMZ5c4pGo947o0J3FKe+XmALACWXFTn815n
   QsKlYOY6q3qtw0KXnRLsRG76qPx4KPZ1LP/3OVHYZex74kpWIr/nm2ckA
   VJvBtnyN7hlbvUL876mtExxED5j/YUqnXG7M+KeZHUvKxL/vFAgNeJCKw
   GIj6QSfAb6BN8gmK83qt+ecEH4YVaRefEidvNlRGzwyv59CyIT9PwEu9+
   u1GHQPUrH8su9IumH0mBu/L0POUmEY8IftIufrfdlxERfEMOJiY2+vxok
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10463"; a="358715374"
X-IronPort-AV: E=Sophos;i="5.93,297,1654585200"; 
   d="scan'208";a="358715374"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2022 12:53:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,297,1654585200"; 
   d="scan'208";a="614618487"
Received: from lkp-server02.sh.intel.com (HELO 95dfd251caa2) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 07 Sep 2022 12:53:27 -0700
Received: from kbuild by 95dfd251caa2 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oW171-0006uL-06;
        Wed, 07 Sep 2022 19:53:27 +0000
Date:   Thu, 8 Sep 2022 03:53:02 +0800
From:   kernel test robot <lkp@intel.com>
To:     luca.ceresoli@bootlin.com, alsa-devel@alsa-project.org,
        linux-rockchip@lists.infradead.org
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        Luca Ceresoli <luca.ceresoli@bootlin.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Johan Jonker <jbx6244@gmail.com>,
        Chris Morgan <macromorgan@hotmail.com>
Subject: Re: [PATCH 7/8] ASoC: codecs: Add RK3308 internal audio codec driver
Message-ID: <202209080340.RFBeIVm2-lkp@intel.com>
References: <20220907142124.2532620-8-luca.ceresoli@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220907142124.2532620-8-luca.ceresoli@bootlin.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I love your patch! Perhaps something to improve:

[auto build test WARNING on broonie-sound/for-next]
[also build test WARNING on rockchip/for-next tiwai-sound/for-next linus/master v6.0-rc4 next-20220907]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/luca-ceresoli-bootlin-com/Add-support-for-the-internal-RK3308-audio-codec/20220907-222555
base:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next
config: riscv-randconfig-r042-20220907 (https://download.01.org/0day-ci/archive/20220908/202209080340.RFBeIVm2-lkp@intel.com/config)
compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project c55b41d5199d2394dd6cdb8f52180d8b81d809d4)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install riscv cross compiling tool for clang build
        # apt-get install binutils-riscv64-linux-gnu
        # https://github.com/intel-lab-lkp/linux/commit/786c160ad64ae5a6c5266184b12ecf2674db2fbe
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review luca-ceresoli-bootlin-com/Add-support-for-the-internal-RK3308-audio-codec/20220907-222555
        git checkout 786c160ad64ae5a6c5266184b12ecf2674db2fbe
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash sound/soc/codecs/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> sound/soc/codecs/rk3308_codec.c:2007:6: warning: variable 'err' set but not used [-Wunused-but-set-variable]
           int err;
               ^
   1 warning generated.


vim +/err +2007 sound/soc/codecs/rk3308_codec.c

  2003	
  2004	static int rk3308_codec_parse_dt(struct rk3308_codec_priv *rk3308)
  2005	{
  2006		struct device_node *np = rk3308->dev->of_node;
> 2007		int err;
  2008	
  2009		/* Default value is 0 */
  2010		err = of_property_read_u32(np, "rockchip,micbias-avdd-multiplier",
  2011					   &rk3308->micbias_avdd_mult);
  2012		if (rk3308->micbias_avdd_mult >= RK3308_CODEC_MICBIAS_NUM)
  2013			return dev_err_probe(rk3308->dev, -EINVAL,
  2014					     "Invalid value for 'rockchip,micbias-avdd-multiplier'\n");
  2015	
  2016		return 0;
  2017	}
  2018	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
