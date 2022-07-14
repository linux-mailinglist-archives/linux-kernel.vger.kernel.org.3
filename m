Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2ECDC574EE6
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 15:21:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239711AbiGNNVN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 09:21:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239662AbiGNNVC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 09:21:02 -0400
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C4A15E318
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 06:21:00 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0VJJkPA3_1657804852;
Received: from e18g06460.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VJJkPA3_1657804852)
          by smtp.aliyun-inc.com;
          Thu, 14 Jul 2022 21:20:58 +0800
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
To:     linux-erofs@lists.ozlabs.org, Chao Yu <chao@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH 00/16] erofs: prepare for folios, duplication and kill PG_error
Date:   Thu, 14 Jul 2022 21:20:35 +0800
Message-Id: <20220714132051.46012-1-hsiangkao@linux.alibaba.com>
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

Hi folks,

I've been doing this for almost 2 months, the main point of this is
to support large folios and rolling hash duplication for compressed
data.

This patchset is as a start of this work targeting for the next 5.20,
it introduces a flexable range representation for (de)compressed buffers
instead of too relying on page(s) directly themselves, so large folios
can laterly base on this work.  Also, this patchset gets rid of all
PG_error flags in the decompression code. It's a cleanup as a result
as well.

In addition, this patchset kicks off rolling hash duplication for
compressed data by introducing fully-referenced multi-reference
pclusters first instead of reporting fs corruption if one pcluster
is introduced by several differnt extents.  The full implementation
is expected to be finished in the merge window after the next.  One
of my colleagues is actively working on the userspace part of this
feature.

However, it's still easy to verify fully-referenced multi-reference
pcluster by constructing some image by hand (see attachment):

Dataset: 300M
seq-read (data-duplicated, read_ahead_kb 8192): 1095MiB/s
seq-read (data-duplicated, read_ahead_kb 4096): 771MiB/s
seq-read (data-duplicated, read_ahead_kb 512):  577MiB/s
seq-read (vanilla, read_ahead_kb 8192):         364MiB/s

Finally, this patchset survives ro-fsstress on my side.

Thanks,
Gao Xiang

Gao Xiang (16):
  erofs: get rid of unneeded `inode', `map' and `sb'
  erofs: clean up z_erofs_collector_begin()
  erofs: introduce `z_erofs_parse_out_bvecs()'
  erofs: introduce bufvec to store decompressed buffers
  erofs: drop the old pagevec approach
  erofs: introduce `z_erofs_parse_in_bvecs'
  erofs: switch compressed_pages[] to bufvec
  erofs: rework online page handling
  erofs: get rid of `enum z_erofs_page_type'
  erofs: clean up `enum z_erofs_collectmode'
  erofs: get rid of `z_pagemap_global'
  erofs: introduce struct z_erofs_decompress_backend
  erofs: try to leave (de)compressed_pages on stack if possible
  erofs: introduce z_erofs_do_decompressed_bvec()
  erofs: record the longest decompressed size in this round
  erofs: introduce multi-reference pclusters (fully-referenced)

 fs/erofs/compress.h     |   2 +-
 fs/erofs/decompressor.c |   2 +-
 fs/erofs/zdata.c        | 777 ++++++++++++++++++++++------------------
 fs/erofs/zdata.h        | 119 +++---
 fs/erofs/zpvec.h        | 159 --------
 5 files changed, 490 insertions(+), 569 deletions(-)
 delete mode 100644 fs/erofs/zpvec.h

-- 
