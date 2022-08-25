Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 601535A0696
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 03:43:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234312AbiHYBlb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 21:41:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234589AbiHYBki (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 21:40:38 -0400
Received: from mail.nfschina.com (unknown [IPv6:2400:dd01:100f:2:72e2:84ff:fe10:5f45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EA6F19C2CD
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 18:38:09 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by mail.nfschina.com (Postfix) with ESMTP id 611481E80CC4;
        Thu, 25 Aug 2022 09:34:04 +0800 (CST)
X-Virus-Scanned: amavisd-new at test.com
Received: from mail.nfschina.com ([127.0.0.1])
        by localhost (mail.nfschina.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 8hsjB63QpFXJ; Thu, 25 Aug 2022 09:34:01 +0800 (CST)
Received: from localhost.localdomain.localdomain (unknown [219.141.250.2])
        (Authenticated sender: lvqian@nfschina.com)
        by mail.nfschina.com (Postfix) with ESMTPA id 75BBF1E80C99;
        Thu, 25 Aug 2022 09:34:01 +0800 (CST)
From:   Lv qian <lvqian@nfschina.com>
To:     jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
        rodrigo.vivi@intel.com, tvrtko.ursulin@linux.intel.com,
        airlied@linux.ie, daniel@ffwll.ch
Cc:     intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Lv qian <lvqian@nfschina.com>
Subject: [PATCH] drm/i915:Move the code position to reduce the number of judgments
Date:   Thu, 25 Aug 2022 09:37:52 +0800
Message-Id: <20220825013752.120988-1-lvqian@nfschina.com>
X-Mailer: git-send-email 2.18.2
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

	If the kmalloc allocation is successful, the if is judged twice, 
	so I move the second judgment in to the first judgment.

Signed-off-by: Lv qian <lvqian@nfschina.com>
---
 drivers/gpu/drm/i915/i915_gpu_error.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/i915/i915_gpu_error.c b/drivers/gpu/drm/i915/i915_gpu_error.c
index 32e92651ef7c..c8230a8beadb 100644
--- a/drivers/gpu/drm/i915/i915_gpu_error.c
+++ b/drivers/gpu/drm/i915/i915_gpu_error.c
@@ -112,10 +112,10 @@ static bool __i915_error_grow(struct drm_i915_error_state_buf *e, size_t len)
 	if (!e->buf) {
 		e->size = PAGE_ALIGN(len + 1);
 		e->buf = kmalloc(e->size, GFP_KERNEL);
-	}
-	if (!e->buf) {
-		e->err = -ENOMEM;
-		return false;
+		if (!e->buf) {
+			e->err = -ENOMEM;
+			return false;
+		}
 	}
 
 	return true;
-- 
2.18.2

