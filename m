Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51AE352F967
	for <lists+linux-kernel@lfdr.de>; Sat, 21 May 2022 08:56:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240171AbiEUG4e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 May 2022 02:56:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229939AbiEUG4a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 May 2022 02:56:30 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7177C5DBFB;
        Fri, 20 May 2022 23:56:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653116187; x=1684652187;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=3JboGVIBiDz+7ckicjuLV5se6lRR3eFp6LO8B17IW64=;
  b=B7LGjbYurUbFTv4raVm9G4nsTk/uDhN3VhRGFnRF5GhnyWuFduItLJBP
   8q+74cNauOjVEKivAGr0bhwVIuddOLsq0d7S7vjJBHwdQyVtuAyR1czHQ
   eDoXuYquJAvl09r10zumzU9FAa/XTgqGKOynIpU9vs4C/QgQJrExEWi2j
   V4g1kmzHpHJHGXCVXVXWLvunORs70C4845S9cAq2iteNdLDP3dmfpLgsm
   qwTs27yhGDhp8hZ1h9LaD6m0FTT1HQySXu56f0IgCbb3W7RFBBKyix+eY
   JhLBPkY52Z0RJcZ3RddqTKvPAiPFkrCnN+YREAkwIcSCwAuNs+3yhxrWO
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10353"; a="253332285"
X-IronPort-AV: E=Sophos;i="5.91,240,1647327600"; 
   d="scan'208";a="253332285"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2022 23:56:27 -0700
X-IronPort-AV: E=Sophos;i="5.91,240,1647327600"; 
   d="scan'208";a="743823241"
Received: from zq-optiplex-7090.bj.intel.com ([10.238.156.125])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2022 23:56:25 -0700
From:   Zqiang <qiang1.zhang@intel.com>
To:     paulmck@kernel.org, frederic@kernel.org
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] rcu/rcuscale: Fix using smp_processor_id() in preemptible warnings
Date:   Sat, 21 May 2022 14:56:26 +0800
Message-Id: <20220521065626.1815175-1-qiang1.zhang@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

BUG: using smp_processor_id() in preemptible [00000000] code: rcu_scale_write/69
CPU: 0 PID: 66 Comm: rcu_scale_write Not tainted 5.18.0-rc7-next-20220517-yoctodev-standard+
caller is debug_smp_processor_id+0x17/0x20
Call Trace:
<TASK>
dump_stack_lvl+0x49/0x5e
dump_stack+0x10/0x12
check_preemption_disabled+0xdf/0xf0
debug_smp_processor_id+0x17/0x20
rcu_scale_writer+0x2b5/0x580
kthread+0x177/0x1b0
ret_from_fork+0x22/0x30
</TASK>

Reproduction method:
runqemu kvm slirp nographic qemuparams="-m 4096 -smp 8" bootparams="isolcpus=2,3
nohz_full=2,3 rcu_nocbs=2,3 rcutree.dump_tree=1 rcuscale.shutdown=false
rcuscale.gp_async=true" -d

when the CONFIG_DEBUG_PREEMPT is enabled, this_cpu_ptr() will call
debug_smp_processor_id() get current CPU number, this warning is triggered by
is_percpu_thread() in debug_smp_processor_id(), the is_percpu_thread() need to
check whether 'current->nr_cpus_allowed  == 1' and 'current->flags & PF_NO_SETAFFINITY',
invoke set_cpus_allowed_ptr() only set kthreads->nr_cpus_allowed, but the
PF_NO_SETAFFINITY is not set to kthread->flags, so add PF_NO_SETAFFINITY flags
setting.

Signed-off-by: Zqiang <qiang1.zhang@intel.com>
---
 kernel/rcu/rcuscale.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/rcu/rcuscale.c b/kernel/rcu/rcuscale.c
index 277a5bfb37d4..3ef02d4a8108 100644
--- a/kernel/rcu/rcuscale.c
+++ b/kernel/rcu/rcuscale.c
@@ -419,6 +419,7 @@ rcu_scale_writer(void *arg)
 	VERBOSE_SCALEOUT_STRING("rcu_scale_writer task started");
 	WARN_ON(!wdpp);
 	set_cpus_allowed_ptr(current, cpumask_of(me % nr_cpu_ids));
+	current->flags |= PF_NO_SETAFFINITY;
 	sched_set_fifo_low(current);
 
 	if (holdoff)
-- 
2.25.1

