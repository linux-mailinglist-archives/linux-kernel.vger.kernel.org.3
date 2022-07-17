Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10CF05776AC
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jul 2022 16:33:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232934AbiGQOdM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Jul 2022 10:33:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbiGQOdK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jul 2022 10:33:10 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40A0D15814;
        Sun, 17 Jul 2022 07:33:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658068389; x=1689604389;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=x3vifSfYKYciuNC9kpnllNYzaEXNsYZUcjc3GTcyvHU=;
  b=eXtUthGx0dAPEO4NxB7aiOWKXAOsfhUh14o/jlQn6QSlv+S5GRRVQDsX
   TYA9y7Q7LOFFl+3qx9FYE9RySsw4SlTZ6CsWfztnU5qa6xKzFnMnq23Tx
   677Vs8m7KaPkuy8SuVw7tES2Jga8oAO5EkCWsAAJ2PY92JhGoiasaiA6s
   QGP8yjicF/4PlGFFoof2nzTYkVcQu6rw/YSpc3Z9rSlSXEviTNV7bH6Re
   1x1iuuS5fUcF4Ug/lHpZYfvrGkI+IcgjSjyBcZGsZ9fmQJKqk36zagB1M
   WZnXzGlYp8THiMz4jXFiiUa+7JoaNBYIgCCMFJgVankAgEhpaW+KziuYz
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10411"; a="265851423"
X-IronPort-AV: E=Sophos;i="5.92,279,1650956400"; 
   d="scan'208";a="265851423"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2022 07:33:08 -0700
X-IronPort-AV: E=Sophos;i="5.92,279,1650956400"; 
   d="scan'208";a="654951133"
Received: from zq-optiplex-7090.bj.intel.com ([10.238.156.125])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2022 07:33:07 -0700
From:   Zqiang <qiang1.zhang@intel.com>
To:     paulmck@kernel.org, frederic@kernel.org, quic_neeraju@quicinc.com,
        joel@joelfernandes.org
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] rcu-tasks: Make RCU Tasks Trace checking for userspace execution
Date:   Sun, 17 Jul 2022 22:38:01 +0800
Message-Id: <20220717143801.189865-1-qiang1.zhang@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For RCU tasks trace, the userspace execution is also a valid quiescent
state, if the task is in userspace, the ->trc_reader_nesting should be
zero and if the ->trc_reader_special.b.need_qs is not set, set the
tasks ->trc_reader_special.b.need_qs is TRC_NEED_QS_CHECKED, this cause
grace-period kthread remove it from holdout list if it remains here.

This commit add rcu_tasks_trace_qs() to rcu_flavor_sched_clock_irq()
when the kernel built with no PREEMPT_RCU.

Signed-off-by: Zqiang <qiang1.zhang@intel.com>
---
 kernel/rcu/tree_plugin.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 4152816dd29f..764cc4db4134 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -976,7 +976,7 @@ static void rcu_flavor_sched_clock_irq(int user)
 		 * neither access nor modify, at least not while the
 		 * corresponding CPU is online.
 		 */
-
+		rcu_tasks_trace_qs(current);
 		rcu_qs();
 	}
 }
-- 
2.25.1

