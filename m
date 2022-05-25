Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F29BD533510
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 03:56:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243009AbiEYB4q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 21:56:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239239AbiEYB4o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 21:56:44 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6CF72C675
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 18:56:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 58A65B81C03
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 01:56:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60E9AC34100;
        Wed, 25 May 2022 01:56:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653443801;
        bh=hNHaLYvjKeAxDgpE7qKiVuYLTc51rccayDM5S5yqzkM=;
        h=From:To:Cc:Subject:Date:From;
        b=HqxwfzFzjDfU7SRG2BfRajIWClMs/kpuOLa7VZSBEcKwmOLSA59INHgjGSVsInWbH
         LwF5kFHXstg/igZgSGOAfkyIQscBp3ooPWZu8gETaQv166TBhp9822sp9BzpkZnKBk
         JNprhK4E36cUR4DROICWCn98CF/7fXLuQ+BwlOE9cU67myilCoNNGryY5GIFGaynVM
         QPJWPO/cvoUmHH4/JL+yNuquUQ5ce3zThpu+ss87THXaQqSHC9lltCvwJ0YmpckV3Y
         S6gqbypEPXC3+0OeMj6KfzxBXFucawEwA3KPKUJ+13N59lzY1zfUQm7AJfRxlD67rj
         RARZDR10TZ+Yg==
From:   Chao Yu <chao@kernel.org>
To:     jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Chao Yu <chao@kernel.org>,
        Chao Yu <chao.yu@oppo.com>
Subject: [PATCH] f2fs: avoid unneeded error handling for revoke_entry_slab allocation
Date:   Wed, 25 May 2022 09:56:34 +0800
Message-Id: <20220525015634.3985529-1-chao@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In __f2fs_commit_atomic_write(), we will guarantee success of
revoke_entry_slab allocation, so let's avoid unneeded error handling.

Signed-off-by: Chao Yu <chao.yu@oppo.com>
---
 fs/f2fs/segment.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 0a4180f64291..51ceff797b97 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -315,11 +315,6 @@ static int __f2fs_commit_atomic_write(struct inode *inode)
 
 			new = f2fs_kmem_cache_alloc(revoke_entry_slab, GFP_NOFS,
 							true, NULL);
-			if (!new) {
-				f2fs_put_dnode(&dn);
-				ret = -ENOMEM;
-				goto out;
-			}
 
 			ret = __replace_atomic_write_block(inode, index, blkaddr,
 							&new->old_addr, false);
-- 
2.25.1

