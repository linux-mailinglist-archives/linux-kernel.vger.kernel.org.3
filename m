Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 952A0516F9B
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 14:31:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385035AbiEBMfG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 08:35:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384872AbiEBMfE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 08:35:04 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5923312A94;
        Mon,  2 May 2022 05:31:35 -0700 (PDT)
Date:   Mon, 02 May 2022 12:31:32 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1651494694;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=M6819Ern8zQctjbgFOLq4zCoZZuTcZxoj2Eqm7eU0Us=;
        b=WwsBHEsPuu50F3CEKNuvGvpTXLf7Dy1VI+ECB0jiVmTx1lZzYhfKTUumtMK7jFh7SQG/fQ
        rlFE5R+Iivf9odHtmlRAfHldsQvWkypkaXOkOUT1rBWFpH7vcuNmrvzMjoCPvXPazL2hnK
        QxU76FxbWO5AzW8jqd3LVKr5NOlIffqOK9YbeZ8AXUnv9zgP7bckY0fxSSw5cMbRV2+u2I
        aBWs3NBSJTcDFIFQW6lJAYbcS6PIZj4RD1EM/8GO4lKraCT9yC1CoFkh9kdhcMhquX+nip
        pjAaFF1h8EA92QfDuz0iwDw0B9M39PfhSdYkYMBee3QD28Yyr7g8u0kGXkZfMA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1651494694;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=M6819Ern8zQctjbgFOLq4zCoZZuTcZxoj2Eqm7eU0Us=;
        b=tI2ceN7xQQ2uQKpwORSti2z2882PKNJhZ4ezNwrouic8NAqe7QIcDAMPTDO1iKm3I0z0gM
        SXPQm/pHAYBB8iDw==
From:   "tip-bot2 for Maciej W. Rozycki" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] time/sched_clock: Fix formatting of frequency
 reporting code
Cc:     "Maciej W. Rozycki" <macro@orcam.me.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        John Stultz <jstultz@google.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <alpine.DEB.2.21.2204240148220.9383@angie.orcam.me.uk>
References: <alpine.DEB.2.21.2204240148220.9383@angie.orcam.me.uk>
MIME-Version: 1.0
Message-ID: <165149469263.4207.2139248782239839767.tip-bot2@tip-bot2>
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

Commit-ID:     f4b62e1e1137507268c2c63dc4e6da279dc58e9f
Gitweb:        https://git.kernel.org/tip/f4b62e1e1137507268c2c63dc4e6da279dc58e9f
Author:        Maciej W. Rozycki <macro@orcam.me.uk>
AuthorDate:    Sun, 24 Apr 2022 12:47:30 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 02 May 2022 14:29:04 +02:00

time/sched_clock: Fix formatting of frequency reporting code

Use flat rather than nested indentation for chained else/if clauses as 
per coding-style.rst:

	if (x == y) {
		..
	} else if (x > y) {
		...
	} else {
		....
	}

This also improves readability.

Signed-off-by: Maciej W. Rozycki <macro@orcam.me.uk>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: John Stultz <jstultz@google.com>
Link: https://lore.kernel.org/r/alpine.DEB.2.21.2204240148220.9383@angie.orcam.me.uk

---
 kernel/time/sched_clock.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/kernel/time/sched_clock.c b/kernel/time/sched_clock.c
index 4a95c0b..8464c5a 100644
--- a/kernel/time/sched_clock.c
+++ b/kernel/time/sched_clock.c
@@ -202,13 +202,11 @@ sched_clock_register(u64 (*read)(void), int bits, unsigned long rate)
 	if (r >= 4000000) {
 		r = DIV_ROUND_CLOSEST(r, 1000000);
 		r_unit = 'M';
+	} else if (r >= 4000) {
+		r = DIV_ROUND_CLOSEST(r, 1000);
+		r_unit = 'k';
 	} else {
-		if (r >= 4000) {
-			r = DIV_ROUND_CLOSEST(r, 1000);
-			r_unit = 'k';
-		} else {
-			r_unit = ' ';
-		}
+		r_unit = ' ';
 	}
 
 	/* Calculate the ns resolution of this counter */
