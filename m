Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7913459B5BA
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Aug 2022 19:50:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230453AbiHURu3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Aug 2022 13:50:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231387AbiHURu0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Aug 2022 13:50:26 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1C3C17E1D
        for <linux-kernel@vger.kernel.org>; Sun, 21 Aug 2022 10:50:24 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id ca13so6047659ejb.9
        for <linux-kernel@vger.kernel.org>; Sun, 21 Aug 2022 10:50:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=kCT+kY+pxIqvLumJULX2iwyMToWhruEPioR8K3WE5dw=;
        b=LBkl15RlPsR/CVEaIxiYKWHevObk45s2/wFF3/uRIb5g8xBHeIrkPr1X4uSEy1rFCC
         Tblo9enDqlZY8qGwB0F/kSTwzgpannOiTIPdw5zK3xyy5/OSSTcn1IAqKU7fPshCg80p
         VH0ohjAo0oZBsmmmgrS+oi75pwOFeAp+ooB3sq6Bkai+gzjBBPzKgI+VZ8mfuFxKwRCx
         FZuqjQg0y2WHjPIkFW9hOmvgDBMyfEqpEwoc/PzIGRXn3NnyGnRuVTgwP+rDCiQxAY8R
         5qvBjEw/szW9uLtZJIa0f5hTB8HeS478rPKpkVRUxjgSBzm4bxvE/B/NVm/tdkGSKyrF
         iLTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=kCT+kY+pxIqvLumJULX2iwyMToWhruEPioR8K3WE5dw=;
        b=qYVVu1IgZcuOIBoKW0Qra7xpusP6vAMGJ8clKk83iVUDyrJmo6pbfcIJDyHtQKBVBW
         A/qGmO09J0dg56uEechWVKwFoENHmSvj27c0WlnFgZ+CIo/CN/Fw85xKrn9CKC2+5vff
         dUgx/omwNKiTns2UjVyKcSqfEPPat02ZxSOBK/2VN6MCrTvZFGTGAOAiLOz7Z7quxjGh
         NDFSMLvDYnZYLUdVSxGBcmG8N3jKeMAKdKE2dLDOXxo0aCoa6jVtPol9S82uEGhVyblP
         zr8BzOMF4QKy22PUsx8vLVHfoJNTlbhtjXOEeslSaf0v2Y72KwaLK16MD2hR6kAZRnV3
         fmDQ==
X-Gm-Message-State: ACgBeo05/VYnPDRqcN1qkRdztQ7rBPM1ZmtGJQUz7/3j3MY0mWhzJVME
        e8x65LoUXAKh5frFZ4I3hkE=
X-Google-Smtp-Source: AA6agR7bHl9NY0CG6093KT5YBUkgGAg/b2EmECMU3lp+pYN+emTuzF1YQ1g0/3MMfztObo5GXsMybQ==
X-Received: by 2002:a17:907:6e8f:b0:73d:81a1:d565 with SMTP id sh15-20020a1709076e8f00b0073d81a1d565mr1018938ejc.675.1661104223409;
        Sun, 21 Aug 2022 10:50:23 -0700 (PDT)
Received: from localhost.localdomain (host-87-17-106-94.retail.telecomitalia.it. [87.17.106.94])
        by smtp.gmail.com with ESMTPSA id u18-20020a1709061db200b00726c0e63b94sm5086252ejh.27.2022.08.21.10.50.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Aug 2022 10:50:21 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Jan Kara <jack@suse.cz>,
        Muchun Song <songmuchun@bytedance.com>,
        Jens Axboe <axboe@kernel.dk>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Bart Van Assche <bvanassche@acm.org>,
        linux-kernel@vger.kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Ira Weiny <ira.weiny@intel.com>,
        kernel test robot <lkp@intel.com>
Subject: [RESEND PATCH v2] fs/isofs: Replace kmap() with kmap_local_page()
Date:   Sun, 21 Aug 2022 19:50:12 +0200
Message-Id: <20220821175012.6866-1-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The use of kmap() is being deprecated in favor of kmap_local_page().

There are two main problems with kmap(): (1) It comes with an overhead as
mapping space is restricted and protected by a global lock for
synchronization and (2) it also requires global TLB invalidation when the
kmap’s pool wraps and it might block when the mapping space is fully
utilized until a slot becomes available.

With kmap_local_page() the mappings are per thread, CPU local, can take
page faults, and can be called from any context (including interrupts).
Tasks can be preempted and, when scheduled to run again, the kernel
virtual addresses are restored and still valid. It is faster than kmap()
in kernels with HIGHMEM enabled.

Since kmap_local_page() can be safely used in compress.c, it should be
called everywhere instead of kmap().

Therefore, replace kmap() with kmap_local_page() in compress.c. Where it
is needed, use memzero_page() instead of open coding kmap_local_page()
plus memset() to fill the pages with zeros. Delete the redundant
flush_dcache_page() in the two call sites of memzero_page().

Tested with mkisofs on a QEMU/KVM x86_32 VM, 6GB RAM, booting a kernel
with HIGHMEM64GB enabled.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Jan Kara <jack@suse.cz>
Suggested-by: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
---

Some days ago Andrew requested a resend of this patch.[1]

v1->v2: Cast zisofs_sink_page to pointer to unsigned char.
Reported-by: kernel test robot <lkp@intel.com>

Many thanks to Jan Kara for the comments and suggestions provided with
replying to my previous RFC.[2] Furthermore, I want to thank Ira Weiny for
the advices he provided, especially about how to use mkisofs to test that
this patch is working properly.

[1] https://lore.kernel.org/all/20220801122709.8164-1-fmdefrancesco@gmail.com/
[2] https://lore.kernel.org/lkml/20220726145024.rryvw7ot7j2c6tqv@quack3/

 fs/isofs/compress.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/fs/isofs/compress.c b/fs/isofs/compress.c
index 95a19f25d61c..107007c38d08 100644
--- a/fs/isofs/compress.c
+++ b/fs/isofs/compress.c
@@ -67,8 +67,7 @@ static loff_t zisofs_uncompress_block(struct inode *inode, loff_t block_start,
 		for ( i = 0 ; i < pcount ; i++ ) {
 			if (!pages[i])
 				continue;
-			memset(page_address(pages[i]), 0, PAGE_SIZE);
-			flush_dcache_page(pages[i]);
+			memzero_page(pages[i], 0, PAGE_SIZE);
 			SetPageUptodate(pages[i]);
 		}
 		return ((loff_t)pcount) << PAGE_SHIFT;
@@ -120,7 +119,7 @@ static loff_t zisofs_uncompress_block(struct inode *inode, loff_t block_start,
 	       zerr != Z_STREAM_END) {
 		if (!stream.avail_out) {
 			if (pages[curpage]) {
-				stream.next_out = page_address(pages[curpage])
+				stream.next_out = kmap_local_page(pages[curpage])
 						+ poffset;
 				stream.avail_out = PAGE_SIZE - poffset;
 				poffset = 0;
@@ -176,6 +175,10 @@ static loff_t zisofs_uncompress_block(struct inode *inode, loff_t block_start,
 				flush_dcache_page(pages[curpage]);
 				SetPageUptodate(pages[curpage]);
 			}
+			if (stream.next_out != (unsigned char *)zisofs_sink_page) {
+				kunmap_local(stream.next_out);
+				stream.next_out = NULL;
+			}
 			curpage++;
 		}
 		if (!stream.avail_in)
@@ -183,6 +186,8 @@ static loff_t zisofs_uncompress_block(struct inode *inode, loff_t block_start,
 	}
 inflate_out:
 	zlib_inflateEnd(&stream);
+	if (stream.next_out && stream.next_out != (unsigned char *)zisofs_sink_page)
+		kunmap_local(stream.next_out);
 
 z_eio:
 	mutex_unlock(&zisofs_zlib_lock);
@@ -283,9 +288,7 @@ static int zisofs_fill_pages(struct inode *inode, int full_page, int pcount,
 	}
 
 	if (poffset && *pages) {
-		memset(page_address(*pages) + poffset, 0,
-		       PAGE_SIZE - poffset);
-		flush_dcache_page(*pages);
+		memzero_page(*pages, poffset, PAGE_SIZE - poffset);
 		SetPageUptodate(*pages);
 	}
 	return 0;
@@ -343,10 +346,8 @@ static int zisofs_read_folio(struct file *file, struct folio *folio)
 	for (i = 0; i < pcount; i++, index++) {
 		if (i != full_page)
 			pages[i] = grab_cache_page_nowait(mapping, index);
-		if (pages[i]) {
+		if (pages[i])
 			ClearPageError(pages[i]);
-			kmap(pages[i]);
-		}
 	}
 
 	err = zisofs_fill_pages(inode, full_page, pcount, pages);
@@ -357,7 +358,6 @@ static int zisofs_read_folio(struct file *file, struct folio *folio)
 			flush_dcache_page(pages[i]);
 			if (i == full_page && err)
 				SetPageError(pages[i]);
-			kunmap(pages[i]);
 			unlock_page(pages[i]);
 			if (i != full_page)
 				put_page(pages[i]);
-- 
2.37.1

