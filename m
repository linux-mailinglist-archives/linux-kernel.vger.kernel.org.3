Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C6E0490C3E
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 17:13:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240913AbiAQQN3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 11:13:29 -0500
Received: from zg8tmja2lje4os4yms4ymjma.icoremail.net ([206.189.21.223]:33966
        "HELO zg8tmja2lje4os4yms4ymjma.icoremail.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with SMTP id S240855AbiAQQN1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 11:13:27 -0500
X-Greylist: delayed 124574 seconds by postgrey-1.27 at vger.kernel.org; Mon, 17 Jan 2022 11:13:27 EST
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pku.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
        Message-Id; bh=IoU4c8Qzrzf/vo2epfkLxZWf7un1XmuXnluB/LP7dP8=; b=g
        TLAPgMpzf/x5FbuHOyvGRxjaP/qRqepLfA2iqWfARbD15jogBc2qS70g1RVE20TL
        Gqb6vPRutJHxgrCztIAxzSljyeIHfpIOK7FH1+MgGQESb8jts/gFBCo8PxgKAnhP
        qSO7J6uDUXQ2wf/kJx61xdGiVjB2/i1SGbqwILSrkY=
Received: from localhost (unknown [10.129.21.144])
        by front02 (Coremail) with SMTP id 54FpogBnbzP8lOVhrbppAA--.47477S2;
        Tue, 18 Jan 2022 00:10:36 +0800 (CST)
From:   Yongzhi Liu <lyz_cs@pku.edu.cn>
To:     emma@anholt.net, airlied@linux.ie, daniel@ffwll.ch
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Yongzhi Liu <lyz_cs@pku.edu.cn>
Subject: [PATCH] drm/v3d: Fix runtime PM imbalance on error
Date:   Mon, 17 Jan 2022 08:10:35 -0800
Message-Id: <1642435835-10115-1-git-send-email-lyz_cs@pku.edu.cn>
X-Mailer: git-send-email 2.7.4
X-CM-TRANSID: 54FpogBnbzP8lOVhrbppAA--.47477S2
X-Coremail-Antispam: 1UD129KBjvdXoWrKrW7ZFW7WF1rGrW8GF4rKrg_yoWfJwc_ur
        1UXrs7ur9ruFsFq3ZFka13ZFyIvF1DuayruF40y343tr12vr4UXryxZr1kZr1xXw48AFn8
        ta4vvFn3AFsrWjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUb4AFc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AK
        wVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20x
        vE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1l84ACjcxK6I8E
        87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4j6r4UJwAS0I0E0xvYzx
        vE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
        JVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7V
        AKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY02Avz4vE-syl42xK82IYc2Ij64vIr41l
        42xK82IY6x8ErcxFaVAv8VWkJr1UJwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F4
        0E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1l
        IxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxV
        AFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j
        6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7VUbXdbU
        UUUUU==
X-CM-SenderInfo: irzqijirqukmo6sn3hxhgxhubq/1tbiAwEEBlPy7t9+qgAdsZ
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pm_runtime_get_sync() increments the runtime PM usage counter even
when it returns an error code, thus a matching decrement is needed
on the error handling path to keep the counter balanced.

Signed-off-by: Yongzhi Liu <lyz_cs@pku.edu.cn>
---
 drivers/gpu/drm/v3d/v3d_drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/v3d/v3d_drv.c b/drivers/gpu/drm/v3d/v3d_drv.c
index 1afcd54..6e72bd7 100644
--- a/drivers/gpu/drm/v3d/v3d_drv.c
+++ b/drivers/gpu/drm/v3d/v3d_drv.c
@@ -69,7 +69,7 @@ static int v3d_get_param_ioctl(struct drm_device *dev, void *data,
 		if (args->value != 0)
 			return -EINVAL;
 
-		ret = pm_runtime_get_sync(v3d->drm.dev);
+		ret = pm_runtime_resume_and_get(v3d->drm.dev);
 		if (ret < 0)
 			return ret;
 		if (args->param >= DRM_V3D_PARAM_V3D_CORE0_IDENT0 &&
-- 
2.7.4

