Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85C0158607C
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jul 2022 21:01:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237527AbiGaTBR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jul 2022 15:01:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230114AbiGaTBP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jul 2022 15:01:15 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D33DEE0E
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jul 2022 12:01:14 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id z12so1525072wrs.9
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jul 2022 12:01:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6pSG7mQOlq9VAm3mg0gHXQ/IXxt0kekrqZ6fENnFSV0=;
        b=kEQFlBAG2kC97S15SIhVoN74Dvo3BXa8WVXfSXSWvptEu+ErgIusaSukMXVUU+4sU5
         5dMjwhxEV8dI3afW2aH/7HNWh9RzHWv2NEMbxHCstPft0Bka1kgI2T1Cuq9OtNclXia/
         3bvk0Gw9O9EGC/n3qoDWfwO+2uR+nokDDWGJqerTM5GyM2bP5B25uaQhOtf4IN2+2Z2Q
         ozbJUFPrMPYYrlTvmw7Sj7hGXKvWpXs6mttFV5Y+pXLq/SMDQ7ZKfxRl8Rqyxw2sK/Ku
         Ubmtx9nBEuvv5COeCRuE8KkyI3wHDBDJX1fwGTAvpb9FEI0xJhICjjbbnpXhUWALHrbr
         AKDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6pSG7mQOlq9VAm3mg0gHXQ/IXxt0kekrqZ6fENnFSV0=;
        b=QDTJ0JVhXgJyPw9BtCOnLLNHVgyMNVccKfmvpS0+W43RZ5kB72wCStqI/LXWvrRMeW
         jSKQm6qj2p2LlBt24yS6shQ/XnE52OeW/Iyzmn5B/lf2vzBEm/600doNITEroL0PXLz8
         fgfJXGzBhoHXFmOV+R8aWgofB1yaV2KewIZVfKEsd61JgR722WJ/M1+ndpbkDv4iK9bJ
         6BPOlI1hAbCkvBxXaUpKtL2mgH4Zh7w037kdDKWs9NHiCcnsvXcfsF+xCZU3BSx1XmNu
         e6MFVrvpJPVNfYbh6OMLaOxC4MM57qBapB2YN6RjcZ7EoPespzpA5bdD/L0WEcyFGP76
         N1HA==
X-Gm-Message-State: ACgBeo34SGWoSp9oxzRx1CUdO+/xP64nazX9KJ40lU+fJ4qQTZb4ShXn
        G/77xpNTsk9dSwddfYg+d2s=
X-Google-Smtp-Source: AA6agR6AdWGGfjQp3H0JIbnI25U2fIZ3wedUXiIvnq7oMSDCU0I0erX7/ySA7Y0oMOSdsqPi6kgaag==
X-Received: by 2002:a5d:46ca:0:b0:220:5f9b:9a77 with SMTP id g10-20020a5d46ca000000b002205f9b9a77mr2531111wrs.622.1659294073003;
        Sun, 31 Jul 2022 12:01:13 -0700 (PDT)
Received: from localhost.localdomain (host-79-27-108-198.retail.telecomitalia.it. [79.27.108.198])
        by smtp.gmail.com with ESMTPSA id bs18-20020a056000071200b0021dd08ad8d7sm1254280wrb.46.2022.07.31.12.01.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Jul 2022 12:01:11 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Jan Kara <jack@suse.cz>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Muchun Song <songmuchun@bytedance.com>,
        Ira Weiny <ira.weiny@intel.com>, linux-kernel@vger.kernel.org
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Subject: [PATCH] fs/isofs: Replace kmap() with kmap_local_page()
Date:   Sun, 31 Jul 2022 21:01:01 +0200
Message-Id: <20220731190101.7928-1-fmdefrancesco@gmail.com>
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

Cc: Jan Kara <jack@suse.cz>
Suggested-by: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
---

Many thanks to Jan Kara for the comments and suggestions provided as
reply to my previous RFC.[1] Furthermore, I want to thank Ira Weiny for
the advice he provided privately, especially about how to use mkisofs to
test that this patch works properly.

[1] https://lore.kernel.org/lkml/20220726145024.rryvw7ot7j2c6tqv@quack3/ 

 fs/isofs/compress.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/fs/isofs/compress.c b/fs/isofs/compress.c
index 95a19f25d61c..f17754484a75 100644
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
+			if (stream.next_out != (char *)zisofs_sink_page) {
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
+	if (stream.next_out && stream.next_out != (char *)zisofs_sink_page)
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

