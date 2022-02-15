Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 886B04B786B
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 21:52:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243738AbiBOTiG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 14:38:06 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243701AbiBOTiC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 14:38:02 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8FDE6301;
        Tue, 15 Feb 2022 11:37:52 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 689681F37B;
        Tue, 15 Feb 2022 19:37:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1644953871; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type;
        bh=y/qjbYgEthADxutskRuqAtoMhMng2hMp57R8uqULpbI=;
        b=ASyO1UJjvhoTT+rCCbegiy15Ea1VTCtrW/bQtoFRPi3Q2U+ITKr8trHSNwPWBboHHteXqT
        a/iGSNF0t1j9oa7SGopd9pbF769jdwF8XMnelHwVn1uhqsxmylxF1Ar/9NFRZxY8aPgl3L
        zhRrFp5ZR1gij2vpnrnZvHBmIg/Rxsw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1644953871;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type;
        bh=y/qjbYgEthADxutskRuqAtoMhMng2hMp57R8uqULpbI=;
        b=8VBe4UE97RJoV6pOXqj2B+/+iadiJN7I9EWaXD9IxjEjucDV5ZDlCXXweL/lqTykpq7tYU
        y1i7FLnlNoDrG6Cg==
Received: from pobox.suse.cz (pobox.suse.cz [10.100.2.14])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 1CC26A3B8B;
        Tue, 15 Feb 2022 19:37:51 +0000 (UTC)
Date:   Tue, 15 Feb 2022 20:37:51 +0100 (CET)
From:   Jiri Kosina <jkosina@suse.cz>
To:     Kalle Valo <kvalo@kernel.org>
cc:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ping-Ke Shih <pkshih@realtek.com>
Subject: [PATCH] rtw89: fix RCU usage in rtw89_core_txq_push()
Message-ID: <nycvar.YFH.7.76.2202152037000.11721@cbobk.fhfr.pm>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Kosina <jkosina@suse.cz>
Subject: [PATCH] rtw89: fix RCU usage in rtw89_core_txq_push()

ieee80211_tx_h_select_key() is performing a series of RCU dereferences,
but rtw89_core_txq_push() is calling it (via ieee80211_tx_dequeue_ni())
without RCU read-side lock held; fix that.

This addresses the splat below.

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

Signed-off-by: Jiri Kosina <jkosina@suse.cz>
---
 drivers/net/wireless/realtek/rtw89/core.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index a0737eea9f81..9632e7f218dd 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -1509,11 +1509,12 @@ static void rtw89_core_txq_push(struct rtw89_dev *rtwdev,
 	unsigned long i;
 	int ret;
 
+	rcu_read_lock();
 	for (i = 0; i < frame_cnt; i++) {
 		skb = ieee80211_tx_dequeue_ni(rtwdev->hw, txq);
 		if (!skb) {
 			rtw89_debug(rtwdev, RTW89_DBG_TXRX, "dequeue a NULL skb\n");
-			return;
+			goto out;
 		}
 		rtw89_core_txq_check_agg(rtwdev, rtwtxq, skb);
 		ret = rtw89_core_tx_write(rtwdev, vif, sta, skb, NULL);
@@ -1523,6 +1524,8 @@ static void rtw89_core_txq_push(struct rtw89_dev *rtwdev,
 			break;
 		}
 	}
+out:
+	rcu_read_unlock();
 }
 
 static u32 rtw89_check_and_reclaim_tx_resource(struct rtw89_dev *rtwdev, u8 tid)

-- 
Jiri Kosina
SUSE Labs


