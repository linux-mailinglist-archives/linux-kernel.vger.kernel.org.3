Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B26864A86E4
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 15:48:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351480AbiBCOr0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 09:47:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351351AbiBCOrN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 09:47:13 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C674C06173D
        for <linux-kernel@vger.kernel.org>; Thu,  3 Feb 2022 06:47:13 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AE503619C6
        for <linux-kernel@vger.kernel.org>; Thu,  3 Feb 2022 14:47:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07328C340E4;
        Thu,  3 Feb 2022 14:47:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643899632;
        bh=HsISUCVfu1iUw1BVQ2l4vNJsgdtVwJ6qtpiQzSoC5as=;
        h=From:To:Cc:Subject:Date:From;
        b=SK+mkJx8u6S8ZgT7OW2Z+bbqatlwui/sMuRXvTn6ItzkjyGHBZZXJGwxQSfs79287
         z+0aMg+lHj6gIMkdfG3T00Mvj24b1fUaiKxzlEi2/Ofb99QMM/W8djmhMJJDR/tfSZ
         xdaFCLaA/RQcdQA5F+vMSmDWl7eEGMcldz6zue4UBaw+QBserFBtEDyy93q/liRIZh
         yqie5ayExS+KmGqJs/EZpCCJG4++VpR9jWXofTJtbvPOEIVzIemit9xaG3mIdoN2op
         0d1W67+YeDui5rOfznX876bXylj14gVZAZJJgg/MoSGLq5bvnjUmUOxyFPT2rk0tA7
         bskTm/wQJoM6w==
From:   Chao Yu <chao@kernel.org>
To:     jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Chao Yu <chao@kernel.org>,
        Pavel Machek <pavel@denx.de>
Subject: [PATCH] f2fs: fix to unlock page correctly in error path of is_alive()
Date:   Thu,  3 Feb 2022 22:47:05 +0800
Message-Id: <20220203144705.23528-1-chao@kernel.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As Pavel Machek reported in below link [1]:

After commit 77900c45ee5c ("f2fs: fix to do sanity check in is_alive()"),
node page should be unlock via calling f2fs_put_page() in the error path
of is_alive(), otherwise, f2fs may hang when it tries to lock the node
page, fix it.

[1] https://lore.kernel.org/stable/20220124203637.GA19321@duo.ucw.cz/

Fixes: 77900c45ee5c ("f2fs: fix to do sanity check in is_alive()")
Reported-by: Pavel Machek <pavel@denx.de>
Signed-off-by: Pavel Machek <pavel@denx.de>
Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/gc.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index 0a6b0a8ae97e..2d53ef121e76 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -1038,8 +1038,10 @@ static bool is_alive(struct f2fs_sb_info *sbi, struct f2fs_summary *sum,
 		set_sbi_flag(sbi, SBI_NEED_FSCK);
 	}
 
-	if (f2fs_check_nid_range(sbi, dni->ino))
+	if (f2fs_check_nid_range(sbi, dni->ino)) {
+		f2fs_put_page(node_page, 1);
 		return false;
+	}
 
 	*nofs = ofs_of_node(node_page);
 	source_blkaddr = data_blkaddr(NULL, node_page, ofs_in_node);
-- 
2.32.0

