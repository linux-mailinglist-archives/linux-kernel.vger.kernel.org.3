Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54AD2526040
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 12:58:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379599AbiEMKod (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 06:44:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379580AbiEMKoa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 06:44:30 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F010C2A0A53;
        Fri, 13 May 2022 03:44:29 -0700 (PDT)
Date:   Fri, 13 May 2022 10:44:27 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1652438668;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lCMh6nqjHElj/25pJ4wX9SdSVOW2vHWVXsi1MXUwgTI=;
        b=IpO9gztm4bTvLaifLDQ9nUY+VI8Ts4oHTGWrseIQBLsbiEl40L9g5zr0KSjwpxcRJgxxVg
        56BNUwJfQTXwrWiz2LHLnl48m/+o2epdny+cFlmbgwTRveXsrGl6FD2vvYlaP1JFlg5Onj
        un/QUDr1Fu5yVlZ7AzmyIPVjb9rtgTTmmsc6dzMkKC5IGZ6MTd60T4L/trS2bR4hJkhO8p
        OJ/Q3AoAoLpHd0aWtCtEFUOlZqPQplL9EPaa+rVU4TC6vg1DKPML6QaLtF9iLutBwH0f9d
        lTQ08JEm8XuKi3W/U+5asrSCHNzFW9huUftD4pH0PUZOW3sCBxiytBwXkN9QeA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1652438668;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lCMh6nqjHElj/25pJ4wX9SdSVOW2vHWVXsi1MXUwgTI=;
        b=TYx2ABwb3E0Hlny78P2LX4dzQG13JP17gj7fORKMz1FhW5muuIureL9voZSj0nXFrC0VQc
        ywiYE7OwzlTHhTCw==
From:   "tip-bot2 for Sebastian Andrzej Siewior" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] futex: Remove a PREEMPT_RT_FULL reference.
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>, andrealmeid@igalia.com,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <YnvWUvq1vpqCfCU7@linutronix.de>
References: <YnvWUvq1vpqCfCU7@linutronix.de>
MIME-Version: 1.0
Message-ID: <165243866737.4207.3194810680223006844.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     6829061315065c7af394d556a887fbf847e4e708
Gitweb:        https://git.kernel.org/tip/6829061315065c7af394d556a887fbf847e=
4e708
Author:        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
AuthorDate:    Wed, 11 May 2022 17:29:22 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 13 May 2022 12:36:51 +02:00

futex: Remove a PREEMPT_RT_FULL reference.

Earlier the PREEMPT_RT patch had a PREEMPT_RT_FULL and PREEMPT_RT_BASE
Kconfig option. The latter was a subset of the functionality that was
enabled with PREEMPT_RT_FULL and was mainly useful for debugging.

During the merging efforts the two Kconfig options were abandoned in the
v5.4.3-rt1 release and since then there is only PREEMPT_RT which enables
the full features set (as PREEMPT_RT_FULL did in earlier releases).

Replace the PREEMPT_RT_FULL reference with PREEMPT_RT.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Andr=C3=A9 Almeida <andrealmeid@igalia.com>
Link: https://lore.kernel.org/r/YnvWUvq1vpqCfCU7@linutronix.de

---
 kernel/futex/pi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/futex/pi.c b/kernel/futex/pi.c
index 183b28c..ce2889f 100644
--- a/kernel/futex/pi.c
+++ b/kernel/futex/pi.c
@@ -1005,7 +1005,7 @@ retry_private:
 	rt_mutex_init_waiter(&rt_waiter);
=20
 	/*
-	 * On PREEMPT_RT_FULL, when hb->lock becomes an rt_mutex, we must not
+	 * On PREEMPT_RT, when hb->lock becomes an rt_mutex, we must not
 	 * hold it while doing rt_mutex_start_proxy(), because then it will
 	 * include hb->lock in the blocking chain, even through we'll not in
 	 * fact hold it while blocking. This will lead it to report -EDEADLK
