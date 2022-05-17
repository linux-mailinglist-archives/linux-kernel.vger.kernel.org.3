Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A33F352984D
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 05:37:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233081AbiEQDhi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 23:37:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229935AbiEQDhc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 23:37:32 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 006AC4131E
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 20:37:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7F4E1B816D4
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 03:37:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73B6CC385B8;
        Tue, 17 May 2022 03:37:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652758649;
        bh=isWA7aLKx1dRpSJoWvz9DhEYkVr5Q60QsXwO9Q/jGhM=;
        h=From:To:Cc:Subject:Date:From;
        b=V78V9rnoN5nzFCHqK1RTxSX8hlyxcPv3GqZMMY0OuyTVq7hyMyizIsdYegR/duGMo
         Bm5RFnJ+H8kOLMuiFJ6wPOSJrAb0KwgZXki1N4QL3HSIyAyh4fR5n3XuNd5uDKNC+3
         JV7JNffFcrH0hEHccTWRNCR8ACMTdp4KvXLhOhHDpEpgyMPdNJrAoUahqgNm70h/kc
         ODyDp6jGNzBF3MEWjryW/Hlc2mwwMXcRKLw1lhUP+oURDQaK0/r19qFJea8jekLwf0
         rQeWQXHGPpX1L9fdmmg64JiIRiIqSFqQ2QUFWUo0HIJZsIODH8gc1qpMpd0q+HpjBk
         3aSXPLclokfWg==
From:   Chao Yu <chao@kernel.org>
To:     jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Chao Yu <chao@kernel.org>,
        stable@kernel.org, Chao Yu <chao.yu@oppo.com>
Subject: [PATCH] f2fs: fix fallocate to use file_modified to update permissions consistently
Date:   Tue, 17 May 2022 11:37:23 +0800
Message-Id: <20220517033723.3565469-1-chao@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch tries to fix permission consistency issue as all other
mainline filesystems.

Since the initial introduction of (posix) fallocate back at the turn of
the century, it has been possible to use this syscall to change the
user-visible contents of files.  This can happen by extending the file
size during a preallocation, or through any of the newer modes (punch,
zero, collapse, insert range).  Because the call can be used to change
file contents, we should treat it like we do any other modification to a
file -- update the mtime, and drop set[ug]id privileges/capabilities.

The VFS function file_modified() does all this for us if pass it a
locked inode, so let's make fallocate drop permissions correctly.

Cc: stable@kernel.org
Signed-off-by: Chao Yu <chao.yu@oppo.com>
---
 fs/f2fs/file.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 73ba1c6dceaa..f23a7cdee657 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -1783,6 +1783,10 @@ static long f2fs_fallocate(struct file *file, int mode,
 
 	inode_lock(inode);
 
+	ret = file_modified(file);
+	if (ret)
+		goto out;
+
 	if (mode & FALLOC_FL_PUNCH_HOLE) {
 		if (offset >= inode->i_size)
 			goto out;
-- 
2.25.1

