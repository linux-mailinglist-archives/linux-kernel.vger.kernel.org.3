Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44CFB51E28C
	for <lists+linux-kernel@lfdr.de>; Sat,  7 May 2022 01:41:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444950AbiEFXY1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 19:24:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355522AbiEFXYX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 19:24:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B1042AC63
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 16:20:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 992D961A01
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 23:20:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3325C385A8;
        Fri,  6 May 2022 23:20:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651879234;
        bh=Equ3KAligNPBOnEusR03evXVwk87qPTr3C3S0lOJka0=;
        h=From:To:Cc:Subject:Date:From;
        b=l+BbfqRBpHaBkitbrWhYcbcDmIYXWmiS79QhKnQGE1r4C67IiNKHCk2R/+w/6AAij
         w9aqr0V23ae2kjED3iyGt9jcoFWJ8B6bM/0UaFmk6dHImdpMebKNPR7p7NKJ/icuWy
         S9k+FaiPBcAnZx+q9shQAEYkSWaWWTMLn4onwRzzKPALKwKTA7BxFKul/DsT0OC9Uy
         EaTZ9Xdz/G8aBgRtUpB1DtTpXAEm6GbNyG+UJHnwybwUtbeD/goU1Y0lFQNK/K4Z9X
         2OnMr4BD/4CtwntbsAj3VZNrRfovyZ2fWbxVX9JEf6zr2blyUHHPlNPnEYFcaAQ4dS
         rmjRH+RGfMHTg==
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 1/5] f2fs: stop allocating pinned sections if EAGAIN happens
Date:   Fri,  6 May 2022 16:20:28 -0700
Message-Id: <20220506232032.1264078-1-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.36.0.512.ge40c2bad7a-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

EAGAIN doesn't guarantee to have a free section. Let's report it.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index e4cf8b7b23aa..b307d96a0a7c 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -1685,7 +1685,7 @@ static int expand_inode_data(struct inode *inode, loff_t offset,
 			GET_SEC_FROM_SEG(sbi, overprovision_segments(sbi)))) {
 			f2fs_down_write(&sbi->gc_lock);
 			err = f2fs_gc(sbi, true, false, false, NULL_SEGNO);
-			if (err && err != -ENODATA && err != -EAGAIN)
+			if (err && err != -ENODATA)
 				goto out_err;
 		}
 
-- 
2.36.0.512.ge40c2bad7a-goog

