Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25ECC4B79B1
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 22:49:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244287AbiBOVHh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 16:07:37 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237465AbiBOVHg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 16:07:36 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 995A22FFE3;
        Tue, 15 Feb 2022 13:07:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644959245; x=1676495245;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=L7n8zm9Mv7CaXAqF7R96N+XLVC5Z7D6HaUCIWDsaT9c=;
  b=TWuvog1t8s5ueB0PqsAzEMXqwyKyYyAgmiFGYQ141yZsoaBoHMKBMJ29
   zzuhVZ8UZHSw/YxCjNsNMPXSObD5XN2oWaGs2FoioRofmo7mLhgf/BCAb
   B0LUgeIuaolXeMIzNmU4grcuOZEJV9PEO8lMQHWBoEQl+GkhJw4oygaaz
   pLspu/kBqO8Kz/JzGAhE5umHP4OhdBYyYfYK6ruL7ptM2jFo90mSVXkjs
   8BZi7RIJedYK3QmrZLCRuQgI99FeaBDJrRRog0v3JoN7XQTS+pUFzIOBU
   /JQ22X3ACyAALqjjU7ruVH0yIFEG5bufr3/V5xRxwIHOB48/nzIjvZGoV
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10259"; a="275031597"
X-IronPort-AV: E=Sophos;i="5.88,371,1635231600"; 
   d="scan'208";a="275031597"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2022 13:07:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,371,1635231600"; 
   d="scan'208";a="681201331"
Received: from lkp-server01.sh.intel.com (HELO d95dc2dabeb1) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 15 Feb 2022 13:07:06 -0800
Received: from kbuild by d95dc2dabeb1 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nK52Q-000A2J-5y; Tue, 15 Feb 2022 21:07:06 +0000
Date:   Wed, 16 Feb 2022 05:06:13 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jiri Kosina <jikos@kernel.org>,
        Johannes Berg <johannes@sipsolutions.net>
Cc:     kbuild-all@lists.01.org, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mac80211: fix RCU usage in ieee80211_tx_h_select_key()
Message-ID: <202202160406.p1c7XduC-lkp@intel.com>
References: <nycvar.YFH.7.76.2202151643220.11721@cbobk.fhfr.pm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <nycvar.YFH.7.76.2202151643220.11721@cbobk.fhfr.pm>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jiri,

I love your patch! Perhaps something to improve:

[auto build test WARNING on wireless-next/main]
[also build test WARNING on wireless/main jberg-mac80211-next/master jberg-mac80211/master v5.17-rc4 next-20220215]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Jiri-Kosina/mac80211-fix-RCU-usage-in-ieee80211_tx_h_select_key/20220215-234935
base:   https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git main
config: i386-randconfig-s002-20220214 (https://download.01.org/0day-ci/archive/20220216/202202160406.p1c7XduC-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://github.com/0day-ci/linux/commit/cdfe17d7fc283e125686bdd9a6bbc6fd60909bd7
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Jiri-Kosina/mac80211-fix-RCU-usage-in-ieee80211_tx_h_select_key/20220215-234935
        git checkout cdfe17d7fc283e125686bdd9a6bbc6fd60909bd7
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=i386 SHELL=/bin/bash net/mac80211/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> net/mac80211/tx.c:652:29: sparse: sparse: incorrect type in assignment (different base types) @@     expected int ret @@     got restricted ieee80211_tx_result [usertype] @@
   net/mac80211/tx.c:652:29: sparse:     expected int ret
   net/mac80211/tx.c:652:29: sparse:     got restricted ieee80211_tx_result [usertype]
   net/mac80211/tx.c:661:21: sparse: sparse: incorrect type in assignment (different base types) @@     expected int ret @@     got restricted ieee80211_tx_result [usertype] @@
   net/mac80211/tx.c:661:21: sparse:     expected int ret
   net/mac80211/tx.c:661:21: sparse:     got restricted ieee80211_tx_result [usertype]
   net/mac80211/tx.c:664:13: sparse: sparse: incorrect type in assignment (different base types) @@     expected int ret @@     got restricted ieee80211_tx_result [usertype] @@
   net/mac80211/tx.c:664:13: sparse:     expected int ret
   net/mac80211/tx.c:664:13: sparse:     got restricted ieee80211_tx_result [usertype]
>> net/mac80211/tx.c:667:16: sparse: sparse: incorrect type in return expression (different base types) @@     expected restricted ieee80211_tx_result @@     got int ret @@
   net/mac80211/tx.c:667:16: sparse:     expected restricted ieee80211_tx_result
   net/mac80211/tx.c:667:16: sparse:     got int ret

vim +652 net/mac80211/tx.c

   579	
   580	static ieee80211_tx_result debug_noinline
   581	ieee80211_tx_h_select_key(struct ieee80211_tx_data *tx)
   582	{
   583		int ret;
   584		struct ieee80211_key *key;
   585		struct ieee80211_tx_info *info = IEEE80211_SKB_CB(tx->skb);
   586		struct ieee80211_hdr *hdr = (struct ieee80211_hdr *)tx->skb->data;
   587	
   588		if (unlikely(info->flags & IEEE80211_TX_INTFL_DONT_ENCRYPT)) {
   589			tx->key = NULL;
   590			return TX_CONTINUE;
   591		}
   592	
   593		rcu_read_lock();
   594	
   595		if (tx->sta &&
   596		    (key = rcu_dereference(tx->sta->ptk[tx->sta->ptk_idx])))
   597			tx->key = key;
   598		else if (ieee80211_is_group_privacy_action(tx->skb) &&
   599			(key = rcu_dereference(tx->sdata->default_multicast_key)))
   600			tx->key = key;
   601		else if (ieee80211_is_mgmt(hdr->frame_control) &&
   602			 is_multicast_ether_addr(hdr->addr1) &&
   603			 ieee80211_is_robust_mgmt_frame(tx->skb) &&
   604			 (key = rcu_dereference(tx->sdata->default_mgmt_key)))
   605			tx->key = key;
   606		else if (is_multicast_ether_addr(hdr->addr1) &&
   607			 (key = rcu_dereference(tx->sdata->default_multicast_key)))
   608			tx->key = key;
   609		else if (!is_multicast_ether_addr(hdr->addr1) &&
   610			 (key = rcu_dereference(tx->sdata->default_unicast_key)))
   611			tx->key = key;
   612		else
   613			tx->key = NULL;
   614	
   615		if (tx->key) {
   616			bool skip_hw = false;
   617	
   618			/* TODO: add threshold stuff again */
   619	
   620			switch (tx->key->conf.cipher) {
   621			case WLAN_CIPHER_SUITE_WEP40:
   622			case WLAN_CIPHER_SUITE_WEP104:
   623			case WLAN_CIPHER_SUITE_TKIP:
   624				if (!ieee80211_is_data_present(hdr->frame_control))
   625					tx->key = NULL;
   626				break;
   627			case WLAN_CIPHER_SUITE_CCMP:
   628			case WLAN_CIPHER_SUITE_CCMP_256:
   629			case WLAN_CIPHER_SUITE_GCMP:
   630			case WLAN_CIPHER_SUITE_GCMP_256:
   631				if (!ieee80211_is_data_present(hdr->frame_control) &&
   632				    !ieee80211_use_mfp(hdr->frame_control, tx->sta,
   633						       tx->skb) &&
   634				    !ieee80211_is_group_privacy_action(tx->skb))
   635					tx->key = NULL;
   636				else
   637					skip_hw = (tx->key->conf.flags &
   638						   IEEE80211_KEY_FLAG_SW_MGMT_TX) &&
   639						ieee80211_is_mgmt(hdr->frame_control);
   640				break;
   641			case WLAN_CIPHER_SUITE_AES_CMAC:
   642			case WLAN_CIPHER_SUITE_BIP_CMAC_256:
   643			case WLAN_CIPHER_SUITE_BIP_GMAC_128:
   644			case WLAN_CIPHER_SUITE_BIP_GMAC_256:
   645				if (!ieee80211_is_mgmt(hdr->frame_control))
   646					tx->key = NULL;
   647				break;
   648			}
   649	
   650			if (unlikely(tx->key && tx->key->flags & KEY_FLAG_TAINTED &&
   651				     !ieee80211_is_deauth(hdr->frame_control))) {
 > 652				ret = TX_DROP;
   653				goto out;
   654			}
   655	
   656			if (!skip_hw && tx->key &&
   657			    tx->key->flags & KEY_FLAG_UPLOADED_TO_HARDWARE)
   658				info->control.hw_key = &tx->key->conf;
   659		} else if (ieee80211_is_data_present(hdr->frame_control) && tx->sta &&
   660			   test_sta_flag(tx->sta, WLAN_STA_USES_ENCRYPTION)) {
   661			ret = TX_DROP;
   662			goto out;
   663		}
   664		ret = TX_CONTINUE;
   665	out:
   666		rcu_read_unlock();
 > 667		return ret;
   668	}
   669	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
