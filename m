Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE79448A417
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 01:00:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345807AbiAKAAH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 19:00:07 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:34534 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345773AbiAKAAG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 19:00:06 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DA4D1B8172C;
        Tue, 11 Jan 2022 00:00:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37C27C36AF3;
        Tue, 11 Jan 2022 00:00:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641859203;
        bh=pADzQ3uH7mcl/zzkI+lzAz4AejYG8SBgS2Wlf9QLcxA=;
        h=From:To:Cc:Subject:Date:From;
        b=tDnSEhULEb5IImxI3c+Zq1WjN+jvkruseYPBB+u5lx6R7XOjYNEnpuSvikvuPdncg
         NOpfCHxLDq3CNELNd89yBha4MzSJIlEj39gqg+D9qbxeLhV7Funm6Cr/dmdWuqnM3W
         FLHFcpCXw2eAwp7bZzsNawCGM1WTBnBUcMYZzDffANJ6T5IYINUBlCVimP4oErjSRJ
         6w/zsSvvLmfTRZRjSxYomBLWx5R/k4REjo0B0WEoPRGsN5VYJDZJnqBz10yV8OTId/
         KhgEzaIfp4ahwQVdIOOW0MbA1qV56ntywtdqpy6vj++8kjmENkRa6JObP06aUolLkm
         1eFsnXnrG99kA==
From:   Jeff Layton <jlayton@kernel.org>
To:     smfrench@gmail.com
Cc:     linux-cifs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] cifs: move superblock magic defitions to magic.h
Date:   Mon, 10 Jan 2022 19:00:02 -0500
Message-Id: <20220111000002.139789-1-jlayton@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Help userland apps to identify cifs and smb2 mounts.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/cifs/cifsfs.c           | 3 ++-
 fs/cifs/cifsglob.h         | 2 --
 fs/cifs/smb1ops.c          | 3 ++-
 fs/cifs/smb2glob.h         | 2 --
 fs/cifs/smb2ops.c          | 5 +++--
 include/uapi/linux/magic.h | 4 ++++
 6 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/fs/cifs/cifsfs.c b/fs/cifs/cifsfs.c
index dca42aa87d30..5a4d56622d2b 100644
--- a/fs/cifs/cifsfs.c
+++ b/fs/cifs/cifsfs.c
@@ -26,6 +26,7 @@
 #include <linux/random.h>
 #include <linux/uuid.h>
 #include <linux/xattr.h>
+#include <uapi/linux/magic.h>
 #include <net/ipv6.h>
 #include "cifsfs.h"
 #include "cifspdu.h"
@@ -202,7 +203,7 @@ cifs_read_super(struct super_block *sb)
 		sb->s_time_max = ts.tv_sec;
 	}
 
-	sb->s_magic = CIFS_MAGIC_NUMBER;
+	sb->s_magic = CIFS_SUPER_MAGIC;
 	sb->s_op = &cifs_super_ops;
 	sb->s_xattr = cifs_xattr_handlers;
 	rc = super_setup_bdi(sb);
diff --git a/fs/cifs/cifsglob.h b/fs/cifs/cifsglob.h
index be74606724c7..50e857e0a311 100644
--- a/fs/cifs/cifsglob.h
+++ b/fs/cifs/cifsglob.h
@@ -24,8 +24,6 @@
 #include "../smbfs_common/smb2pdu.h"
 #include "smb2pdu.h"
 
-#define CIFS_MAGIC_NUMBER 0xFF534D42      /* the first four bytes of SMB PDUs */
-
 #define SMB_PATH_MAX 260
 #define CIFS_PORT 445
 #define RFC1001_PORT 139
diff --git a/fs/cifs/smb1ops.c b/fs/cifs/smb1ops.c
index 3b83839fc2c2..dcc8b97e2bbf 100644
--- a/fs/cifs/smb1ops.c
+++ b/fs/cifs/smb1ops.c
@@ -7,6 +7,7 @@
 
 #include <linux/pagemap.h>
 #include <linux/vfs.h>
+#include <uapi/linux/magic.h>
 #include "cifsglob.h"
 #include "cifsproto.h"
 #include "cifs_debug.h"
@@ -878,7 +879,7 @@ cifs_queryfs(const unsigned int xid, struct cifs_tcon *tcon,
 {
 	int rc = -EOPNOTSUPP;
 
-	buf->f_type = CIFS_MAGIC_NUMBER;
+	buf->f_type = CIFS_SUPER_MAGIC;
 
 	/*
 	 * We could add a second check for a QFS Unix capability bit
diff --git a/fs/cifs/smb2glob.h b/fs/cifs/smb2glob.h
index ca692b2283cd..4125fd113cfb 100644
--- a/fs/cifs/smb2glob.h
+++ b/fs/cifs/smb2glob.h
@@ -13,8 +13,6 @@
 #ifndef _SMB2_GLOB_H
 #define _SMB2_GLOB_H
 
-#define SMB2_MAGIC_NUMBER 0xFE534D42
-
 /*
  *****************************************************************
  * Constants go here
diff --git a/fs/cifs/smb2ops.c b/fs/cifs/smb2ops.c
index c5b1dea54ebc..57e856c195b5 100644
--- a/fs/cifs/smb2ops.c
+++ b/fs/cifs/smb2ops.c
@@ -13,6 +13,7 @@
 #include <linux/sort.h>
 #include <crypto/aead.h>
 #include <linux/fiemap.h>
+#include <uapi/linux/magic.h>
 #include "cifsfs.h"
 #include "cifsglob.h"
 #include "smb2pdu.h"
@@ -2747,7 +2748,7 @@ smb2_queryfs(const unsigned int xid, struct cifs_tcon *tcon,
 		goto qfs_exit;
 
 	rsp = (struct smb2_query_info_rsp *)rsp_iov.iov_base;
-	buf->f_type = SMB2_MAGIC_NUMBER;
+	buf->f_type = SMB2_SUPER_MAGIC;
 	info = (struct smb2_fs_full_size_info *)(
 		le16_to_cpu(rsp->OutputBufferOffset) + (char *)rsp);
 	rc = smb2_validate_iov(le16_to_cpu(rsp->OutputBufferOffset),
@@ -2789,7 +2790,7 @@ smb311_queryfs(const unsigned int xid, struct cifs_tcon *tcon,
 
 	rc = SMB311_posix_qfs_info(xid, tcon, fid.persistent_fid,
 				   fid.volatile_fid, buf);
-	buf->f_type = SMB2_MAGIC_NUMBER;
+	buf->f_type = SMB2_SUPER_MAGIC;
 	SMB2_close(xid, tcon, fid.persistent_fid, fid.volatile_fid);
 	return rc;
 }
diff --git a/include/uapi/linux/magic.h b/include/uapi/linux/magic.h
index a3034558b018..9438fd4a79c9 100644
--- a/include/uapi/linux/magic.h
+++ b/include/uapi/linux/magic.h
@@ -53,6 +53,7 @@
 #define QNX6_SUPER_MAGIC	0x68191122	/* qnx6 fs detection */
 #define AFS_FS_MAGIC		0x6B414653
 
+
 #define REISERFS_SUPER_MAGIC	0x52654973	/* used by gcc */
 					/* used by file system utilities that
 	                                   look at the superblock, etc.  */
@@ -61,6 +62,9 @@
 #define REISER2FS_JR_SUPER_MAGIC_STRING	"ReIsEr3Fs"
 
 #define SMB_SUPER_MAGIC		0x517B
+#define CIFS_SUPER_MAGIC	0xFF534D42      /* the first four bytes of SMB PDUs */
+#define SMB2_SUPER_MAGIC	0xFE534D42
+
 #define CGROUP_SUPER_MAGIC	0x27e0eb
 #define CGROUP2_SUPER_MAGIC	0x63677270
 
-- 
2.34.1

