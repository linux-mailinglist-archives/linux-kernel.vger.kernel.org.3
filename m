Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BF1F4B720F
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 17:41:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241086AbiBOPsT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 10:48:19 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241082AbiBOPsI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 10:48:08 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FAE4AFF6D;
        Tue, 15 Feb 2022 07:47:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E252161733;
        Tue, 15 Feb 2022 15:47:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D834C340EB;
        Tue, 15 Feb 2022 15:47:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644940023;
        bh=CiYsFsleEmFiP9wgHpNttT8nePiRXeGuXEYD/WN097I=;
        h=Date:From:To:cc:Subject:From;
        b=rdmwSsW7TUPA0WcHuIfaCz4QVPEPcvdzXEgHJeLuWsNah5e/RDEfA38ZbkSWxPPzz
         QXPjhlB6IyMJw8vIK/LW/KAoTXmBOKuGBzNotBIATNFBqYncXnpoNB5Jy3B1rfzWca
         Hz4LDdC6Rs6O0rglZd04Yb9pKOshQL0iaf7cFh6zISP5WDLOW7APySdZLZWAt59PPI
         t1bj/hxIind2cKx2WKZN03RC9O4/BztMiXWZ+4tzk4sWY9KyXzeN9Mj0xqBLylccTd
         4x3x2bCsAuHXxRGg2C8Bl2Jl/sx7711lX6x6PhR5gQeuqn02+iAOTVlfwrRO/dp3Zg
         WkWxtIZM0l19w==
Date:   Tue, 15 Feb 2022 16:47:00 +0100 (CET)
From:   Jiri Kosina <jikos@kernel.org>
To:     Johannes Berg <johannes@sipsolutions.net>
cc:     linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] mac80211: fix RCU usage in ieee80211_tx_h_select_key()
Message-ID: <nycvar.YFH.7.76.2202151643220.11721@cbobk.fhfr.pm>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Kosina <jkosina@suse.cz>

ieee80211_tx_h_select_key() is performing a series of RCU dereferences, 
but none of the callers seems to be taking RCU read-side lock; let's 
acquire the lock in ieee80211_tx_h_select_key() itself.

Spotted with rtw89 driver.

This fixes the splat below.

 =============================
 WARNING: suspicious RCU usage
 5.17.0-rc4-00003-gccad664b7f14 #3 Tainted: G            E
 -----------------------------
 net/mac80211/tx.c:593 suspicious rcu_dereference_check() usage!

 other info that might help us debug this:

 rcu_scheduler_active = 2, debug_locks = 1
 2 locks held by kworker/u33:0/184:
  #0: ffff9c0b14811d38 ((wq_completion)rtw89_tx_wq){+.+.}-{0:0}, at: process_one_work+0x258/0x660
  #1: ffffb97380cf3e78 ((work_completion)(&rtwdev->txq_work)){+.+.}-{0:0}, at: process_one_work+0x258/0x660

 stack backtrace:
 CPU: 8 PID: 184 Comm: kworker/u33:0 Tainted: G            E     5.17.0-rc4-00003-gccad664b7f14 #3 473b49ab0e7c2d6af2900c756bfd04efd7a9de13
 Hardware name: LENOVO 20UJS2B905/20UJS2B905, BIOS R1CET63W(1.32 ) 04/09/2021
 Workqueue: rtw89_tx_wq rtw89_core_txq_work [rtw89_core]
 Call Trace:
  <TASK>
  dump_stack_lvl+0x58/0x71
  ieee80211_tx_h_select_key+0x2c0/0x530 [mac80211 911c23e2351c0ae60b597a67b1204a5ea955e365]
  ieee80211_tx_dequeue+0x1a7/0x1260 [mac80211 911c23e2351c0ae60b597a67b1204a5ea955e365]
  rtw89_core_txq_work+0x1a6/0x420 [rtw89_core b39ba493f2e517ad75e0f8187ecc24edf58bbbea]
  process_one_work+0x2d8/0x660
  worker_thread+0x39/0x3e0
  ? process_one_work+0x660/0x660
  kthread+0xe5/0x110
  ? kthread_complete_and_exit+0x20/0x20
  ret_from_fork+0x22/0x30
  </TASK>

 =============================
 WARNING: suspicious RCU usage
 5.17.0-rc4-00003-gccad664b7f14 #3 Tainted: G            E
 -----------------------------
 net/mac80211/tx.c:607 suspicious rcu_dereference_check() usage!

 other info that might help us debug this:

 rcu_scheduler_active = 2, debug_locks = 1
 2 locks held by kworker/u33:0/184:
  #0: ffff9c0b14811d38 ((wq_completion)rtw89_tx_wq){+.+.}-{0:0}, at: process_one_work+0x258/0x660
  #1: ffffb97380cf3e78 ((work_completion)(&rtwdev->txq_work)){+.+.}-{0:0}, at: process_one_work+0x258/0x660

 stack backtrace:
 CPU: 8 PID: 184 Comm: kworker/u33:0 Tainted: G            E     5.17.0-rc4-00003-gccad664b7f14 #3 473b49ab0e7c2d6af2900c756bfd04efd7a9de13
 Hardware name: LENOVO 20UJS2B905/20UJS2B905, BIOS R1CET63W(1.32 ) 04/09/2021
 Workqueue: rtw89_tx_wq rtw89_core_txq_work [rtw89_core]
 Call Trace:
  <TASK>
  dump_stack_lvl+0x58/0x71
  ieee80211_tx_h_select_key+0x464/0x530 [mac80211 911c23e2351c0ae60b597a67b1204a5ea955e365]
  ieee80211_tx_dequeue+0x1a7/0x1260 [mac80211 911c23e2351c0ae60b597a67b1204a5ea955e365]
  rtw89_core_txq_work+0x1a6/0x420 [rtw89_core b39ba493f2e517ad75e0f8187ecc24edf58bbbea]
  process_one_work+0x2d8/0x660
  worker_thread+0x39/0x3e0
  ? process_one_work+0x660/0x660
  kthread+0xe5/0x110
  ? kthread_complete_and_exit+0x20/0x20
  ret_from_fork+0x22/0x30
  </TASK>

Fixes: a0761a301746e ("mac80211: drop data frames without key on encrypted links")
Fixes: 46f6b06050b73 ("mac80211: Encrypt "Group addressed privacy" action frames")
Fixes: 3cfcf6ac6d69d ("mac80211: 802.11w - Use BIP (AES-128-CMAC)")
Fixes: f7e0104c1a4e7 ("mac80211: support separate default keys")
Signed-off-by: Jiri Kosina <jkosina@suse.cz>
---

Unless I am missing something, this seems to have been buggy for over a 
decade ... ?

 net/mac80211/tx.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index 6d054fed062f..50b33ef70627 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -580,6 +580,7 @@ ieee80211_tx_h_check_control_port_protocol(struct ieee80211_tx_data *tx)
 static ieee80211_tx_result debug_noinline
 ieee80211_tx_h_select_key(struct ieee80211_tx_data *tx)
 {
+	int ret;
 	struct ieee80211_key *key;
 	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(tx->skb);
 	struct ieee80211_hdr *hdr = (struct ieee80211_hdr *)tx->skb->data;
@@ -589,6 +590,8 @@ ieee80211_tx_h_select_key(struct ieee80211_tx_data *tx)
 		return TX_CONTINUE;
 	}
 
+	rcu_read_lock();
+
 	if (tx->sta &&
 	    (key = rcu_dereference(tx->sta->ptk[tx->sta->ptk_idx])))
 		tx->key = key;
@@ -645,18 +648,23 @@ ieee80211_tx_h_select_key(struct ieee80211_tx_data *tx)
 		}
 
 		if (unlikely(tx->key && tx->key->flags & KEY_FLAG_TAINTED &&
-			     !ieee80211_is_deauth(hdr->frame_control)))
-			return TX_DROP;
+			     !ieee80211_is_deauth(hdr->frame_control))) {
+			ret = TX_DROP;
+			goto out;
+		}
 
 		if (!skip_hw && tx->key &&
 		    tx->key->flags & KEY_FLAG_UPLOADED_TO_HARDWARE)
 			info->control.hw_key = &tx->key->conf;
 	} else if (ieee80211_is_data_present(hdr->frame_control) && tx->sta &&
 		   test_sta_flag(tx->sta, WLAN_STA_USES_ENCRYPTION)) {
-		return TX_DROP;
+		ret = TX_DROP;
+		goto out;
 	}
-
-	return TX_CONTINUE;
+	ret = TX_CONTINUE;
+out:
+	rcu_read_unlock();
+	return ret;
 }
 
 static ieee80211_tx_result debug_noinline

-- 
Jiri Kosina
SUSE Labs

