Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BECCA583969
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 09:24:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234258AbiG1HYZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 03:24:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231701AbiG1HYX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 03:24:23 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C50E5B7AD
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 00:24:23 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id iw1so1069833plb.6
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 00:24:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RB/SZ70a/o/tX4AnScvsyN+T3/w9iKfaj6s0tJ9DxGk=;
        b=Q8HbnqLgKGVIGAXotMRHn4ea9s5wHTZxkXOYz1Pw3zvZZJdXhQpErRMPQ6GNb5miES
         YO8dJskLT1VPjXWBxCRRC4HZdr8EizEEZOMQfLblUQhnMi4ldT86CMncNypaQtrnH2PF
         AaKaCvNaA9r0IWlFyvSbEevNUGBbjp2DSzuR3mnKSYGa1lFcWa7WYA/5Ucua6fM+nYcg
         jXA9SoFH91F9B/7GXbVEJV4pWVbHbF8rk7XNR5CMXhaPFsbZFE0d8P2jgEFvN7nyYVhv
         xatRjOAS+6LZqFjltk8aoHNnUwcN4GAHWiL3FKA6eoiwLiLZsng9BSOUjINuGCUuvaML
         oS1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RB/SZ70a/o/tX4AnScvsyN+T3/w9iKfaj6s0tJ9DxGk=;
        b=YChmDBj5Wxw4F+a5aeMgZNJweVJkWqYY1hcZ2gZ4n7I5vHUi5KIDkbzd+llHvJPaHj
         ENsJpeRomOoJo9WuSqa40+EQK0BtGtst3oW39Pa5eQW0dDuVSjRo/fP1vsU+20IUrcPz
         qVv6B6Dtt+RPVTl3gfMBUlNxowR50A033+/xGgtPADBHz2C4sGljuOq7F/vr31Xauarb
         jxZLVV/aBQNAhVvtpdd0zo5HNwtyI/aRsWYumFPyHZpi1h2pf3FrO4b7+i0zfivTxTQJ
         Dsi3TyadsAwK17b4S+Ss8Wlw4gNNNT2/62XZYgJ7QyOoBcOrlSh2DvYNTCgyUx8MZ40G
         gjyQ==
X-Gm-Message-State: AJIora8XgLSgn7PefN4ojM8KKss3xk0zIdL1578immruRg1clF1pK8Y0
        oRHRzymvCsw1l0FXrd25vag=
X-Google-Smtp-Source: AGRyM1v2SL8vO2wqMYgcK7IAS3AJ7pWQUytXnxtvV1R0OVvb4TwOsL5cEFdHlPY+N80yIS5RfpzmfQ==
X-Received: by 2002:a17:90b:4ac7:b0:1f2:8413:1b02 with SMTP id mh7-20020a17090b4ac700b001f284131b02mr8659496pjb.142.1658993062818;
        Thu, 28 Jul 2022 00:24:22 -0700 (PDT)
Received: from ubuntu-Virtual-Machine.corp.microsoft.com ([2001:4898:80e8:37:8c3c:b6ff:9cab:ee94])
        by smtp.gmail.com with ESMTPSA id q13-20020a631f4d000000b0041239bf9be8sm347452pgm.1.2022.07.28.00.24.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jul 2022 00:24:22 -0700 (PDT)
From:   Tianyu Lan <ltykernel@gmail.com>
To:     hch@infradead.org, m.szyprowski@samsung.com, robin.murphy@arm.com
Cc:     Tianyu Lan <tiala@microsoft.com>, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] swiotlb: Fix passing local variable to debugfs_create_ulong()
Date:   Thu, 28 Jul 2022 03:24:20 -0400
Message-Id: <20220728072420.1782744-1-ltykernel@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tianyu Lan <tiala@microsoft.com>

Debugfs node will be run-timely checked and so local variable
should be not passed to debugfs_create_ulong(). Fix it via
debugfs_create_file() to create io_tlb_used node and calculate
used io tlb number with fops_io_tlb_used attribute.

Fixes: 20347fca71a3 ("swiotlb: split up the global swiotlb lock")
Signed-off-by: Tianyu Lan <tiala@microsoft.com>
---
 kernel/dma/swiotlb.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index cc50f1fb127f..69986cffda5f 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -912,17 +912,24 @@ bool is_swiotlb_active(struct device *dev)
 }
 EXPORT_SYMBOL_GPL(is_swiotlb_active);
 
+static int io_tlb_used_get(void *data, u64 *val)
+{
+	*val = mem_used(&io_tlb_default_mem);
+
+	return 0;
+}
+DEFINE_DEBUGFS_ATTRIBUTE(fops_io_tlb_used, io_tlb_used_get, NULL, "%llu\n");
+
 static void swiotlb_create_debugfs_files(struct io_tlb_mem *mem,
 					 const char *dirname)
 {
-	unsigned long used = mem_used(mem);
-
 	mem->debugfs = debugfs_create_dir(dirname, io_tlb_default_mem.debugfs);
 	if (!mem->nslabs)
 		return;
 
 	debugfs_create_ulong("io_tlb_nslabs", 0400, mem->debugfs, &mem->nslabs);
-	debugfs_create_ulong("io_tlb_used", 0400, mem->debugfs, &used);
+	debugfs_create_file("io_tlb_used", 0400, mem->debugfs, NULL,
+			&fops_io_tlb_used);
 }
 
 static int __init __maybe_unused swiotlb_create_default_debugfs(void)
-- 
2.25.1

