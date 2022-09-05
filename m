Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 131565ACD85
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 10:17:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237362AbiIEIQv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 04:16:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237202AbiIEIQY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 04:16:24 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D71B231DEE
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 01:16:20 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id 202so7481907pgc.8
        for <linux-kernel@vger.kernel.org>; Mon, 05 Sep 2022 01:16:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=MkTg5zDd6KOHOk4vuhlZ6bZv6q468yLoqf3LP8Ucpys=;
        b=Yh6VENY7q3YjaerT3c1AQXDjiIILaH8AUngGutf7HnKvu8GAnr9IlHVsTgfRuTLGOO
         OKBaaaGmULjMztF0WOR43xP/EjqpicbbeSx+EEE6wGwDXLoLTYATlGao7+E9mhA0InQW
         EdYiOFN772ahgE+GNg4JzbKFc/cocrdCjFz8U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=MkTg5zDd6KOHOk4vuhlZ6bZv6q468yLoqf3LP8Ucpys=;
        b=JDwGJll3HsA/uFlv0nOwOMaDH4nDulLLtU8z+KYZ2QkJ5NDexnT5sFb38FPt7lYwGj
         FzK1BuT/uXRN9qOCXwAThS8oDcxXEjtoD2z8FxfrdoRBzWW26xDF4qFf6vmVHFGT+3nv
         hnDM2IM1nNHC45/90FaBjZD2WTAYGFcpvSgdTNm98rNnlY/LgsErpqVMWQLbsR0BoDIu
         LgjW8yr215KBy2+WzJrswoCxJnoxG1xtgmVp/W7YFARTB3GfEB92Rh3hiZqAWFVe1VK2
         y4sCvWyTRjJRx1ABAIw8Pu5OjRo7jFIdvFHDBkr9DMV5R6Fxj/7MCfKtDC/vSaPIKjHz
         2GdA==
X-Gm-Message-State: ACgBeo2ES3XhZnK7+xV9hLYri7S5dCOPG5WMR3qSdAg8s+sBc+eNyHo1
        qzm3kighgrJmqgD9w+2HNoNGdA==
X-Google-Smtp-Source: AA6agR5MfYBqXmqx8e3N43HvnHj+epezxnhAQ669hTNgt9FrJdUmOYNGNHPziNFBCcO5mcmBn1/e8g==
X-Received: by 2002:a63:26c7:0:b0:434:5712:8432 with SMTP id m190-20020a6326c7000000b0043457128432mr3647624pgm.404.1662365780348;
        Mon, 05 Sep 2022 01:16:20 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:71e2:8444:42d9:4bb0])
        by smtp.gmail.com with ESMTPSA id w12-20020aa79a0c000000b005363bc65bafsm7075864pfj.57.2022.09.05.01.16.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Sep 2022 01:16:19 -0700 (PDT)
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Nitin Gupta <ngupta@vflare.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCH RFC 3/7] zram: Factor out WB and non-WB zram read functions
Date:   Mon,  5 Sep 2022 17:15:48 +0900
Message-Id: <20220905081552.2740917-7-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
In-Reply-To: <20220905081552.2740917-1-senozhatsky@chromium.org>
References: <20220905081552.2740917-1-senozhatsky@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We will use non-WB variant in ZRAM page recompression path.

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 drivers/block/zram/zram_drv.c | 66 +++++++++++++++++++++++++----------
 1 file changed, 47 insertions(+), 19 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 694c8c426cb2..de2970865b7b 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -1325,8 +1325,33 @@ static void zram_free_page(struct zram *zram, size_t index)
 		~(1UL << ZRAM_LOCK | 1UL << ZRAM_UNDER_WB));
 }
 
-static int __zram_bvec_read(struct zram *zram, struct page *page, u32 index,
-				struct bio *bio, bool partial_io)
+/*
+ * Reads a page from the writeback devices. Corresponding ZRAM slot
+ * should be unlocked.
+ */
+static int zram_read_from_writeback(struct zram *zram,
+				    struct page *page,
+				    u32 index,
+				    struct bio *bio,
+				    bool partial_io)
+{
+	struct bio_vec bvec;
+
+	bvec.bv_page = page;
+	bvec.bv_len = PAGE_SIZE;
+	bvec.bv_offset = 0;
+	return read_from_bdev(zram, &bvec,
+			      zram_get_element(zram, index),
+			      bio, partial_io);
+}
+
+/*
+ * Reads (decompresses if needed) a page from zspool (zsmalloc).
+ * Corresponding ZRAM slot should be locked.
+ */
+static int zram_read_from_zspool(struct zram *zram,
+				 struct page *page,
+				 u32 index)
 {
 	struct zcomp_strm *zstrm;
 	unsigned long handle;
@@ -1334,20 +1359,6 @@ static int __zram_bvec_read(struct zram *zram, struct page *page, u32 index,
 	void *src, *dst;
 	int ret;
 
-	zram_slot_lock(zram, index);
-	if (zram_test_flag(zram, index, ZRAM_WB)) {
-		struct bio_vec bvec;
-
-		zram_slot_unlock(zram, index);
-
-		bvec.bv_page = page;
-		bvec.bv_len = PAGE_SIZE;
-		bvec.bv_offset = 0;
-		return read_from_bdev(zram, &bvec,
-				zram_get_element(zram, index),
-				bio, partial_io);
-	}
-
 	handle = zram_get_handle(zram, index);
 	if (!handle || zram_test_flag(zram, index, ZRAM_SAME)) {
 		unsigned long value;
@@ -1357,7 +1368,6 @@ static int __zram_bvec_read(struct zram *zram, struct page *page, u32 index,
 		mem = kmap_atomic(page);
 		zram_fill_page(mem, PAGE_SIZE, value);
 		kunmap_atomic(mem);
-		zram_slot_unlock(zram, index);
 		return 0;
 	}
 
@@ -1379,7 +1389,25 @@ static int __zram_bvec_read(struct zram *zram, struct page *page, u32 index,
 		zcomp_stream_put(zram->comps[ZRAM_PRIMARY_ZCOMP]);
 	}
 	zs_unmap_object(zram->mem_pool, handle);
-	zram_slot_unlock(zram, index);
+	return ret;
+}
+
+static int __zram_bvec_read(struct zram *zram, struct page *page, u32 index,
+			    struct bio *bio, bool partial_io)
+{
+	int ret;
+
+	zram_slot_lock(zram, index);
+	if (!zram_test_flag(zram, index, ZRAM_WB)) {
+		/* Slot should be locked through out the function call */
+		ret = zram_read_from_zspool(zram, page, index);
+		zram_slot_unlock(zram, index);
+	} else {
+		/* Slot should be unlocked before the function call */
+		zram_slot_unlock(zram, index);
+		ret = zram_read_from_writeback(zram, page, index, bio,
+					       partial_io);
+	}
 
 	/* Should NEVER happen. Return bio error if it does. */
 	if (WARN_ON(ret))
@@ -1389,7 +1417,7 @@ static int __zram_bvec_read(struct zram *zram, struct page *page, u32 index,
 }
 
 static int zram_bvec_read(struct zram *zram, struct bio_vec *bvec,
-				u32 index, int offset, struct bio *bio)
+			  u32 index, int offset, struct bio *bio)
 {
 	int ret;
 	struct page *page;
-- 
2.37.2.789.g6183377224-goog

