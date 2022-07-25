Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A05F9580297
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 18:23:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234725AbiGYQXn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 12:23:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235468AbiGYQXl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 12:23:41 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1EDE1834F
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 09:23:39 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id ss3so21429842ejc.11
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 09:23:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YwCFarmJh4PicurxfwsS6NacLOIP84PDUu/cBdBYT6E=;
        b=cF1O8ddzfyfKaJdJ4wtujqLScwlIHBFZGbaG/4vQ+/x911Q8sdQ3MO+OLOs2e9X0OV
         YzohYWePCOVpfaxfrKItmTf4IcsVt4RpHun/UxuoxLvG9NHxo0Ts9dsqlA+nCv/IiSGC
         r0iLjJ819dUEAB1HnLXUpQKmk98DfuEOCgATbyxyTa3XsqrIjzrVGpYiUK0aqwzeMex+
         Yn7mrkngkOepHB1KTuVwtgNGGfImwaRGi0fsXjdoL+luNlHv9Y81FB7ZTVsBSua0ZHy1
         vODcbnjXfGk2bNTZ+MM9bqk5p9bVyw616GrnZiQ5vBAql0/SauUbswPZGGnl2j/S+m0U
         RCZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YwCFarmJh4PicurxfwsS6NacLOIP84PDUu/cBdBYT6E=;
        b=1oX/rht00u0dBn8BrtjTwh/++ljktCH/oHAMaPpAsiDIBTf4vklKC6QIe0A5uoT5E/
         5bkmbr4FgICWq1S7eCYiIhOD1gZizz4hiKsYUmg+eLawh3yzaYS2hASJDODE5CDryR9x
         vcO3gOOHAVHPhMLcQInoWTMhazYqwWUwGyIcX730YDW8siWG2cGgk6ECkqPl50bFLmp2
         JBpAEP+ukZCJLipepu819+8958GyargGrgebf4lVqk/Ex3VYEOkofGLX7ig7wLimh5BY
         ectFjRaOHSMuox//D7EDNCTyICI6qkSle/ltdJ22O/MclsfiOmYHyeBrm0oFtKAHvzOM
         RsVw==
X-Gm-Message-State: AJIora9b2BJp4TCgG3SXMAX7iItqvxcl6Wzpp0d+qSm+ctJ8SJ7WKQeC
        w6KlJceJ8wfL2pDjrgxtC//eTMO4x8Q=
X-Google-Smtp-Source: AGRyM1sUxh6g1PqZYFiNAssUhRB5i8BMUkNa89nNIM+alMp3cbdjD0LmJZ05+Wlz6K1kgctXFBS/pw==
X-Received: by 2002:a17:907:a0c6:b0:72e:ee9a:cf89 with SMTP id hw6-20020a170907a0c600b0072eee9acf89mr10333441ejc.43.1658766218373;
        Mon, 25 Jul 2022 09:23:38 -0700 (PDT)
Received: from localhost.localdomain (host-79-56-6-250.retail.telecomitalia.it. [79.56.6.250])
        by smtp.gmail.com with ESMTPSA id kw23-20020a170907771700b007263713cfe9sm1576210ejc.169.2022.07.25.09.23.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jul 2022 09:23:37 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Jan Kara <jack@suse.cz>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Muchun Song <songmuchun@bytedance.com>,
        linux-kernel@vger.kernel.org
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Ira Weiny <ira.weiny@intel.com>
Subject: [RFC PATCH] fs/isofs: Replace kmap() with kmap_local_page()
Date:   Mon, 25 Jul 2022 18:23:31 +0200
Message-Id: <20220725162331.9825-1-fmdefrancesco@gmail.com>
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

This is an RFC because these changes have not been tested (tests are
welcome!), therefore I'm not entirely sure whether these conversions work
properly. I'd like to hear comments from more experienced developers
before sending a real patch. Suggestions about how to run tests would
also be much appreciated.

Suggested-by: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
---
 fs/isofs/compress.c | 24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/fs/isofs/compress.c b/fs/isofs/compress.c
index 95a19f25d61c..a1562124bb91 100644
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
@@ -120,8 +119,7 @@ static loff_t zisofs_uncompress_block(struct inode *inode, loff_t block_start,
 	       zerr != Z_STREAM_END) {
 		if (!stream.avail_out) {
 			if (pages[curpage]) {
-				stream.next_out = page_address(pages[curpage])
-						+ poffset;
+				stream.next_out = kmap_local_page(pages[curpage] + poffset);
 				stream.avail_out = PAGE_SIZE - poffset;
 				poffset = 0;
 			} else {
@@ -170,6 +168,12 @@ static loff_t zisofs_uncompress_block(struct inode *inode, loff_t block_start,
 			}
 		}
 
+		if (stream.next_out)
+			if (stream.next_out != (char *)zisofs_sink_page) {
+				kunmap_local(stream.next_out);
+				stream.next_out = NULL;
+			}
+
 		if (!stream.avail_out) {
 			/* This page completed */
 			if (pages[curpage]) {
@@ -183,6 +187,9 @@ static loff_t zisofs_uncompress_block(struct inode *inode, loff_t block_start,
 	}
 inflate_out:
 	zlib_inflateEnd(&stream);
+	if (stream.next_out)
+		if (stream.next_out != (char *)zisofs_sink_page)
+			kunmap_local(stream.next_out);
 
 z_eio:
 	mutex_unlock(&zisofs_zlib_lock);
@@ -283,9 +290,7 @@ static int zisofs_fill_pages(struct inode *inode, int full_page, int pcount,
 	}
 
 	if (poffset && *pages) {
-		memset(page_address(*pages) + poffset, 0,
-		       PAGE_SIZE - poffset);
-		flush_dcache_page(*pages);
+		memzero_page(*pages, poffset, PAGE_SIZE - poffset);
 		SetPageUptodate(*pages);
 	}
 	return 0;
@@ -343,10 +348,8 @@ static int zisofs_read_folio(struct file *file, struct folio *folio)
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
@@ -357,7 +360,6 @@ static int zisofs_read_folio(struct file *file, struct folio *folio)
 			flush_dcache_page(pages[i]);
 			if (i == full_page && err)
 				SetPageError(pages[i]);
-			kunmap(pages[i]);
 			unlock_page(pages[i]);
 			if (i != full_page)
 				put_page(pages[i]);
-- 
2.37.1

