Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FE6D47A4B0
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 06:43:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234122AbhLTFnj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 00:43:39 -0500
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132]:55193 "EHLO
        out30-132.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231863AbhLTFni (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 00:43:38 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=xianting.tian@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0V.5MXam_1639979015;
Received: from localhost(mailfrom:xianting.tian@linux.alibaba.com fp:SMTPD_---0V.5MXam_1639979015)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 20 Dec 2021 13:43:36 +0800
From:   Xianting Tian <xianting.tian@linux.alibaba.com>
To:     kraxel@redhat.com, sumit.semwal@linaro.org,
        christian.koenig@amd.com
Cc:     dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org,
        linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org,
        Xianting Tian <xianting.tian@linux.alibaba.com>
Subject: [PATCH] udmabuf: put dmabuf in case of get fd failed
Date:   Mon, 20 Dec 2021 13:43:33 +0800
Message-Id: <20211220054333.3041893-1-xianting.tian@linux.alibaba.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It needs call dma_buf_put() to put dmabuf in case of getting
fd failed.

Signed-off-by: Xianting Tian <xianting.tian@linux.alibaba.com>
---
 drivers/dma-buf/udmabuf.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/dma-buf/udmabuf.c b/drivers/dma-buf/udmabuf.c
index c57a609db..d77f96995 100644
--- a/drivers/dma-buf/udmabuf.c
+++ b/drivers/dma-buf/udmabuf.c
@@ -274,8 +274,11 @@ static long udmabuf_create(struct miscdevice *device,
 	flags = 0;
 	if (head->flags & UDMABUF_FLAGS_CLOEXEC)
 		flags |= O_CLOEXEC;
-	return dma_buf_fd(buf, flags);
+	ret = dma_buf_fd(buf, flags);
+	if (ret < 0) {
+		dma_buf_put(buf);
 
+	return ret;
 err:
 	while (pgbuf > 0)
 		put_page(ubuf->pages[--pgbuf]);
-- 
2.17.1

