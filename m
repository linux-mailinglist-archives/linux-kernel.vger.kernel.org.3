Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66A924F9B9F
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 19:26:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238154AbiDHR2I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 13:28:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230268AbiDHR2H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 13:28:07 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 011D5ECB20;
        Fri,  8 Apr 2022 10:26:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649438762; x=1680974762;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=7TpvQCspyDtMRrhPPjoBqo4eTzVYuAJZTGqg9RPtf94=;
  b=Lp4uaZIoreS3Q7GmWTUpa7/paUKezfZ3nF7QT0AXR2NekrK/V3mpBoro
   aont9Q9aTym8M6amAzeM2Eq772iTrG0ulVQxs5jEMLLXoV6Fhe5Bns7Vx
   x3bgIWd7zxtw42tiHdO6dLbCPfx0rNuVL1xLDIW8i2tE8uATDCP2JL3DT
   IxVxJMyoRTmheckbYClUXqWRoPqjGy/gS8f2VHaRfEeFdRg7vNI6+/cAn
   2oniVyNLAds1ymItv238DwHpVmWiDA5PeFN4IR1J7JLrzMp+HgmQ7Cdng
   gEaVRz6TpwYZHgMCRk3lOXBTstoGzPEJ9sBGfTVhHoGHnVTaChd2PVoMh
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10310"; a="261334974"
X-IronPort-AV: E=Sophos;i="5.90,245,1643702400"; 
   d="scan'208";a="261334974"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2022 10:26:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,245,1643702400"; 
   d="scan'208";a="642978789"
Received: from lkp-server02.sh.intel.com (HELO 7e80bc2a00a0) ([10.239.97.151])
  by FMSMGA003.fm.intel.com with ESMTP; 08 Apr 2022 10:25:58 -0700
Received: from kbuild by 7e80bc2a00a0 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1ncsMv-0000Ur-Oo;
        Fri, 08 Apr 2022 17:25:57 +0000
Date:   Sat, 9 Apr 2022 01:25:22 +0800
From:   kernel test robot <lkp@intel.com>
To:     Luca Weiss <luca.weiss@fairphone.com>, linux-input@vger.kernel.org
Cc:     kbuild-all@lists.01.org, ~postmarketos/upstreaming@lists.sr.ht,
        phone-devel@vger.kernel.org, Luca Weiss <luca.weiss@fairphone.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] Input - aw8695: Add driver for AW8695 haptics
Message-ID: <202204090150.l1wQZ8IR-lkp@intel.com>
References: <20220408115311.237039-2-luca.weiss@fairphone.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220408115311.237039-2-luca.weiss@fairphone.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Luca,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on dtor-input/next]
[also build test ERROR on hid/for-next robh/for-next v5.18-rc1 next-20220408]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Luca-Weiss/dt-bindings-input-Add-bindings-for-Awinic-AW8695-haptics/20220408-195432
base:   https://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git next
config: arc-allyesconfig (https://download.01.org/0day-ci/archive/20220409/202204090150.l1wQZ8IR-lkp@intel.com/config)
compiler: arceb-elf-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/df1f510ce633a7d4a6cd3722620980961b39961b
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Luca-Weiss/dt-bindings-input-Add-bindings-for-Awinic-AW8695-haptics/20220408-195432
        git checkout df1f510ce633a7d4a6cd3722620980961b39961b
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arc SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/input/misc/aw8695-haptics.c: In function 'aw8695_haptic_read_f0':
>> drivers/input/misc/aw8695-haptics.c:795:18: error: implicit declaration of function 'FIELD_PREP' [-Werror=implicit-function-declaration]
     795 |         f0_reg = FIELD_PREP(AW8695_HIGH_MASK, read_buf);
         |                  ^~~~~~~~~~
   drivers/input/misc/aw8695-haptics.c: In function 'aw8695_haptic_get_f0':
>> drivers/input/misc/aw8695-haptics.c:862:25: error: implicit declaration of function 'FIELD_GET'; did you mean 'FOLL_GET'? [-Werror=implicit-function-declaration]
     862 |                         FIELD_GET(AW8695_HIGH_MASK, f0_reg));
         |                         ^~~~~~~~~
         |                         FOLL_GET
   cc1: some warnings being treated as errors


vim +/FIELD_PREP +795 drivers/input/misc/aw8695-haptics.c

   783	
   784	static int aw8695_haptic_read_f0(struct aw8695_data *haptics)
   785	{
   786		struct device *dev = &haptics->client->dev;
   787		unsigned long f0;
   788		unsigned int f0_reg;
   789		unsigned int read_buf;
   790		int err;
   791	
   792		err = regmap_read(haptics->regmap, AW8695_F_LRA_F0_H, &read_buf);
   793		if (err)
   794			return err;
 > 795		f0_reg = FIELD_PREP(AW8695_HIGH_MASK, read_buf);
   796	
   797		err = regmap_read(haptics->regmap, AW8695_F_LRA_F0_L, &read_buf);
   798		if (err)
   799			return err;
   800		f0_reg |= FIELD_PREP(AW8695_LOW_MASK, read_buf);
   801	
   802		if (!f0_reg) {
   803			dev_err(dev, "Failed to read f0 value!\n");
   804			return -EINVAL;
   805		}
   806	
   807		f0 = 1000000000 / (f0_reg * haptics->f0_coefficient);
   808		dev_dbg(dev, "Read new f0: %d\n", (int)f0);
   809	
   810		return (int)f0;
   811	}
   812	
   813	static int aw8695_haptic_get_f0(struct aw8695_data *haptics)
   814	{
   815		struct device *dev = &haptics->client->dev;
   816		unsigned int read_buf;
   817		unsigned int f0_trace_ms;
   818		unsigned int f0_reg;
   819		int f0;
   820		int err;
   821	
   822		err = aw8695_haptics_stop(haptics);
   823		if (err)
   824			return err;
   825	
   826		err = regmap_write(haptics->regmap, AW8695_TRIM_LRA, 0x00);
   827		if (err)
   828			return err;
   829	
   830		err = aw8695_set_work_mode(haptics, AW8695_CONT_MODE);
   831		if (err)
   832			return err;
   833	
   834		err = regmap_update_bits(haptics->regmap, AW8695_CONT_CTRL,
   835			AW8695_CONT_CTRL_EN_CLOSE_MASK, AW8695_CONT_CTRL_OPEN_PLAYBACK);
   836		if (err)
   837			return err;
   838		err = regmap_update_bits(haptics->regmap, AW8695_CONT_CTRL,
   839			AW8695_CONT_CTRL_F0_DETECT_ENABLE, AW8695_CONT_CTRL_F0_DETECT_ENABLE);
   840		if (err)
   841			return err;
   842	
   843		/* LPF */
   844		err = regmap_update_bits(haptics->regmap, AW8695_DATCTRL,
   845			AW8695_DATCTRL_FC_MASK, AW8695_DATCTRL_FC_1000HZ);
   846		if (err)
   847			return err;
   848		err = regmap_update_bits(haptics->regmap, AW8695_DATCTRL,
   849			AW8695_DATCTRL_LPF_ENABLE_MASK, AW8695_DATCTRL_LPF_ENABLE);
   850		if (err)
   851			return err;
   852	
   853		/* LRA OSC Source */
   854		err = regmap_update_bits(haptics->regmap, AW8695_ANACTRL,
   855			AW8695_ANACTRL_LRA_SRC_MASK, AW8695_ANACTRL_LRA_SRC_REG);
   856		if (err)
   857			return err;
   858	
   859		/* preset f0 */
   860		f0_reg = 1000000000 / (haptics->f0_preset * haptics->f0_coefficient);
   861		err = regmap_write(haptics->regmap, AW8695_F_PRE_H,
 > 862				FIELD_GET(AW8695_HIGH_MASK, f0_reg));
   863		if (err)
   864			return err;
   865		err = regmap_write(haptics->regmap, AW8695_F_PRE_L,
   866				FIELD_GET(AW8695_LOW_MASK, f0_reg));
   867		if (err)
   868			return err;
   869	
   870		/* f0 driver level */
   871		err = regmap_write(haptics->regmap, AW8695_DRV_LVL, haptics->drive_level);
   872		if (err)
   873			return err;
   874	
   875		/* f0 trace parameter */
   876		err = regmap_write(haptics->regmap, AW8695_NUM_F0_1,
   877				FIELD_PREP(AW8695_NUM_F0_1_PRE_MASK, haptics->f0_det_play) |
   878				FIELD_PREP(AW8695_NUM_F0_1_WAIT_MASK, haptics->f0_det_wait));
   879		if (err)
   880			return err;
   881		err = regmap_write(haptics->regmap, AW8695_NUM_F0_2, haptics->f0_det_repeat);
   882		if (err)
   883			return err;
   884		err = regmap_write(haptics->regmap, AW8695_NUM_F0_3, haptics->f0_det_trace);
   885		if (err)
   886			return err;
   887	
   888		err = aw8695_interrupt_clear(haptics);
   889		if (err)
   890			return err;
   891	
   892		/* play go and start f0 calibration */
   893		err = regmap_update_bits(haptics->regmap, AW8695_GO,
   894			AW8695_GO_ENABLE, AW8695_GO_ENABLE);
   895		if (err)
   896			return err;
   897	
   898		/* f0 trace time */
   899		f0_trace_ms =
   900			(1000 * 10 / haptics->f0_preset) * (haptics->f0_det_play + haptics->f0_det_wait +
   901			(haptics->f0_det_trace + haptics->f0_det_wait) * (haptics->f0_det_repeat - 1));
   902		usleep_range(f0_trace_ms * 1000, f0_trace_ms * 1000 + 500);
   903	
   904		err = regmap_read_poll_timeout(haptics->regmap, AW8695_GLB_STATE, read_buf,
   905				(read_buf & 0x0f) == 0, 10000, 10000 * 50);
   906		if (err) {
   907			dev_err(dev, "Did not enter standby: %d\n", err);
   908			return err;
   909		}
   910	
   911		f0 = aw8695_haptic_read_f0(haptics);
   912	
   913		/* restore default config */
   914		err = regmap_update_bits(haptics->regmap, AW8695_CONT_CTRL,
   915			AW8695_CONT_CTRL_EN_CLOSE_MASK, AW8695_CONT_CTRL_CLOSE_PLAYBACK);
   916		if (err)
   917			return err;
   918		err = regmap_update_bits(haptics->regmap, AW8695_CONT_CTRL,
   919			AW8695_CONT_CTRL_F0_DETECT_ENABLE, 0);
   920		if (err)
   921			return err;
   922	
   923		return f0;
   924	}
   925	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
