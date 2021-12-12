Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4332D47199C
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Dec 2021 11:35:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230094AbhLLKe0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Dec 2021 05:34:26 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:57606 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230078AbhLLKeZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Dec 2021 05:34:25 -0500
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1639305264;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=t5DMBMVLh+g+UhDhHu9YCONc2ej9kqSFYW7lSNriSGI=;
        b=nVil5oXOkijS/PRT1nhw77Z3uvN4SbzKJDMyzsYydMptPhi0sLox98+9VZE78hPdt/Mdns
        NP3qKYeHiOST/IqHlpuo+WrqATkPLZRBEbpwHk7nHLbl2O5fC3zrN6G3gNoTTQCS3ns+UX
        Jzplf+ZplyJSM1hKIdUrRxhyrgL0Vj8ZBIHWOLMe74DOU/5RE5Tej9It+z5xArJY/6PehD
        ePWyMYuiuQAw88Q8kQ7QY1Jfl9uOpvAPJI/3jW/iPqLdRxOKduaemVBKfAFFQJM2L7AliN
        kibrBnoBhJcdlpOFsil0qXBcpf+ZyM82muQ4FTHeq32eSr5W0inoyZ8bmPcsdg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1639305264;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=t5DMBMVLh+g+UhDhHu9YCONc2ej9kqSFYW7lSNriSGI=;
        b=0SQtZb8dYyaXfUhEg76kN5/BMBhFnMNxgqAOutWWaTkekZG7CharzU4QdMbEKB/eVQUHki
        v+hxh+ZqneJXAQAw==
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] timers/urgent for v5.16-rc5
References: <163930519667.2118055.7751610896538340816.tglx@xen13>
Message-ID: <163930519961.2118055.13711839421332400381.tglx@xen13>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Date:   Sun, 12 Dec 2021 11:34:23 +0100 (CET)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest timers/urgent branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers-urgent-20=
21-12-12

up to:  aa073d8b2a63: Merge tag 'timers-v5.16-rc4' of https://git.linaro.org/=
people/daniel.lezcano/linux into timers/urgent


Two fixes for clock chip drivers:

    - A regression fix for the Designware APB timer. A recent change to the
      error checking code transformed the error condition wrongly so it
      turned into a fail if good condition.

    - Fix a clang build fail of the ARM architected timer driver.

Thanks,

	tglx

------------------>
Alexey Sheplyakov (1):
      clocksource/drivers/dw_apb_timer_of: Fix probe failure

Marc Zyngier (1):
      clocksource/drivers/arm_arch_timer: Force inlining of erratum_set_next_=
event_generic()


 drivers/clocksource/arm_arch_timer.c  | 9 +++++++--
 drivers/clocksource/dw_apb_timer_of.c | 2 +-
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_a=
rch_timer.c
index 9a04eacc4412..1ecd52f903b8 100644
--- a/drivers/clocksource/arm_arch_timer.c
+++ b/drivers/clocksource/arm_arch_timer.c
@@ -394,8 +394,13 @@ EXPORT_SYMBOL_GPL(timer_unstable_counter_workaround);
=20
 static atomic_t timer_unstable_counter_workaround_in_use =3D ATOMIC_INIT(0);
=20
-static void erratum_set_next_event_generic(const int access, unsigned long e=
vt,
-						struct clock_event_device *clk)
+/*
+ * Force the inlining of this function so that the register accesses
+ * can be themselves correctly inlined.
+ */
+static __always_inline
+void erratum_set_next_event_generic(const int access, unsigned long evt,
+				    struct clock_event_device *clk)
 {
 	unsigned long ctrl;
 	u64 cval;
diff --git a/drivers/clocksource/dw_apb_timer_of.c b/drivers/clocksource/dw_a=
pb_timer_of.c
index 3819ef5b7098..3245eb0c602d 100644
--- a/drivers/clocksource/dw_apb_timer_of.c
+++ b/drivers/clocksource/dw_apb_timer_of.c
@@ -47,7 +47,7 @@ static int __init timer_get_base_and_rate(struct device_nod=
e *np,
 			pr_warn("pclk for %pOFn is present, but could not be activated\n",
 				np);
=20
-	if (!of_property_read_u32(np, "clock-freq", rate) &&
+	if (!of_property_read_u32(np, "clock-freq", rate) ||
 	    !of_property_read_u32(np, "clock-frequency", rate))
 		return 0;
=20

