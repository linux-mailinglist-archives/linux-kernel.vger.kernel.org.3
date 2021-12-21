Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E74147BE8F
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 12:07:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236905AbhLULH2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 06:07:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236894AbhLULH1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 06:07:27 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B31AC061574
        for <linux-kernel@vger.kernel.org>; Tue, 21 Dec 2021 03:07:27 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id a9so26109917wrr.8
        for <linux-kernel@vger.kernel.org>; Tue, 21 Dec 2021 03:07:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=M5nj+gBvQdZROHMnLR6jxrg8l7EBQjNMsTgxyewyXUU=;
        b=io5cAXMS5UqaOiSu6i7Yu72xUCmiP6/25wgJ2ecsrCYURA2QDdGtEA4RMAK9Qgp3EI
         GxY9sjivPZ4kthZ9ArnxD85NWydWugFVIXTKij2HjjNw4YKSms86DgPgUjQwy1tSMn7W
         2B72VtQFLLeqSmp9onrzLIZQAJZ5vTjFVYn/itsv5qIjmPn+Nbcx6g3lnCrvpVJ2ZJoK
         DRHA/8cmXPQBR5WaYePKZEK9gpkabLpPpPjfI+R3qrEGYGiwSnU6GBXX6Gpnc/FRg3iy
         8qJdq35gRumj7UFZAKAPofsg6S535rchXWPjINeqgSSafWEKt2WJipi4i9QGVHTmEZRz
         9WHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=M5nj+gBvQdZROHMnLR6jxrg8l7EBQjNMsTgxyewyXUU=;
        b=qQ/DbvaYLMwSFRTMlA0YJTCSgIwT9jDC0+gZSVC6yQtOUs5z72PYI7HzMNOjGSruBI
         FnSYTsl+PBm3/X2F82vcG/FxDCNyYXp2Gx6sH7gjMacfx9PJSNpvHHrCojmI8RRH/gwz
         oUn6LoVhvoMKM4CuiMCkMEtIcutgMOBIYHEX07nRthyx5uelwh/s2NcpKHVJhJDWXwQR
         33V6YMXa7/6/zmYpzmdzntqW5CQOi0vFSgsjaY+/B46+JBEh24Scjk+i0DiAP98gDIaM
         hiFJ20bIawye+PskO8ngHxnGVm56Z3RcwgTy6sq5rEgMeKSSM6MBrJ7U2ODjqr5ut4Fh
         YJTg==
X-Gm-Message-State: AOAM5302YjZ1coS3tg+x4/eWJems6ejiHbGcL9ZLmSiv6Qf70MJCKYp6
        +bUKqVzvlWSZNiirSOX0qv0=
X-Google-Smtp-Source: ABdhPJwDCCyprFCtxmBhJnotrdlSlZ2i0c4q5M7XL2cw3TYABXW5kGTbXS+bcu+52TBee7PUFp6TOQ==
X-Received: by 2002:a5d:6d41:: with SMTP id k1mr2193127wri.134.1640084845897;
        Tue, 21 Dec 2021 03:07:25 -0800 (PST)
Received: from abel.fritz.box (p57b0bff8.dip0.t-ipconnect.de. [87.176.191.248])
        by smtp.gmail.com with ESMTPSA id n7sm2138483wms.45.2021.12.21.03.07.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Dec 2021 03:07:25 -0800 (PST)
From:   "=?UTF-8?q?Christian=20K=C3=B6nig?=" 
        <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
To:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, hch@infradead.org
Subject: [PATCH] dma: Revert "make dma pool to use kmalloc_node"
Date:   Tue, 21 Dec 2021 12:07:24 +0100
Message-Id: <20211221110724.97664-1-christian.koenig@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 2618c60b8b5836b73e8deb385a036820744d256d.

While working myself into the dmapool code I've found this little odd
kmalloc_node().

What basically happens here is that we allocate the housekeeping structure
on the numa node where the device is attached to. Since the device is never
doing DMA to or from that memory this doesn't seem to make sense at all.

So while this doesn't seem to cause much harm it's probably cleaner to
revert the change for consistency.

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 mm/dmapool.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/dmapool.c b/mm/dmapool.c
index 64b537b3ccb0..a7eb5d0eb2da 100644
--- a/mm/dmapool.c
+++ b/mm/dmapool.c
@@ -152,7 +152,7 @@ struct dma_pool *dma_pool_create(const char *name, struct device *dev,
 	else if ((boundary < size) || (boundary & (boundary - 1)))
 		return NULL;
 
-	retval = kmalloc_node(sizeof(*retval), GFP_KERNEL, dev_to_node(dev));
+	retval = kmalloc(sizeof(*retval), GFP_KERNEL);
 	if (!retval)
 		return retval;
 
-- 
2.25.1

