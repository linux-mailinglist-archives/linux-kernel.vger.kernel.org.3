Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA264595823
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 12:27:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234567AbiHPK1N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 06:27:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234557AbiHPK0g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 06:26:36 -0400
X-Greylist: delayed 610 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 16 Aug 2022 02:35:42 PDT
Received: from mx.swemel.ru (mx.swemel.ru [95.143.211.150])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FDEB79607
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 02:35:40 -0700 (PDT)
From:   Denis Arefev <arefev@swemel.ru>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=swemel.ru; s=mail;
        t=1660641925;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=4pN/HWYNP5Og6NT88D8bQhfdAYmJL0p3JtbVeMHSDU4=;
        b=Ivk+0ti/i5rbLhfDR13Gj4UMSC2U3igGCdFugoWc8EPkhACXCtRR4JODk28pbDVJpywEis
        2VtcV3npfjFwQo2yL/1PYuvYlF0MW/6vgEXe5i5n59RgkAKPpwI1iNZPH2OvyNjjgOsJ3/
        SU+u5ghxEgNErrG6VQphdU8tEUZFgc8=
To:     Jani Nikula <jani.nikula@linux.intel.com>
Cc:     Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, ldv-project@linuxtesting.org,
        trufanov@swemel.ru, vfh@swemel.ru
Subject: [PATCH 3/3] i915-pmu: Add extra check NULL
Date:   Tue, 16 Aug 2022 12:25:25 +0300
Message-Id: <20220816092525.37670-1-arefev@swemel.ru>
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

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Signed-off-by: Denis Arefev <arefev@swemel.ru>
---
 drivers/gpu/drm/i915/i915_pmu.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/i915/i915_pmu.c b/drivers/gpu/drm/i915/i915_pmu.c
index 34a7f0ef1f67..33db49ffac3d 100644
--- a/drivers/gpu/drm/i915/i915_pmu.c
+++ b/drivers/gpu/drm/i915/i915_pmu.c
@@ -704,8 +704,7 @@ static void i915_pmu_disable(struct perf_event *event)
 		 * Decrement the reference count and clear the enabled
 		 * bitmask when the last listener on an event goes away.
 		 */
-		if(engine != NULL)
-		{
+		if (engine != NULL) {
 		        if (--engine->pmu.enable_count[sample] == 0)
 			        engine->pmu.enable &= ~BIT(sample);
 		}
-- 
2.25.1

