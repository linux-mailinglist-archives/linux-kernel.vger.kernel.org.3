Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE0EB585E7D
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jul 2022 12:49:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231417AbiGaKtP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jul 2022 06:49:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbiGaKtN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jul 2022 06:49:13 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E979E9FC8;
        Sun, 31 Jul 2022 03:49:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659264552; x=1690800552;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=lT72Bexrs57W84BZaeIkvJnQF4eTQDr/RDyvUrHL/v4=;
  b=ewe8r6P+gFQNExb8UgYA1tgLQRCcHVGqNVarIwmsWPHo5AZl8itpRxVz
   0kks3fCm0LVmUyLjKA28Gr3iinTMXQrEiH/TJ/ZMrBVdaLgOqIJOpgxo+
   fIF5VK4UgXZ57pqZiKyDPs5jMm6pTmy0W0ynD5L3vNnm9Vu6eHw/wuSGU
   KdZiPn4VohKBU4FoGJFShzkAG3eEP/IIWVZ77fA+QqNKta7s/Ib1ivR6d
   Vihr8Mh/zunDPV8vxC406X3yO8nhg4PiAIWY1Fj2SX6j3AR+NrPGrbrOD
   3rW2fV3fK6zf172ts7yWpXjBQ7cY76Sm/GAif8iliQv+4VNacEA3GY5r5
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10424"; a="375289126"
X-IronPort-AV: E=Sophos;i="5.93,206,1654585200"; 
   d="scan'208";a="375289126"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2022 03:49:12 -0700
X-IronPort-AV: E=Sophos;i="5.93,206,1654585200"; 
   d="scan'208";a="660799595"
Received: from zq-optiplex-7090.bj.intel.com ([10.238.156.125])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2022 03:49:11 -0700
From:   Zqiang <qiang1.zhang@intel.com>
To:     paulmck@kernel.org, frederic@kernel.org, quic_neeraju@quicinc.com
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] rcutorture: Use the barrier operation corresponding to rcutorture.torture_type
Date:   Sun, 31 Jul 2022 18:53:56 +0800
Message-Id: <20220731105356.1741086-1-qiang1.zhang@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

when the rcutorture.torture_type value is 'rcu', this is correct for
invoke rcu_barrier() to wait all in-flight call_rcu() callbacks
(rcu_torture_fwd_cb_cr()) complete in rcutorture_oom_notify(). but when
the rcutorture.torture_type value is 'tasks-tracing', invoke rcu_barrier()
won't wait all in-flight call_rcu_tasks_trace() callbacks complete, the
rcu_barrier_tasks_trace() should be invoked.

This commit fix it by using barrier operation corresponding to
rcutorture.torture_type to wait all in-flight rcu_torture_fwd_cb_cr()
complete.

Signed-off-by: Zqiang <qiang1.zhang@intel.com>
---
 kernel/rcu/rcutorture.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 7f13f2e5ed62..7e7d54841613 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -2638,12 +2638,12 @@ static int rcutorture_oom_notify(struct notifier_block *self,
 	for (i = 0; i < fwd_progress; i++)
 		ncbs += rcu_torture_fwd_prog_cbfree(&rfp[i]);
 	pr_info("%s: Freed %lu RCU callbacks.\n", __func__, ncbs);
-	rcu_barrier();
+	cur_ops->cb_barrier();
 	ncbs = 0;
 	for (i = 0; i < fwd_progress; i++)
 		ncbs += rcu_torture_fwd_prog_cbfree(&rfp[i]);
 	pr_info("%s: Freed %lu RCU callbacks.\n", __func__, ncbs);
-	rcu_barrier();
+	cur_ops->cb_barrier();
 	ncbs = 0;
 	for (i = 0; i < fwd_progress; i++)
 		ncbs += rcu_torture_fwd_prog_cbfree(&rfp[i]);
-- 
2.25.1

