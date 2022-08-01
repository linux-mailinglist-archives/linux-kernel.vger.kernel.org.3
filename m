Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A470C586B0D
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 14:44:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234635AbiHAMoF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 08:44:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234834AbiHAMnm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 08:43:42 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1920B3FA22
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 05:27:18 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id j15so5841765wrr.2
        for <linux-kernel@vger.kernel.org>; Mon, 01 Aug 2022 05:27:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nLKdQQ5g3ou50dhyIdW6eWtXk/tWTXotcdzpp32Zmcs=;
        b=Mr/s1tlx4/ydwVD50h+BuznAd+SNslOgaw3OXGHBKbaduMKEvI//MsCHsvmgcnWbez
         Z22Ha66Hw1yjPwZpTskwqRfJVnktWw09PgtbqZzIs3vbcXfdd82ItcVLKE9Lsys7US/8
         xRiRi7+DGcTz8R6PYH0Fm7/gagMHkoBnEa4qFF7BlWSzv8fkbBRv8WQugFgZNbCA1lL7
         W+QfFghrpei/aTmEPHeErWCAvs+tq2Bgqi6PK+7oMK3cCL6qpusCpOmCnPWm8VKXcvW0
         jS8J4tpNNb/6siyuCmo3eoABbS7XOIDmIiyviP+l+jT1S4tlmlCwUMJ3W9X+ugKp2h6n
         fiAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nLKdQQ5g3ou50dhyIdW6eWtXk/tWTXotcdzpp32Zmcs=;
        b=DDGsgeVQ3zAmyI8bY8sJ/XpsYoZuQLvcauArERBE9yBgxnW7O9CAh9mieUgHXnGqH8
         Me0qBIF7VT5g/0uI04GkcG6ePNpVfGgMNHkHkYFxa52CyT1T2u8/9zdZ0ad8+GvOPyz2
         fB3Pf7xj80XTXU78DoXjzyGtg/Z7JUX5hzghuQP2PeSGuhwjUh4mm7Jayb/bAdusLU85
         tY8W8EPGtpk5jADs6LCYMKSO59FQkdRDgBTrchAQeVhlfrKyw9npUs0r30wOBEwgIBLa
         TB961O4yVHzjqU27866TNK2+T+8/LUDnN6f5qzI52zUhHmLS213CZGO1owzMXyupBH71
         bv6Q==
X-Gm-Message-State: ACgBeo0bXa5qLA0/KKHu/G7tWu7f+zbD6gX71NYnATxm6V12f6+ubG3d
        E7/zm3YPtFLV5l3J7n2KEi4=
X-Google-Smtp-Source: AA6agR4j85qMHT/7R/CkURi692BI1xDOTS7V2jmJ/5xMKAi4WXmDI6fi8tLL4l5W1JEPteWnuGKrVA==
X-Received: by 2002:a5d:4fcc:0:b0:21f:dd9:df09 with SMTP id h12-20020a5d4fcc000000b0021f0dd9df09mr10418799wrw.294.1659356836572;
        Mon, 01 Aug 2022 05:27:16 -0700 (PDT)
Received: from localhost.localdomain (host-79-27-108-198.retail.telecomitalia.it. [79.27.108.198])
        by smtp.gmail.com with ESMTPSA id t16-20020a5d42d0000000b0021f17542fe2sm7954707wrr.84.2022.08.01.05.27.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Aug 2022 05:27:15 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Jan Kara <jack@suse.cz>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Muchun Song <songmuchun@bytedance.com>,
        "Theodore Ts'o" <tytso@mit.edu>, Ira Weiny <ira.weiny@intel.com>,
        linux-kernel@vger.kernel.org
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH v2] fs/isofs: Replace kmap() with kmap_local_page()
Date:   Mon,  1 Aug 2022 14:27:09 +0200
Message-Id: <20220801122709.8164-1-fmdefrancesco@gmail.com>
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

v1->v2: Cast zisofs_sink_page to pointer to unsigned char.
Reported-by: kernel test robot <lkp@intel.com>

Many thanks to Jan Kara for the comments and suggestions provided with
replying to my previous RFC.[1] Furthermore, I want to thank Ira Weiny for
the advices he provided, especially about how to use mkisofs to test that
this patch is working properly.

[1] https://lore.kernel.org/lkml/20220726145024.rryvw7ot7j2c6tqv@quack3/

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

