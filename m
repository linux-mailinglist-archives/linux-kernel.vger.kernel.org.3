Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDCB7489935
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 14:06:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230173AbiAJNGr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 08:06:47 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:42924 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiAJNGq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 08:06:46 -0500
Date:   Mon, 10 Jan 2022 13:06:44 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1641820005;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=A8LM0Mbfc7D4SCqnRFJWq+6zfe1o+Wc+4Al0V9Pcny4=;
        b=2+Mlog6WXlkaSDYVtZxW4dn17n7j6RhAMnpZZySwEi2t3SEkymWeeWNhKG9j7Sizk9gQn2
        GJ26PKa6DEsQcfyPLWnLhIRjVcVVAoSw018zs4w8IdYK1/18NGg+T9MOmZrl3ljNmM3buo
        nGc4x/OELfy9kE5yMmmGy/KNr3e2pVWh6e8GsDiaSElTYKqOcXsoV/0FK+3Yv86u5KJg2b
        QxGduFsuZAvliNafLxMrtHydQuiYHevurIRfWfRgtMxiAWPqKMfzdTQ3NRLoojw59fEzPM
        f/ORKdeUgN8L5GMQbZJpNdGRh1RPUsHms4qlqD7A5o/b4Yo4Le1L/pdiTXiicA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1641820005;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=A8LM0Mbfc7D4SCqnRFJWq+6zfe1o+Wc+4Al0V9Pcny4=;
        b=RUNp7daKk9+NxjcB56fJX5qZjZQZjeGVmCBrs+f8uHkn6IMIgHeOnoZM3Y06K3A7qhEmT3
        jNap84FqARh1F3Ag==
From:   "tip-bot2 for Waiman Long" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] clocksource: Reduce the default
 clocksource_watchdog() retries to 2
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Waiman Long <longman@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <164182000439.16921.4167002233119575414.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     1a5620671a1b6fd9cc08761677d050f1702f910c
Gitweb:        https://git.kernel.org/tip/1a5620671a1b6fd9cc08761677d050f1702f910c
Author:        Waiman Long <longman@redhat.com>
AuthorDate:    Thu, 18 Nov 2021 14:14:37 -05:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Tue, 30 Nov 2021 17:22:29 -08:00

clocksource: Reduce the default clocksource_watchdog() retries to 2

With the previous patch, there is an extra watchdog read in each retry.
Now the total number of clocksource reads is increased to 4 per iteration.
In order to avoid increasing the clock skew check overhead, the default
maximum number of retries is reduced from 3 to 2 to maintain the same 12
clocksource reads in the worst case.

Suggested-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Waiman Long <longman@redhat.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 Documentation/admin-guide/kernel-parameters.txt | 4 ++--
 kernel/time/clocksource.c                       | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 9725c54..3ea934b 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -603,8 +603,8 @@
 	clocksource.max_cswd_read_retries= [KNL]
 			Number of clocksource_watchdog() retries due to
 			external delays before the clock will be marked
-			unstable.  Defaults to three retries, that is,
-			four attempts to read the clock under test.
+			unstable.  Defaults to two retries, that is,
+			three attempts to read the clock under test.
 
 	clocksource.verify_n_cpus= [KNL]
 			Limit the number of CPUs checked for clocksources
diff --git a/kernel/time/clocksource.c b/kernel/time/clocksource.c
index bcad1a1..b7e52a6 100644
--- a/kernel/time/clocksource.c
+++ b/kernel/time/clocksource.c
@@ -199,7 +199,7 @@ void clocksource_mark_unstable(struct clocksource *cs)
 	spin_unlock_irqrestore(&watchdog_lock, flags);
 }
 
-ulong max_cswd_read_retries = 3;
+ulong max_cswd_read_retries = 2;
 module_param(max_cswd_read_retries, ulong, 0644);
 EXPORT_SYMBOL_GPL(max_cswd_read_retries);
 static int verify_n_cpus = 8;
