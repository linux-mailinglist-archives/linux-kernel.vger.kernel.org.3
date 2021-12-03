Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78EBE467BA0
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 17:40:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382127AbhLCQno (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 11:43:44 -0500
Received: from mga03.intel.com ([134.134.136.65]:55647 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244037AbhLCQnm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 11:43:42 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10186"; a="236945193"
X-IronPort-AV: E=Sophos;i="5.87,284,1631602800"; 
   d="scan'208";a="236945193"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2021 08:40:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,284,1631602800"; 
   d="scan'208";a="478376898"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 03 Dec 2021 08:40:16 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mtBbb-000HoS-M5; Fri, 03 Dec 2021 16:40:15 +0000
Date:   Sat, 4 Dec 2021 00:40:10 +0800
From:   kernel test robot <lkp@intel.com>
To:     Johannes Berg <johannes.berg@intel.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, 0day robot <lkp@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>
Subject: net/mac80211/mlme.c:5085:8: error: use of undeclared identifier
 'vht_cap'; did you mean 'ht_cap'?
Message-ID: <202112040006.MMObTEHX-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/0day-ci/linux/commits/UPDATE-20211202-213007/Luca-Coelho/cfg80211-mac80211-patches-from-our-internal-tree-2021-11-29/20211129-213704
head:   13504866f3fbc52c9e1bcdd00dd6f92b512966e2
commit: 9c694b9b36533d573343d25d5ba8c3a4cf205480 mac80211: add more HT/VHT/HE state logging
date:   27 hours ago
config: x86_64-randconfig-a015-20211203 (https://download.01.org/0day-ci/archive/20211204/202112040006.MMObTEHX-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 1e328b06c15273edf4a40a27ca24931b5efb3a87)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/9c694b9b36533d573343d25d5ba8c3a4cf205480
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review UPDATE-20211202-213007/Luca-Coelho/cfg80211-mac80211-patches-from-our-internal-tree-2021-11-29/20211129-213704
        git checkout 9c694b9b36533d573343d25d5ba8c3a4cf205480
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash net/mac80211/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> net/mac80211/mlme.c:5085:8: error: use of undeclared identifier 'vht_cap'; did you mean 'ht_cap'?
                           if (vht_cap)
                               ^~~~~~~
                               ht_cap
   net/mac80211/mlme.c:5011:33: note: 'ht_cap' declared here
           const struct ieee80211_ht_cap *ht_cap = NULL;
                                          ^
   1 error generated.


vim +5085 net/mac80211/mlme.c

  5005	
  5006	static int ieee80211_prep_channel(struct ieee80211_sub_if_data *sdata,
  5007					  struct cfg80211_bss *cbss)
  5008	{
  5009		struct ieee80211_local *local = sdata->local;
  5010		struct ieee80211_if_managed *ifmgd = &sdata->u.mgd;
  5011		const struct ieee80211_ht_cap *ht_cap = NULL;
  5012		const struct ieee80211_ht_operation *ht_oper = NULL;
  5013		const struct ieee80211_vht_operation *vht_oper = NULL;
  5014		const struct ieee80211_he_operation *he_oper = NULL;
  5015		const struct ieee80211_s1g_oper_ie *s1g_oper = NULL;
  5016		struct ieee80211_supported_band *sband;
  5017		struct cfg80211_chan_def chandef;
  5018		bool is_6ghz = cbss->channel->band == NL80211_BAND_6GHZ;
  5019		bool is_5ghz = cbss->channel->band == NL80211_BAND_5GHZ;
  5020		struct ieee80211_bss *bss = (void *)cbss->priv;
  5021		struct ieee802_11_elems *elems;
  5022		const struct cfg80211_bss_ies *ies;
  5023		int ret;
  5024		u32 i;
  5025		bool have_80mhz;
  5026	
  5027		rcu_read_lock();
  5028	
  5029		ies = rcu_dereference(cbss->ies);
  5030		elems = ieee802_11_parse_elems(ies->data, ies->len, false,
  5031					       NULL, NULL);
  5032		if (!elems) {
  5033			rcu_read_unlock();
  5034			return -ENOMEM;
  5035		}
  5036	
  5037		sband = local->hw.wiphy->bands[cbss->channel->band];
  5038	
  5039		ifmgd->flags &= ~(IEEE80211_STA_DISABLE_40MHZ |
  5040				  IEEE80211_STA_DISABLE_80P80MHZ |
  5041				  IEEE80211_STA_DISABLE_160MHZ);
  5042	
  5043		/* disable HT/VHT/HE if we don't support them */
  5044		if (!sband->ht_cap.ht_supported && !is_6ghz) {
  5045			mlme_dbg(sdata, "HT not supported, disabling HT/VHT/HE\n");
  5046			ifmgd->flags |= IEEE80211_STA_DISABLE_HT;
  5047			ifmgd->flags |= IEEE80211_STA_DISABLE_VHT;
  5048			ifmgd->flags |= IEEE80211_STA_DISABLE_HE;
  5049		}
  5050	
  5051		if (!sband->vht_cap.vht_supported && is_5ghz) {
  5052			mlme_dbg(sdata, "VHT not supported, disabling VHT/HE\n");
  5053			ifmgd->flags |= IEEE80211_STA_DISABLE_VHT;
  5054			ifmgd->flags |= IEEE80211_STA_DISABLE_HE;
  5055		}
  5056	
  5057		if (!ieee80211_get_he_iftype_cap(sband,
  5058						 ieee80211_vif_type_p2p(&sdata->vif))) {
  5059			mlme_dbg(sdata, "HE not supported, disabling it\n");
  5060			ifmgd->flags |= IEEE80211_STA_DISABLE_HE;
  5061		}
  5062	
  5063		if (!(ifmgd->flags & IEEE80211_STA_DISABLE_HT) && !is_6ghz) {
  5064			ht_oper = elems->ht_operation;
  5065			ht_cap = elems->ht_cap_elem;
  5066	
  5067			if (!ht_cap) {
  5068				ifmgd->flags |= IEEE80211_STA_DISABLE_HT;
  5069				ht_oper = NULL;
  5070			}
  5071		}
  5072	
  5073		if (!(ifmgd->flags & IEEE80211_STA_DISABLE_VHT) && !is_6ghz) {
  5074			vht_oper = elems->vht_operation;
  5075			if (vht_oper && !ht_oper) {
  5076				vht_oper = NULL;
  5077				sdata_info(sdata,
  5078					   "AP advertised VHT without HT, disabling HT/VHT/HE\n");
  5079				ifmgd->flags |= IEEE80211_STA_DISABLE_HT;
  5080				ifmgd->flags |= IEEE80211_STA_DISABLE_VHT;
  5081				ifmgd->flags |= IEEE80211_STA_DISABLE_HE;
  5082			}
  5083	
  5084			if (!elems->vht_cap_elem) {
> 5085				if (vht_cap)
  5086					sdata_info(sdata,
  5087						   "bad VHT capabilities, disabling VHT\n");
  5088				ifmgd->flags |= IEEE80211_STA_DISABLE_VHT;
  5089				vht_oper = NULL;
  5090			}
  5091		}
  5092	
  5093		if (!(ifmgd->flags & IEEE80211_STA_DISABLE_HE)) {
  5094			he_oper = elems->he_operation;
  5095	
  5096			if (is_6ghz) {
  5097				struct ieee80211_bss_conf *bss_conf;
  5098				u8 i, j = 0;
  5099	
  5100				bss_conf = &sdata->vif.bss_conf;
  5101	
  5102				if (elems->pwr_constr_elem)
  5103					bss_conf->pwr_reduction = *elems->pwr_constr_elem;
  5104	
  5105				BUILD_BUG_ON(ARRAY_SIZE(bss_conf->tx_pwr_env) !=
  5106					     ARRAY_SIZE(elems->tx_pwr_env));
  5107	
  5108				for (i = 0; i < elems->tx_pwr_env_num; i++) {
  5109					if (elems->tx_pwr_env_len[i] >
  5110					    sizeof(bss_conf->tx_pwr_env[j]))
  5111						continue;
  5112	
  5113					bss_conf->tx_pwr_env_num++;
  5114					memcpy(&bss_conf->tx_pwr_env[j], elems->tx_pwr_env[i],
  5115					       elems->tx_pwr_env_len[i]);
  5116					j++;
  5117				}
  5118			}
  5119	
  5120			if (!ieee80211_verify_sta_he_mcs_support(sdata, sband, he_oper))
  5121				ifmgd->flags |= IEEE80211_STA_DISABLE_HE;
  5122		}
  5123	
  5124		/* Allow VHT if at least one channel on the sband supports 80 MHz */
  5125		have_80mhz = false;
  5126		for (i = 0; i < sband->n_channels; i++) {
  5127			if (sband->channels[i].flags & (IEEE80211_CHAN_DISABLED |
  5128							IEEE80211_CHAN_NO_80MHZ))
  5129				continue;
  5130	
  5131			have_80mhz = true;
  5132			break;
  5133		}
  5134	
  5135		if (!have_80mhz) {
  5136			sdata_info(sdata, "80 MHz not supported, disabling VHT\n");
  5137			ifmgd->flags |= IEEE80211_STA_DISABLE_VHT;
  5138		}
  5139	
  5140		if (sband->band == NL80211_BAND_S1GHZ) {
  5141			s1g_oper = elems->s1g_oper;
  5142			if (!s1g_oper)
  5143				sdata_info(sdata,
  5144					   "AP missing S1G operation element?\n");
  5145		}
  5146	
  5147		ifmgd->flags |= ieee80211_determine_chantype(sdata, sband,
  5148							     cbss->channel,
  5149							     bss->vht_cap_info,
  5150							     ht_oper, vht_oper, he_oper,
  5151							     s1g_oper,
  5152							     &chandef, false);
  5153	
  5154		sdata->needed_rx_chains = min(ieee80211_ht_vht_rx_chains(sdata, cbss),
  5155					      local->rx_chains);
  5156	
  5157		rcu_read_unlock();
  5158		/* the element data was RCU protected so no longer valid anyway */
  5159		kfree(elems);
  5160		elems = NULL;
  5161	
  5162		if (ifmgd->flags & IEEE80211_STA_DISABLE_HE && is_6ghz) {
  5163			sdata_info(sdata, "Rejecting non-HE 6/7 GHz connection");
  5164			return -EINVAL;
  5165		}
  5166	
  5167		/* will change later if needed */
  5168		sdata->smps_mode = IEEE80211_SMPS_OFF;
  5169	
  5170		mutex_lock(&local->mtx);
  5171		/*
  5172		 * If this fails (possibly due to channel context sharing
  5173		 * on incompatible channels, e.g. 80+80 and 160 sharing the
  5174		 * same control channel) try to use a smaller bandwidth.
  5175		 */
  5176		ret = ieee80211_vif_use_channel(sdata, &chandef,
  5177						IEEE80211_CHANCTX_SHARED);
  5178	
  5179		/* don't downgrade for 5 and 10 MHz channels, though. */
  5180		if (chandef.width == NL80211_CHAN_WIDTH_5 ||
  5181		    chandef.width == NL80211_CHAN_WIDTH_10)
  5182			goto out;
  5183	
  5184		while (ret && chandef.width != NL80211_CHAN_WIDTH_20_NOHT) {
  5185			ifmgd->flags |= ieee80211_chandef_downgrade(&chandef);
  5186			ret = ieee80211_vif_use_channel(sdata, &chandef,
  5187							IEEE80211_CHANCTX_SHARED);
  5188		}
  5189	 out:
  5190		mutex_unlock(&local->mtx);
  5191		return ret;
  5192	}
  5193	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
