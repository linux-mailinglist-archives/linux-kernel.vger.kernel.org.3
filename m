Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42DF7492559
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 13:03:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241200AbiARMDb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 07:03:31 -0500
Received: from zg8tmja2lje4os4yms4ymjma.icoremail.net ([206.189.21.223]:39609
        "HELO zg8tmja2lje4os4yms4ymjma.icoremail.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with SMTP id S238285AbiARMDa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 07:03:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pku.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
        Message-Id; bh=5O5U7jsnHA7kBZ7RZnQht5rKmv8b+xsNFODgWa6IJVM=; b=h
        5BcuwSvNQCBvm11EbUyflIk+RG+nEAqLmaEWdccBI1pZY7mFHbjREveJJ32Chdaq
        x95XhIjuNKlORFN/kHAnnR6xL2ABHU3sm/ASHMaawuwVL3q6FGOH9q9piXIZJrKF
        IOswzR26dHiZVPXwUNSUgEGoRNGD47h8g0eI5Ghxws=
Received: from localhost (unknown [10.129.21.144])
        by front01 (Coremail) with SMTP id 5oFpogC3vTkJrOZhATZ0AA--.62223S2;
        Tue, 18 Jan 2022 20:01:14 +0800 (CST)
From:   Yongzhi Liu <lyz_cs@pku.edu.cn>
To:     airlied@linux.ie, daniel@ffwll.ch, nirmoy.das@amd.com,
        lijo.lazar@amd.com, Jingwen.Chen2@amd.com, evan.quan@amd.com,
        Jack.Zhang1@amd.com, kevin1.wang@amd.com, tom.stdenis@amd.com
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Yongzhi Liu <lyz_cs@pku.edu.cn>
Subject: [PATCH] drm/amdgpu: Add missing pm_runtime_put_autosuspend
Date:   Tue, 18 Jan 2022 04:01:12 -0800
Message-Id: <1642507272-17545-1-git-send-email-lyz_cs@pku.edu.cn>
X-Mailer: git-send-email 2.7.4
X-CM-TRANSID: 5oFpogC3vTkJrOZhATZ0AA--.62223S2
X-Coremail-Antispam: 1UD129KBjvdXoWrKrW7ZFW7WF1rGrW8GF4rKrg_yoWfuFX_K3
        yUXr9rXw13AF1qqr1Iyw43ZrWIvFZ8ZF18Wr1ftFySyryUZrWDJryjvrn8Zw4rWr17GF1D
        X390gF1fAwnI9jkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUb3AFc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AK
        wVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20x
        vE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1l84ACjcxK6I8E
        87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c
        8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_
        Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwI
        xGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc2xSY4AK
        6svPMxAIw28IcxkI7VAKI48JMxAIw28IcVCjz48v1sIEY20_Kr1UJr1l4I8I3I0E4IkC6x
        0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2
        zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF
        4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWU
        CwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCT
        nIWIevJa73UjIFyTuYvjfUoOJ5UUUUU
X-CM-SenderInfo: irzqijirqukmo6sn3hxhgxhubq/1tbiAwEKBlPy7uA+KwADs3
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pm_runtime_get_sync() increments the runtime PM usage counter even
when it returns an error code, thus a matching decrement is needed
on the error handling path to keep the counter balanced.

Signed-off-by: Yongzhi Liu <lyz_cs@pku.edu.cn>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
index 9aea1cc..4b950de 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
@@ -1120,8 +1120,10 @@ static ssize_t amdgpu_debugfs_gfxoff_read(struct file *f, char __user *buf,
 		return -EINVAL;
 
 	r = pm_runtime_get_sync(adev_to_drm(adev)->dev);
-	if (r < 0)
+	if (r < 0) {
+		pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
 		return r;
+	}
 
 	while (size) {
 		uint32_t value;
-- 
2.7.4

