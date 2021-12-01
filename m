Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 127E5464471
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 02:15:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346009AbhLABSU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 20:18:20 -0500
Received: from mga07.intel.com ([134.134.136.100]:20003 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236405AbhLABSS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 20:18:18 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10184"; a="299747647"
X-IronPort-AV: E=Sophos;i="5.87,277,1631602800"; 
   d="scan'208";a="299747647"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2021 17:14:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,277,1631602800"; 
   d="scan'208";a="459829738"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 30 Nov 2021 17:14:57 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1msED2-000E10-OD; Wed, 01 Dec 2021 01:14:56 +0000
Date:   Wed, 1 Dec 2021 09:14:04 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Kalle Valo <kvalo@codeaurora.org>
Subject: drivers/net/wireless/ath/wcn36xx/main.c:772:58: sparse: sparse:
 incorrect type in assignment (different base types)
Message-ID: <202112010950.acD0hjla-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   58e1100fdc5990b0cc0d4beaf2562a92e621ac7d
commit: 87d3f1f34157a22be9c9c621bcad9e8a00ec4b3c wcn36xx: Add VHT rates to wcn36xx_update_allowed_rates()
date:   1 year, 2 months ago
config: riscv-randconfig-s031-20211201 (https://download.01.org/0day-ci/archive/20211201/202112010950.acD0hjla-lkp@intel.com/config)
compiler: riscv32-linux-gcc (GCC) 11.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=87d3f1f34157a22be9c9c621bcad9e8a00ec4b3c
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 87d3f1f34157a22be9c9c621bcad9e8a00ec4b3c
        # save the config file to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=riscv SHELL=/bin/bash drivers/net/wireless/ath/wcn36xx/ drivers/tty/serial/8250/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> drivers/net/wireless/ath/wcn36xx/main.c:772:58: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short [usertype] vht_rx_mcs_map @@     got restricted __le16 [usertype] rx_mcs_map @@
   drivers/net/wireless/ath/wcn36xx/main.c:772:58: sparse:     expected unsigned short [usertype] vht_rx_mcs_map
   drivers/net/wireless/ath/wcn36xx/main.c:772:58: sparse:     got restricted __le16 [usertype] rx_mcs_map
>> drivers/net/wireless/ath/wcn36xx/main.c:774:58: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short [usertype] vht_tx_mcs_map @@     got restricted __le16 [usertype] tx_mcs_map @@
   drivers/net/wireless/ath/wcn36xx/main.c:774:58: sparse:     expected unsigned short [usertype] vht_tx_mcs_map
   drivers/net/wireless/ath/wcn36xx/main.c:774:58: sparse:     got restricted __le16 [usertype] tx_mcs_map

vim +772 drivers/net/wireless/ath/wcn36xx/main.c

   729	
   730	static void wcn36xx_update_allowed_rates(struct ieee80211_sta *sta,
   731						 enum nl80211_band band)
   732	{
   733		int i, size;
   734		u16 *rates_table;
   735		struct wcn36xx_sta *sta_priv = wcn36xx_sta_to_priv(sta);
   736		u32 rates = sta->supp_rates[band];
   737	
   738		memset(&sta_priv->supported_rates, 0,
   739			sizeof(sta_priv->supported_rates));
   740		sta_priv->supported_rates.op_rate_mode = STA_11n;
   741	
   742		size = ARRAY_SIZE(sta_priv->supported_rates.dsss_rates);
   743		rates_table = sta_priv->supported_rates.dsss_rates;
   744		if (band == NL80211_BAND_2GHZ) {
   745			for (i = 0; i < size; i++) {
   746				if (rates & 0x01) {
   747					rates_table[i] = wcn_2ghz_rates[i].hw_value;
   748					rates = rates >> 1;
   749				}
   750			}
   751		}
   752	
   753		size = ARRAY_SIZE(sta_priv->supported_rates.ofdm_rates);
   754		rates_table = sta_priv->supported_rates.ofdm_rates;
   755		for (i = 0; i < size; i++) {
   756			if (rates & 0x01) {
   757				rates_table[i] = wcn_5ghz_rates[i].hw_value;
   758				rates = rates >> 1;
   759			}
   760		}
   761	
   762		if (sta->ht_cap.ht_supported) {
   763			BUILD_BUG_ON(sizeof(sta->ht_cap.mcs.rx_mask) >
   764				sizeof(sta_priv->supported_rates.supported_mcs_set));
   765			memcpy(sta_priv->supported_rates.supported_mcs_set,
   766			       sta->ht_cap.mcs.rx_mask,
   767			       sizeof(sta->ht_cap.mcs.rx_mask));
   768		}
   769	
   770		if (sta->vht_cap.vht_supported) {
   771			sta_priv->supported_rates.op_rate_mode = STA_11ac;
 > 772			sta_priv->supported_rates.vht_rx_mcs_map =
   773					sta->vht_cap.vht_mcs.rx_mcs_map;
 > 774			sta_priv->supported_rates.vht_tx_mcs_map =
   775					sta->vht_cap.vht_mcs.tx_mcs_map;
   776		}
   777	}
   778	void wcn36xx_set_default_rates(struct wcn36xx_hal_supported_rates *rates)
   779	{
   780		u16 ofdm_rates[WCN36XX_HAL_NUM_OFDM_RATES] = {
   781			HW_RATE_INDEX_6MBPS,
   782			HW_RATE_INDEX_9MBPS,
   783			HW_RATE_INDEX_12MBPS,
   784			HW_RATE_INDEX_18MBPS,
   785			HW_RATE_INDEX_24MBPS,
   786			HW_RATE_INDEX_36MBPS,
   787			HW_RATE_INDEX_48MBPS,
   788			HW_RATE_INDEX_54MBPS
   789		};
   790		u16 dsss_rates[WCN36XX_HAL_NUM_DSSS_RATES] = {
   791			HW_RATE_INDEX_1MBPS,
   792			HW_RATE_INDEX_2MBPS,
   793			HW_RATE_INDEX_5_5MBPS,
   794			HW_RATE_INDEX_11MBPS
   795		};
   796	
   797		rates->op_rate_mode = STA_11n;
   798		memcpy(rates->dsss_rates, dsss_rates,
   799			sizeof(*dsss_rates) * WCN36XX_HAL_NUM_DSSS_RATES);
   800		memcpy(rates->ofdm_rates, ofdm_rates,
   801			sizeof(*ofdm_rates) * WCN36XX_HAL_NUM_OFDM_RATES);
   802		rates->supported_mcs_set[0] = 0xFF;
   803	}
   804	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
