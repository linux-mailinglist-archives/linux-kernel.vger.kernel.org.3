Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 178FD56165A
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 11:32:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233973AbiF3Jb2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 05:31:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233020AbiF3JbY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 05:31:24 -0400
Received: from mail.nfschina.com (unknown [IPv6:2400:dd01:100f:2:72e2:84ff:fe10:5f45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 47FC442A33;
        Thu, 30 Jun 2022 02:31:22 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by mail.nfschina.com (Postfix) with ESMTP id 7339D1E80D11;
        Thu, 30 Jun 2022 17:30:01 +0800 (CST)
X-Virus-Scanned: amavisd-new at test.com
Received: from mail.nfschina.com ([127.0.0.1])
        by localhost (mail.nfschina.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id tcSNZRmyGWA2; Thu, 30 Jun 2022 17:29:58 +0800 (CST)
Received: from localhost.localdomain (unknown [180.167.10.98])
        (Authenticated sender: yuzhe@nfschina.com)
        by mail.nfschina.com (Postfix) with ESMTPA id 53F231E80CB6;
        Thu, 30 Jun 2022 17:29:58 +0800 (CST)
From:   Yu Zhe <yuzhe@nfschina.com>
To:     sfrench@samba.org
Cc:     linux-cifs@vger.kernel.org, samba-technical@lists.samba.org,
        linux-kernel@vger.kernel.org, liqiong@nfschina.com,
        Yu Zhe <yuzhe@nfschina.com>
Subject: [PATCH] cifs: remove unnecessary type castings
Date:   Thu, 30 Jun 2022 17:30:27 +0800
Message-Id: <20220630093027.26200-1-yuzhe@nfschina.com>
X-Mailer: git-send-email 2.11.0
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
 fs/cifs/connect.c  | 2 +-
 fs/cifs/inode.c    | 4 ++--
 fs/cifs/netmisc.c  | 2 +-
 fs/cifs/smb2misc.c | 2 +-
 fs/cifs/smb2pdu.c  | 2 +-
 5 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/fs/cifs/connect.c b/fs/cifs/connect.c
index fa29c9aae24b..90863b3b5204 100644
--- a/fs/cifs/connect.c
+++ b/fs/cifs/connect.c
@@ -2646,7 +2646,7 @@ match_prepath(struct super_block *sb, struct cifs_mnt_data *mnt_data)
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
diff --git a/fs/cifs/smb2misc.c b/fs/cifs/smb2misc.c
index 17813c3d0c6e..db0f27fd373b 100644
--- a/fs/cifs/smb2misc.c
+++ b/fs/cifs/smb2misc.c
@@ -402,7 +402,7 @@ smb2_get_data_area_len(int *off, int *len, struct smb2_hdr *shdr)
 unsigned int
 smb2_calc_size(void *buf, struct TCP_Server_Info *srvr)
 {
-	struct smb2_pdu *pdu = (struct smb2_pdu *)buf;
+	struct smb2_pdu *pdu = buf;
 	struct smb2_hdr *shdr = &pdu->hdr;
 	int offset; /* the offset from the beginning of SMB to data area */
 	int data_length; /* the length of the variable length data area */
diff --git a/fs/cifs/smb2pdu.c b/fs/cifs/smb2pdu.c
index 12b4dddaedb0..92fb513e5478 100644
--- a/fs/cifs/smb2pdu.c
+++ b/fs/cifs/smb2pdu.c
@@ -354,7 +354,7 @@ fill_small_buf(__le16 smb2_command, struct cifs_tcon *tcon,
 	       void *buf,
 	       unsigned int *total_len)
 {
-	struct smb2_pdu *spdu = (struct smb2_pdu *)buf;
+	struct smb2_pdu *spdu = buf;
 	/* lookup word count ie StructureSize from table */
 	__u16 parmsize = smb2_req_struct_sizes[le16_to_cpu(smb2_command)];
 
-- 
2.11.0

