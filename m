Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 910DC5A5E00
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 10:25:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231435AbiH3IZx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 04:25:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230430AbiH3IZv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 04:25:51 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1031253000;
        Tue, 30 Aug 2022 01:25:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661847951; x=1693383951;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=FM2Nw6OVv3oANgo8eVrCve+EM/odlJq6l1r72WRUiCU=;
  b=AMdaVOefmx3cat1jWPp1TxPxt+elMIwRs+K3p5i7rDGxRb7SEDcc4nEt
   996zMz708/UXcjQbAcJetzsFbhCXuTz5J4pidbZniMr3VppKokDRUKaNh
   wbQF9P3UNvY3Ukiv2g6+htqQoOnfzajg1qtPpbIljpBfipaLDxaOFAtwJ
   lI2l44ynQTc3mcN32GDbpSvoEukdLktrog05TYhL+x2yxlAcJC3xjH8gb
   /kNjPP6JI7TmvYKlrgIfgEBG04oaZheZF5OUlZMUbx5De+B/uSbwI7Gav
   zbN14GU6XeAhhF+tOXSDCGD+Fwmk/YkJYLQTeYEfSpe81KB754xqjJYFa
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10454"; a="275517826"
X-IronPort-AV: E=Sophos;i="5.93,274,1654585200"; 
   d="scan'208";a="275517826"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2022 01:25:50 -0700
X-IronPort-AV: E=Sophos;i="5.93,274,1654585200"; 
   d="scan'208";a="672751679"
Received: from zq-optiplex-7090.bj.intel.com ([10.238.156.129])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2022 01:25:49 -0700
From:   Zqiang <qiang1.zhang@intel.com>
To:     paulmck@kernel.org, frederic@kernel.org, quic_neeraju@quicinc.com,
        joel@joelfernandes.org
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] rcu: Remove duplicate RCU exp QS report from rcu_report_dead()
Date:   Tue, 30 Aug 2022 16:31:51 +0800
Message-Id: <20220830083151.396561-1-qiang1.zhang@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For PREEMPT_RCU, the rcu_report_dead() is invoked means that the
outgoing CPU mask is clear from leaf rcu_node and has no further
need of RCU, so invoke rcu_preempt_depth() return value is always
zero in rcu_report_dead(), if the current outgoing CPU rcu_data
structure's cpu_no_qs.b.exp is true, the rcu_preempt_deferred_qs()
will invoke rcu_report_exp_rdp() to report exp QS.

for non-PREEMPT_RCU, the rcu_preempt_deferred_qs() is equivalent to
rcu_report_exp_rdp().

Signed-off-by: Zqiang <qiang1.zhang@intel.com>
---
 kernel/rcu/tree.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 6bb8e72bc815..0ca21ac0f064 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -4276,8 +4276,6 @@ void rcu_report_dead(unsigned int cpu)
 	// Do any dangling deferred wakeups.
 	do_nocb_deferred_wakeup(rdp);
 
-	/* QS for any half-done expedited grace period. */
-	rcu_report_exp_rdp(rdp);
 	rcu_preempt_deferred_qs(current);
 
 	/* Remove outgoing CPU from mask in the leaf rcu_node structure. */
-- 
2.25.1

