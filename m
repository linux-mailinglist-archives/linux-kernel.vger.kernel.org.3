Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73F724FC6AA
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 23:22:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350165AbiDKVYJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 17:24:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245205AbiDKVYD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 17:24:03 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E9812FE5C
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 14:21:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 08C1BB815C8
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 21:21:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EB4EC385A3;
        Mon, 11 Apr 2022 21:21:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649712105;
        bh=KMidD+w99wAIiwGhewAltcaEDYwfTgwuH9rySlM7owU=;
        h=From:To:Cc:Subject:Date:From;
        b=lk9VWBICFXjGKTnI22r2ysF69//hMym+TGv5xnjmfAAu0maDn0rXzdvqNYHyGD9Ev
         RiQerYKR1ioyJJQTrAY1ZTljIQNFs1HVWIt3TSrCoF+w+MKXoep1FwVmVhecdcINvc
         10EzMt5SIL63+xwx2HwNTQnREAZSAn3phmSwvqo6cvy67kjQk9S3YKNQzWeaFWau29
         hrvuOxMiQ2hfb6IYm4wfIdvz9iDDCLKkVbQFQLTRsDIcgfKT8HjqL7Z8m2+8A/Jw1V
         Z0Az20XQUp24kxfdlJ3QylhQTbzxq7LCUj4XRjqTSNmQ1p77v9OmpcBhYFDMwBsWCw
         N5TO3c0Q9UPWg==
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 1/2] f2fs: fix wrong condition check when failing metapage read
Date:   Mon, 11 Apr 2022 14:21:40 -0700
Message-Id: <20220411212141.1775589-1-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.35.1.1178.g4f1659d476-goog
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

This patch fixes wrong initialization.

Fixes: 50c63009f6ab ("f2fs: avoid an infinite loop in f2fs_sync_dirty_inodes")
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/checkpoint.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index aba1b8a1ce66..ed61ac99a3cf 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -98,9 +98,9 @@ static struct page *__get_meta_page(struct f2fs_sb_info *sbi, pgoff_t index,
 	}
 
 	if (unlikely(!PageUptodate(page))) {
-		if (page->index == sbi->metapage_eio_ofs &&
-			sbi->metapage_eio_cnt++ == MAX_RETRY_META_PAGE_EIO) {
-			set_ckpt_flags(sbi, CP_ERROR_FLAG);
+		if (page->index == sbi->metapage_eio_ofs) {
+			if (sbi->metapage_eio_cnt++ == MAX_RETRY_META_PAGE_EIO)
+				set_ckpt_flags(sbi, CP_ERROR_FLAG);
 		} else {
 			sbi->metapage_eio_ofs = page->index;
 			sbi->metapage_eio_cnt = 0;
-- 
2.35.1.1178.g4f1659d476-goog

