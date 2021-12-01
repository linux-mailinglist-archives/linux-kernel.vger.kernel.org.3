Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E78246580B
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 21:57:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353612AbhLAVAM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 16:00:12 -0500
Received: from mga18.intel.com ([134.134.136.126]:15605 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1353149AbhLAU4L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 15:56:11 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10185"; a="223430763"
X-IronPort-AV: E=Sophos;i="5.87,279,1631602800"; 
   d="scan'208";a="223430763"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2021 12:52:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,279,1631602800"; 
   d="scan'208";a="460179271"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 01 Dec 2021 12:52:46 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1msWar-000FNs-Ch; Wed, 01 Dec 2021 20:52:45 +0000
Date:   Thu, 2 Dec 2021 04:51:48 +0800
From:   kernel test robot <lkp@intel.com>
To:     Loic Poulain <loic.poulain@linaro.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Kalle Valo <kvalo@codeaurora.org>
Subject: drivers/net/wireless/ath/wcn36xx/smd.c:943:33: sparse: sparse: cast
 truncates bits from constant value (780 becomes 80)
Message-ID: <202112020449.FNKDxUVp-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   58e1100fdc5990b0cc0d4beaf2562a92e621ac7d
commit: d707f812bb0513ea0030d0c9fe2a456bae5a4583 wcn36xx: Channel list update before hardware scan
date:   5 weeks ago
config: riscv-randconfig-s031-20211201 (https://download.01.org/0day-ci/archive/20211202/202112020449.FNKDxUVp-lkp@intel.com/config)
compiler: riscv32-linux-gcc (GCC) 11.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=d707f812bb0513ea0030d0c9fe2a456bae5a4583
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout d707f812bb0513ea0030d0c9fe2a456bae5a4583
        # save the config file to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=riscv SHELL=/bin/bash drivers/net/wireless/ath/wcn36xx/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> drivers/net/wireless/ath/wcn36xx/smd.c:943:33: sparse: sparse: cast truncates bits from constant value (780 becomes 80)

vim +943 drivers/net/wireless/ath/wcn36xx/smd.c

   931	
   932	int wcn36xx_smd_update_channel_list(struct wcn36xx *wcn, struct cfg80211_scan_request *req)
   933	{
   934		struct wcn36xx_hal_update_channel_list_req_msg *msg_body;
   935		int ret, i;
   936	
   937		msg_body = kzalloc(sizeof(*msg_body), GFP_KERNEL);
   938		if (!msg_body)
   939			return -ENOMEM;
   940	
   941		INIT_HAL_MSG((*msg_body), WCN36XX_HAL_UPDATE_CHANNEL_LIST_REQ);
   942	
 > 943		msg_body->num_channel = min_t(u8, req->n_channels, sizeof(msg_body->channels));
   944		for (i = 0; i < msg_body->num_channel; i++) {
   945			struct wcn36xx_hal_channel_param *param = &msg_body->channels[i];
   946			u32 min_power = WCN36XX_HAL_DEFAULT_MIN_POWER;
   947			u32 ant_gain = WCN36XX_HAL_DEFAULT_ANT_GAIN;
   948	
   949			param->mhz = req->channels[i]->center_freq;
   950			param->band_center_freq1 = req->channels[i]->center_freq;
   951			param->band_center_freq2 = 0;
   952	
   953			if (req->channels[i]->flags & IEEE80211_CHAN_NO_IR)
   954				param->channel_info |= WCN36XX_HAL_CHAN_INFO_FLAG_PASSIVE;
   955	
   956			if (req->channels[i]->flags & IEEE80211_CHAN_RADAR)
   957				param->channel_info |= WCN36XX_HAL_CHAN_INFO_FLAG_DFS;
   958	
   959			if (req->channels[i]->band == NL80211_BAND_5GHZ) {
   960				param->channel_info |= WCN36XX_HAL_CHAN_INFO_FLAG_HT;
   961				param->channel_info |= WCN36XX_HAL_CHAN_INFO_FLAG_VHT;
   962				param->channel_info |= WCN36XX_HAL_CHAN_INFO_PHY_11A;
   963			} else {
   964				param->channel_info |= WCN36XX_HAL_CHAN_INFO_PHY_11BG;
   965			}
   966	
   967			if (min_power > req->channels[i]->max_power)
   968				min_power = req->channels[i]->max_power;
   969	
   970			if (req->channels[i]->max_antenna_gain)
   971				ant_gain = req->channels[i]->max_antenna_gain;
   972	
   973			u32p_replace_bits(&param->reg_info_1, min_power,
   974					  WCN36XX_HAL_CHAN_REG1_MIN_PWR_MASK);
   975			u32p_replace_bits(&param->reg_info_1, req->channels[i]->max_power,
   976					  WCN36XX_HAL_CHAN_REG1_MAX_PWR_MASK);
   977			u32p_replace_bits(&param->reg_info_1, req->channels[i]->max_reg_power,
   978					  WCN36XX_HAL_CHAN_REG1_REG_PWR_MASK);
   979			u32p_replace_bits(&param->reg_info_1, 0,
   980					  WCN36XX_HAL_CHAN_REG1_CLASS_ID_MASK);
   981			u32p_replace_bits(&param->reg_info_2, ant_gain,
   982					  WCN36XX_HAL_CHAN_REG2_ANT_GAIN_MASK);
   983	
   984			wcn36xx_dbg(WCN36XX_DBG_HAL,
   985				    "%s: freq=%u, channel_info=%08x, reg_info1=%08x, reg_info2=%08x\n",
   986				    __func__, param->mhz, param->channel_info, param->reg_info_1,
   987				    param->reg_info_2);
   988		}
   989	
   990		mutex_lock(&wcn->hal_mutex);
   991	
   992		PREPARE_HAL_BUF(wcn->hal_buf, (*msg_body));
   993	
   994		ret = wcn36xx_smd_send_and_wait(wcn, msg_body->header.len);
   995		if (ret) {
   996			wcn36xx_err("Sending hal_update_channel_list failed\n");
   997			goto out;
   998		}
   999	
  1000		ret = wcn36xx_smd_rsp_status_check(wcn->hal_buf, wcn->hal_rsp_len);
  1001		if (ret) {
  1002			wcn36xx_err("hal_update_channel_list response failed err=%d\n", ret);
  1003			goto out;
  1004		}
  1005	
  1006	out:
  1007		kfree(msg_body);
  1008		mutex_unlock(&wcn->hal_mutex);
  1009		return ret;
  1010	}
  1011	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
