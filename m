Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C23E054E9C5
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 21:04:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378085AbiFPTE0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 15:04:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230498AbiFPTEV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 15:04:21 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6657954FB4
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 12:04:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655406260; x=1686942260;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=05ZQtWGf38sMkIDGBxN5ear0JqXBorAqDG9HH+7P078=;
  b=QImydolwIr9AtsZW7rs4pWc77eKMwO2gS0ZQsTyc3ie4umZC8X8s0EnC
   6tkylGA4GXao03RwlcCWpyeDd0XiIK7k3KdbGS4EUuQ2moODtE/TTdlHM
   5CjeKbI4a7Lx35AnU4kfCAk8TE8IGtqU6FcKaGhr7CX9Kg/Fll27xnkWn
   Rj4UjU+6aTUOSWxXpDpcZnoroF8Sop9ovFGTeNSMWLvCYmMCi6nVVpycT
   TkBPAT1qLO4iOFSYbYlXLy+oS5/j2yhKgkB0MZpLKhFQkb5idPU6Vnzpr
   BWsAzLZdlAGcq6cqFh0W5lALiKLcwFQkvqQmcRJvafuZ6ndw3ml7iXjhz
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10380"; a="268017100"
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="268017100"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2022 12:04:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="728022535"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 16 Jun 2022 12:04:12 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o1ump-000Ogz-O9;
        Thu, 16 Jun 2022 19:04:11 +0000
Date:   Fri, 17 Jun 2022 03:03:38 +0800
From:   kernel test robot <lkp@intel.com>
To:     Judy Hsiao <judyhsiao@chromium.org>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     kbuild-all@lists.01.org, Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Brian Norris <briannorris@chromium.org>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Chen-Yu Tsai <wenst@chromium.org>, alsa-devel@alsa-project.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        Judy Hsiao <judyhsiao@chromium.org>
Subject: Re: [PATCH v2 1/3] ASoC: rockchip: i2s: switch BCLK to GPIO
Message-ID: <202206170216.M52eiJwN-lkp@intel.com>
References: <20220616155836.3401420-2-judyhsiao@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220616155836.3401420-2-judyhsiao@chromium.org>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Judy,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on rockchip/for-next]
[also build test ERROR on broonie-sound/for-next robh/for-next linus/master v5.19-rc2 next-20220616]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Judy-Hsiao/ASoC-rockchip-i2s-switch-BCLK-to-GPIO/20220617-000041
base:   https://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip.git for-next
config: arc-randconfig-r043-20220616 (https://download.01.org/0day-ci/archive/20220617/202206170216.M52eiJwN-lkp@intel.com/config)
compiler: arc-elf-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/322064314e50b113217aa4c7412e2431defea08f
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Judy-Hsiao/ASoC-rockchip-i2s-switch-BCLK-to-GPIO/20220617-000041
        git checkout 322064314e50b113217aa4c7412e2431defea08f
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=arc SHELL=/bin/bash sound/soc/rockchip/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   sound/soc/rockchip/rockchip_i2s.c: In function 'rockchip_snd_rxctrl':
   sound/soc/rockchip/rockchip_i2s.c:247:16: error: 'return' with a value, in function returning void [-Werror=return-type]
     247 |         return ret;
         |                ^~~
   sound/soc/rockchip/rockchip_i2s.c:188:13: note: declared here
     188 | static void rockchip_snd_rxctrl(struct rk_i2s_dev *i2s, int on)
         |             ^~~~~~~~~~~~~~~~~~~
   sound/soc/rockchip/rockchip_i2s.c: In function 'rockchip_i2s_trigger':
>> sound/soc/rockchip/rockchip_i2s.c:485:29: error: void value not ignored as it ought to be
     485 |                         ret = rockchip_snd_rxctrl(i2s, 1);
         |                             ^
   sound/soc/rockchip/rockchip_i2s.c:498:29: error: void value not ignored as it ought to be
     498 |                         ret = rockchip_snd_rxctrl(i2s, 0);
         |                             ^
   cc1: some warnings being treated as errors


vim +485 sound/soc/rockchip/rockchip_i2s.c

   473	
   474	static int rockchip_i2s_trigger(struct snd_pcm_substream *substream,
   475					int cmd, struct snd_soc_dai *dai)
   476	{
   477		struct rk_i2s_dev *i2s = to_info(dai);
   478		int ret = 0;
   479	
   480		switch (cmd) {
   481		case SNDRV_PCM_TRIGGER_START:
   482		case SNDRV_PCM_TRIGGER_RESUME:
   483		case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
   484			if (substream->stream == SNDRV_PCM_STREAM_CAPTURE)
 > 485				ret = rockchip_snd_rxctrl(i2s, 1);
   486			else
   487				ret = rockchip_snd_txctrl(i2s, 1);
   488			if (ret < 0)
   489				return ret;
   490			i2s_pinctrl_select_bclk_on(i2s);
   491			break;
   492		case SNDRV_PCM_TRIGGER_SUSPEND:
   493		case SNDRV_PCM_TRIGGER_STOP:
   494		case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
   495			if (substream->stream == SNDRV_PCM_STREAM_CAPTURE) {
   496				if (!i2s->tx_start)
   497					i2s_pinctrl_select_bclk_off(i2s);
   498				ret = rockchip_snd_rxctrl(i2s, 0);
   499			} else {
   500				if (!i2s->rx_start)
   501					i2s_pinctrl_select_bclk_off(i2s);
   502				ret = rockchip_snd_txctrl(i2s, 0);
   503			}
   504			break;
   505		default:
   506			ret = -EINVAL;
   507			break;
   508		}
   509	
   510		return ret;
   511	}
   512	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
