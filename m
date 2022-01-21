Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2AA7495E3E
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 12:14:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350058AbiAULO2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 06:14:28 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:50448 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231467AbiAULO0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 06:14:26 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id A4A051F888;
        Fri, 21 Jan 2022 11:14:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1642763665; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=huXZBaaoOclQBKGYH9qhA4+r2hqJ985w7l3q+2AarV4=;
        b=pooZty+tY45RueosEtn5jjsTq1uLipDDrZUaHFLS5jjCwkKcs5Q2lojB2bkHSyx7DIsfey
        4wUa1oBT7FMWUe5DdyUTcz4P6CJIh2OiZTpROYXN7NnIuW/aCxphQ4e46quZ52X4irMkCO
        8WJUCctiIktWMWOnTSNuUa1T9ARoOIU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1642763665;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=huXZBaaoOclQBKGYH9qhA4+r2hqJ985w7l3q+2AarV4=;
        b=ud8bBkRgIfECxejjjkPb6a4YsnezrDUynm7rKdz29LloIU7PXVIHyYKQXCHvfkWv2h94nR
        3hpDG8oR7QI0HvBg==
Received: from alsa1.nue.suse.com (alsa1.suse.de [10.160.4.42])
        by relay2.suse.de (Postfix) with ESMTP id 9ADF0A3B88;
        Fri, 21 Jan 2022 11:14:25 +0000 (UTC)
From:   Takashi Iwai <tiwai@suse.de>
To:     Luca Coelho <luciano.coelho@intel.com>
Cc:     Johannes Berg <johannes.berg@intel.com>,
        Oliver Neukum <oneukum@suse.de>,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] iwlwifi: mvm: Fix potential NULL dereference for sta
Date:   Fri, 21 Jan 2022 12:14:18 +0100
Message-Id: <20220121111418.9144-1-tiwai@suse.de>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The recent fix for NULL sta in iwl_mvm_get_tx_rate() may still hit a
potential NULL dereference, as iwl_mvm_sta_from_mac80211() is called
unconditionally (although this doesn't seem happening, practically
seen, thanks to the compiler optimization).

This patch addresses it by dropping the temporary variable.

Fixes: d599f714b73e ("iwlwifi: mvm: don't crash on invalid rate w/o STA")
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
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

