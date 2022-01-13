Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87A5D48D3D3
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 09:49:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229688AbiAMIst (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 03:48:49 -0500
Received: from smtp21.cstnet.cn ([159.226.251.21]:53450 "EHLO cstnet.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229648AbiAMIss (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 03:48:48 -0500
Received: from localhost.localdomain (unknown [124.16.141.244])
        by APP-01 (Coremail) with SMTP id qwCowABnb59b599hVSpGBg--.58605S2;
        Thu, 13 Jan 2022 16:48:28 +0800 (CST)
From:   Xu Wang <vulab@iscas.ac.cn>
To:     lee.jones@linaro.org, daniel.thompson@linaro.org,
        jingoohan1@gmail.com
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] backlight: lm3630a_bl: Remove redundant 'flush_workqueue()' calls
Date:   Thu, 13 Jan 2022 08:48:06 +0000
Message-Id: <20220113084806.13822-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qwCowABnb59b599hVSpGBg--.58605S2
X-Coremail-Antispam: 1UD129KBjvdXoWrKF1xtr43uF4kGFWrZrW5Jrb_yoW3ArX_Kr
        ZFqryfWFWUKF409FZrtFWrZFWFkaykuFy5XF4FyFyFy34UWry5uFZFvrs7uF1Uua45GFsr
        u34a9r40vr1fJjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbFkYjsxI4VWkCwAYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I
        6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM2
        8CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0
        cI8IcVCY1x0267AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4vEx4
        A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IE
        w4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMc
        vjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCF04k20xvY0x0EwIxGrwCFx2Iq
        xVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r
        106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AK
        xVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7
        xG6rW3Jr0E3s1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWU
        JVW8JbIYCTnIWIevJa73UjIFyTuYvjxUcDDGUUUUU
X-Originating-IP: [124.16.141.244]
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiCwkFA1z4kwKO+wAAsE
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'destroy_workqueue()' already drains the queue before destroying it, so
there is no need to flush it explicitly.

Remove the redundant 'flush_workqueue()' calls.

Signed-off-by: Xu Wang <vulab@iscas.ac.cn>
---
 drivers/video/backlight/lm3630a_bl.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/video/backlight/lm3630a_bl.c b/drivers/video/backlight/lm3630a_bl.c
index e8b185bb6f5e..1d17c439430e 100644
--- a/drivers/video/backlight/lm3630a_bl.c
+++ b/drivers/video/backlight/lm3630a_bl.c
@@ -594,7 +594,6 @@ static int lm3630a_remove(struct i2c_client *client)
 
 	if (pchip->irq) {
 		free_irq(pchip->irq, pchip);
-		flush_workqueue(pchip->irqthread);
 		destroy_workqueue(pchip->irqthread);
 	}
 	return 0;
-- 
2.25.1

