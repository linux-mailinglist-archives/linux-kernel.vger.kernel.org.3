Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BF594C2882
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 10:49:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233000AbiBXJt5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 04:49:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232999AbiBXJt4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 04:49:56 -0500
X-Greylist: delayed 63 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 24 Feb 2022 01:49:25 PST
Received: from esa4.hc1455-7.c3s2.iphmx.com (esa4.hc1455-7.c3s2.iphmx.com [68.232.139.117])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E2DF15FC89
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 01:49:24 -0800 (PST)
IronPort-SDR: MlR9ir+ODx2HYvf/DJX649bwc9SwkmCcol268/Ikf/j5u5WczFO7hPjUXGEZpA2gJP80x3Wfr8
 jr9hDwnodTydYuD1zDU0IGc16orgzUn2hhuNgZWx38zm6JAIiZNJNqs40grZhZxylSpUAVUEjt
 EvRWZWoeMP/X26c2rq6vaCbR8GsU0Y/TMXs9esiHNox0th7IRCkGygEZGzL1gMbLL08dSeIGCz
 qi8bqiiD9ZWWE7uc+G1bFuipmszAc19EUmU+iVP8febNwDivO04sOGvUHTe1O/5hXcUREDBMjx
 yzy+EVGCXmcr/aeas1NifpUg
X-IronPort-AV: E=McAfee;i="6200,9189,10267"; a="63927949"
X-IronPort-AV: E=Sophos;i="5.88,393,1635174000"; 
   d="scan'208";a="63927949"
Received: from unknown (HELO yto-r1.gw.nic.fujitsu.com) ([218.44.52.217])
  by esa4.hc1455-7.c3s2.iphmx.com with ESMTP; 24 Feb 2022 18:48:20 +0900
Received: from yto-m1.gw.nic.fujitsu.com (yto-nat-yto-m1.gw.nic.fujitsu.com [192.168.83.64])
        by yto-r1.gw.nic.fujitsu.com (Postfix) with ESMTP id 2935410617
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 18:48:18 +0900 (JST)
Received: from m3003.s.css.fujitsu.com (m3003.s.css.fujitsu.com [10.128.233.114])
        by yto-m1.gw.nic.fujitsu.com (Postfix) with ESMTP id 6C6E2D0437
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 18:48:16 +0900 (JST)
Received: from localhost.localdomain (unknown [10.125.5.220])
        by m3003.s.css.fujitsu.com (Postfix) with ESMTP id 45E6E200B431;
        Thu, 24 Feb 2022 18:48:16 +0900 (JST)
From:   Rei Yamamoto <yamamoto.rei@jp.fujitsu.com>
To:     tglx@linutronix.de
Cc:     geert+renesas@glider.be, linux-kernel@vger.kernel.org,
        yamamoto.rei@jp.fujitsu.com
Subject: [PATCH] hrtimer: Remove a warning message in hrtimer_interrupt()
Date:   Thu, 24 Feb 2022 18:28:48 +0900
Message-Id: <20220224092848.3755-1-yamamoto.rei@jp.fujitsu.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20211224023924.91851-1-yamamoto.rei@jp.fujitsu.com>
References: <20211224023924.91851-1-yamamoto.rei@jp.fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It seems the warning message in hrtimer_interrupt() has
no an intention.
The required action for the warning message in hrtimer_interrupt() 
is not clear.
Remove this message not to confuse user.

Signed-off-by: Rei Yamamoto <yamamoto.rei@jp.fujitsu.com>
---
 kernel/time/hrtimer.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index 0ea8702eb516..4f4eb9d1f05a 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -1866,7 +1866,6 @@ void hrtimer_interrupt(struct clock_event_device *dev)
 	else
 		expires_next = ktime_add(now, delta);
 	tick_program_event(expires_next, 1);
-	pr_warn_once("hrtimer: interrupt took %llu ns\n", ktime_to_ns(delta));
 }
 
 /* called with interrupts disabled */
-- 
2.27.0

