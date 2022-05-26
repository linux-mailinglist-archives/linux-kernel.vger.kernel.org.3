Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C22153486E
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 03:55:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345852AbiEZBz1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 21:55:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240584AbiEZBzZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 21:55:25 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DFD8ABF79;
        Wed, 25 May 2022 18:55:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653530124; x=1685066124;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=1pfebO5CWIzGouQot/Szo2SSK2J1j3dTVROMYETyiwQ=;
  b=dAiKp5JhVHCxputtWeQ02yyJbYwp6LTmbdLr4RP7xDchV/dMzs7OyjMr
   SkQMLwYQqo8dZ8tQpErjkqRga2dsENylXUr46r2OlLQDaJw+LmnXTGKx3
   7LjyCK2PWjmdgDsozZWHJBAgPpLbLqlhiZbIBeBmla1UGooD3x+Mv0jI7
   bBZjmomkoyx1kxa3xrnd1fVf9e7CRscGUW6Rjy/z0aKSruNw5cxFc7b/a
   UMV2trXUZYJExU57g1UX1N90S+QBWgOyUnZtqzwXoGX3wl9d1S1Mv1QW1
   mR6pt6xJKb7+ox6vtkIAPc9E2Edv4J7DhhFf7+TIbGpjNuJeOWauFU5pG
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10358"; a="271564491"
X-IronPort-AV: E=Sophos;i="5.91,252,1647327600"; 
   d="scan'208";a="271564491"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2022 18:55:24 -0700
X-IronPort-AV: E=Sophos;i="5.91,252,1647327600"; 
   d="scan'208";a="527137344"
Received: from zq-optiplex-7090.bj.intel.com ([10.238.156.125])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2022 18:55:15 -0700
From:   Zqiang <qiang1.zhang@intel.com>
To:     paulmck@kernel.org, frederic@kernel.org
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] rcu: Cleanup RCU urgency state for offline CPU
Date:   Thu, 26 May 2022 09:55:12 +0800
Message-Id: <20220526015512.2218046-1-qiang1.zhang@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When an RCU grace period starts and at this time the CPU is in
the process of going offline, if the RCU gp-fqs occurs during the
time period when the CPU has passed the stop-machine but has not
yet entered the idle loop, and this CPU have not report quiescent
state yet, its urgent flags maybe is set, for example due to cbovld
is true, but this CPUs rcu urgent flags is not cleanup in rcu_report_dead()
when report qs. however for CPU that have been report qs, its rcu
urgent flags should cleanup, so add rcu_disable_urgency_upon_qs()
in rcu_report_dead() when CPU report qs.

Signed-off-by: Zqiang <qiang1.zhang@intel.com>
---
 kernel/rcu/tree.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 02233b17cce0..6a01a48fe56d 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -4536,6 +4536,7 @@ void rcu_report_dead(unsigned int cpu)
 	rdp->rcu_ofl_gp_flags = READ_ONCE(rcu_state.gp_flags);
 	if (rnp->qsmask & mask) { /* RCU waiting on outgoing CPU? */
 		/* Report quiescent state -before- changing ->qsmaskinitnext! */
+		rcu_disable_urgency_upon_qs(rdp);
 		rcu_report_qs_rnp(mask, rnp, rnp->gp_seq, flags);
 		raw_spin_lock_irqsave_rcu_node(rnp, flags);
 	}
-- 
2.25.1

