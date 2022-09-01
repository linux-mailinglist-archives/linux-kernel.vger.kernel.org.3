Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A05545A9C8A
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 18:07:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234833AbiIAQHO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 12:07:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232539AbiIAQHL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 12:07:11 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81CC769F7F;
        Thu,  1 Sep 2022 09:07:10 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id h5so24144286ejb.3;
        Thu, 01 Sep 2022 09:07:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=4VJruaNQlZmfFLkd95beZGUr5mHEF8CKOi+WYXEPPvs=;
        b=Fc9a+A93csieHGq1JI6Kclyd+05dfVZT4wh3OXLyclKdraGurGth6aDwWkP66LLuE4
         EFuc1WXKF5EJhOLZQak6b9BhwOOvG9yvNyNweg5Q6VZbSp896tkIID91uhfVDaoMjdJk
         QNgnMnIBaal28BcAGBRnk/q0tETYaJSYaVSRVWDEeyx+9lGijs7NgZIWJ21iYW8BValE
         uJJa7U0dcEiKGUIvYKd1QIEMxMK401gcKlMX+/WZxIRQ95osG5Gi0J8sI0pMfpFYFPUl
         Z/qU29AAutEwvEVmSISGJAsb1FNuBHWYYhxTc4NvHyGoUiWLABJvcby7RTP7PlUjLfMD
         zvzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=4VJruaNQlZmfFLkd95beZGUr5mHEF8CKOi+WYXEPPvs=;
        b=eOkEWga2iqQUlF5ZycwDTT6Uo7ijQNpUGT4vY+cguYsoDIXRi0W7A9TrG7NpAka2Q1
         YBxqwsyBp73e2Cn3i7DuE+00mZUPNmourCuUrJm+cVT8XhLbil3E59XoM0bv6rrkfhDA
         FYedEXUc9OCTCWE3vUlyZtCI47yVmj+H7vzGvYkLyATry2GpvJuWIJxDjrp3yuKQch+3
         3gQNFfc/YZX1yDOUjGspMWyFDutTrTEAECJihmruZfI95cIfZCBK6ZhcmllJLpkadvJG
         mLqday6vTJez0hzzNkrAb1sGn/qXSmocitmCJCH4xQVvzWlQqWMizZNxPzBRmgctdEB9
         06aw==
X-Gm-Message-State: ACgBeo0rW95SFYOq750CuVcy/V8daehSkYGQsWINFOyfwINs0z7XTHvt
        FfrNDCnkU60iX6/2/mpB5t4=
X-Google-Smtp-Source: AA6agR5uwHLhnuKmevtAHZVuEceRTbDEBvGkVKoPnf9uEBY1ROs9QTnNRuwVR20o1fhszYsOdw1D0Q==
X-Received: by 2002:a17:907:2bc7:b0:73d:d239:110b with SMTP id gv7-20020a1709072bc700b0073dd239110bmr23998582ejc.752.1662048428975;
        Thu, 01 Sep 2022 09:07:08 -0700 (PDT)
Received: from localhost.localdomain (host-87-1-103-238.retail.telecomitalia.it. [87.1.103.238])
        by smtp.gmail.com with ESMTPSA id q27-20020a50c35b000000b0043cf2e0ce1csm1613771edb.48.2022.09.01.09.07.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Sep 2022 09:07:07 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Tyler Hicks <code@tyhicks.com>,
        Christian Brauner <brauner@kernel.org>,
        Seth Forshee <sforshee@digitalocean.com>,
        Amir Goldstein <amir73il@gmail.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Muchun Song <songmuchun@bytedance.com>,
        ecryptfs@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        "Venkataramanan, Anirudh" <anirudh.venkataramanan@intel.com>,
        Ira Weiny <ira.weiny@intel.com>
Subject: [RESEND PATCH] ecryptfs: Replace kmap() with kmap_local_page()
Date:   Thu,  1 Sep 2022 18:07:04 +0200
Message-Id: <20220901160704.25701-1-fmdefrancesco@gmail.com>
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
the mapping space is restricted and protected by a global lock for
synchronization and (2) it also requires global TLB invalidation when the
kmap’s pool wraps and it might block when the mapping space is fully
utilized until a slot becomes available.

With kmap_local_page() the mappings are per thread, CPU local, can take
page faults, and can be called from any context (including interrupts).
It is faster than kmap() in kernels with HIGHMEM enabled. Furthermore,
the tasks can be preempted and, when they are scheduled to run again, the
kernel virtual addresses are restored and still valid.

Since its use in fs/ecryptfs is safe everywhere, it should be preferred.

Therefore, replace kmap() with kmap_local_page() in fs/ecryptfs.

Cc: "Venkataramanan, Anirudh" <anirudh.venkataramanan@intel.com>
Suggested-by: Ira Weiny <ira.weiny@intel.com>
Reviewed-by: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
---

I'm resending this patch because some recipients were missing in the
previous submission. In the meantime I'm also adding some more information
in the commit message. There are no changes in the code.

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
2.37.2

