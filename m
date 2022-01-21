Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6332C495E78
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 12:40:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350109AbiAULkb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 06:40:31 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:52862 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230234AbiAULka (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 06:40:30 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 332651F888;
        Fri, 21 Jan 2022 11:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1642765229; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=p1in7D2MoPPm603YyrrTr2s6zVMfG0P250uqSYygmeI=;
        b=h5S0Jr6FZwY202+6mTdu9nNbF+F26Jl2zNoQmfahKHaPL88xWfJd9P7RsicQXk8sfM+CVC
        k3EBvIUVrExSjqmvYCvhdXzPY0a0dcwvepPCjkztMWP0JwWQMnBXHEvJXir+asDOovxKPa
        PfsZwKNUsl6pBIi8x83ZYGCAcZtUcpU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1642765229;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=p1in7D2MoPPm603YyrrTr2s6zVMfG0P250uqSYygmeI=;
        b=IOtP3Dt8foBoh38dhybtf3hNkVwT5gsFuSCgeSs2nfKxj6LlDx8rohZRW8FgmpKMn70JRy
        6S6nKX+lfZ6XP2Dw==
Received: from alsa1.nue.suse.com (alsa1.suse.de [10.160.4.42])
        by relay2.suse.de (Postfix) with ESMTP id 29FB5A3B83;
        Fri, 21 Jan 2022 11:40:29 +0000 (UTC)
From:   Takashi Iwai <tiwai@suse.de>
To:     Luca Coelho <luciano.coelho@intel.com>
Cc:     Johannes Berg <johannes.berg@intel.com>,
        Oliver Neukum <oneukum@suse.de>,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] iwlwifi: mvm: Don't call iwl_mvm_sta_from_mac80211() with NULL sta
Date:   Fri, 21 Jan 2022 12:40:24 +0100
Message-Id: <20220121114024.10454-1-tiwai@suse.de>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The recent fix for NULL sta in iwl_mvm_get_tx_rate() still has a call
of iwl_mvm_sta_from_mac80211() that may be called with NULL sta.
Although this practically only points to the address and the actual
access doesn't happen due to the conditional evaluation at a later
point, it looks a bit flaky.

This patch drops the temporary variable above and evaluates
iwm_mvm_sta_from_mac80211() directly for avoiding confusions.

Fixes: d599f714b73e ("iwlwifi: mvm: don't crash on invalid rate w/o STA")
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---

Corrected the subject and the description from
  https://lore.kernel.org/r/20220121111418.9144-1-tiwai@suse.de

 drivers/net/wireless/intel/iwlwifi/mvm/tx.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/tx.c b/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
index 6fa2c12f7955..4d1ddca73fb0 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
@@ -318,15 +318,14 @@ static u32 iwl_mvm_get_tx_rate(struct iwl_mvm *mvm,
 
 	/* info->control is only relevant for non HW rate control */
 	if (!ieee80211_hw_check(mvm->hw, HAS_RATE_CONTROL)) {
-		struct iwl_mvm_sta *mvmsta = iwl_mvm_sta_from_mac80211(sta);
-
 		/* HT rate doesn't make sense for a non data frame */
 		WARN_ONCE(info->control.rates[0].flags & IEEE80211_TX_RC_MCS &&
 			  !ieee80211_is_data(fc),
 			  "Got a HT rate (flags:0x%x/mcs:%d/fc:0x%x/state:%d) for a non data frame\n",
 			  info->control.rates[0].flags,
 			  info->control.rates[0].idx,
-			  le16_to_cpu(fc), sta ? mvmsta->sta_state : -1);
+			  le16_to_cpu(fc),
+			  sta ? iwl_mvm_sta_from_mac80211(sta)->sta_state : -1);
 
 		rate_idx = info->control.rates[0].idx;
 	}
-- 
2.31.1

