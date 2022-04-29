Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9381951412A
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 06:04:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236935AbiD2EHb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 00:07:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230133AbiD2EH3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 00:07:29 -0400
Received: from nksmu.kylinos.cn (mailgw.kylinos.cn [123.150.8.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5B3DB9F3F
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 21:04:08 -0700 (PDT)
X-UUID: d2eb80d31af748789493127fc21f493c-20220429
X-UUID: d2eb80d31af748789493127fc21f493c-20220429
Received: from cs2c.com.cn [(172.17.111.24)] by nksmu.kylinos.cn
        (envelope-from <lizhenneng@kylinos.cn>)
        (Generic MTA)
        with ESMTP id 2146502266; Fri, 29 Apr 2022 12:02:33 +0800
X-ns-mid: postfix-626B63B4-5096043818
Received: from localhost.localdomain (unknown [172.20.108.41])
        by cs2c.com.cn (NSMail) with ESMTPA id 40EBE3844000;
        Fri, 29 Apr 2022 04:04:04 +0000 (UTC)
From:   Zhenneng Li <lizhenneng@kylinos.cn>
To:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>
Cc:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Zhenneng Li <lizhenneng@kylinos.cn>
Subject: [PATCH] drm/i915: remove unnecessary spin_lock_irq
Date:   Fri, 29 Apr 2022 12:03:55 +0800
Message-Id: <20220429040355.2644322-1-lizhenneng@kylinos.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        SPF_HELO_NONE,T_SPF_PERMERROR,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This code will not be called by interrupt handler,
so change it to spin_lock.

Signed-off-by: Zhenneng Li <lizhenneng@kylinos.cn>
---
 drivers/gpu/drm/i915/i915_scheduler.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/i915/i915_scheduler.c b/drivers/gpu/drm/i915/i915_scheduler.c
index 762127dd56c5..6615102a1568 100644
--- a/drivers/gpu/drm/i915/i915_scheduler.c
+++ b/drivers/gpu/drm/i915/i915_scheduler.c
@@ -288,9 +288,9 @@ static void __i915_schedule(struct i915_sched_node *node,
 
 void i915_schedule(struct i915_request *rq, const struct i915_sched_attr *attr)
 {
-	spin_lock_irq(&schedule_lock);
+	spin_lock(&schedule_lock);
 	__i915_schedule(&rq->sched, attr);
-	spin_unlock_irq(&schedule_lock);
+	spin_unlock(&schedule_lock);
 }
 
 void i915_sched_node_init(struct i915_sched_node *node)
-- 
2.25.1

