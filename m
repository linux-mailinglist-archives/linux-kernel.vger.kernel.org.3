Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD39958670F
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 11:47:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230470AbiHAJrQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 05:47:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230461AbiHAJrI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 05:47:08 -0400
Received: from out30-43.freemail.mail.aliyun.com (out30-43.freemail.mail.aliyun.com [115.124.30.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D80F432EF5
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 02:47:05 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=cruzzhao@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0VL4lxRG_1659347212;
Received: from rt2b04371.sqa.tbc.tbsite.net(mailfrom:CruzZhao@linux.alibaba.com fp:SMTPD_---0VL4lxRG_1659347212)
          by smtp.aliyun-inc.com;
          Mon, 01 Aug 2022 17:47:02 +0800
From:   Cruz Zhao <CruzZhao@linux.alibaba.com>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] sched/features: Expand the space of sched features
Date:   Mon,  1 Aug 2022 17:46:51 +0800
Message-Id: <1659347211-81838-1-git-send-email-CruzZhao@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With the increase of sched features, the available space decreases
gradually. In order to prevent features overflow, this patch expands
the space of sched features from 32 to 64.

Signed-off-by: Cruz Zhao <CruzZhao@linux.alibaba.com>
---
 kernel/sched/core.c  | 2 +-
 kernel/sched/sched.h | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 1899990..afe76fb 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -122,7 +122,7 @@
  */
 #define SCHED_FEAT(name, enabled)	\
 	(1UL << __SCHED_FEAT_##name) * enabled |
-const_debug unsigned int sysctl_sched_features =
+const_debug u64 sysctl_sched_features =
 #include "features.h"
 	0;
 #undef SCHED_FEAT
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index a6f071b..ac97f0a 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1999,7 +1999,7 @@ enum {
  * To support run-time toggling of sched features, all the translation units
  * (but core.c) reference the sysctl_sched_features defined in core.c.
  */
-extern const_debug unsigned int sysctl_sched_features;
+extern const_debug u64 sysctl_sched_features;
 
 #ifdef CONFIG_JUMP_LABEL
 #define SCHED_FEAT(name, enabled)					\
@@ -2029,7 +2029,7 @@ enum {
  */
 #define SCHED_FEAT(name, enabled)	\
 	(1UL << __SCHED_FEAT_##name) * enabled |
-static const_debug __maybe_unused unsigned int sysctl_sched_features =
+static const_debug __maybe_unused u64 sysctl_sched_features =
 #include "features.h"
 	0;
 #undef SCHED_FEAT
-- 
1.8.3.1

