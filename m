Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57F904B7BF8
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 01:31:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230043AbiBPAay convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 15 Feb 2022 19:30:54 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245186AbiBPAav (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 19:30:51 -0500
X-Greylist: delayed 184 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 15 Feb 2022 16:30:39 PST
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D648F7479
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 16:30:39 -0800 (PST)
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 21G0R7mzC019869, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 21G0R7mzC019869
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 16 Feb 2022 08:27:07 +0800
Received: from RTEXMBS06.realtek.com.tw (172.21.6.99) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Wed, 16 Feb 2022 08:27:07 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Wed, 16 Feb 2022 08:27:06 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::35e4:d9d1:102d:605e]) by
 RTEXMBS04.realtek.com.tw ([fe80::35e4:d9d1:102d:605e%5]) with mapi id
 15.01.2308.020; Wed, 16 Feb 2022 08:27:06 +0800
From:   Pkshih <pkshih@realtek.com>
To:     Jiri Kosina <jkosina@suse.cz>, Kalle Valo <kvalo@kernel.org>
CC:     Johannes Berg <johannes@sipsolutions.net>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] rtw89: fix RCU usage in rtw89_core_txq_push()
Thread-Topic: [PATCH] rtw89: fix RCU usage in rtw89_core_txq_push()
Thread-Index: AQHYIqOb6vwbbBNtV0K4EdeAWNx0VKyVUlUQ
Date:   Wed, 16 Feb 2022 00:27:06 +0000
Message-ID: <58fa5d4b7d794228ad45485ec5b979df@realtek.com>
References: <nycvar.YFH.7.76.2202152037000.11721@cbobk.fhfr.pm>
In-Reply-To: <nycvar.YFH.7.76.2202152037000.11721@cbobk.fhfr.pm>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.69.188]
x-kse-serverinfo: RTEXMBS06.realtek.com.tw, 9
x-kse-attachmentfiltering-interceptor-info: no applicable attachment filtering
 rules found
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: =?us-ascii?Q?Clean,_bases:_2022/2/15_=3F=3F_02:07:00?=
x-kse-bulkmessagesfiltering-scan-result: protection disabled
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> -----Original Message-----
> From: Jiri Kosina <jkosina@suse.cz>
> Sent: Wednesday, February 16, 2022 3:38 AM
> To: Kalle Valo <kvalo@kernel.org>
> Cc: Johannes Berg <johannes@sipsolutions.net>; linux-wireless@vger.kernel.org;
> linux-kernel@vger.kernel.org; Pkshih <pkshih@realtek.com>
> Subject: [PATCH] rtw89: fix RCU usage in rtw89_core_txq_push()
> 
> From: Jiri Kosina <jkosina@suse.cz>
> Subject: [PATCH] rtw89: fix RCU usage in rtw89_core_txq_push()
> 
> ieee80211_tx_h_select_key() is performing a series of RCU dereferences,
> but rtw89_core_txq_push() is calling it (via ieee80211_tx_dequeue_ni())
> without RCU read-side lock held; fix that.
> 
> This addresses the splat below.
> 
>  =============================
>  WARNING: suspicious RCU usage
>  5.17.0-rc4-00003-gccad664b7f14 #3 Tainted: G            E
>  -----------------------------
>  net/mac80211/tx.c:593 suspicious rcu_dereference_check() usage!
> 
>  other info that might help us debug this:
> 
>  rcu_scheduler_active = 2, debug_locks = 1
>  2 locks held by kworker/u33:0/184:
>   #0: ffff9c0b14811d38 ((wq_completion)rtw89_tx_wq){+.+.}-{0:0}, at: process_one_work+0x258/0x660
>   #1: ffffb97380cf3e78 ((work_completion)(&rtwdev->txq_work)){+.+.}-{0:0}, at:
> process_one_work+0x258/0x660
> 
>  stack backtrace:
>  CPU: 8 PID: 184 Comm: kworker/u33:0 Tainted: G            E     5.17.0-rc4-00003-gccad664b7f14 #3
> 473b49ab0e7c2d6af2900c756bfd04efd7a9de13
>  Hardware name: LENOVO 20UJS2B905/20UJS2B905, BIOS R1CET63W(1.32 ) 04/09/2021
>  Workqueue: rtw89_tx_wq rtw89_core_txq_work [rtw89_core]
>  Call Trace:
>   <TASK>
>   dump_stack_lvl+0x58/0x71
>   ieee80211_tx_h_select_key+0x2c0/0x530 [mac80211 911c23e2351c0ae60b597a67b1204a5ea955e365]
>   ieee80211_tx_dequeue+0x1a7/0x1260 [mac80211 911c23e2351c0ae60b597a67b1204a5ea955e365]
>   rtw89_core_txq_work+0x1a6/0x420 [rtw89_core b39ba493f2e517ad75e0f8187ecc24edf58bbbea]
>   process_one_work+0x2d8/0x660
>   worker_thread+0x39/0x3e0
>   ? process_one_work+0x660/0x660
>   kthread+0xe5/0x110
>   ? kthread_complete_and_exit+0x20/0x20
>   ret_from_fork+0x22/0x30
>   </TASK>
> 
>  =============================
>  WARNING: suspicious RCU usage
>  5.17.0-rc4-00003-gccad664b7f14 #3 Tainted: G            E
>  -----------------------------
>  net/mac80211/tx.c:607 suspicious rcu_dereference_check() usage!
> 
>  other info that might help us debug this:
> 
>  rcu_scheduler_active = 2, debug_locks = 1
>  2 locks held by kworker/u33:0/184:
>   #0: ffff9c0b14811d38 ((wq_completion)rtw89_tx_wq){+.+.}-{0:0}, at: process_one_work+0x258/0x660
>   #1: ffffb97380cf3e78 ((work_completion)(&rtwdev->txq_work)){+.+.}-{0:0}, at:
> process_one_work+0x258/0x660
> 
>  stack backtrace:
>  CPU: 8 PID: 184 Comm: kworker/u33:0 Tainted: G            E     5.17.0-rc4-00003-gccad664b7f14 #3
> 473b49ab0e7c2d6af2900c756bfd04efd7a9de13
>  Hardware name: LENOVO 20UJS2B905/20UJS2B905, BIOS R1CET63W(1.32 ) 04/09/2021
>  Workqueue: rtw89_tx_wq rtw89_core_txq_work [rtw89_core]
>  Call Trace:
>   <TASK>
>   dump_stack_lvl+0x58/0x71
>   ieee80211_tx_h_select_key+0x464/0x530 [mac80211 911c23e2351c0ae60b597a67b1204a5ea955e365]
>   ieee80211_tx_dequeue+0x1a7/0x1260 [mac80211 911c23e2351c0ae60b597a67b1204a5ea955e365]
>   rtw89_core_txq_work+0x1a6/0x420 [rtw89_core b39ba493f2e517ad75e0f8187ecc24edf58bbbea]
>   process_one_work+0x2d8/0x660
>   worker_thread+0x39/0x3e0
>   ? process_one_work+0x660/0x660
>   kthread+0xe5/0x110
>   ? kthread_complete_and_exit+0x20/0x20
>   ret_from_fork+0x22/0x30
>   </TASK>
> 
> Signed-off-by: Jiri Kosina <jkosina@suse.cz>

Acked-by: Ping-Ke Shih <pkshih@realtek.com>

Thanks for your finding.

> ---
>  drivers/net/wireless/realtek/rtw89/core.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
> index a0737eea9f81..9632e7f218dd 100644
> --- a/drivers/net/wireless/realtek/rtw89/core.c
> +++ b/drivers/net/wireless/realtek/rtw89/core.c
> @@ -1509,11 +1509,12 @@ static void rtw89_core_txq_push(struct rtw89_dev *rtwdev,
>  	unsigned long i;
>  	int ret;
> 
> +	rcu_read_lock();
>  	for (i = 0; i < frame_cnt; i++) {
>  		skb = ieee80211_tx_dequeue_ni(rtwdev->hw, txq);
>  		if (!skb) {
>  			rtw89_debug(rtwdev, RTW89_DBG_TXRX, "dequeue a NULL skb\n");
> -			return;
> +			goto out;
>  		}
>  		rtw89_core_txq_check_agg(rtwdev, rtwtxq, skb);
>  		ret = rtw89_core_tx_write(rtwdev, vif, sta, skb, NULL);
> @@ -1523,6 +1524,8 @@ static void rtw89_core_txq_push(struct rtw89_dev *rtwdev,
>  			break;
>  		}
>  	}
> +out:
> +	rcu_read_unlock();
>  }
> 
>  static u32 rtw89_check_and_reclaim_tx_resource(struct rtw89_dev *rtwdev, u8 tid)
> 
> --
> Jiri Kosina
> SUSE Labs
> 
> 
> ------Please consider the environment before printing this e-mail.
