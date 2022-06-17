Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D47654FB79
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 18:51:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383395AbiFQQub (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 12:50:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382246AbiFQQuP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 12:50:15 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E95F5402F;
        Fri, 17 Jun 2022 09:49:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655484574; x=1687020574;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=txJBSEOHEOVo7LI9mqLJJ279WhRXUuWnU6vzP4vmFlQ=;
  b=FQnkOUBRAENKxpXUgGpITPPQsarABb/nDuAZzbRCxFz7EQqT9K05uDXD
   C767efuPTLVs+DfHzKGLgmb91gI3vwDUHrBCKnNidlG6Y2Duojgbzy4+U
   PsXzOuJiepb3YvNANSYyEZO4DwTPt4JqXP025MSWGLDbKyxs3Qv+MXN9v
   AYtMZQrXVvdkSbYVQCG7A2LO1uW+xrqI2MO5N8IoVEcqQxEjfRD9HErjJ
   /zS+eEXkiWWBqz2WU3vyYpUb5ISEqI3OVb7K7GfnfLuxdi09stEzCBHrS
   WHGI7daKyvT4uzm01wkrvQJUL3fguVdxY+6qRDv0wR8ssi6NiUdhw6XBX
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10380"; a="277056288"
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="277056288"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2022 07:15:37 -0700
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="642045257"
Received: from zq-optiplex-7090.bj.intel.com ([10.238.156.125])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2022 07:15:36 -0700
From:   Zqiang <qiang1.zhang@intel.com>
To:     paulmck@kernel.org, frederic@kernel.org
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] rcu/nocb: Correct output rcuog/rcuop kthreads information
Date:   Fri, 17 Jun 2022 22:15:19 +0800
Message-Id: <20220617141519.1677119-1-qiang1.zhang@intel.com>
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

This commit make rcuog and rcuop thread information output
in the correct location.

Signed-off-by: Zqiang <qiang1.zhang@intel.com>
---
 v1->v2:
 Only change commit information, the v1 is
 [PATCH] rcu: Fix incorrect judgment condition in show_rcu_nocb_state(). 

 kernel/rcu/tree_nocb.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
index a8f574d8850d..f20aec4f4394 100644
--- a/kernel/rcu/tree_nocb.h
+++ b/kernel/rcu/tree_nocb.h
@@ -1452,8 +1452,8 @@ static void show_rcu_nocb_gp_state(struct rcu_data *rdp)
 		(long)rdp->nocb_gp_seq,
 		rnp->grplo, rnp->grphi, READ_ONCE(rdp->nocb_gp_loops),
 		rdp->nocb_gp_kthread ? task_state_to_char(rdp->nocb_gp_kthread) : '.',
-		rdp->nocb_cb_kthread ? (int)task_cpu(rdp->nocb_gp_kthread) : -1,
-		show_rcu_should_be_on_cpu(rdp->nocb_cb_kthread));
+		rdp->nocb_gp_kthread ? (int)task_cpu(rdp->nocb_gp_kthread) : -1,
+		show_rcu_should_be_on_cpu(rdp->nocb_gp_kthread));
 }
 
 /* Dump out nocb kthread state for the specified rcu_data structure. */
@@ -1497,7 +1497,7 @@ static void show_rcu_nocb_state(struct rcu_data *rdp)
 		".B"[!!rcu_cblist_n_cbs(&rdp->nocb_bypass)],
 		rcu_segcblist_n_cbs(&rdp->cblist),
 		rdp->nocb_cb_kthread ? task_state_to_char(rdp->nocb_cb_kthread) : '.',
-		rdp->nocb_cb_kthread ? (int)task_cpu(rdp->nocb_gp_kthread) : -1,
+		rdp->nocb_cb_kthread ? (int)task_cpu(rdp->nocb_cb_kthread) : -1,
 		show_rcu_should_be_on_cpu(rdp->nocb_cb_kthread));
 
 	/* It is OK for GP kthreads to have GP state. */
-- 
2.25.1

