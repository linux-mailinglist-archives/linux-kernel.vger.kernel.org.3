Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92BC747F4D7
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Dec 2021 01:52:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233155AbhLZAwX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Dec 2021 19:52:23 -0500
Received: from mga03.intel.com ([134.134.136.65]:21330 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233146AbhLZAwV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Dec 2021 19:52:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640479941; x=1672015941;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=kfPkIMH7ue+nMTzR4Dl6QOBT9sxSI8f4MNh6jyt9QUo=;
  b=YC1n+U1WHEKl0oNG3inMXjEbG5FTHqB1LIHeG5J+H5kxAJlZhamLt2MX
   mLf4YBeG5MQhJk127RD1dOpXkPWc3dKUjPWWcM1c7QJs0h3cvW1oo8njK
   glmdQxkdziecAwBNId52pJdSqJKkoJJJJ0SFD8UE/y2VrKjLVSX6PLpU5
   9iwwwQ/BGe1uIGglF39bHASZN9FNCarUN/4DOWniYHpQYkI4NOTHMu5sc
   PNRdomztIKCHwjA7uMJc6WrY+ms7vYM5NwgIa98v/7PuKYfm/PpjFt66A
   0wrgwjarNMAqR5F0QtX0rRzy3T8syedzT60AqZDdbUTwFLKznGSlmrZ7/
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10208"; a="241027889"
X-IronPort-AV: E=Sophos;i="5.88,236,1635231600"; 
   d="scan'208";a="241027889"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Dec 2021 16:52:21 -0800
X-IronPort-AV: E=Sophos;i="5.88,236,1635231600"; 
   d="scan'208";a="522863566"
Received: from zoulin-mobl.ccr.corp.intel.com (HELO zq-VirtualBox.gar.corp.intel.com) ([10.215.246.214])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Dec 2021 16:52:15 -0800
From:   Zqiang <qiang1.zhang@intel.com>
To:     elver@google.com, paulmck@kernel.org
Cc:     linux-kernel@vger.kernel.org, qiang1.zhang@intel.com
Subject: [PATCH v2] rcu, kasan: Record work creation stack trace with interrupts enabled
Date:   Sun, 26 Dec 2021 08:52:04 +0800
Message-Id: <20211226005204.6909-1-qiang1.zhang@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Recording the work creation stack trace for KASAN reports in
call_rcu() is expensive, due to unwinding the stack, but also
due to acquiring depot_lock inside stackdepot (which may be contended).
Because calling kasan_record_aux_stack_noalloc() does not require
interrupts to already be disabled, this may unnecessarily extend
the time with interrupts disabled.

Therefore, move calling kasan_record_aux_stack() before the section
with interrupts disabled.

Acked-by: Marco Elver <elver@google.com>
Signed-off-by: Zqiang <qiang1.zhang@intel.com>
---
 v1->v2:
 Make the submitted information clearer.

 kernel/rcu/tree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 9b58bae0527a..36bd3f9e57b3 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -3068,8 +3068,8 @@ void call_rcu(struct rcu_head *head, rcu_callback_t func)
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

