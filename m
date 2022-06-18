Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA0065501F7
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Jun 2022 04:23:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238001AbiFRCXS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 22:23:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbiFRCXR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 22:23:17 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BADA4DF73;
        Fri, 17 Jun 2022 19:23:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655518995; x=1687054995;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Vw65PlxxPIXKSdQhfZecw4qu+4AdMh2WHr1f09bz/k8=;
  b=iULMVlFXbq0a2kqwviDbaKQ+xp6xhKedcolfeoQtH8Pa4PLeZtRe653g
   MDmCQhZiJiWsHrgbSqJaJkPW+pVsXRz8z3NNro3R2D5grZG+FTB3AFdhg
   xv4BsIMg+4XYcXDu0TmTo80/YiU3RrExy58SmdpcBVobUB2q0ZTb/1tj5
   PtMRQvhLmygK23aZAkQJHBhwEGuI6JqAtPkjundresR+Q+gaIgHIKqWNy
   kk+TJzy1snwmZZyskTuw/sZk5TrRbJNzX/o7E8me+YlNmmlpyoTd8cZHO
   qVbVTFEDDBctJYQVWeMaABb3fbxYWDaXDMEOUH5HqNJpnHxlVTJIy5Ju4
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10380"; a="262662854"
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="262662854"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2022 19:23:14 -0700
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="642268395"
Received: from zq-optiplex-7090.bj.intel.com ([10.238.156.125])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2022 19:23:13 -0700
From:   Zqiang <qiang1.zhang@intel.com>
To:     paulmck@kernel.org, frederic@kernel.org
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] rcu: Avoid strict QS reporting in NMI context
Date:   Sat, 18 Jun 2022 10:22:55 +0800
Message-Id: <20220618022255.1697816-1-qiang1.zhang@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Avoid invoke rcu_report_qs_rdp() in NMI handlers, in NMI handlers,
acquiring raw_spinlocks should be avoided, prevent NMI handlers
from blocking(spin) unnecessarily.

This commit make rcu_read_unlock_strict() early return when in
NMI context.

Signed-off-by: Zqiang <qiang1.zhang@intel.com>
---
 kernel/rcu/tree_plugin.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index dc78726b993f..e7a36e248a8a 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -821,7 +821,7 @@ void rcu_read_unlock_strict(void)
 {
 	struct rcu_data *rdp;
 
-	if (irqs_disabled() || preempt_count() || !rcu_state.gp_kthread)
+	if (in_nmi() || irqs_disabled() || preempt_count() || !rcu_state.gp_kthread)
 		return;
 	rdp = this_cpu_ptr(&rcu_data);
 	rdp->cpu_no_qs.b.norm = false;
-- 
2.25.1

