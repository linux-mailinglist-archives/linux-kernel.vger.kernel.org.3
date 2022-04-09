Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4DE64FAAB7
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 22:23:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231582AbiDIUY5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Apr 2022 16:24:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231330AbiDIUYo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Apr 2022 16:24:44 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF2BE2BCE;
        Sat,  9 Apr 2022 13:22:34 -0700 (PDT)
Date:   Sat, 09 Apr 2022 20:22:31 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1649535752;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8zaOcmLacimZqKKgJ63XfnGyUqu5Teh+3oLuqT1XOXc=;
        b=10RPt3/QkNPy1Q6lI1vM1kB0GqlGn8ye3vu+/4RbBeHFIHRMA+uO1i6Vgguvd9SDXp4QwO
        Egy33v8bPwmf71plab1c14WZMtth9rCTNVfP0tJpKoaMiDSnUWGsHB3W5STycLGfeBIIMv
        NtUKHNG7NJtL0oTvLZEZ2XE5zo5GFlqmaWdVKDH8f22i3M8pU6tdd/Kgl7fI9hNQEjaAvF
        iJ7YaNvzSt7yQcdHWkOQB9icb2ntyDXf3vZBUEhitsxVfcYn47TWde5pXE072M2LTT6zOE
        EbzvvbWc0Mu3oGpQs0lckdl2ylfzN9o9cDKRjZWaUY2bgHBEbkmnL5AnRDcMOQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1649535752;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8zaOcmLacimZqKKgJ63XfnGyUqu5Teh+3oLuqT1XOXc=;
        b=GDVrwfohIS5ekAag54Ki7/L048J1H20Hm41fBGfjdcVuRUbFnnk9JDqvKF9zC7AdyGGY58
        FLA8szonjkLYfDCw==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] timers: Simplify calc_index()
Cc:     Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <87h778j46c.ffs@tglx>
References: <87h778j46c.ffs@tglx>
MIME-Version: 1.0
Message-ID: <164953575112.4207.4558393487753239676.tip-bot2@tip-bot2>
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

Commit-ID:     a2026e44eff5d74a83d7ffee6325a007bef85385
Gitweb:        https://git.kernel.org/tip/a2026e44eff5d74a83d7ffee6325a007bef85385
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Mon, 04 Apr 2022 16:47:55 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sat, 09 Apr 2022 22:19:39 +02:00

timers: Simplify calc_index()

The level granularity round up of calc_index() does:

   (x + (1 << n)) >> n

which is obviously equivalent to

   (x >> n) + 1

but compilers can't figure that out despite the fact that the input range
is known to not cause an overflow. It's neither intuitive to read.

Just write out the obvious.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/87h778j46c.ffs@tglx

---
 kernel/time/timer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index 204d6cd..60aebf2 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -502,7 +502,7 @@ static inline unsigned calc_index(unsigned long expires, unsigned lvl,
 	 *
 	 * Round up with level granularity to prevent this.
 	 */
-	expires = (expires + LVL_GRAN(lvl)) >> LVL_SHIFT(lvl);
+	expires = (expires >> LVL_SHIFT(lvl)) + 1;
 	*bucket_expiry = expires << LVL_SHIFT(lvl);
 	return LVL_OFFS(lvl) + (expires & LVL_MASK);
 }
