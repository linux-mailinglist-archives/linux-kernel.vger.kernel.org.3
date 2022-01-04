Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D15A483CFC
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 08:36:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232242AbiADHgQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 02:36:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230366AbiADHgP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 02:36:15 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12017C061761;
        Mon,  3 Jan 2022 23:36:15 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id k18so37587397wrg.11;
        Mon, 03 Jan 2022 23:36:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5QgurAW0lNK9DtZ5aiYOIjTcb84ucRlepZxkJq+T308=;
        b=GatvyyE/kBqheoYQ/d13MygNqovRYyBIG1SdlHBTM1JWbwgDE3yn5BdZmHzV8HNnvD
         rmimV5S7wUikeOcwGIyS15JbLAw7OU1rycZIfjDo20/Z+pwuC3BigTkotG+zY4Z3RYi2
         e3Na7QyiJiekB7fK2RCVkTJKTz/P8RzAoNvkGvsJH8h2hE7U8ECkMOXtgytKJdpoqgOF
         IUTKXMadctzVM8Lvz9v06fMMeae/oeEe4C8ta1Fai/ggwnhkSQ1ORvJy7e4G5uk+p81v
         nPgtzhQqJCGHo8e/zXUhVqDmmFor3xL5Wzpl6GyWhqpLJmRwhIxS2YHwtQMLBUXGuPg5
         ITsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5QgurAW0lNK9DtZ5aiYOIjTcb84ucRlepZxkJq+T308=;
        b=fwkO3w4qBVxfEnYKVSHXXG0gLl4LWmViTXYzsLVDoiDgJCUqiVagc2Vy8IGcXGl34o
         cOd0xkfIOdoK/lmQybhkEhgjBCXnkAJYAxI6nqpwOttQmX0P7K1ldETBEcR9t1xrOJr0
         7Yw9xsvL+EVl/8NZkJXk/C7BBLLHw6QwKq/Lqh4giU5bDV0pcyE9oao5n2xstGvFov0M
         ikLPSke6vkqa4aJ3Yc7Hl+FVxDapxn4EKihUSDOl9lHLllZvYi+NecwTWhhZ6LOGHEss
         ZOi2YYOT0MY8MgZEo606DmJ+YVeH1Df/EfJ8RD7h786uJQNNAyFHenrSA86pAf12ydfO
         C7Ng==
X-Gm-Message-State: AOAM531hh8XUocCJZ0oJN/fTZHO6N5iKIXFhZ3BBoZzI9RzyzX/A1z5U
        lOEfd0Sgy7JDkWOPzjT4ies=
X-Google-Smtp-Source: ABdhPJwWuBVqvqiAa6SL5fPaQqllfHGw/SdK0Uc5+CN6wLMv/wwUKJbrSULom+MJXNBTgh1mRkzIPw==
X-Received: by 2002:a05:6000:2aa:: with SMTP id l10mr42207978wry.518.1641281773701;
        Mon, 03 Jan 2022 23:36:13 -0800 (PST)
Received: from ownia.. ([103.105.48.220])
        by smtp.gmail.com with ESMTPSA id l12sm43064477wmq.2.2022.01.03.23.36.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jan 2022 23:36:13 -0800 (PST)
From:   Weizhao Ouyang <o451686892@gmail.com>
To:     Sumit Semwal <sumit.semwal@linaro.org>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        Liam Mark <lmark@codeaurora.org>,
        Laura Abbott <labbott@kernel.org>,
        Brian Starkey <Brian.Starkey@arm.com>,
        John Stultz <john.stultz@linaro.org>, christian.koenig@amd.com
Cc:     linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org,
        Weizhao Ouyang <o451686892@gmail.com>
Subject: [PATCH] dma-buf: cma_heap: Fix mutex locking section
Date:   Tue,  4 Jan 2022 15:35:45 +0800
Message-Id: <20220104073545.124244-1-o451686892@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix cma_heap_buffer mutex locking critical section to protect vmap_cnt
and vaddr.

Fixes: a5d2d29e24be ("dma-buf: heaps: Move heap-helper logic into the cma_heap implementation")
Signed-off-by: Weizhao Ouyang <o451686892@gmail.com>
---
 drivers/dma-buf/heaps/cma_heap.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/dma-buf/heaps/cma_heap.c b/drivers/dma-buf/heaps/cma_heap.c
index 0c05b79870f9..83f02bd51dda 100644
--- a/drivers/dma-buf/heaps/cma_heap.c
+++ b/drivers/dma-buf/heaps/cma_heap.c
@@ -124,10 +124,11 @@ static int cma_heap_dma_buf_begin_cpu_access(struct dma_buf *dmabuf,
 	struct cma_heap_buffer *buffer = dmabuf->priv;
 	struct dma_heap_attachment *a;
 
+	mutex_lock(&buffer->lock);
+
 	if (buffer->vmap_cnt)
 		invalidate_kernel_vmap_range(buffer->vaddr, buffer->len);
 
-	mutex_lock(&buffer->lock);
 	list_for_each_entry(a, &buffer->attachments, list) {
 		if (!a->mapped)
 			continue;
@@ -144,10 +145,11 @@ static int cma_heap_dma_buf_end_cpu_access(struct dma_buf *dmabuf,
 	struct cma_heap_buffer *buffer = dmabuf->priv;
 	struct dma_heap_attachment *a;
 
+	mutex_lock(&buffer->lock);
+
 	if (buffer->vmap_cnt)
 		flush_kernel_vmap_range(buffer->vaddr, buffer->len);
 
-	mutex_lock(&buffer->lock);
 	list_for_each_entry(a, &buffer->attachments, list) {
 		if (!a->mapped)
 			continue;
-- 
2.32.0

