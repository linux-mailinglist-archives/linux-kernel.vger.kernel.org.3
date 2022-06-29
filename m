Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F84D5600F6
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 15:10:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233793AbiF2NIA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 09:08:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233757AbiF2NHx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 09:07:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19D022E9DD
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 06:07:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AA1E361DF8
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 13:07:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAF79C34114;
        Wed, 29 Jun 2022 13:07:17 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="VnMFDKTf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1656508036;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+cNHKtE95GsFoHDL/3ALQ8YKwfdHzX/1d4YROHsMAlI=;
        b=VnMFDKTfaxlEDM+WOeSPlIH1Q3kNF6bOQ1e0odNdT9nYfGkuEZOIFpS5ebHbPHc2umooYT
        k/sng0112JSuB64IHUg9vExDMlC3rYATbmPR9CV3m/DFmIlBzPzzyQpa7SmOK/F/jM4ZEK
        fQi4YU8JI+XMKlYr7mYP3/UYf+d07mk=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 41b7ce59 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Wed, 29 Jun 2022 13:07:16 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: [PATCH v3 4/7] fs: do not compare against ->llseek
Date:   Wed, 29 Jun 2022 15:06:59 +0200
Message-Id: <20220629130702.954310-5-Jason@zx2c4.com>
In-Reply-To: <20220629130702.954310-1-Jason@zx2c4.com>
References: <20220629130702.954310-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now we can rely on llseek being functional (via vfs_llseek) if
FMODE_LSEEK is set, so remove the old broken comparisons.

Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 fs/coredump.c          | 4 ++--
 fs/overlayfs/copy_up.c | 3 +--
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/fs/coredump.c b/fs/coredump.c
index ebc43f960b64..9f4aae202109 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -816,9 +816,9 @@ static int __dump_skip(struct coredump_params *cprm, size_t nr)
 {
 	static char zeroes[PAGE_SIZE];
 	struct file *file = cprm->file;
-	if (file->f_op->llseek && file->f_op->llseek != no_llseek) {
+	if (file->f_mode & FMODE_LSEEK) {
 		if (dump_interrupted() ||
-		    file->f_op->llseek(file, nr, SEEK_CUR) < 0)
+		    vfs_llseek(file, nr, SEEK_CUR) < 0)
 			return 0;
 		cprm->pos += nr;
 		return 1;
diff --git a/fs/overlayfs/copy_up.c b/fs/overlayfs/copy_up.c
index 714ec569d25b..022606c9703b 100644
--- a/fs/overlayfs/copy_up.c
+++ b/fs/overlayfs/copy_up.c
@@ -226,8 +226,7 @@ static int ovl_copy_up_data(struct ovl_fs *ofs, struct path *old,
 	/* Couldn't clone, so now we try to copy the data */
 
 	/* Check if lower fs supports seek operation */
-	if (old_file->f_mode & FMODE_LSEEK &&
-	    old_file->f_op->llseek)
+	if (old_file->f_mode & FMODE_LSEEK)
 		skip_hole = true;
 
 	while (len) {
-- 
2.35.1

