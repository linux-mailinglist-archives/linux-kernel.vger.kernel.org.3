Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4629E4A00DE
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 20:30:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350946AbiA1TaC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 14:30:02 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:48360 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232590AbiA1T36 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 14:29:58 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8512B61D2F
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 19:29:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7ECF5C340E7;
        Fri, 28 Jan 2022 19:29:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643398198;
        bh=1AbZb7gk4/lKM+5zqRw8TFlZPGMTXr24D/71dUnb9J4=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=tX+2HY4FZurCF35sRXCW64cSpkKnryW1tTdZ6SPc6wasPOsiXxqC2MX7zRltmlmbm
         DrT1TNot20A3QTF6f6hlStvQXEMGCCEE/Y/N2oDblDhr53DKaXgx3NyRLjEPeEsSSg
         x4zhLenicVyz/Z/fXtAsJA6o4wJ2aqjvVU84gBxBS7M9jSr6ukpqOHPXHl5gxE63Wd
         at5UTjK782E+vraxULd2scMksYLzNA0Ej3GZA1EEW71pCJWkGTn7tLY1InK9qaRgOG
         yw5KUbOQ928yf8AEORb2vN5IE/eAvN+EFInGAP6pTnjR7tHsReEExdDiwhRrZwbfit
         vsrBCzeQBF3ZA==
From:   Kalle Valo <kvalo@kernel.org>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     kbuild@lists.01.org, Wen Gong <quic_wgong@quicinc.com>,
        lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, ath11k@lists.infradead.org
Subject: Re: drivers/net/wireless/ath/ath11k/dp_tx.c:511 ath11k_dp_tx_update_txcompl() error: uninitialized symbol 'rate_idx'.
References: <202201272110.Z8STyrTC-lkp@intel.com>
Date:   Fri, 28 Jan 2022 21:29:52 +0200
In-Reply-To: <202201272110.Z8STyrTC-lkp@intel.com> (Dan Carpenter's message of
        "Fri, 28 Jan 2022 10:12:36 +0300")
Message-ID: <87ilu3d5fz.fsf@tynnyri.adurom.net>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ ath11k list

Dan Carpenter <dan.carpenter@oracle.com> writes:

> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   0280e3c58f92b2fe0e8fbbdf8d386449168de4a8
> commit: 1b8bb94c0612cf32e418e90ae93cf37214d84669 ath11k: report tx bitrate for iw wlan station dump
> config: microblaze-randconfig-m031-20220127 (https://download.01.org/0day-ci/archive/20220127/202201272110.Z8STyrTC-lkp@intel.com/config)
> compiler: microblaze-linux-gcc (GCC) 11.2.0
>
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
>
> smatch warnings:
> drivers/net/wireless/ath/ath11k/dp_tx.c:511 ath11k_dp_tx_update_txcompl() error: uninitialized symbol 'rate_idx'.
>
> vim +/rate_idx +511 drivers/net/wireless/ath/ath11k/dp_tx.c
>
> 1b8bb94c0612cf Wen Gong   2021-12-20  418  void ath11k_dp_tx_update_txcompl(struct ath11k *ar, struct hal_tx_status *ts)
> 1b8bb94c0612cf Wen Gong   2021-12-20  419  {
> 1b8bb94c0612cf Wen Gong   2021-12-20  420  	struct ath11k_base *ab = ar->ab;
> 1b8bb94c0612cf Wen Gong   2021-12-20  421  	struct ath11k_per_peer_tx_stats *peer_stats = &ar->cached_stats;
> 1b8bb94c0612cf Wen Gong   2021-12-20  422  	enum hal_tx_rate_stats_pkt_type pkt_type;
> 1b8bb94c0612cf Wen Gong   2021-12-20  423  	enum hal_tx_rate_stats_sgi sgi;
> 1b8bb94c0612cf Wen Gong   2021-12-20  424  	enum hal_tx_rate_stats_bw bw;
> 1b8bb94c0612cf Wen Gong   2021-12-20  425  	struct ath11k_peer *peer;
> 1b8bb94c0612cf Wen Gong   2021-12-20  426  	struct ath11k_sta *arsta;
> 1b8bb94c0612cf Wen Gong   2021-12-20  427  	struct ieee80211_sta *sta;
> 1b8bb94c0612cf Wen Gong   2021-12-20  428  	u16 rate, ru_tones;
> 1b8bb94c0612cf Wen Gong   2021-12-20  429  	u8 mcs, rate_idx, ofdma;
> 1b8bb94c0612cf Wen Gong   2021-12-20  430  	int ret;
> 1b8bb94c0612cf Wen Gong   2021-12-20  431  
> 1b8bb94c0612cf Wen Gong   2021-12-20  432  	spin_lock_bh(&ab->base_lock);
> 1b8bb94c0612cf Wen Gong   2021-12-20  433  	peer = ath11k_peer_find_by_id(ab, ts->peer_id);
> 1b8bb94c0612cf Wen Gong   2021-12-20  434  	if (!peer || !peer->sta) {
> 1b8bb94c0612cf Wen Gong   2021-12-20  435  		ath11k_dbg(ab, ATH11K_DBG_DP_TX,
> 1b8bb94c0612cf Wen Gong   2021-12-20  436  			   "failed to find the peer by id %u\n", ts->peer_id);
> 1b8bb94c0612cf Wen Gong   2021-12-20  437  		goto err_out;
> 1b8bb94c0612cf Wen Gong   2021-12-20  438  	}
> 1b8bb94c0612cf Wen Gong   2021-12-20  439  
> 1b8bb94c0612cf Wen Gong   2021-12-20  440  	sta = peer->sta;
> 1b8bb94c0612cf Wen Gong   2021-12-20  441  	arsta = (struct ath11k_sta *)sta->drv_priv;
> 1b8bb94c0612cf Wen Gong   2021-12-20  442  
> 1b8bb94c0612cf Wen Gong   2021-12-20  443  	memset(&arsta->txrate, 0, sizeof(arsta->txrate));
> 1b8bb94c0612cf Wen Gong   2021-12-20  444  	pkt_type = FIELD_GET(HAL_TX_RATE_STATS_INFO0_PKT_TYPE,
> 1b8bb94c0612cf Wen Gong   2021-12-20  445  			     ts->rate_stats);
> 1b8bb94c0612cf Wen Gong   2021-12-20  446  	mcs = FIELD_GET(HAL_TX_RATE_STATS_INFO0_MCS,
> 1b8bb94c0612cf Wen Gong   2021-12-20  447  			ts->rate_stats);
> 1b8bb94c0612cf Wen Gong   2021-12-20  448  	sgi = FIELD_GET(HAL_TX_RATE_STATS_INFO0_SGI,
> 1b8bb94c0612cf Wen Gong   2021-12-20  449  			ts->rate_stats);
> 1b8bb94c0612cf Wen Gong   2021-12-20  450  	bw = FIELD_GET(HAL_TX_RATE_STATS_INFO0_BW, ts->rate_stats);
> 1b8bb94c0612cf Wen Gong   2021-12-20  451  	ru_tones = FIELD_GET(HAL_TX_RATE_STATS_INFO0_TONES_IN_RU, ts->rate_stats);
> 1b8bb94c0612cf Wen Gong   2021-12-20  452  	ofdma = FIELD_GET(HAL_TX_RATE_STATS_INFO0_OFDMA_TX, ts->rate_stats);
> 1b8bb94c0612cf Wen Gong   2021-12-20  453  
> 1b8bb94c0612cf Wen Gong   2021-12-20  454  	/* This is to prefer choose the real NSS value arsta->last_txrate.nss,
> 1b8bb94c0612cf Wen Gong   2021-12-20  455  	 * if it is invalid, then choose the NSS value while assoc.
> 1b8bb94c0612cf Wen Gong   2021-12-20  456  	 */
> 1b8bb94c0612cf Wen Gong   2021-12-20  457  	if (arsta->last_txrate.nss)
> 1b8bb94c0612cf Wen Gong   2021-12-20  458  		arsta->txrate.nss = arsta->last_txrate.nss;
> 1b8bb94c0612cf Wen Gong   2021-12-20  459  	else
> 1b8bb94c0612cf Wen Gong   2021-12-20  460  		arsta->txrate.nss = arsta->peer_nss;
> 1b8bb94c0612cf Wen Gong   2021-12-20  461  
> 1b8bb94c0612cf Wen Gong   2021-12-20  462  	if (pkt_type == HAL_TX_RATE_STATS_PKT_TYPE_11A ||
> 1b8bb94c0612cf Wen Gong   2021-12-20  463  	    pkt_type == HAL_TX_RATE_STATS_PKT_TYPE_11B) {
> 1b8bb94c0612cf Wen Gong   2021-12-20  464  		ret = ath11k_mac_hw_ratecode_to_legacy_rate(mcs,
> 1b8bb94c0612cf Wen Gong   2021-12-20  465  							    pkt_type,
> 1b8bb94c0612cf Wen Gong   2021-12-20  466  							    &rate_idx,
> 1b8bb94c0612cf Wen Gong   2021-12-20  467  							    &rate);
> 1b8bb94c0612cf Wen Gong   2021-12-20  468  		if (ret < 0)
> 1b8bb94c0612cf Wen Gong   2021-12-20  469  			goto err_out;
> 1b8bb94c0612cf Wen Gong   2021-12-20  470  		arsta->txrate.legacy = rate;
>
> "rate_idx" only set on this path
>
> 1b8bb94c0612cf Wen Gong   2021-12-20  471  	} else if (pkt_type == HAL_TX_RATE_STATS_PKT_TYPE_11N) {
> 1b8bb94c0612cf Wen Gong   2021-12-20  472  		if (mcs > 7) {
> 1b8bb94c0612cf Wen Gong   2021-12-20  473  			ath11k_warn(ab, "Invalid HT mcs index %d\n", mcs);
> 1b8bb94c0612cf Wen Gong   2021-12-20  474  			goto err_out;
> 1b8bb94c0612cf Wen Gong   2021-12-20  475  		}
> 1b8bb94c0612cf Wen Gong   2021-12-20  476  
> 1b8bb94c0612cf Wen Gong   2021-12-20  477  		if (arsta->txrate.nss != 0)
> 1b8bb94c0612cf Wen Gong   2021-12-20  478  			arsta->txrate.mcs = mcs + 8 * (arsta->txrate.nss - 1);
> 1b8bb94c0612cf Wen Gong   2021-12-20  479  		arsta->txrate.flags = RATE_INFO_FLAGS_MCS;
> 1b8bb94c0612cf Wen Gong   2021-12-20  480  		if (sgi)
> 1b8bb94c0612cf Wen Gong   2021-12-20  481  			arsta->txrate.flags |= RATE_INFO_FLAGS_SHORT_GI;
> 1b8bb94c0612cf Wen Gong   2021-12-20  482  	} else if (pkt_type == HAL_TX_RATE_STATS_PKT_TYPE_11AC) {
> 1b8bb94c0612cf Wen Gong   2021-12-20  483  		if (mcs > 9) {
> 1b8bb94c0612cf Wen Gong   2021-12-20  484  			ath11k_warn(ab, "Invalid VHT mcs index %d\n", mcs);
> 1b8bb94c0612cf Wen Gong   2021-12-20  485  			goto err_out;
> 1b8bb94c0612cf Wen Gong   2021-12-20  486  		}
> 1b8bb94c0612cf Wen Gong   2021-12-20  487  
> 1b8bb94c0612cf Wen Gong   2021-12-20  488  		arsta->txrate.mcs = mcs;
> 1b8bb94c0612cf Wen Gong   2021-12-20  489  		arsta->txrate.flags = RATE_INFO_FLAGS_VHT_MCS;
> 1b8bb94c0612cf Wen Gong   2021-12-20  490  		if (sgi)
> 1b8bb94c0612cf Wen Gong   2021-12-20  491  			arsta->txrate.flags |= RATE_INFO_FLAGS_SHORT_GI;
> 1b8bb94c0612cf Wen Gong   2021-12-20  492  	} else if (pkt_type == HAL_TX_RATE_STATS_PKT_TYPE_11AX) {
> 1b8bb94c0612cf Wen Gong   2021-12-20  493  		if (mcs > 11) {
> 1b8bb94c0612cf Wen Gong   2021-12-20  494  			ath11k_warn(ab, "Invalid HE mcs index %d\n", mcs);
> 1b8bb94c0612cf Wen Gong   2021-12-20  495  			goto err_out;
> 1b8bb94c0612cf Wen Gong   2021-12-20  496  		}
> 1b8bb94c0612cf Wen Gong   2021-12-20  497  
> 1b8bb94c0612cf Wen Gong   2021-12-20  498  		arsta->txrate.mcs = mcs;
> 1b8bb94c0612cf Wen Gong   2021-12-20  499  		arsta->txrate.flags = RATE_INFO_FLAGS_HE_MCS;
> 1b8bb94c0612cf Wen Gong   2021-12-20  500  		arsta->txrate.he_gi = ath11k_mac_he_gi_to_nl80211_he_gi(sgi);
> 1b8bb94c0612cf Wen Gong   2021-12-20  501  	}
> 1b8bb94c0612cf Wen Gong   2021-12-20  502  
> 1b8bb94c0612cf Wen Gong   2021-12-20  503  	arsta->txrate.bw = ath11k_mac_bw_to_mac80211_bw(bw);
> 1b8bb94c0612cf Wen Gong   2021-12-20  504  	if (ofdma && pkt_type == HAL_TX_RATE_STATS_PKT_TYPE_11AX) {
> 1b8bb94c0612cf Wen Gong   2021-12-20  505  		arsta->txrate.bw = RATE_INFO_BW_HE_RU;
> 1b8bb94c0612cf Wen Gong   2021-12-20  506  		arsta->txrate.he_ru_alloc =
> 1b8bb94c0612cf Wen Gong   2021-12-20  507  			ath11k_mac_he_ru_tones_to_nl80211_he_ru_alloc(ru_tones);
> 1b8bb94c0612cf Wen Gong   2021-12-20  508  	}
> 1b8bb94c0612cf Wen Gong   2021-12-20  509  
> 1b8bb94c0612cf Wen Gong   2021-12-20  510  	if (ath11k_debugfs_is_extd_tx_stats_enabled(ar))
> 1b8bb94c0612cf Wen Gong   2021-12-20 @511  		ath11k_debugfs_sta_add_tx_stats(arsta, peer_stats, rate_idx);
>                                                                                                            ^^^^^^^^
> Used here

Wen, please send a fix for this.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
