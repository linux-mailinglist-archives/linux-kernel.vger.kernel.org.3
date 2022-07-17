Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBB0A577516
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jul 2022 10:38:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232300AbiGQIgZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Jul 2022 04:36:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiGQIgY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jul 2022 04:36:24 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 908B617599
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jul 2022 01:36:21 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id r83-20020a1c4456000000b003a2fa488efdso724617wma.4
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jul 2022 01:36:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KPdpIj6+zuOLFfGVczdnmA1kYYpvkGTEpBqmCCkcOr0=;
        b=ho0FfW0pzlLfTloSwm6NgaWVW4pOv3rtpTRxR10iGG3jkA9gzty0hmbnjYYKm4MVu1
         6KL5aXu14gFYJo419YFIBHhoNhaKn7cCtWnm6VIi8mpaFVy2w6gP+OpHpUZMxTKYMssv
         Bw5QNXHf9h65o+bnmZ/A7EcOzv2z/jeoczzZswXfyLQqtf5dzkcJRoSmLx7eUDB8tK0m
         F6NYIoJQb+rH8WRfEoq7DEYRGHZTraUcf9Wh3VuffqtuRC/CGSPU/ivWkpxj1N6e2wr2
         lkcB0CHehDxga/HVL1qJG2aUZnOohW420anJm1Nsy3GD5F5CBjg9MJ0c7Si3y8loiPgp
         bdkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KPdpIj6+zuOLFfGVczdnmA1kYYpvkGTEpBqmCCkcOr0=;
        b=qU+PLbF+q75awJZjnKTEyk7IGZmuiTmv55appMaPSeWGBuBF3VLcNePD2VAMWgFM5E
         V1EompCxxuHwAwaE5s4IUlRrrqFSnywObZyRh0yfa6168dKQbkWLWQGtJOgSwZpflAsN
         bQKUHFn6dS924BkBC28XdbCtxuaqpM9EUfWzUDHRby0Idyjrn9cpOryhZYYEF2FRkMsy
         SmYPw9aB14jlh7tvF0j+66IHnp/2LUzUwTnoL1JKCKiD6x8wiLtMZnIBoTzApsO36Czv
         kLv+KLICpfk7wCcYzfV3gIDHxalyGSC+He6jypWBik5ZVngUf6NEl6/QdzZe1Cpiv8Vm
         ICHA==
X-Gm-Message-State: AJIora89DdD8A75P6S46GiZ0RZqWeOd3FcIaLYCnrsiJfq40nwsmYjiM
        TG6BjZDUNPtEL04z1NtFhJV7XpFwmls=
X-Google-Smtp-Source: AGRyM1sqobUZzrErJtyW6GoiEJMsugB4ZhdeqcqwoPOaR3IhOIV61PAuC34TD9zvVdZFbfTK/NPJdg==
X-Received: by 2002:a05:600c:3399:b0:3a3:f1e:ebd8 with SMTP id o25-20020a05600c339900b003a30f1eebd8mr9493905wmp.6.1658046979942;
        Sun, 17 Jul 2022 01:36:19 -0700 (PDT)
Received: from localhost.localdomain (host-95-235-102-55.retail.telecomitalia.it. [95.235.102.55])
        by smtp.gmail.com with ESMTPSA id r8-20020a5d52c8000000b0021d65e9d449sm8117515wrv.73.2022.07.17.01.36.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Jul 2022 01:36:18 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
        Nick Terrell <terrelln@fb.com>,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        Ira Weiny <ira.weiny@intel.com>
Subject: [PATCH] f2fs: Delete f2fs_copy_page() and replace with memcpy_page()
Date:   Sun, 17 Jul 2022 10:36:13 +0200
Message-Id: <20220717083613.3861-1-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

f2fs_copy_page() is a wrapper around two kmap() + one memcpy() from/to
the mapped pages. It unnecessarily duplicates a kernel API and it makes
use of kmap(), which is being deprecated in favor of kmap_local_page().

Two main problems with kmap(): (1) It comes with an overhead as mapping
space is restricted and protected by a global lock for synchronization and
(2) it also requires global TLB invalidation when the kmap’s pool wraps
and it might block when the mapping space is fully utilized until a slot
becomes available.

With kmap_local_page() the mappings are per thread, CPU local, can take
page faults, and can be called from any context (including interrupts).
It is faster than kmap() in kernels with HIGHMEM enabled. Therefore, its
use in __clone_blkaddrs() is safe and should be preferred.

Delete f2fs_copy_page() and use a plain memcpy_page() in the only one
site calling the removed function. memcpy_page() avoids open coding two
kmap_local_page() + one memcpy() between the two kernel virtual addresses.

Suggested-by: Christoph Hellwig <hch@infradead.org>
Suggested-by: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
---

This patch extends the scope and replaces "f2fs: Use memcpy_page() in
f2fs_copy_page()", as suggested by Christoph Hellwig (thanks!):
https://lore.kernel.org/lkml/YtOyWOKFN9ramUyb@infradead.org/

 fs/f2fs/f2fs.h | 10 ----------
 fs/f2fs/file.c |  2 +-
 2 files changed, 1 insertion(+), 11 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index d9bbecd008d2..52be3e23ae7c 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -2696,16 +2696,6 @@ static inline struct page *f2fs_pagecache_get_page(
 	return pagecache_get_page(mapping, index, fgp_flags, gfp_mask);
 }
 
-static inline void f2fs_copy_page(struct page *src, struct page *dst)
-{
-	char *src_kaddr = kmap(src);
-	char *dst_kaddr = kmap(dst);
-
-	memcpy(dst_kaddr, src_kaddr, PAGE_SIZE);
-	kunmap(dst);
-	kunmap(src);
-}
-
 static inline void f2fs_put_page(struct page *page, int unlock)
 {
 	if (!page)
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index bd14cef1b08f..8d984aeb270f 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -1278,7 +1278,7 @@ static int __clone_blkaddrs(struct inode *src_inode, struct inode *dst_inode,
 				f2fs_put_page(psrc, 1);
 				return PTR_ERR(pdst);
 			}
-			f2fs_copy_page(psrc, pdst);
+			memcpy_page(pdst, 0, psrc, 0, PAGE_SIZE);
 			set_page_dirty(pdst);
 			f2fs_put_page(pdst, 1);
 			f2fs_put_page(psrc, 1);
-- 
2.37.1

