Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD4FE56AC6C
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 22:05:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236726AbiGGUDQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 16:03:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236827AbiGGUCw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 16:02:52 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07D7B20BEA
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jul 2022 13:02:51 -0700 (PDT)
Received: from hermes-devbox.fritz.box (82-71-8-225.dsl.in-addr.zen.co.uk [82.71.8.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: bbeckett)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id A131D66019EE;
        Thu,  7 Jul 2022 21:02:49 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1657224169;
        bh=4Q2MmpoHgvo6IqR+FhRTJWk4TRp24CULBaAdeSzO30A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JcQ8SBZEpPP8EVYE51rSwLw651bQzWdQSRRUwK1M4rWQYn5HR8crPwf6o8cKWODl0
         DbR1AXNNhzUfA5JTgnIiRB36fje01CdfpOXc0UKLYFI0VOVJJZiDRqrnfPKDqDNW5s
         EC+Y6vaNL2T15/5SglZMBCePcuWrgjqmYRlzWOQ5bMEeo15W1EE6f4boLQh1nPFB98
         lj0gphq9lFYno2gjqGknMcPlsFBzgTbUp20r6OeN0TxIDVn+6/ipjGXVly5b7g8BsP
         TldLyJXAQZiExu1gXaj0VUa/JhQM6r3k8mlRBls158d/E1fsqNdIF+g9iA2fyi+DD6
         3Z2HFxjwCl8dA==
From:   Robert Beckett <bob.beckett@collabora.com>
To:     dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     kernel@collabora.com, Robert Beckett <bob.beckett@collabora.com>,
        Matthew Auld <matthew.auld@intel.com>,
        =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= 
        <thomas.hellstrom@linux.intel.com>, linux-kernel@vger.kernel.org
Subject: [PATCH v10 10/11] drm/i915/selftest: wait for requests during engine reset selftest
Date:   Thu,  7 Jul 2022 20:02:28 +0000
Message-Id: <20220707200230.1657555-11-bob.beckett@collabora.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220707200230.1657555-1-bob.beckett@collabora.com>
References: <20220707200230.1657555-1-bob.beckett@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While looping around each engine and testing for corrupted solen memory
during engine reset, the old requests from the previous engine can still
be yet to retire.
To prevent false positive corruption tests, wait for the outstanding
requests at the end of the test

Signed-off-by: Robert Beckett <bob.beckett@collabora.com>
---
 drivers/gpu/drm/i915/gt/selftest_reset.c | 35 ++++++++++++++++++++++--
 1 file changed, 33 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/i915/gt/selftest_reset.c b/drivers/gpu/drm/i915/gt/selftest_reset.c
index 55f3b34e5f6e..a2558bc31408 100644
--- a/drivers/gpu/drm/i915/gt/selftest_reset.c
+++ b/drivers/gpu/drm/i915/gt/selftest_reset.c
@@ -6,6 +6,7 @@
 #include <linux/crc32.h>
 
 #include "gem/i915_gem_stolen.h"
+#include "gt/intel_gt.h"
 
 #include "i915_memcpy.h"
 #include "i915_selftest.h"
@@ -26,6 +27,7 @@ __igt_reset_stolen(struct intel_gt *gt,
 	intel_wakeref_t wakeref;
 	enum intel_engine_id id;
 	struct igt_spinner spin;
+	struct i915_request *requests[I915_NUM_ENGINES] = {0};
 	long max, count;
 	void *tmp;
 	u32 *crc;
@@ -68,15 +70,16 @@ __igt_reset_stolen(struct intel_gt *gt,
 		ce = intel_context_create(engine);
 		if (IS_ERR(ce)) {
 			err = PTR_ERR(ce);
-			goto err_spin;
+			goto err_requests;
 		}
 		rq = igt_spinner_create_request(&spin, ce, MI_ARB_CHECK);
 		intel_context_put(ce);
 		if (IS_ERR(rq)) {
 			err = PTR_ERR(rq);
-			goto err_spin;
+			goto err_requests;
 		}
 		i915_request_add(rq);
+		requests[id] = i915_request_get(rq);
 	}
 
 	for (page = 0; page < num_pages; page++) {
@@ -165,6 +168,34 @@ __igt_reset_stolen(struct intel_gt *gt,
 		err = -EINVAL;
 	}
 
+	/* wait for requests and idle, otherwise cleanup can happen on next loop */
+	for (id = 0; id < I915_NUM_ENGINES; id++) {
+		if (!requests[id])
+			continue;
+		err = i915_request_wait(requests[id], I915_WAIT_INTERRUPTIBLE, HZ);
+		if (err < 0) {
+			pr_err("%s failed to wait for rq: %d\n", msg, err);
+			goto err_requests;
+		}
+
+		i915_request_put(requests[id]);
+		requests[id] = NULL;
+	}
+
+	err = intel_gt_wait_for_idle(gt, HZ);
+	if (err < 0) {
+		pr_err("%s failed to wait for gt idle: %d\n", msg, err);
+		goto err_spin;
+	}
+
+	err = 0;
+
+err_requests:
+	for (id = 0; id < I915_NUM_ENGINES; id++) {
+		if (!requests[id])
+			continue;
+		i915_request_put(requests[id]);
+	}
 err_spin:
 	igt_spinner_fini(&spin);
 
-- 
2.25.1

