Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DC8159AAD3
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Aug 2022 05:08:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236670AbiHTDGb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 23:06:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbiHTDG1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 23:06:27 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D19AFD0754
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 20:06:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 83DC0B82A22
        for <linux-kernel@vger.kernel.org>; Sat, 20 Aug 2022 03:06:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 323D7C433D6;
        Sat, 20 Aug 2022 03:06:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660964783;
        bh=RjXdwcWPdrL/4i/EG/8q1BEfNqlJJsKx6SU+UP5QRPw=;
        h=From:To:Cc:Subject:Date:From;
        b=cQJmhXReefvs4vo15RyLZNBCE1Z171mHdnAorUr5JRdxVCnsag7L5hfgJwsV2kAY+
         CGpZmMHIp913AsoAqWdBYuY9HbNY6Im7aiXr8B9mEeXOwpikW3PRbdMU5pJitg7w3/
         sYZHySvUpLrJLNYccWctGqR+pmOJ1ZczQubagG4xo4qHhjQZy9JAxR2BF/JdeyPGMd
         drRUE0cyV/WMp3r8tqvGMJ4ib+oqAjgVtMSbb04l3y2X+gZiwWQwzwcPR0ATM9nnNO
         aVbxbCFgy6NNZKIxwdaOw0vNRPnK2LkmdjKQ4SiGXIQ/5ZWLt0ecYok5NPvWzj7/Qa
         TSmCb8YiLDPbA==
From:   Chao Yu <chao@kernel.org>
To:     jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Chao Yu <chao.yu@oppo.com>
Subject: [PATCH] f2fs: remove gc_urgent_high_limited for cleanup
Date:   Sat, 20 Aug 2022 11:06:00 +0800
Message-Id: <20220820030600.3509403-1-chao@kernel.org>
X-Mailer: git-send-email 2.25.1
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

From: Chao Yu <chao.yu@oppo.com>

Remove redundant sbi->gc_urgent_high_limited.

Signed-off-by: Chao Yu <chao.yu@oppo.com>
---
 fs/f2fs/f2fs.h  | 1 -
 fs/f2fs/gc.c    | 8 ++++----
 fs/f2fs/sysfs.c | 1 -
 3 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 1e47d5e77ec7..088c3d1574b8 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1731,7 +1731,6 @@ struct f2fs_sb_info {
 	unsigned int gc_mode;			/* current GC state */
 	unsigned int next_victim_seg[2];	/* next segment in victim section */
 	spinlock_t gc_urgent_high_lock;
-	bool gc_urgent_high_limited;		/* indicates having limited trial count */
 	unsigned int gc_urgent_high_remaining;	/* remaining trial count for GC_URGENT_HIGH */
 
 	/* for skip statistic */
diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index 2a3816c20f84..fd400d148afb 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -97,10 +97,10 @@ static int gc_thread_func(void *data)
 		 */
 		if (sbi->gc_mode == GC_URGENT_HIGH) {
 			spin_lock(&sbi->gc_urgent_high_lock);
-			if (sbi->gc_urgent_high_limited &&
-					!sbi->gc_urgent_high_remaining--) {
-				sbi->gc_urgent_high_limited = false;
-				sbi->gc_mode = GC_NORMAL;
+			if (sbi->gc_urgent_high_remaining) {
+				sbi->gc_urgent_high_remaining--;
+				if (!sbi->gc_urgent_high_remaining)
+					sbi->gc_mode = GC_NORMAL;
 			}
 			spin_unlock(&sbi->gc_urgent_high_lock);
 		}
diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
index eba5fb1629d7..39ebf0ad133a 100644
--- a/fs/f2fs/sysfs.c
+++ b/fs/f2fs/sysfs.c
@@ -527,7 +527,6 @@ static ssize_t __sbi_store(struct f2fs_attr *a,
 
 	if (!strcmp(a->attr.name, "gc_urgent_high_remaining")) {
 		spin_lock(&sbi->gc_urgent_high_lock);
-		sbi->gc_urgent_high_limited = t != 0;
 		sbi->gc_urgent_high_remaining = t;
 		spin_unlock(&sbi->gc_urgent_high_lock);
 
-- 
2.25.1

