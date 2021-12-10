Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28DBC470E4D
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Dec 2021 00:02:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344865AbhLJXF7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 18:05:59 -0500
Received: from mga06.intel.com ([134.134.136.31]:56218 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229685AbhLJXF6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 18:05:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639177343; x=1670713343;
  h=from:to:cc:subject:date:message-id;
  bh=YW4WsvNq/bREwArai310LiI26XmDGJGOPqm+1ejpzoQ=;
  b=KEnKi7rRv1tfV1EREbvj4QAmikvPkrqPvwB5gbhnyLKnmMCkIeU6Dc1B
   RoskGiGTtl1QTZzSLeVuPIneJh4TuoweSzGGkNM0Hpd3Z2nXXysiSfYNG
   ehdxfVEkb048BtOwmdRPWt3XeQuVt3V9HXIq40FX7Nn7TT3H8MogXFHTY
   3Z1ZDPSphjrw96tU9G5oDrr8v71bO34kUyAoAW6+R6DaJjqSX+gyDlUKT
   kDNev4mNoRuS4QcHOZdVCURg/4GYceno+ym3oFT8QMHeUhPnBHzXBAF7u
   x0lxMv0WNwAjuPdKH4oXyFOkJbCJ0vb2kzJg9Mk4cMBP8OFuLl0w2kkKp
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10194"; a="299257266"
X-IronPort-AV: E=Sophos;i="5.88,196,1635231600"; 
   d="scan'208";a="299257266"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2021 15:02:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,196,1635231600"; 
   d="scan'208";a="463856193"
Received: from chang-linux-3.sc.intel.com ([172.25.66.175])
  by orsmga006.jf.intel.com with ESMTP; 10 Dec 2021 15:02:22 -0800
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, dave.hansen@linux.intel.com,
        ebiederm@xmission.com, oleg@redhat.com, bp@alien8.de,
        x86@kernel.org, chang.seok.bae@intel.com
Subject: [PATCH v2] signal: Skip the altstack update when not needed
Date:   Fri, 10 Dec 2021 14:55:03 -0800
Message-Id: <20211210225503.12734-1-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

Reported-by: kernel test robot <oliver.sang@intel.com>
[1] https://lore.kernel.org/lkml/20211207012128.GA16074@xsang-OptiPlex-9020/
Fixes: 3aac3ebea08f ("x86/signal: Implement sigaltstack size validation")
Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
---
Changes from v1:
* Rewrite the changelog. (Dave Hansen)
* Add the code comment. (Dave Hansen)
---
 kernel/signal.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/kernel/signal.c b/kernel/signal.c
index a629b11bf3e0..dfcee3888b00 100644
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
-- 
2.17.1

