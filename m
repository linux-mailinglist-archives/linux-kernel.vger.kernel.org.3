Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCC9151C476
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 18:01:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381535AbiEEQDS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 12:03:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239474AbiEEQDQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 12:03:16 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2A28515A3;
        Thu,  5 May 2022 08:59:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651766377; x=1683302377;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=4xPb5hYDEuqAvEmIzib3MGbfqSg4B/cO3p6boPn/ylU=;
  b=BqTAWosly3ieVB3EZ002q1J4C6FzRvEhir7aYD3yAz0ULz7ABCIUvE2K
   gPoHyCMbH46bfeCHIJ2IIYI9Rww/tkEkLM2BxtnahN95GJTNgRiEpc1bA
   aCX3YIUZiTRd9OkD6B7EL6NbahdpEMmTJSUJ10IX4e9yyej54zvTITZK6
   bRh6Uvi5iVdA/FzIuvCjIS7ODRxKJH97RGyD0z+ekqEVp/oQIoD5Fwt+P
   YN2SPXyTu3tNNekoZWHMwYxDpvndODyT1VXixRPqBSw1Sfd8wXD94GZ/K
   4D+2hguwzUuJCZLhwRGunUT83PEV44jKg/PunNEhpj7pZ+c125e1izWDw
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10338"; a="267756537"
X-IronPort-AV: E=Sophos;i="5.91,201,1647327600"; 
   d="scan'208";a="267756537"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2022 08:52:27 -0700
X-IronPort-AV: E=Sophos;i="5.91,201,1647327600"; 
   d="scan'208";a="585394297"
Received: from zq-optiplex-7090.bj.intel.com ([10.238.156.125])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2022 08:52:26 -0700
From:   Zqiang <qiang1.zhang@intel.com>
To:     paulmck@kernel.org, frederic@kernel.org
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] rcu: Add rnp->cbovldmask check in rcutree_migrate_callbacks()
Date:   Thu,  5 May 2022 23:52:36 +0800
Message-Id: <20220505155236.1559619-1-qiang1.zhang@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, the rnp's cbovlmask is set in call_rcu(). when CPU going
offline, the outgoing CPU's callbacks is migrated to target CPU, the
number of callbacks on the my_rdp may be overloaded, if overload and
there is no call_rcu() call on target CPU for a long time, the rnp's
cbovldmask is not set in time. in order to fix this situation, add
check_cb_ovld_locked() in rcutree_migrate_callbacks() to help CPU more
quickly reach quiescent states.

Signed-off-by: Zqiang <qiang1.zhang@intel.com>
---
 kernel/rcu/tree.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 9dc4c4e82db6..bcc5876c9753 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -4577,6 +4577,7 @@ void rcutree_migrate_callbacks(int cpu)
 	needwake = needwake || rcu_advance_cbs(my_rnp, my_rdp);
 	rcu_segcblist_disable(&rdp->cblist);
 	WARN_ON_ONCE(rcu_segcblist_empty(&my_rdp->cblist) != !rcu_segcblist_n_cbs(&my_rdp->cblist));
+	check_cb_ovld_locked(my_rdp, my_rnp);
 	if (rcu_rdp_is_offloaded(my_rdp)) {
 		raw_spin_unlock_rcu_node(my_rnp); /* irqs remain disabled. */
 		__call_rcu_nocb_wake(my_rdp, true, flags);
-- 
2.25.1

