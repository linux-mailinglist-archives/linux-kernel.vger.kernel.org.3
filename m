Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91FC1474AC1
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 19:24:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234256AbhLNSYp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 13:24:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234219AbhLNSYm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 13:24:42 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 736F4C061574
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 10:24:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8A230B81C51
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 18:24:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07CD7C34604;
        Tue, 14 Dec 2021 18:24:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639506278;
        bh=AmPX+a0hWSnCjAZZM9pCdd+GAXYEX32Uad3FqW5pKtw=;
        h=From:To:Cc:Subject:Date:From;
        b=DFX0mUq6xjhGyLCzZiE8ytesWpSrSHAOn6/lTDKUUx0jikGjXXx9v5/LqOuNR4jsL
         dv4NIjCpZSqKrTHvLQOM3GyrnNDPt5F2pGuJtG0IHdzKmatUmwYXBK7JapdyulVkbV
         gaH+tSRZ/h7/IW/BIpcevP0r4QyB/53A4hB16D3kqyFn3Jb26Lv8TV1jBS+5XCNHaw
         js1YWOQpjlXFDKa3kKJlKhdYl6jfFuGwGl01DxAh0pdyqxOBNhhJMEJPfLMTHxsknn
         mOJHJgA/1qFRwZdftW98uLXRbpYS1MXqifAKP0I5MrSLd+zZ8kTZSIS4cO277XE2O3
         4ATk/QLVLIFOw==
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 1/2] f2fs: avoid down_write on nat_tree_lock during checkpoint
Date:   Tue, 14 Dec 2021 10:24:34 -0800
Message-Id: <20211214182435.2595176-1-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.34.1.173.g76aa8bc2d0-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let's cache nat entry if there's no lock contention only.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/node.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 556fcd8457f3..b1bc7d76da3b 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -430,6 +430,10 @@ static void cache_nat_entry(struct f2fs_sb_info *sbi, nid_t nid,
 	struct f2fs_nm_info *nm_i = NM_I(sbi);
 	struct nat_entry *new, *e;
 
+	/* Let's mitigate lock contention of nat_tree_lock during checkpoint */
+	if (rwsem_is_locked(&sbi->cp_global_sem))
+		return;
+
 	new = __alloc_nat_entry(sbi, nid, false);
 	if (!new)
 		return;
-- 
2.34.1.173.g76aa8bc2d0-goog

