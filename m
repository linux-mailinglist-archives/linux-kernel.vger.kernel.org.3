Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98D2954E289
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 15:54:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377300AbiFPNyH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 09:54:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376717AbiFPNyG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 09:54:06 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFF99344DD;
        Thu, 16 Jun 2022 06:54:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655387645; x=1686923645;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=8DBLbS3wVl/9ObJhboDBWvo7NIEiATgLdaJKo4so8Xc=;
  b=HdRg/IFmDEUntWqG/BMRiMWtKpeR+t91m9KWknExv1oJ91eW9/DcIdRM
   bXwvlaMnhBd0q4x5RlzqPbOHySTLbUz5X5lEdPYfMdZIi1FoCFGjwDSp1
   iCwklxdz/2YhzckOafF3fjTDWjXHYqv5vrj8jw5WWtoET6MVYG8XbCBQx
   g/lWAFZLz/qo2l397h19Y9H3OEp0SVLTCf9nI04sRTZ5L4edh/uwBtEaF
   JpgBU7Tx0ib6YBbTSY0B2cV+PhzME9BqyQ8xFUJ2XHcy/L0oTPX0sS2H5
   pQGruU/me4EFQT5+YwiTLGaJ+znmzK8Dkvb56faiR6n4kKE7gRxdu0fSi
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10379"; a="278048124"
X-IronPort-AV: E=Sophos;i="5.92,305,1650956400"; 
   d="scan'208";a="278048124"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2022 06:54:05 -0700
X-IronPort-AV: E=Sophos;i="5.92,305,1650956400"; 
   d="scan'208";a="641549582"
Received: from zq-optiplex-7090.bj.intel.com ([10.238.156.125])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2022 06:54:04 -0700
From:   Zqiang <qiang1.zhang@intel.com>
To:     paulmck@kernel.org, frederic@kernel.org
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] rcu: Fix rcu_read_unlock_strict() strict QS reporting
Date:   Thu, 16 Jun 2022 21:53:47 +0800
Message-Id: <20220616135347.1351441-1-qiang1.zhang@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When running a kerenl with CONFIG_PREEMPT=n and
CONFIG_RCU_STRICT_GRACE_PERIOD=y, the QS state will be reported
directly after exiting the last level of RCU critical section and
in non irqs-disable context, but maybe the CPU's rcu_data
structure's ->cpu_no_qs.b.norm is not cleared, as a result the
rcu_report_qs_rdp() will exit early, and not report QS state.

This commit will clear CPU's rcu_data structure's ->cpu_no_qs.b.norm
before invoke rcu_report_qs_rdp().

Signed-off-by: Zqiang <qiang1.zhang@intel.com>
---
 kernel/rcu/tree_plugin.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index b2c01919b92c..dc78726b993f 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -824,6 +824,7 @@ void rcu_read_unlock_strict(void)
 	if (irqs_disabled() || preempt_count() || !rcu_state.gp_kthread)
 		return;
 	rdp = this_cpu_ptr(&rcu_data);
+	rdp->cpu_no_qs.b.norm = false;
 	rcu_report_qs_rdp(rdp);
 	udelay(rcu_unlock_delay);
 }
-- 
2.25.1

