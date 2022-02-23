Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 405B54C1329
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 13:49:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240618AbiBWMtM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 07:49:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240593AbiBWMtB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 07:49:01 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5270FA66C3
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 04:48:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645620514; x=1677156514;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=7U3dBXvnvJSXR66MUjtmjBPnFPs6h5fn1DN++jies5w=;
  b=UdjaNgzP0TcAacOKhtCAkH+nQmnD8qXaqbwO+pXH5/YTckkSPEdGtlY8
   UkeMtE7XUV0kT16nnaG/O0nd14Ko6od5kdg/vCW7oYt7l1PANdXNrJjc+
   HAmlGn4elDJeGnPr/bOxydDiZ/5x/fwzRJBCIvikwFf0Ju6Nwm126MEoR
   Rm9RiLW3ZPZf0w1fbqddGxWhzHuDgDArJTPkg2uJHm8h1CP/NUd8+L3Kr
   TdC7tMqTGyqAF5nEB29lxJsp6I7yklVY6ix+sZUQwquxz+lYTjsP4NwmE
   KUmhH6MUX2RiLNxGtVm5ES6I65OwfWsygz+24mKkTTXbBQ9w5vPrZ/dZ6
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10266"; a="251689844"
X-IronPort-AV: E=Sophos;i="5.88,390,1635231600"; 
   d="scan'208";a="251689844"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2022 04:48:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,390,1635231600"; 
   d="scan'208";a="637409614"
Received: from lkp-server01.sh.intel.com (HELO 788b1cd46f0d) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 23 Feb 2022 04:48:30 -0800
Received: from kbuild by 788b1cd46f0d with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nMr4I-0001Pq-3g; Wed, 23 Feb 2022 12:48:30 +0000
Date:   Wed, 23 Feb 2022 20:48:10 +0800
From:   kernel test robot <lkp@intel.com>
To:     Vijendar Mukunda <Vijendar.Mukunda@amd.com>, broonie@kernel.org,
        alsa-devel@alsa-project.org
Cc:     kbuild-all@lists.01.org, Alexander.Deucher@amd.com,
        Sunil-kumar.Dommati@amd.com, krisman@collabora.com,
        wtli@nuvoton.com, Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/9] ASoC: amd: vg: fix for pm resume callback sequence
Message-ID: <202202232021.rBs2qLvB-lkp@intel.com>
References: <20220223071959.13539-1-Vijendar.Mukunda@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220223071959.13539-1-Vijendar.Mukunda@amd.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vijendar,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on broonie-sound/for-next]
[also build test WARNING on v5.17-rc5 next-20220222]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Vijendar-Mukunda/ASoC-amd-vg-fix-for-pm-resume-callback-sequence/20220223-152636
base:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next
config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20220223/202202232021.rBs2qLvB-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://github.com/0day-ci/linux/commit/43c5f728cf59371b29569d941fb2ef2bdc3a279d
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Vijendar-Mukunda/ASoC-amd-vg-fix-for-pm-resume-callback-sequence/20220223-152636
        git checkout 43c5f728cf59371b29569d941fb2ef2bdc3a279d
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash sound/soc/amd/vangogh/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   sound/soc/amd/vangogh/acp5x-pcm-dma.c: In function 'acp5x_pcm_resume':
>> sound/soc/amd/vangogh/acp5x-pcm-dma.c:430:20: warning: variable 'frmt_val' set but not used [-Wunused-but-set-variable]
     430 |  u32 val, reg_val, frmt_val;
         |                    ^~~~~~~~
>> sound/soc/amd/vangogh/acp5x-pcm-dma.c:430:11: warning: variable 'reg_val' set but not used [-Wunused-but-set-variable]
     430 |  u32 val, reg_val, frmt_val;
         |           ^~~~~~~


vim +/frmt_val +430 sound/soc/amd/vangogh/acp5x-pcm-dma.c

361414dc1f07b72 Vijendar Mukunda 2021-07-21  425  
361414dc1f07b72 Vijendar Mukunda 2021-07-21  426  static int __maybe_unused acp5x_pcm_resume(struct device *dev)
361414dc1f07b72 Vijendar Mukunda 2021-07-21  427  {
361414dc1f07b72 Vijendar Mukunda 2021-07-21  428  	struct i2s_dev_data *adata;
43c5f728cf59371 Vijendar Mukunda 2022-02-23  429  	struct i2s_stream_instance *rtd;
361414dc1f07b72 Vijendar Mukunda 2021-07-21 @430  	u32 val, reg_val, frmt_val;
361414dc1f07b72 Vijendar Mukunda 2021-07-21  431  
361414dc1f07b72 Vijendar Mukunda 2021-07-21  432  	reg_val = 0;
361414dc1f07b72 Vijendar Mukunda 2021-07-21  433  	frmt_val = 0;
361414dc1f07b72 Vijendar Mukunda 2021-07-21  434  	adata = dev_get_drvdata(dev);
361414dc1f07b72 Vijendar Mukunda 2021-07-21  435  
361414dc1f07b72 Vijendar Mukunda 2021-07-21  436  	if (adata->play_stream && adata->play_stream->runtime) {
43c5f728cf59371 Vijendar Mukunda 2022-02-23  437  		rtd = adata->play_stream->runtime->private_data;
361414dc1f07b72 Vijendar Mukunda 2021-07-21  438  		config_acp5x_dma(rtd, SNDRV_PCM_STREAM_PLAYBACK);
43c5f728cf59371 Vijendar Mukunda 2022-02-23  439  		acp_writel((rtd->xfer_resolution  << 3), rtd->acp5x_base + ACP_HSTDM_ITER);
43c5f728cf59371 Vijendar Mukunda 2022-02-23  440  		if (adata->tdm_mode == TDM_ENABLE) {
43c5f728cf59371 Vijendar Mukunda 2022-02-23  441  			acp_writel(adata->tdm_fmt, adata->acp5x_base + ACP_HSTDM_TXFRMT);
43c5f728cf59371 Vijendar Mukunda 2022-02-23  442  			val = acp_readl(adata->acp5x_base + ACP_HSTDM_ITER);
43c5f728cf59371 Vijendar Mukunda 2022-02-23  443  			acp_writel(val | 0x2, adata->acp5x_base + ACP_HSTDM_ITER);
43c5f728cf59371 Vijendar Mukunda 2022-02-23  444  		}
43c5f728cf59371 Vijendar Mukunda 2022-02-23  445  	}
43c5f728cf59371 Vijendar Mukunda 2022-02-23  446  	if (adata->i2ssp_play_stream && adata->i2ssp_play_stream->runtime) {
43c5f728cf59371 Vijendar Mukunda 2022-02-23  447  		rtd = adata->i2ssp_play_stream->runtime->private_data;
43c5f728cf59371 Vijendar Mukunda 2022-02-23  448  		config_acp5x_dma(rtd, SNDRV_PCM_STREAM_PLAYBACK);
43c5f728cf59371 Vijendar Mukunda 2022-02-23  449  		acp_writel((rtd->xfer_resolution  << 3), rtd->acp5x_base + ACP_I2STDM_ITER);
43c5f728cf59371 Vijendar Mukunda 2022-02-23  450  		if (adata->tdm_mode == TDM_ENABLE) {
43c5f728cf59371 Vijendar Mukunda 2022-02-23  451  			acp_writel(adata->tdm_fmt, adata->acp5x_base + ACP_I2STDM_TXFRMT);
43c5f728cf59371 Vijendar Mukunda 2022-02-23  452  			val = acp_readl(adata->acp5x_base + ACP_I2STDM_ITER);
43c5f728cf59371 Vijendar Mukunda 2022-02-23  453  			acp_writel(val | 0x2, adata->acp5x_base + ACP_I2STDM_ITER);
361414dc1f07b72 Vijendar Mukunda 2021-07-21  454  		}
361414dc1f07b72 Vijendar Mukunda 2021-07-21  455  	}
361414dc1f07b72 Vijendar Mukunda 2021-07-21  456  
361414dc1f07b72 Vijendar Mukunda 2021-07-21  457  	if (adata->capture_stream && adata->capture_stream->runtime) {
43c5f728cf59371 Vijendar Mukunda 2022-02-23  458  		rtd = adata->capture_stream->runtime->private_data;
361414dc1f07b72 Vijendar Mukunda 2021-07-21  459  		config_acp5x_dma(rtd, SNDRV_PCM_STREAM_CAPTURE);
43c5f728cf59371 Vijendar Mukunda 2022-02-23  460  		acp_writel((rtd->xfer_resolution  << 3), rtd->acp5x_base + ACP_HSTDM_IRER);
43c5f728cf59371 Vijendar Mukunda 2022-02-23  461  		if (adata->tdm_mode == TDM_ENABLE) {
43c5f728cf59371 Vijendar Mukunda 2022-02-23  462  			acp_writel(adata->tdm_fmt, adata->acp5x_base + ACP_HSTDM_RXFRMT);
43c5f728cf59371 Vijendar Mukunda 2022-02-23  463  			val = acp_readl(adata->acp5x_base + ACP_HSTDM_IRER);
43c5f728cf59371 Vijendar Mukunda 2022-02-23  464  			acp_writel(val | 0x2, adata->acp5x_base + ACP_HSTDM_IRER);
361414dc1f07b72 Vijendar Mukunda 2021-07-21  465  		}
361414dc1f07b72 Vijendar Mukunda 2021-07-21  466  	}
43c5f728cf59371 Vijendar Mukunda 2022-02-23  467  	if (adata->i2ssp_capture_stream && adata->i2ssp_capture_stream->runtime) {
43c5f728cf59371 Vijendar Mukunda 2022-02-23  468  		rtd = adata->i2ssp_capture_stream->runtime->private_data;
43c5f728cf59371 Vijendar Mukunda 2022-02-23  469  		config_acp5x_dma(rtd, SNDRV_PCM_STREAM_CAPTURE);
43c5f728cf59371 Vijendar Mukunda 2022-02-23  470  		acp_writel((rtd->xfer_resolution  << 3), rtd->acp5x_base + ACP_I2STDM_IRER);
361414dc1f07b72 Vijendar Mukunda 2021-07-21  471  		if (adata->tdm_mode == TDM_ENABLE) {
43c5f728cf59371 Vijendar Mukunda 2022-02-23  472  			acp_writel(adata->tdm_fmt, adata->acp5x_base + ACP_I2STDM_RXFRMT);
43c5f728cf59371 Vijendar Mukunda 2022-02-23  473  			val = acp_readl(adata->acp5x_base + ACP_I2STDM_IRER);
43c5f728cf59371 Vijendar Mukunda 2022-02-23  474  			acp_writel(val | 0x2, adata->acp5x_base + ACP_I2STDM_IRER);
43c5f728cf59371 Vijendar Mukunda 2022-02-23  475  		}
361414dc1f07b72 Vijendar Mukunda 2021-07-21  476  	}
361414dc1f07b72 Vijendar Mukunda 2021-07-21  477  	acp_writel(1, adata->acp5x_base + ACP_EXTERNAL_INTR_ENB);
361414dc1f07b72 Vijendar Mukunda 2021-07-21  478  	return 0;
361414dc1f07b72 Vijendar Mukunda 2021-07-21  479  }
361414dc1f07b72 Vijendar Mukunda 2021-07-21  480  

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
