Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA7E15ABB82
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Sep 2022 02:00:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230394AbiIBX7r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 19:59:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230178AbiIBX7n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 19:59:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB23564F7;
        Fri,  2 Sep 2022 16:59:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6A7F46201B;
        Fri,  2 Sep 2022 23:59:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25388C433D6;
        Fri,  2 Sep 2022 23:59:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662163181;
        bh=W8ti3zVsha1L/AuHd1jDm7TAZKo5OlYXymvwuJgcnwU=;
        h=Date:From:To:Cc:Subject:From;
        b=l9jtwONRVIVTIJa3K7WkVc/D1kdK/D6TwoCMfUVuAoH1ZA7cP/yop/OX8voudx6VY
         6/diT/UQ61Pl1qXTaqXxi+ZluebGjPnRucjzG/rIWAomcUfNgnI5R7G2zlNPxxRNSX
         Ee8MWIpkEiGbbK63H7lT5t9plciDdADlP0uWUjfon3RiYR6H/H9sZKbLdXaXevwIod
         Qch7ZJ12/fI3kEYzttCHkZ73k5EmREeuVHTbzSaEsLoLoKO0/i3rxCgj2eWS4wEChs
         ICjFCb0XzziiTLFcnFwBJ1HomvhX138/swPaqdQ6zbrdMfo2BIgH2YFjGai52mvgwf
         rPSTmP1lj6FQw==
Date:   Sat, 3 Sep 2022 00:59:36 +0100
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Mark Fasheh <mark@fasheh.com>, Joel Becker <jlbec@evilplan.org>,
        Joseph Qi <joseph.qi@linux.alibaba.com>
Cc:     ocfs2-devel@oss.oracle.com, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-hardening@vger.kernel.org
Subject: [PATCH][next] ocfs2: Replace zero-length arrays with
 DECLARE_FLEX_ARRAY() helper
Message-ID: <YxKY6O2hmdwNh8r8@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Zero-length arrays are deprecated and we are moving towards adopting
C99 flexible-array members, instead. So, replace zero-length array
declarations in a couple of structures and unions with the new
DECLARE_FLEX_ARRAY() helper macro.

This helper allows for a flexible-array member in a union and as
only member in a structure.

Also, this addresses multiple warnings reported when building with
Clang-15 and -Wzero-length-array.

Lastly, this will also help memcpy (in a coming hardening update)
execute proper bounds-checking on variable length object i_symlink
at fs/ocfs2/namei.c:1973:

fs/ocfs2/namei.c:
1973                 memcpy((char *) fe->id2.i_symlink, symname, l);

Link: https://github.com/KSPP/linux/issues/21
Link: https://github.com/KSPP/linux/issues/193
Link: https://github.com/KSPP/linux/issues/197
Link: https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 fs/ocfs2/ocfs2_fs.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/ocfs2/ocfs2_fs.h b/fs/ocfs2/ocfs2_fs.h
index 638d875eccc7..7aebdbf5cc0a 100644
--- a/fs/ocfs2/ocfs2_fs.h
+++ b/fs/ocfs2/ocfs2_fs.h
@@ -527,7 +527,7 @@ struct ocfs2_extent_block
  * value -1 (0xFFFF) is OCFS2_INVALID_SLOT.  This marks a slot empty.
  */
 struct ocfs2_slot_map {
-/*00*/	__le16 sm_slots[0];
+/*00*/	DECLARE_FLEX_ARRAY(__le16, sm_slots);
 /*
  * Actual on-disk size is one block.  OCFS2_MAX_SLOTS is 255,
  * 255 * sizeof(__le16) == 512B, within the 512B block minimum blocksize.
@@ -548,7 +548,7 @@ struct ocfs2_extended_slot {
  * i_size.
  */
 struct ocfs2_slot_map_extended {
-/*00*/	struct ocfs2_extended_slot se_slots[0];
+/*00*/	DECLARE_FLEX_ARRAY(struct ocfs2_extended_slot, se_slots);
 /*
  * Actual size is i_size of the slot_map system file.  It should
  * match s_max_slots * sizeof(struct ocfs2_extended_slot)
@@ -727,7 +727,7 @@ struct ocfs2_dinode {
 		struct ocfs2_extent_list	i_list;
 		struct ocfs2_truncate_log	i_dealloc;
 		struct ocfs2_inline_data	i_data;
-		__u8               		i_symlink[0];
+		DECLARE_FLEX_ARRAY(__u8,	i_symlink);
 	} id2;
 /* Actual on-disk size is one block */
 };
@@ -892,7 +892,7 @@ struct ocfs2_group_desc
 /*30*/	struct ocfs2_block_check bg_check;	/* Error checking */
 	__le64   bg_reserved2;
 /*40*/	union {
-		__u8    bg_bitmap[0];
+		DECLARE_FLEX_ARRAY(__u8, bg_bitmap);
 		struct {
 			/*
 			 * Block groups may be discontiguous when
-- 
2.34.1

