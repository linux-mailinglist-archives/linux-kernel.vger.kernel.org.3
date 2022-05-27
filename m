Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9602B5359BC
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 09:01:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344701AbiE0HBt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 03:01:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234075AbiE0HBq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 03:01:46 -0400
Received: from out30-42.freemail.mail.aliyun.com (out30-42.freemail.mail.aliyun.com [115.124.30.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25F4226DB
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 00:01:43 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R211e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0VEW9436_1653634894;
Received: from e18g06460.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VEW9436_1653634894)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 27 May 2022 15:01:41 +0800
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
To:     Chao Yu <chao@kernel.org>, linux-erofs@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org,
        Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH] erofs: update documentation
Date:   Fri, 27 May 2022 15:01:33 +0800
Message-Id: <20220527070133.77962-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.24.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 - refine the filesystem overview for better description of recent
   new features like FSDAX or Fscache;

 - add the new `fsid' mount option;

 - fix some typos.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 Documentation/filesystems/erofs.rst | 62 +++++++++++++++++++----------
 1 file changed, 41 insertions(+), 21 deletions(-)

diff --git a/Documentation/filesystems/erofs.rst b/Documentation/filesystems/erofs.rst
index bef6d3040ce4..4f108a218049 100644
--- a/Documentation/filesystems/erofs.rst
+++ b/Documentation/filesystems/erofs.rst
@@ -1,63 +1,82 @@
 .. SPDX-License-Identifier: GPL-2.0
 
 ======================================
-Enhanced Read-Only File System - EROFS
+EROFS - Enhanced Read-Only File System
 ======================================
 
 Overview
 ========
 
-EROFS file-system stands for Enhanced Read-Only File System. Different
-from other read-only file systems, it aims to be designed for flexibility,
-scalability, but be kept simple and high performance.
+EROFS filesystem stands for Enhanced Read-Only File System.  It aims to form a
+generic read-only filesystem solution for various read-only use cases instead
+of just focusing on storage space saving without considering any side effects
+of runtime performance.
 
-It is designed as a better filesystem solution for the following scenarios:
+It is designed to meet the needs of flexibility, feature extendability and user
+payload friendly, etc.  Apart from those, it is still kept as a simple
+random-access friendly high-performance filesystem to get rid of unneeded I/O
+amplification and memory-resident overhead compared to similar approaches.
+
+It is implemented to be a better choice for the following scenarios:
 
  - read-only storage media or
 
  - part of a fully trusted read-only solution, which means it needs to be
    immutable and bit-for-bit identical to the official golden image for
-   their releases due to security and other considerations and
+   their releases due to security or other considerations and
 
  - hope to minimize extra storage space with guaranteed end-to-end performance
    by using compact layout, transparent file compression and direct access,
    especially for those embedded devices with limited memory and high-density
-   hosts with numerous containers;
+   hosts with numerous containers.
 
 Here is the main features of EROFS:
 
  - Little endian on-disk design;
 
- - Currently 4KB block size (nobh) and therefore maximum 16TB address space;
-
- - Metadata & data could be mixed by design;
+ - 4KiB block size and 32-bit block addresses, therefore 16TiB address space
+   at most for now;
 
- - 2 inode versions for different requirements:
+ - Two inode layouts for different requirements:
 
-   =====================  ============  =====================================
+   =====================  ============  ======================================
                           compact (v1)  extended (v2)
-   =====================  ============  =====================================
+   =====================  ============  ======================================
    Inode metadata size    32 bytes      64 bytes
-   Max file size          4 GB          16 EB (also limited by max. vol size)
+   Max file size          4 GiB         16 EiB (also limited by max. vol size)
    Max uids/gids          65536         4294967296
    Per-inode timestamp    no            yes (64 + 32-bit timestamp)
    Max hardlinks          65536         4294967296
    Metadata reserved      4 bytes       14 bytes
-   =====================  ============  =====================================
+   =====================  ============  ======================================
+
+ - Metadata and data could be mixed as an option;
 
  - Support extended attributes (xattrs) as an option;
 
- - Support xattr inline and tail-end data inline for all files;
+ - Support tailpacking data inline and xattr inline compared to byte-addressed
+   unaligned metadata or smaller block size alternatives;
 
  - Support POSIX.1e ACLs by using xattrs;
 
  - Support transparent data compression as an option:
-   LZ4 algorithm with the fixed-sized output compression for high performance;
+   LZ4 and MicroLZMA algorithms can be used on a per-file basis; In addition,
+   inplace decompression is also supported to avoid bounce compressed buffers
+   and page cache thrashing.
+
+ - Support direct I/O on uncompressed files to avoid double caching for loop
+   devices;
 
- - Multiple device support for multi-layer container images.
+ - Support FSDAX on uncompressed images for secure containers and ramdisks in
+   order to get rid of unnecessary page cache.
+
+ - Support multiple devices for multi blob container images;
+
+ - Support file-based on-demand loading with the Fscache infrastructure.
 
 The following git tree provides the file system user-space tools under
-development (ex, formatting tool mkfs.erofs):
+development, such as a formatting tool (mkfs.erofs), an on-disk consistency &
+compatibility checking tool (fsck.erofs), and a debugging tool (dump.erofs):
 
 - git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs-utils.git
 
@@ -91,6 +110,7 @@ dax={always,never}     Use direct access (no page cache).  See
                        Documentation/filesystems/dax.rst.
 dax                    A legacy option which is an alias for ``dax=always``.
 device=%s              Specify a path to an extra device to be used together.
+fsid=%s                Specify a filesystem image ID for Fscache back-end.
 ===================    =========================================================
 
 Sysfs Entries
@@ -226,8 +246,8 @@ Note that apart from the offset of the first filename, nameoff0 also indicates
 the total number of directory entries in this block since it is no need to
 introduce another on-disk field at all.
 
-Chunk-based file
-----------------
+Chunk-based files
+-----------------
 In order to support chunk-based data deduplication, a new inode data layout has
 been supported since Linux v5.15: Files are split in equal-sized data chunks
 with ``extents`` area of the inode metadata indicating how to get the chunk
-- 
2.24.4

