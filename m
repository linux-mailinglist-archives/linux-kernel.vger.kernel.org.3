Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 818A3502773
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 11:36:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351775AbiDOJiD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 05:38:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348954AbiDOJh7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 05:37:59 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69A47A996D
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 02:35:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650015330; x=1681551330;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=sO75P3i8YhHiT9yKSwD3drsgHXzjTjcGFPWU8lyWFRU=;
  b=ZINo+U3vYzo9wpO3x1audT+ix7hej2ca/0XFppHQaEQP94cja6G5/rFk
   OcdWa+4xMVsCplJ4sS2fvqhIFE7s+DMvzR5ksMPoKsGjNwwkrQRXgS0hP
   q61AflhJQEtgXtGWwuDXq3FUrrcGhkvEVfSFmUuKVNnf9p1asMCZjzIZE
   D3kjTQwI8IAkFgKcMdBF6a4XweoQ+hDcWq+IgwdVg6CBUYHSs4vOxFPBM
   1yJxdpULadmUkoyHhLOncErH6OvoQYeZuxUWh4xe2oX//5Qxkxp9asUOg
   TxqBaK8hPFZacYx3vykgJ3dDXgQygEXGPkECHiUnjcn+lPDLFbXVb4eSp
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10317"; a="262881533"
X-IronPort-AV: E=Sophos;i="5.90,262,1643702400"; 
   d="scan'208";a="262881533"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2022 02:35:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,262,1643702400"; 
   d="scan'208";a="612757953"
Received: from lkp-server01.sh.intel.com (HELO 3abc53900bec) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 15 Apr 2022 02:35:26 -0700
Received: from kbuild by 3abc53900bec with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nfIMP-0001nz-Vt;
        Fri, 15 Apr 2022 09:35:25 +0000
Date:   Fri, 15 Apr 2022 17:35:13 +0800
From:   kernel test robot <lkp@intel.com>
To:     Miles Hu <milehu@codeaurora.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Kalle Valo <kvalo@codeaurora.org>,
        Aloka Dixit <alokad@codeaurora.org>,
        Lavanya Suresh <lavaks@codeaurora.org>,
        Pradeep Chitrapu <pradeepc@codeaurora.org>,
        Venkateswara Naralasetty <vnaralas@codeaurora.org>,
        Jouni Malinen <jouni@codeaurora.org>
Subject: drivers/net/wireless/ath/ath11k/mac.c:1845:9: warning: Local
 variable 'i' shadows outer variable [shadowVariable]
Message-ID: <202204151759.YWh7KcKY-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   028192fea1de083f4f12bfb1eb7c4d7beb5c8ecd
commit: 61fe43e7216df6e9a912d831aafc7142fa20f280 ath11k: add support for setting fixed HE rate/gi/ltf
date:   7 months ago
compiler: riscv64-linux-gcc (GCC) 11.2.0
reproduce (cppcheck warning):
        # apt-get install cppcheck
        git checkout 61fe43e7216df6e9a912d831aafc7142fa20f280
        cppcheck --quiet --enable=style,performance,portability --template=gcc FILE

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


cppcheck warnings: (new ones prefixed by >>)
>> drivers/net/wireless/ath/ath11k/mac.c:1845:9: warning: Local variable 'i' shadows outer variable [shadowVariable]
       int i;
           ^
   drivers/net/wireless/ath/ath11k/mac.c:1775:6: note: Shadowed declaration
    int i, he_nss, nss_idx;
        ^
   drivers/net/wireless/ath/ath11k/mac.c:1845:9: note: Shadow variable
       int i;
           ^
>> drivers/net/wireless/ath/ath11k/mac.c:2778:7: warning: Local variable 'preamble' shadows outer variable [shadowVariable]
     u32 preamble;
         ^
   drivers/net/wireless/ath/ath11k/mac.c:2637:6: note: Shadowed declaration
    u32 preamble;
        ^
   drivers/net/wireless/ath/ath11k/mac.c:2778:7: note: Shadow variable
     u32 preamble;
         ^

cppcheck possible warnings: (new ones prefixed by >>, may not real problems)

>> drivers/scsi/scsi_transport_iscsi.c:437:26: warning: Parameter 'attr' can be declared with const [constParameter]
          struct attribute *attr, int i)
                            ^
   drivers/scsi/scsi_transport_iscsi.c:904:29: warning: Parameter 'attr' can be declared with const [constParameter]
             struct attribute *attr,
                               ^
   drivers/scsi/scsi_transport_iscsi.c:1106:29: warning: Parameter 'attr' can be declared with const [constParameter]
             struct attribute *attr,
                               ^
>> drivers/scsi/scsi_transport_iscsi.c:2456:51: warning: Parameter 'tt' can be declared with const [constParameter]
   iscsi_if_transport_lookup(struct iscsi_transport *tt)
                                                     ^
   drivers/scsi/scsi_transport_iscsi.c:4158:25: warning: Parameter 'attr' can be declared with const [constParameter]
         struct attribute *attr, int i)
                           ^
   drivers/scsi/scsi_transport_iscsi.c:4427:28: warning: Parameter 'attr' can be declared with const [constParameter]
            struct attribute *attr, int i)
                              ^
   drivers/scsi/scsi_transport_iscsi.c:4571:25: warning: Parameter 'attr' can be declared with const [constParameter]
         struct attribute *attr, int i)
                           ^
>> drivers/scsi/scsi_transport_iscsi.c:4660:60: warning: Parameter 'cont' can be declared with const [constParameter]
   static int iscsi_session_match(struct attribute_container *cont,
                                                              ^
   drivers/scsi/scsi_transport_iscsi.c:4682:57: warning: Parameter 'cont' can be declared with const [constParameter]
   static int iscsi_conn_match(struct attribute_container *cont,
                                                           ^
   drivers/scsi/scsi_transport_iscsi.c:4707:57: warning: Parameter 'cont' can be declared with const [constParameter]
   static int iscsi_host_match(struct attribute_container *cont,
                                                           ^
>> drivers/scsi/scsi_transport_iscsi.c:2463:19: warning: Uninitialized variable: priv->iscsi_transport [uninitvar]
     if (tt == priv->iscsi_transport) {
                     ^
>> drivers/scsi/scsi_transport_iscsi.c:3206:25: warning: Variable 'chap_rec' is not assigned a value. [unassignedVariable]
    struct iscsi_chap_rec *chap_rec;
                           ^
--
   drivers/net/wireless/ath/ath11k/mac.c:5684:2: warning: Assignment of function parameter has no effect outside the function. [uselessAssignmentArg]
    changed_flags &= SUPPORTED_FILTERS;
    ^
>> drivers/net/wireless/ath/ath11k/mac.c:7036:33: warning: Parameter 'channel' can be declared with const [constParameter]
         struct ieee80211_channel *channel)
                                   ^
>> drivers/net/wireless/ath/ath11k/mac.c:2466:7: warning: Uninitialized variable: ret [uninitvar]
    if (!ret)
         ^
>> drivers/net/wireless/ath/ath11k/mac.c:720:34: warning: Uninitialized variables: peer.list, peer.sta, peer.vdev_id, peer.peer_id, peer.ast_hash, peer.pdev_idx, peer.hw_peer_id, peer.tfm_mmic, peer.mcast_keyidx, peer.ucast_keyidx, peer.sec_type, peer.sec_type_grp [uninitvar]
     ath11k_peer_rx_tid_cleanup(ar, peer);
                                    ^
>> drivers/net/wireless/ath/ath11k/mac.c:6841:13: warning: Uninitialized variable: peer->sta [uninitvar]
     if (peer->sta) {
               ^
   drivers/net/wireless/ath/ath11k/mac.c:6832:22: note: Assuming condition is false
    if (!vht_fixed_rate && !he_fixed_rate)
                        ^
   drivers/net/wireless/ath/ath11k/mac.c:6841:13: note: Uninitialized variable: peer->sta
     if (peer->sta) {
               ^

vim +/i +1845 drivers/net/wireless/ath/ath11k/mac.c

61fe43e7216df6 Miles Hu            2021-09-24  1761  
d5c65159f28953 Kalle Valo          2019-11-23  1762  static void ath11k_peer_assoc_h_he(struct ath11k *ar,
d5c65159f28953 Kalle Valo          2019-11-23  1763  				   struct ieee80211_vif *vif,
d5c65159f28953 Kalle Valo          2019-11-23  1764  				   struct ieee80211_sta *sta,
d5c65159f28953 Kalle Valo          2019-11-23  1765  				   struct peer_assoc_params *arg)
d5c65159f28953 Kalle Valo          2019-11-23  1766  {
61fe43e7216df6 Miles Hu            2021-09-24  1767  	struct ath11k_vif *arvif = (void *)vif->drv_priv;
61fe43e7216df6 Miles Hu            2021-09-24  1768  	struct cfg80211_chan_def def;
9f056ed8ee01ad John Crispin        2019-11-25  1769  	const struct ieee80211_sta_he_cap *he_cap = &sta->he_cap;
af6d39db1b046a Tamizh Chelvam      2020-09-08  1770  	u8 ampdu_factor;
61fe43e7216df6 Miles Hu            2021-09-24  1771  	enum nl80211_band band;
61fe43e7216df6 Miles Hu            2021-09-24  1772  	u16 *he_mcs_mask;
61fe43e7216df6 Miles Hu            2021-09-24  1773  	u8 max_nss, he_mcs;
61fe43e7216df6 Miles Hu            2021-09-24  1774  	u16 he_tx_mcs = 0, v = 0;
61fe43e7216df6 Miles Hu            2021-09-24  1775  	int i, he_nss, nss_idx;
61fe43e7216df6 Miles Hu            2021-09-24  1776  	bool user_rate_valid = true;
61fe43e7216df6 Miles Hu            2021-09-24  1777  
61fe43e7216df6 Miles Hu            2021-09-24  1778  	if (WARN_ON(ath11k_mac_vif_chan(vif, &def)))
61fe43e7216df6 Miles Hu            2021-09-24  1779  		return;
9f056ed8ee01ad John Crispin        2019-11-25  1780  
9f056ed8ee01ad John Crispin        2019-11-25  1781  	if (!he_cap->has_he)
9f056ed8ee01ad John Crispin        2019-11-25  1782  		return;
9f056ed8ee01ad John Crispin        2019-11-25  1783  
61fe43e7216df6 Miles Hu            2021-09-24  1784  	band = def.chan->band;
61fe43e7216df6 Miles Hu            2021-09-24  1785  	he_mcs_mask = arvif->bitrate_mask.control[band].he_mcs;
61fe43e7216df6 Miles Hu            2021-09-24  1786  
61fe43e7216df6 Miles Hu            2021-09-24  1787  	if (ath11k_peer_assoc_h_he_masked(he_mcs_mask))
61fe43e7216df6 Miles Hu            2021-09-24  1788  		return;
61fe43e7216df6 Miles Hu            2021-09-24  1789  
9f056ed8ee01ad John Crispin        2019-11-25  1790  	arg->he_flag = true;
9f056ed8ee01ad John Crispin        2019-11-25  1791  
c8bcd82a4efd05 Kees Cook           2021-06-16  1792  	memcpy_and_pad(&arg->peer_he_cap_macinfo,
c8bcd82a4efd05 Kees Cook           2021-06-16  1793  		       sizeof(arg->peer_he_cap_macinfo),
c8bcd82a4efd05 Kees Cook           2021-06-16  1794  		       he_cap->he_cap_elem.mac_cap_info,
c8bcd82a4efd05 Kees Cook           2021-06-16  1795  		       sizeof(he_cap->he_cap_elem.mac_cap_info),
c8bcd82a4efd05 Kees Cook           2021-06-16  1796  		       0);
c8bcd82a4efd05 Kees Cook           2021-06-16  1797  	memcpy_and_pad(&arg->peer_he_cap_phyinfo,
c8bcd82a4efd05 Kees Cook           2021-06-16  1798  		       sizeof(arg->peer_he_cap_phyinfo),
c8bcd82a4efd05 Kees Cook           2021-06-16  1799  		       he_cap->he_cap_elem.phy_cap_info,
c8bcd82a4efd05 Kees Cook           2021-06-16  1800  		       sizeof(he_cap->he_cap_elem.phy_cap_info),
c8bcd82a4efd05 Kees Cook           2021-06-16  1801  		       0);
60689de46c7f6a Rajkumar Manoharan  2020-04-24  1802  	arg->peer_he_ops = vif->bss_conf.he_oper.params;
9f056ed8ee01ad John Crispin        2019-11-25  1803  
9f056ed8ee01ad John Crispin        2019-11-25  1804  	/* the top most byte is used to indicate BSS color info */
9f056ed8ee01ad John Crispin        2019-11-25  1805  	arg->peer_he_ops &= 0xffffff;
9f056ed8ee01ad John Crispin        2019-11-25  1806  
af6d39db1b046a Tamizh Chelvam      2020-09-08  1807  	/* As per section 26.6.1 11ax Draft5.0, if the Max AMPDU Exponent Extension
af6d39db1b046a Tamizh Chelvam      2020-09-08  1808  	 * in HE cap is zero, use the arg->peer_max_mpdu as calculated while parsing
af6d39db1b046a Tamizh Chelvam      2020-09-08  1809  	 * VHT caps(if VHT caps is present) or HT caps (if VHT caps is not present).
af6d39db1b046a Tamizh Chelvam      2020-09-08  1810  	 *
af6d39db1b046a Tamizh Chelvam      2020-09-08  1811  	 * For non-zero value of Max AMPDU Extponent Extension in HE MAC caps,
af6d39db1b046a Tamizh Chelvam      2020-09-08  1812  	 * if a HE STA sends VHT cap and HE cap IE in assoc request then, use
af6d39db1b046a Tamizh Chelvam      2020-09-08  1813  	 * MAX_AMPDU_LEN_FACTOR as 20 to calculate max_ampdu length.
af6d39db1b046a Tamizh Chelvam      2020-09-08  1814  	 * If a HE STA that does not send VHT cap, but HE and HT cap in assoc
af6d39db1b046a Tamizh Chelvam      2020-09-08  1815  	 * request, then use MAX_AMPDU_LEN_FACTOR as 16 to calculate max_ampdu
af6d39db1b046a Tamizh Chelvam      2020-09-08  1816  	 * length.
af6d39db1b046a Tamizh Chelvam      2020-09-08  1817  	 */
1f851b8dfd76a0 Johannes Berg       2021-04-09  1818  	ampdu_factor = u8_get_bits(he_cap->he_cap_elem.mac_cap_info[3],
1f851b8dfd76a0 Johannes Berg       2021-04-09  1819  				   IEEE80211_HE_MAC_CAP3_MAX_AMPDU_LEN_EXP_MASK);
af6d39db1b046a Tamizh Chelvam      2020-09-08  1820  
af6d39db1b046a Tamizh Chelvam      2020-09-08  1821  	if (ampdu_factor) {
af6d39db1b046a Tamizh Chelvam      2020-09-08  1822  		if (sta->vht_cap.vht_supported)
af6d39db1b046a Tamizh Chelvam      2020-09-08  1823  			arg->peer_max_mpdu = (1 << (IEEE80211_HE_VHT_MAX_AMPDU_FACTOR +
af6d39db1b046a Tamizh Chelvam      2020-09-08  1824  						    ampdu_factor)) - 1;
af6d39db1b046a Tamizh Chelvam      2020-09-08  1825  		else if (sta->ht_cap.ht_supported)
af6d39db1b046a Tamizh Chelvam      2020-09-08  1826  			arg->peer_max_mpdu = (1 << (IEEE80211_HE_HT_MAX_AMPDU_FACTOR +
af6d39db1b046a Tamizh Chelvam      2020-09-08  1827  						    ampdu_factor)) - 1;
af6d39db1b046a Tamizh Chelvam      2020-09-08  1828  	}
af6d39db1b046a Tamizh Chelvam      2020-09-08  1829  
9f056ed8ee01ad John Crispin        2019-11-25  1830  	if (he_cap->he_cap_elem.phy_cap_info[6] &
9f056ed8ee01ad John Crispin        2019-11-25  1831  	    IEEE80211_HE_PHY_CAP6_PPE_THRESHOLD_PRESENT) {
9f056ed8ee01ad John Crispin        2019-11-25  1832  		int bit = 7;
9f056ed8ee01ad John Crispin        2019-11-25  1833  		int nss, ru;
9f056ed8ee01ad John Crispin        2019-11-25  1834  
9f056ed8ee01ad John Crispin        2019-11-25  1835  		arg->peer_ppet.numss_m1 = he_cap->ppe_thres[0] &
9f056ed8ee01ad John Crispin        2019-11-25  1836  					  IEEE80211_PPE_THRES_NSS_MASK;
9f056ed8ee01ad John Crispin        2019-11-25  1837  		arg->peer_ppet.ru_bit_mask =
9f056ed8ee01ad John Crispin        2019-11-25  1838  			(he_cap->ppe_thres[0] &
9f056ed8ee01ad John Crispin        2019-11-25  1839  			 IEEE80211_PPE_THRES_RU_INDEX_BITMASK_MASK) >>
9f056ed8ee01ad John Crispin        2019-11-25  1840  			IEEE80211_PPE_THRES_RU_INDEX_BITMASK_POS;
9f056ed8ee01ad John Crispin        2019-11-25  1841  
9f056ed8ee01ad John Crispin        2019-11-25  1842  		for (nss = 0; nss <= arg->peer_ppet.numss_m1; nss++) {
9f056ed8ee01ad John Crispin        2019-11-25  1843  			for (ru = 0; ru < 4; ru++) {
9f056ed8ee01ad John Crispin        2019-11-25  1844  				u32 val = 0;
9f056ed8ee01ad John Crispin        2019-11-25 @1845  				int i;
9f056ed8ee01ad John Crispin        2019-11-25  1846  
9f056ed8ee01ad John Crispin        2019-11-25  1847  				if ((arg->peer_ppet.ru_bit_mask & BIT(ru)) == 0)
9f056ed8ee01ad John Crispin        2019-11-25  1848  					continue;
9f056ed8ee01ad John Crispin        2019-11-25  1849  				for (i = 0; i < 6; i++) {
9f056ed8ee01ad John Crispin        2019-11-25  1850  					val >>= 1;
9f056ed8ee01ad John Crispin        2019-11-25  1851  					val |= ((he_cap->ppe_thres[bit / 8] >>
9f056ed8ee01ad John Crispin        2019-11-25  1852  						 (bit % 8)) & 0x1) << 5;
9f056ed8ee01ad John Crispin        2019-11-25  1853  					bit++;
9f056ed8ee01ad John Crispin        2019-11-25  1854  				}
9f056ed8ee01ad John Crispin        2019-11-25  1855  				arg->peer_ppet.ppet16_ppet8_ru3_ru0[nss] |=
9f056ed8ee01ad John Crispin        2019-11-25  1856  								val << (ru * 6);
9f056ed8ee01ad John Crispin        2019-11-25  1857  			}
9f056ed8ee01ad John Crispin        2019-11-25  1858  		}
9f056ed8ee01ad John Crispin        2019-11-25  1859  	}
9f056ed8ee01ad John Crispin        2019-11-25  1860  
6d293d447670da John Crispin        2019-11-25  1861  	if (he_cap->he_cap_elem.mac_cap_info[0] & IEEE80211_HE_MAC_CAP0_TWT_RES)
6d293d447670da John Crispin        2019-11-25  1862  		arg->twt_responder = true;
6d293d447670da John Crispin        2019-11-25  1863  	if (he_cap->he_cap_elem.mac_cap_info[0] & IEEE80211_HE_MAC_CAP0_TWT_REQ)
6d293d447670da John Crispin        2019-11-25  1864  		arg->twt_requester = true;
6d293d447670da John Crispin        2019-11-25  1865  
61fe43e7216df6 Miles Hu            2021-09-24  1866  	he_nss =  ath11k_mac_max_he_nss(he_mcs_mask);
61fe43e7216df6 Miles Hu            2021-09-24  1867  
61fe43e7216df6 Miles Hu            2021-09-24  1868  	if (he_nss > sta->rx_nss) {
61fe43e7216df6 Miles Hu            2021-09-24  1869  		user_rate_valid = false;
61fe43e7216df6 Miles Hu            2021-09-24  1870  		for (nss_idx = sta->rx_nss - 1; nss_idx >= 0; nss_idx--) {
61fe43e7216df6 Miles Hu            2021-09-24  1871  			if (he_mcs_mask[nss_idx]) {
61fe43e7216df6 Miles Hu            2021-09-24  1872  				user_rate_valid = true;
61fe43e7216df6 Miles Hu            2021-09-24  1873  				break;
61fe43e7216df6 Miles Hu            2021-09-24  1874  			}
61fe43e7216df6 Miles Hu            2021-09-24  1875  		}
61fe43e7216df6 Miles Hu            2021-09-24  1876  	}
61fe43e7216df6 Miles Hu            2021-09-24  1877  
61fe43e7216df6 Miles Hu            2021-09-24  1878  	if (!user_rate_valid) {
61fe43e7216df6 Miles Hu            2021-09-24  1879  		ath11k_dbg(ar->ab, ATH11K_DBG_MAC, "mac setting he range mcs value to peer supported nss %d for peer %pM\n",
61fe43e7216df6 Miles Hu            2021-09-24  1880  			   sta->rx_nss, sta->addr);
61fe43e7216df6 Miles Hu            2021-09-24  1881  		he_mcs_mask[sta->rx_nss - 1] = he_mcs_mask[he_nss - 1];
61fe43e7216df6 Miles Hu            2021-09-24  1882  	}
61fe43e7216df6 Miles Hu            2021-09-24  1883  
9f056ed8ee01ad John Crispin        2019-11-25  1884  	switch (sta->bandwidth) {
9f056ed8ee01ad John Crispin        2019-11-25  1885  	case IEEE80211_STA_RX_BW_160:
9f056ed8ee01ad John Crispin        2019-11-25  1886  		if (he_cap->he_cap_elem.phy_cap_info[0] &
9f056ed8ee01ad John Crispin        2019-11-25  1887  		    IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_80PLUS80_MHZ_IN_5G) {
9f056ed8ee01ad John Crispin        2019-11-25  1888  			v = le16_to_cpu(he_cap->he_mcs_nss_supp.rx_mcs_80p80);
61fe43e7216df6 Miles Hu            2021-09-24  1889  			v = ath11k_peer_assoc_h_he_limit(v, he_mcs_mask);
9f056ed8ee01ad John Crispin        2019-11-25  1890  			arg->peer_he_rx_mcs_set[WMI_HECAP_TXRX_MCS_NSS_IDX_80_80] = v;
9f056ed8ee01ad John Crispin        2019-11-25  1891  
9f056ed8ee01ad John Crispin        2019-11-25  1892  			v = le16_to_cpu(he_cap->he_mcs_nss_supp.tx_mcs_80p80);
9f056ed8ee01ad John Crispin        2019-11-25  1893  			arg->peer_he_tx_mcs_set[WMI_HECAP_TXRX_MCS_NSS_IDX_80_80] = v;
9f056ed8ee01ad John Crispin        2019-11-25  1894  
9f056ed8ee01ad John Crispin        2019-11-25  1895  			arg->peer_he_mcs_count++;
61fe43e7216df6 Miles Hu            2021-09-24  1896  			he_tx_mcs = v;
9f056ed8ee01ad John Crispin        2019-11-25  1897  		}
9f056ed8ee01ad John Crispin        2019-11-25  1898  		v = le16_to_cpu(he_cap->he_mcs_nss_supp.rx_mcs_160);
9f056ed8ee01ad John Crispin        2019-11-25  1899  		arg->peer_he_rx_mcs_set[WMI_HECAP_TXRX_MCS_NSS_IDX_160] = v;
9f056ed8ee01ad John Crispin        2019-11-25  1900  
9f056ed8ee01ad John Crispin        2019-11-25  1901  		v = le16_to_cpu(he_cap->he_mcs_nss_supp.tx_mcs_160);
61fe43e7216df6 Miles Hu            2021-09-24  1902  		v = ath11k_peer_assoc_h_he_limit(v, he_mcs_mask);
9f056ed8ee01ad John Crispin        2019-11-25  1903  		arg->peer_he_tx_mcs_set[WMI_HECAP_TXRX_MCS_NSS_IDX_160] = v;
9f056ed8ee01ad John Crispin        2019-11-25  1904  
9f056ed8ee01ad John Crispin        2019-11-25  1905  		arg->peer_he_mcs_count++;
61fe43e7216df6 Miles Hu            2021-09-24  1906  		if (!he_tx_mcs)
61fe43e7216df6 Miles Hu            2021-09-24  1907  			he_tx_mcs = v;
0b294aebb6a00b Gustavo A. R. Silva 2020-07-27  1908  		fallthrough;
9f056ed8ee01ad John Crispin        2019-11-25  1909  
9f056ed8ee01ad John Crispin        2019-11-25  1910  	default:
9f056ed8ee01ad John Crispin        2019-11-25  1911  		v = le16_to_cpu(he_cap->he_mcs_nss_supp.rx_mcs_80);
9f056ed8ee01ad John Crispin        2019-11-25  1912  		arg->peer_he_rx_mcs_set[WMI_HECAP_TXRX_MCS_NSS_IDX_80] = v;
9f056ed8ee01ad John Crispin        2019-11-25  1913  
9f056ed8ee01ad John Crispin        2019-11-25  1914  		v = le16_to_cpu(he_cap->he_mcs_nss_supp.tx_mcs_80);
61fe43e7216df6 Miles Hu            2021-09-24  1915  		v = ath11k_peer_assoc_h_he_limit(v, he_mcs_mask);
9f056ed8ee01ad John Crispin        2019-11-25  1916  		arg->peer_he_tx_mcs_set[WMI_HECAP_TXRX_MCS_NSS_IDX_80] = v;
9f056ed8ee01ad John Crispin        2019-11-25  1917  
9f056ed8ee01ad John Crispin        2019-11-25  1918  		arg->peer_he_mcs_count++;
61fe43e7216df6 Miles Hu            2021-09-24  1919  		if (!he_tx_mcs)
61fe43e7216df6 Miles Hu            2021-09-24  1920  			he_tx_mcs = v;
9f056ed8ee01ad John Crispin        2019-11-25  1921  		break;
9f056ed8ee01ad John Crispin        2019-11-25  1922  	}
61fe43e7216df6 Miles Hu            2021-09-24  1923  
61fe43e7216df6 Miles Hu            2021-09-24  1924  	/* Calculate peer NSS capability from HE capabilities if STA
61fe43e7216df6 Miles Hu            2021-09-24  1925  	 * supports HE.
61fe43e7216df6 Miles Hu            2021-09-24  1926  	 */
61fe43e7216df6 Miles Hu            2021-09-24  1927  	for (i = 0, max_nss = 0, he_mcs = 0; i < NL80211_HE_NSS_MAX; i++) {
61fe43e7216df6 Miles Hu            2021-09-24  1928  		he_mcs = he_tx_mcs >> (2 * i) & 3;
61fe43e7216df6 Miles Hu            2021-09-24  1929  
61fe43e7216df6 Miles Hu            2021-09-24  1930  		/* In case of fixed rates, MCS Range in he_tx_mcs might have
61fe43e7216df6 Miles Hu            2021-09-24  1931  		 * unsupported range, with he_mcs_mask set, so check either of them
61fe43e7216df6 Miles Hu            2021-09-24  1932  		 * to find nss.
61fe43e7216df6 Miles Hu            2021-09-24  1933  		 */
61fe43e7216df6 Miles Hu            2021-09-24  1934  		if (he_mcs != IEEE80211_HE_MCS_NOT_SUPPORTED ||
61fe43e7216df6 Miles Hu            2021-09-24  1935  		    he_mcs_mask[i])
61fe43e7216df6 Miles Hu            2021-09-24  1936  			max_nss = i + 1;
61fe43e7216df6 Miles Hu            2021-09-24  1937  	}
61fe43e7216df6 Miles Hu            2021-09-24  1938  	arg->peer_nss = min(sta->rx_nss, max_nss);
61fe43e7216df6 Miles Hu            2021-09-24  1939  
61fe43e7216df6 Miles Hu            2021-09-24  1940  	ath11k_dbg(ar->ab, ATH11K_DBG_MAC,
61fe43e7216df6 Miles Hu            2021-09-24  1941  		   "mac he peer %pM nss %d mcs cnt %d\n",
61fe43e7216df6 Miles Hu            2021-09-24  1942  		   sta->addr, arg->peer_nss, arg->peer_he_mcs_count);
d5c65159f28953 Kalle Valo          2019-11-23  1943  }
d5c65159f28953 Kalle Valo          2019-11-23  1944  

:::::: The code at line 1845 was first introduced by commit
:::::: 9f056ed8ee01ad6898db49707cdc70ce923be3d0 ath11k: add HE support

:::::: TO: John Crispin <john@phrozen.org>
:::::: CC: Kalle Valo <kvalo@codeaurora.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
