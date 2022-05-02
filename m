Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1CC7516F3E
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 14:05:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384875AbiEBMIK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 08:08:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384863AbiEBMIE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 08:08:04 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A1D313D6D;
        Mon,  2 May 2022 05:04:35 -0700 (PDT)
Date:   Mon, 02 May 2022 12:04:32 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1651493073;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=z8X/9Q4KBvNpgeKtB/Wu+gpbUp9bksPoT5kvw77NT5U=;
        b=RWNQ8yNyrI/V7ntL9yhRqAcgISi2e512U7Cxg1P0TGd7OWm5NjyUepNyjxqxNxwTgNw55t
        Trnva+SYHiGNBefFa/CaTu034+1kkn/jpotj98OEkVO5cMuZCkGx4pe9UNSz7U63GSQZg3
        cjfhXHTtwLTnzcWfotEoFqEj7i6SvUD8ejoJOVltQbsnQGrfYTM5nXQqqWWJ1DNq/+YQyQ
        8QigciQA3qPwWWiUimcWGZFwRyONcuORUwlzY5ISSifSYEUN/cgNu0j0jZngDyoECTRMbW
        GxyPcV7jhi6/eFO1RKgm+BHLAvWtqtRURCrW312wEmNN3s9V/t7x5vx0ZWw9HA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1651493073;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=z8X/9Q4KBvNpgeKtB/Wu+gpbUp9bksPoT5kvw77NT5U=;
        b=NSovzquFxKhbtiRbJe0gioXDwCcxBxl8SzBz9IZDHpEpjtHZsjkv1BMHkE0iZN8A7YvUP0
        omqX00Rv/McVlUBQ==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] timekeeping: Annotate ktime_get_boot_fast_ns()
 with data_race()
Cc:     Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220415091920.956045162@linutronix.de>
References: <20220415091920.956045162@linutronix.de>
MIME-Version: 1.0
Message-ID: <165149307242.4207.1206001832585845014.tip-bot2@tip-bot2>
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

Commit-ID:     eff4849f928f2b90402907e06a6de1619cf16b1a
Gitweb:        https://git.kernel.org/tip/eff4849f928f2b90402907e06a6de1619cf16b1a
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Fri, 15 Apr 2022 11:19:35 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 02 May 2022 14:00:20 +02:00

timekeeping: Annotate ktime_get_boot_fast_ns() with data_race()

Accessing timekeeper::offset_boot in ktime_get_boot_fast_ns() is an
intended data race as the reader side cannot synchronize with a writer and
there is no space in struct tk_read_base of the NMI safe timekeeper.

Mark it so.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20220415091920.956045162@linutronix.de

---
 kernel/time/timekeeping.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index 2c22023..3479804 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -528,7 +528,7 @@ u64 notrace ktime_get_boot_fast_ns(void)
 {
 	struct timekeeper *tk = &tk_core.timekeeper;
 
-	return (ktime_get_mono_fast_ns() + ktime_to_ns(tk->offs_boot));
+	return (ktime_get_mono_fast_ns() + ktime_to_ns(data_race(tk->offs_boot)));
 }
 EXPORT_SYMBOL_GPL(ktime_get_boot_fast_ns);
 
