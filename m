Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8F1847CDAF
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 08:54:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243077AbhLVHyM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 02:54:12 -0500
Received: from mga07.intel.com ([134.134.136.100]:9854 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231422AbhLVHyL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 02:54:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640159651; x=1671695651;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=dBSOo+YJyS2n99i1BZV8d32xM02qox78iHX+isbPq18=;
  b=QVXqBmoIAem5xnsPrvvpm1YkTQ6TG2rrR2Jqs9tgoGvkt+IqXQgPIXG8
   2tbzA1cHYN/QGsssJGvttaQS01iSof6+SpbNlxSmETE3os/3JT946ZYm7
   5C7gOAdspInZAlzZ93X4hXrR+3AgxAEilkWOOQMcBwlCE6GB6GXXsdgWT
   6l9vejUGMO0eAWk/TPZFwsdk/gMHBW5cpWuP6opoahB3T36bEk8z2lJ6k
   k8v00xkPzQSJTHji9LqqrCB/ScDPpbxOcIsHv3cRABitFxUidgAwDZD3I
   UztpOtJIkCjAa7CjaPQSHctnL+MBu1cqKnOQAL9zFJ8oc8pwmEi1flCOt
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10205"; a="303939544"
X-IronPort-AV: E=Sophos;i="5.88,225,1635231600"; 
   d="scan'208";a="303939544"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2021 23:54:11 -0800
X-IronPort-AV: E=Sophos;i="5.88,225,1635231600"; 
   d="scan'208";a="521579421"
Received: from unknown (HELO zq-VirtualBox.bj.intel.com) ([10.238.129.32])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2021 23:54:09 -0800
From:   Zqiang <qiang1.zhang@intel.com>
To:     paulmck@kernel.org, ryabinin.a.a@gmail.com
Cc:     urezki@gmail.com, elver@google.com, jun.miao@intel.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH] rcu: record kasan stack before enter local_irq_save()/restore() critical area
Date:   Wed, 22 Dec 2021 15:54:06 +0800
Message-Id: <20211222075406.57191-1-qiang1.zhang@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The kasan_record_aux_stack_noalloc() only record stack, it doesn't need
to be called in local_irq_save()/restore() critical area, and the global
spinlock (depot_lock) will be acquired in this function, When enable
kasan stack, locking contention may increase the time in the critical area.

Signed-off-by: Zqiang <qiang1.zhang@intel.com>
---
 kernel/rcu/tree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 347dae1876a6..5198e44cb124 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -3030,8 +3030,8 @@ __call_rcu(struct rcu_head *head, rcu_callback_t func)
 	}
 	head->func = func;
 	head->next = NULL;
-	local_irq_save(flags);
 	kasan_record_aux_stack_noalloc(head);
+	local_irq_save(flags);
 	rdp = this_cpu_ptr(&rcu_data);
 
 	/* Add the callback to our list. */
-- 
2.25.1

