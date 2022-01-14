Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47B7248E68C
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 09:31:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234709AbiANIar (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 03:30:47 -0500
Received: from smtp25.cstnet.cn ([159.226.251.25]:60220 "EHLO cstnet.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S241056AbiANIaL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 03:30:11 -0500
Received: from localhost.localdomain (unknown [124.16.141.244])
        by APP-05 (Coremail) with SMTP id zQCowABnb39_NOFhBN4xBg--.50417S2;
        Fri, 14 Jan 2022 16:29:52 +0800 (CST)
From:   Xu Wang <vulab@iscas.ac.cn>
To:     mporter@kernel.crashing.org, alex.bou9@gmail.com
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] rapidio: Remove redundant 'flush_workqueue()' calls
Date:   Fri, 14 Jan 2022 08:29:31 +0000
Message-Id: <20220114082931.42153-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: zQCowABnb39_NOFhBN4xBg--.50417S2
X-Coremail-Antispam: 1UD129KBjvdXoWrKF13JrWDJrW7Ww15AF1rCrg_yoWxurb_Ca
        y5WrZ7X3yq9a1Ikayjqw1ruFZIvaykZF1vvFWftFZ8K34UZw1FvrWUZr4ku3y7Zw15GFn7
        u397Z34rZrnrCjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUb2kYjsxI4VWkKwAYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I
        6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM2
        8CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0
        cI8IcVCY1x0267AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I
        8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI
        64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv67AKxVWUJVW8Jw
        Am72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lc2xSY4AK67AK6r43MxAIw28I
        cxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2
        IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUXVWUAwCIc40Y0x0EwIxGrwCI
        42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42
        IY6xAIw20EY4v20xvaj40_Wr1j6rW3Jr1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2
        z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU5WKZtUUUUU==
X-Originating-IP: [124.16.141.244]
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBgkGA10Tf6iqfAABsE
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'destroy_workqueue()' already drains the queue before destroying it, so
there is no need to flush it explicitly.

Remove the redundant 'flush_workqueue()' calls.

Signed-off-by: Xu Wang <vulab@iscas.ac.cn>
---
 drivers/rapidio/rio_cm.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/rapidio/rio_cm.c b/drivers/rapidio/rio_cm.c
index db4c265287ae..f2c0d6aa911f 100644
--- a/drivers/rapidio/rio_cm.c
+++ b/drivers/rapidio/rio_cm.c
@@ -2198,7 +2198,6 @@ static void riocm_remove_mport(struct device *dev,
 	if (!found)
 		return;
 
-	flush_workqueue(cm->rx_wq);
 	destroy_workqueue(cm->rx_wq);
 
 	/* Release channels bound to this mport */
-- 
2.25.1

