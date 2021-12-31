Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49C534822A3
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Dec 2021 08:50:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242764AbhLaHuk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Dec 2021 02:50:40 -0500
Received: from smtp21.cstnet.cn ([159.226.251.21]:48636 "EHLO cstnet.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229636AbhLaHuj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Dec 2021 02:50:39 -0500
Received: from localhost.localdomain (unknown [124.16.138.126])
        by APP-01 (Coremail) with SMTP id qwCowACXn1c8ts5hxcaTBQ--.45212S2;
        Fri, 31 Dec 2021 15:50:20 +0800 (CST)
From:   Jiasheng Jiang <jiasheng@iscas.ac.cn>
To:     dwlsalmeida@gmail.com, mchehab@kernel.org
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiasheng Jiang <jiasheng@iscas.ac.cn>
Subject: [PATCH] media: vidtv: Check for null return of vzalloc
Date:   Fri, 31 Dec 2021 15:50:19 +0800
Message-Id: <20211231075019.1894177-1-jiasheng@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qwCowACXn1c8ts5hxcaTBQ--.45212S2
X-Coremail-Antispam: 1UD129KBjvdXoW7Jw4DJr1DWFyrurWDZr1rCrg_yoWDGwb_ua
        n3Xr1xWayUKrWrtrnrtr1xZry0kaykuFyvgFnxt3ySvFy3ZF18Jryjvr18Gw429rZ09FZr
        Aw43Xr1F9r1xGjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbcxFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2IYs7xG
        6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
        A2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_
        Cr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
        0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
        jxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr
        1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkIecxEwVAFwVW8CwCF
        04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r
        18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vI
        r41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr
        1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAI
        cVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUjKFAPUUUUU==
X-Originating-IP: [124.16.138.126]
X-CM-SenderInfo: pmld2xxhqjqxpvfd2hldfou0/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As the possible failure of the vzalloc(), e->encoder_buf might be NULL.
Therefore, it should be better to check it like the kzalloc() in order
to guarantee the success of the initialization.

Fixes: f90cf6079bf6 ("media: vidtv: add a bridge driver")
Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>
---
 drivers/media/test-drivers/vidtv/vidtv_s302m.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/media/test-drivers/vidtv/vidtv_s302m.c b/drivers/media/test-drivers/vidtv/vidtv_s302m.c
index d79b65854627..d7907f1ae530 100644
--- a/drivers/media/test-drivers/vidtv/vidtv_s302m.c
+++ b/drivers/media/test-drivers/vidtv/vidtv_s302m.c
@@ -455,6 +455,11 @@ struct vidtv_encoder
 		e->name = kstrdup(args.name, GFP_KERNEL);
 
 	e->encoder_buf = vzalloc(VIDTV_S302M_BUF_SZ);
+	if (!e->encoder_buf) {
+		kfree(e);
+		return NULL;
+	}
+
 	e->encoder_buf_sz = VIDTV_S302M_BUF_SZ;
 	e->encoder_buf_offset = 0;
 
-- 
2.25.1

