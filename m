Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A37348E7BF
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 10:45:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239554AbiANJpF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 04:45:05 -0500
Received: from smtp25.cstnet.cn ([159.226.251.25]:48326 "EHLO cstnet.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229785AbiANJpE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 04:45:04 -0500
Received: from localhost.localdomain (unknown [124.16.138.126])
        by APP-05 (Coremail) with SMTP id zQCowADnxxQHRuFh+NkyBg--.53894S2;
        Fri, 14 Jan 2022 17:44:39 +0800 (CST)
From:   Jiasheng Jiang <jiasheng@iscas.ac.cn>
To:     liviu.dudau@arm.com, brian.starkey@arm.com, airlied@linux.ie,
        daniel@ffwll.ch
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Jiasheng Jiang <jiasheng@iscas.ac.cn>
Subject: [PATCH] drm/arm/mali: Check for NULL pointer after calling kzalloc
Date:   Fri, 14 Jan 2022 17:44:38 +0800
Message-Id: <20220114094438.1319522-1-jiasheng@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: zQCowADnxxQHRuFh+NkyBg--.53894S2
X-Coremail-Antispam: 1UD129KBjvJXoW7tFy3Wr1DAw15uFy5ZFWxXrb_yoW8Gr18pr
        48KrZ2yr95Za15Gr9rAa1kurn8Ca90vFyxKrykWw15uw1rK3s8AF4kKas8Wa1UJrWfJryY
        yanFqa93Z3Wjkw7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkl14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
        6r4UJwA2z4x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
        CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
        2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
        W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc2xSY4AK67AK6r4f
        MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr
        0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0E
        wIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JV
        WxJwCI42IY6xAIw20EY4v20xvaj40_Wr1j6rW3Jr1lIxAIcVC2z280aVAFwI0_Jr0_Gr1l
        IxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUbgyCJUUUU
        U==
X-Originating-IP: [124.16.138.126]
X-CM-SenderInfo: pmld2xxhqjqxpvfd2hldfou0/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As the possible failure of the kzalloc(), mw_state could be NULL
pointer.
Therefore, it should be better to check it in order to avoid the
dereference of the NULL pointer, like the kzalloc() in
malidp_mw_connector_duplicate_state().
If fails, we can directly use the 'NULL' instead of the
'&mw_state->base' and __drm_atomic_helper_connector_reset() will deal
with it correctly.

Fixes: 8cbc5caf36ef ("drm: mali-dp: Add writeback connector")
Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>
---
 drivers/gpu/drm/arm/malidp_mw.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/arm/malidp_mw.c b/drivers/gpu/drm/arm/malidp_mw.c
index f5847a79dd7e..96752353b5a1 100644
--- a/drivers/gpu/drm/arm/malidp_mw.c
+++ b/drivers/gpu/drm/arm/malidp_mw.c
@@ -70,7 +70,11 @@ static void malidp_mw_connector_reset(struct drm_connector *connector)
 		__drm_atomic_helper_connector_destroy_state(connector->state);
 
 	kfree(connector->state);
-	__drm_atomic_helper_connector_reset(connector, &mw_state->base);
+
+	if (!mw_state)
+		__drm_atomic_helper_connector_reset(connector, NULL);
+	else
+		__drm_atomic_helper_connector_reset(connector, &mw_state->base);
 }
 
 static enum drm_connector_status
-- 
2.25.1

