Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52A7C55AA45
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Jun 2022 14:59:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232984AbiFYM7A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Jun 2022 08:59:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231982AbiFYM67 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jun 2022 08:58:59 -0400
Received: from zg8tmtyylji0my4xnjqunzqa.icoremail.net (zg8tmtyylji0my4xnjqunzqa.icoremail.net [162.243.164.74])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 6431A17E20
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jun 2022 05:58:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fudan.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
        Message-Id:MIME-Version:Content-Transfer-Encoding; bh=6cdzgUCaDT
        0VxXMEsUwLLOq5OqTUlLwgUTvTXMzofWg=; b=sXXPIyPIYZjm1QWgYrNcqc6bm3
        xbvHaOE2ZHQd6itjIXevBu32RvhD3iCTQk9kTxMxQkbuwng+i/tHKJxNmV61naoe
        7+QTR2z5mkv0G/FIJ7aDq0P4YY/c5FNP9xoelKOahGWaQDIh4vKai0rsM+IB0wKm
        Ibs7/4DnuwAfUv8WU=
Received: from localhost.localdomain (unknown [117.136.12.236])
        by app1 (Coremail) with SMTP id XAUFCgAHXVFvBrdi2qvoAA--.14003S4;
        Sat, 25 Jun 2022 20:58:38 +0800 (CST)
From:   Xin Xiong <xiongx18@fudan.edu.cn>
To:     Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Matthew Dawson <matthew@mjdsystems.ca>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Cc:     yuanxzhang@fudan.edu.cn, Xin Xiong <xiongx18@fudan.edu.cn>,
        Xin Tan <tanxin.ctf@gmail.com>
Subject: [PATCH v2] drm/radeon: fix potential memory leaks in two ib test functions
Date:   Sat, 25 Jun 2022 20:56:48 +0800
Message-Id: <20220625125647.1782-1-xiongx18@fudan.edu.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: XAUFCgAHXVFvBrdi2qvoAA--.14003S4
X-Coremail-Antispam: 1UD129KBjvJXoWxJw43GFW3tF4ktFWxJF1rtFb_yoW5CryxpF
        Za9r9Fyr92yw42gw47ta9rXFyYkw1fGayxWr4qk3y5uw15AF1qgF13Zryvqry8JrykZryI
        vF1kWw1xZ3W0kF7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9214x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
        JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
        CE3s1lnxkEFVAIw20F6cxK64vIFxWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xv
        F2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r
        4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I
        648v4I1lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x
        0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2
        zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF
        4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j
        6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYx
        BIdaVFxhVjvjDU0xZFpf9x0JUQZ23UUUUU=
X-CM-SenderInfo: arytiiqsuqiimz6i3vldqovvfxof0/1tbiAQ8IEFKp5B6mNgACsF
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The issue takes place in several error handling paths in both
cik_sdma_ib_test() and r600_dma_ib_test(). Take cik_sdma_ib_test()
for an example. When radeon_fence_wait_timeout() returns a value equal
or less than zero, the function simply returns an error code,
forgetting to free the object "ib", which is requested by calling
radeon_ib_get() earlier. This may result in memory leaks.

Fix it by freeing "ib" in specific error handling paths.

Fixes: 04db4caf5c83 ("drm/radeon: Avoid double gpu reset by adding a timeout on IB ring tests.")
Signed-off-by: Xin Xiong <xiongx18@fudan.edu.cn>
Signed-off-by: Xin Tan <tanxin.ctf@gmail.com>
---
V1 -> V2: Fix another function of similar pattern
---
 drivers/gpu/drm/radeon/cik_sdma.c | 9 +++++----
 drivers/gpu/drm/radeon/r600_dma.c | 9 +++++----
 2 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/radeon/cik_sdma.c b/drivers/gpu/drm/radeon/cik_sdma.c
index 919b14845c3c..d0e7323cdd42 100644
--- a/drivers/gpu/drm/radeon/cik_sdma.c
+++ b/drivers/gpu/drm/radeon/cik_sdma.c
@@ -732,18 +732,18 @@ int cik_sdma_ib_test(struct radeon_device *rdev, struct radeon_ring *ring)
 
 	r = radeon_ib_schedule(rdev, &ib, NULL, false);
 	if (r) {
-		radeon_ib_free(rdev, &ib);
 		DRM_ERROR("radeon: failed to schedule ib (%d).\n", r);
-		return r;
+		goto out;
 	}
 	r = radeon_fence_wait_timeout(ib.fence, false, usecs_to_jiffies(
 		RADEON_USEC_IB_TEST_TIMEOUT));
 	if (r < 0) {
 		DRM_ERROR("radeon: fence wait failed (%d).\n", r);
-		return r;
+		goto out;
 	} else if (r == 0) {
 		DRM_ERROR("radeon: fence wait timed out.\n");
-		return -ETIMEDOUT;
+		r = -ETIMEDOUT;
+		goto out;
 	}
 	r = 0;
 	for (i = 0; i < rdev->usec_timeout; i++) {
@@ -758,6 +758,7 @@ int cik_sdma_ib_test(struct radeon_device *rdev, struct radeon_ring *ring)
 		DRM_ERROR("radeon: ib test failed (0x%08X)\n", tmp);
 		r = -EINVAL;
 	}
+out:
 	radeon_ib_free(rdev, &ib);
 	return r;
 }
diff --git a/drivers/gpu/drm/radeon/r600_dma.c b/drivers/gpu/drm/radeon/r600_dma.c
index 89ca2738c5d4..75ed03886fc2 100644
--- a/drivers/gpu/drm/radeon/r600_dma.c
+++ b/drivers/gpu/drm/radeon/r600_dma.c
@@ -363,18 +363,18 @@ int r600_dma_ib_test(struct radeon_device *rdev, struct radeon_ring *ring)
 
 	r = radeon_ib_schedule(rdev, &ib, NULL, false);
 	if (r) {
-		radeon_ib_free(rdev, &ib);
 		DRM_ERROR("radeon: failed to schedule ib (%d).\n", r);
-		return r;
+		goto out;
 	}
 	r = radeon_fence_wait_timeout(ib.fence, false, usecs_to_jiffies(
 		RADEON_USEC_IB_TEST_TIMEOUT));
 	if (r < 0) {
 		DRM_ERROR("radeon: fence wait failed (%d).\n", r);
-		return r;
+		goto out;
 	} else if (r == 0) {
 		DRM_ERROR("radeon: fence wait timed out.\n");
-		return -ETIMEDOUT;
+		r = -ETIMEDOUT;
+		goto out;
 	}
 	r = 0;
 	for (i = 0; i < rdev->usec_timeout; i++) {
@@ -389,6 +389,7 @@ int r600_dma_ib_test(struct radeon_device *rdev, struct radeon_ring *ring)
 		DRM_ERROR("radeon: ib test failed (0x%08X)\n", tmp);
 		r = -EINVAL;
 	}
+out:
 	radeon_ib_free(rdev, &ib);
 	return r;
 }
-- 
2.25.1

