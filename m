Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17CC44815E5
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Dec 2021 18:39:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241124AbhL2RjR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Dec 2021 12:39:17 -0500
Received: from mga06.intel.com ([134.134.136.31]:46048 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231217AbhL2RjQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Dec 2021 12:39:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640799556; x=1672335556;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=wtFfeiNyTTvOmaiv8HmWk9Y5TPTA7BkoMXdIveUOA8o=;
  b=PgjOvllex9RsFHmR7qGUTnY2LNQjGPwRbrIHDrcFvcHahPfV7xFaz6N3
   7JDMaQxrQys46RaChOGtToyXRyPFvPZM8/uvLy7RNimswGEnZtOEiLfCM
   rMZllTYJUl5ewBODxR0unIggVEHBHUow95G4MQjAGyRgi7vdv/gXk/tyK
   MKezL0oEjQCuzhWeLW8Zwi49bQJBybpRlgpv5flsCKoNMFxzVNIJbyL8D
   VEkHm9pjyjVmLUdtMeTDdgFZ2T+b02uXmbur2aQRXTMjx1RtuixOcHL4m
   9mwFQAwxrVevCn3pC5UOijvrTdf0bZRIZuZft7zd8RH+E136HpDBOUFd3
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10212"; a="302300878"
X-IronPort-AV: E=Sophos;i="5.88,246,1635231600"; 
   d="scan'208";a="302300878"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Dec 2021 09:39:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,246,1635231600"; 
   d="scan'208";a="524085127"
Received: from lkp-server01.sh.intel.com (HELO e357b3ef1427) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 29 Dec 2021 09:39:14 -0800
Received: from kbuild by e357b3ef1427 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n2cuv-0009HY-R5; Wed, 29 Dec 2021 17:39:13 +0000
Date:   Thu, 30 Dec 2021 01:38:21 +0800
From:   kernel test robot <lkp@intel.com>
To:     Felix Fietkau <nbd@nbd.name>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [nbd168-wireless:mt76 62/62]
 drivers/net/wireless/mediatek/mt76/mt7915/main.c:411:35: warning: implicit
 conversion from 'enum mcu_cipher_type' to 'enum mt76_cipher_type'
Message-ID: <202112300121.0IhhiGM4-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/nbd168/wireless mt76
head:   b18073c341fd3b4143cd034decb0ad8544b51bdf
commit: b18073c341fd3b4143cd034decb0ad8544b51bdf [62/62] mt76: mt7915: update bss_info with cipher after setting the group key
config: alpha-allyesconfig (https://download.01.org/0day-ci/archive/20211230/202112300121.0IhhiGM4-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/nbd168/wireless/commit/b18073c341fd3b4143cd034decb0ad8544b51bdf
        git remote add nbd168-wireless https://github.com/nbd168/wireless
        git fetch --no-tags nbd168-wireless mt76
        git checkout b18073c341fd3b4143cd034decb0ad8544b51bdf
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=alpha SHELL=/bin/bash drivers/net/wireless/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/net/wireless/mediatek/mt76/mt7915/main.c: In function 'mt7915_set_key':
>> drivers/net/wireless/mediatek/mt76/mt7915/main.c:411:35: warning: implicit conversion from 'enum mcu_cipher_type' to 'enum mt76_cipher_type' [-Wenum-conversion]
     411 |                 mvif->mt76.cipher = mt76_connac_mcu_get_cipher(key->cipher);
         |                                   ^


vim +411 drivers/net/wireless/mediatek/mt76/mt7915/main.c

   364	
   365	static int mt7915_set_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
   366				  struct ieee80211_vif *vif, struct ieee80211_sta *sta,
   367				  struct ieee80211_key_conf *key)
   368	{
   369		struct mt7915_dev *dev = mt7915_hw_dev(hw);
   370		struct mt7915_phy *phy = mt7915_hw_phy(hw);
   371		struct mt7915_vif *mvif = (struct mt7915_vif *)vif->drv_priv;
   372		struct mt7915_sta *msta = sta ? (struct mt7915_sta *)sta->drv_priv :
   373					  &mvif->sta;
   374		struct mt76_wcid *wcid = &msta->wcid;
   375		u8 *wcid_keyidx = &wcid->hw_key_idx;
   376		int idx = key->keyidx;
   377		int err = 0;
   378	
   379		/* The hardware does not support per-STA RX GTK, fallback
   380		 * to software mode for these.
   381		 */
   382		if ((vif->type == NL80211_IFTYPE_ADHOC ||
   383		     vif->type == NL80211_IFTYPE_MESH_POINT) &&
   384		    (key->cipher == WLAN_CIPHER_SUITE_TKIP ||
   385		     key->cipher == WLAN_CIPHER_SUITE_CCMP) &&
   386		    !(key->flags & IEEE80211_KEY_FLAG_PAIRWISE))
   387			return -EOPNOTSUPP;
   388	
   389		/* fall back to sw encryption for unsupported ciphers */
   390		switch (key->cipher) {
   391		case WLAN_CIPHER_SUITE_AES_CMAC:
   392			wcid_keyidx = &wcid->hw_key_idx2;
   393			key->flags |= IEEE80211_KEY_FLAG_GENERATE_MMIE;
   394			break;
   395		case WLAN_CIPHER_SUITE_TKIP:
   396		case WLAN_CIPHER_SUITE_CCMP:
   397		case WLAN_CIPHER_SUITE_CCMP_256:
   398		case WLAN_CIPHER_SUITE_GCMP:
   399		case WLAN_CIPHER_SUITE_GCMP_256:
   400		case WLAN_CIPHER_SUITE_SMS4:
   401			break;
   402		case WLAN_CIPHER_SUITE_WEP40:
   403		case WLAN_CIPHER_SUITE_WEP104:
   404		default:
   405			return -EOPNOTSUPP;
   406		}
   407	
   408		mutex_lock(&dev->mt76.mutex);
   409	
   410		if (cmd == SET_KEY && !sta && !mvif->mt76.cipher) {
 > 411			mvif->mt76.cipher = mt76_connac_mcu_get_cipher(key->cipher);
   412			mt7915_mcu_add_bss_info(phy, vif, true);
   413		}
   414	
   415		if (cmd == SET_KEY)
   416			*wcid_keyidx = idx;
   417		else if (idx == *wcid_keyidx)
   418			*wcid_keyidx = -1;
   419		else
   420			goto out;
   421	
   422		mt76_wcid_key_setup(&dev->mt76, wcid,
   423				    cmd == SET_KEY ? key : NULL);
   424	
   425		err = mt76_connac_mcu_add_key(&dev->mt76, vif, &msta->bip,
   426					      key, MCU_EXT_CMD(STA_REC_UPDATE),
   427					      &msta->wcid, cmd);
   428	out:
   429		mutex_unlock(&dev->mt76.mutex);
   430	
   431		return err;
   432	}
   433	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
