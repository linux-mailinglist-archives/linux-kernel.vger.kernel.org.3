Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D258246872B
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Dec 2021 20:02:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347509AbhLDTFe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Dec 2021 14:05:34 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:48172 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347261AbhLDTFd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Dec 2021 14:05:33 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 94704B80D38
        for <linux-kernel@vger.kernel.org>; Sat,  4 Dec 2021 19:02:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4293DC341C2;
        Sat,  4 Dec 2021 19:02:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638644525;
        bh=AHl9BrLcAAyIfH+2de6f2wjbYlxFQtE4dIITddjEuYo=;
        h=From:To:Cc:Subject:Date:From;
        b=kGPgVsI5JfDrLMgna0R87aHb5WNG5JA5/CavfrCm/n4VjTImptPZO8Z+e8dYuUlQK
         yOJOYaPiLrsVn6ca9r9O9es1VcqGgLwUGeq6uF/FrV1Erc6KLMFu878i3S+yB3pfQH
         dKhIQ/YcF75BOnLEzosADha4jl0tmwczvwq2E0kwVppFjbVRYAB0r8miThq3Lg499w
         Z6IjBkCgKUygYjZIWqcJXh32ptlSW9e//ZqUARAVe3Cy2TeYePOTBtIf92oQLMQWL7
         N3olw/2SWW28+wv4CId8mVan2kMvs8ywx3jRyEMO2gETX980Yhm/IGplyarGV4iTwV
         /0u8bQIi8a0fw==
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH] f2fs: avoid duplicate call of mark_inode_dirty
Date:   Sat,  4 Dec 2021 11:01:58 -0800
Message-Id: <20211204190158.3158405-1-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.34.1.400.ga245620fadb-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let's check the condition first before set|clear bit.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/f2fs.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index ac6dda6c4c5a..cbc73bd71dad 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -3115,12 +3115,16 @@ static inline int is_file(struct inode *inode, int type)
 
 static inline void set_file(struct inode *inode, int type)
 {
+	if (is_file(inode, type))
+		return;
 	F2FS_I(inode)->i_advise |= type;
 	f2fs_mark_inode_dirty_sync(inode, true);
 }
 
 static inline void clear_file(struct inode *inode, int type)
 {
+	if (!is_file(inode, type))
+		return;
 	F2FS_I(inode)->i_advise &= ~type;
 	f2fs_mark_inode_dirty_sync(inode, true);
 }
-- 
2.34.1.400.ga245620fadb-goog

