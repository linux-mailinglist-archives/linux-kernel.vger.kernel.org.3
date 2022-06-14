Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2D0A54AC9E
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 10:55:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356005AbiFNIzA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 04:55:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355971AbiFNIy6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 04:54:58 -0400
Received: from mail.nfschina.com (unknown [IPv6:2400:dd01:100f:2:72e2:84ff:fe10:5f45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 88E182314C;
        Tue, 14 Jun 2022 01:54:56 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by mail.nfschina.com (Postfix) with ESMTP id 5990C1E80D90;
        Tue, 14 Jun 2022 16:53:36 +0800 (CST)
X-Virus-Scanned: amavisd-new at test.com
Received: from mail.nfschina.com ([127.0.0.1])
        by localhost (mail.nfschina.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id AoZYzFdfq0Ln; Tue, 14 Jun 2022 16:53:33 +0800 (CST)
Received: from ubuntu.localdomain (unknown [101.228.248.65])
        (Authenticated sender: yuzhe@nfschina.com)
        by mail.nfschina.com (Postfix) with ESMTPA id 9E1771E80D0E;
        Tue, 14 Jun 2022 16:53:32 +0800 (CST)
From:   Yu Zhe <yuzhe@nfschina.com>
To:     sfrench@samba.org
Cc:     linux-cifs@vger.kernel.org, samba-technical@lists.samba.org,
        linux-kernel@vger.kernel.org, liqiong@nfschina.com,
        Yu Zhe <yuzhe@nfschina.com>
Subject: [PATCH] cifs: remove unnecessary (void*) conversions.
Date:   Tue, 14 Jun 2022 01:54:49 -0700
Message-Id: <20220614085449.794181-1-yuzhe@nfschina.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove unnecessary void* type castings.

Signed-off-by: Yu Zhe <yuzhe@nfschina.com>
---
 fs/cifs/cifs_debug.c | 2 +-
 fs/cifs/connect.c    | 2 +-
 fs/cifs/inode.c      | 4 ++--
 fs/cifs/netmisc.c    | 2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/cifs/cifs_debug.c b/fs/cifs/cifs_debug.c
index 1dd995efd5b8..c4dc8dbf755b 100644
--- a/fs/cifs/cifs_debug.c
+++ b/fs/cifs/cifs_debug.c
@@ -36,7 +36,7 @@ cifs_dump_mem(char *label, void *data, int length)
 void cifs_dump_detail(void *buf, struct TCP_Server_Info *server)
 {
 #ifdef CONFIG_CIFS_DEBUG2
-	struct smb_hdr *smb = (struct smb_hdr *)buf;
+	struct smb_hdr *smb = buf;
 
 	cifs_dbg(VFS, "Cmd: %d Err: 0x%x Flags: 0x%x Flgs2: 0x%x Mid: %d Pid: %d\n",
 		 smb->Command, smb->Status.CifsError,
diff --git a/fs/cifs/connect.c b/fs/cifs/connect.c
index 1849e3411487..0fcb8fb0be85 100644
--- a/fs/cifs/connect.c
+++ b/fs/cifs/connect.c
@@ -2603,7 +2603,7 @@ match_prepath(struct super_block *sb, struct cifs_mnt_data *mnt_data)
 int
 cifs_match_super(struct super_block *sb, void *data)
 {
-	struct cifs_mnt_data *mnt_data = (struct cifs_mnt_data *)data;
+	struct cifs_mnt_data *mnt_data = data;
 	struct smb3_fs_context *ctx;
 	struct cifs_sb_info *cifs_sb;
 	struct TCP_Server_Info *tcp_srv;
diff --git a/fs/cifs/inode.c b/fs/cifs/inode.c
index 81da81e18553..3ad303dd5e5a 100644
--- a/fs/cifs/inode.c
+++ b/fs/cifs/inode.c
@@ -1223,7 +1223,7 @@ static const struct inode_operations cifs_ipc_inode_ops = {
 static int
 cifs_find_inode(struct inode *inode, void *opaque)
 {
-	struct cifs_fattr *fattr = (struct cifs_fattr *) opaque;
+	struct cifs_fattr *fattr = opaque;
 
 	/* don't match inode with different uniqueid */
 	if (CIFS_I(inode)->uniqueid != fattr->cf_uniqueid)
@@ -1247,7 +1247,7 @@ cifs_find_inode(struct inode *inode, void *opaque)
 static int
 cifs_init_inode(struct inode *inode, void *opaque)
 {
-	struct cifs_fattr *fattr = (struct cifs_fattr *) opaque;
+	struct cifs_fattr *fattr = opaque;
 
 	CIFS_I(inode)->uniqueid = fattr->cf_uniqueid;
 	CIFS_I(inode)->createtime = fattr->cf_createtime;
diff --git a/fs/cifs/netmisc.c b/fs/cifs/netmisc.c
index 235aa1b395eb..28caae7aed1b 100644
--- a/fs/cifs/netmisc.c
+++ b/fs/cifs/netmisc.c
@@ -911,7 +911,7 @@ map_and_check_smb_error(struct mid_q_entry *mid, bool logErr)
 unsigned int
 smbCalcSize(void *buf, struct TCP_Server_Info *server)
 {
-	struct smb_hdr *ptr = (struct smb_hdr *)buf;
+	struct smb_hdr *ptr = buf;
 	return (sizeof(struct smb_hdr) + (2 * ptr->WordCount) +
 		2 /* size of the bcc field */ + get_bcc(ptr));
 }
-- 
2.25.1

