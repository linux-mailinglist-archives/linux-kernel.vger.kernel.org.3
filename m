Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CAB3480694
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Dec 2021 06:46:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232959AbhL1FqM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Dec 2021 00:46:12 -0500
Received: from out30-57.freemail.mail.aliyun.com ([115.124.30.57]:43187 "EHLO
        out30-57.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230113AbhL1FqL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Dec 2021 00:46:11 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R461e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01424;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0V0240kf_1640670365;
Received: from e18g06460.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0V0240kf_1640670365)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 28 Dec 2021 13:46:09 +0800
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
To:     linux-erofs@lists.ozlabs.org, Chao Yu <chao@kernel.org>
Cc:     Yue Hu <huyue2@yulong.com>, LKML <linux-kernel@vger.kernel.org>,
        Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH v4 0/5] erofs: support tail-packing inline compressed data
Date:   Tue, 28 Dec 2021 13:45:59 +0800
Message-Id: <20211228054604.114518-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.24.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks,

v2: https://lore.kernel.org/r/20211225070626.74080-1-hsiangkao@linux.alibaba.com
mkfs v8: https://lore.kernel.org/r/20211224012316.42929-1-hsiangkao@linux.alibaba.com

This is the 4th version of tail-packing inline compressed data feature.
It tries to inline the tail pcluster right after the inode metadata to
save data I/O and storage space.

Take Linux 5.10.87 source code as an example:
linux-5.10.87 (erofs, uncompressed)		972570624

linux-5.10.87 (erofs, lz4hc,9 4k tailpacking)	391696384
linux-5.10.87 (erofs, lz4hc,9 8k tailpacking)	368807936
linux-5.10.87 (erofs, lz4hc,9 16k tailpacking)	345649152

linux-5.10.87 (erofs, lz4hc,9 4k vanilla)	416079872
linux-5.10.87 (erofs, lz4hc,9 8k vanilla)	395493376
linux-5.10.87 (erofs, lz4hc,9 16k vanilla)	383213568

Thanks,
Gao Xiang

changes since v3:
 - add comments about z_erofs_lz4_decompress_ctx (Chao);
 - move cache_strategy together with preload_compressed_pages (Yue);
 - remove duplicated code about z_idata_size (Yue);
 - rename z_idata_headlcn to z_tailextent_headlcn since
   EROFS_GET_BLOCKS_FINDTAIL is a generic flag which is not
   only used for tail pcluster (Yue).

Gao Xiang (3):
  erofs: tidy up z_erofs_lz4_decompress
  erofs: introduce z_erofs_fixup_insize
  erofs: support unaligned data decompression

Yue Hu (2):
  erofs: support inline data decompression
  erofs: add on-disk compressed tail-packing inline support

 fs/erofs/compress.h          |   4 +-
 fs/erofs/decompressor.c      | 132 +++++++++++++++++++--------------
 fs/erofs/decompressor_lzma.c |  19 ++---
 fs/erofs/erofs_fs.h          |  10 ++-
 fs/erofs/internal.h          |   6 ++
 fs/erofs/super.c             |   3 +
 fs/erofs/sysfs.c             |   2 +
 fs/erofs/zdata.c             | 139 +++++++++++++++++++++++------------
 fs/erofs/zdata.h             |  24 +++++-
 fs/erofs/zmap.c              | 113 ++++++++++++++++++++--------
 10 files changed, 306 insertions(+), 146 deletions(-)

-- 
2.24.4

