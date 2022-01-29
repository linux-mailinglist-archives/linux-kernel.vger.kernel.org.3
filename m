Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 502274A3033
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jan 2022 16:06:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243122AbiA2PGp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jan 2022 10:06:45 -0500
Received: from mta-13-4.privateemail.com ([198.54.127.109]:53839 "EHLO
        MTA-13-4.privateemail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241780AbiA2PGm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jan 2022 10:06:42 -0500
X-Greylist: delayed 1740 seconds by postgrey-1.27 at vger.kernel.org; Sat, 29 Jan 2022 10:06:41 EST
Received: from mta-13.privateemail.com (localhost [127.0.0.1])
        by mta-13.privateemail.com (Postfix) with ESMTP id D991818000BE;
        Sat, 29 Jan 2022 10:06:40 -0500 (EST)
Received: from localhost.localdomain (unknown [10.20.151.172])
        by mta-13.privateemail.com (Postfix) with ESMTPA id 3071B18000A5;
        Sat, 29 Jan 2022 10:06:37 -0500 (EST)
From:   Jordy Zomer <jordy@pwning.systems>
To:     linux-kernel@vger.kernel.org
Cc:     Jordy Zomer <jordy@pwning.systems>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Liam Mark <lmark@codeaurora.org>,
        Laura Abbott <labbott@redhat.com>,
        Brian Starkey <Brian.Starkey@arm.com>,
        John Stultz <john.stultz@linaro.org>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linaro-mm-sig@lists.linaro.org
Subject: [PATCH] dma-buf: heaps: Fix potential spectre v1 gadget
Date:   Sat, 29 Jan 2022 16:06:04 +0100
Message-Id: <20220129150604.3461652-1-jordy@pwning.systems>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It appears like nr could be a Spectre v1 gadget as it's supplied by a
user and used as an array index. Prevent the contents
of kernel memory from being leaked to userspace via speculative
execution by using array_index_nospec.

Signed-off-by: Jordy Zomer <jordy@pwning.systems>
---
 drivers/dma-buf/dma-heap.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/dma-buf/dma-heap.c b/drivers/dma-buf/dma-heap.c
index 56bf5ad01ad5..8f5848aa144f 100644
--- a/drivers/dma-buf/dma-heap.c
+++ b/drivers/dma-buf/dma-heap.c
@@ -14,6 +14,7 @@
 #include <linux/xarray.h>
 #include <linux/list.h>
 #include <linux/slab.h>
+#include <linux/nospec.h>
 #include <linux/uaccess.h>
 #include <linux/syscalls.h>
 #include <linux/dma-heap.h>
@@ -135,6 +136,7 @@ static long dma_heap_ioctl(struct file *file, unsigned int ucmd,
 	if (nr >= ARRAY_SIZE(dma_heap_ioctl_cmds))
 		return -EINVAL;
 
+	nr = array_index_nospec(nr, ARRAY_SIZE(dma_heap_ioctl_cmds));
 	/* Get the kernel ioctl cmd that matches */
 	kcmd = dma_heap_ioctl_cmds[nr];
 
-- 
2.27.0

