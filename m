Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13D3855ED0E
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 20:50:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234087AbiF1SuM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 14:50:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234041AbiF1St7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 14:49:59 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71B1024956;
        Tue, 28 Jun 2022 11:49:58 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id d17so13361411wrc.10;
        Tue, 28 Jun 2022 11:49:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=v12W7lrwEZaMnJj/8/YW2fjv7549ZdYfdH8DoyJsAPU=;
        b=Oc8qV2LqyBUhEWiuQFy7QvJeR4shc+Sfl5kJtkr/YIsuWRVZbdRkF8CD9PUPE1Vn8F
         evZHqpoMaVN6ODzvR68EVjtVmhEZl+Il3Qymm1rCZBpUUnLcToS7JJTZSDiFLiz86SSy
         APZ87lZJ/aWVOpMlctUc46BcvpePcH3tQD+Y8+ldRzayq6i3gMWZhevjZurKQcJXBiLQ
         yqWFVebYZRbjyNATEDol9ONAP7t86DmjoVI81ODlhal7Yb1I7JPNKLyZ3RnCYMSaMMTv
         u9UpzNY39krMjzIKeeIQRhxc4+Aej06Bd19deVppPpLEjXZoYJKr5Jk3xHZd3LIFnMin
         KmIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=v12W7lrwEZaMnJj/8/YW2fjv7549ZdYfdH8DoyJsAPU=;
        b=wFfHRWYPD088Z1qlSN0c7QbMNy/tZPfnzcMMKzCi8HndxPlnoHDEXq7bytuas37XDp
         d7qn9C4V/ZdWV5kKn/Wb3I/H8CgGk3b1Xg7+8IzMN5mm7HmQ8a2vEbxhaFEBQLZHCa8m
         jwAlTCTMPW/jFkvsivF02j7p2hkRgDQgdDPI/uAj5YEhJgGHG/NGLBqy0c1W9/PtK5WT
         z50AoiBhzbYRwgEkL8+J/ikTp2cpTBX2LY9cF97VC0/hxZRPGrRltUMT+vapBPL5rcgn
         eNyQwaysm3hRuSHv79p5/JuGxISItur5Fne7N6N+2HTRsy4cHDrdFqEOyWi+chSdd2Tf
         GEdw==
X-Gm-Message-State: AJIora/4r2HLmIp/gOOkf/STm5yEID+dAaaGSAH9tf5rQpuEnoluSuZk
        nGPp8aUnC4+FygBvl/QgmcyYsMPQig4=
X-Google-Smtp-Source: AGRyM1ue70t4mReX8BosJPQG8RZjjJfVbUvjGPOzvXYf2h4d6+aXr3IYvgrLVgeEsaKhmBPo4Ugu5w==
X-Received: by 2002:a5d:6b91:0:b0:21b:bc0b:7282 with SMTP id n17-20020a5d6b91000000b0021bbc0b7282mr19213599wrx.375.1656442196924;
        Tue, 28 Jun 2022 11:49:56 -0700 (PDT)
Received: from localhost.localdomain (host-87-6-98-182.retail.telecomitalia.it. [87.6.98.182])
        by smtp.gmail.com with ESMTPSA id z21-20020a1c4c15000000b0039c871d3191sm460368wmf.3.2022.06.28.11.49.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jun 2022 11:49:54 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Tyler Hicks <code@tyhicks.com>,
        Christian Brauner <brauner@kernel.org>,
        Seth Forshee <sforshee@digitalocean.com>,
        Amir Goldstein <amir73il@gmail.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jan Kara <jack@suse.cz>,
        Muchun Song <songmuchun@bytedance.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        "Theodore Ts'o" <tytso@mit.edu>, ecryptfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Ira Weiny <ira.weiny@intel.com>
Subject: [RFC PATCH] ecryptfs: Replace kmap() with kmap_local_page()
Date:   Tue, 28 Jun 2022 20:49:50 +0200
Message-Id: <20220628184950.2045-1-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
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

With kmap_local_page() the mappings are per thread, CPU local and not
globally visible.

Use kmap_local_page() on all calling sites where kmap() is currently used.

The mappings in fs/ecryptfs seem to conform to the prerequisites for
easy conversions to kmap_local_page(), however I am not familiar with this
code.

This is why this is an RFC PATCH. I'd appreciate if people familiar with
eCryptfs could test and confirm whether these conversions are safe or not.

Suggested-by: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
---
 fs/ecryptfs/crypto.c     | 8 ++++----
 fs/ecryptfs/read_write.c | 8 ++++----
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/fs/ecryptfs/crypto.c b/fs/ecryptfs/crypto.c
index e3f5d7f3c8a0..03263ebcccc6 100644
--- a/fs/ecryptfs/crypto.c
+++ b/fs/ecryptfs/crypto.c
@@ -465,10 +465,10 @@ int ecryptfs_encrypt_page(struct page *page)
 	}
 
 	lower_offset = lower_offset_for_page(crypt_stat, page);
-	enc_extent_virt = kmap(enc_extent_page);
+	enc_extent_virt = kmap_local_page(enc_extent_page);
 	rc = ecryptfs_write_lower(ecryptfs_inode, enc_extent_virt, lower_offset,
 				  PAGE_SIZE);
-	kunmap(enc_extent_page);
+	kunmap_local(enc_extent_virt);
 	if (rc < 0) {
 		ecryptfs_printk(KERN_ERR,
 			"Error attempting to write lower page; rc = [%d]\n",
@@ -514,10 +514,10 @@ int ecryptfs_decrypt_page(struct page *page)
 	BUG_ON(!(crypt_stat->flags & ECRYPTFS_ENCRYPTED));
 
 	lower_offset = lower_offset_for_page(crypt_stat, page);
-	page_virt = kmap(page);
+	page_virt = kmap_local_page(page);
 	rc = ecryptfs_read_lower(page_virt, lower_offset, PAGE_SIZE,
 				 ecryptfs_inode);
-	kunmap(page);
+	kunmap_local(page_virt);
 	if (rc < 0) {
 		ecryptfs_printk(KERN_ERR,
 			"Error attempting to read lower page; rc = [%d]\n",
diff --git a/fs/ecryptfs/read_write.c b/fs/ecryptfs/read_write.c
index 60bdcaddcbe5..5edf027c8359 100644
--- a/fs/ecryptfs/read_write.c
+++ b/fs/ecryptfs/read_write.c
@@ -64,11 +64,11 @@ int ecryptfs_write_lower_page_segment(struct inode *ecryptfs_inode,
 
 	offset = ((((loff_t)page_for_lower->index) << PAGE_SHIFT)
 		  + offset_in_page);
-	virt = kmap(page_for_lower);
+	virt = kmap_local_page(page_for_lower);
 	rc = ecryptfs_write_lower(ecryptfs_inode, virt, offset, size);
 	if (rc > 0)
 		rc = 0;
-	kunmap(page_for_lower);
+	kunmap_local(virt);
 	return rc;
 }
 
@@ -253,11 +253,11 @@ int ecryptfs_read_lower_page_segment(struct page *page_for_ecryptfs,
 	int rc;
 
 	offset = ((((loff_t)page_index) << PAGE_SHIFT) + offset_in_page);
-	virt = kmap(page_for_ecryptfs);
+	virt = kmap_local_page(page_for_ecryptfs);
 	rc = ecryptfs_read_lower(virt, offset, size, ecryptfs_inode);
 	if (rc > 0)
 		rc = 0;
-	kunmap(page_for_ecryptfs);
+	kunmap_local(virt);
 	flush_dcache_page(page_for_ecryptfs);
 	return rc;
 }
-- 
2.36.1

