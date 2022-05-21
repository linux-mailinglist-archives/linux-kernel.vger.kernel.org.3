Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19BB352FF7A
	for <lists+linux-kernel@lfdr.de>; Sat, 21 May 2022 22:45:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244644AbiEUUo6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 May 2022 16:44:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232211AbiEUUo4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 May 2022 16:44:56 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8734640914
        for <linux-kernel@vger.kernel.org>; Sat, 21 May 2022 13:44:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653165895; x=1684701895;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=rOfTKvK0UmtLZVyJidSDNdqOlFGh4soKUNHTuYlPYps=;
  b=PyZYcUVPUeFDa2YtUpGmum5KPdmGqdhSD3q6jnjVYzjbJoEJH/aCCWDA
   YwsgWSYYAjk1cLzjV/7wbliORXbhOP0pmHeWLNHp0FavtOIt8A3gD/aRs
   pQNwJuYIZQ9Nngx3fowjfhmrAoxKAFXg8/VpV/vQbz393mqGvHwMiTmPP
   6D9B3x2Huw0R3wyqaZFSNcaAEVh8GGh++tBhXJFczxm4S166wz9PO1kVP
   qjmVhqlIkg3dyB3jDjHISql0dT38aVI4C7RYooDtWkvMJD+xjqS5AyTHB
   /aHR+83y/h/FtA5dml2Pa9mUuznnaLQND4kkbrxuzDDfPMBNguxkeN5sp
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10354"; a="254955883"
X-IronPort-AV: E=Sophos;i="5.91,243,1647327600"; 
   d="scan'208";a="254955883"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2022 13:44:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,243,1647327600"; 
   d="scan'208";a="558004391"
Received: from lkp-server02.sh.intel.com (HELO 242b25809ac7) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 21 May 2022 13:44:52 -0700
Received: from kbuild by 242b25809ac7 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nsVxz-0006bc-NA;
        Sat, 21 May 2022 20:44:51 +0000
Date:   Sun, 22 May 2022 04:44:20 +0800
From:   kernel test robot <lkp@intel.com>
To:     Martin Kaiser <martin@kaiser.cx>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     kbuild-all@lists.01.org, Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: Re: [PATCH 05/12] staging: r8188eu: use mgmt to set the sequence
 number
Message-ID: <202205220408.1gEq5pSp-lkp@intel.com>
References: <20220521153824.218196-6-martin@kaiser.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220521153824.218196-6-martin@kaiser.cx>
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Martin,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on staging/staging-testing]

url:    https://github.com/intel-lab-lkp/linux/commits/Martin-Kaiser/staging-r8188eu-start-cleaning-up-issue_action_BA/20220521-234202
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git 6a31a95135da0bb2c5349e49e37d76e9909ab7ea
config: i386-randconfig-a005 (https://download.01.org/0day-ci/archive/20220522/202205220408.1gEq5pSp-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-1) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/d2cf0b366868a18d3237f29c55e8c2f3a95a433f
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Martin-Kaiser/staging-r8188eu-start-cleaning-up-issue_action_BA/20220521-234202
        git checkout d2cf0b366868a18d3237f29c55e8c2f3a95a433f
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash drivers/staging/r8188eu/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/staging/r8188eu/core/rtw_mlme_ext.c: In function 'issue_action_BA':
>> drivers/staging/r8188eu/core/rtw_mlme_ext.c:5378:31: warning: variable 'pwlanhdr' set but not used [-Wunused-but-set-variable]
    5378 |         struct ieee80211_hdr *pwlanhdr;
         |                               ^~~~~~~~


vim +/pwlanhdr +5378 drivers/staging/r8188eu/core/rtw_mlme_ext.c

15865124feed88 Phillip Potter  2021-07-28  5365  
15865124feed88 Phillip Potter  2021-07-28  5366  void issue_action_BA(struct adapter *padapter, unsigned char *raddr, unsigned char action, unsigned short status)
15865124feed88 Phillip Potter  2021-07-28  5367  {
64c62b697f7612 Martin Kaiser   2022-05-02  5368  	u8 category = WLAN_CATEGORY_BACK;
15865124feed88 Phillip Potter  2021-07-28  5369  	u16 start_seq;
15865124feed88 Phillip Potter  2021-07-28  5370  	u16 BA_para_set;
15865124feed88 Phillip Potter  2021-07-28  5371  	u16 reason_code;
15865124feed88 Phillip Potter  2021-07-28  5372  	u16 BA_timeout_value;
15865124feed88 Phillip Potter  2021-07-28  5373  	__le16	le_tmp;
15865124feed88 Phillip Potter  2021-07-28  5374  	u16 BA_starting_seqctrl = 0;
15865124feed88 Phillip Potter  2021-07-28  5375  	struct xmit_frame *pmgntframe;
15865124feed88 Phillip Potter  2021-07-28  5376  	struct pkt_attrib *pattrib;
15865124feed88 Phillip Potter  2021-07-28  5377  	u8 *pframe;
9dc9653c8501b9 Michael Straube 2022-04-18 @5378  	struct ieee80211_hdr *pwlanhdr;
3b522a11b50476 Michael Straube 2021-08-09  5379  	struct xmit_priv *pxmitpriv = &padapter->xmitpriv;
3b522a11b50476 Michael Straube 2021-08-09  5380  	struct mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
3b522a11b50476 Michael Straube 2021-08-09  5381  	struct mlme_ext_info *pmlmeinfo = &pmlmeext->mlmext_info;
15865124feed88 Phillip Potter  2021-07-28  5382  	struct sta_info *psta;
15865124feed88 Phillip Potter  2021-07-28  5383  	struct sta_priv *pstapriv = &padapter->stapriv;
15865124feed88 Phillip Potter  2021-07-28  5384  	struct registry_priv *pregpriv = &padapter->registrypriv;
106e8dfa1c07a9 Martin Kaiser   2022-05-21  5385  	struct ieee80211_mgmt *mgmt;
15865124feed88 Phillip Potter  2021-07-28  5386  
15865124feed88 Phillip Potter  2021-07-28  5387  	pmgntframe = alloc_mgtxmitframe(pxmitpriv);
552838fdcaef2c Michael Straube 2021-08-01  5388  	if (!pmgntframe)
15865124feed88 Phillip Potter  2021-07-28  5389  		return;
15865124feed88 Phillip Potter  2021-07-28  5390  
15865124feed88 Phillip Potter  2021-07-28  5391  	/* update attribute */
15865124feed88 Phillip Potter  2021-07-28  5392  	pattrib = &pmgntframe->attrib;
15865124feed88 Phillip Potter  2021-07-28  5393  	update_mgntframe_attrib(padapter, pattrib);
15865124feed88 Phillip Potter  2021-07-28  5394  
15865124feed88 Phillip Potter  2021-07-28  5395  	memset(pmgntframe->buf_addr, 0, WLANHDR_OFFSET + TXDESC_OFFSET);
15865124feed88 Phillip Potter  2021-07-28  5396  
15865124feed88 Phillip Potter  2021-07-28  5397  	pframe = (u8 *)(pmgntframe->buf_addr) + TXDESC_OFFSET;
9dc9653c8501b9 Michael Straube 2022-04-18  5398  	pwlanhdr = (struct ieee80211_hdr *)pframe;
106e8dfa1c07a9 Martin Kaiser   2022-05-21  5399  	mgmt = (struct ieee80211_mgmt *)pframe;
15865124feed88 Phillip Potter  2021-07-28  5400  
106e8dfa1c07a9 Martin Kaiser   2022-05-21  5401  	mgmt->frame_control = cpu_to_le16(IEEE80211_STYPE_ACTION | IEEE80211_FTYPE_MGMT);
15865124feed88 Phillip Potter  2021-07-28  5402  
35f6cf522c478c Martin Kaiser   2022-05-21  5403  	memcpy(mgmt->da, raddr, ETH_ALEN);
35f6cf522c478c Martin Kaiser   2022-05-21  5404  	memcpy(mgmt->sa, myid(&padapter->eeprompriv), ETH_ALEN);
35f6cf522c478c Martin Kaiser   2022-05-21  5405  	memcpy(mgmt->bssid, get_my_bssid(&pmlmeinfo->network), ETH_ALEN);
15865124feed88 Phillip Potter  2021-07-28  5406  
d2cf0b366868a1 Martin Kaiser   2022-05-21  5407  	mgmt->seq_ctrl = cpu_to_le16(pmlmeext->mgnt_seq);
15865124feed88 Phillip Potter  2021-07-28  5408  	pmlmeext->mgnt_seq++;
15865124feed88 Phillip Potter  2021-07-28  5409  
9dc9653c8501b9 Michael Straube 2022-04-18  5410  	pframe += sizeof(struct ieee80211_hdr_3addr);
9dc9653c8501b9 Michael Straube 2022-04-18  5411  	pattrib->pktlen = sizeof(struct ieee80211_hdr_3addr);
15865124feed88 Phillip Potter  2021-07-28  5412  
3b522a11b50476 Michael Straube 2021-08-09  5413  	pframe = rtw_set_fixed_ie(pframe, 1, &(category), &pattrib->pktlen);
3b522a11b50476 Michael Straube 2021-08-09  5414  	pframe = rtw_set_fixed_ie(pframe, 1, &(action), &pattrib->pktlen);
15865124feed88 Phillip Potter  2021-07-28  5415  
15865124feed88 Phillip Potter  2021-07-28  5416  	switch (action) {
84aee42a485b38 Martin Kaiser   2022-05-21  5417  	case WLAN_ACTION_ADDBA_REQ:
15865124feed88 Phillip Potter  2021-07-28  5418  		do {
15865124feed88 Phillip Potter  2021-07-28  5419  			pmlmeinfo->dialogToken++;
15865124feed88 Phillip Potter  2021-07-28  5420  		} while (pmlmeinfo->dialogToken == 0);
3b522a11b50476 Michael Straube 2021-08-09  5421  		pframe = rtw_set_fixed_ie(pframe, 1, &pmlmeinfo->dialogToken, &pattrib->pktlen);
15865124feed88 Phillip Potter  2021-07-28  5422  
15865124feed88 Phillip Potter  2021-07-28  5423  		BA_para_set = (0x1002 | ((status & 0xf) << 2)); /* immediate ack & 64 buffer size */
15865124feed88 Phillip Potter  2021-07-28  5424  		le_tmp = cpu_to_le16(BA_para_set);
3b522a11b50476 Michael Straube 2021-08-09  5425  		pframe = rtw_set_fixed_ie(pframe, 2, (unsigned char *)&le_tmp, &pattrib->pktlen);
15865124feed88 Phillip Potter  2021-07-28  5426  
15865124feed88 Phillip Potter  2021-07-28  5427  		BA_timeout_value = 5000;/*  5ms */
15865124feed88 Phillip Potter  2021-07-28  5428  		le_tmp = cpu_to_le16(BA_timeout_value);
3b522a11b50476 Michael Straube 2021-08-09  5429  		pframe = rtw_set_fixed_ie(pframe, 2, (unsigned char *)&le_tmp, &pattrib->pktlen);
15865124feed88 Phillip Potter  2021-07-28  5430  
15865124feed88 Phillip Potter  2021-07-28  5431  		psta = rtw_get_stainfo(pstapriv, raddr);
552838fdcaef2c Michael Straube 2021-08-01  5432  		if (psta) {
15865124feed88 Phillip Potter  2021-07-28  5433  			start_seq = (psta->sta_xmitpriv.txseq_tid[status & 0x07] & 0xfff) + 1;
15865124feed88 Phillip Potter  2021-07-28  5434  
15865124feed88 Phillip Potter  2021-07-28  5435  			psta->BA_starting_seqctrl[status & 0x07] = start_seq;
15865124feed88 Phillip Potter  2021-07-28  5436  
15865124feed88 Phillip Potter  2021-07-28  5437  			BA_starting_seqctrl = start_seq << 4;
15865124feed88 Phillip Potter  2021-07-28  5438  		}
15865124feed88 Phillip Potter  2021-07-28  5439  		le_tmp = cpu_to_le16(BA_starting_seqctrl);
3b522a11b50476 Michael Straube 2021-08-09  5440  		pframe = rtw_set_fixed_ie(pframe, 2, (unsigned char *)&le_tmp, &pattrib->pktlen);
15865124feed88 Phillip Potter  2021-07-28  5441  		break;
84aee42a485b38 Martin Kaiser   2022-05-21  5442  	case WLAN_ACTION_ADDBA_RESP:
3b522a11b50476 Michael Straube 2021-08-09  5443  		pframe = rtw_set_fixed_ie(pframe, 1, &pmlmeinfo->ADDBA_req.dialog_token, &pattrib->pktlen);
3b522a11b50476 Michael Straube 2021-08-09  5444  		pframe = rtw_set_fixed_ie(pframe, 2, (unsigned char *)&status, &pattrib->pktlen);
15865124feed88 Phillip Potter  2021-07-28  5445  		BA_para_set = le16_to_cpu(pmlmeinfo->ADDBA_req.BA_para_set) & 0x3f;
15865124feed88 Phillip Potter  2021-07-28  5446  		BA_para_set |= 0x1000; /* 64 buffer size */
15865124feed88 Phillip Potter  2021-07-28  5447  
15865124feed88 Phillip Potter  2021-07-28  5448  		if (pregpriv->ampdu_amsdu == 0)/* disabled */
15865124feed88 Phillip Potter  2021-07-28  5449  			BA_para_set = BA_para_set & ~BIT(0);
15865124feed88 Phillip Potter  2021-07-28  5450  		else if (pregpriv->ampdu_amsdu == 1)/* enabled */
15865124feed88 Phillip Potter  2021-07-28  5451  			BA_para_set = BA_para_set | BIT(0);
15865124feed88 Phillip Potter  2021-07-28  5452  		le_tmp = cpu_to_le16(BA_para_set);
15865124feed88 Phillip Potter  2021-07-28  5453  
3b522a11b50476 Michael Straube 2021-08-09  5454  		pframe = rtw_set_fixed_ie(pframe, 2, (unsigned char *)&le_tmp, &pattrib->pktlen);
3b522a11b50476 Michael Straube 2021-08-09  5455  		pframe = rtw_set_fixed_ie(pframe, 2, (unsigned char *)&pmlmeinfo->ADDBA_req.BA_timeout_value, &pattrib->pktlen);
15865124feed88 Phillip Potter  2021-07-28  5456  		break;
84aee42a485b38 Martin Kaiser   2022-05-21  5457  	case WLAN_ACTION_DELBA:
15865124feed88 Phillip Potter  2021-07-28  5458  		BA_para_set = (status & 0x1F) << 3;
15865124feed88 Phillip Potter  2021-07-28  5459  		le_tmp = cpu_to_le16(BA_para_set);
3b522a11b50476 Michael Straube 2021-08-09  5460  		pframe = rtw_set_fixed_ie(pframe, 2, (unsigned char *)&le_tmp, &pattrib->pktlen);
15865124feed88 Phillip Potter  2021-07-28  5461  
15865124feed88 Phillip Potter  2021-07-28  5462  		reason_code = 37;/* Requested from peer STA as it does not want to use the mechanism */
15865124feed88 Phillip Potter  2021-07-28  5463  		le_tmp = cpu_to_le16(reason_code);
3b522a11b50476 Michael Straube 2021-08-09  5464  		pframe = rtw_set_fixed_ie(pframe, 2, (unsigned char *)&le_tmp, &pattrib->pktlen);
15865124feed88 Phillip Potter  2021-07-28  5465  		break;
15865124feed88 Phillip Potter  2021-07-28  5466  	default:
15865124feed88 Phillip Potter  2021-07-28  5467  		break;
15865124feed88 Phillip Potter  2021-07-28  5468  	}
15865124feed88 Phillip Potter  2021-07-28  5469  
15865124feed88 Phillip Potter  2021-07-28  5470  	pattrib->last_txcmdsz = pattrib->pktlen;
15865124feed88 Phillip Potter  2021-07-28  5471  
15865124feed88 Phillip Potter  2021-07-28  5472  	dump_mgntframe(padapter, pmgntframe);
15865124feed88 Phillip Potter  2021-07-28  5473  }
15865124feed88 Phillip Potter  2021-07-28  5474  

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
