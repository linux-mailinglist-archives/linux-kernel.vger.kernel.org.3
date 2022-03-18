Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDE594DD6C1
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 10:02:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234163AbiCRJEE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 05:04:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230096AbiCRJEC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 05:04:02 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E814421FC75
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 02:02:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9FB15B82196
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 09:02:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABFDDC340E8;
        Fri, 18 Mar 2022 09:02:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647594161;
        bh=a9kcKdyy34HKkql+gG9xZK5LGjnACzCRZOb54+k9ARI=;
        h=From:To:Cc:Subject:Date:From;
        b=TUKAj841h+8McDB0ki0QIIr1ugANgJng6oCWwUYCv2gGJsyXQNnqMynhmXpZXq9xh
         TINP1p+z4vKJk2QY2KJwDccMRCjxf8bk++zK5qLrlof3nBPW6p1PezUTceqbuHIruK
         IZ+ZZqCPZJ3itiZwidrmqmPY8pmriTF41vE36vcxQH6g6szzyxHwBLMXe0mCn2xs28
         ofkWtZLDQIHqZ9LzyuugH8uF4BRRSFceeZxWtJqvkA8cF0evTF6XM2KC8MJYO1D3Iq
         6OMVaFSnGpWOauZ7E7M/MMmPyAml9xnunVxINUS38qUR1RiMGzGFyW+1J3wQQ9WbNb
         l6lmeRSxx7NIA==
From:   Chao Yu <chao@kernel.org>
To:     jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Chao Yu <chao@kernel.org>,
        Chao Yu <chao.yu@oppo.com>
Subject: [PATCH v2] f2fs: use aggressive GC policy during f2fs_disable_checkpoint()
Date:   Fri, 18 Mar 2022 17:02:30 +0800
Message-Id: <20220318090230.3756263-1-chao@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let's enable GC_URGENT_HIGH mode during f2fs_disable_checkpoint(),
so that we can use SSR allocator for GCed data/node persistence,
it can improve the performance due to it avoiding migration of
data/node locates in selected target segment of SSR allocator.

Signed-off-by: Chao Yu <chao.yu@oppo.com>
---
v2:
- enable GC_URGENT_HIGH mode only.
 fs/f2fs/super.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 9176597fdf94..caceb80b87ec 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -2080,6 +2080,7 @@ static int f2fs_disable_checkpoint(struct f2fs_sb_info *sbi)
 {
 	unsigned int s_flags = sbi->sb->s_flags;
 	struct cp_control cpc;
+	unsigned int gc_mode;
 	int err = 0;
 	int ret;
 	block_t unusable;
@@ -2092,6 +2093,9 @@ static int f2fs_disable_checkpoint(struct f2fs_sb_info *sbi)
 
 	f2fs_update_time(sbi, DISABLE_TIME);
 
+	gc_mode = sbi->gc_mode;
+	sbi->gc_mode = GC_URGENT_HIGH;
+
 	while (!f2fs_time_over(sbi, DISABLE_TIME)) {
 		f2fs_down_write(&sbi->gc_lock);
 		err = f2fs_gc(sbi, true, false, false, NULL_SEGNO);
@@ -2129,6 +2133,7 @@ static int f2fs_disable_checkpoint(struct f2fs_sb_info *sbi)
 out_unlock:
 	f2fs_up_write(&sbi->gc_lock);
 restore_flag:
+	sbi->gc_mode = gc_mode;
 	sbi->sb->s_flags = s_flags;	/* Restore SB_RDONLY status */
 	return err;
 }
-- 
2.25.1

