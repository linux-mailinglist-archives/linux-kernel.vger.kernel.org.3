Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBCD95144E8
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 10:56:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356076AbiD2I7y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 04:59:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236950AbiD2I7x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 04:59:53 -0400
Received: from zg8tmty1ljiyny4xntqumjca.icoremail.net (zg8tmty1ljiyny4xntqumjca.icoremail.net [165.227.154.27])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id B772286E13
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 01:56:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fudan.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
        Message-Id:MIME-Version:Content-Transfer-Encoding; bh=amePFdXDy6
        eKXcLqyO+aJjWEC77R1KGfpX+ipQ86EH0=; b=qBo1feLTejqDETkmTn2w/8cBe1
        0+0nMtNrgMmP84QHlG16UoWRSS5eQawwHI96CxFzxYp5XSQEd+KYvf67IZGu7DeZ
        RNCnTL2hvTA/SZUY7IfOAKUwDdY8j1Wqw6tAn5yFDcs4u96t2YKAZnvIcyV/622J
        3C8h7cBLVicVrJ11E=
Received: from localhost.localdomain (unknown [10.102.183.96])
        by app1 (Coremail) with SMTP id XAUFCgAXHnYhqGtibix3EQ--.46279S4;
        Fri, 29 Apr 2022 16:56:05 +0800 (CST)
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
Subject: [PATCH] drm/radeon: fix reference count leak in cik_sdma_ib_test()
Date:   Fri, 29 Apr 2022 16:53:32 +0800
Message-Id: <20220429085331.2515-1-xiongx18@fudan.edu.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: XAUFCgAXHnYhqGtibix3EQ--.46279S4
X-Coremail-Antispam: 1UD129KBjvJXoW7Cw47JFykXFyrAr4fGrWkXrb_yoW8Cr47pr
        WS9r9Fyr92yw42gw47ta9rWFyYkw18Ja1xWr4DC398Cw45Zw1vqF13ZryvqryUJrykZryS
        vF1kWw48Z3W8AF7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9C14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26rxl
        6s0DM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
        0DM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI
        64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8Jw
        Am72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAG
        YxC7M4IIrI8v6xkF7I0E8cxan2IY04v7MxkIecxEwVCm-wCF04k20xvY0x0EwIxGrwCFx2
        IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v2
        6r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67
        AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IY
        s7xG6rWUJVWrZr1UMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI
        0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUQZ23UUUUU=
X-CM-SenderInfo: arytiiqsuqiimz6i3vldqovvfxof0/1tbiAhALEFKp2mkXjwAAsZ
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The issue takes place in several error handling paths in
cik_sdma_ib_test(). For example, when radeon_fence_wait_timeout()
returns a value no greater than zero, the function simply returns an
error code, forgetting to decrease the reference count of the object
"ib", which is incremented by radeon_ib_get() earlier. This may
result in memory leaks.

Fix it by decrementing the reference count of "ib" in those paths.

Fixes: 04db4caf5c83 ("drm/radeon: Avoid double gpu reset by adding a timeout on IB ring tests.")
Signed-off-by: Xin Xiong <xiongx18@fudan.edu.cn>
Signed-off-by: Xin Tan <tanxin.ctf@gmail.com>
---
 drivers/gpu/drm/radeon/cik_sdma.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

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
-- 
2.25.1

