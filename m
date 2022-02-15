Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 937D74B7177
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 17:40:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241442AbiBOQLt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 11:11:49 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241623AbiBOQL2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 11:11:28 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2D6C9AD96;
        Tue, 15 Feb 2022 08:11:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 18207B81B3D;
        Tue, 15 Feb 2022 16:11:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1570C340F0;
        Tue, 15 Feb 2022 16:11:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644941474;
        bh=i5obIJ0DwCv/AaBdy0yjZuQs07k8fQqBuIkOGBE3DVA=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=I175An+sZ3Inl+RRsYN8U/CYYst114L6OrhxbcoSFmG06RAZh3Pw3c0590AKVpLUG
         9FRaO1232fmttrW8JAnBnTm95boSVwCgY0ivuExL2nqd84GCgawIcq3U8xI0F2/4j2
         z3su7G+u5EUirn/1mf2CWVZHmryEILU6jR8GOGtWVDpCxtplfgkI+p7pYLIVMhiZWb
         ZLAbh7dR63vkp+q8EgQ0GmpsEr6bYsa02rp7lOEGObAJ5kP2B3za2WAdzWID3mCFkg
         V7RnrMPpF3rPdvbO6OWOAO0C+8ifpWcoB9Vsjn1xlCmADOy4p9b3rze87XKT3SKHHb
         7BbN4m2XwiDVQ==
Date:   Tue, 15 Feb 2022 17:11:11 +0100 (CET)
From:   Jiri Kosina <jikos@kernel.org>
To:     Johannes Berg <johannes@sipsolutions.net>
cc:     linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ping-Ke Shih <pkshih@realtek.com>
Subject: [PATCH] rtw89: fix RCU usage in rtw89_core_txq_push() (was Re:
 [PATCH] mac80211: fix RCU usage in ieee80211_tx_h_select_key())
In-Reply-To: <af6abf72593074c007fe42205e941dabfd08bf3a.camel@sipsolutions.net>
Message-ID: <nycvar.YFH.7.76.2202151700540.11721@cbobk.fhfr.pm>
References: <nycvar.YFH.7.76.2202151643220.11721@cbobk.fhfr.pm> <af6abf72593074c007fe42205e941dabfd08bf3a.camel@sipsolutions.net>
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

On Tue, 15 Feb 2022, Johannes Berg wrote:

> > 
> > ieee80211_tx_h_select_key() is performing a series of RCU dereferences, 
> > but none of the callers seems to be taking RCU read-side lock; let's 
> > acquire the lock in ieee80211_tx_h_select_key() itself.
> > 
> but but ...
> 
> >   ieee80211_tx_dequeue+0x1a7/0x1260 [mac80211 911c23e2351c0ae60b597a67b1204a5ea955e365]
> >   rtw89_core_txq_work+0x1a6/0x420 [rtw89_core b39ba493f2e517ad75e0f8187ecc24edf58bbbea]
> 
> /**
>  * ieee80211_tx_dequeue - dequeue a packet from a software tx queue
>  *
>  * @hw: pointer as obtained from ieee80211_alloc_hw()
>  * @txq: pointer obtained from station or virtual interface, or from
>  *      ieee80211_next_txq()
>  *
>  * Returns the skb if successful, %NULL if no frame was available.
>  *
>  * Note that this must be called in an rcu_read_lock() critical section,
>  * which can only be released after the SKB was handled. Some pointers in
> [...]
> 
> -> driver bug?

Right you are, thanks.

CCing Ping-Ke Shih; find updated fix below.




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

