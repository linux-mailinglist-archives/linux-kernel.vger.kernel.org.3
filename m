Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B49DB50B118
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 09:07:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444661AbiDVHJy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 03:09:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229636AbiDVHJv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 03:09:51 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C6CA50E31;
        Fri, 22 Apr 2022 00:06:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650611219; x=1682147219;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=K5K/9LP5qRdw+kAG2wypguFk5flX/j+CqMO4RT/vvxA=;
  b=kXelw/wzOaRh/LIF0UmBSG/g+2d8r3X74W3/LVmQ9JQ/NLZTcGqtRPwy
   UuyzXDQoHDlDOAMKQqaHYiVDRjoBbYjjfcfdEmqZAuh9WRZJN2/Xx+lED
   rcbR8z86KxiQEAZ6qEhh1to9RFsdAG65pcCooF1Jjx/txez7dxiaKoYjA
   1geoRA7KUyWvIrTYor0ZLWMyjDKruPM+P6GqtHbJaf9ljip2JY4//wF6h
   ag3AQigB2e/7oCDWXLMRnL9Set9EdqK3f04q140kxZ2iKQLz0PyoZq4rA
   xdURsFUkndRpJA2IUVpfIsF/BC1NRzTwpL05R0/3pN0icjkoRLkwUgubZ
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10324"; a="325049925"
X-IronPort-AV: E=Sophos;i="5.90,281,1643702400"; 
   d="scan'208";a="325049925"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2022 00:06:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,281,1643702400"; 
   d="scan'208";a="577715736"
Received: from lkp-server01.sh.intel.com (HELO 3abc53900bec) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 22 Apr 2022 00:06:53 -0700
Received: from kbuild by 3abc53900bec with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nhnNU-0009M8-Fo;
        Fri, 22 Apr 2022 07:06:52 +0000
Date:   Fri, 22 Apr 2022 15:06:01 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ryan Lee <ryan.lee.analog@gmail.com>, lgirdwood@gmail.com,
        broonie@kernel.org, robh+dt@kernel.org, krzk+dt@kernel.org,
        perex@perex.cz, tiwai@suse.com, srinivas.kandagatla@linaro.org,
        ckeepax@opensource.cirrus.com, tanureal@opensource.cirrus.com,
        cy_huang@richtek.com, pierre-louis.bossart@linux.intel.com,
        drhodes@opensource.cirrus.com, pbrobinson@gmail.com,
        hdegoede@redhat.com, lukas.bulwahn@gmail.com, stephan@gerhold.net,
        arnd@arndb.de, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        ryans.lee@analog.com
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org
Subject: Re: [PATCH V2 2/2] ASoC: max98396: add amplifier driver
Message-ID: <202204221550.phNeKLyn-lkp@intel.com>
References: <20220421230253.823798-2-ryan.lee.analog@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220421230253.823798-2-ryan.lee.analog@gmail.com>
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ryan,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on broonie-sound/for-next]
[also build test WARNING on v5.18-rc3 next-20220421]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Ryan-Lee/ASoC-dt-bindings-max98396-add-amplifier-driver/20220422-070610
base:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next
config: arm-buildonly-randconfig-r003-20220421 (https://download.01.org/0day-ci/archive/20220422/202204221550.phNeKLyn-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 5bd87350a5ae429baf8f373cb226a57b62f87280)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm cross compiling tool for clang build
        # apt-get install binutils-arm-linux-gnueabi
        # https://github.com/intel-lab-lkp/linux/commit/1acb9ac9acbd834a2e93c2127be6bdd1716dc6dd
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Ryan-Lee/ASoC-dt-bindings-max98396-add-amplifier-driver/20220422-070610
        git checkout 1acb9ac9acbd834a2e93c2127be6bdd1716dc6dd
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash sound/soc/codecs/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> sound/soc/codecs/max98396.c:408:7: warning: variable 'update' is used uninitialized whenever 'if' condition is false [-Wsometimes-uninitialized]
                   if (format != (reg & MAX98396_PCM_MODE_CFG_FORMAT_MASK))
                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   sound/soc/codecs/max98396.c:411:7: note: uninitialized use occurs here
                   if (update)
                       ^~~~~~
   sound/soc/codecs/max98396.c:408:3: note: remove the 'if' if its condition is always true
                   if (format != (reg & MAX98396_PCM_MODE_CFG_FORMAT_MASK))
                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   sound/soc/codecs/max98396.c:349:13: note: initialize the variable 'update' to silence this warning
           bool update;
                      ^
                       = 0
   1 warning generated.


vim +408 sound/soc/codecs/max98396.c

   339	
   340	static int max98396_dai_set_fmt(struct snd_soc_dai *codec_dai, unsigned int fmt)
   341	{
   342		struct snd_soc_component *component = codec_dai->component;
   343		struct max98396_priv *max98396 = snd_soc_component_get_drvdata(component);
   344		unsigned int format;
   345		unsigned int bclk_pol = 0;
   346		unsigned int fsync_pol = 0;
   347		int ret, status;
   348		int reg;
   349		bool update;
   350	
   351		dev_dbg(component->dev, "%s: fmt 0x%08X\n", __func__, fmt);
   352	
   353		switch (fmt & SND_SOC_DAIFMT_INV_MASK) {
   354		case SND_SOC_DAIFMT_NB_NF:
   355			break;
   356		case SND_SOC_DAIFMT_NB_IF:
   357			fsync_pol = MAX98396_PCM_MODE_CFG_PCM_LRCLKEDGE;
   358			break;
   359		case SND_SOC_DAIFMT_IB_NF:
   360			bclk_pol = MAX98396_PCM_MODE_CFG_PCM_BCLKEDGE;
   361			break;
   362		case SND_SOC_DAIFMT_IB_IF:
   363			bclk_pol = MAX98396_PCM_MODE_CFG_PCM_BCLKEDGE;
   364			fsync_pol = MAX98396_PCM_MODE_CFG_PCM_LRCLKEDGE;
   365			break;
   366	
   367		default:
   368			dev_err(component->dev, "DAI invert mode unsupported\n");
   369			return -EINVAL;
   370		}
   371	
   372		regmap_update_bits(max98396->regmap,
   373				   MAX98396_R2041_PCM_MODE_CFG,
   374				   MAX98396_PCM_MODE_CFG_PCM_LRCLKEDGE,
   375				   fsync_pol);
   376	
   377		regmap_update_bits(max98396->regmap,
   378				   MAX98396_R2042_PCM_CLK_SETUP,
   379				   MAX98396_PCM_MODE_CFG_PCM_BCLKEDGE,
   380				   bclk_pol);
   381	
   382		/* interface format */
   383		switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
   384		case SND_SOC_DAIFMT_I2S:
   385			format = MAX98396_PCM_FORMAT_I2S;
   386			break;
   387		case SND_SOC_DAIFMT_LEFT_J:
   388			format = MAX98396_PCM_FORMAT_LJ;
   389			break;
   390		case SND_SOC_DAIFMT_DSP_A:
   391			format = MAX98396_PCM_FORMAT_TDM_MODE1;
   392			break;
   393		case SND_SOC_DAIFMT_DSP_B:
   394			format = MAX98396_PCM_FORMAT_TDM_MODE0;
   395			break;
   396		default:
   397			return -EINVAL;
   398		}
   399	
   400		ret = regmap_read(max98396->regmap, MAX98396_R210F_GLOBAL_EN, &status);
   401		if (ret < 0)
   402			return -EINVAL;
   403	
   404		if (status) {
   405			ret = regmap_read(max98396->regmap, MAX98396_R2041_PCM_MODE_CFG, &reg);
   406			if (ret < 0)
   407				return -EINVAL;
 > 408			if (format != (reg & MAX98396_PCM_MODE_CFG_FORMAT_MASK))
   409				update = true;
   410			/* GLOBAL_EN OFF prior to pcm mode change */
   411			if (update)
   412				max98396_global_enable_onoff(max98396->regmap, false);
   413		}
   414	
   415		regmap_update_bits(max98396->regmap,
   416				   MAX98396_R2041_PCM_MODE_CFG,
   417				   MAX98396_PCM_MODE_CFG_FORMAT_MASK,
   418				   format);
   419	
   420		if (status && update)
   421			max98396_global_enable_onoff(max98396->regmap, true);
   422	
   423		return 0;
   424	}
   425	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
