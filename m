Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59F9A46F776
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 00:32:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234427AbhLIXf3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 18:35:29 -0500
Received: from mga14.intel.com ([192.55.52.115]:48157 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229760AbhLIXf2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 18:35:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639092714; x=1670628714;
  h=from:to:cc:subject:date:message-id;
  bh=gNoCXxW9NByMSJK7ekXm9u+LGKskuB0g5GKnEq/SOC0=;
  b=GM5yW9ZaG8Q2VO8CItZ5HqZQEq/Zqa/atpNS4GE4yV32ozUMyE3xHB+x
   gMJ6LHGu+SID9Jh86vUi54B2tELrikwQgGm+jVnFN0J66S7t51B2MHwOj
   mLSMN9PbGFT5DwCFhUsjK7GaRLRCxIrS3FOvH1sVHwJ7lkVLmc0j9b+0U
   o85tdK+6Zn/va5MMs1xYkWQhEIKIYfyWZNud6k+KQ9G992cm5+PtBI0LL
   A7rmlxVK/6QQSGQ/I2NtFPVch0EyICdIkynHap8ANLK5DT7plLE8wIZqu
   cJgjzJ9SJ4YOWZxiW1sixwe7yb5D1xdjmi6i2uVGba8EfXLfFz3RG8h96
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10193"; a="238452861"
X-IronPort-AV: E=Sophos;i="5.88,193,1635231600"; 
   d="scan'208";a="238452861"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2021 15:31:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,193,1635231600"; 
   d="scan'208";a="503691267"
Received: from chang-linux-3.sc.intel.com ([172.25.66.175])
  by orsmga007.jf.intel.com with ESMTP; 09 Dec 2021 15:31:54 -0800
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, dave.hansen@linux.intel.com,
        ebiederm@xmission.com, oleg@redhat.com, bp@alien8.de,
        x86@kernel.org, chang.seok.bae@intel.com
Subject: [PATCH] signal: Skip the altstack update when not needed
Date:   Thu,  9 Dec 2021 15:24:34 -0800
Message-Id: <20211209232434.3585-1-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

New x86 FPU features require a large signal stack for their large states.
Instead of requiring a large stack for every process, make sure enough
altstack both at sys_sigaltstack() and when enabling the feature in each
process.

The optional size check was added. It helps to reject a too-small altstack
when the large feature is enabled. Also, the architecture code examines
each thread's altstack large enough before enabling the feature.

But threads can be racy without a lock. So, this enforcement mechanism
accompanies a lock to serialize altstack updates and the size check.

On the signal return path, the altstack is restored via do_sigaltstack().
In fact, the threads without altstack ensure it is disabled there. While no
altstack change is needed in this case, this call ends up obtaining the
lock.

When multiple signal returns hit the lock at the same time, this
unnecessarily increases the lock contention.

Add a new check to avoid this. Check if an altstack update is needed. If
not, skip the lock and the update. This may help sys_sigaltstack() in
general. So place it in the function.

Reported-by: kernel test robot <oliver.sang@intel.com>
Fixes: 3aac3ebea08f ("x86/signal: Implement sigaltstack size validation")
Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
---
 kernel/signal.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kernel/signal.c b/kernel/signal.c
index a629b11bf3e0..eeb634f954cd 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -4185,6 +4185,11 @@ do_sigaltstack (const stack_t *ss, stack_t *oss, unsigned long sp,
 				ss_mode != 0))
 			return -EINVAL;
 
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

