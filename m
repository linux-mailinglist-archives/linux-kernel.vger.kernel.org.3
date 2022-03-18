Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1029E4DD547
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 08:35:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233133AbiCRHgY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 03:36:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233128AbiCRHgW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 03:36:22 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3DE9117C85
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 00:35:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 190F9CE2681
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 07:35:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6082AC340EC;
        Fri, 18 Mar 2022 07:34:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1647588901;
        bh=v3i9Go38w1KBuJ9IR4jSwRlFv0/OgX9Lvxu9XyNe3AA=;
        h=From:To:Cc:Subject:Date:From;
        b=F79Swd0cLTEvO/vG6RdChYwe1XLACl/P5GxiMAqQCtbXAABoOn3bff9ZB7iU/sYDJ
         gl3lxph3anaNgQcS8vsyOsXdK2wWdjvEgn9lqXNGVKoB0OvIORm47th+gfjGBBQgQ8
         QZVVOyfN5NYG9Vpl5qMPF65DV04H7BNxAAkyxFyM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>, Tejun Heo <tj@kernel.org>
Subject: [PATCH] kernfs: remove unneeded #if 0 guard
Date:   Fri, 18 Mar 2022 08:34:52 +0100
Message-Id: <20220318073452.1486568-1-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1412; h=from:subject; bh=v3i9Go38w1KBuJ9IR4jSwRlFv0/OgX9Lvxu9XyNe3AA=; b=owGbwMvMwCRo6H6F97bub03G02pJDEkmZtJfD/8L+/uEYV/0U+sZ8+Yym7iWnHLbfkTMZqas786S Y6YCHbEsDIJMDLJiiixftvEc3V9xSNHL0PY0zBxWJpAhDFycAjCRgHyG+Z7669UPKvQ4HtXWi69Qff Blv++2ywzz624GBs1Ivbb+nD6XdbW7g/hzJYddAA==
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit f2eb478f2f32 ("kernfs: move struct kernfs_root out of the public
view.") moved kernfs_root out of kernfs.h, but my debugging code of a
 #if 0 was left in accidentally.  Fix that up by removing the guards.

Fixes: f2eb478f2f32 ("kernfs: move struct kernfs_root out of the public view.")
Reported-by: Al Viro <viro@zeniv.linux.org.uk>
Cc: Tejun Heo <tj@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/linux/kernfs.h | 20 --------------------
 1 file changed, 20 deletions(-)

diff --git a/include/linux/kernfs.h b/include/linux/kernfs.h
index 62aff082dc3f..e2ae15a6225e 100644
--- a/include/linux/kernfs.h
+++ b/include/linux/kernfs.h
@@ -185,26 +185,6 @@ struct kernfs_syscall_ops {
 			 struct kernfs_root *root);
 };
 
-#if 0
-struct kernfs_root {
-	/* published fields */
-	struct kernfs_node	*kn;
-	unsigned int		flags;	/* KERNFS_ROOT_* flags */
-
-	/* private fields, do not use outside kernfs proper */
-	struct idr		ino_idr;
-	u32			last_id_lowbits;
-	u32			id_highbits;
-	struct kernfs_syscall_ops *syscall_ops;
-
-	/* list of kernfs_super_info of this root, protected by kernfs_rwsem */
-	struct list_head	supers;
-
-	wait_queue_head_t	deactivate_waitq;
-	struct rw_semaphore	kernfs_rwsem;
-};
-#endif
-
 struct kernfs_node *kernfs_root_to_node(struct kernfs_root *root);
 
 struct kernfs_open_file {
-- 
2.35.1

