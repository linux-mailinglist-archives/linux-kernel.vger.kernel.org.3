Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8698493628
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 09:21:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344391AbiASIVm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 03:21:42 -0500
Received: from azure-sdnproxy.icoremail.net ([52.237.72.81]:57902 "HELO
        azure-sdnproxy-1.icoremail.net" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with SMTP id S238265AbiASIVl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 03:21:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pku.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
        Message-Id; bh=FeyDaeCUE9Q9PPbCn5K7YqRumBgy06OD99LoSc0+DUU=; b=e
        +PV6G/BFn9XXMOhXoVD4lC/8uxoBEbV4Q32h9sMlhufQ22lvk4jaNYk722AYUgg6
        Koz2n9JMZEXdSQyX/CFulJb5+HO0Z2z2kepg2itlMTaqwSJECgMqFt7wBR2/CgK1
        QBZySMWsA5hEIbjRmOyHndkwuJ/9rQ1J6oI1ClUUuk=
Received: from localhost (unknown [10.129.21.144])
        by front01 (Coremail) with SMTP id 5oFpogB3fjqKyedhmGh8AA--.52130S2;
        Wed, 19 Jan 2022 16:19:23 +0800 (CST)
From:   Yongzhi Liu <lyz_cs@pku.edu.cn>
To:     thierry.reding@gmail.com, sam@ravnborg.org, airlied@linux.ie,
        daniel@ffwll.ch
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Yongzhi Liu <lyz_cs@pku.edu.cn>
Subject: [PATCH] drm/panel: Add missing pm_rumtime_resume_and_get
Date:   Wed, 19 Jan 2022 00:19:21 -0800
Message-Id: <1642580361-27552-1-git-send-email-lyz_cs@pku.edu.cn>
X-Mailer: git-send-email 2.7.4
X-CM-TRANSID: 5oFpogB3fjqKyedhmGh8AA--.52130S2
X-Coremail-Antispam: 1UD129KBjvJXoW7ZryUKw47WF1xurW3Cw48WFg_yoW8WFW5pr
        45XFWIyFyrtrW0yrW7AFn7XFy5uayIgFW7tF98Gan8Za15AF4jy3s8trWaqF1DArnxCFWa
        qFs7Kw43Z3Wayr7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkK1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AE
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
        Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUbXdbU
        UUUUU==
X-CM-SenderInfo: irzqijirqukmo6sn3hxhgxhubq/1tbiAwEKBlPy7uA+KwAXsj
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pm_runtime_put_autosuspend() and pm_runtime_put_sync_suspend()
will decrease the rumtime PM counter even when it returns an error.
Thus a pairing decrement is needed to prevent refcount leak.
Fix this by adding pm_runtime_resume_and_get() on error handling path.

Signed-off-by: Yongzhi Liu <lyz_cs@pku.edu.cn>
---
 drivers/gpu/drm/panel/panel-samsung-atna33xc20.c | 4 +++-
 drivers/gpu/drm/panel/panel-simple.c             | 4 +++-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-samsung-atna33xc20.c b/drivers/gpu/drm/panel/panel-samsung-atna33xc20.c
index 20666b6..dd7e3f1 100644
--- a/drivers/gpu/drm/panel/panel-samsung-atna33xc20.c
+++ b/drivers/gpu/drm/panel/panel-samsung-atna33xc20.c
@@ -189,8 +189,10 @@ static int atana33xc20_unprepare(struct drm_panel *panel)
 	 * to get the EDID or otherwise send DP AUX commands to the panel.
 	 */
 	ret = pm_runtime_put_sync_suspend(panel->dev);
-	if (ret < 0)
+	if (ret < 0) {
+		pm_runtime_resume_and_get(panel->dev);
 		return ret;
+	}
 	p->prepared = false;
 
 	return 0;
diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
index 9e46db5..ad18965 100644
--- a/drivers/gpu/drm/panel/panel-simple.c
+++ b/drivers/gpu/drm/panel/panel-simple.c
@@ -323,8 +323,10 @@ static int panel_simple_unprepare(struct drm_panel *panel)
 
 	pm_runtime_mark_last_busy(panel->dev);
 	ret = pm_runtime_put_autosuspend(panel->dev);
-	if (ret < 0)
+	if (ret < 0) {
+		pm_runtime_resume_and_get(panel->dev);
 		return ret;
+	}
 	p->prepared = false;
 
 	return 0;
-- 
2.7.4

