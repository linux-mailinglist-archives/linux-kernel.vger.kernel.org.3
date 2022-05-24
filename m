Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CDAC531FE5
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 02:35:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232300AbiEXAfK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 20:35:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232224AbiEXAfB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 20:35:01 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1D249C2D4;
        Mon, 23 May 2022 17:35:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653352500; x=1684888500;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Uuq/o6+TsTmTxh6cE4BlifTTgnKV8Ddm8hawFfo0q0A=;
  b=i16+2PcYQlPRALd/EPJ3H4pJLACcur6s/vAmKJgnDvedON+hChBhENJj
   5e6RdDivlw0SmLEzCDnlj4BzdDRGT100LHJO3eAa/XaqrbygTL5ZLNJEv
   s15jpNd35sxvJA04MRJN6PU6DE55CoH2bv7mYKKxh1Og4ehK0nKaBSclY
   7I5VCtK00bZaDoEt7DSKlP0lOloKtmIYcHz+clwxok9Na0Sasy0+owCoQ
   VluxF6y8G6YZCH3ccEDsBuISz7Tkz+baqLy9+ZmJgZeCkxMHyWidY57zv
   gnUCHt77Xwe4SikStmUi0Rlzema5fJ0d8+I2UgVEjsHQVjguU4he0bGaZ
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10356"; a="273509534"
X-IronPort-AV: E=Sophos;i="5.91,247,1647327600"; 
   d="scan'208";a="273509534"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2022 17:35:00 -0700
X-IronPort-AV: E=Sophos;i="5.91,247,1647327600"; 
   d="scan'208";a="600952750"
Received: from zq-optiplex-7090.bj.intel.com ([10.238.156.125])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2022 17:34:59 -0700
From:   Zqiang <qiang1.zhang@intel.com>
To:     paulmck@kernel.org, frederic@kernel.org
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/2] rcu-tasks: Remove is_idle_task() from warnings in check_holdout_task()
Date:   Tue, 24 May 2022 08:34:54 +0800
Message-Id: <20220524003454.1887414-3-qiang1.zhang@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220524003454.1887414-1-qiang1.zhang@intel.com>
References: <20220524003454.1887414-1-qiang1.zhang@intel.com>
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

Due to the rcu_tasks_pertask() already exclude idle tasks, the idle tasks
not appear in holdout list. so It is not necessary to judge whether the
tasks in the holdout list are idle tasks.

Signed-off-by: Zqiang <qiang1.zhang@intel.com>
---
 kernel/rcu/tasks.h | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index a28337f280e4..6a2598efd0cc 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -862,9 +862,8 @@ static void check_holdout_task(struct task_struct *t,
 		*firstreport = false;
 	}
 	cpu = task_cpu(t);
-	pr_alert("%p: %c%c nvcsw: %lu/%lu holdout: %d idle_cpu: %d/%d\n",
-		 t, ".I"[is_idle_task(t)],
-		 "N."[cpu < 0 || !tick_nohz_full_cpu(cpu)],
+	pr_alert("%p: %c nvcsw: %lu/%lu holdout: %d idle_cpu: %d/%d\n",
+		 t, "N."[cpu < 0 || !tick_nohz_full_cpu(cpu)],
 		 t->rcu_tasks_nvcsw, t->nvcsw, t->rcu_tasks_holdout,
 		 t->rcu_tasks_idle_cpu, cpu);
 	sched_show_task(t);
-- 
2.25.1

