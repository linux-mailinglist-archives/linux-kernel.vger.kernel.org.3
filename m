Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E1AE496CE1
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jan 2022 17:29:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234396AbiAVQ30 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jan 2022 11:29:26 -0500
Received: from tkylinode-sdnproxy-1.icoremail.net ([139.162.70.28]:34060 "HELO
        tkylinode-sdnproxy-1.icoremail.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with SMTP id S233256AbiAVQ3Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jan 2022 11:29:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pku.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
        Message-Id; bh=alq4ir+0MOG88pcfGYwcw057jT8x9vR4bRokF24UWbg=; b=R
        yNOVBZcEZ3yWqkD2aoKSIg5F2m6frcZAOhiXdi3zE193mbE0A0W1hEj3J9QlzB+V
        MiyWOCK3HcfiFngbT7aYiH1CWqhr2HUGWJqbsOoSq1xcVSsHuqgbBbD8uNNNGOwU
        K62x4GHKlrh2/Sjjrv+uZufqtIt2ZqAXyckQAqDmXA=
Received: from localhost (unknown [10.129.21.144])
        by front02 (Coremail) with SMTP id 54FpogA3PyM0MOxhuSOfAA--.56422S2;
        Sun, 23 Jan 2022 00:26:28 +0800 (CST)
From:   Yongzhi Liu <lyz_cs@pku.edu.cn>
To:     emma@anholt.net, airlied@linux.ie, daniel@ffwll.ch
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Yongzhi Liu <lyz_cs@pku.edu.cn>
Subject: [PATCH] drm/v3d: Add missing unlock
Date:   Sat, 22 Jan 2022 08:26:27 -0800
Message-Id: <1642868787-61384-1-git-send-email-lyz_cs@pku.edu.cn>
X-Mailer: git-send-email 2.7.4
X-CM-TRANSID: 54FpogA3PyM0MOxhuSOfAA--.56422S2
X-Coremail-Antispam: 1UD129KBjvdXoWrtFykGFy3ArW7uF43Aw15CFg_yoWDGFb_Ga
        13Xwn7WF4UCrsIqF17A3yavrWFvFykCF4rZwnrKa43t3sF9FykKry8Zr1UXr1rJa18uFsr
        tr1fZrsayFn7KjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbxxFc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AK
        wVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20x
        vE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1l84ACjcxK6I8E
        87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AKxVW8Jr0_Cr1UM2AIxVAIcx
        kEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v2
        6r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2
        Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkIecxEwVCm-wCF04k20xvY0x0EwIxG
        rwCF04k20xvE74AGY7Cv6cx26w4UJr1UMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I
        8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWU
        twCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x
        0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_
        Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjfUoO
        J5UUUUU
X-CM-SenderInfo: irzqijirqukmo6sn3hxhgxhubq/1tbiAwEOBlPy7uC2rgAAs9
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[why]
Unlock is needed on the error handling path to prevent dead lock.

[how]
Fix this by adding drm_gem_unlock_reservations on the error handling path.

Signed-off-by: Yongzhi Liu <lyz_cs@pku.edu.cn>
---
 drivers/gpu/drm/v3d/v3d_gem.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/v3d/v3d_gem.c b/drivers/gpu/drm/v3d/v3d_gem.c
index c7ed2e1..0c989dc 100644
--- a/drivers/gpu/drm/v3d/v3d_gem.c
+++ b/drivers/gpu/drm/v3d/v3d_gem.c
@@ -798,6 +798,8 @@ v3d_submit_cl_ioctl(struct drm_device *dev, void *data,
 
 		if (!render->base.perfmon) {
 			ret = -ENOENT;
+			drm_gem_unlock_reservations(last_job->bo,
+				    last_job->bo_count, &acquire_ctx);
 			goto fail;
 		}
 	}
@@ -1027,6 +1029,8 @@ v3d_submit_csd_ioctl(struct drm_device *dev, void *data,
 						     args->perfmon_id);
 		if (!job->base.perfmon) {
 			ret = -ENOENT;
+			drm_gem_unlock_reservations(clean_job->bo, clean_job->bo_count,
+						    &acquire_ctx);
 			goto fail;
 		}
 	}
-- 
2.7.4

