Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C7D755F21A
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 01:55:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231311AbiF1Xrm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 19:47:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231190AbiF1Xrj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 19:47:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8943C38788
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 16:47:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 25F6C61B7C
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 23:47:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DEE5C341CD;
        Tue, 28 Jun 2022 23:47:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656460057;
        bh=+ZRax8MPEredU/1+Bs9dXUbhcOVmW3HrTA16lC6ZIFE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oMprKlEtoRQtiOEkQZLQPYX/++Jdxk1iXoWh19FbjWoBjWja654lAIhS/a8jIzVps
         x10KsNGyFNxobidocUKrI4JWEw1KRASfgHWCKV8n1+JATdeGp1gBBSn24tsb8m6BC4
         LOyqf1oGb8bQki512pUYU0BW7O/jlvjrfDjIQlvKEn8u3grIkT4VDU1qj8Zywo4jr2
         eN4OFy4XvsLb6wNEC1Hx3BoeCMelqMuLcY1mErbkz1HPRNuKQcgMSXbfza5kFbuPGB
         yxLkdvm/MTpJ6YxyOYp05cwSwqJcIZL3ooQNVseEdm+2RvQgLcOQK2J9+TinIHjCh8
         G8haSdzS9pCaA==
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 3/3] f2fs: add a sysfs entry to show zone capacity
Date:   Tue, 28 Jun 2022 16:47:33 -0700
Message-Id: <20220628234733.3330502-3-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
In-Reply-To: <20220628234733.3330502-1-jaegeuk@kernel.org>
References: <20220628234733.3330502-1-jaegeuk@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds a sysfs entry showing the unusable space in a section
made by zone capacity.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 Documentation/ABI/testing/sysfs-fs-f2fs |  6 ++++++
 fs/f2fs/sysfs.c                         | 10 ++++++++++
 2 files changed, 16 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-fs-f2fs b/Documentation/ABI/testing/sysfs-fs-f2fs
index 9b583dd0298b..22c1efd49773 100644
--- a/Documentation/ABI/testing/sysfs-fs-f2fs
+++ b/Documentation/ABI/testing/sysfs-fs-f2fs
@@ -580,3 +580,9 @@ Date:		January 2022
 Contact:	"Jaegeuk Kim" <jaegeuk@kernel.org>
 Description:	Controls max # of node block writes to be used for roll forward
 		recovery. This can limit the roll forward recovery time.
+
+What:		/sys/fs/f2fs/<disk>/unusable_blocks_per_sec
+Date:		June 2022
+Contact:	"Jaegeuk Kim" <jaegeuk@kernel.org>
+Description:	Shows the number of unusable blocks in a section which was defined by
+		the zone capacity reported by underlying zoned device.
diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
index 4c50aedd5144..6eeefe60a7af 100644
--- a/fs/f2fs/sysfs.c
+++ b/fs/f2fs/sysfs.c
@@ -713,6 +713,11 @@ static struct f2fs_attr f2fs_attr_##_name = {			\
 	.offset = _offset					\
 }
 
+#define F2FS_RO_ATTR(struct_type, struct_name, name, elname)	\
+	F2FS_ATTR_OFFSET(struct_type, name, 0444,		\
+		f2fs_sbi_show, NULL,				\
+		offsetof(struct struct_name, elname))
+
 #define F2FS_RW_ATTR(struct_type, struct_name, name, elname)	\
 	F2FS_ATTR_OFFSET(struct_type, name, 0644,		\
 		f2fs_sbi_show, f2fs_sbi_store,			\
@@ -811,6 +816,8 @@ F2FS_FEATURE_RO_ATTR(encrypted_casefold);
 #endif /* CONFIG_FS_ENCRYPTION */
 #ifdef CONFIG_BLK_DEV_ZONED
 F2FS_FEATURE_RO_ATTR(block_zoned);
+F2FS_RO_ATTR(F2FS_SBI, f2fs_sb_info, unusable_blocks_per_sec,
+					unusable_blocks_per_sec);
 #endif
 F2FS_FEATURE_RO_ATTR(atomic_write);
 F2FS_FEATURE_RO_ATTR(extra_attr);
@@ -919,6 +926,9 @@ static struct attribute *f2fs_attrs[] = {
 	ATTR_LIST(moved_blocks_background),
 	ATTR_LIST(avg_vblocks),
 #endif
+#ifdef CONFIG_BLK_DEV_ZONED
+	ATTR_LIST(unusable_blocks_per_sec),
+#endif
 #ifdef CONFIG_F2FS_FS_COMPRESSION
 	ATTR_LIST(compr_written_block),
 	ATTR_LIST(compr_saved_block),
-- 
2.37.0.rc0.161.g10f37bed90-goog

