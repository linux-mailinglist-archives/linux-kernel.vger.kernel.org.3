Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57F0F49399F
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 12:37:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354214AbiASLhT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 06:37:19 -0500
Received: from zg8tmtyylji0my4xnjqunzqa.icoremail.net ([162.243.164.74]:39230
        "HELO zg8tmtyylji0my4xnjqunzqa.icoremail.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with SMTP id S1354053AbiASLhQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 06:37:16 -0500
X-Greylist: delayed 24798 seconds by postgrey-1.27 at vger.kernel.org; Wed, 19 Jan 2022 06:37:16 EST
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pku.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
        Message-Id; bh=kD8l7wKIyCk4oo+Iq/iBIYCsIUgzS7PCA2TMzmhVhFo=; b=e
        GIUiRRfovsyJnUyPdjmwKy3yJlaK3Pf/vX8mcr0CnrwZe/GF/Qp9VxvEveIa5+Fj
        FtJYQG0WuDwN5LsM/sQHTYYuMwJo6bpDIxJYiJBKGPJBdq6ixCMU/v5WbeS64nlO
        bXrveM7JUXBJwIHRPuyhowgfNnqp5DIW9/D7rJhpwI=
Received: from localhost (unknown [10.129.21.144])
        by front02 (Coremail) with SMTP id 54FpogBXXQEv9+dhY3N9AA--.9450S2;
        Wed, 19 Jan 2022 19:34:07 +0800 (CST)
From:   Yongzhi Liu <lyz_cs@pku.edu.cn>
To:     l.stach@pengutronix.de, linux+etnaviv@armlinux.org.uk,
        christian.gmeiner@gmail.com, airlied@linux.ie, daniel@ffwll.ch
Cc:     etnaviv@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Yongzhi Liu <lyz_cs@pku.edu.cn>
Subject: [PATCH] drm/etnaviv: Fix runtime PM imbalance on error
Date:   Wed, 19 Jan 2022 03:34:05 -0800
Message-Id: <1642592045-28700-1-git-send-email-lyz_cs@pku.edu.cn>
X-Mailer: git-send-email 2.7.4
X-CM-TRANSID: 54FpogBXXQEv9+dhY3N9AA--.9450S2
X-Coremail-Antispam: 1UD129KBjvdXoWrZrW3Aw4rurW8GF1kAr48tFb_yoWfKrb_CF
        1UZrs7Xr4agr1vqr47Z345ZryIqF1rXa92qws0qasxKrW2yrn8Xrykuw1DZay3XayUuFn8
        Jan2qFy3Ar1qgjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUb4kFc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AK
        wVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20x
        vE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1l84ACjcxK6I8E
        87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c
        8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_
        Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwI
        xGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc2xSY4AK6svPMxAIw28IcxkI7VAKI48JMxAI
        w28IcVCjz48v1sIEY20_Kr1UJr1l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67
        AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIY
        rxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14
        v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8
        JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUoOJ5UU
        UUU
X-CM-SenderInfo: irzqijirqukmo6sn3hxhgxhubq/1tbiAwEKBlPy7uA+KwAasu
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pm_runtime_get_sync() will increase the rumtime PM counter
even it returns an error. Thus a pairing decrement is needed
to prevent refcount leak. Fix this by replacing this API with
pm_runtime_resume_and_get(), which will not change the runtime
PM counter on error.

Signed-off-by: Yongzhi Liu <lyz_cs@pku.edu.cn>
---
 drivers/gpu/drm/etnaviv/etnaviv_gpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gpu.c b/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
index 242a5fd..aa64f45 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
+++ b/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
@@ -1690,7 +1690,7 @@ static int etnaviv_gpu_bind(struct device *dev, struct device *master,
 		goto out_workqueue;
 
 #ifdef CONFIG_PM
-	ret = pm_runtime_get_sync(gpu->dev);
+	ret = pm_runtime_resume_and_get(gpu->dev);
 #else
 	ret = etnaviv_gpu_clk_enable(gpu);
 #endif
-- 
2.7.4

