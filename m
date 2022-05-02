Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C72B516F9A
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 14:31:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383988AbiEBMfO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 08:35:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384914AbiEBMfE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 08:35:04 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36AE212A99;
        Mon,  2 May 2022 05:31:36 -0700 (PDT)
Date:   Mon, 02 May 2022 12:31:33 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1651494694;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wUo1RV29CS04qOxcEpeLvwt92eN/kBQsGYgjoTAJ744=;
        b=QPW70wu+LGUHAxQaRYTjoZ0cpTxVxELQ6r39dsm/Qdn3mJfBMKDRxga6dGTQZ/G7/t9Kd/
        qz1klChd02WhJlC+LLDU/30KXLG4T8Cno/euzkLzX8W20PNI1yVlfWOywr87vwmiqqJT5A
        BCzD0LaFouDwFAQI0CzBkL1I+fjrcN0W94NsqiGAasczObSAWKsTPiZ/tm9y+9GEf3QlKb
        d/jbivlmZCI4qxSeqfCjyhxTCoZFPYVsrahtbjPLlOKEyvHWHq6smuco7Q3ApmGvCcYD9I
        2tpbwhXn2yBBGaYv+Ply9zrqVS2ttq+URcKw1khLZO9estRtT3OIC9F41Erj7A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1651494694;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wUo1RV29CS04qOxcEpeLvwt92eN/kBQsGYgjoTAJ744=;
        b=TfwzDfUfe3GKLNPF6BMcjS2BXxkSjZ/hD4O5Y5y7yV5JaljLQG/OXZAy11LA6hxw1fJ6Qi
        KQ24XQVEbeMbuIBA==
From:   "tip-bot2 for Maciej W. Rozycki" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] time/sched_clock: Use Hz as the unit for clock
 rate reporting below 4kHz
Cc:     "Maciej W. Rozycki" <macro@orcam.me.uk>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <alpine.DEB.2.21.2204240106380.9383@angie.orcam.me.uk>
References: <alpine.DEB.2.21.2204240106380.9383@angie.orcam.me.uk>
MIME-Version: 1.0
Message-ID: <165149469366.4207.10574054034236381529.tip-bot2@tip-bot2>
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

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     cc1b923a4e378c943386e7fe6205918d43e5fede
Gitweb:        https://git.kernel.org/tip/cc1b923a4e378c943386e7fe6205918d43e5fede
Author:        Maciej W. Rozycki <macro@orcam.me.uk>
AuthorDate:    Sun, 24 Apr 2022 12:47:26 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 02 May 2022 14:29:04 +02:00

time/sched_clock: Use Hz as the unit for clock rate reporting below 4kHz

The kernel uses kHz as the unit for clock rates reported between 1MHz
(inclusive) and 4MHz (exclusive), e.g.:

 sched_clock: 64 bits at 1000kHz, resolution 1000ns, wraps every 2199023255500ns

This reduces the amount of data lost due to rounding, but hasn't been
replicated for the kHz range when support was added for proper reporting of
sub-kHz clock rates.  Take the same approach for rates between 1kHz
(inclusive) and 4kHz (exclusive), which makes it consistent.

Signed-off-by: Maciej W. Rozycki <macro@orcam.me.uk>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/alpine.DEB.2.21.2204240106380.9383@angie.orcam.me.uk

---
 kernel/time/sched_clock.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/time/sched_clock.c b/kernel/time/sched_clock.c
index ee07f3a..4a95c0b 100644
--- a/kernel/time/sched_clock.c
+++ b/kernel/time/sched_clock.c
@@ -203,7 +203,7 @@ sched_clock_register(u64 (*read)(void), int bits, unsigned long rate)
 		r = DIV_ROUND_CLOSEST(r, 1000000);
 		r_unit = 'M';
 	} else {
-		if (r >= 1000) {
+		if (r >= 4000) {
 			r = DIV_ROUND_CLOSEST(r, 1000);
 			r_unit = 'k';
 		} else {
