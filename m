Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EDCB4E1C2F
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Mar 2022 16:11:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245335AbiCTPM5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Mar 2022 11:12:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233927AbiCTPMz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Mar 2022 11:12:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29005199508
        for <linux-kernel@vger.kernel.org>; Sun, 20 Mar 2022 08:11:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AE5CB61163
        for <linux-kernel@vger.kernel.org>; Sun, 20 Mar 2022 15:11:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9A91C340E9;
        Sun, 20 Mar 2022 15:11:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647789091;
        bh=KcbLfc7Bfaq3o3LXcOKhrozhNyeQvxBcvnMZGTOFfUc=;
        h=From:To:Cc:Subject:Date:From;
        b=qhR8TDsw5hzRsmRm8oVmTPW0zTbvnCYH3ep65I1MWsQAJS953rD/MVDlzqZV0ydU+
         e8Tcag8aD0SritfgoUBlO25rddxxOSqcPiICz4YBIso0zuLoUDRG6l5P/9T0CpFlqG
         l8/zFDCxt7U7buFjctRnhP2a2yZu9FYWMErpcYWfYx1JchBI2ipwAcrXxq6YPXyGyO
         noHVyprHWmVoHek3vZm113l0qNqZ3hXUcPPxEDB05d2fJ0wIrxLp1GX3eutLOzPCV7
         oRnl2UmohPlCYt5A/gp8VYod0fupn9WgPcDoeBxfr/sShczdpqw838HwIaXPXQv5Ie
         lwvW24OiknAvg==
From:   Chao Yu <chao@kernel.org>
To:     jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Chao Yu <chao@kernel.org>,
        Chao Yu <chao.yu@oppo.com>
Subject: [PATCH 1/3] f2fs: check pinfile in gc_data_segment() in advance
Date:   Sun, 20 Mar 2022 23:11:17 +0800
Message-Id: <20220320151119.837552-1-chao@kernel.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to skip migrating section which contains data of pinned
file in advance.

Signed-off-by: Chao Yu <chao.yu@oppo.com>
---
 fs/f2fs/gc.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index ea5b93b689cd..e83c07144d8f 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -1480,6 +1480,13 @@ static int gc_data_segment(struct f2fs_sb_info *sbi, struct f2fs_summary *sum,
 					special_file(inode->i_mode))
 				continue;
 
+			if (is_inode_flag_set(inode, FI_PIN_FILE) &&
+							gc_type == FG_GC) {
+				f2fs_pin_file_control(inode, true);
+				iput(inode);
+				return submitted;
+			}
+
 			if (!f2fs_down_write_trylock(
 				&F2FS_I(inode)->i_gc_rwsem[WRITE])) {
 				iput(inode);
-- 
2.32.0

