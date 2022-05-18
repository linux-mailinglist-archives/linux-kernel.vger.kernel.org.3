Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D58A52B906
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 13:45:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235739AbiERLnR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 07:43:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235762AbiERLnL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 07:43:11 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3FF32B1BC;
        Wed, 18 May 2022 04:43:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652874189; x=1684410189;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=tw6Z4f9Bhax1c/2buQLmzsM9gge//sdJmnyXlU32Rlc=;
  b=eJQ4XPZTsxO31SOu3CgTf0SfECcc/z4uOMlHSfwXEMihacHB2ZRa0Bnt
   e/Gqt0EqxjbiE472AUwTMDxungnabNqFGMm5VOk78GIm3bIJgPupwL5+9
   Qb0Xgri5rvLGyynGh0mAJhn4X0QsOQLfSnMc646emdTj/qD3j3J/tiibK
   NWGm80XKFNfPj1NvaTKI/41nkeptpIGLNS7KcAvodL2ldyXP6OZr+j/PW
   1wLUr/6IpQ3Ibiv6EvZqSPotK9VvJDThgWaG8Lu/zY4gOQtNOjAbUt48W
   J9DcERwFF+FhGzj3/0eTzfy2cuy7lNfwhs9Le3RjfKd561i4eJ3f9mYYl
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10350"; a="358038747"
X-IronPort-AV: E=Sophos;i="5.91,234,1647327600"; 
   d="scan'208";a="358038747"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2022 04:43:09 -0700
X-IronPort-AV: E=Sophos;i="5.91,234,1647327600"; 
   d="scan'208";a="597743292"
Received: from zq-optiplex-7090.bj.intel.com ([10.238.156.125])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2022 04:43:07 -0700
From:   Zqiang <qiang1.zhang@intel.com>
To:     paulmck@kernel.org, frederic@kernel.org
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] rcu: Add cpu-exp indicator to expedited RCU CPU stall warnings
Date:   Wed, 18 May 2022 19:43:10 +0800
Message-Id: <20220518114310.1478091-1-qiang1.zhang@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit adds a "D" indicator to expedited RCU CPU stall warnings.
when an expedited grace period begins, due to CPU disable interrupt
time too long, cause the IPI(rcu_exp_handler()) unable to respond in
time, this debugging id will be showed.

runqemu kvm slirp nographic qemuparams="-m 4096 -smp 4"  bootparams=
"isolcpus=2,3 nohz_full=2,3 rcu_nocbs=2,3 rcutree.dump_tree=1
rcutorture.stall_cpu_holdoff=30 rcutorture.stall_cpu=40
rcutorture.stall_cpu_irqsoff=1 rcutorture.stall_cpu_block=0
rcutorture.stall_no_softlockup=1" -d

rcu_torture_stall start on CPU 1.
............
rcu: INFO: rcu_preempt detected expedited stalls on CPUs/tasks:
{ 1-...D } 26467 jiffies s: 13317 root: 0x1/.
rcu: blocking rcu_node structures (internal RCU debug): l=1:0-1:0x2/.
Task dump for CPU 1:
task:rcu_torture_sta state:R  running task     stack:    0 pid:   76
ppid:     2 flags:0x00004008

Signed-off-by: Zqiang <qiang1.zhang@intel.com>
---
 kernel/rcu/tree_exp.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
index 4c7037b50703..f092c7f18a5f 100644
--- a/kernel/rcu/tree_exp.h
+++ b/kernel/rcu/tree_exp.h
@@ -637,10 +637,11 @@ static void synchronize_rcu_expedited_wait(void)
 					continue;
 				ndetected++;
 				rdp = per_cpu_ptr(&rcu_data, cpu);
-				pr_cont(" %d-%c%c%c", cpu,
+				pr_cont(" %d-%c%c%c%c", cpu,
 					"O."[!!cpu_online(cpu)],
 					"o."[!!(rdp->grpmask & rnp->expmaskinit)],
-					"N."[!!(rdp->grpmask & rnp->expmaskinitnext)]);
+					"N."[!!(rdp->grpmask & rnp->expmaskinitnext)],
+					"D."[!!(rdp->cpu_no_qs.b.exp)]);
 			}
 		}
 		pr_cont(" } %lu jiffies s: %lu root: %#lx/%c\n",
-- 
2.25.1

