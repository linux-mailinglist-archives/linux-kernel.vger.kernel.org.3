Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0148B5AB51C
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 17:27:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236295AbiIBP1Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 11:27:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236488AbiIBP1D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 11:27:03 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1066017E430
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 07:59:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EBA84B82C4F
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 14:59:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4274CC433B5;
        Fri,  2 Sep 2022 14:59:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1662130758;
        bh=CoFme0zMBIUwRf3gNJvQ/ECW6i5MyW3v8WlXC7E5J4c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BGKQlsG6T2oEaL038tcYsu3uMXoieDl8RswMpsaulf4ARjk6zf8Vtwt5YVvjSSwiW
         eNbhG6/QRgMlm4Sb8WCCzW7Xi/9VxsV+OpwFqsu8OmiGf28WnMW1NCuuP1DgKl3cb0
         dl8yCbLkKzSPtTDqpANjnIo9+LRixIYYsOVBertY=
Date:   Fri, 2 Sep 2022 16:59:15 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Kuyo Chang <kuyo.chang@mediatek.com>, stable <stable@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH 1/2 v2] debugfs: add debugfs_lookup_and_remove()
Message-ID: <YxIaQ8cSinDR881k@kroah.com>
References: <20220902123107.109274-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220902123107.109274-1-gregkh@linuxfoundation.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a very common pattern of using
debugfs_remove(debufs_lookup(..)) which results in a dentry leak of the
dentry that was looked up.  Instead of having to open-code the correct
pattern of calling dput() on the dentry, create
debugfs_lookup_and_remove() to handle this pattern automatically and
properly without any memory leaks.

Reported-by: Kuyo Chang <kuyo.chang@mediatek.com>
Tested-by: Kuyo Chang <kuyo.chang@mediatek.com>
Cc: stable <stable@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
v2: fix up debugfs_lookup() return value check as pointed out by Al.


 fs/debugfs/inode.c      | 22 ++++++++++++++++++++++
 include/linux/debugfs.h |  6 ++++++
 2 files changed, 28 insertions(+)

diff --git a/fs/debugfs/inode.c b/fs/debugfs/inode.c
index 3dcf0b8b4e93..232cfdf095ae 100644
--- a/fs/debugfs/inode.c
+++ b/fs/debugfs/inode.c
@@ -744,6 +744,28 @@ void debugfs_remove(struct dentry *dentry)
 }
 EXPORT_SYMBOL_GPL(debugfs_remove);
 
+/**
+ * debugfs_lookup_and_remove - lookup a directory or file and recursively remove it
+ * @name: a pointer to a string containing the name of the item to look up.
+ * @parent: a pointer to the parent dentry of the item.
+ *
+ * This is the equlivant of doing something like
+ * debugfs_remove(debugfs_lookup(..)) but with the proper reference counting
+ * handled for the directory being looked up.
+ */
+void debugfs_lookup_and_remove(const char *name, struct dentry *parent)
+{
+	struct dentry *dentry;
+
+	dentry = debugfs_lookup(name, parent);
+	if (!dentry)
+		return;
+
+	debugfs_remove(dentry);
+	dput(dentry);
+}
+EXPORT_SYMBOL_GPL(debugfs_lookup_and_remove);
+
 /**
  * debugfs_rename - rename a file/directory in the debugfs filesystem
  * @old_dir: a pointer to the parent dentry for the renamed object. This
diff --git a/include/linux/debugfs.h b/include/linux/debugfs.h
index c869f1e73d75..f60674692d36 100644
--- a/include/linux/debugfs.h
+++ b/include/linux/debugfs.h
@@ -91,6 +91,8 @@ struct dentry *debugfs_create_automount(const char *name,
 void debugfs_remove(struct dentry *dentry);
 #define debugfs_remove_recursive debugfs_remove
 
+void debugfs_lookup_and_remove(const char *name, struct dentry *parent);
+
 const struct file_operations *debugfs_real_fops(const struct file *filp);
 
 int debugfs_file_get(struct dentry *dentry);
@@ -225,6 +227,10 @@ static inline void debugfs_remove(struct dentry *dentry)
 static inline void debugfs_remove_recursive(struct dentry *dentry)
 { }
 
+static inline void debugfs_lookup_and_remove(const char *name,
+					     struct dentry *parent)
+{ }
+
 const struct file_operations *debugfs_real_fops(const struct file *filp);
 
 static inline int debugfs_file_get(struct dentry *dentry)
-- 
2.37.3

