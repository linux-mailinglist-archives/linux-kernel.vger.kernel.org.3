Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEA844FFBC4
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 18:51:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237054AbiDMQyP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 12:54:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234566AbiDMQyM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 12:54:12 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E86F5674D3;
        Wed, 13 Apr 2022 09:51:49 -0700 (PDT)
Date:   Wed, 13 Apr 2022 16:51:46 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1649868708;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=86mdrBQ5bfO1glHLGsv54Godblef0RidxRX59FMwf5I=;
        b=Z7e5cleoO6eg1OHsYh8MGQDt4kQJtWEc5T2vuvJg4keutI1pHaPTZHKswNmbOhYFxwsH2L
        aHbEqSzRaFFCDO5F4lTrUg27i2lx2RsT10ZfPCchfD7ISNlpHlIt1Yci3cQcRzan7oELC8
        jztCizlRazjdrefhn/aqS3XZDJCMMCnBOi7NEVd4kAIP6G26flVaWbKbyh9HZ7UKAyXEvn
        7kmEoUEQVG52ax81mditmA2DiEWb6EPbwgmyWXPZrtwR78b9ztSDyGSrRaFPwPHNLrFDbE
        0yRrXqSZ29pJxyEZZru8hJ6EVd3TKr5H/VDxTmbB7RB7eTTwsFmGyCwq3zlE9A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1649868708;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=86mdrBQ5bfO1glHLGsv54Godblef0RidxRX59FMwf5I=;
        b=VO85mUgLKDgwaHlvamH5Z0m/ETcRkGAOn9CfPFuZydie32geQn+MKKOX2cphuP3OyfQPnf
        MuzD3Yc40ILH0nCg==
From:   "tip-bot2 for Nadav Amit" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: smp/urgent] smp: Fix offline cpu check in
 flush_smp_call_function_queue()
Cc:     Nadav Amit <namit@vmware.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220319072015.1495036-1-namit@vmware.com>
References: <20220319072015.1495036-1-namit@vmware.com>
MIME-Version: 1.0
Message-ID: <164986870674.4207.3617586517028813554.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the smp/urgent branch of tip:

Commit-ID:     9e949a3886356fe9112c6f6f34a6e23d1d35407f
Gitweb:        https://git.kernel.org/tip/9e949a3886356fe9112c6f6f34a6e23d1d35407f
Author:        Nadav Amit <namit@vmware.com>
AuthorDate:    Sat, 19 Mar 2022 00:20:15 -07:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 13 Apr 2022 18:44:35 +02:00

smp: Fix offline cpu check in flush_smp_call_function_queue()

The check in flush_smp_call_function_queue() for callbacks that are sent
to offline CPUs currently checks whether the queue is empty.

However, flush_smp_call_function_queue() has just deleted all the
callbacks from the queue and moved all the entries into a local list.
This checks would only be positive if some callbacks were added in the
short time after llist_del_all() was called. This does not seem to be
the intention of this check.

Change the check to look at the local list to which the entries were
moved instead of the queue from which all the callbacks were just
removed.

Fixes: 8d056c48e4862 ("CPU hotplug, smp: flush any pending IPI callbacks before CPU offline")
Signed-off-by: Nadav Amit <namit@vmware.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20220319072015.1495036-1-namit@vmware.com
---
 kernel/smp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/smp.c b/kernel/smp.c
index 01a7c17..65a630f 100644
--- a/kernel/smp.c
+++ b/kernel/smp.c
@@ -579,7 +579,7 @@ static void flush_smp_call_function_queue(bool warn_cpu_offline)
 
 	/* There shouldn't be any pending callbacks on an offline CPU. */
 	if (unlikely(warn_cpu_offline && !cpu_online(smp_processor_id()) &&
-		     !warned && !llist_empty(head))) {
+		     !warned && entry != NULL)) {
 		warned = true;
 		WARN(1, "IPI on offline CPU %d\n", smp_processor_id());
 
