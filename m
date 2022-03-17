Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 412AE4DC50A
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 12:50:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233131AbiCQLvW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 07:51:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231431AbiCQLvV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 07:51:21 -0400
Received: from out30-56.freemail.mail.aliyun.com (out30-56.freemail.mail.aliyun.com [115.124.30.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5342F1D4C0F
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 04:50:04 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04395;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0V7RQQb7_1647517801;
Received: from e18g06460.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0V7RQQb7_1647517801)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 17 Mar 2022 19:50:01 +0800
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
To:     linux-erofs@lists.ozlabs.org, Chao Yu <chao@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        David Anderson <dvander@google.com>,
        Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH v2] erofs: rename ctime to mtime
Date:   Thu, 17 Mar 2022 19:49:59 +0800
Message-Id: <20220317114959.106787-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.24.4
In-Reply-To: <YjFrSivX%2F%2F3sGdSr@B-P7TQMD6M-0146.local>
References: <YjFrSivX%2F%2F3sGdSr@B-P7TQMD6M-0146.local>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Anderson <dvander@google.com>

EROFS images should inherit modification time rather than change time,
since users and host tooling have no easy way to control change time.

To reflect the new timestamp meaning, i_ctime and i_ctime_nsec are
renamed to i_mtime and i_mtime_nsec.

Signed-off-by: David Anderson <dvander@google.com>
[ Gao Xiang: update document as well. ]
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
If no other concerns, I will apply it for 5.18.

 Documentation/filesystems/erofs.rst | 2 +-
 fs/erofs/erofs_fs.h                 | 5 +++--
 fs/erofs/inode.c                    | 4 ++--
 3 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/Documentation/filesystems/erofs.rst b/Documentation/filesystems/erofs.rst
index 7119aa213be7..bef6d3040ce4 100644
--- a/Documentation/filesystems/erofs.rst
+++ b/Documentation/filesystems/erofs.rst
@@ -40,7 +40,7 @@ Here is the main features of EROFS:
    Inode metadata size    32 bytes      64 bytes
    Max file size          4 GB          16 EB (also limited by max. vol size)
    Max uids/gids          65536         4294967296
-   File change time       no            yes (64 + 32-bit timestamp)
+   Per-inode timestamp    no            yes (64 + 32-bit timestamp)
    Max hardlinks          65536         4294967296
    Metadata reserved      4 bytes       14 bytes
    =====================  ============  =====================================
diff --git a/fs/erofs/erofs_fs.h b/fs/erofs/erofs_fs.h
index 3ea62c6fb00a..1238ca104f09 100644
--- a/fs/erofs/erofs_fs.h
+++ b/fs/erofs/erofs_fs.h
@@ -12,6 +12,7 @@
 #define EROFS_SUPER_OFFSET      1024
 
 #define EROFS_FEATURE_COMPAT_SB_CHKSUM          0x00000001
+#define EROFS_FEATURE_COMPAT_MTIME              0x00000002
 
 /*
  * Any bits that aren't in EROFS_ALL_FEATURE_INCOMPAT should
@@ -186,8 +187,8 @@ struct erofs_inode_extended {
 
 	__le32 i_uid;
 	__le32 i_gid;
-	__le64 i_ctime;
-	__le32 i_ctime_nsec;
+	__le64 i_mtime;
+	__le32 i_mtime_nsec;
 	__le32 i_nlink;
 	__u8   i_reserved2[16];
 };
diff --git a/fs/erofs/inode.c b/fs/erofs/inode.c
index ff62f84f47d3..e8b37ba5e9ad 100644
--- a/fs/erofs/inode.c
+++ b/fs/erofs/inode.c
@@ -113,8 +113,8 @@ static void *erofs_read_inode(struct erofs_buf *buf,
 		set_nlink(inode, le32_to_cpu(die->i_nlink));
 
 		/* extended inode has its own timestamp */
-		inode->i_ctime.tv_sec = le64_to_cpu(die->i_ctime);
-		inode->i_ctime.tv_nsec = le32_to_cpu(die->i_ctime_nsec);
+		inode->i_ctime.tv_sec = le64_to_cpu(die->i_mtime);
+		inode->i_ctime.tv_nsec = le32_to_cpu(die->i_mtime_nsec);
 
 		inode->i_size = le64_to_cpu(die->i_size);
 
-- 
2.24.4

