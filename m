Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54E8E4FFAA6
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 17:49:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236694AbiDMPv6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 11:51:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236695AbiDMPv4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 11:51:56 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFE5812AF1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 08:49:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DC183B8256B
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 15:49:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8032FC385A4;
        Wed, 13 Apr 2022 15:49:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649864969;
        bh=rfY+zz0EuMCDCl5xRvtF27SM8BicRPxM1bncNrdxx0A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=doIhqVsnjd2JQK1auCF3NlybCIVILT6hrtkjgPvkbU9ocftiLFygYW6NGXNKbmgji
         lB2ClmnfaMlvTDNlz+U7O0Y+BMRuR1wjqfOX2bnUxXDhD256W7Q+yd0T/8miimjFlO
         jtzSAxG+NRek/wdNLYb7g5QsiyweekKbx4N7iZXlNhJHTwbz0KRgyZ+HAOnKGmr6zC
         S37szmfOKyxZ9ExQAIG3JrBBOJOnB/ucmLZQLBnZTlTY5gb8cBZZeS1HLxww1a+sV4
         PpqFjsRiJqh/apPR4DTdtR4rcVn6nebXu51AJvwhMWlvRHL9R8CvdEtbkqgMmKe+1C
         l9/wpv57+ZFDQ==
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 2/2] f2fs: keep io_flags to avoid IO split due to different op_flags in two fio holders
Date:   Wed, 13 Apr 2022 08:49:20 -0700
Message-Id: <20220413154920.2024872-2-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.36.0.rc0.470.gd361397f0d-goog
In-Reply-To: <20220413154920.2024872-1-jaegeuk@kernel.org>
References: <20220413154920.2024872-1-jaegeuk@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let's attach io_flags to bio only, so that we can merge IOs given original
io_flags only.

Fixes: 64bf0eef0171 ("f2fs: pass the bio operation to bio_alloc_bioset")
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/data.c | 33 +++++++++++++++++++++------------
 1 file changed, 21 insertions(+), 12 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index acc523f893ba..fcf0daa386de 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -387,11 +387,23 @@ int f2fs_target_device_index(struct f2fs_sb_info *sbi, block_t blkaddr)
 	return 0;
 }
 
-static void __attach_io_flag(struct f2fs_io_info *fio, unsigned int io_flag)
+static unsigned int f2fs_io_flags(struct f2fs_io_info *fio)
 {
 	unsigned int temp_mask = (1 << NR_TEMP_TYPE) - 1;
-	unsigned int fua_flag = io_flag & temp_mask;
-	unsigned int meta_flag = (io_flag >> NR_TEMP_TYPE) & temp_mask;
+	unsigned int fua_flag, meta_flag, io_flag;
+	unsigned int op_flags = 0;
+
+	if (fio->op != REQ_OP_WRITE)
+		return 0;
+	if (fio->type == DATA)
+		io_flag = fio->sbi->data_io_flag;
+	else if (fio->type == NODE)
+		io_flag = fio->sbi->node_io_flag;
+	else
+		return 0;
+
+	fua_flag = io_flag & temp_mask;
+	meta_flag = (io_flag >> NR_TEMP_TYPE) & temp_mask;
 
 	/*
 	 * data/node io flag bits per temp:
@@ -400,9 +412,10 @@ static void __attach_io_flag(struct f2fs_io_info *fio, unsigned int io_flag)
 	 * Cold | Warm | Hot | Cold | Warm | Hot |
 	 */
 	if ((1 << fio->temp) & meta_flag)
-		fio->op_flags |= REQ_META;
+		op_flags |= REQ_META;
 	if ((1 << fio->temp) & fua_flag)
-		fio->op_flags |= REQ_FUA;
+		op_flags |= REQ_FUA;
+	return op_flags;
 }
 
 static struct bio *__bio_alloc(struct f2fs_io_info *fio, int npages)
@@ -412,14 +425,10 @@ static struct bio *__bio_alloc(struct f2fs_io_info *fio, int npages)
 	sector_t sector;
 	struct bio *bio;
 
-	if (fio->type == DATA)
-		__attach_io_flag(fio, sbi->data_io_flag);
-	else if (fio->type == NODE)
-		__attach_io_flag(fio, sbi->node_io_flag);
-
 	bdev = f2fs_target_device(sbi, fio->new_blkaddr, &sector);
-	bio = bio_alloc_bioset(bdev, npages, fio->op | fio->op_flags, GFP_NOIO,
-			       &f2fs_bioset);
+	bio = bio_alloc_bioset(bdev, npages,
+				fio->op | fio->op_flags | f2fs_io_flags(fio),
+				GFP_NOIO, &f2fs_bioset);
 	bio->bi_iter.bi_sector = sector;
 	if (is_read_io(fio->op)) {
 		bio->bi_end_io = f2fs_read_end_io;
-- 
2.36.0.rc0.470.gd361397f0d-goog

