Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EE5648AEA4
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 14:42:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240714AbiAKNmE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 08:42:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240723AbiAKNmC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 08:42:02 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C6B4C06173F
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 05:42:01 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 62F71B818B8
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 13:42:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3ED65C36AE3;
        Tue, 11 Jan 2022 13:41:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641908518;
        bh=1CtuOB0vDk0i5VHaDx1yRgLANkCIdPjX042q41eAXJU=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=W/kCUMC3sIYbHXtH5vF9eGXWbOdx+oYA9qVDhDC6WfXagQ9p1AxtRDcdFqdGUv7ml
         pgUUgSuVqqBoZkWYOo6qtOSQLrlpH/0hXX8j0H56mVB0kJjvz4JUzqxRij9bLosJyN
         VbD/Jy209OHtU6JaVCwQDf2h090OmqFhmAA4lmON720kLf18eBhUUqYCL6gBd6ZyIm
         lu6Jr8kWEImbeo/gB0Yn21/cKouOW3+BX2kn4k/YH3EbWY8kPvTjE21Qeiz68nCIiJ
         xshdyoiJQhhQ7zis/5JFQ4/GXNx1JemvD+4IYB4Ae0uUbS8WWqIv1MsE9rI9fHIhiQ
         tMfo/bhQ1PqcA==
From:   Kalle Valo <kvalo@kernel.org>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     kbuild@lists.01.org, Wen Gong <quic_wgong@quicinc.com>,
        lkp@intel.com, kbuild-all@lists.01.org, ath11k@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [kvalo-ath:pending 8/17] drivers/net/wireless/ath/ath11k/dp_tx.c:511 ath11k_dp_tx_update_txcompl() error: uninitialized symbol 'rate_idx'.
References: <202112230637.BasxPV7i-lkp@intel.com>
Date:   Tue, 11 Jan 2022 15:41:55 +0200
In-Reply-To: <202112230637.BasxPV7i-lkp@intel.com> (Dan Carpenter's message of
        "Wed, 5 Jan 2022 17:49:29 +0300")
Message-ID: <878rvmv17g.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(Moving from ath10k to ath11k list)

Dan Carpenter <dan.carpenter@oracle.com> writes:

> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git pending
> head:   c9a516b946c4b3ce25d422890ca78d0ca730b065
> commit: 1b8bb94c0612cf32e418e90ae93cf37214d84669 [8/17] ath11k: report
> tx bitrate for iw wlan station dump
> config: microblaze-randconfig-m031-20211222
> (https://download.01.org/0day-ci/archive/20211223/202112230637.BasxPV7i-lkp@intel.com/config)
> compiler: microblaze-linux-gcc (GCC) 11.2.0

This was also a test commit in the pending branch, the actual commit is:

1b8bb94c0612 ath11k: report tx bitrate for iw wlan station dump

> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
>
> smatch warnings:
> drivers/net/wireless/ath/ath11k/dp_tx.c:511
> ath11k_dp_tx_update_txcompl() error: uninitialized symbol 'rate_idx'.
>
> vim +/rate_idx +511 drivers/net/wireless/ath/ath11k/dp_tx.c
>
> 1b8bb94c0612cf Wen Gong 2021-12-20 418 void
> ath11k_dp_tx_update_txcompl(struct ath11k *ar, struct hal_tx_status
> *ts)
> 1b8bb94c0612cf Wen Gong   2021-12-20  419  {
> 1b8bb94c0612cf Wen Gong   2021-12-20  420  	struct ath11k_base *ab = ar->ab;
> 1b8bb94c0612cf Wen Gong 2021-12-20 421 struct ath11k_per_peer_tx_stats
> *peer_stats = &ar->cached_stats;
> 1b8bb94c0612cf Wen Gong 2021-12-20 422 enum hal_tx_rate_stats_pkt_type
> pkt_type;
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
> 1b8bb94c0612cf Wen Gong 2021-12-20 433 peer =
> ath11k_peer_find_by_id(ab, ts->peer_id);
> 1b8bb94c0612cf Wen Gong   2021-12-20  434  	if (!peer || !peer->sta) {
> 1b8bb94c0612cf Wen Gong 2021-12-20 435 ath11k_dbg(ab,
> ATH11K_DBG_DP_TX,
> 1b8bb94c0612cf Wen Gong 2021-12-20 436 "failed to find the peer by id
> %u\n", ts->peer_id);
> 1b8bb94c0612cf Wen Gong   2021-12-20  437  		goto err_out;
> 1b8bb94c0612cf Wen Gong   2021-12-20  438  	}
> 1b8bb94c0612cf Wen Gong   2021-12-20  439  
> 1b8bb94c0612cf Wen Gong   2021-12-20  440  	sta = peer->sta;
> 1b8bb94c0612cf Wen Gong 2021-12-20 441 arsta = (struct ath11k_sta
> *)sta->drv_priv;
> 1b8bb94c0612cf Wen Gong   2021-12-20  442  
> 1b8bb94c0612cf Wen Gong 2021-12-20 443 memset(&arsta->txrate, 0,
> sizeof(arsta->txrate));
> 1b8bb94c0612cf Wen Gong 2021-12-20 444 pkt_type =
> FIELD_GET(HAL_TX_RATE_STATS_INFO0_PKT_TYPE,
> 1b8bb94c0612cf Wen Gong   2021-12-20  445  			     ts->rate_stats);
> 1b8bb94c0612cf Wen Gong 2021-12-20 446 mcs =
> FIELD_GET(HAL_TX_RATE_STATS_INFO0_MCS,
> 1b8bb94c0612cf Wen Gong   2021-12-20  447  			ts->rate_stats);
> 1b8bb94c0612cf Wen Gong 2021-12-20 448 sgi =
> FIELD_GET(HAL_TX_RATE_STATS_INFO0_SGI,
> 1b8bb94c0612cf Wen Gong   2021-12-20  449  			ts->rate_stats);
> 1b8bb94c0612cf Wen Gong 2021-12-20 450 bw =
> FIELD_GET(HAL_TX_RATE_STATS_INFO0_BW, ts->rate_stats);
> 1b8bb94c0612cf Wen Gong 2021-12-20 451 ru_tones =
> FIELD_GET(HAL_TX_RATE_STATS_INFO0_TONES_IN_RU, ts->rate_stats);
> 1b8bb94c0612cf Wen Gong 2021-12-20 452 ofdma =
> FIELD_GET(HAL_TX_RATE_STATS_INFO0_OFDMA_TX, ts->rate_stats);
> 1b8bb94c0612cf Wen Gong   2021-12-20  453  
> 1b8bb94c0612cf Wen Gong 2021-12-20 454 /* This is to prefer choose the
> real NSS value arsta->last_txrate.nss,
> 1b8bb94c0612cf Wen Gong 2021-12-20 455 * if it is invalid, then choose
> the NSS value while assoc.
> 1b8bb94c0612cf Wen Gong   2021-12-20  456  	 */
> 1b8bb94c0612cf Wen Gong   2021-12-20  457  	if (arsta->last_txrate.nss)
> 1b8bb94c0612cf Wen Gong 2021-12-20 458 arsta->txrate.nss =
> arsta->last_txrate.nss;
> 1b8bb94c0612cf Wen Gong   2021-12-20  459  	else
> 1b8bb94c0612cf Wen Gong 2021-12-20 460 arsta->txrate.nss =
> arsta->peer_nss;
> 1b8bb94c0612cf Wen Gong   2021-12-20  461  
> 1b8bb94c0612cf Wen Gong 2021-12-20 462 if (pkt_type ==
> HAL_TX_RATE_STATS_PKT_TYPE_11A ||
> 1b8bb94c0612cf Wen Gong 2021-12-20 463 pkt_type ==
> HAL_TX_RATE_STATS_PKT_TYPE_11B) {
> 1b8bb94c0612cf Wen Gong 2021-12-20 464 ret =
> ath11k_mac_hw_ratecode_to_legacy_rate(mcs,
> 1b8bb94c0612cf Wen Gong 2021-12-20 465 pkt_type,
> 1b8bb94c0612cf Wen Gong 2021-12-20 466 &rate_idx,
> 1b8bb94c0612cf Wen Gong 2021-12-20 467 &rate);
> 1b8bb94c0612cf Wen Gong   2021-12-20  468  		if (ret < 0)
> 1b8bb94c0612cf Wen Gong   2021-12-20  469  			goto err_out;
>
> "rate_idx" not initialized on other paths.

Wen, can you please send a patch fixing this?

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
