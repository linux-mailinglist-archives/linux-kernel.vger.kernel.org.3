Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 730AA4F0809
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Apr 2022 08:15:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349554AbiDCGQH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Apr 2022 02:16:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232663AbiDCGQG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Apr 2022 02:16:06 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BB8BBC03;
        Sat,  2 Apr 2022 23:14:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648966453; x=1680502453;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=HiyotpaX2vP6TLwEpXSXpxsDN8hTJfCPw9+FmUKPPTc=;
  b=Cx+EzT3rVk+j0Ayf3/XZZXwsF1WZq1lPCej3xm7zVg5gD5oBQ2lDPSB9
   ZAA0VoMBkzaM3VIeyoKf+NYpPfhvt0CirQ16Cr2D3y65wFmVqUG3Ybc2d
   +QSa09Oue4siq7AlRpkB8/HlaxEtTogfWtFasuVey8CEKCdn0bRhE+pl8
   4Kot2gFuaXoFnR5wPNwCk/bTh1pc61cXOI/BwiA+05YjBPSsodbrw44XO
   +x5EkkgXU7XFCjTw/IN3WPmJtmgktuVT/TctTVFhXLT+ttuLbKzz1MGVw
   sb6Lau48S8O5c5MJo0MnEpScwQvZRKdbxx7WS5Hp3d7pt9Gy2/Z1hzWXo
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10305"; a="242499780"
X-IronPort-AV: E=Sophos;i="5.90,231,1643702400"; 
   d="scan'208";a="242499780"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2022 23:14:12 -0700
X-IronPort-AV: E=Sophos;i="5.90,231,1643702400"; 
   d="scan'208";a="568744391"
Received: from zq-optiplex-7090.bj.intel.com ([10.238.156.125])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2022 23:14:11 -0700
From:   Zqiang <qiang1.zhang@intel.com>
To:     paulmck@kernel.org, frederic@kernel.org
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] rcu: Use IRQ_WORK_INIT_HARD() to initialize defer_qs_iw on PREEMPT_RT kernel
Date:   Sun,  3 Apr 2022 14:14:40 +0800
Message-Id: <20220403061440.2762522-1-qiang1.zhang@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On non-PREEMPT_RT kernel, the init_irq_work() make the defer_qs_iw irq-work
execute in interrupt context. however, on PREEMPT_RT kernel, the
init_irq_work() make defer_qs_iq irq-work execute in rt-fifo irq_work
kthreads. when system booting, and the CONFIG_RCU_STRICT_GRACE_PERIOD
is enabled, there are a lot of defer_qs_iw irq-work to be processed
in rt-fifo irq_work kthreads, it occupies boot CPU for long time and
cause other kthread cannot get the boot CPU, the boot process occurs
hang. use IRQ_WORK_INIT_HARD() to initialize defer_qs_iw irq-work, can
ensure the defer_qs_iw irq-work always execute in interrupt context,
whether PREEMPT_RT or non PREEMPT_RT kernel.

Signed-off-by: Zqiang <qiang1.zhang@intel.com>
---
 kernel/rcu/tree_plugin.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 3037c2536e1f..cf7bd28af8ef 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -661,7 +661,7 @@ static void rcu_read_unlock_special(struct task_struct *t)
 			    expboost && !rdp->defer_qs_iw_pending && cpu_online(rdp->cpu)) {
 				// Get scheduler to re-evaluate and call hooks.
 				// If !IRQ_WORK, FQS scan will eventually IPI.
-				init_irq_work(&rdp->defer_qs_iw, rcu_preempt_deferred_qs_handler);
+				rdp->defer_qs_iw = IRQ_WORK_INIT_HARD(rcu_preempt_deferred_qs_handler);
 				rdp->defer_qs_iw_pending = true;
 				irq_work_queue_on(&rdp->defer_qs_iw, rdp->cpu);
 			}
-- 
2.25.1

