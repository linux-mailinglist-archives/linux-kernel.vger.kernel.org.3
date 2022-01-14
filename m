Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E5EB48E441
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 07:29:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239369AbiANG3C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 01:29:02 -0500
Received: from smtp23.cstnet.cn ([159.226.251.23]:50566 "EHLO cstnet.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S239342AbiANG3A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 01:29:00 -0500
Received: from localhost.localdomain (unknown [124.16.138.126])
        by APP-03 (Coremail) with SMTP id rQCowAAXHloZGOFhzqGFBQ--.12322S2;
        Fri, 14 Jan 2022 14:28:41 +0800 (CST)
From:   Jiasheng Jiang <jiasheng@iscas.ac.cn>
To:     hverkuil@xs4all.nl, dwlsalmeida@gmail.com, mchehab@kernel.org
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiasheng Jiang <jiasheng@iscas.ac.cn>
Subject: [PATCH v3] media: vidtv: Check for null return of vzalloc
Date:   Fri, 14 Jan 2022 14:28:40 +0800
Message-Id: <20220114062840.1246544-1-jiasheng@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: rQCowAAXHloZGOFhzqGFBQ--.12322S2
X-Coremail-Antispam: 1UD129KBjvJXoW7CFWrXFW7GF15tFWrKry5CFg_yoW8AFW3pF
        Z2qr90kry8Jw1fW3WUAw1UJFy5Kan7KFW3K3yI93s7u343Zr17KrZ0yFyUGr4kCa9YqrWx
        tF1DZFy7Wr1UCr7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkm14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
        6F4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Cr
        1j6rxdM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj
        6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr
        0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkIecxEwVAFwVW8
        AwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r
        1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij
        64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr
        0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAFwI0_Jr0_Gr1l
        IxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjfU8xR6UUUUU
X-Originating-IP: [124.16.138.126]
X-CM-SenderInfo: pmld2xxhqjqxpvfd2hldfou0/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As the possible failure of the vzalloc(), e->encoder_buf might be NULL.
Therefore, it should be better to check it in order
to guarantee the success of the initialization.
If fails, we need to free not only 'e' but also 'e->name'.
Also, if the allocation for ctx fails, we need to free 'e->encoder_buf'
else.

Fixes: f90cf6079bf6 ("media: vidtv: add a bridge driver")
Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>
---
Changelog

v1 -> v2

* Change 1. Add 'kfree(e->name)' if fails.

v2 -> v3

* Change 1. Fix the potential memory leak if ctx fails.
* Change 2. Use goto to instead of duplicating kfree()s.
---
 drivers/media/test-drivers/vidtv/vidtv_s302m.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/media/test-drivers/vidtv/vidtv_s302m.c b/drivers/media/test-drivers/vidtv/vidtv_s302m.c
index d79b65854627..4676083cee3b 100644
--- a/drivers/media/test-drivers/vidtv/vidtv_s302m.c
+++ b/drivers/media/test-drivers/vidtv/vidtv_s302m.c
@@ -455,6 +455,9 @@ struct vidtv_encoder
 		e->name = kstrdup(args.name, GFP_KERNEL);
 
 	e->encoder_buf = vzalloc(VIDTV_S302M_BUF_SZ);
+	if (!e->encoder_buf)
+		goto out_kfree_e;
+
 	e->encoder_buf_sz = VIDTV_S302M_BUF_SZ;
 	e->encoder_buf_offset = 0;
 
@@ -467,10 +470,8 @@ struct vidtv_encoder
 	e->is_video_encoder = false;
 
 	ctx = kzalloc(priv_sz, GFP_KERNEL);
-	if (!ctx) {
-		kfree(e);
-		return NULL;
-	}
+	if (!ctx)
+		goto out_kfree_buf;
 
 	e->ctx = ctx;
 	ctx->last_duration = 0;
@@ -498,6 +499,14 @@ struct vidtv_encoder
 	e->next = NULL;
 
 	return e;
+
+out_kfree_buf:
+	kfree(e->encoder_buf);
+
+out_kfree_e:
+	kfree(e->name);
+	kfree(e);
+	return NULL;
 }
 
 void vidtv_s302m_encoder_destroy(struct vidtv_encoder *e)
-- 
2.25.1

