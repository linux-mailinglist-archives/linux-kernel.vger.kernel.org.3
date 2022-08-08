Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A476458C19A
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 04:28:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235747AbiHHC2I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Aug 2022 22:28:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231852AbiHHC1q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Aug 2022 22:27:46 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F362C113C;
        Sun,  7 Aug 2022 19:20:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659925256; x=1691461256;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=DSFtjCvyVuLCouGH3nrkWmxv8xftzPQ8caPWxrxOie0=;
  b=XsXC9nkmNYSfvEPNhcai2gJv+CWIZKLC8geiHxfdoIDg2lv4Ky4R8jfd
   C92PxE4/NI17cgovv6euP4jdGKwND6aeqxuvOguwOrwQuNSCgKGJmV6bO
   TCgliKyb2K3aQmMyL28il7v7IGCCaK9uQemqK/WYFxHVKsOkN4Z9aEIxT
   6MemXxykAyEVPg4PzAuCFqhcv+CtZs3wn4cm41uRi/pZX/A6MTRXYoTRi
   A7Z5sh9wp/Q4UP3pbRidPlf8/ThfsRkaW0GraC2hja+V8dYC7cGvwGFhw
   sJDRXTjHQmUppS0gdmUZf3+9v4sCXsJNVfCakdrVvA+CLxqTuPr588DQM
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10432"; a="290493847"
X-IronPort-AV: E=Sophos;i="5.93,221,1654585200"; 
   d="scan'208";a="290493847"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2022 19:20:56 -0700
X-IronPort-AV: E=Sophos;i="5.93,221,1654585200"; 
   d="scan'208";a="931854925"
Received: from zq-optiplex-7090.bj.intel.com ([10.238.156.125])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2022 19:20:54 -0700
From:   Zqiang <qiang1.zhang@intel.com>
To:     paulmck@kernel.org, frederic@kernel.org, quic_neeraju@quicinc.com
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] rcu: Reduce the frequency of triggering irq-work for strict grace period
Date:   Mon,  8 Aug 2022 10:26:26 +0800
Message-Id: <20220808022626.12825-1-qiang1.zhang@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For kernel built with PREEMPT_RCU=y and RCU_STRICT_GRACE_PERIOD=y,
currently, the irq-work will be triggered by high frequency to make
the scheduler re-evaluate and call hooks to check whether there are
qs need to report when exit RCU read critical section in irq-disbaled
context. however if there is no gp in progress, the irq-work trigger
is meaningless.

This commit reduced irq-work trigger frequency by check whether the
current CPU is not experiencing qs or there is task that blocks
the current grace period for RCU_STRICT_GRACE_PERIOD=y kernel.

The test results are as follows:

echo rcu_preempt_deferred_qs_handler > /sys/kernel/debug/tracing/set_ftrace_filter
echo 1 > /sys/kernel/debug/tracing/function_profile_enabled
insmod rcutorture.ko
sleep 20
rmmod rcutorture.ko
echo 0 > /sys/kernel/debug/tracing/function_profile_enabled
echo > /sys/kernel/debug/tracing/set_ftrace_filter

head /sys/kernel/debug/tracing/trace_stat/function*

original:

==> /sys/kernel/debug/tracing/trace_stat/function0 <==
  Function                               Hit    Time            Avg             s^2
  --------                               ---    ----            ---             ---
  rcu_preempt_deferred_qs_handle      838746    182650.3 us     0.217 us        0.004 us

==> /sys/kernel/debug/tracing/trace_stat/function1 <==
  Function                               Hit    Time            Avg             s^2
  --------                               ---    ----            ---             ---
  rcu_preempt_deferred_qs_handle      841768    191138.6 us     0.227 us        0.024 us

==> /sys/kernel/debug/tracing/trace_stat/function2 <==
  Function                               Hit    Time            Avg             s^2
  --------                               ---    ----            ---             ---
  rcu_preempt_deferred_qs_handle      828243    180455.6 us     0.217 us        0.004 us

==> /sys/kernel/debug/tracing/trace_stat/function3 <==
  Function                               Hit    Time            Avg             s^2
  --------                               ---    ----            ---             ---
  rcu_preempt_deferred_qs_handle      810258    189158.1 us     0.233 us        0.023 us

apply patch:

==> /sys/kernel/debug/tracing/trace_stat/function0 <==
  Function                               Hit    Time            Avg             s^2
  --------                               ---    ----            ---             ---
  rcu_preempt_deferred_qs_handle      302373    67434.95 us     0.223 us        0.001 us

==> /sys/kernel/debug/tracing/trace_stat/function1 <==
  Function                               Hit    Time            Avg             s^2
  --------                               ---    ----            ---             ---
  rcu_preempt_deferred_qs_handle      307174    68398.34 us     0.222 us        0.002 us

==> /sys/kernel/debug/tracing/trace_stat/function2 <==
  Function                               Hit    Time            Avg             s^2
  --------                               ---    ----            ---             ---
  rcu_preempt_deferred_qs_handle      250910    56157.42 us     0.223 us        0.002 us

==> /sys/kernel/debug/tracing/trace_stat/function3 <==
  Function                               Hit    Time            Avg             s^2
  --------                               ---    ----            ---             ---
  rcu_preempt_deferred_qs_handle      279902    62644.64 us     0.223 us        0.003 us

Signed-off-by: Zqiang <qiang1.zhang@intel.com>
---
 kernel/rcu/tree_plugin.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index b76076014e12..1514909cf905 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -641,7 +641,8 @@ static void rcu_read_unlock_special(struct task_struct *t)
 
 		expboost = (t->rcu_blocked_node && READ_ONCE(t->rcu_blocked_node->exp_tasks)) ||
 			   (rdp->grpmask & READ_ONCE(rnp->expmask)) ||
-			   IS_ENABLED(CONFIG_RCU_STRICT_GRACE_PERIOD) ||
+			   (IS_ENABLED(CONFIG_RCU_STRICT_GRACE_PERIOD) &&
+			   ((rdp->grpmask & READ_ONCE(rnp->qsmask)) || t->rcu_blocked_node)) ||
 			   (IS_ENABLED(CONFIG_RCU_BOOST) && irqs_were_disabled &&
 			    t->rcu_blocked_node);
 		// Need to defer quiescent state until everything is enabled.
-- 
2.25.1

