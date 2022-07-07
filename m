Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75AA156A84D
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 18:39:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236341AbiGGQhX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 12:37:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236226AbiGGQgv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 12:36:51 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A6B64D159
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jul 2022 09:36:51 -0700 (PDT)
Received: from hermes-devbox.fritz.box (82-71-8-225.dsl.in-addr.zen.co.uk [82.71.8.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: bbeckett)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id A1EFB66019E0;
        Thu,  7 Jul 2022 17:36:49 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1657211810;
        bh=E5T70icBxb2SeJUS5t8AxNkSIQiak1K4e7CDoJQNNIg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DJ1Xc33RVVLPMaQyKloHcfIgoeAAzA02axrrSGTUsok/MCSLamqMJPU6E275N6YPt
         azfSdpX1SPv6NlLq1GkFww2yNIoa90S5yKgc2u2wY0nUxoy/k0FBx2vgG4t6z7qxM9
         HE0Naf9/VimHDTRhIx0Nct+bR876PlsilpZhgj6CR3bPV0ntpWH7UCHzk98wOtLwld
         WvthL4tH0mU3TsPq/siS77c+WqJfN6UDZlOH30E4VwETW/KtEMKdUTeUvaWbMSqx91
         9+zu1IOKTMWAMH0PZEv29Zfb1Xd/WF4+A/T1FmJfKyKUWhJPErvtpjfROq9SBbe3HF
         XdDOtdLyBf0vQ==
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
Subject: [PATCH v9 10/11] drm/i915/selftest: wait for requests during engine reset selftest
Date:   Thu,  7 Jul 2022 16:36:05 +0000
Message-Id: <20220707163606.1474111-11-bob.beckett@collabora.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220707163606.1474111-1-bob.beckett@collabora.com>
References: <20220707163606.1474111-1-bob.beckett@collabora.com>
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
 drivers/gpu/drm/i915/gt/selftest_reset.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/gpu/drm/i915/gt/selftest_reset.c b/drivers/gpu/drm/i915/gt/selftest_reset.c
index 55f3b34e5f6e..52acef647396 100644
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
@@ -77,6 +79,7 @@ __igt_reset_stolen(struct intel_gt *gt,
 			goto err_spin;
 		}
 		i915_request_add(rq);
+		requests[id] = i915_request_get(rq);
 	}
 
 	for (page = 0; page < num_pages; page++) {
@@ -165,6 +168,27 @@ __igt_reset_stolen(struct intel_gt *gt,
 		err = -EINVAL;
 	}
 
+	/* wait for requests and idle, otherwise cleanup can happen on next loop */
+	for (id = 0; id < I915_NUM_ENGINES; id++) {
+		if (!requests[id])
+			continue;
+		err = i915_request_wait(requests[id], I915_WAIT_INTERRUPTIBLE, HZ);
+		if (err < 0) {
+			pr_err("%s failed to wait for rq: %d\n", msg, err);
+			goto err_spin;
+		}
+
+		i915_request_put(requests[id]);
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
 err_spin:
 	igt_spinner_fini(&spin);
 
-- 
2.25.1

