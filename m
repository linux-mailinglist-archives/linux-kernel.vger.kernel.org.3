Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9CD553DB00
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Jun 2022 11:31:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350956AbiFEJbE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Jun 2022 05:31:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350927AbiFEJa5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jun 2022 05:30:57 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04F02252BC
        for <linux-kernel@vger.kernel.org>; Sun,  5 Jun 2022 02:30:57 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1654421455;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=Lclo3T9NeR0CiqoNoIC1Dz2q5LcjMw+PeZEXxy9EH/4=;
        b=BQvpCNnaulo1XoMYlvOKFugB3Vay/loeCmzqiOImnFADQ/qw1ugYEKqr+uo3PkW4Iy0zZb
        2PWHyRnhSkdtIEoVsY5Kzz67MwMafwuwf18KZHU71/nduigzJsVrl2VricgvKNOpDlmVb/
        oEeRifaGkFfRX1LIsUdmCgJmfVXCWtJlsRJeSje7YNLGMimh6ZqU5RM4jVYMRGTm0Cect5
        1QkB90f5YMx0GpEqZRiJkelR0/kX7Prs7RfDu2iPkjGD3bEAjFsAYzz279p1vmIOIh9ESl
        dxuPC7Wy0L8kNjH5sWWr4mt+/MM7uIKuSYGzilzmTAK2bgv3Rl4sgrNYIK+txQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1654421455;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=Lclo3T9NeR0CiqoNoIC1Dz2q5LcjMw+PeZEXxy9EH/4=;
        b=+RqveWw+9Z7QoeYMl7sXSwAFTTXjXsXYUH+3OQ6a4xPTWZ+hdX9Srk9vMeIPii1sOYmIgT
        4brPQj78YiG+HiAA==
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] sched/urgent for v5.19-rc1
References: <165442136963.152751.14259048792272164569.tglx@xen13>
Message-ID: <165442137401.152751.18098290131233756985.tglx@xen13>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Date:   Sun,  5 Jun 2022 11:30:55 +0200 (CEST)
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

please pull the latest sched/urgent branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched-urgent-202=
2-06-05

up to:  82f586f923e3: sched/autogroup: Fix sysctl move


Fix the fallout of sysctl code move which placed the init function wrong.

Thanks,

	tglx

------------------>
Peter Zijlstra (1):
      sched/autogroup: Fix sysctl move


 kernel/sched/autogroup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/autogroup.c b/kernel/sched/autogroup.c
index 16092b49ff6a..4ebaf97f7bd8 100644
--- a/kernel/sched/autogroup.c
+++ b/kernel/sched/autogroup.c
@@ -36,6 +36,7 @@ void __init autogroup_init(struct task_struct *init_task)
 	kref_init(&autogroup_default.kref);
 	init_rwsem(&autogroup_default.lock);
 	init_task->signal->autogroup =3D &autogroup_default;
+	sched_autogroup_sysctl_init();
 }
=20
 void autogroup_free(struct task_group *tg)
@@ -219,7 +220,6 @@ void sched_autogroup_exit(struct signal_struct *sig)
 static int __init setup_autogroup(char *str)
 {
 	sysctl_sched_autogroup_enabled =3D 0;
-	sched_autogroup_sysctl_init();
=20
 	return 1;
 }

