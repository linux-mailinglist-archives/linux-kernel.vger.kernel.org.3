Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA5D656A84E
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 18:39:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236324AbiGGQhS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 12:37:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236242AbiGGQgv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 12:36:51 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 849F245054
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jul 2022 09:36:50 -0700 (PDT)
Received: from hermes-devbox.fritz.box (82-71-8-225.dsl.in-addr.zen.co.uk [82.71.8.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: bbeckett)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id F023566019DD;
        Thu,  7 Jul 2022 17:36:48 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1657211809;
        bh=yyqoiKo1vjbgBxUDvFfH6fIoAaG7ofkIEVjSYkMkda8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=S2kS6QnGpjD57PEwB480ynQtUoapIaA63cBW9pqtjzasS0yZoA5XCZqnYPaHlY76h
         uaR0jaJN5EjdprHX59F6OWdAqbzfHd3QDwo9NG/ZJrwl2mQbXyORlBe0FrhZ4Be3pv
         4pYgp9uYTKPcZxzviqPTk1v5fMcaK5uvMzaW7OLeRnaruwUgnfeu93UfXk/Ui1qE0e
         Oj25lZnGeO9M6PUaetxA5Vzg0IPPAyBfc3Jbm6DOJAb859iBo7MM7a3dGpHLZ/2Ec3
         f/8iO2d2EIaTmT0IJ+2wN461ZLVLJiO+wS2/ThqxfyjH4ot7YAbnKhUb392VvR1Cfi
         5g8DCk9BWGSAg==
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
Subject: [PATCH v9 09/11] drm/i915/selftest: don't attempt engine reset of guc submission engines
Date:   Thu,  7 Jul 2022 16:36:04 +0000
Message-Id: <20220707163606.1474111-10-bob.beckett@collabora.com>
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

igt_reset_engines_stolen tries to reset engines without checking if it
is possible.
Engines using GuC submission are not able to be reset from the host.

In this scenario, the reset exits early, then on the next iteration of
the each engine loop, the async teardown of the spinner request
context's ring occurs while the next engine is under test.

This is seen as a stolen memory corruption as the ring buffer was busy
initially, but free during the confirmation check and had been poisoned
during cleanup.

Fix this by not testing GuC submission using engines.

Signed-off-by: Robert Beckett <bob.beckett@collabora.com>
---
 drivers/gpu/drm/i915/gt/selftest_reset.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/i915/gt/selftest_reset.c b/drivers/gpu/drm/i915/gt/selftest_reset.c
index 37c38bdd5f47..55f3b34e5f6e 100644
--- a/drivers/gpu/drm/i915/gt/selftest_reset.c
+++ b/drivers/gpu/drm/i915/gt/selftest_reset.c
@@ -194,6 +194,8 @@ static int igt_reset_engines_stolen(void *arg)
 		return 0;
 
 	for_each_engine(engine, gt, id) {
+		if (intel_engine_uses_guc(engine))
+			continue;
 		err = __igt_reset_stolen(gt, engine->mask, engine->name);
 		if (err)
 			return err;
-- 
2.25.1

