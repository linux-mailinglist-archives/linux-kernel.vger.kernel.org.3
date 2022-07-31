Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76C785861AE
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 00:33:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238549AbiGaWdS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jul 2022 18:33:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229710AbiGaWdR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jul 2022 18:33:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 953CEBE2F
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jul 2022 15:33:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C93E061157
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jul 2022 22:33:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03B4DC433D7;
        Sun, 31 Jul 2022 22:33:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659306795;
        bh=U1tYY61xwY2E0whHYnaZvetVSFrW88QG1t3Zk2udQRc=;
        h=Date:From:To:Cc:Subject:From;
        b=j1IvQrAmoEQ3reaLdmgeCCaNnI+9eawfthZ9rmmLQ9EXn3h390yA0aai5oIZkr6UV
         9qRo9Wgxefgmt/I8iRVE1WLnmyEKf7ZoVRjvbYGABf4wMHxhTzuijhrZq2X7DVn1CY
         rwyfzPfptMe2C2C9IzITbhor9nXxYTGZotOoQOv7JIk8QSSfMZ7qkxsXsiv3beHmkl
         pTTc5e6DXaFdEUNzaJkpl6rSJ2/FpYzJMMH8UifehTa5L5sl0/fPJSIbma0ps1GrpX
         4eVn3rukXIIV1IIzXFTXeso1LXSh7NDm1yzytLvfTQD9gR5z86B3uAWKaHnNMIzRCO
         JhPHQnhGbHNZw==
Date:   Mon, 1 Aug 2022 06:33:08 +0800
From:   Gao Xiang <xiang@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>,
        Chao Yu <chao@kernel.org>, Yue Hu <huyue2@yulong.com>,
        Jeffle Xu <jefflexu@linux.alibaba.com>
Subject: [GIT PULL] erofs updates for 5.20-rc1
Message-ID: <YucDJOcnlB7EOD8g@debian>
Mail-Followup-To: Linus Torvalds <torvalds@linux-foundation.org>,
        linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>,
        Chao Yu <chao@kernel.org>, Yue Hu <huyue2@yulong.com>,
        Jeffle Xu <jefflexu@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Could you consider this pull request for 5.20-rc1?

First of all, we'd like to add Yue Hu and Jeffle Xu as two new
reviewers.  Thank them for spending time working on EROFS!

There is no major feature outstanding in this cycle, mainly a patchset
I worked on to prepare for rolling hash deduplication and folios for
compressed data as the next big features.  It kills the unneeded
PG_error flag dependency as well.

Apart from that, there are bugfixes and cleanups as always. Details are
listed below.

All commits have been in -next for a while and no potential merge
conflict is observed.

Thanks,
Gao Xiang

The following changes since commit 03c765b0e3b4cb5063276b086c76f7a612856a9a:

  Linux 5.19-rc4 (2022-06-26 14:22:10 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-5.20-rc1

for you to fetch changes up to ecce9212d0fd7a2d4a4998f0c4623a66887e14c8:

  erofs: update ctx->pos for every emitted dirent (2022-07-31 22:26:29 +0800)

----------------------------------------------------------------
Changes since last update:

 - Add Yue Hu and Jeffle Xu as reviewers;

 - Add the missing wake_up when updating lzma streams;

 - Avoid consecutive detection for Highmem memory;

 - Prepare for multi-reference pclusters and get rid of PG_error;

 - Fix ctx->pos update for NFS export;

 - minor cleanups.

----------------------------------------------------------------
Gao Xiang (19):
      erofs: avoid consecutive detection for Highmem memory
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
      erofs: get rid of erofs_prepare_dio() helper
      erofs: get rid of the leftover PAGE_SIZE in dir.c

Hongnan Li (1):
      erofs: update ctx->pos for every emitted dirent

Jeffle Xu (1):
      MAINTAINERS: erofs: add myself as reviewer

Yue Hu (1):
      MAINTAINERS: erofs: add myself as reviewer

Yuwen Chen (1):
      erofs: wake up all waiters after z_erofs_lzma_head ready

 MAINTAINERS                  |   2 +
 fs/erofs/compress.h          |   2 +-
 fs/erofs/data.c              |  39 +--
 fs/erofs/decompressor.c      |  18 +-
 fs/erofs/decompressor_lzma.c |   1 +
 fs/erofs/dir.c               |  20 +-
 fs/erofs/zdata.c             | 797 ++++++++++++++++++++++++-------------------
 fs/erofs/zdata.h             | 119 +++----
 fs/erofs/zpvec.h             | 159 ---------
 9 files changed, 533 insertions(+), 624 deletions(-)
 delete mode 100644 fs/erofs/zpvec.h
