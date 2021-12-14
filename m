Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FDB5474D1E
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 22:12:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237818AbhLNVMX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 16:12:23 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:44060 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234778AbhLNVMJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 16:12:09 -0500
Date:   Tue, 14 Dec 2021 21:12:06 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1639516327;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rcii2iHyAkR9Kah3KUc4lSx3hIDJM4dLUBLakzw4z6E=;
        b=B0rPXjbt1p4rP1GFra4RGExEArWK/VnsV3RQzG+kSZISyI8gUQklTnHVoHza/qViZ4xjSE
        2rch1qW2B9EEoAkvSclf/c5dnC0leshpUBx8TCva0GYGlY7baBsDeRqjArN6bkAgw0fNko
        YwQGpJAqlRLcC/TNCAGexGnJXT4BVQgXxjjX6GKtXd+XwU1LVgIwiBuosJznfP5YWh1MUH
        V90pk7iC3QX+5sN+xLoWRXOmbH/+raJ+caNU5lsavdt8TNh/yYWEePeUhXt1BK7snKTzrY
        6t/qR/7rPSkjUWLQbF/oCDy8a/sKHXprnJBLjkJhhFtcue0Ghize8MXhK5Ek9w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1639516327;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rcii2iHyAkR9Kah3KUc4lSx3hIDJM4dLUBLakzw4z6E=;
        b=xZEw/zMk3g/IMoezgazY85RpvDxMaCvVQtFZs9lhvsFQB+8uOSZ8EV96YXK2x/k+Fxqmsm
        GwjKrSqhtTykzJDg==
From:   "tip-bot2 for Chang S. Bae" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/urgent] signal: Skip the altstack update when not needed
Cc:     kernel test robot <oliver.sang@intel.com>,
        "Chang S. Bae" <chang.seok.bae@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211210225503.12734-1-chang.seok.bae@intel.com>
References: <20211210225503.12734-1-chang.seok.bae@intel.com>
MIME-Version: 1.0
Message-ID: <163951632633.23020.9347613990471336482.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/urgent branch of tip:

Commit-ID:     6c3118c32129b4197999a8928ba776bcabd0f5c4
Gitweb:        https://git.kernel.org/tip/6c3118c32129b4197999a8928ba776bcabd0f5c4
Author:        Chang S. Bae <chang.seok.bae@intel.com>
AuthorDate:    Fri, 10 Dec 2021 14:55:03 -08:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Tue, 14 Dec 2021 13:08:36 -08:00

signal: Skip the altstack update when not needed

== Background ==

Support for large, "dynamic" fpstates was recently merged.  This
included code to ensure that sigaltstacks are sufficiently sized for
these large states.  A new lock was added to remove races between
enabling large features and setting up sigaltstacks.

== Problem ==

The new lock (sigaltstack_lock()) is acquired in the sigreturn path
before restoring the old sigaltstack.  Unfortunately, contention on the
new lock causes a measurable signal handling performance regression [1].
However, the common case is that no *changes* are made to the
sigaltstack state at sigreturn.

== Solution ==

do_sigaltstack() acquires sigaltstack_lock() and is used for both
sys_sigaltstack() and restoring the sigaltstack in sys_sigreturn().
Check for changes to the sigaltstack before taking the lock.  If no
changes were made, return before acquiring the lock.

This removes lock contention from the common-case sigreturn path.

[1] https://lore.kernel.org/lkml/20211207012128.GA16074@xsang-OptiPlex-9020/

Fixes: 3aac3ebea08f ("x86/signal: Implement sigaltstack size validation")
Reported-by: kernel test robot <oliver.sang@intel.com>
Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/20211210225503.12734-1-chang.seok.bae@intel.com
---
 kernel/signal.c |  9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/kernel/signal.c b/kernel/signal.c
index a629b11..dfcee38 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -4185,6 +4185,15 @@ do_sigaltstack (const stack_t *ss, stack_t *oss, unsigned long sp,
 				ss_mode != 0))
 			return -EINVAL;
 
+		/*
+		 * Return before taking any locks if no actual
+		 * sigaltstack changes were requested.
+		 */
+		if (t->sas_ss_sp == (unsigned long)ss_sp &&
+		    t->sas_ss_size == ss_size &&
+		    t->sas_ss_flags == ss_flags)
+			return 0;
+
 		sigaltstack_lock();
 		if (ss_mode == SS_DISABLE) {
 			ss_size = 0;
