Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99F27488EAB
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 03:33:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238209AbiAJCdV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jan 2022 21:33:21 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:53762 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232540AbiAJCdU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jan 2022 21:33:20 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7569560F78
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 02:33:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20614C36AEB;
        Mon, 10 Jan 2022 02:33:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641781999;
        bh=ZCcLXImgRaqQRtW+LJ+XtzULaBeHfxsWVhfXg2K+vkM=;
        h=Date:From:To:Cc:Subject:From;
        b=umORd6CgiImPOZtD4MXSKwBBM+bo6ZUPDRkLDWKCsOtLzFL23JsXgsERrERqPR2zX
         owAjQekm0HejPGcYBuoWa5qvrK9ketJG1hKnyqMY/XXH50Wg1y+MboxeTdqZks/vCB
         RJ02ogsaNbAjVtyFyxPD4WF1DIiO2A6gkgS0vZhRnxBRNGWvHvZb8XNLVyEWfdr6jP
         zT+RuK9OjG3HvP9JuTLIOSHPvXfagqdmWLM6ruQvn84Uqn/fcygMjtplLR47kPS+BX
         ChgnVeN8msq47PnONlbNZL9WdTDbaziOo79hRjaVJs7tKdrJ/EsH9hHptnbkgaBse/
         uGnPxQYvMqHnQ==
Date:   Mon, 10 Jan 2022 10:33:09 +0800
From:   Gao Xiang <xiang@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, Chao Yu <chao@kernel.org>,
        linux-erofs@lists.ozlabs.org, Liu Bo <bo.liu@linux.alibaba.com>,
        Huang Jianan <huangjianan@oppo.com>,
        Yue Hu <huyue2@yulong.com>, Miao Xie <miaoxie@huawei.com>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        Peng Tao <tao.peng@linux.alibaba.com>
Subject: [GIT PULL] erofs updates for 5.17-rc1
Message-ID: <20220110023303.GA26979@hsiangkao-HP-ZHAN-66-Pro-G1>
Mail-Followup-To: Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, Chao Yu <chao@kernel.org>,
        linux-erofs@lists.ozlabs.org, Liu Bo <bo.liu@linux.alibaba.com>,
        Huang Jianan <huangjianan@oppo.com>, Yue Hu <huyue2@yulong.com>,
        Miao Xie <miaoxie@huawei.com>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        Peng Tao <tao.peng@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Could you consider this pull request for 5.17-rc1?

In this cycle, tail-packing data inline for compressed files is now
supported so that tail pcluster can be stored and read together with
inode metadata in order to save data I/O and storage space.

In addition to that, to prepare for the upcoming subpage, folio and
fscache features, we also introduce meta buffers to get rid of
erofs_get_meta_page() since it was too close to the page itself.

Besides, in order to show supported kernel features and control sync
decompression strategy. new sysfs nodes are introduced in this
cycle as well.

All commits have been in -next and no merge conflicts.

Thanks,
Gao Xiang

The following changes since commit d58071a8a76d779eedab38033ae4c821c30295a5:

  Linux 5.16-rc3 (2021-11-28 14:09:19 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-5.17-rc1

for you to fetch changes up to 09c543798c3cde19aae575a0f76d5fc7c130ff18:

  erofs: use meta buffers for zmap operations (2022-01-04 23:47:36 +0800)

----------------------------------------------------------------
Changes since last update:

 - add sysfs interface and a sysfs node to control sync decompression;

 - add tail-packing inline support for compressed files;

 - get rid of erofs_get_meta_page().

----------------------------------------------------------------
Gao Xiang (10):
      erofs: Replace zero-length array with flexible-array member
      erofs: clean up erofs_map_blocks tracepoints
      erofs: tidy up z_erofs_lz4_decompress
      erofs: introduce z_erofs_fixup_insize
      erofs: support unaligned data decompression
      erofs: introduce meta buffer operations
      erofs: use meta buffers for inode operations
      erofs: use meta buffers for super operations
      erofs: use meta buffers for xattr operations
      erofs: use meta buffers for zmap operations

Huang Jianan (3):
      erofs: rename lz4_0pading to zero_padding
      erofs: add sysfs interface
      erofs: add sysfs node to control sync decompression strategy

Yue Hu (2):
      erofs: support inline data decompression
      erofs: add on-disk compressed tail-packing inline support

 Documentation/ABI/testing/sysfs-fs-erofs |  16 ++
 Documentation/filesystems/erofs.rst      |   8 +
 fs/erofs/Makefile                        |   2 +-
 fs/erofs/compress.h                      |   4 +-
 fs/erofs/data.c                          | 138 +++++++++++------
 fs/erofs/decompressor.c                  | 134 +++++++++-------
 fs/erofs/decompressor_lzma.c             |  19 +--
 fs/erofs/erofs_fs.h                      |  18 ++-
 fs/erofs/inode.c                         |  68 ++++----
 fs/erofs/internal.h                      |  52 ++++++-
 fs/erofs/super.c                         | 121 ++++++---------
 fs/erofs/sysfs.c                         | 256 +++++++++++++++++++++++++++++++
 fs/erofs/xattr.c                         | 135 +++++-----------
 fs/erofs/xattr.h                         |   1 -
 fs/erofs/zdata.c                         | 170 ++++++++++++++------
 fs/erofs/zdata.h                         |  24 ++-
 fs/erofs/zmap.c                          | 159 +++++++++++--------
 include/trace/events/erofs.h             |   4 +-
 18 files changed, 870 insertions(+), 459 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-fs-erofs
 create mode 100644 fs/erofs/sysfs.c
