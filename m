Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E27149FB00
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 14:44:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241907AbiA1Nor (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 08:44:47 -0500
Received: from zg8tmja2lje4os4yms4ymjma.icoremail.net ([206.189.21.223]:60487
        "HELO zg8tmja2lje4os4yms4ymjma.icoremail.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with SMTP id S230092AbiA1Noq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 08:44:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pku.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
        Message-Id:In-Reply-To:References; bh=+yFFJELgwWtpD3SxF4eLEVwNGI
        zEfRo0oZQ4dXCLmTM=; b=NsEoYkbbzJjrxd3IjDlS4ykWy3wv/VTkQV/m7qs671
        kK6nmT+SgEiehdfCVE5BCgwEmVE7ApttAuBCrg+sSoJ20ymbpzyFfX7+YOSgfXyw
        Xq0CpNeLCsRO9qX9QZKtJQS0f6kY/C9QCyB9u66mX2A+I/SCNHWe/A9oeDl2jlGk
        g=
Received: from localhost (unknown [10.129.21.144])
        by front02 (Coremail) with SMTP id 54FpogDX37tw8vNhpUDiAA--.39451S2;
        Fri, 28 Jan 2022 21:41:04 +0800 (CST)
From:   Yongzhi Liu <lyz_cs@pku.edu.cn>
To:     emma@anholt.net, airlied@linux.ie, daniel@ffwll.ch, mwen@igalia.com
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Yongzhi Liu <lyz_cs@pku.edu.cn>
Subject: [PATCH v3] drm/v3d: fix missing unlock
Date:   Fri, 28 Jan 2022 05:41:02 -0800
Message-Id: <1643377262-109975-1-git-send-email-lyz_cs@pku.edu.cn>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <20220128125510.idyai4bp3g5nbzd2@mail.igalia.com>
References: <20220128125510.idyai4bp3g5nbzd2@mail.igalia.com>
X-CM-TRANSID: 54FpogDX37tw8vNhpUDiAA--.39451S2
X-Coremail-Antispam: 1UD129KBjvJXoW7tr43tw17Aw48uryrCw13CFg_yoW8XF4fpr
        WkXr9F9rWxtFWjg39rAFs8Xa48Wa4aka18Ga4xA398Xws0yF47Xa9YkFyjyryUWr97GFWU
        tF1YgFy0vF1UAw7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkC1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AE
        w4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2
        IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2
        z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcV
        Aq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j
        6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64
        vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkIecxEwVCm-wCF04k20xvY0x0EwIxGrwCF
        04k20xvE74AGY7Cv6cx26w4UJr1UMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrV
        AFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCI
        c40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267
        AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_
        Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjfUoOJ5UU
        UUU
X-CM-SenderInfo: irzqijirqukmo6sn3hxhgxhubq/1tbiAwEABlPy7uIpCAABsJ
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[why]
Unlock is needed on the error handling path to prevent dead lock.
v3d_submit_cl_ioctl and v3d_submit_csd_ioctl is missing unlock.

[how]
Fix this by changing goto target on the error handling path. So
changing the goto to target an error handling path
that includes drm_gem_unlock reservations.

Signed-off-by: Yongzhi Liu <lyz_cs@pku.edu.cn>
---
 drivers/gpu/drm/v3d/v3d_gem.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/v3d/v3d_gem.c b/drivers/gpu/drm/v3d/v3d_gem.c
index c7ed2e1..92bc0fa 100644
--- a/drivers/gpu/drm/v3d/v3d_gem.c
+++ b/drivers/gpu/drm/v3d/v3d_gem.c
@@ -798,7 +798,7 @@ v3d_submit_cl_ioctl(struct drm_device *dev, void *data,
 
 		if (!render->base.perfmon) {
 			ret = -ENOENT;
-			goto fail;
+			goto fail_perfmon;
 		}
 	}
 
@@ -847,6 +847,7 @@ v3d_submit_cl_ioctl(struct drm_device *dev, void *data,
 
 fail_unreserve:
 	mutex_unlock(&v3d->sched_lock);
+fail_perfmon:
 	drm_gem_unlock_reservations(last_job->bo,
 				    last_job->bo_count, &acquire_ctx);
 fail:
@@ -1027,7 +1028,7 @@ v3d_submit_csd_ioctl(struct drm_device *dev, void *data,
 						     args->perfmon_id);
 		if (!job->base.perfmon) {
 			ret = -ENOENT;
-			goto fail;
+			goto fail_perfmon;
 		}
 	}
 
@@ -1056,6 +1057,7 @@ v3d_submit_csd_ioctl(struct drm_device *dev, void *data,
 
 fail_unreserve:
 	mutex_unlock(&v3d->sched_lock);
+fail_perfmon:
 	drm_gem_unlock_reservations(clean_job->bo, clean_job->bo_count,
 				    &acquire_ctx);
 fail:
-- 
2.7.4

