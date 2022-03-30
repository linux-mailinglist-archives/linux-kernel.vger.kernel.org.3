Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01D8E4EBFB1
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 13:19:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343585AbiC3LVc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 07:21:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235372AbiC3LV3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 07:21:29 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AADE109A4A;
        Wed, 30 Mar 2022 04:19:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648639184; x=1680175184;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=hNn5VlT2gG+pVF4p+g9iABCXPtmNiVuS8fWlHnCJL5s=;
  b=G3kgL2k0Gk+C4Zt1XDedP5SqrptKJthosK8psreKas2IfUHA2Odg4jXN
   83HjoySbHB8qZ5owdXSmPuFpxheflLumeOc9fCec8mMoKmirKTTjmt66L
   9FLX9cOqfacLDllNiEdtbghwVrpQjTiapzuwvN2AzC+MjDhJpR05WkEMW
   adsD70/eyv5rBKeWgecTeM/V2h3MvydRMziURWSeIsjmi1w8UfW8QcM/M
   264wcBMBW7imRnQWzb9ySdDtpDkY0ryRObSXG/1XI9Pcm+oGlA9xd28lG
   G6f/zLcU3nLqUUsjp7BaMeHt9n/7ndnesrNjfHcx9Kwy8tKIbxtfxSH7V
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10301"; a="345954414"
X-IronPort-AV: E=Sophos;i="5.90,222,1643702400"; 
   d="scan'208";a="345954414"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2022 04:19:44 -0700
X-IronPort-AV: E=Sophos;i="5.90,222,1643702400"; 
   d="scan'208";a="565495185"
Received: from zq-optiplex-7090.bj.intel.com ([10.238.156.125])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2022 04:19:42 -0700
From:   Zqiang <qiang1.zhang@intel.com>
To:     paulmck@kernel.org, frederic@kernel.org
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] rcu-tasks: Check the atomic variable trc_n_readers_need_end again when wait timeout
Date:   Wed, 30 Mar 2022 19:20:14 +0800
Message-Id: <20220330112014.2587148-1-qiang1.zhang@intel.com>
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

When the trc_wait waitqueue timeout, the atomic variable
trc_n_readers_need_end need to be checked again, perhaps the
conditions have been established at this time, avoid invalid
stall information output.

Signed-off-by: Zqiang <qiang1.zhang@intel.com>
---
 kernel/rcu/tasks.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index 65d6e21a607a..b73a2b362d6b 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -1544,7 +1544,7 @@ static void rcu_tasks_trace_postgp(struct rcu_tasks *rtp)
 				trc_wait,
 				atomic_read(&trc_n_readers_need_end) == 0,
 				READ_ONCE(rcu_task_stall_timeout));
-		if (ret)
+		if (ret || !atomic_read(&trc_n_readers_need_end))
 			break;  // Count reached zero.
 		// Stall warning time, so make a list of the offenders.
 		rcu_read_lock();
-- 
2.25.1

