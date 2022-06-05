Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E725953DB02
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Jun 2022 11:31:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350945AbiFEJbB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Jun 2022 05:31:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350919AbiFEJa4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jun 2022 05:30:56 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D28B252BC
        for <linux-kernel@vger.kernel.org>; Sun,  5 Jun 2022 02:30:55 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1654421453;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=F2mg78atyxKdqm6d5evnZo2+jefnkxpqUmr918ngYNs=;
        b=0BQn9XkmNiKHvtrXpIw9CCbb40l/9c8mVVtR91pYM1R0R+2oztcMSqXgb/Gm7C3jFACfrd
        rtbd+2g+dPF2LgijxtSFXR4eQvXY8Elyt5Kfz/q0x12HDOb1Sv7MGZWzs/gKvsu1W9tAbG
        EAJ9hkmUvas5SMEDoye5+c34kYgYGBeVFnDNnyhN1Qv69clKGcqaFq5+FYnLty0OUO8aUM
        OZ5yctUw8F7so5zgPbn100q5cQMXQWiAijMwx94B3ZjnVB6TyqQQO490wvxc6yzAE/6Wu4
        zhFommGpr/RUf3EypcKorB0HTfjOLD6MGdoYdJilASyooiGgb0ud+BiFPIEVSg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1654421453;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=F2mg78atyxKdqm6d5evnZo2+jefnkxpqUmr918ngYNs=;
        b=JERJgZ4c640xtsGOYorfrDG6StXNR689KOUs2yrLEDggZQfyCchvQFtn+QxSewkvqYxvBz
        A0HrIxeo9a7tu3Dw==
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] perf/urgent for v5.19-rc1
References: <165442136963.152751.14259048792272164569.tglx@xen13>
Message-ID: <165442137256.152751.9491260964554807818.tglx@xen13>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Date:   Sun,  5 Jun 2022 11:30:53 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest perf/urgent branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-urgent-2022=
-06-05

up to:  8b4dd2d8627e: perf/core: Remove unused local variable


Two small perf updates:

  - Make the ICL event constraints match reality

  - Remove a unused local variable


Thanks,

	tglx

------------------>
Haowen Bai (1):
      perf/core: Remove unused local variable

Kan Liang (1):
      perf/x86/intel: Fix event constraints for ICL


 arch/x86/events/intel/core.c | 2 +-
 kernel/events/core.c         | 1 -
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 955ae91c56dc..45024abd929f 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -276,7 +276,7 @@ static struct event_constraint intel_icl_event_constraint=
s[] =3D {
 	INTEL_EVENT_CONSTRAINT_RANGE(0x03, 0x0a, 0xf),
 	INTEL_EVENT_CONSTRAINT_RANGE(0x1f, 0x28, 0xf),
 	INTEL_EVENT_CONSTRAINT(0x32, 0xf),	/* SW_PREFETCH_ACCESS.* */
-	INTEL_EVENT_CONSTRAINT_RANGE(0x48, 0x54, 0xf),
+	INTEL_EVENT_CONSTRAINT_RANGE(0x48, 0x56, 0xf),
 	INTEL_EVENT_CONSTRAINT_RANGE(0x60, 0x8b, 0xf),
 	INTEL_UEVENT_CONSTRAINT(0x04a3, 0xff),  /* CYCLE_ACTIVITY.STALLS_TOTAL */
 	INTEL_UEVENT_CONSTRAINT(0x10a3, 0xff),  /* CYCLE_ACTIVITY.CYCLES_MEM_ANY */
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 950b25c3f210..80782cddb1da 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -4257,7 +4257,6 @@ static void perf_event_remove_on_exec(int ctxn)
 {
 	struct perf_event_context *ctx, *clone_ctx =3D NULL;
 	struct perf_event *event, *next;
-	LIST_HEAD(free_list);
 	unsigned long flags;
 	bool modified =3D false;
=20

