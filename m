Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6082C57F13E
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jul 2022 22:00:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235117AbiGWUA3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Jul 2022 16:00:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230005AbiGWUAZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jul 2022 16:00:25 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EF1E015707
        for <linux-kernel@vger.kernel.org>; Sat, 23 Jul 2022 13:00:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658606421;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=YO9dcmk0QXd/wQEuwbD9vAV95IqlIKI9spJSz1SGPuU=;
        b=ibRAEwO+4C4xWFuS7ezXjxay1DrrGH3VBf75OUNi8eP180eUCXzBxbzYCjCt2MJLjwksPj
        +oI2kKCSC3H9rCgR8hTnExee+BP0tD9RWoP1lcR8Fec0a/qtOPjeH/rsMm+rswasSOmge6
        fiFlxb1KO7vD0J8N4uvoVehsAbGG/kE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-335-y-FHcB0FM-OKSTN-i7bgAw-1; Sat, 23 Jul 2022 16:00:18 -0400
X-MC-Unique: y-FHcB0FM-OKSTN-i7bgAw-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 19B598037AA;
        Sat, 23 Jul 2022 20:00:18 +0000 (UTC)
Received: from llong.com (unknown [10.22.16.48])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A878F492C3B;
        Sat, 23 Jul 2022 20:00:17 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Len Brown <lenb@kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Waiman Long <longman@redhat.com>
Subject: [PATCH] intel_idle: Fix false positive RCU splats due to incorrect hardirqs state
Date:   Sat, 23 Jul 2022 15:59:32 -0400
Message-Id: <20220723195932.1302575-1-longman@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.10
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 32d4fd5751ea ("cpuidle,intel_idle: Fix CPUIDLE_FLAG_IRQ_ENABLE")
uses raw_local_irq_enable/local_irq_disable() around call to
__intel_idle() in intel_idle_irq().

With interrupt enabled, timer tick interrupt can happen and a
subsequently call to __do_softirq() may change the lockdep hardirqs state
of a debug kernel back to 'on'. This will result in a mismatch between
the cpu hardirqs state (off) and the lockdep hardirqs state (on) causing
a number of false positive "WARNING: suspicious RCU usage" splats.

Fix that by using local_irq_disable() to disable interrupt in
intel_idle_irq().

Fixes: 32d4fd5751ea ("cpuidle,intel_idle: Fix CPUIDLE_FLAG_IRQ_ENABLE")
Signed-off-by: Waiman Long <longman@redhat.com>
---
 drivers/idle/intel_idle.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
index f5c6802aa6c3..907700d1e78e 100644
--- a/drivers/idle/intel_idle.c
+++ b/drivers/idle/intel_idle.c
@@ -162,7 +162,13 @@ static __cpuidle int intel_idle_irq(struct cpuidle_device *dev,
 
 	raw_local_irq_enable();
 	ret = __intel_idle(dev, drv, index);
-	raw_local_irq_disable();
+
+	/*
+	 * The lockdep hardirqs state may be changed to 'on' with timer
+	 * tick interrupt followed by __do_softirq(). Use local_irq_disable()
+	 * to keep the hardirqs state correct.
+	 */
+	local_irq_disable();
 
 	return ret;
 }
-- 
2.31.1

