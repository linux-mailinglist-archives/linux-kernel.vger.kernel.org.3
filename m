Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BC0B4884AD
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jan 2022 17:46:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234724AbiAHQp6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jan 2022 11:45:58 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:34342 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232201AbiAHQp5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jan 2022 11:45:57 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 75164B8075E
        for <linux-kernel@vger.kernel.org>; Sat,  8 Jan 2022 16:45:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2804DC36AE0;
        Sat,  8 Jan 2022 16:45:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641660355;
        bh=Cwe33DNy7p/gHqdTzE8Lh7iOrBD6pivF/lzBddkAwOk=;
        h=From:To:Cc:Subject:Date:From;
        b=rJ6nVy8Y/t2P0uLDeQZCNrLqpIpGKXbAvILfB61iENXETGvnvVssqVuR69w1PlSP7
         LEx7noZAQgZbjgApSWkT1Dt6m0VJio3acVTbF2LaCaI+CpQDZXxgznJuk9z8HTQ+fw
         P++QF24VRF7sOScB/Ca4FF5XjDq0awLsEGFhw4QsZtAxEHtO9diOmg77Lizgpts+Kq
         2nw666QHZL7IvUWRZ565ZxhEHmFWHJueHC4QrQSPRGvINORt9gRPbYsSkF6ajMvodO
         qX7E130Qm5P7tTKV0vWZmfJMrDTVTukoU0hL8iq7kLA8SEGCi1kaOQ+cIUKQuFckev
         eCrF5A1Qc/MjQ==
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH] f2fs: do not allow partial truncation on pinned file
Date:   Sat,  8 Jan 2022 08:45:52 -0800
Message-Id: <20220108164552.3130085-1-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.34.1.575.g55b058a8bb-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the pinned file has a hole by partial truncation, application that has
the block map will be broken.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/file.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index f39feedc9816..6ccdd6e347e2 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -1750,7 +1750,11 @@ static long f2fs_fallocate(struct file *file, int mode,
 		(mode & (FALLOC_FL_COLLAPSE_RANGE | FALLOC_FL_INSERT_RANGE)))
 		return -EOPNOTSUPP;
 
-	if (f2fs_compressed_file(inode) &&
+	/*
+	 * Pinned file should not support partial trucation since the block
+	 * can be used by applications.
+	 */
+	if ((f2fs_compressed_file(inode) || f2fs_is_pinned_file(inode)) &&
 		(mode & (FALLOC_FL_PUNCH_HOLE | FALLOC_FL_COLLAPSE_RANGE |
 			FALLOC_FL_ZERO_RANGE | FALLOC_FL_INSERT_RANGE)))
 		return -EOPNOTSUPP;
-- 
2.34.1.575.g55b058a8bb-goog

