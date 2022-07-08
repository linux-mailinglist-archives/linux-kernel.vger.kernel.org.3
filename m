Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E819656AF8E
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 03:07:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236028AbiGHAoV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 20:44:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbiGHAoS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 20:44:18 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83EE470E5B;
        Thu,  7 Jul 2022 17:44:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657241057; x=1688777057;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=c+P6YDMV9PRWXetSgJx/P+CHVW6L1Bzzbpwgy+7i05E=;
  b=dKmy3z646rV18FCgEKYYffcZEFS/PI4oHSyb5xdW24i32NIZ4alEx1S/
   rVM9ukpIU4zr03jzGsmJmFiU90SOYCrgzh9SVQ6dFF1H3kk0tjbuYzlXU
   5FH73ZKzbn1DKnztunYYJT26fmRaAt/W9BBuqPRTPkT31W0dmRycqX/KG
   Kd3KB1zteF5qVmC2ZRMlBeN84pU07oWM/O9ATNq9LK7YLmK2ZztiV7RxC
   1bfJAt8QiMGVxkngMz/BC1XsQPmg5NbZiRPrsZoKnmN6kDO9QkpauOupU
   UoQueqD6TaDWji288QA9hzWSAgCmwZhPn2IV8FlUak9gkkR96D98XKbUo
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10401"; a="309715477"
X-IronPort-AV: E=Sophos;i="5.92,253,1650956400"; 
   d="scan'208";a="309715477"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2022 17:44:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,253,1650956400"; 
   d="scan'208";a="626521925"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 07 Jul 2022 17:44:14 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o9c6P-000Mfb-PJ;
        Fri, 08 Jul 2022 00:44:13 +0000
Date:   Fri, 8 Jul 2022 08:43:24 +0800
From:   kernel test robot <lkp@intel.com>
To:     Aidan MacDonald <aidanmacdonald.0x0@gmail.com>,
        paul@crapouillou.net, lgirdwood@gmail.com, broonie@kernel.org,
        perex@perex.cz, tiwai@suse.com
Cc:     kbuild-all@lists.01.org, linux-mips@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 11/11] ASoC: jz4740-i2s: Refactor DAI probe/remove ops
 as component ops
Message-ID: <202207080814.p8h1it9G-lkp@intel.com>
References: <20220707194655.312892-12-aidanmacdonald.0x0@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220707194655.312892-12-aidanmacdonald.0x0@gmail.com>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Aidan,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on broonie-sound/for-next]
[cannot apply to linus/master v5.19-rc5 next-20220707]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Aidan-MacDonald/ASoC-cleanups-and-improvements-for-jz4740-i2s/20220708-034953
base:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next
config: s390-randconfig-m031-20220707 (https://download.01.org/0day-ci/archive/20220708/202207080814.p8h1it9G-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/d990302616fcc22f1e2a3b963c25fdec9d787251
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Aidan-MacDonald/ASoC-cleanups-and-improvements-for-jz4740-i2s/20220708-034953
        git checkout d990302616fcc22f1e2a3b963c25fdec9d787251
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=s390 SHELL=/bin/bash sound/soc/jz4740/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   sound/soc/jz4740/jz4740-i2s.c: In function 'jz4740_i2s_probe':
>> sound/soc/jz4740/jz4740-i2s.c:442:9: error: 'ret' undeclared (first use in this function); did you mean 'net'?
     442 |         ret = clk_prepare_enable(i2s->clk_aic);
         |         ^~~
         |         net
   sound/soc/jz4740/jz4740-i2s.c:442:9: note: each undeclared identifier is reported only once for each function it appears in


vim +442 sound/soc/jz4740/jz4740-i2s.c

   437	
   438	static int jz4740_i2s_probe(struct snd_soc_component *component)
   439	{
   440		struct jz4740_i2s *i2s = snd_soc_component_get_drvdata(component);
   441	
 > 442		ret = clk_prepare_enable(i2s->clk_aic);
   443		if (ret)
   444			return ret;
   445	
   446		regmap_write(i2s->regmap, JZ_REG_AIC_CONF, JZ_AIC_CONF_RESET);
   447	
   448		regmap_write(i2s->regmap, JZ_REG_AIC_CONF,
   449			     JZ_AIC_CONF_OVERFLOW_PLAY_LAST |
   450			     JZ_AIC_CONF_I2S | JZ_AIC_CONF_INTERNAL_CODEC);
   451	
   452		regmap_field_write(i2s->field_rx_fifo_thresh, 7);
   453		regmap_field_write(i2s->field_tx_fifo_thresh, 8);
   454	
   455		return 0;
   456	}
   457	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
