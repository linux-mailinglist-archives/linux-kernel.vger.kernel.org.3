Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D5ED4BE8D2
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 19:06:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349397AbiBUJMZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 04:12:25 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347742AbiBUJIz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 04:08:55 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9A6124BD8;
        Mon, 21 Feb 2022 01:00:34 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5D8C0B80EB3;
        Mon, 21 Feb 2022 08:55:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0544FC340EB;
        Mon, 21 Feb 2022 08:55:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645433731;
        bh=ZeTaPKMLPKsdndEyUbjYbsfZtwlYxTtcQ162SzMk4h4=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=SEspquUeJCV1HXWS77krJRrrQ7FNeGSw31dq0pgdER7ww2DJKNg6sNcBQXzr3L9Ns
         gTX1hhdPA5jGYm/gtKPxQImFuqH6XRuuDosMGuVqTaRbMWrA+pK7wQvEL3ww+Vs3wH
         /o/jzjC+LBI+tIwHASBNM6/eV8g29Omca28xxW2qzTRweLQbMLKJXYrjWTYh/oFlyI
         +DIvjm+SwMELei4HJmMLyfQXufXl+DNyzx+2EzaJrmcPUUma6wGGbtES/COlf+9+18
         b802kSRgJ/x+UIHKOc8Bsb+1YCPhWT5beIZLfvxxwPlHygUU2EPKdZCTmx5VA4ysop
         +6Xo7fLkD4bLw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] rtw89: fix RCU usage in rtw89_core_txq_push()
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <nycvar.YFH.7.76.2202152037000.11721@cbobk.fhfr.pm>
References: <nycvar.YFH.7.76.2202152037000.11721@cbobk.fhfr.pm>
To:     Jiri Kosina <jkosina@suse.cz>
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ping-Ke Shih <pkshih@realtek.com>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <164543372747.995.16579003811495784285.kvalo@kernel.org>
Date:   Mon, 21 Feb 2022 08:55:29 +0000 (UTC)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jiri Kosina <jkosina@suse.cz> wrote:

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
>   #1: ffffb97380cf3e78 ((work_completion)(&rtwdev->txq_work)){+.+.}-{0:0}, at: process_one_work+0x258/0x660
> 
>  stack backtrace:
>  CPU: 8 PID: 184 Comm: kworker/u33:0 Tainted: G            E     5.17.0-rc4-00003-gccad664b7f14 #3 473b49ab0e7c2d6af2900c756bfd04efd7a9de13
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
>   #1: ffffb97380cf3e78 ((work_completion)(&rtwdev->txq_work)){+.+.}-{0:0}, at: process_one_work+0x258/0x660
> 
>  stack backtrace:
>  CPU: 8 PID: 184 Comm: kworker/u33:0 Tainted: G            E     5.17.0-rc4-00003-gccad664b7f14 #3 473b49ab0e7c2d6af2900c756bfd04efd7a9de13
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
> Acked-by: Ping-Ke Shih <pkshih@realtek.com>

Patch applied to wireless-next.git, thanks.

f3d825a35920 rtw89: fix RCU usage in rtw89_core_txq_push()

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/nycvar.YFH.7.76.2202152037000.11721@cbobk.fhfr.pm/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

