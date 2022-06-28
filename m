Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A27D55D8B7
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:20:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231826AbiF1DZI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 23:25:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231689AbiF1DZC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 23:25:02 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32D2B24F3D
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 20:25:02 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id go6so11330626pjb.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 20:25:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7W3a+cqhlUrLN7zR1YRe1TDmkGT0ULnVmRWaUqT5Xdk=;
        b=MDx4EiSYBdUwIxoB/hlLPrm4mNMGmsHVb9dDktqxmCXkIyXgwK8kNofkn65dJzqUmy
         E/UlHGfA3AEOP86jvJww7+IXC1wOIYLJUmI3SEepL42rv3Tq71+gHZ6ngvq+MpNFHByq
         AHRRWvVZ4pIGxPtdRlvlF/F4xFj36+jGkqTTmjM1DTn7UcuVXbYCPikO09BcGPG6OOtY
         yZM1cdGxbUrl4zrcumNrQOeo2cbGsDTcVTm3CJLvhvvdXDHN09E1PHFUBzIF0JkfAVVA
         mCmu1EjVxgQeGBVOWJtk1papjASVdBSGajsO5JbGLhefm6OevtFYPI9ltqI6qnLI1ldN
         lBsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7W3a+cqhlUrLN7zR1YRe1TDmkGT0ULnVmRWaUqT5Xdk=;
        b=Apwg96wSLgO88SIw4xBGbsZ/s2LPE/cI87JCjIARDYKR6YRe811r6sRvu6fIBZmouF
         C2rIHPfNAYmND0lkCSMCyGqTfVOgdur856AyTgUECAMrmF7tyDSNURaL1Z+G7pc33wMg
         nEusFn8QemE47213N1xVw7ONnXloLtCqf9ZohdpTvZXgmFYXsPlA5poVht8l9GycVpM6
         rRS351aFPvlURYAlatRUFFz3yZhf3g+3V1LoLrqY299UBKUWI1tXIgcoO46MRkewyIGu
         1h5ekdZkaE8Qjo1nGuXGVru7P90tp/REyxzAsY6n2eGOxxE1ofPtjbykIrbvFAapv5kO
         U/5w==
X-Gm-Message-State: AJIora/g647iCt8kQ6VVp+AdH3M0HSX5hEFrI0wIQzi0gDsLX+ENdh/s
        lEYGtk6XLiZg1j0W8D5uRrk=
X-Google-Smtp-Source: AGRyM1uQ/H9qsCCDP+yUzGLgtYeMv+LUmj9hXXnBemNlRLt2JRPj5LozT1h/YwsicW4Mre4sp2Bonw==
X-Received: by 2002:a17:903:1ca:b0:16a:5d7f:182f with SMTP id e10-20020a17090301ca00b0016a5d7f182fmr2670279plh.88.1656386701676;
        Mon, 27 Jun 2022 20:25:01 -0700 (PDT)
Received: from mi-HP-ProDesk-680-G4-MT.mioffice.cn ([43.224.245.232])
        by smtp.gmail.com with ESMTPSA id b12-20020a1709027e0c00b0016b82ff7072sm2174559plm.138.2022.06.27.20.24.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 20:25:01 -0700 (PDT)
From:   Guowei Du <duguoweisz@gmail.com>
To:     jaegeuk@kernel.org, chao@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, duguowei <duguowei@xiaomi.com>
Subject: [PATCH 4/4] f2fs: make some changes for memory using
Date:   Tue, 28 Jun 2022 11:24:50 +0800
Message-Id: <20220628032450.5869-1-duguoweisz@gmail.com>
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

From: duguowei <duguowei@xiaomi.com>

No functional change.

- one is just using a variable for f2fs_available_free_memory
- another adds 'inline' modifier for the function call

Signed-off-by: duguowei <duguowei@xiaomi.com>
---
 fs/f2fs/node.c     | 18 ++++++++++--------
 fs/f2fs/shrinker.c |  6 +++---
 2 files changed, 13 insertions(+), 11 deletions(-)

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 836c79a20afc..2924c8ce13bb 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -46,7 +46,7 @@ bool f2fs_available_free_memory(struct f2fs_sb_info *sbi, int type)
 	struct f2fs_nm_info *nm_i = NM_I(sbi);
 	struct discard_cmd_control *dcc = SM_I(sbi)->dcc_info;
 	struct sysinfo val;
-	unsigned long avail_ram;
+	unsigned long avail_ram, ram_thresh;
 	unsigned long mem_size = 0;
 	bool res = false;
 
@@ -57,25 +57,27 @@ bool f2fs_available_free_memory(struct f2fs_sb_info *sbi, int type)
 
 	/* only uses low memory */
 	avail_ram = val.totalram - val.totalhigh;
+	ram_thresh = avail_ram * nm_i->ram_thresh / 100;
 
 	/*
-	 * give 25%, 25%, 50%, 50%, 50% memory for each components respectively
+	 * give 25%, 25%, 50%, 50%, 50%, 100% of memory threshold
+	 * for each components respectively
 	 */
 	if (type == FREE_NIDS) {
 		mem_size = (nm_i->nid_cnt[FREE_NID] *
 				sizeof(struct free_nid)) >> PAGE_SHIFT;
-		res = mem_size < ((avail_ram * nm_i->ram_thresh / 100) >> 2);
+		res = mem_size < (ram_thresh >> 2);
 	} else if (type == NAT_ENTRIES) {
 		mem_size = (nm_i->nat_cnt[TOTAL_NAT] *
 				sizeof(struct nat_entry)) >> PAGE_SHIFT;
-		res = mem_size < ((avail_ram * nm_i->ram_thresh / 100) >> 2);
+		res = mem_size < (ram_thresh >> 2);
 		if (excess_cached_nats(sbi))
 			res = false;
 	} else if (type == DIRTY_DENTS) {
 		if (sbi->sb->s_bdi->wb.dirty_exceeded)
 			return false;
 		mem_size = get_pages(sbi, F2FS_DIRTY_DENTS);
-		res = mem_size < ((avail_ram * nm_i->ram_thresh / 100) >> 1);
+		res = mem_size < (ram_thresh >> 1);
 	} else if (type == INO_ENTRIES) {
 		int i;
 
@@ -83,17 +85,17 @@ bool f2fs_available_free_memory(struct f2fs_sb_info *sbi, int type)
 			mem_size += sbi->im[i].ino_num *
 						sizeof(struct ino_entry);
 		mem_size >>= PAGE_SHIFT;
-		res = mem_size < ((avail_ram * nm_i->ram_thresh / 100) >> 1);
+		res = mem_size < (ram_thresh >> 1);
 	} else if (type == EXTENT_CACHE) {
 		mem_size = (atomic_read(&sbi->total_ext_tree) *
 				sizeof(struct extent_tree) +
 				atomic_read(&sbi->total_ext_node) *
 				sizeof(struct extent_node)) >> PAGE_SHIFT;
-		res = mem_size < ((avail_ram * nm_i->ram_thresh / 100) >> 1);
+		res = mem_size < (ram_thresh >> 1);
 	} else if (type == DISCARD_CACHE) {
 		mem_size = (atomic_read(&dcc->discard_cmd_cnt) *
 				sizeof(struct discard_cmd)) >> PAGE_SHIFT;
-		res = mem_size < (avail_ram * nm_i->ram_thresh / 100);
+		res = mem_size < ram_thresh;
 	} else if (type == COMPRESS_PAGE) {
 #ifdef CONFIG_F2FS_FS_COMPRESSION
 		unsigned long free_ram = val.freeram;
diff --git a/fs/f2fs/shrinker.c b/fs/f2fs/shrinker.c
index dd3c3c7a90ec..201207b78bda 100644
--- a/fs/f2fs/shrinker.c
+++ b/fs/f2fs/shrinker.c
@@ -16,19 +16,19 @@ static LIST_HEAD(f2fs_list);
 static DEFINE_SPINLOCK(f2fs_list_lock);
 static unsigned int shrinker_run_no;
 
-static unsigned long __count_nat_entries(struct f2fs_sb_info *sbi)
+static inline unsigned long __count_nat_entries(struct f2fs_sb_info *sbi)
 {
 	return NM_I(sbi)->nat_cnt[RECLAIMABLE_NAT];
 }
 
-static unsigned long __count_free_nids(struct f2fs_sb_info *sbi)
+static inline unsigned long __count_free_nids(struct f2fs_sb_info *sbi)
 {
 	long count = NM_I(sbi)->nid_cnt[FREE_NID] - MAX_FREE_NIDS;
 
 	return count > 0 ? count : 0;
 }
 
-static unsigned long __count_extent_cache(struct f2fs_sb_info *sbi)
+static inline unsigned long __count_extent_cache(struct f2fs_sb_info *sbi)
 {
 	return atomic_read(&sbi->total_zombie_tree) +
 				atomic_read(&sbi->total_ext_node);
-- 
2.36.1

