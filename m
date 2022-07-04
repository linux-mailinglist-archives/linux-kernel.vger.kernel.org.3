Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB880565BEF
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 18:23:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233830AbiGDQXy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 12:23:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232318AbiGDQXw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 12:23:52 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 213F460CA;
        Mon,  4 Jul 2022 09:23:50 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id f2so8807976wrr.6;
        Mon, 04 Jul 2022 09:23:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tlz+dh9xydaT19bCuuZ/xc8P/NTU4SA6f9c7EjBMyIc=;
        b=FsD7WBczvgetQP1o/Atxmb5AVD9awpZdJXgOX/q3jFUUmWFhmlMVsWBWp4Ut/uY5xG
         KqoAtIQwlAfiHTdDYZMFxdqhyqLC1WI3EDeEerpLaU2wOf78lbPAJ+12l7dwSCcfCzgm
         YJJXZ1/g7Z4XrzrRyNp35ZvEd6OW4RpwZV6uAb81ZiUGh4+5+JSViDfg2L9DwL+p1qvc
         U26RRLwRY2KiQtgMa3VPe0jmS9E2qhD4CsB7tTaSUzZ6Cod/LlgO2x1OPdPNG2LQcFYB
         uWyL6CRLK7jiChXSii6k8OPgHaDOYKf7N2rYByW8KwgoI7q9soIFnT3EX4ZldM5S16GG
         AVFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tlz+dh9xydaT19bCuuZ/xc8P/NTU4SA6f9c7EjBMyIc=;
        b=ftkIV2KTjKUTzvNcd7JyL/GDjID7dkEXTmqrcBrzOkQYZrz+8rIKLlk2Fm3JlZtPSn
         d2RiZEdi4dfoOYw0L1viwxFZnCxv17S8GTAfkCaErrCHXHlin6ob6Lh8MEq6tuCcenrS
         NKD4k523i2l2yWCSowzsMR3j26CHf6T9ZfKb0/mAhRU7zCNZykG8ua2QnsH6y0j0HXkr
         YXx3Cky7nnCh7Jw025Ww7BFcoYZRhOsn2Sj8IFpkWiGMK5YOkNZvViuTu0mOVq8lbfHH
         3tG4EvHi/q/ms8Bgzl5XQIcjkxHhttYcU/SIqrPT+Nl/Rvn5dyqBsBI9tiCiVFr1i9WZ
         KnRA==
X-Gm-Message-State: AJIora9YVxWtUF2kZJxroNcbjJupTvSDsQ5pIWYmXo+f6y9l5FeREqDw
        g2ARKeirNRgO9GtlUs2BUgfZDMkasQBYiA==
X-Google-Smtp-Source: AGRyM1vyl/XjdeejWBH3/QySCpqdGrhuZspcdOa6otCtaHWDoAbqqJPdLut7sTIeRdz7mIWkeMCCig==
X-Received: by 2002:a05:6000:885:b0:21b:a423:172c with SMTP id ca5-20020a056000088500b0021ba423172cmr27126617wrb.98.1656951828710;
        Mon, 04 Jul 2022 09:23:48 -0700 (PDT)
Received: from localhost.localdomain (host-79-53-109-127.retail.telecomitalia.it. [79.53.109.127])
        by smtp.gmail.com with ESMTPSA id p15-20020a05600c204f00b0039c5cecf206sm19737293wmg.4.2022.07.04.09.23.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jul 2022 09:23:47 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Tyler Hicks <code@tyhicks.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Seth Forshee <sforshee@digitalocean.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Christian Brauner <brauner@kernel.org>,
        Muchun Song <songmuchun@bytedance.com>,
        ecryptfs@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Ira Weiny <ira.weiny@intel.com>
Subject: [PATCH] ecryptfs: Replace kmap() with kmap_local_page()
Date:   Mon,  4 Jul 2022 18:23:43 +0200
Message-Id: <20220704162343.23895-1-fmdefrancesco@gmail.com>
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

Suggested-by: Ira Weiny <ira.weiny@intel.com>
Reviewed-by: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
---

Please discard RFC PATCH at
https://lore.kernel.org/lkml/20220628184950.2045-1-fmdefrancesco@gmail.com/

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

